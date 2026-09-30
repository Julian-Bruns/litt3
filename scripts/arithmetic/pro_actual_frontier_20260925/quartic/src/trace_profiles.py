"""Construct and check trace-equation profiles, NOT actual simultaneous quotients."""
import json
from pathlib import Path
from finite_fields import Extension

ROOT=Path(__file__).resolve().parents[1]
DATA=json.loads((ROOT/'data/inputs.json').read_text())
F=Extension(DATA['F_modulus'])
ZETA=F.gen
ZPOW=[F.pow(ZETA,j) for j in range(29)]
Q=5**7

def conjugate(x):return F.pow(x,Q)
def norm(x):return F.mul(x,conjugate(x))
def moment(d,j):
    r=F.zero
    for l,c in enumerate(d):r=F.add(r,F.scale(ZPOW[(l*j)%29],c%5))
    return r

def inverse_moments(X,Y,s0):
    """All 29 residues from S2=X, S6=Y and S0=s0, using exact inverse DFT."""
    S=[None]*29;S[0]=F.const(s0%5)
    for start,v in [(2,X),(6,Y)]:
        j=start
        for _ in range(14):
            assert S[j] is None
            S[j]=v;v=F.pow(v,5);j=(5*j)%29
        assert j==start
    assert all(x is not None for x in S)
    d=[]
    for j in range(29):
        r=F.zero
        for k in range(29):r=F.add(r,F.mul(S[k],ZPOW[(-j*k)%29]))
        r=F.scale(r,4) # 29^{-1}=4 in characteristic five.
        assert all(x==0 for x in r[1:]) and 0<=r[0]<5
        d.append(r[0])
    assert moment(d,2)==X and moment(d,6)==Y and sum(d)%5==s0%5
    return d

def family_moments(epsilon):
    """Fixed ends: c=C/a, M/a=-1. Requires epsilon != 0 and Norm(epsilon) != 1."""
    if epsilon==F.zero:raise ValueError('epsilon must be nonzero')
    N=norm(epsilon)
    if N==F.one:raise ValueError('this fixed-end trace locus excludes norm-one scalars')
    h=F.div(F.const(DATA['delta']),F.sub(N,F.one))
    X=F.sub(F.one,F.mul(epsilon,h))
    Y=F.sub(F.neg(F.const(DATA['normalized_c'])),h)
    return X,Y

def trace_check(d,epsilon):
    a=DATA['a'];C=F.const(DATA['C_sum']);M=F.const(DATA['M_sum'])
    Sp={j:moment(d,j) for j in [-6,-2,2,6]}
    left1=F.mul(epsilon,F.add(M,F.scale(Sp[-2],a)))
    right1=F.add(C,F.scale(Sp[-6],a))
    left2=F.add(M,F.scale(Sp[2],a))
    right2=F.mul(epsilon,F.add(C,F.scale(Sp[6],a)))
    assert left1==right1 and left2==right2
    assert right1!=F.zero or F.add(C,F.scale(Sp[6],a))!=F.zero
    return {'moments':{str(j):list(Sp[j]) for j in Sp},
            'first_left':list(left1),'first_right':list(right1),
            'second_left':list(left2),'second_right':list(right2)}

def is_excluded_shape(d):
    """Constant except possibly one entry, with residues modulo 5."""
    return any(sum((x%5)!=c for x in d)<=1 for c in range(5))

def make_record(epsilon,s0):
    X,Y=family_moments(epsilon);d=inverse_moments(X,Y,s0)
    checks=trace_check(d,epsilon)
    assert not is_excluded_shape(d)
    assert 14<=12+sum(d)<=128
    assert all(F.mul(epsilon,ZPOW[(4*j)%29])!=F.one for j in range(29))
    return {'epsilon_F25_zeta_basis':list(epsilon),'S0':s0,'d_0_to_28':d,
            'n':12+sum(d),'norm_epsilon_F25_zeta_basis':list(norm(epsilon)),
            'trace_evidence':checks,
            'scope':'Necessary trace equations and numerical local-fiber rules only; no u,v,r model.'}

def generate_bounded_records():
    records=[]
    # Complete enumeration ONLY of the 18 non-norm-one nonzero scalars in F25.
    for e in range(1,25):
        eps=F.const(e)
        if norm(eps)!=F.one:
            for s0 in range(5):records.append(make_record(eps,s0))
    assert len(records)==90
    # Three explicitly specified scalars outside F25, not an exhaustive search.
    extras=[F.add(ZETA,F.one),F.add(ZETA,F.const(5)),F.add(ZPOW[2],F.const(2))]
    for eps in extras:
        assert any(eps[1:]) and norm(eps)!=F.one
        for s0 in range(5):records.append(make_record(eps,s0))
    assert len(records)==105
    return records

if __name__=='__main__':
    witness=make_record(F.const(2),0)
    records=generate_bounded_records()
    (ROOT/'certificates/degree_42_trace_witness.json').write_text(json.dumps(witness,indent=2)+'\n')
    (ROOT/'certificates/bounded_trace_records.json').write_text(json.dumps(records,indent=2)+'\n')
    print('Wrote degree-42 witness and 105 explicitly bounded trace records.')
    print('The theoretical family count is NOT an executed enumeration:',5*(Q*Q-Q-2))
