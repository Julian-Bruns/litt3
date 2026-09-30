#!/usr/bin/env sage-python
"""Explicit Cech--Koszul transgression of the 175-entry octic class.

Sparse Laurent cochains in c; coefficients are homogeneous b-polynomials.
Every Cech primitive and final global polynomial is checked exactly.
"""
import argparse
import itertools
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, lcm, gcd

ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
ap.add_argument('--kernel',type=Path,required=True);ap.add_argument('--map',type=Path)
ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[2])
start=time.monotonic();data=json.loads(args.tensor.read_text());kd=json.loads(args.kernel.read_text())
R=PolynomialRing(GF(5),'a');a=R.gen();F=R.fraction_field()
if kd['specialization']=='cubic':
    k=GF(125,'alpha',modulus=[1,1,0,1]);alpha=k.gen()
    conv=lambda s:F(s.replace('^','**')).numerator()(alpha)/F(s.replace('^','**')).denominator()(alpha)
elif kd['specialization']=='four':
    k=GF(5);conv=lambda s:F(s.replace('^','**')).numerator()(k(4))/F(s.replace('^','**')).denominator()(k(4))
else:k=F;conv=lambda s:F(s.replace('^','**'))
assert kd['kernel_dimension']==1
coeff=[k(s) for s in kd['kernel_basis'][0]]
generic=kd['specialization'] is None
if generic:
    source_den=lcm(v.denominator() for v in coeff)
    form_den=R(data['five_test_clearing_denominator'].replace('^','**'))
    B=PolynomialRing(GF(5),names=['b0','b1','b2','b3','a']);b=B.gens()[:4]
    convert=lambda v:B(str(R(v)))
    coeff=[convert(v*source_den) for v in coeff]
    conv=lambda s:convert(F(s.replace('^','**'))*form_den)
    bmon=lambda e:B.monomial(*(tuple(e)+(0,)))
else:
    B=PolynomialRing(k,names=['b0','b1','b2','b3']);b=B.gens()
    bmon=lambda e:B.monomial(*e)
m2=[tuple(w.count(i) for i in range(4)) for w in itertools.combinations_with_replacement(range(4),2)]
forms=[]
for eq in data['five_test_coefficients']:
    forms.append([(e,sum(conv(eq[i][j])*bmon(m2[i]) for i in range(10)))
                  for j,e in enumerate(m2)])

def clean(d):return {key:v for key,v in d.items() if v}
def add(d,key,val):d[key]=d.get(key,B.zero())+val
def koszul(d):
    out={}
    for (I,J,e),value in d.items():
        for pos,i in enumerate(I):
            newI=I[:pos]+I[pos+1:]
            for exponent,f in forms[i]:
                if f:add(out,(newI,J,tuple(x+y for x,y in zip(e,exponent))),(-1)**pos*value*f)
    return clean(out)
def cech(d):
    out={}
    for (I,J,e),value in d.items():
        for i in range(4):
            if i in J:continue
            newJ=tuple(sorted(J+(i,)));pos=newJ.index(i)
            add(out,(I,newJ,e),(-1)**pos*value)
    return clean(out)
def primitive(d):
    out={}
    for (I,J,e),value in d.items():
        candidates=[i for i in range(4) if e[i]>=0]
        if not candidates:continue
        i=candidates[0]
        if i in J:
            pos=J.index(i);newJ=J[:pos]+J[pos+1:]
            assert newJ
            add(out,(I,newJ,e),(-1)**pos*value)
    return clean(out)

source={}
for j,I in enumerate(kd['source_subsets']):
    for h,m in enumerate(kd['source_quartic_monomials']):
        value=coeff[35*j+h]
        if value:source[(tuple(I),(0,1,2,3),tuple(-i-1 for i in m))]=B(value)
sizes=[len(source)]
for step in range(3):
    image=koszul(source);assert not cech(image)
    lifted=primitive(image);assert cech(lifted)==image
    source=lifted;sizes.append(len(source))
    print('Cech primitive',step+1,'terms',len(source),'seconds',time.monotonic()-start,flush=True)
final=koszul(source);assert not cech(final)
assert all(I==() and len(J)==1 and e==(0,0,0,0) for I,J,e in final)
polys=[final[((),(j,),(0,0,0,0))] for j in range(4)]
assert all(p==polys[0] for p in polys);p=polys[0]
assert p and all(sum(e[:4])==8 for e in p.dict())
if generic:
    by_b={}
    for e,v in p.dict().items():by_b[e[:4]]=by_b.get(e[:4],R.zero())+R(v)*a**e[4]
    content=gcd(list(by_b.values()))
    by_b={e:v//content for e,v in by_b.items()}
    unit=next(iter(by_b.values())).leading_coefficient()
    by_b={e:v/unit for e,v in by_b.items()}
    p=sum(convert(v)*bmon(e) for e,v in by_b.items())
    terms=[[list(e),str(v)] for e,v in by_b.items()]
else:
    p/=p.leading_coefficient();terms=[[list(e),str(v)] for e,v in p.dict().items()]
out={'status':'exact_Cech_primitives_and_global_transgression_verified','specialization':kd['specialization'],
     'cochain_term_counts':sizes,'octic':str(p),'octic_terms':terms,
     'seconds':time.monotonic()-start}
if generic:
    out.update(source_clearing_denominator=str(source_den),form_clearing_denominator=str(form_den),
               transgression_content=str(content),coefficient_degree=max(int(v.degree()) for v in by_b.values()))
if args.map:
    assert kd['specialization']=='cubic';md=json.loads(args.map.read_text())
    dec=lambda n:k(n%5)+k(n//5%5)*alpha+k(n//25)*alpha**2
    h=sum(dec(n)*B.monomial(*e) for e,n in md['stable_to_boundary_octic'])
    h/=h.leading_coefficient();out['equals_actual_first_boundary']=bool(p==h);assert p==h
    print('MATCHES ACTUAL FIRST-BOUNDARY OCTIC',flush=True)
args.output.write_text(json.dumps(out,indent=2)+'\n')
print('complete',len(p.dict()),'terms',time.monotonic()-start,flush=True)
