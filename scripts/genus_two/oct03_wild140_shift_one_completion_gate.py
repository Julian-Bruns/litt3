#!/usr/bin/env -S sage -python
"""Fresh exact T=1 Cartier fiber; test the seven completion equations."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(6)
R = PolynomialRing(GF(5), names=('B','S','Z','Q'), order='lex')
B,S,Z,Q = R.gens()
Rw = PolynomialRing(R,'w'); w = Rw.gen(); l = 2*Q
A = w**3+l*w**2+B*w-B*(l-1)+3*l**2+Q
Phi = w**5+Q*w**4+S; bb = w-1
H = (A**3+3*A*Phi*bb**2)*Phi**2
I = R.ideal([R(H[j]) for j in (14,9,4)]+[Z*Q*S-1])
gb = I.groebner_basis()
assert len(gb)==4 and all(gb[j].degree(R.gens()[j])==1 for j in range(3))
Rq = PolynomialRing(GF(5),'q'); q=Rq.gen()
def in_q(p):
    return Rq(str(p).replace('Q','q'))
g = in_q(gb[3])
bexpr = in_q(B-gb[0]); sexpr = in_q(S-gb[1])
results = []
for f, multiplicity in g.factor():
    assert multiplicity==1
    F = GF(5**f.degree(), name='a', modulus=f)
    a = F.gen(); bval=bexpr(a); sval=sexpr(a)
    assert a and sval
    K = PolynomialRing(F,'w'); w=K.gen(); ell=2*a
    AA=w**3+ell*w**2+bval*w-bval*(ell-1)+3*ell**2+a
    pp=w**5+a*w**4+sval; beta=w-1
    NN=AA**2-pp*beta**2
    entry={'field_degree':int(f.degree()),'modulus':str(f),
           'norm_derivative_gcd_degree':int(NN.gcd(NN.derivative()).degree()),
           'AB_gcd_degree':int(AA.gcd(beta).degree())}
    if entry['AB_gcd_degree'] or entry['norm_derivative_gcd_degree']:
        entry['reduced_coprime_slice']=False
        results.append(entry)
        continue
    E=3*AA**2*beta+pp*beta**3
    HH=AA**3+3*AA*pp*beta**2
    Peven=sum((E[j-1]/F(j))*w**j for j in range(1,10) if j%5)
    assert Peven.derivative()==E
    c6=HH[10];c2=HH[6]/F(2);c1=HH[5]-sval*c6-4*a*c2
    c3=HH[2]/(3*sval);c4=(HH[7]-3*c3)/a
    c5=(HH[8]-4*c4)/(2*a);c0=(HH[3]-4*sval*c4)/(2*a)
    Qodd=sum(co*w**j for j,co in enumerate((c0,c1,c2,c3,c4,c5,c6)))
    assert pp*Qodd.derivative()+pp.derivative()*Qodd/F(2)==HH
    C=PolynomialRing(F,names=('K0','K5','K10','mu','V'))
    K0,K5,K10,mu,V=C.gens();Cw=PolynomialRing(C,'w');ww=Cw.gen()
    P0=Cw(Peven);Q0=Cw(Qodd);A0=Cw(AA);B0=Cw(beta);N0=Cw(NN)
    RR=(P0+K0+K5*ww**5+K10*ww**10)*B0-A0*Q0
    remainder=(RR**2*B0**3-mu*N0.derivative()**5)%N0
    J=C.ideal([C(remainder[j]) for j in range(7)]+[V*mu*K10-1])
    GJ=J.groebner_basis()
    entry.update({'reduced_coprime_slice':True,'completion_unit':GJ==[C(1)],
                  'completion_basis_count':len(GJ),'completion_dimension':int(J.dimension())})
    results.append(entry)
signal.alarm(0)
receipt={'scope':'Exact T=1 normalized cubic Cartier fiber ONLY; no generic implication',
         'cartier_basis':[str(p) for p in gb],'results':results}
out=Path('../litt3-computation-data/oct03_wild140_shift_one_completion_gate')
out.mkdir(parents=True,exist_ok=True)
(out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(results))
