#!/usr/bin/env sage-python
"""Local contact of the actual symmetric incidence curve at the certified point.

This is a local experiment, not a global Frobenius-boundary proof.
"""
import argparse
import itertools
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, PowerSeriesRing, matrix, vector

ap=argparse.ArgumentParser()
ap.add_argument('--certificate',type=Path,required=True)
ap.add_argument('--locus',type=Path,required=True)
ap.add_argument('--map',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--precision',type=int,default=8)
args=ap.parse_args()
assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3])
data=json.loads(args.certificate.read_text())
locus=json.loads(args.locus.read_text())
mapdata=json.loads(args.map.read_text())
k=GF(5**6,'t');U=PolynomialRing(k,'u');u=U.gen()
alpha=(u**3+u+1).roots(multiplicities=False)[0];beta=k(2).sqrt()
dec0=lambda a:k(a%5)+k((a//5)%5)*alpha+k(a//25)*alpha**2
decode=lambda a:dec0(a%125)+dec0(a//125)*beta
encoding={decode(i):i for i in range(15625)}
R=PolynomialRing(k,names=['b0','b1','b2','c0','c1','c2'])
x=R.gens();env={'alpha':alpha,**dict(zip(R.variable_names(),x))}
eq=[R(eval(s.replace('^','**'),{'__builtins__':{}},env)) for s in locus['equations']]
h=sum(dec0(t)*x[0]**e[0]*x[1]**e[1]*x[2]**e[2]
      for e,t in mapdata['stable_to_boundary_octic'])
point=[decode(v) for v in data['b'][:3]+data['c'][:3]]
assert all(not f(*point) for f in eq+[h])
J=matrix(k,[[f.derivative(v)(*point) for v in x] for f in eq])
assert J.rank()==6 and J[:5].rank()==5
free=next(j for j in range(6) if J[:5,[i for i in range(6) if i!=j]].det())
cols=[i for i in range(6) if i!=free]
inv=J[:5,cols].inverse()
prec=args.precision;S=PowerSeriesRing(k,'s',default_prec=prec);s=S.gen()
arc=[S(v).add_bigoh(prec) for v in point];arc[free]+=s
for n in range(1,prec):
    error=vector(k,[f(*arc)[n] for f in eq[:5]])
    correction=-inv*error
    for i,value in zip(cols,correction):arc[i]+=value*s**n
assert all(f(*arc).valuation()>=prec for f in eq[:5])
results={}
hc=R(h.subs(dict(zip(x[:3],x[3:]))))
for label,f in [('second_kummer',eq[5]),('first_boundary',h),('second_boundary',hc)]:
    value=f(*arc)
    results[label]={'order':int(value.valuation()) if value else None,
                    'coefficients':[int(encoding[value[n]]) for n in range(prec)]}
out={'status':'local_exact_experiment','precision':prec,'free_coordinate':str(x[free]),
     'curve_jacobian_rank':5,'kummer_cut_jacobian_rank':6,
     'contacts':results,'arc':[[int(encoding[v[n]]) for n in range(prec)] for v in arc]}
Cr=PolynomialRing(k,names=['c0','c1','c2','c3']);cv=Cr.gens()
quadrics=[]
for f in eq[:5]:
    affine=f(*(point[:3]+list(cv[:3])))
    quadrics.append(sum(v*cv[0]**e[0]*cv[1]**e[1]*cv[2]**e[2]*cv[3]**(2-sum(e))
                         for e,v in affine.dict().items()))
mon=[tuple(w.count(i) for i in range(4)) for w in itertools.combinations_with_replacement(range(4),3)]
mac=matrix(k,[[q.monomial_coefficient(Cr.monomial(*e)) for e in mon]
              for quad in quadrics for v in cv for q in [quad*v]])
out['specialized_cubic_matrix_rank']=int(mac.rank())
out['specialized_twist_projective_hilbert_polynomial']=str(Cr.ideal(quadrics).hilbert_polynomial())
args.output.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({key:value for key,value in out.items() if key!='arc'},indent=2))
