#!/usr/bin/env python3
"""Recompute the finite algebra certificates, not the geometric existence locus."""
from __future__ import annotations
import itertools
import json
from pathlib import Path
import ff25 as f
from extension import Extension, determinant

ROOT=Path(__file__).resolve().parents[1]

def powmod(a: list[int], n: int, m: list[int]) -> list[int]:
    r=[1]
    while n:
        if n&1:r=f.pdivmod(f.pmul(r,a),m)[1]
        a=f.pdivmod(f.pmul(a,a),m)[1]
        n>>=1
    return r

def bezout_record(a: list[int], b: list[int]) -> dict:
    g,s,t=f.pxgcd(a,b)
    return {'left':a,'right':b,'gcd':g,'s':s,'t':t}

def algebra_certificate() -> dict:
    data=json.loads((ROOT/'data/input.json').read_text())
    A=data['A_ascending'];P=data['P_ascending'];Ap=f.derivative(A)
    E=Extension(A);x=E.elt([0,1]);ap=E.eval(Ap,x);p=E.eval(P,x)
    H=E.div(E.mul(E.elt(3),E.mul(E.pow(p,2),E.pow(ap,3))),
            E.elt(f.power(A[4],3)))
    exponent=pow(29,-1,25**4-1)
    root=E.pow(H,exponent)
    roots=[E.pow(root,25**i) for i in range(4)]
    normal_matrix=[list(row) for row in zip(*roots)]
    invariant=E.div(E.pow(ap,20),E.pow(p,6))
    invariants=[E.pow(invariant,25**i) for i in range(4)]
    modulus7=[1,1,0,0,0,0,0,1]
    Z=Extension(modulus7)
    zeta=Z.pow(Z.elt([5,1]),(25**7-1)//29)
    zetas=[Z.pow(zeta,i) for i in range(29)]
    sums=[{'pair':[i,j],'sum':list(Z.add(zetas[i],zetas[j]))}
          for i in range(29) for j in range(i,29)]
    from math import comb
    center=f.neg(f.mul(A[3],f.inv(f.mul(4,A[4]))))
    depressed=[0]*5
    for i,ai in enumerate(A):
        for j in range(i+1):
            depressed[j]=f.add(depressed[j],f.mul(ai,f.mul(comb(i,j)%5,f.power(center,i-j))))
    ap_center=f.mul(depressed[1],f.inv(f.mul(2,depressed[2])))
    PA2=f.pmul(P,f.pmul(A,A))
    Q=[0]*(len(PA2)+1)
    obstructions=[]
    for i,coefficient in enumerate(PA2):
        if (i+1)%5:
            Q[i+1]=f.mul(coefficient,f.inv((i+1)%5))
        elif coefficient:
            obstructions.append([i,coefficient])
    return {
      'scope':'Exact finite coefficient checks only; not a search for S,u,v.',
      'exact_primitive':{
        'PA2':PA2,'Q':f.trim(Q),
        'integration_obstructions':obstructions,
        'normalization':'Q coefficients in all degrees divisible by 5 are zero',
        'identity':'Qprime=P*A^2'},
      'bezout':{
        'P_squarefree':bezout_record(P,f.derivative(P)),
        'A_squarefree':bezout_record(A,Ap),
        'P_A_coprime':bezout_record(P,A)},
      'degree4_field':{
        'modulus':E.modulus,
        'x_q4_minus_x':f.psub(powmod([0,1],25**4,E.modulus),[0,1]),
        'rabin_gcd':bezout_record(f.psub(powmod([0,1],25**2,E.modulus),[0,1]),E.modulus),
        'H':list(H),'inverse_29_mod_q4_minus_1':exponent,
        'b':list(root),'b_conjugates':[list(a) for a in roots],
        'normal_basis_matrix':normal_matrix,'determinant':determinant(normal_matrix),
        'I':list(invariant),'I_conjugates':[list(a) for a in invariants]},
      'degree7_field':{
        'modulus':modulus7,
        'x_q7_minus_x':f.psub(powmod([0,1],25**7,modulus7),[0,1]),
        'rabin_gcd':bezout_record(f.psub(powmod([0,1],25,modulus7),[0,1]),modulus7),
        'seed':[5,1],'zeta':list(zeta),'zeta_29':list(Z.pow(zeta,29)),
        'zeta_powers':[list(a) for a in zetas],
        'unordered_pair_sums':sums,
        'distinct_pair_sum_count':len({tuple(item['sum']) for item in sums})},
      'A_pair_sums':{
        'translation_center':center,'depressed_row':depressed,
        'possible_three_term_AP_center_depressed':ap_center,
        'A_depressed_at_AP_center':f.evaluate(depressed,ap_center)},
      'leading_set_description':{
        'field':'F_25[alpha,z]/(monic A(alpha), z^7+z+1), degree 28 over F_25',
        'members':'b_i(alpha) * zeta(z)^j, 0<=i<4, 0<=j<29',
        'count':116,
        'normalization_at_t_zero':'v = epsilon * B * t^(-3) + O(t^(-2))',
        'normalization_at_t_infinity':'u = epsilon^(-1) * B * t^3 + O(t^2)',
        'warning':'This bounds only the endpoint leading constants, not coefficients of the entire curve or maps.'}
    }

def compose(p,q): return tuple(p[q[i]] for i in range(4))
def closure(gens):
    G={(0,1,2,3)}
    while True:
        new=G|{compose(g,h) for g in G for h in gens}
        if new==G:return sorted(G)
        G=new

def orbits(p,items):
    unseen=set(items);out=[]
    while unseen:
        a=min(unseen);orb=[];b=a
        while b not in orb:
            orb.append(b);b=p[b]
        unseen-=set(orb);out.append(tuple(sorted(orb)))
    return sorted(out)

def tower_certificate() -> dict:
    r=(1,2,3,0);sigma=compose(r,r);reflection=(0,3,2,1)
    groups={'C4':closure([r]),'V4':closure([sigma,(1,0,3,2)]),
            'D4':closure([r,reflection])}
    blocks=[(0,2),(1,3)];which={a:i for i,b in enumerate(blocks) for a in b}
    records=[]
    for name,G in groups.items():
        for p in G:
            cycles=orbits(p,range(4))
            block_perm=tuple(which[p[b[0]]] for b in blocks)
            block_orbs=orbits(block_perm,range(2))
            fibers=[]
            for cyc in cycles:
                qorb=next(b for b in block_orbs if which[cyc[0]] in b)
                image=tuple(sorted(sigma[a] for a in cyc))
                et=len(cyc);eb=len(qorb)
                fibers.append({'sheets':list(cyc),'e_t':et,'e_lower':eb,'e_upper':et//eb,
                               'sigma_partner_sheets':list(image)})
            decorations=[]
            for exceptional in [False,True]:
                allowed=[]
                for point in fibers:
                    et=point['e_t']
                    opts=[0]
                    if et==1 and not exceptional:opts+=[1]
                    if et==2:opts+=[3]
                    if et==4 and exceptional:opts+=[1]
                    allowed.append(opts)
                for mults in itertools.product(*allowed):
                    if sum(mults)>6:continue
                    decorations.append({'ell_equals_one':exceptional,'multiplicities':list(mults),
                                        'weight':sum(mults)})
            records.append({'group':name,'inertia_generator':list(p),'fibers':fibers,
                            'decorations':decorations})
    return {'scope':'All cyclic-inertia elements in the three degree-four permutation groups; no global cover search.',
            'sigma':list(sigma),'blocks':[list(x) for x in blocks],
            'group_orders':{name:len(G) for name,G in groups.items()},'records':records}

def main():
    target=ROOT/'certificates';target.mkdir(exist_ok=True)
    for name,object_ in [('algebra.json',algebra_certificate()),('local_towers.json',tower_certificate())]:
        (target/name).write_text(json.dumps(object_,indent=2,sort_keys=True)+'\n')
        print('WROTE',str(Path('certificates')/name))
if __name__=='__main__':main()
