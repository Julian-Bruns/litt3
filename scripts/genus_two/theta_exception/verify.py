#!/usr/bin/env python3
"""Exact certificate verification for the rank-two theta counterexample.

Run with Python 3 and NumPy: python verify.py
No floating point, external CAS, network access, or random sampling is used.
All supplied numerical data are in certificate.json.
"""
from pathlib import Path
import argparse
from itertools import combinations, combinations_with_replacement, product
import json
import numpy as np
from geometry import *

HERE = Path(__file__).resolve().parent
H = np.array([[0,0,0,1],[0,0,4,0],[0,1,0,0],[4,0,0,0]], dtype=np.int16)
PSI = [63,81,75,53,6,1]
AP = [[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1]]
TRIPLES = list(combinations_with_replacement(range(10),3))
TRIPLE_INDEX = {t:i for i,t in enumerate(TRIPLES)}


def determinant(A):
    """Determinant over k0, returned in the question's field codes."""
    A = np.array(A,dtype=np.int16,copy=True)
    n,m = A.shape
    if n != m:
        raise ValueError('A square matrix is required.')
    value = 1
    for i in range(n):
        nz = np.flatnonzero(A[i:,i])
        if not len(nz):
            return 0
        j = i+int(nz[0])
        if j != i:
            A[[i,j]]=A[[j,i]]
            value=neg(value)
        pivot = int(A[i,i])
        value = mul(value,pivot)
        A[i] = MUL[A[i],INV[pivot]]
        rows = np.flatnonzero(A[i+1:,i])+i+1
        A[rows] = SUB[A[rows],MUL[A[rows,i,None],A[i,None,:]]]
    return value


def translation_equations(Ds, torsion):
    """Linear equations for L z(D) proportional to z(D+torsion)."""
    equations=[]
    for D in Ds:
        v=z_from_k(kummer(D))
        w=z_from_k(kummer(jac_add(D,torsion)))
        for a,b in combinations(range(4),2):
            row=np.zeros((4,4),dtype=np.int16)
            for i in range(4):
                row[a,i]=mul(w[b],v[i])
                row[b,i]=neg(mul(w[a],v[i]))
            equations.append(row.ravel())
    return np.array(equations,dtype=np.int16)


def square_bilinear(B):
    """Coefficients of (a^t B b)^2 in m_i(a)m_j(b)."""
    ans=np.zeros((10,10),dtype=np.int16)
    index={m:i for i,m in enumerate(MON2)}
    for i,j,k,l in product(range(4),repeat=4):
        x=index[tuple(sorted((i,k)))]
        y=index[tuple(sorted((j,l)))]
        ans[x,y]=add(ans[x,y],mul(B[i,j],B[k,l]))
    assert np.array_equal(ans,ans.T)
    return ans


def calibration_matrix(Ls,nodes):
    """880 equations, 220 symmetric tensor entries and 16 node scalars."""
    equations=[]
    for n,(L,p) in enumerate(zip(Ls,nodes)):
        sq=square_bilinear(matmul(H,L))
        vp=v2(p)
        for i,j in combinations_with_replacement(range(10),2):
            row=[0]*236
            for l in range(10):
                row[TRIPLE_INDEX[tuple(sorted((i,j,l)))]]=vp[l]
            row[220+n]=neg(int(sq[i,j]))
            equations.append(row)
    return np.array(equations,dtype=np.int16)


def tensor_from_entries(entries):
    T=np.zeros((10,10,10),dtype=np.int16)
    for i,j,k,c in entries:
        assert i <= j <= k and 0 <= c < 125
        for v in set(__import__('itertools').permutations((i,j,k))):
            T[v]=c
    return T


