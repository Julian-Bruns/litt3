#!/usr/bin/env python3
"""Exact certificate verification for the rank-two theta counterexample.

Run with Python 3 and NumPy: python verify.py --data-dir DIR
No floating point, external CAS, network access, or random sampling is used.
All supplied numerical data are in certificate.json.
"""
from pathlib import Path
import argparse
from itertools import combinations, product
import json
import numpy as np
from geometry import *

HERE = Path(__file__).resolve().parent
H = np.array([[0,0,0,1],[0,0,4,0],[0,1,0,0],[4,0,0,0]], dtype=np.int16)
PSI = [63,81,75,53,6,1]
AP = [[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1]]


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


def ten_node_calibration(T,Ls,nodes):
    """Identify the actual tensor by ten independent node evaluations."""
    evaluation=np.array([v2(p) for p in nodes],dtype=np.int16)
    _,columns=rref(evaluation)
    _,rows=rref(evaluation.T)
    assert len(columns)==len(rows)==10
    assert determinant(evaluation[rows,:])!=0
    chart_rows=np.array([L[3,:] for L in Ls],dtype=np.int16)
    chart_ranks=[len(rref(np.delete(chart_rows,i,axis=0))[1]) for i in range(16)]
    assert chart_ranks==[4]*16
    scalars=[]
    for L,p in zip(Ls,nodes):
        left=matmul(np.array(p,dtype=np.int16)[None,:],H)[0]
        right=matmul(matmul(np.array(nodes[0],dtype=np.int16)[None,:],H),L)[0]
        j=next(j for j,x in enumerate(right) if x)
        ratio=div(int(left[j]),int(right[j]))
        assert np.array_equal(left,MUL[right,ratio])
        scalar=mul(ratio,ratio)
        vp=v2(p)
        value=np.zeros((10,10),dtype=np.int16)
        for l in range(10):
            value=ADD[value,MUL[T[:,:,l],vp[l]]]
        assert np.array_equal(value,MUL[square_bilinear(matmul(H,L)),scalar])
        scalars.append(int(scalar))
    return dict(node_evaluation_rank=10,independent_node_rows=list(map(int,rows)),
                node_minor_determinant=int(determinant(evaluation[rows,:])),
                intrinsic_node_scalars=scalars,chart_cover_ranks=chart_ranks)


def determinant2(A):
    """Exact determinant over k1, in packed field codes."""
    A=[list(map(int,row)) for row in A]
    n=len(A)
    assert all(len(row)==n for row in A)
    value=1
    for i in range(n):
        j=next((j for j in range(i,n) if A[j][i]),None)
        if j is None:
            return 0
        if j!=i:
            A[i],A[j]=A[j],A[i]
            value=n2(value)
        pivot=A[i][i]
        value=m2(value,pivot)
        A[i]=[m2(x,i2(pivot)) for x in A[i]]
        for j in range(i+1,n):
            factor=A[j][i]
            A[j]=[s2(x,m2(factor,y)) for x,y in zip(A[j],A[i])]
    return value


def quadratic_gradient2(z):
    return [[a2(z[j] if i==axis else 0,z[i] if j==axis else 0)
             for i,j in MON2] for axis in range(3)]


def reduced_point_jacobian(T,b,c):
    """Six affine equations and their literal six-variable Jacobian."""
    assert b[3]==c[3]==1
    _,F=simultaneous_equations(T)
    vb,vc=v22(b),v22(c)
    db,dc=quadratic_gradient2(b),quadratic_gradient2(c)
    rows=[]
    for r in range(5):
        value=0
        for j,k in product(range(10),repeat=2):
            value=a2(value,m2(int(F[r,j,k]),m2(vb[j],vc[k])))
        assert value==0
        row=[]
        for axis in range(3):
            value=0
            for j,k in product(range(10),repeat=2):
                value=a2(value,m2(int(F[r,j,k]),m2(db[axis][j],vc[k])))
            row.append(value)
        for axis in range(3):
            value=0
            for j,k in product(range(10),repeat=2):
                value=a2(value,m2(int(F[r,j,k]),m2(vb[j],dc[axis][k])))
            row.append(value)
        rows.append(row)
    assert G2(c)==0
    last=[]
    for axis in range(3):
        value=0
        for ex,coefficient in Gterms.items():
            if not ex[axis]%5:
                continue
            term=m2(coefficient,ex[axis]%5)
            for j,x in enumerate(c):
                term=m2(term,pow2(x,ex[j]-(j==axis)))
            value=a2(value,term)
        last.append(value)
    rows.append([0,0,0]+last)
    value=determinant2(rows)
    assert value!=0
    return dict(jacobian=rows,determinant=value,
                determinant_base_code=value%125,
                determinant_beta_code=value//125)


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

    # The later interpolation lemma replaces the 880-by-236 calibration.
    T=tensor_from_entries(data['tensor_nonzero_unordered'])
    calibration=ten_node_calibration(T,Ls,nodes)
    print(f"Actual triquadratic: node evaluation rank 10; minor [{calibration['node_minor_determinant']}].")
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

    reduced=reduced_point_jacobian(T,b,c)
    print(f"Explicit point is reduced: Jacobian determinant [{reduced['determinant_base_code']}]+[{reduced['determinant_beta_code']}]*beta.")
    print('All point certificates verified. Uniform Frobenius assertions use the family theorem.')


if __name__=='__main__':
    main()
