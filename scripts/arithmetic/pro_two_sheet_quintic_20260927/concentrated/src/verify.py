#!/usr/bin/env python3
"""Reproduce all exact arithmetic used in the nonexistence proof.

Python standard library only. This is not a search over geometric parameters.
The four conjugate labels, fixed polynomial identities, Fourier exponents,
and local symbolic identities are exhaustively checked as stated.
"""
from __future__ import annotations
import argparse
import json
import math
import platform
from pathlib import Path
import ff25 as f
import ff5_8 as e

ROOT=Path(__file__).resolve().parents[1]

def require(condition: bool, message: str) -> None:
    if not condition: raise AssertionError(message)
    print('PASS:',message)

def determinant_mod5(a: list[list[int]]) -> int:
    a=[row[:] for row in a]; n=len(a); det=1
    for j in range(n):
        pivot=next((i for i in range(j,n) if a[i][j]%5),None)
        if pivot is None:return 0
        if pivot!=j:a[j],a[pivot]=a[pivot],a[j];det=-det
        p=a[j][j]%5;det=det*p%5;ip=pow(p,-1,5)
        for i in range(j+1,n):
            factor=a[i][j]*ip%5
            for k in range(j,n):a[i][k]=(a[i][k]-factor*a[j][k])%5
    return det%5

class Jet:
    """F5[a,p,r,t,q]/(t^2,q^2), sparse exact polynomial arithmetic."""
    def __init__(self, terms=None):
        self.terms={m:c%5 for m,c in (terms or {}).items() if c%5 and m[3]<2 and m[4]<2}
    @staticmethod
    def constant(c):return Jet({(0,0,0,0,0):c})
    @staticmethod
    def variable(i):
        p=[0]*5;p[i]=1;return Jet({tuple(p):1})
    @staticmethod
    def lift(x):return x if isinstance(x,Jet) else Jet.constant(x)
    def __add__(self,other):
        other=self.lift(other);r=self.terms.copy()
        for m,c in other.terms.items():r[m]=(r.get(m,0)+c)%5
        return Jet(r)
    __radd__=__add__
    def __neg__(self):return Jet({m:-c for m,c in self.terms.items()})
    def __sub__(self,other):return self+-self.lift(other)
    def __rsub__(self,other):return self.lift(other)+-self
    def __mul__(self,other):
        other=self.lift(other);r={}
        for m,c in self.terms.items():
            for n,d in other.terms.items():
                k=tuple(x+y for x,y in zip(m,n))
                if k[3]<2 and k[4]<2:r[k]=(r.get(k,0)+c*d)%5
        return Jet(r)
    __rmul__=__mul__
    def __pow__(self,n):
        r=Jet.constant(1);x=self
        while n:
            if n&1:r=r*x
            x=x*x;n//=2
        return r

