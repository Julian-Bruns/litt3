#!/usr/bin/env python3
"""Independent exact replay of the small structural certificates.

This verifier does NOT import structural_field or moment_linearization. It uses
F25-polynomial arithmetic and the older degree-seven-over-K8 field model. No
weighted pole profiles, endpoint multisets, or finite-field elements are searched.
The theoretical cyclotomic and genus arguments have full proofs in REPORT.md;
this checks only their fixed arithmetic and the five small algebra certificates.
"""
from __future__ import annotations
import argparse, json, math, platform
from pathlib import Path
from functools import lru_cache
import ff25 as F
import verify_moments as O
from trace_field import certificate as trace_certificate
ROOT=Path(__file__).resolve().parents[1]
H=[4,4,2,3,3,2,2,1]
F7=[4,22,7,20,21,7,24,1]
A=[1,21,14,22,13]
P=[11,22,18,5,19,20,15,16,9,22,1]
ETA=22

def trim(p):return F.trim(list(p))
def pm(p,q):return F.pdivmod(F.pmul(list(p),list(q)),F7)[1]
def pp(p,n):return O.polynomial_power(list(p),n,F7)
def pa(p,q):return F.padd(list(p),list(q))
def pn(p):return F.pneg(list(p))
def ps(p,q):return F.psub(list(p),list(q))
def pi(p):
    g,s,t=F.xgcd(list(p),F7);assert g==[1]
    r=F.pdivmod(s,F7)[1];assert pm(p,r)==[1];return r

def pad(p):return tuple(list(p)+[0]*(7-len(p)))
THETA=pa([0,1],pp([0,1],28))
THETA_POWERS=[[1]]
for _ in range(7):THETA_POWERS.append(pm(THETA_POWERS[-1],THETA))

@lru_cache(maxsize=None)
def embed7(code):
    assert isinstance(code,int) and 0<=code<5**7
    v=[]
    for i in range(7):
        c=code%5;code//=5
        v=pa(v,F.scale(THETA_POWERS[i],c))
    return tuple(v)

def embed14(pair):return pad(pa(embed7(pair[0]),F.scale(list(embed7(pair[1])),5)))

def embed56(v):
    assert len(v)==8
    coeff=[]
    for i in range(4):coeff.append(embed14(v[2*i:2*i+2]))
    return tuple(O.encode8([coeff[i][j] for i in range(4)]) for j in range(7))

def psum(rows):
    r=[]
    for row in rows:r=pa(r,row)
    return r

def det_nonzero(matrix):
    a=[[list(v) for v in row] for row in matrix];det=[1];n=len(a)
    for j in range(n):
        p=next((i for i in range(j,n) if a[i][j]),None)
        if p is None:return False
        if p!=j:a[j],a[p]=a[p],a[j];det=pn(det)
        det=pm(det,a[j][j]);iv=pi(a[j][j])
        for i in range(j+1,n):
            c=pm(a[i][j],iv)
            a[i]=[ps(x,pm(c,y)) for x,y in zip(a[i],a[j])]
    return bool(det)

def osum(labels,table):
    r=O.ZERO
    for i in labels:r=O.add(r,table[i])
    return r

