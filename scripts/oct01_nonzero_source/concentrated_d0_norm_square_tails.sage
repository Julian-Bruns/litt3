#!/usr/bin/env sage
"""Exact characteristic-five square tails on the reduced critical norm."""
from sage.all import *
import argparse,json,time
from pathlib import Path
from field_descent import descend
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
ap.add_argument('--root',type=int,default=145049);ap.add_argument('--tails',default='71,72,73')
args=ap.parse_args();start=time.time();data=args.work/'data'
source=load(str(data/f'concentrated_d0_critical_norm_{args.root}_symbolic.sobj'))
original=source['reduced_norm_C_hat'].dict();keys=list(original)
if source.get('norm_field_descended'):
    E=source['norm_field'];converted=[original[key] for key in keys];descent=source['norm_descent']
else:E,converted,descent=descend([original[key] for key in keys],source['E'],source['alpha'])
U=PolynomialRing(E,'h');h=U.gen();x,eta=source['R'].gens()
groups=[{} for _ in range(141)]
for (dx,de),c in zip(keys,converted):groups[dx][de]=c
coefficients=[U(group) for group in groups]
content=gcd(coefficients);assert content
coefficients=[f//content for f in coefficients]
reverse=list(reversed(coefficients));maximum=max(map(int,args.tails.split(',')))
print('NORM_COEFFICIENT_DEGREE',max(f.degree() for f in coefficients),'CONTENT_DEGREE',content.degree(),flush=True)
square=[]
for n in range(maximum+1):
    out=U.zero()
    for i in range(n//2+1):
        j=n-i
        if reverse[i] and reverse[j]:out+=(1 if i==j else 2)*reverse[i]*reverse[j]
    square.append(out)
print('TRUNCATED_SQUARE_SECONDS',time.time()-start,flush=True)
cube={}
needed={n-5*i-25*j for n in map(int,args.tails.split(','))
        for j in range(n//25+1) for i in range((n-25*j)//5+1)}
for n in sorted(needed):cube[n]=sum((reverse[i]*square[n-i] for i in range(n+1)),U.zero())
def frobenius(f,power):return U({i*power:c**power for i,c in enumerate(f) if c})
fifth=[frobenius(square[i],5) for i in range(maximum//5+1)]
twentyfifth=[frobenius(square[i],25) for i in range(maximum//25+1)]
tails=[];rows=[];g=U.zero();multipliers=[]
family=json.loads((data/'concentrated_d0_source_family.json').read_text())
record=next(r for r in family['records'] if r['root_K_code']==args.root)
alpha=E.gen();beta=-(alpha**4+2*alpha**3+alpha**2+2*alpha)/(alpha**3+alpha**2+1)
def decode(code):
    n=int(code);out=E.zero()
    assert n<390625
    b=n
    for i in range(4):
        c=b%25;b//=25;out+=(E(c%5)+E(c//5)*beta)*alpha**i
    return out
def ep(f):return U([decode(c) for c in f])
unit=content*ep(record['common_denominator'])*ep(record['v0_numerator'])*ep(record['p4_numerator'])
for n in map(int,args.tails.split(',')):
    tail=U.zero()
    for j in range(n//25+1):
        subtotal=U.zero()
        for i in range((n-25*j)//5+1):subtotal+=cube[n-5*i-25*j]*fifth[i]
        tail+=subtotal*twentyfifth[j]
    tails.append(tail)
    if not g:
        scale=tail.leading_coefficient()**(-1);g=tail*scale;multipliers=[U(scale)]
    else:
        g,left,right=g.xgcd(tail)
        multipliers=[left*v for v in multipliers]+[right]
    assert sum((a*f for a,f in zip(multipliers,tails)),U.zero())==g
    remaining=g;count=0
    while remaining.degree()>0:
        divisor=remaining.gcd(unit)
        if divisor.degree()==0:break
        remaining//=divisor;count+=1
    row={'tail_index':n,'tail_degree':int(tail.degree()),'gcd_degree':int(g.degree()),
         'remaining_gcd_degree':int(remaining.degree()),'unit_power_bound':count}
    rows.append(row);print('TAIL_RESULT',row,'SECONDS',time.time()-start,flush=True)
    if remaining.degree()==0:
        quotient,remainder=(unit**count).quo_rem(g);assert not remainder
        break
report={'source':source,'field_descent':descent,'unit':unit,'norm_content':content,'tails':tails,'tail_indices':[r['tail_index'] for r in rows],
        'gcd':g,'bezout_multipliers':multipliers,'remaining_gcd':remaining,'rows':rows,
        'unit_power_bound':count,'unit_power_quotient':quotient if remaining.degree()==0 else None}
save(report,str(data/f'concentrated_d0_norm_square_tails_{args.root}.sobj'))
(data/f'concentrated_d0_norm_square_tails_{args.root}.json').write_text(json.dumps({'scope':'necessary norm-square obstruction on the entire valid concentrated d0 chart',
    'root':args.root,'rows':rows,'remaining_gcd_degree':int(remaining.degree()),'completed_exclusion':remaining.degree()==0},indent=2)+'\n')
