#!/usr/bin/env sage
"""Exact prime-field reformulation of the saved b3=0 generic-u reduction.

Avoids the unsupported F125(u) libsingular conversion. Alpha is an
explicit algebraic variable and every converted row is mapped back
exactly before the bounded new Groebner calculation.
"""
import argparse
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--reduced',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(30)
start=time.monotonic()
Pu,F,Q,pivots,solved,reduced=load(args.reduced)
k=Pu.base_ring()
alpha=k.gen()
Fp=GF(5)
Vu=PolynomialRing(Fp,'u')
u=Vu.gen()
F0=Vu.fraction_field()
order=TermOrder('degrevlex',4)+TermOrder('lex',1)
S=PolynomialRing(F0,names=('a0','a1','b0','b4','zalpha'),order=order)
a0,a1,b0,b4,zalpha=S.gens()
def convert_coefficient(c):
    c=F(c)
    denominator=Vu([Fp(z) for z in c.denominator().list()])
    assert Pu(denominator)==c.denominator()
    value=S.zero()
    for i,z in enumerate(c.numerator().list()):
        for j,scalar in enumerate(k(z).polynomial().list()):
            value+=S(Fp(scalar)*F0(u)^i/F0(denominator))*zalpha^j
    return value
def convert_polynomial(p):
    return sum(convert_coefficient(c)*prod(S.gen(i)^j for i,j in enumerate(e))
               for e,c in p.dict().items())
def back_coefficient(c):
    c=F0(c)
    return F(Pu(c.numerator()))/F(Pu(c.denominator()))
def back_polynomial(p):
    return sum(Q(back_coefficient(c)*F(alpha)^e[4])*
               prod(Q.gen(i)^e[i] for i in range(4))
               for e,c in p.dict().items())
converted=[(ch,j,convert_polynomial(p)) for ch,j,p in reduced]
assert all(back_polynomial(q)==p for (ch,j,p),(ch2,j2,q) in zip(reduced,converted))
assert alpha^3+alpha+1==0
algebraic=zalpha^3+zalpha+1
assert back_polynomial(algebraic)==0
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((S,converted,algebraic),str(out/'prime_system.sobj'))
summary={'scope':'b3=0, generic nonzero a2=u; exceptional u values open',
         'threads':1,'coefficient_field':'F5(u)',
         'original_equations':len(reduced),'roundtrip_conversion':'PASS',
         'added_relation':'zalpha^3+zalpha+1=0',
         'status':'exact_prime_reformulation_completed'}
def checkpoint():
    summary['elapsed_seconds']=time.monotonic()-start
    (out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
checkpoint()
I=S.ideal([p for ch,j,p in converted]+[algebraic])
basis=I.groebner_basis(algorithm='libsingular:slimgb')
save(basis,str(out/'groebner.sobj'))
(out/'groebner.txt').write_text('\n'.join(str(p) for p in basis)+'\n')
summary.update({'status':'generic_prime_groebner_completed',
                'unit':list(basis)==[S.one()],
                'basis_length':len(basis),
                'maximum_basis_degree':max(int(p.degree()) for p in basis)})
if list(basis)!=[S.one()]:summary['dimension_over_generic_a2']=int(I.dimension())
checkpoint()
print(json.dumps(summary,default=int))