# k1 = k0[beta]/(beta^2-2); packed integer a+125*b means [a]+[b]*beta.
def a2(a,b): return add(a%125,b%125)+125*add(a//125,b//125)
def n2(a): return neg(a%125)+125*neg(a//125)
def s2(a,b): return a2(a,n2(b))
def m2(a,b):
    x,y=a%125,a//125
    u,v=b%125,b//125
    return add(mul(x,u),mul(2,mul(y,v)))+125*add(mul(x,v),mul(y,u))
def i2(a):
    x,y=a%125,a//125
    z=inv(sub(mul(x,x),mul(2,mul(y,y))))
    return mul(x,z)+125*neg(mul(y,z))
def d2(a,b): return m2(a,i2(b))
def pow2(a,n):
    if n<0:
        return pow2(i2(a),-n)
    value=1
    while n:
        if n&1: value=m2(value,a)
        a=m2(a,a)
        n//=2
    return value

def trim2(a):
    a=list(map(int,a))
    while a and a[-1]==0: a.pop()
    return a

def padd2(a,b):
    out=[0]*max(len(a),len(b))
    for i,x in enumerate(a):out[i]=x
    for i,x in enumerate(b):out[i]=a2(out[i],x)
    return trim2(out)

def pmul2(a,b):
    if not a or not b:return []
    out=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):out[i+j]=a2(out[i+j],m2(x,y))
    return trim2(out)

def pdivrem2(a,b):
    a,b=trim2(a),trim2(b)
    if not b:raise ZeroDivisionError
    out=[0]*max(0,len(a)-len(b)+1)
    while len(a)>=len(b):
        j=len(a)-len(b)
        value=d2(a[-1],b[-1])
        out[j]=value
        for i,x in enumerate(b):a[i+j]=s2(a[i+j],m2(value,x))
        a=trim2(a)
    return trim2(out),a

def G2(z):
    ans=0
    for ex,coef in Gterms.items():
        value=coef
        for x,n in zip(z,ex):value=m2(value,pow2(x,n))
        ans=a2(ans,value)
    return ans

def v22(z):return [m2(z[i],z[j]) for i,j in MON2]

def mumford_kummer2(U,V):
    """Generic Kummer formula; the discriminant is checked nonzero."""
    p,s=U[0],n2(U[1])
    disc=s2(m2(s,s),m2(4,p))
    assert disc != 0
    v0,v1=V
    yy=a2(a2(m2(v0,v0),m2(m2(v0,v1),s)),m2(m2(v1,v1),p))
    pol=a2(a2(m2(f[1],s),m2(mul(2,f[2]),p)),
           a2(m2(f[3],m2(s,p)),a2(m2(mul(2,f[4]),m2(p,p)),m2(s,m2(p,p)))))
    return [1,s,p,d2(s2(pol,m2(2,yy)),disc)],disc


def simultaneous_equations(T):
    """Coefficient equations after substituting the degree-five point."""
    AZ=np.zeros((5,10),dtype=np.int16)
    for i,(j,k) in enumerate(MON2):
        v=pmod(pmul(AP[j],AP[k]),PSI)
        AZ[:len(v),i]=v
    F=np.zeros((5,10,10),dtype=np.int16)
    for i in range(10):
        F=ADD[F,MUL[AZ[:,i,None,None],T[None,i,:,:]]]
    return AZ,F


def monomial_exponents(degree):
    ans=[]
    for word in combinations_with_replacement(range(4),degree):
        ex=[0]*4
        for j in word:ex[j]+=1
        ans.append(tuple(ex))
    return ans


def multiplication_matrix(v):
    out=np.zeros((5,5),dtype=np.int16)
    for j in range(5):
        w=pmod([0]*j+list(v),PSI)
        out[:len(w),j]=w
    return out


def unstable_macaulay(T):
    """Restriction-of-scalars of the 20 by 20 cubic Macaulay matrix."""
    AZ,F=simultaneous_equations(T)
    qs=np.zeros((5,10,5),dtype=np.int16)
    for r,j,k in product(range(5),range(10),range(10)):
        qs[r,k]=ADD[qs[r,k],MUL[F[r,j,k],AZ[:,j]]]
    m2ex,m3ex=monomial_exponents(2),monomial_exponents(3)
    out=np.zeros((100,100),dtype=np.int16)
    for r in range(5):
        for x in range(4):
            for j,ex in enumerate(m2ex):
                new=list(ex);new[x]+=1
                row=m3ex.index(tuple(new));col=4*r+x
                out[5*row:5*row+5,5*col:5*col+5]=multiplication_matrix(qs[r,j])
    return out


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--data-dir',type=Path,required=True)
    args=parser.parse_args()
    directory=args.data_dir.resolve()
    workspace=Path(__file__).resolve().parents[3]
    if directory.is_relative_to(workspace):
        parser.error('Use a certificate directory outside litt3.')
    data=json.loads((directory/'certificate.json').read_text())
    # Field and curve conventions, including the scalar Frobenius twist.
    assert power(5,3)==neg(add(5,1))
    assert all(power(x,125)==x for x in range(125))
    assert power(2,62)==4  # beta^2-2 is irreducible over k0.
    assert m2(125,125)==2 and pow2(125,125)==n2(125)
    assert f==[0,106,48,107,48,1]
    print('k0, k1 and the equation of C: verified.')

    # Compute all two-torsion points using rational branch divisors.
    branchpts=[None]+[(x,0) for x in BRANCHES]
    tors=[([1],[])]+[
        mumford_from_pts(branchpts[j]) if branchpts[i] is None
        else mumford_from_pts(branchpts[i],branchpts[j])
        for i,j in combinations(range(6),2)]
    assert all(jac_add(t,t)==([1],[]) for t in tors)
    nodes=[normalize(z_from_k(kummer(t))) for t in tors]
    assert len(set(nodes))==16 and all(G(p)==0 for p in nodes)
    assert nodes==[tuple(v) for v in data['nodes']]
    Ds=data['interpolation_divisors']
    for U,V in Ds:
        assert len(U)==3 and U[-1]==1
        assert not pmod(psub(pmul(V,V),f),U)
        assert sub(mul(U[1],U[1]),mul(4,U[0])) != 0
    Ls=np.array(data['translation_matrices'],dtype=np.int16)
    for L,t in zip(Ls,tors):
        eq=translation_equations(Ds,t)
        _,piv=rref(eq)
        assert len(piv)==15 and determinant(L)!=0
        assert not np.any(matmul(eq,L.ravel()[:,None]))
    print('16 projective two-torsion translations: uniquely verified (rank 15 each).')

    # Certify that the symmetric triquadratic is the unique geometrically
    # calibrated tensor, up to its one overall scalar.
    T=tensor_from_entries(data['tensor_nonzero_unordered'])
    eq=calibration_matrix(Ls,nodes)
    assert eq.shape==(880,236)
    sol=np.array([T[v] for v in TRIPLES]+[1]*16,dtype=np.int16)
    assert not np.any(matmul(eq,sol[:,None]))
    rr=data['calibration_minor_rows'];cc=data['calibration_minor_columns']
    assert len(rr)==len(cc)==235 and len(set(rr))==len(set(cc))==235
    minor_det=determinant(eq[np.ix_(rr,cc)])
    assert minor_det==data['calibration_minor_determinant'] and minor_det!=0
    print(f'Triquadratic calibration: rank 235/236, nonzero minor [{minor_det}].')
    print(f'Nonzero unordered tensor entries: {len(data["tensor_nonzero_unordered"])}.')

    # The actual bundle and its actual line twist.
    b,c,U,V,Qc=(data[n] for n in ['b','c','U','V','quadric'])
    cq,cr=pdivrem2(padd2(pmul2(V,V),[n2(x) for x in f]),U)
    assert not cr and cq==data['curve_quotient']
    kap,disc=mumford_kummer2(U,V)
    assert [n2(kap[3]),kap[2],n2(kap[1]),kap[0]]==c
    assert G2(c)==0
    assert G2(b)==data['G_b'] and G2(b)!=0
    assert any(V)  # the reduced Mumford class is not two-torsion.
    print('Actual divisor M: V^2-F^(5)=U*H, with nonzero discriminant.')
    print(f'G(b) = [{G2(b)%125}]+[{G2(b)//125}]*beta; G(c)=0.')

    vb,vc=v22(b),v22(c)
    raw=[]
    for i in range(10):
        value=0
        for j,k in product(range(10),repeat=2):
            value=a2(value,m2(int(T[i,j,k]),m2(vb[j],vc[k])))
        raw.append(value)
    scalar=data['quadric_scalar']
    assert scalar!=0 and raw==[m2(scalar,x) for x in Qc]
    print(f'Actual determinant quadric R(a,b,c) = ([{scalar%125}]+[{scalar//125}]*beta)*Q(a).')

    # All five section tests in one unreduced polynomial identity.
    qpoly=[]
    for coef,(i,j) in zip(Qc,MON2):
        qpoly=padd(qpoly,pscale(pmul(AP[i],AP[j]),coef))
    quotient,rem=pdivrem(qpoly,PSI)
    assert not rem and quotient==data['theta_quotient']
    assert qpoly==pmul(PSI,quotient)
    print(f'Q(A_0(T),A_1(T),A_2(T),1) = psi(T) * {quotient} (ascending codes).')
    QM=np.zeros((4,4),dtype=np.int16)
    for coef,(i,j) in zip(Qc,MON2):
        QM[i,j]=coef if i==j else mul(3,coef)
        QM[j,i]=QM[i,j]
    assert determinant(QM)==119
    print('Q is smooth: determinant of its symmetric matrix is [119].')

    # Additional result: no common theta exception on any first-unstable
    # twist family. This computation is not needed for the concrete example.
    B=unstable_macaulay(T)
    assert determinant(B)==78
    Binv=np.array(data['unstable_macaulay_inverse'],dtype=np.int16)
    assert np.array_equal(matmul(B,Binv),np.eye(100,dtype=np.int16))
    print('First-unstable cubic Macaulay matrix: norm determinant [78], inverse verified.')
    print('All certificates verified. The geometric implications are proved in PROOF.md.')


if __name__=='__main__':
    main()