def constants_check():
    tc=trace_certificate(P,A)
    hc=O.polynomial_power([0,1],5**7,H)
    assert hc==[0,1]
    r=F.psub(O.polynomial_power([0,1],5,H),[0,1])
    g,s,t=F.xgcd(H,r);assert g==[1]
    assert F.padd(F.pmul(s,H),F.pmul(t,r))==[1]
    assert ps(THETA,[22,8,20,21,7,24,1])==[]
    hv=psum(F.scale(p,c) for p,c in zip(THETA_POWERS,H));assert hv==[]
    d=psum(F.scale(p,c) for p,c in zip(THETA_POWERS,[1,2,4,1,3,0,1]))
    z=F.scale(pa(THETA,F.scale(d,F.sub(F.mul(2,5),1))),3)
    assert z==[0,1]
    assert pp(z,29)==[1] and z!=[1]
    assert pp(THETA,5**7)==THETA and pp(d,5**7)==d
    assert math.gcd(8,14)==2 and math.lcm(8,14)==56
    assert pow(5,42,29)==1 and 42%8==2
    assert pow(5,16,29)==25 and 16%8==0
    def eig(row,lam):
        out=[]
        for i in range(4):
            p=O.polynomial_power(row,25**i,A)
            out=F.padd(out,F.scale(p,4*pow(lam,-i,5)%5))
        return out
    cp={str(l):eig(tc['canonical_c'],l) for l in [1,2,3,4]}
    ep={str(l):eig(tc['canonical_e2'],l) for l in [1,2,3,4]}
    assert cp=={'1':[20],'2':[5,17,12,5],'3':[23,8,17,20],'4':[4,12,5,23]}
    assert ep=={'1':[8],'2':[5,17,12,5],'3':[],'4':[18,11,21,10]}
    assert F.scale(cp['4'],12)==ep['4']
    assert F.power(12,2)==11 and F.add(F.add(F.power(11,2),11),1)==0 and 11!=1
    kap=F.mul(5,F.inv(22));assert kap==17
    assert F.add(kap,F.power(kap,5))==2 and F.mul(kap,F.power(kap,5))==3
    rho=F.sub(kap,1);assert F.power(rho,2)==3
    zz=F.scale(cp['4'],F.mul(4,F.inv(ETA)))
    assert zz==[24,8,13,5]
    z2=F.pdivmod(F.pmul(zz,zz),A)[1];assert z2==[7]
    constant=F.add(F.sub(1,F.power(kap,2)),F.mul(F.sub(1,F.power(12,2)),7))
    assert constant==19
    residues=sorted({pow(5,i,29) for i in range(14)})
    assert len(residues)==14 and set([4,5,6,7,22,23,24,25])<=set(residues)
    assert 2 not in residues and pow(5,7,29)==28 and math.gcd(18,29)==1
    assert len({pow(4,i,29) for i in range(14)})==14
    return {'canonical_B':tc['canonical_B'],'canonical_c':tc['canonical_c'],
            'canonical_e2':tc['canonical_e2'],'c_eigenprojections':cp,'e_eigenprojections':ep,
            'lambda':12,'lambda_squared_primitive_cube_root':11,'kappa':kap,'rho_squared':3,
            'reciprocal_Z':zz,'reciprocal_Z_squared':7,'reciprocal_constant':constant,
            'K7_modulus':H,'K7_irreducibility':{'x_5pow7_mod_H':hc,'x_5_minus_x_mod_H':r,'bezout_s':s,'bezout_t':t},
            'theta_in_old_zeta_basis':THETA,'d_in_theta_basis':[1,2,4,1,3,0,1],
            'field_embedding_verified':True,'powers_of_5_mod29':residues,
            'theoretical_short_sum_and_genus_lemmas':'proved in REPORT.md; no computational certificate is needed'}

