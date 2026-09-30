"""One-endpoint reduction using an order-seven projective Frobenius equation.

This is an exact per-input classifier, not a search over Q or u.  It never
loops over the moment field K: the scalar-norm branch uses P^1(F25), plus
at most fourteen F25-basis vectors for constructive semilinear descent.
"""
from __future__ import annotations
import sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'src'))
sys.path.insert(0,str(Path(__file__).parent))
from exact_fields import *
from newton_endpoints import ROWS,constant,direct_traces,reconstruct_first,compatibility_residuals,grid_residuals
FT=Field(K,[-constant(20),K.zero,K.zero,K.zero,K.one],'F_theta')
ETA=constant(22)

def rho(z):return z.frob(8)
def scalar(z):return FT.from_base(z)
def matmul(A,B):return [[sum((A[i][k]*B[k][j] for k in range(2)),K.zero) for j in range(2)] for i in range(2)]
def matvec(A,v):return [sum((A[i][j]*v[j] for j in range(2)),K.zero) for i in range(2)]
def matdet(A):return A[0][0]*A[1][1]-A[0][1]*A[1][0]
def matinv(A):
    d=matdet(A)
    if not d:raise ZeroDivisionError('Singular matrix')
    di=d.inverse()
    return [[A[1][1]*di,-A[0][1]*di],[-A[1][0]*di,A[0][0]*di]]
def identity():return [[K.one,K.zero],[K.zero,K.one]]
def twist(A,n=1):return [[z.frob(8*n) for z in row] for row in A]
def normalize_point(v):
    if not any(v):raise ValueError('Zero projective vector')
    return (v[0]/v[1],K.one) if v[1] else (K.one,K.zero)
def fixes(M,v):
    w=matvec(M,v);rv=[rho(z) for z in v]
    return rv[0]*w[1]-rv[1]*w[0]==K.zero

def projective_frobenius_solutions(M):
    """Solve det(rho(v), M v)=0, with singular base points retained.

For rank zero the returned 'all_projective_points' flag is true; these
points have zero oriented epsilon_3 and so never survive oriented_y().
"""
    d=matdet(M)
    if not d:
        row=next((r for r in M if any(r)),None)
        if row is None:return {'case':'rank_zero','all_projective_points':True,'points':[]}
        kernel=normalize_point([-row[1],row[0]])
        col=next([M[0][j],M[1][j]] for j in range(2) if M[0][j] or M[1][j])
        preimage=normalize_point([z.frob(6) for z in col])
        pts=list(dict.fromkeys([kernel,preimage]))
        assert all(fixes(M,v) for v in pts)
        return {'case':'rank_one','all_projective_points':False,'points':pts,'kernel':kernel}
    N=identity()
    for i in range(7):N=matmul(twist(M,i),N)
    tr=N[0][0]+N[1][1];det=matdet(N)
    assert rho(tr)==tr and rho(det)==det
    if N[0][1] or N[1][0] or N[0][0]!=N[1][1]:
        eigenvalues=[constant(i) for i in range(25) if constant(i)**2-tr*constant(i)+det==K.zero]
        pts=[]
        for lam in eigenvalues:
            row0=[N[0][0]-lam,N[0][1]]
            row1=[N[1][0],N[1][1]-lam]
            row=row0 if any(row0) else row1
            v=normalize_point([-row[1],row[0]])
            assert matvec(N,v)==[lam*z for z in v]
            assert fixes(M,v)
            pts.append(v)
        return {'case':'invertible_nonscalar_norm','all_projective_points':False,
                'points':pts,'norm':N,'norm_trace':tr,'norm_determinant':det}
    c=N[0][0];assert c and rho(c)==c
    # Norm_{K/F25}(c^{-7})=c^{-49}=c^{-1}, since |F25*|=24.
    b=c**(-7)
    Mp=[[b*z for z in row] for row in M];Mi=matinv(Mp)
    def L(v):return matvec(Mi,[rho(z) for z in v])
    basis=[];tested=0
    for j in range(7):
        for axis in range(2):
            v=[K.zero,K.zero];v[axis]=zeta**j
            accum=[K.zero,K.zero];w=v
            for _ in range(7):
                accum=[accum[k]+w[k] for k in range(2)];w=L(w)
            assert w==v and L(accum)==accum
            tested+=1
            if not any(accum):continue
            if not basis:basis.append(accum)
            elif basis[0][0]*accum[1]-basis[0][1]*accum[0]:basis.append(accum);break
        if len(basis)==2:break
    assert len(basis)==2
    pts=[normalize_point([basis[0][k]*constant(t)+basis[1][k] for k in range(2)]) for t in range(25)]
    pts.append(normalize_point(basis[0]))
    assert len(set(pts))==26 and all(fixes(M,v) for v in pts)
    return {'case':'invertible_scalar_norm','all_projective_points':False,'points':pts,
            'norm':N,'basis_vectors_tested':tested,'descent_basis':basis}

