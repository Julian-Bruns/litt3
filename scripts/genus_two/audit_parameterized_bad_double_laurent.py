#!/usr/bin/env python3
"""Independent finite-field audit in the original infinity coordinate z=u^2/v.

Requires NumPy. Arithmetic in F_125/F_625 and all matrix multiplication are
implemented explicitly, with no native finite-field matrix backend.
The symbolic Laurent-polynomial certificate is in parameterized_bad_double_four_jet.py.
This second implementation instead expands u(z), v(z), and R(z), and uses
the original invariant/anti-invariant affine reduction modules.
"""
import numpy as np
from itertools import product
import time, json, sys

class GF:
    def __init__(self,mod):
        self.mod=mod; self.d=len(mod)-1; self.q=5**self.d
        digs=np.array([[(i//5**j)%5 for j in range(self.d)] for i in range(self.q)],dtype=np.int64)
        weights=5**np.arange(self.d)
        self.add=((digs[:,None,:]+digs[None,:,:])%5)@weights
        self.neg=((-digs)%5)@weights
        self.mul=np.zeros((self.q,self.q),dtype=np.int64)
        for i in range(self.q):
            c=np.zeros((self.q,2*self.d-1),dtype=np.int64)
            for j in range(self.d):
                for k in range(self.d): c[:,j+k]+=digs[i,j]*digs[:,k]
            c%=5
            for j in range(2*self.d-2,self.d-1,-1):
                for k in range(self.d): c[:,j-self.d+k]-=c[:,j]*mod[k]
                c%=5
            self.mul[i,:]=c[:,:self.d]@weights
        self.inv=np.zeros(self.q,dtype=np.int64)
        for i in range(1,self.q):
            hits=np.where(self.mul[i]==1)[0]
            if not len(hits): raise ValueError('not field')
            self.inv[i]=hits[0]
        self.digs=digs
    def a(self,x,y):return int(self.add[x,y])
    def m(self,x,y):return int(self.mul[x,y])
    def n(self,x):return int(self.neg[x])
    def p(self,x,n):
        if n<0:return self.p(int(self.inv[x]),-n)
        y=1
        while n:
            if n&1:y=self.m(y,x)
            x=self.m(x,x);n//=2
        return y
    def fmt(self,x):
        return '+'.join(str(c)+('' if j==0 else '*a' if j==1 else '*a^'+str(j)) for j,c in enumerate(self.digs[x]) if c) or '0'

class Laurent:
    def __init__(self,F,lo=-80,hi=180):
        self.F=F; self.lo=lo; self.hi=hi; self.N=hi-lo+1
    def zero(self):return np.zeros(self.N,dtype=np.int64)
    def mono(self,i,c=1):
        a=self.zero()
        if c and self.lo<=i<=self.hi:a[i-self.lo]=c
        return a
    def add(self,a,b):return self.F.add[a,b]
    def neg(self,a):return self.F.neg[a]
    def sub(self,a,b):return self.F.add[a,self.F.neg[b]]
    def scale(self,a,c):return self.F.mul[c,a]
    def shift(self,a,s):
        b=self.zero()
        if s>=0:
            if s<self.N:b[s:]=a[:self.N-s]
        else:
            if -s<self.N:b[:self.N+s]=a[-s:]
        return b
    def mul(self,a,b):
        ia=np.flatnonzero(a);ib=np.flatnonzero(b)
        if len(ia)>len(ib):a,b=b,a;ia,ib=ib,ia
        c=self.zero()
        for i in ia:
            shift=i+self.lo
            l=max(0,-shift);h=min(self.N,self.N-shift)
            if l<h:
                c[l+shift:h+shift]=self.F.add[c[l+shift:h+shift],self.F.mul[a[i],b[l:h]]]
        return c
    def pow(self,a,n):
        b=self.mono(0)
        for i in range(n):b=self.mul(b,a)
        return b
    def trim(self,a,low=None,high=None):
        a=a.copy()
        if low is not None:a[:max(0,low-self.lo)]=0
        if high is not None:a[max(0,high+1-self.lo):]=0
        return a

class Calc:
    def __init__(self,F,t,order=4,lo=-80,hi=180):
        self.F=F;self.t=t; self.order=order;self.L=L=Laurent(F,lo=lo,hi=hi)
        # U=z^2 u, U^4-e1*z^2 U^3+e2*z^4 U^2-e3*z^6 U+e4*z^8=U^3.
        # X=1/u solves X=z^2*(1-X)(1-2X)(1-3X)(1-tX).
        X=L.mono(2)
        for _ in range(hi//2+5):
            B=L.mono(0)
            for c in [1,2,3,t]:B=L.mul(B,L.sub(L.mono(0),L.scale(X,c)))
            X=L.shift(B,2)
        # inverse of X/z^2 as an ordinary power series, even exponents
        V=L.shift(X,-2); U=L.mono(0)
        # series inverse recursive
        for n in range(2,hi+1,2):
            s=0
            for j in range(2,n+1,2):s=F.a(s,F.m(int(V[j-L.lo]),int(U[n-j-L.lo])))
            U[n-L.lo]=F.n(s)
        self.u=L.shift(U,-2)
        self.v=L.shift(L.mul(self.u,self.u),-1)
        self.R=L.mul(self.u,L.sub(self.u,L.mono(0,3)))
        self.A=L.mono(0)
        for c in [0,1,2,3]:self.A=L.mul(self.A,L.sub(self.u,L.mono(0,c)))
        self.R2=L.mul(self.R,self.R)
        # v/R = 1/z * u/(u-3) = 1/z * (1-3X)^(-1)
        den=L.sub(L.mono(0),L.scale(X,3));dinv=L.mono(0)
        for n in range(2,hi+1,2):
            s=0
            for j in range(2,n+1,2):s=F.a(s,F.m(int(den[j-L.lo]),int(dinv[n-j-L.lo])))
            dinv[n-L.lo]=F.n(s)
        self.vR=L.shift(dinv,-1)
        self.aff=[{},{}]
        up=L.mono(0)
        for j in range((-lo)//2+1):
            if -2*j>=L.lo:
                self.aff[0][-2*j]=up.copy();self.aff[1][-2*j]=up.copy()
            if -5-2*j>=L.lo:self.aff[0][-5-2*j]=L.mul(self.v,up)
            if -1-2*j>=L.lo:self.aff[1][-1-2*j]=L.mul(self.vR,up)
            up=L.mul(up,self.u)
        self.H=[]
        for exp in [-15,-5,5]:self.H.append((L.shift(self.A,exp),L.zero()))
        for exp in [5,10,15]:self.H.append((L.zero(),L.shift(L.mul(self.A,self.R2),exp)))
        self.D=[(L.mono(-15),L.zero()),(L.mono(-5),L.zero()),(L.zero(),L.shift(self.R2,5))]
        self.M0=np.zeros((6,6),dtype=np.int64)
        self.r0=[]
        for j,h in enumerate(self.H):
            p,r=self.split(h,64)
            self.M0[:,j]=p;self.r0.append(r)
    def pa(self,a,b):return tuple(self.L.add(a[i],b[i]) for i in [0,1])
    def pn(self,a):return tuple(self.L.neg(a[i]) for i in [0,1])
    def ps(self,a,c):return tuple(self.L.scale(a[i],c) for i in [0,1])
    def pm(self,a,b):
        L=self.L
        return (L.add(L.mul(a[0],b[0]),L.mul(self.R,L.mul(a[1],b[1]))),L.add(L.mul(a[0],b[1]),L.mul(a[1],b[0])))
    def split(self,h,upper):
        L=self.L;F=self.F;p=[];rem=[]
        for parity in [0,1]:
            r=L.trim(h[parity],high=upper)
            for exp in range(L.lo,1):
                c=int(r[exp-L.lo])
                if c and exp in self.aff[parity]:
                    r=L.sub(r,L.scale(self.aff[parity][exp],c))
            exps=[-3,-1,1] if parity==0 else [1,2,3]
            p.extend(int(r[e-L.lo]) for e in exps)
            rem.append(L.trim(r,low=2 if parity==0 else 4,high=upper))
        return np.array(p,dtype=np.int64),tuple(rem)
    def matrix_jet(self,d,order=None):
        if order is None:order=self.order
        L=self.L;F=self.F
        D=(L.zero(),L.zero())
        for i in range(3):D=self.pa(D,self.ps(self.D[i],d[i]))
        powers=[None,D]
        for n in range(2,order+1):powers.append(self.ps(self.pm(powers[-1],D),int(F.inv[n])))
        matrices=[self.M0.copy()]+[np.zeros((6,6),dtype=np.int64) for n in range(order)]
        for col in range(6):
            rs=[self.r0[col]]
            for n in range(1,order+1):
                h=(L.zero(),L.zero())
                for k in range(1,n+1):h=self.pa(h,self.pm(powers[k],rs[n-k]))
                h=self.pn(h)
                p,r=self.split(h,64-15*n)
                matrices[n][:,col]=p;rs.append(r)
        return matrices
    def scalar_jet(self,d,order=None):
        Ms=self.matrix_jet(d,order)
        return schur(self.F,Ms)

def invmat(F,A):
    n=len(A);M=np.hstack((A.copy(),np.eye(n,dtype=np.int64)))
    for i in range(n):
        p=next(j for j in range(i,n) if M[j,i])
        M[[i,p]]=M[[p,i]]
        M[i]=F.mul[F.inv[M[i,i]],M[i]]
        for j in range(n):
            if j!=i and M[j,i]:M[j]=F.add[M[j],F.neg[F.mul[M[j,i],M[i]]]]
    return M[:,n:]

def mm(F,A,B):
    if B.ndim==1:
        ans=np.zeros(A.shape[0],dtype=np.int64)
        for j in range(A.shape[1]):ans=F.add[ans,F.mul[A[:,j],B[j]]]
        return ans
    ans=np.zeros((A.shape[0],B.shape[1]),dtype=np.int64)
    for j in range(A.shape[1]):ans=F.add[ans,F.mul[A[:,j,None],B[None,j,:]]]
    return ans

def pivot(F,M):
    A=M.copy();rows=list(range(6));cols=[];r=0
    for j in range(6):
        poss=[i for i in range(r,6) if A[i,j]]
        if not poss:continue
        i=poss[0];A[[r,i]]=A[[i,r]];rows[r],rows[i]=rows[i],rows[r]
        A[r]=F.mul[F.inv[A[r,j]],A[r]]
        for i in range(r+1,6):A[i]=F.add[A[i],F.neg[F.mul[A[i,j],A[r]]]]
        cols.append(j);r+=1
    assert r==5,(r,M)
    col=next(j for j in range(6) if j not in cols)
    return rows[:5],cols,rows[5],col

def schur(F,Ms):
    rows,cols,rr,cc=pivot(F,Ms[0]);B0inv=invmat(F,Ms[0][np.ix_(rows,cols)])
    # solve 5 good row equations with exceptional coordinate =1
    vecs=[];out=[]
    for n,M in enumerate(Ms):
        rhs=M[rows,cc].copy()
        for k in range(1,n+1):rhs=F.add[rhs,mm(F,Ms[k][np.ix_(rows,cols)],vecs[n-k])]
        vec=F.neg[mm(F,B0inv,rhs)];vecs.append(vec)
        val=int(M[rr,cc])
        for k in range(n+1):val=F.a(val,int(mm(F,Ms[k][rr,cols][None,:],vecs[n-k])[0]))
        out.append(val)
    return out



def normal_form_rank(q=5):
    """Exact rank of multiplication by UV+W^4 in F5[U,V,W]/(U^q,V^q,W^q)."""
    mons=list(product(range(q),repeat=3));where={m:i for i,m in enumerate(mons)}
    M=np.zeros((q**3,q**3),dtype=np.int64)
    for j,(a,b,c) in enumerate(mons):
        if a+1<q and b+1<q:M[where[(a+1,b+1,c)],j]+=1
        if c+4<q:M[where[(a,b,c+4)],j]+=1
    rank=0
    for j in range(q**3):
        nz=np.flatnonzero(M[rank:,j])
        if not len(nz):continue
        i=rank+int(nz[0]);M[[i,rank]]=M[[rank,i]]
        M[rank]=(M[rank]*pow(int(M[rank,j]),-1,5))%5
        for i in range(rank+1,q**3):
            if M[i,j]:M[i]=(M[i]-M[i,j]*M[rank])%5
        rank+=1
    return rank


def main():
    for name,mod in [("alpha",[1,1,0,1]),("benchmark",[2,4,4,0,1]),
                     ("other_quartic",[3,4,1,4,1])]:
        F=GF(mod);t=5
        if name=="benchmark":t=3*5+3*25+3*125
        C=Calc(F,t)
        D=F.a(F.p(t,5),F.n(t))
        qx=F.m(3,D);qz=F.m(4,F.m(D,F.inv[F.p(F.a(t,1),2)]))
        for direction in [(1,0,0),(0,1,0),(0,0,1),(1,1,0),(1,0,1),(0,1,1)]:
            f=C.scalar_jet(direction,2)
            expected=F.a(F.m(qx,F.p(direction[0],2)),F.m(qz,F.p(direction[2],2)))
            assert f==[0,0,expected],(name,direction,f,expected)
        radial=C.scalar_jet((0,1,0),4)
        assert radial==[0,0,0,0,3]
        # Repeat with strictly larger Laurent precision and pole range.
        C2=Calc(F,t,lo=-96,hi=220)
        assert C2.scalar_jet((0,1,0),4)==radial
        print(name+": quadratic agrees; radical jet 0,0,0,0,3; enlarged-precision check passed")
        if name=="benchmark":
            assert F.a(F.p(t,2),2)==0
            poly=lambda coeff:sum(c*5**i for i,c in enumerate(coeff))
            c1=poly([1,0,1]);c2=poly([0,1,0,1]);c3=poly([4,1,0,3])
            h1=poly([3,4,1,4]);h2=poly([3,4,2,4])
            lam=poly([0,2,0,4]);unit=F.p(F.a(t,1),2)
            # Check the supplied Artin-Schreier classes against the actual curve.
            # For H^1(O), keep only indices 0,1,3 from the tangent projection.
            for aa,bb in [(c1,h1),(c2,h2)]:
                image=C.pa(C.ps(C.D[0],F.p(aa,5)),C.ps(C.D[1],F.p(bb,5)))
                chi=(C.L.add(C.L.mono(-3,aa),C.L.mono(-1,bb)),C.L.zero())
                pp,_=C.split(C.pa(image,C.pn(chi)),64)
                assert not any(pp[i] for i in [0,1,3])
            image=C.ps(C.D[2],F.p(c3,5))
            pp,_=C.split(C.pa(image,C.pn((C.L.zero(),C.L.mono(1,c3)))),64)
            assert not any(pp[i] for i in [0,1,3])
            print("  all three supplied Artin-Schreier classes are Frobenius-fixed")
            a1,a2,a3=[F.p(c,5) for c in [c1,c2,c3]]
            predicted=[F.m(unit,F.m(qx,F.p(a1,2))),
                       F.m(unit,F.m(qx,F.p(a2,2))),
                       F.m(unit,F.m(qz,F.p(a3,2))),
                       F.m(unit,F.m(2,F.m(qx,F.m(a1,a2))))]
            supplied=[poly([1,2,2]),poly([0,3,3,4]),poly([4,1,1,1]),poly([4,1,1,2])]
            assert predicted==supplied
            assert not F.a(a1,F.m(lam,a2))
            beta=F.a(F.p(h1,5),F.m(lam,F.p(h2,5)))
            assert beta==poly([1,3,0,3])
            quartic=F.m(unit,F.m(3,F.p(beta,4)))
            assert quartic==poly([0,3,3])
            print("  supplied four quadratic coefficients matched exactly with coefficient Frobenius")
            print("  unit =",F.fmt(unit),"; radical scale =",F.fmt(beta))
            print("  predicted corrected benchmark quartic =",F.fmt(quartic))
            # Recover BOTH displayed transverse correction coefficients.
            # X=a1*log(1+e1)+a2*log(1+e2).
            # Y=bb1*log(1+e1)+bb2*log(1+e2), where v/u=z^-3+(t+1)z^-1+regular.
            bb2=F.a(F.p(h2,5),F.n(F.m(F.a(F.p(t,5),1),a2)))
            u2=F.m(F.inv[2],F.a(F.p(lam,2),F.n(lam)))
            c130=F.m(2,F.m(t,F.a(F.p(t,4),3)))
            x3=F.n(F.m(F.p(beta,3),F.m(
                F.a(c130,F.m(2,F.m(bb2,F.inv[a2]))),F.inv[F.m(2,qx)])))
            u3=F.a(F.a(F.m(x3,F.inv[a2]),F.m(lam,u2)),
                    F.n(F.m(F.a(F.p(lam,3),F.n(lam)),F.inv[3])))
            assert u2==poly([3,0,2,1])
            assert u3==poly([0,1,0,1])
            print("  transverse correction u2 =",F.fmt(u2),"; u3 =",F.fmt(u3))
    rank=normal_form_rank(5)
    assert rank==82
    print("Independent normal-form multiplication matrix: size 125, rank 82, length 43")
    for q in [5,25,125]:
        count=sum(1 for a in range(4*q) for b in range(4*q)
                  if (a-b)%4==0 and (a<q or b<q))
        assert count==(7*q*q-3)//4
        print("Semigroup length at q=%d: %d"%(q,count))
    print("ALL INDEPENDENT AUDITS PASSED")

if __name__=="__main__":
    main()
