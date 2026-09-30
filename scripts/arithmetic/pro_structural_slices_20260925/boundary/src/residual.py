"""Fraction-free resultant, exact norm division, and all-boundary parametrization."""
from exact import *
from linear_family import deserialize,serialize,all_constraints,top_coordinates
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
FORMULA=json.loads((ROOT/'data'/'resultant_formula.json').read_text())

# This evaluation uses the 43-term universal polynomial identity in the data file.
def resultant_fast(N,k,v):
    vals=[N[2],N[3],N[4],N[5],CR(Q),(y**10*t**3).scale(k),CR(v)]
    powers=[]
    for j,a in enumerate(vals):
        m=max(e[j] for e,c in FORMULA['terms']);p=[CR(1)]
        for _ in range(m):p.append(p[-1]*a)
        powers.append(p)
    r=CR()
    for e,c in FORMULA['terms']:
        u=CR(c)
        for j,ex in enumerate(e):
            if ex:u=u*powers[j][ex]
        r+=u
    return r

def resultant_recurrence(N,k,v):
    """Independent pseudo-remainder calculation, no 43-term table."""
    n2,n3,n4,n5=N[2:]
    fs={10:CR(v),8:n2,7:n3,6:n4,5:n5+CR(v)*Q,3:n2*Q,2:n3*Q,1:n4*Q,0:n5*Q+(y**10*t**3).scale(k)}
    p2=[CR(1)]
    for _ in range(10):p2.append(p2[-1]*n2)
    s0=fs[0]*p2[9];s1=CR();ell=CR(1);emm=CR()
    for i in range(1,11):
        if i in fs:
            s1+=fs[i]*p2[10-i]*ell;s0+=fs[i]*p2[10-i]*emm
        ell,emm=n3*ell+n2*emm,(n4*ell).scale(3)
    numer=(n2*s0*s0+n3*s0*s1+(n4*s1*s1).scale(2)).scale(4)
    return numer.exact_div(p2[9])

def residual(N,k,v,check_second=False):
    r=resultant_fast(N,k,v)
    if check_second:assert r==resultant_recurrence(N,k,v)
    den=P**40*t**15
    if v.deg:den*=v**3
    nm=r.norm();R=nm//den
    assert R.deg<=144
    return R

def boundary_constants(s):
    # Obtain c = ca*a + cd*d using the complete top map, without assuming the relation.
    C0=s['top_columns']
    rows=[[v[1],v[3],v[2]] for v in C0]
    rr,piv=rref(rows)
    assert piv==[0,1] and len(rr)==2
    ca,cd=rr[0][2],rr[1][2]
    assert all(v[2]==add(mul(ca,v[1]),mul(cd,v[3])) for v in C0)
    assert all(x==0 for x in s['top_origin'])
    return ca,cd

def adapted_basis(s):
    """Linear right-inverse for top coordinates (kappa,a,d,e,f), plus a full two-dimensional kernel."""
    picks=[0,1,3,4,5]
    A0=[[col[i] for col in s['top_columns']] for i in picks]
    rr,piv=rref(A0)
    assert len(piv)==5
    n=7;free=[i for i in range(n) if i not in piv]
    # RREF augmented by identity obtains a right-inverse at the same pivot columns.
    aug=[row+[int(i==j) for j in range(5)] for i,row in enumerate(A0)]
    ra,pa=rref(aug);assert pa==piv
    right=[]
    for j in range(5):
        v=[0]*7
        for row,p in zip(ra,piv):v[p]=row[7+j]
        right.append(v)
    ker=[]
    for f in free:
        v=[0]*7;v[f]=1
        for row,p in zip(ra,piv):v[p]=neg(row[f])
        ker.append(v)
    return right,ker,free

def combine(s,coords):
    N,k,D=deserialize(s['origin'])
    for u,bs in zip(coords,s['basis']):
        if not u:continue
        M,l,E=deserialize(bs)
        N=[p+q.scale(u) for p,q in zip(N,M)]
        k=add(k,mul(l,u));D+=E.scale(u)
    return N,k,D

def boundary_point(s,kappa,a,d,h0=0,h1=0):
    if not (kappa and a and d):raise ValueError('kappa,a,d must be nonzero')
    ca,cd=boundary_constants(s);c=add(mul(ca,a),mul(cd,d));b=mul(epsilon,kappa)
    z=fdiv(mul(2,d),b)
    f=neg(add(fdiv(mul(d,d),b),fdiv(mul(mul(8,kappa),power(z,5)),24)))
    e=neg(add(mul(c,z),fdiv(mul(eta,kappa),mul(24,z))))
    right,ker,_=adapted_basis(s)
    coords=[0]*7
    for val,col in zip([kappa,a,d,e,f,h0,h1],right+ker):
        coords=[add(u,mul(val,w)) for u,w in zip(coords,col)]
    N,k,D=combine(s,coords)
    assert top_coordinates(N,k,D,s['root'])==[kappa,a,c,d,e,f]
    U,V=boundary_uv(N,k,D,s['root'])
    assert U==V==0
    return N,k,D,coords

def boundary_uv(N,k,D2,root=None):
    _,a,c,d,e,f=top_coordinates(N,k,D2,root);b=mul(epsilon,k)
    if not b:raise ValueError('kappa zero')
    z=fdiv(mul(2,d),b)
    U=add(mul(mul(8,k),power(z,5)),mul(24,add(fdiv(mul(d,d),b),f)))
    V=add(mul(eta,k),mul(24,add(mul(c,power(z,2)),mul(e,z))))
    return U,V

if __name__=='__main__':
    import time
    data=json.loads((ROOT/'data'/'linear_spaces.json').read_text());out=[];start=time.monotonic()
    for i,s in enumerate(data['spaces']):
        N,k,D,coords=boundary_point(s,1,1,1)
        v=FP(s['v']);all_constraints(N,k,D,v,s['root'])
        R=residual(N,k,v,check_second=True)
        assert R and R.deg==142
        g=R.gcd(R.derivative());sq=R.geometric_square_root()
        print('root',s['root'],'R degree',R.deg,'gcd(R,Rprime) degree',g.deg,'square?',sq is not None,flush=True)
        out.append({'root':s['root'],'adapted_coordinates':[1,1,1,0,0],'affine_coordinates':coords,'point':serialize(N,k,D),'R0':list(R.c),'gcd_degree':g.deg,'square':sq is not None})
    (ROOT/'data'/'boundary_examples.json').write_text(json.dumps(out,indent=2)+'\n')
    print('All 11 boundary examples checked; both resultant formulas agree. Seconds',round(time.monotonic()-start,3))