def oriented_y(M):
    """Discard infinity and epsilon_3=a*rho(y)+c=0. Rank-zero gives no points."""
    data=projective_frobenius_solutions(M)
    a=M[1][0];c=-M[0][0]
    ys=[v[0] for v in data['points'] if v[1] and a*rho(v[0])+c]
    if data['case']=='rank_one':assert len(ys)<=1
    if data['case']=='rank_zero':assert not ys
    assert len(ys)<=26
    return ys,data

def sigma(v,power=1):return FT.row([v.c[j]*K(pow(2,j*power,5)) for j in range(4)])
def inv_quartic(v):
    if not v:raise ZeroDivisionError
    adj=sigma(v)*sigma(v,2)*sigma(v,3);norm=v*adj
    assert not any(norm.c[1:]) and norm.c[0]
    ans=adj*scalar(norm.c[0].inverse());assert v*ans==FT.one
    return ans

def normalized_endpoint(labels):
    direct=direct_traces(labels)
    return {name:FT.row([z/ETA for z in row]) for name,row in direct.items()}

def moment_matrix(Q,u):
    B=Q['C'];P=Q['U'];R=Q['V']
    if not P.c[3] or not R.c[1]:raise ValueError('Odd endpoint characters must be nonzero')
    W=inv_quartic(P-scalar(u))
    ell=lambda v:v.c[3]
    a=-ell(W);b=ell(W*B);c=-ell(W*R);d=ell(W*R*B)
    return [[-c,-d],[a,b]],W

def recover_from_y(Q,u,y,W=None):
    M,W=moment_matrix(Q,u) if W is None else (None,W)
    x=u.frob(10);eps=-(Q['V']+scalar(rho(y)))*W
    B=eps*(Q['E']-scalar(x.frob(7)))+scalar(y.frob(7))
    V=FT.row([constant(v)*B.c[j].frob(8) for j,v in enumerate([13,17,7,0])])
    U=scalar(x.frob(11))-eps*(V+scalar(y.frob(1)))
    E=FT.row([(U.c[j]/constant(w)).frob(3) for j,w in enumerate([8,1,17])]+[K.zero])
    eq2=eps*(Q['C']-scalar(y))-E+scalar(x)
    assert eps and not (eps*(Q['U']-scalar(u))+Q['V']+scalar(rho(y)))
    H={'C':B,'E':E,'U':U,'V':V}
    C_raw=[ETA*z for z in B.c];U_raw=[ETA*z for z in U.c]
    first=reconstruct_first(C_raw,U_raw)
    return {'x':x,'y':y,'epsilon':eps,'H':H,'eq2':eq2,
            'H_first':first,'H_Newton_residuals':compatibility_residuals(C_raw,U_raw),
            'H_grid_residuals':grid_residuals(first)}

def scalar_rank_polynomial(Q):
    """Exact affine numerator of det M(u), including the identically-zero case.

If h(u)=Norm_{F/K}(P-u), then h(u)*det(M(u))=s*(u-P0)+t.
D is the nonzero odd endpoint determinant; J identifies the possible
all-u singular regime together with s=0. No nonvanishing of J is assumed.
"""
    B,P,R=Q['C'],Q['U'],Q['V']
    p1,p2,p3=P.c[1:]; b1,b2,b3=B.c[1:];r1,r2=R.c[1:3]
    delta=constant(20)
    D=b3*p1-p3*b1;E=b3*p2-p3*b2
    s=r1*E+r2*D
    t=(E*(r1*p1*p2-r2*p1*p1+delta*r2*p3*p3)
        +D*(r1*p1*p3-r1*p2*p2+r2*p1*p2))/p3
    J=r1*r1*(p1*p3-p2*p2)+r2*r2*(p1*p1-delta*p3*p3)
    return {'s':s,'t':t,'D':D,'E':E,'J':J,'center':P.c[0]}

def norm_quartic(v):
    """Quartic field norm in the compatible theta presentation."""
    n=v*sigma(v)*sigma(v,2)*sigma(v,3)
    assert not any(n.c[1:])
    return n.c[0]
