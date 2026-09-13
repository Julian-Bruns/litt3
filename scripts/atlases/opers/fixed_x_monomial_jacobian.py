#!/usr/bin/env python3
"""Actual fixed-X Jacobian arithmetic from the exact pole-semigroup basis.

The Khuri--Makdisi core is Sage's installed implementation.  Only its
Riemann--Roch spaces and multiplication tensors are supplied directly:
L(n*10O)=<x^i*y^j: j<3,3i+10j<=10n>, y^3=F(x).
No function-field genus/maximal-order computation over a huge field is used.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, VectorSpace, matrix, ZZ, FunctionField
from sage.rings.function_field.khuri_makdisi import KhuriMakdisi_small
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt

FROBENIUS_COEFFICIENTS = [3814697265625,-305175781250,-177001953125,13916015625,
    -1210937500,1451562500,48171875,-58884375,3536250,601875,
    141450,-94215,3083,3716,-124,57,-29,-2,1]


def fixed_polynomial(k,a):
    R=PolynomialRing(k,'x');x=R.gen()
    return (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
        +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+(2*a+1))


class FixedXMonomialJacobian:
    def __init__(self,k,a):
        assert a*a+4*a+2==0
        self.k=k;self.a=a;self.f=fixed_polynomial(k,a)
        self.bases={};self.spaces={};self.indices={}
        for n in range(2,8):
            basis=sorted(((i,j) for j in range(3) for i in range((10*n-10*j)//3+1)),
                         key=lambda ij:3*ij[0]+10*ij[1])
            assert len(basis)==10*n-8
            self.bases[n]=basis;self.indices[n]={b:i for i,b in enumerate(basis)}
            self.spaces[n]=VectorSpace(k,len(basis))
        b3=self.bases[3];idx=self.indices[3]
        self.zero=matrix(k,len(self.bases[2]),len(b3),
            {(i,idx[ij]):k.one() for i,ij in enumerate(self.bases[2])},sparse=False)
        self.km=KhuriMakdisi_small(self.spaces.__getitem__,self.mu,self.zero,10,9)

    def mu(self,n,m,i,j):
        xi,yi=self.bases[n][i];xj,yj=self.bases[m][j]
        xx=xi+xj;yy=yi+yj;v=self.spaces[n+m]([self.k.zero()]*len(self.bases[n+m]))
        if yy<3:v[self.indices[n+m][(xx,yy)]]=1
        else:
            for h,c in enumerate(self.f.list()):
                v[self.indices[n+m][(xx+h,yy-3)]]+=c
        return v

    def point(self,x,y):
        """The actual divisor class [(x,y)-O], represented by D=(x,y)+9O."""
        assert y**3==self.f(x)
        allowed=[i for i,(ii,jj) in enumerate(self.bases[3]) if 3*ii+10*jj<=21]
        ev=matrix(self.k,1,len(allowed),[x**self.bases[3][i][0]*y**self.bases[3][i][1]
                                      for i in allowed])
        kernel=ev.right_kernel_matrix()
        result=matrix(self.k,kernel.nrows(),len(self.bases[3]),
            {(r,i):kernel[r,c] for c,i in enumerate(allowed) for r in range(kernel.nrows())},
            sparse=False)
        assert result.nrows()==12
        return result

    def random_point(self):
        attempts=0
        while True:
            attempts+=1;x=self.k.random_element();v=self.f(x)
            if not v:continue
            try:y=v.nth_root(3)
            except ValueError:continue
            return self.point(x,y),(x,y),attempts

    def frobenius(self,w):
        return matrix(self.k,w.nrows(),w.ncols(),[c**25 for c in w.list()])

    def serialize(self,w):
        return dict(rows=w.nrows(),columns=w.ncols(),coefficients=[list(map(int,c.polynomial().list())) for c in w.list()])

    def audit_against_function_field(self,w,xy):
        k=self.k;a=self.a;K=FunctionField(k,'x');x=K.gen();R=PolynomialRing(K,'Y');Y=R.gen()
        F=K.extension(Y**3-K(self.f),'y');y=F.gen()
        O=F(x).divisor_of_poles().support()[0]
        G=F.jacobian(model='km_small',base_div=10*O.divisor()).group()
        transform=matrix(k,[G._to_L(F(x**i*y**j)) for i,j in self.bases[3]])
        def image(v):return G.element_class(G,v*transform)
        xx,yy=xy;place=F.maximal_order().ideal(x-xx,y-yy).place()
        p=G.point(place.divisor()-O.divisor())
        assert image(w)==p
        assert image(self.zero)==G.zero()
        assert image(self.km.multiple(w,7))==7*p
        assert image(self.km.negate(w))==-p
        return True


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('out',type=Path)
    parser.add_argument('--constant-degree',type=int,default=2)
    parser.add_argument('--seconds',type=int,default=180)
    parser.add_argument('--scalar',type=int,default=100)
    parser.add_argument('--audit-base',action='store_true')
    args=parser.parse_args();args.out.mkdir(exist_ok=False)
    started=time.monotonic();events=[]
    def report(stage,**values):
        row=dict(stage=stage,seconds=time.monotonic()-started,**values);events.append(row)
        print(json.dumps(row),flush=True)
        (args.out/'progress.json').write_text(json.dumps(events,indent=2)+'\n')
    alarm(args.seconds)
    try:
        d=args.constant_degree;assert d%2==0
        k=GF(5**d,'a' if d==2 else 'b',impl='givaro' if d==2 else 'pari_ffelt',
             modulus=PolynomialRing(GF(5),'z')([2,4,1]) if d==2 else 'random')
        a=k.gen() if d==2 else PolynomialRing(k,'z')([2,4,1]).roots(multiplicities=False)[0]
        report('constant_field_ready',constant_degree=d)
        J=FixedXMonomialJacobian(k,a)
        report('actual_monomial_jacobian_ready',dimensions={n:len(b) for n,b in J.bases.items()})
        w,xy,attempts=J.random_point();report('actual_point_ready',attempts=attempts)
        (args.out/'input.json').write_text(json.dumps(dict(field_degree=d,
            modulus=list(map(int,k.modulus().list())),a=list(map(int,a.polynomial().list())),
            xy=[list(map(int,z.polynomial().list())) for z in xy],point=J.serialize(w)),indent=2)+'\n')
        t=time.monotonic();v=J.km.multiple(w,args.scalar)
        report('scalar_completed',scalar=args.scalar,arithmetic_seconds=time.monotonic()-t)
        assert J.km.equal(J.km.add(w,J.km.negate(w)),J.zero)
        assert J.km.equal(J.frobenius(w),J.point(xy[0]**25,xy[1]**25))
        assert J.km.equal(J.frobenius(v),J.km.multiple(J.frobenius(w),args.scalar))
        report('group_and_frobenius_checks_passed')
        if args.audit_base:
            assert d==2;J.audit_against_function_field(w,xy)
            assert J.km.equal(J.km.multiple(w,ZZ(sum(FROBENIUS_COEFFICIENTS))),J.zero)
            report('independent_function_field_and_group_order_checks_passed')
        report('complete',scope='Actual arithmetic, not carrier enumeration or exclusion')
    except AlarmInterrupt:report('time_limit_no_verdict')
    finally:cancel_alarm()


if __name__=='__main__':main()
