#!/usr/bin/env sage-python
"""Reconstruct a Heisenberg frame and follow the returned bundle's Frobenius orbit.

Uses the audited actual genus-two quintic reconstruction. Outputs remain
external. A repeated stable moduli point certifies an isomorphism only
geometrically; an initial tail must not be called a period.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import time
from sage.all import GF, PolynomialRing, matrix, vector, identity_matrix, prod

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / 'scripts/deformations'))
from probe_pointed_kummer import ducrohet_quintics


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--data-dir', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--steps', type=int, default=20000)
    args = ap.parse_args()
    assert not args.output.resolve().is_relative_to(ROOT)
    started = time.monotonic()
    source = args.data_dir/'certificate.json'
    data = json.loads(source.read_text())
    k = GF(5**6, 't')
    U = PolynomialRing(k, 'u'); u = U.gen()
    alpha = (u**3+u+1).roots(multiplicities=False)[0]
    beta = k(2).sqrt()
    dec0 = lambda a: k(a % 5)+k((a//5) % 5)*alpha+k(a//25)*alpha**2
    decode = lambda a: dec0(a % 125)+dec0(a//125)*beta
    encoding = {decode(i):i for i in range(15625)}
    assert len(encoding) == 15625
    enc = lambda a: encoding[k(a)]
    norm = lambda v: tuple(c/next(a for a in v if a) for c in v)
    L = [matrix(k, [[decode(c) for c in row] for row in mat])
         for mat in data['translation_matrices']]
    I = identity_matrix(k,4)

    def commutes(i,j):
        if L[i]*L[j] == L[j]*L[i]:return True
        assert L[i]*L[j] == -L[j]*L[i]
        return False

    ia = 1
    ib = next(j for j in range(2,16) if commutes(ia,j))
    ic = next(j for j in range(1,16) if not commutes(ia,j) and commutes(ib,j))
    id_ = next(j for j in range(1,16) if commutes(ia,j) and
               not commutes(ib,j) and commutes(ic,j))
    ids = [ia,ib,ic,id_]
    ops = []
    for j in ids:
        square=L[j]**2
        assert square == square[0,0]*I
        ops.append(L[j]/square[0,0].sqrt())
        assert ops[-1]**2 == I
    A,B,C,D=ops
    common = (A-I).stack(B-I).right_kernel()
    assert common.dimension()==1
    v=common.basis()[0]
    P=matrix(k,[v,C*v,D*v,C*D*v]).transpose()
    assert P.is_invertible()
    Pinv=P.inverse()
    for op,kind in [(A,0),(B,1),(C,2),(D,3)]:
        expected=matrix(k,4,4)
        for j in range(4):
            if kind<2:expected[j,j]=(-1)**((j>>kind)&1)
            else:expected[j^(1<<(kind-2)),j]=1
        assert Pinv*op*P == expected

    R=PolynomialRing(k,names=['x0','x1','x2','x3']);x=vector(R,R.gens())
    z=vector(R,P*x)
    G=lambda z: ((z[0]*z[2]-z[1]**2)**2
        +z[1]*z[3]*(z[0]**2+decode(107)*z[0]*z[1]+decode(66)*z[0]*z[2]
                    +decode(66)*z[1]**2+decode(107)*z[1]*z[2]+decode(106)*z[2]**2)
        +z[3]**2*(decode(107)*z[0]*z[1]+decode(68)*z[0]*z[2]
                    +decode(14)*z[1]**2+decode(74)*z[1]*z[2])
        +decode(37)*z[1]*z[3]**3+decode(93)*z[3]**4)
    K=R(G(z));lead=K.monomial_coefficient(x[0]**4);assert lead
    K/=lead
    coeff=[K.monomial_coefficient(prod(x))/2]
    coeff += [K.monomial_coefficient(x[0]**2*x[i]**2) for i in range(1,4)]
    a,b,c,d=coeff
    model=sum(v**4 for v in x)+2*a*prod(x)
    model += b*(x[0]**2*x[1]**2+x[2]**2*x[3]**2)
    model += c*(x[0]**2*x[2]**2+x[1]**2*x[3]**2)
    model += d*(x[0]**2*x[3]**2+x[1]**2*x[2]**2)
    assert K==model and a*a-b*b-c*c-d*d+b*c*d+4==0
    assert all(t*t != 4 for t in [b,c,d])
    V=ducrohet_quintics(coeff,R)
    # Re-express absolute pullback as coordinatewise fifth powers of
    # four quintics in the original moduli frame. This also tests the
    # actual first-unstable points, not merely the abstract Kummer type.
    root5=lambda a:a**(5**5)
    Vroot=[R({e:root5(t) for e,t in p.dict().items()}) for p in V]
    original=Pinv*x
    Q= P.apply_map(root5)*vector(R,[p(*original) for p in Vroot])
    factor=next(t for p in Q for t in p.coefficients() if t)
    Q=[R(p/factor) for p in Q]
    assert all(t**125==t for p in Q for t in p.coefficients())
    psi=U([decode(t) for t in [63,81,75,53,6,1]])
    aps=[U([decode(t) for t in row]) for row in
         [[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1]]]
    assert all(U(p(*aps))%psi==0 for p in Q), 'dormant base point mismatch'
    Gpoly=R(G(x)); Gsource=R({e:root5(t) for e,t in Gpoly.dict().items()})
    pull=R(Gsource(*Q))
    factors=list(pull.factor())
    assert sorted((f.total_degree(),int(e)) for f,e in factors)==[(4,1),(8,2)]
    quartic=next(f for f,e in factors if e==1)
    assert quartic/quartic.leading_coefficient()==Gpoly/Gpoly.leading_coefficient()
    residual=next(f for f,e in factors if e==2)
    residual/=residual.leading_coefficient()
    assert all(t**125==t for t in residual.coefficients())
    b0=norm(Pinv*vector(k,[decode(t) for t in data['b']]))
    c0=norm(Pinv*vector(k,[decode(t) for t in data['c']]))
    assert K(*b0)!=0 and K(*c0)==0

    def step(v):
        w=[p(*[a**5 for a in v]) for p in V]
        assert any(w), 'actual Frobenius indeterminacy'
        return norm(w)

    def orbit(v,label):
        seen={}; values=[]; current=v
        for i in range(args.steps+1):
            key=tuple(enc(a) for a in current)
            if key in seen:
                first=seen[key]
                return dict(label=label,tail=first,period=i-first,steps=i,
                            orbit=values,boundary_indices=[j for j,w in enumerate(values)
                              if K(*[decode(a) for a in w])==0])
            seen[key]=i;values.append(list(key))
            current=step(current)
            if i and i%1000==0:print(label,'steps',i,flush=True)
        return dict(label=label,status='no_repeat_within_bound',steps=args.steps,
                    first_values=values[:12],last=list(map(enc,current)))

    out=dict(status='exploratory_actual_map',field_modulus=str(k.modulus()),
             field_generator_alpha=str(alpha),field_generator_beta=str(beta),
             translation_ids=ids,frame=[[enc(c) for c in row] for row in P.rows()],
             hudson_coefficients=list(map(enc,coeff)),
             absolute_quintics_before_fifth_power=[[[list(e),enc(t)] for e,t in p.dict().items()] for p in Q],
             stable_to_boundary_octic=[[list(e),enc(t)] for e,t in residual.dict().items()],
             dormant_basepoint_check=True,kummer_pullback_factorization='G times residual_octic squared',
             source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
             script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
             b_orbit=orbit(b0,'bundle'),c_orbit=orbit(c0,'line_Kummer'))
    out['seconds']=time.monotonic()-started
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k not in ['frame','b_orbit','c_orbit',
                     'absolute_quintics_before_fifth_power','stable_to_boundary_octic']}),flush=True)
    for label in ['b_orbit','c_orbit']:
        print(label,{k:v for k,v in out[label].items() if k not in ['orbit','boundary_indices']},flush=True)
        print(label,'boundary count',len(out[label].get('boundary_indices',[])),flush=True)


if __name__=='__main__':main()
