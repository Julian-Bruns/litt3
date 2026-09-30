#!/usr/bin/env python3
"""Independently replay all retained circuit samples with polynomial arithmetic."""
from pathlib import Path
import sys,runpy,json
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'src'));sys.path.insert(0,str(ROOT/'continuation/src'))
from build_circuit import build
circuit=build();ref=runpy.run_path(str(ROOT/'src/replay_candidates.py'))
FR,KR,S,embed,scalar,endpoint,z,c25=[ref[k] for k in ['FR','KR','S','embed','scalar','endpoint','z','c25']]
def bar(x):
 a,b=x.c;return KR.row([a+b,-b])
def pk(x):return [sum(c*5**j for j,c in enumerate(a.c)) for a in x.c]
def pf(x):return [pk(a) for a in x.c]
def inp(rec):
 q,h=rec['Q_ordered'],rec['H_ordered']
 assert q[0]==[0,0]
 return [z**q[j][1] for j in range(1,4)]+[KR(pow(2,q[j][0],5)) for j in range(1,4)]+[z**p for i,p in h]+[KR(pow(2,i,5)) for i,p in h]
def ep(R,name):
 if name in {'c','e'}:return endpoint(R,name)
 cs,m=([12,18,8,6],17) if name=='u' else ([4,17,2,0],4)
 return sum((FR.row([c25(c)*pow(2,i*j,5)*z**((m*p)%29)/c25(22) for j,c in enumerate(cs)]) for i,p in R),FR.zero)
recs=list(map(json.loads,(ROOT/'continuation/evidence/circuit_samples.jsonl').read_text().splitlines()))
for r in recs:
 inputs=inp(r)
 for a,meta in zip(inputs,circuit['inputs']):assert a**meta['order']==KR.one
 vals=[]
 for op,a,b in circuit['gates']:
  if op=='c':v=c25(a)
  elif op=='i':v=inputs[a]
  elif op=='+':v=vals[a]+vals[b]
  elif op=='*':v=vals[a]*vals[b]
  else:raise ValueError(op)
  vals.append(v)
 def s(n):return vals[circuit['outputs'][n]]
 def f(n):return FR.row([vals[i] for i in circuit['outputs'][n]])
 for k in ['X','Y','Z','T','E']:assert pk(s(k))==r[k]
 for k in ['G','eq3_cleared','eq4_cleared']:assert pf(f(k))==r[k]
 x=s('X')/s('d');y=s('Y')/s('delta_C');eps=f('G')/embed(s('E'),FR)
 q,h=r['Q_ordered'],r['H_ordered'];A=ep(q,'e');B=ep(q,'c');D=ep(h,'e')
 assert eps==(D-embed(x,FR))/(B-embed(y,FR))
 e3=eps*(ep(q,'u')-embed(x.frob(4),FR))+ep(q,'v')+embed(y.frob(8),FR)
 e4=ep(h,'u')+eps*(ep(h,'v')+embed(y.frob(1),FR))-embed(x.frob(11),FR)
 assert f('eq3_cleared')==e3*embed(s('eq3_multiplier'),FR)
 assert f('eq4_cleared')==e4*embed(s('eq4_multiplier'),FR)
 assert bool(s('unit_patch_0') or s('unit_patch_2'))==bool(eps.c[3] and (eps.c[0] or eps.c[2]))
assert len(recs)==12
print(json.dumps({'status':'PASS','independent_polynomial_arithmetic':True,'circuit_samples_replayed':len(recs),'four_trace_cleared_residual_identities_checked':True,'samples_are_solutions':False},indent=2))