def verify() -> dict:
    inp=json.loads((ROOT/'inputs/exact.json').read_text())
    A,P,Q=inp['A'],inp['P'],inp['Q'];m=inp['A_monic']
    print('Python',platform.python_version())
    print('Verification type: exact identities; no geometric-parameter search.')
    require(f.mul(5,5)==f.add(5,3),'F25 defining relation iota^2=iota+3')
    require(all(f.power(x,25)==x for x in range(25)) and all(f.mul(x,f.inv(x))==1 for x in range(1,25)),
            'F25 Frobenius and all 24 nonzero inverses')
    require(f.pscale(A,f.inv(A[-1]))==m,'A/[13]=[5]+2X+[6]X^2+[7]X^3+X^4')
    x=[0,1];r625=f.psub(f.pmodpower(x,25**2,m),x)
    gg,bezA,bezR=f.pxgcd(m,r625)
    require(gg==[1] and f.padd(f.pmul(bezA,m),f.pmul(bezR,r625))==[1],
            'Bezout certificate gcd(A_monic,X^625-X)=1')
    require(f.pmodpower(x,25**4,m)==x,'X^(25^4)=X modulo A_monic; Rabin degree-four irreducibility test')
    require(f.pgcd(A,f.pder(A))==[1] and f.pgcd(P,f.pder(P))==[1] and f.pgcd(A,P)==[1],
            'A and P squarefree and coprime')
    require(f.pder(Q)==f.pmul(P,f.ppow(A,2)),'Q prime equals P*A^2')
    shifted=f.pscale(f.pshift(A,7),f.inv(A[-1]))
    require(shifted==[4,10,9,0,1],'depressed quartic A(Z+[7])/[13]=Z^4+[9]Z^2+[10]Z+[4]')
    Ap=f.pder(A);App=f.pder(Ap);Pp=f.pder(P)
    inv29=pow(29,-1,5**8-1)
    require(inv29==67349 and math.gcd(29,5**8-1)==1,'29th-root exponent in F_(5^8)')
    rows=[]
    expected_L=[[23,23,17,12],[7,4,23,0],[5,15,2,24],[1,18,18,24]]
    for i in range(4):
        alpha=e.power(e.GEN,25**i);ap=e.evaluate(Ap,alpha);pa=e.evaluate(P,alpha)
        c=e.div(e.mul(e.const(3),e.mul(e.power(ap,3),e.power(pa,2))),e.const(f.power(A[-1],3)))
        b=e.power(c,inv29)
        aa=e.div(e.mul(e.const(A[-1]),e.power(b,4)),ap)
        p=e.div(e.evaluate(Pp,alpha),pa);r=e.div(e.evaluate(App,alpha),ap)
        j=e.sub(p,r);lam=e.mul(aa,j);diff=e.sub(e.power(lam,25),lam)
        require(e.evaluate(A,alpha)==e.ZERO and e.power(b,29)==c,f'label {i}: A(alpha)=0 and b0^29=c_alpha')
        require(list(lam)==expected_L[i] and diff!=e.ZERO,f'label {i}: phase-free Lambda row agrees and Lambda^25 != Lambda')
        rows.append({'label_index':i,'alpha':list(alpha),'c':list(c),'b0':list(b),'a0':list(aa),
                     'p':list(p),'r':list(r),'p_minus_r':list(j),'Lambda0':list(lam),'Lambda0_25_minus_Lambda0':list(diff)})
    require(len({tuple(row['alpha']) for row in rows})==4,'all four distinct A-labels checked (not a parameter search)')
    require(math.gcd(8,14)==2,'finite-field intersection F_(5^8) cap F_(5^14)=F25')
    H=[];j=1
    while j not in H:H.append(j);j=5*j%29
    H2=sorted({2*j%29 for j in H})
    require(len(H)==14 and set(H).isdisjoint(H2) and set(H)|set(H2)==set(range(1,29)),
            'two Frobenius-5 orbits cover all nonzero Fourier indices modulo 29')
    require(pow(5,9,29)==4 and pow(5,10,29)==20 and 6*5%29==1,'Fourier exponents M1=Y^5 and M4=Y^(5^10)')
    exponent=20+19*625+5**8
    require(exponent==402520,'epsilon X^625=bar(Y)^5 yields Y^402520=1')
    gcd1=math.gcd(exponent,5**14-1);gcd2=math.gcd(gcd1,4*(5**10-20))
    require(gcd1==232 and gcd2==116,'exact integer gcds reduce nonzero Y to mu116')
    require((5**10-20)%4==1 and (5**10-20)%29==0,'M0=r in the mu4*mu29 decomposition')
    # Leading implicit equation in q=z-1, modulo q^5.
    Z=[1,1];V=[0,2,0,2,2]
    expr=f.psub(f.ppow(f.padd(V,f.pscale(Z,2)),3),
                f.pscale(f.pmul(f.ppow(Z,29),f.ppow(f.padd(Z,f.pscale(V,4)),3)),3))
    require(f.trim(expr[:5])==[0],'V0=2q+2q^3+2q^4 solves the implicit equation modulo q^5')
    require((3*2**2-3*3*4)%5==1,'implicit-equation derivative with respect to V is a unit')
    J2=f.trim(f.pmul(V,f.pder(V))[:5])
    require(J2==[0,4,0,1],'V0*V0 prime =4q+q^3 modulo q^5')
    funcs=[[1],Z,f.ppow(Z,4),V,J2]
    matrix=[(g+[0]*5)[:5] for g in funcs]
    require(determinant_mod5(matrix)==3,'five local Hasse-jet rows have determinant 3 in F5')
    # First-order mixed identity, with arbitrary formal a,p,r.
    aa,p,r,t,q=[Jet.variable(i) for i in range(5)]
    zz=1+q;L=aa*(p-r);vv=2*q+t*(-L+L*q)
    mixed=(vv+2*zz)**3*(1+2*p*aa*t*zz**4)-3*zz**29*((zz+4*vv)+t*r*aa*zz**4*(4*zz+vv))**3
    require(not mixed.terms,'mixed implicit identity is zero in F5[a,p,r,t,q]/(t^2,q^2)')
    result={
       'status':'all checks passed','python':platform.python_version(),'requirements':'Python standard library only',
       'input_file':'inputs/exact.json','irreducibility':{'X625_minus_X_mod_A':r625,'bezout_A':bezA,'bezout_remainder':bezR},
       'labels':rows,'frobenius_orbit_1':H,'frobenius_orbit_2':H2,
       'integer_exponents':{'relation':exponent,'field_order':5**14-1,'first_gcd':gcd1,'second_gcd':gcd2},
       'V0_coefficients':V,'Euler_second_coefficients':(J2+[0]*5)[:5],'hasse_jet_matrix':matrix,'determinant':3,
       'mixed_identity_residual':0,'bounded_searches':[],
       'scope':'checks fixed arithmetic and symbolic identities only; the all-parameter exclusion is proved in REPORT.md'}
    print('ALL CHECKS PASSED')
    return result

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write',type=Path,help='Write exact certificate JSON to this path')
    parser.add_argument('--compare',type=Path,help='Compare the mathematical certificate fields with an existing JSON')
    args=parser.parse_args()
    data=verify()
    if args.compare:
        old=json.loads(args.compare.read_text());new=data.copy()
        old.pop('python',None);new.pop('python',None)
        require(old==new,'regenerated mathematical certificate equals the archived certificate')
    if args.write:
        args.write.parent.mkdir(parents=True,exist_ok=True)
        args.write.write_text(json.dumps(data,indent=2)+'\n')
        print('WROTE:',args.write)

if __name__=='__main__':main()