def check_case(cert,C,E,zp):
    # Independent construction of the determinant, with old field arithmetic.
    q,h=cert['Q'],cert['H'];inve=F.inv(ETA)
    a,b,c,d=[O.scale(v,inve) for v in [osum(q,E),osum(q,C),osum(h,C),osum(h,E)]]
    const=O.sub(O.mul(a,d),O.mul(b,c))
    betabar=F.power(5,5)
    cols=[O.neg(O.add(a,d)),O.neg(O.add(O.scale(a,5),O.scale(d,betabar))),
          O.add(b,c),O.add(O.scale(b,betabar),O.scale(c,5))]
    assert [embed56(v) for v in cert['normalized_endpoint_sums']]==[a,b,c,d]
    assert embed56(cert['constant'])==const
    assert [embed56(v) for v in cert['linear_columns']]==cols
    mat=[[list(embed7(x)) for x in r] for r in cert['matrix']]
    tr=[[list(embed7(x)) for x in r] for r in cert['row_operation_certificate']]
    rr=[[list(embed7(x)) for x in r] for r in cert['rref']]
    assert det_nonzero(tr)
    for i in range(7):
        for j in range(5):assert psum(pm(tr[i][k],mat[k][j]) for k in range(7))==rr[i][j]
    # Check the matrix is the stated seven nonconstant coordinates.
    for i in range(7):
        expected=[list(embed7(v[i+1])) for v in cert['linear_columns']]+[pn(embed7(cert['constant'][i+1]))]
        assert mat[i]==expected
    piv=[]
    for row in rr:
        nz=next((j for j in range(4) if row[j]),None)
        if nz is None:assert not row[4];continue
        assert row[nz]==[1] and nz not in piv;piv.append(nz)
    assert len(piv)==cert['rank']==3
    for r,p in enumerate(piv):assert all(rr[i][p]==([1] if i==r else []) for i in range(7))
    particular=[list(embed7(x)) for x in cert['particular']]
    kernel=[[list(embed7(x)) for x in v] for v in cert['kernel']]
    assert len(kernel)==1
    def vecplus(v,w):return [pa(x,y) for x,y in zip(v,w)]
    def norm(v):return pa(pa(pm(v[0],v[0]),pm(v[0],v[1])),F.scale(pm(v[1],v[1]),2))
    def qeval(v):
        value=pa(embed7(cert['constant'][0]),ps(norm(v[:2]),norm(v[2:])))
        return pa(value,psum(pm(embed7(col[0]),t) for col,t in zip(cert['linear_columns'],v)))
    q0=qeval(particular);qplus=qeval(vecplus(particular,kernel[0]));qminus=qeval(vecplus(particular,[pn(x) for x in kernel[0]]))
    qb=F.scale(ps(qplus,qminus),3);qa=F.scale(ps(pa(qplus,qminus),F.scale(q0,2)),3)
    quad=cert['quadratic'];assert not quad['cross']
    assert q0==list(embed7(quad['constant'])) and qb==list(embed7(quad['linear'][0])) and qa==list(embed7(quad['square'][0]))
    assert qa
    disc=ps(pm(qb,qb),F.scale(pm(qa,q0),4));assert disc==list(embed7(cert['discriminant']))
    legendre=pp(disc,(5**7-1)//2)
    points=cert.get('tested_isolated_points',[])
    if not points:
        assert cert['status']=='quadratic_nonsquare_discriminant' and legendre==[4]
    else:
        assert len(points)==2 and legendre==[1]
        assert len({p['parameters'][0] for p in points})==2
        for p in points:
            parameter=list(embed7(p['parameters'][0]))
            assert pa(pa(pm(qa,pm(parameter,parameter)),pm(qb,parameter)),q0)==[]
            v=vecplus(particular,[pm(parameter,t) for t in kernel[0]])
            assert v==[list(embed7(x)) for x in p['point']]
            x=embed14(p['x_M2']);y=embed14(p['y_M6']);eps=embed56(p['epsilon'])
            xb=tuple(O.polynomial_power(list(x),5**7,F7)+[0]*(7-len(O.polynomial_power(list(x),5**7,F7))))
            yb=pad(pp(y,5**7))
            assert eps!=O.ZERO
            assert O.mul(eps,O.sub(a,xb))==O.sub(c,yb)
            assert O.mul(eps,O.sub(b,y))==O.sub(d,x)
            assert p['valid_nonzero_scale'] and p['scale_unique'] and not p['epsilon_in_K14']
            assert any(v>=25 for v in eps) # not in old K14 subfield
    return {'phase':cert['phase_representative'],'rank':3,
            'quadratic':quad,'discriminant':cert['discriminant'],
            'legendre_symbol':legendre[0],'valid_isolated_points':len(points),
            'row_operations_invertible_and_verified':True}

def verify_decodings(evidence,zp):
    out=[]
    for row in evidence['decoded_points']:
        p=row['point'];x=embed14(p['x_M2']);y=embed14(p['y_M6'])
        mins=[]
        for r,d in enumerate(row['decodings_by_mass_residue']):
            w=d['residue_weights'];assert len(w)==29 and all(0<=v<5 for v in w)
            assert sum(w)%5==r
            assert O.moment(zp,list(enumerate(w)),2)==x
            assert O.moment(zp,list(enumerate(w)),6)==y
            assert d['least_positive_mass']==sum(w) and d['number_of_residue_one_nodes']==w.count(1)
            mins.append(sum(w))
        assert row['minimum_mass']==min(mins)
        out.append({'phase':row['phase_representative'],'point_index':row['point_index'],
                    'least_masses_for_residues_0_to_4':mins,'minimum_mass':min(mins)})
    assert min(row['minimum_mass'] for row in out)==evidence['minimum_sector_mass']==37
    return out

def verify_witness(w,zp,C,E):
    assert w['degree']==49 and w['mass']==37 and w['is_actual_curve'] is False
    weights=w['weights'];assert len(weights)==29 and sum(weights)==37
    assert all(0<=v<=4 for v in weights)
    x=O.moment(zp,list(enumerate(weights)),2);y=O.moment(zp,list(enumerate(weights)),6)
    assert x==embed14(w['x_M2']) and y==embed14(w['y_M6'])
    xm=O.moment(zp,list(enumerate(weights)),-2);ym=O.moment(zp,list(enumerate(weights)),-6)
    cq,eq,ch,eh=osum(w['Q'],C),osum(w['Q'],E),osum(w['H'],C),osum(w['H'],E)
    eps=embed56(w['epsilon'])
    assert O.mul(eps,O.sub(eq,O.scale(xm,ETA)))==O.sub(ch,O.scale(ym,ETA))
    assert O.mul(eps,O.sub(cq,O.scale(y,ETA)))==O.sub(eh,O.scale(x,ETA))
    assert eps!=O.ZERO and any(v>=25 for v in eps)
    assert all(O.mul(eps,zp[4*j%29])!=O.ONE for j in range(29))
    return {'degree':49,'mass':37,'support_size':sum(v!=0 for v in weights),
            'both_moment_equations_exact':True,'epsilon_nonzero_and_not_in_K14':True,
            'all_epsilon_c4_different_from_one':True,'actual_curve_constructed':False}

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--reference',type=Path)
    args=ap.parse_args()
    fixed=constants_check()
    zp,C,E,_=O.setup()
    evidence=json.loads((ROOT/'evidence/structural_sector.json').read_text())
    seen=set()
    for g,orbit in zip(evidence['phase_representatives'],evidence['phase_orbits']):
        assert orbit==sorted({g*pow(25,i,29)%29 for i in range(7)})
        assert not seen.intersection(orbit);seen.update(orbit)
    assert seen==set(range(29))
    checks=[check_case(case,C,E,zp) for case in evidence['cases']]
    dec=verify_decodings(evidence,zp)
    witness=verify_witness(evidence['moment_only_degree49'],zp,C,E)
    # Retained degree-41 witness: the balanced reciprocal norm quadric.
    kap=17;rho=F.sub(kap,1);x=13;y=8
    assert x==F.add(4,F.mul(rho,4)) and y==F.add(1,F.mul(rho,2))
    assert (pow(1-4,2,5)-3*4**2+3*2**2+2)%5==0
    result={'software':{'python':platform.python_version(),'implementation':platform.python_implementation()},
            'scope':'Exact fixed arithmetic and five small linear/quadratic systems; no brute force endpoint or pole-profile search.',
            'fixed_arithmetic':fixed,'independent_linear_quadratic_checks':checks,
            'independent_fourier_reconstruction_checks':dec,'degree49_moment_only_witness':witness,
            'retained_degree41_norm_quadric_check':True,
            'number_of_endpoint_multisets_enumerated':0,'number_of_pole_profiles_enumerated':0,
            'new_complete_degree_exclusions':[],'new_actual_witnesses':[]}
    if args.reference:
        ref=json.loads(args.reference.read_text());ref.pop('software',None)
        r=dict(result);r.pop('software',None);assert r==ref
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: independent old-model field embedding, endpoint eigenspaces, five rank/quadric certificates')
    print('PASS: six isolated moment points and all 30 residue-weight reconstructions')
    print('PASS: degree-49 moment-only datum, including nonzero scale outside K14')
    print('SCOPE: no actual curve constructed; no complete degree newly excluded')
    if args.reference:print('PASS: independent evidence matches reference')
if __name__=='__main__':main()
