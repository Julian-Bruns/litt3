#!/usr/bin/env sage
"""Explore the root-nine common-critical incidence off P*t.

Source reconstruction is accepted input. New elimination retains every
geometric ratio; algebra outside the original open is identified explicitly.
"""
import argparse,json,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--data',required=True);p.add_argument('--output',required=True);p.add_argument('--eliminate',action='store_true');p.add_argument('--shape',action='store_true');p.add_argument('--include-cubic-branches',action='store_true')
args=p.parse_args();out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
F5=GF(5);R0=PolynomialRing(F5,'a');aa=R0.gen()
K=GF(5**8,name='a',modulus=aa**8+aa**6+2*aa**3+4*aa**2+2*aa+2);a=K.gen()
beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  d=c%25;c//=25;z+=(d%5+(d//5)*beta)*a**i
 assert not c
 return z
UQ=PolynomialRing(K,('u','q'));u,q=UQ.gens();R=PolynomialRing(UQ,'x');x=R.gen()
P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
A=R([dec(c) for c in [1,21,14,22,13]])
t,rem=A.quo_rem(dec(13)*(x-a));assert not rem
d=json.loads((Path(args.data)/'scaled_source.json').read_text())
def uq(row):return sum((dec(c)*u**i*q**j for i,j,c in row),UQ.zero())
G=[[R([uq(row) for row in component]) for component in gg] for gg in d['numerators_Gbar']]
L,rem=G[0][0].quo_rem(P);assert not rem and not G[0][1]
D=G[0][2]
(out/'G2_components.txt').write_text('L='+str(L)+'\nD='+str(D)+'\n')
print('DEGREES',[(g.degree(),max((c.degree(u) for c in g),default=-1),max((c.degree(q) for c in g),default=-1)) for g in [L,D]],flush=True)
# Replace G2 by its quotient by z^2 using q*z^3=P.  On P*q!=0
# this is equivalent to G2, and often has a much smaller degree.
B=PolynomialRing(K,('inv','z','x','u','q'),order='degrevlex');iv,z,xx,uu,qq=B.gens()
def flat(f):
 return sum((dec(0)+B(c.subs({u:uu,q:qq}))*xx**i for i,c in enumerate(f)),B.zero())
# Explicit substitution avoids coercion between polynomial towers.
def flat(f):
 return sum((cc*uu**i*qq**j*xx**k for k,co in enumerate(f) for (i,j),cc in co.dict().items()),B.zero())
g2=qq*flat(L)*z+flat(D)
g3=sum((flat(G[1][i])*z**i for i in range(3)),B.zero())
g4=sum((flat(G[2][i])*z**i for i in range(3)),B.zero())
curve=qq*z**3-flat(P)
den=qq*flat(P)*flat(t)*B(sum((cc*uu**i*qq**j for (i,j),cc in uq(d['denominator_uq']).dict().items()),B.zero()))
if args.include_cubic_branches:
 B0=R([dec(c) for c in [8,14,19,2,10,19,3,24,18,16]])
 def exact(f,g):
  a,b=f.quo_rem(g);assert not b;return a
 shifted3=[exact(2*B0*G[0][j]+G[1][j],P) for j in range(3)]
 shifted4=[3*B0**2*G[0][j]+3*B0*G[1][j]+G[2][j] for j in range(3)]
 g3=qq*sum((flat(shifted3[j])*z**j for j in range(3)),B.zero())
 g4=qq*flat(exact(shifted4[1],P))+qq*flat(exact(shifted4[2],P))*z+qq**2*flat(exact(shifted4[0],P**2))*z**2
 den=qq*flat(t)*B(sum((cc*uu**i*qq**j for (i,j),cc in uq(d['denominator_uq']).dict().items()),B.zero()))
 print('ALL_CUBIC_BRANCHES_RETAINED',flush=True)
polys=[g2,g3,g4,curve,iv*den-1]
save(polys,str(out/'incidence.sobj'))
(out/'incidence_summary.json').write_text(json.dumps({'scope':('Common-critical incidence off t, including all cubic branches.' if args.include_cubic_branches else 'Common-critical incidence off P*t.')+' q and original source denominator inverted; no square equations.', 'total_degrees':[int(f.total_degree()) for f in polys],'term_counts':[len(f.dict()) for f in polys]},indent=2)+'\n')
print('INCIDENCE',[(f.total_degree(),len(f.dict())) for f in polys],flush=True)
if args.eliminate:
 st=time.time();I=B.ideal(polys);gb=I.groebner_basis();save(gb,str(out/'groebner.sobj'))
 print('GROEBNER',len(gb),'DIMENSION',I.dimension(),'SECONDS',time.time()-st,flush=True)
 if I.dimension()==0: print('QUOTIENT_LENGTH',I.vector_space_dimension(),flush=True)
if args.shape:
 st=time.time();gb=load(str(out/'groebner.sobj'));I=B.ideal(gb)
 Lex=PolynomialRing(K,('inv','z','x','u','q'),order='lex')
 lex=I.transformed_basis('fglm',other_ring=Lex);save(lex,str(out/'lex_groebner.sobj'))
 print('LEX_LENGTH',len(lex),'SECONDS',time.time()-st,flush=True)
 for f in lex: print('LEX_LEAD',f.lm(),'TERMS',len(f.dict()),flush=True)
 pq=[f for f in lex if all(all(e==0 for e in mon[:-1]) for mon in f.dict())]
 assert len(pq)==1
 Q=PolynomialRing(K,'q');fq=Q([pq[0].coefficient({Lex.gen(4):i}) for i in range(pq[0].degree(Lex.gen(4))+1)])
 ff=fq.factor();save(ff,str(out/'q_factorization.sobj'))
 print('Q_FACTORS',[(f.degree(),e) for f,e in ff],flush=True)
 print('Q_SQUAREFREE',fq.gcd(fq.derivative()).degree()==0,flush=True)
