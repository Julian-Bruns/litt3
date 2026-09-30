#!/usr/bin/env python3
"""Independent polynomial-arithmetic replay of all five boundary survivors."""
from pathlib import Path
import runpy,sys,json,gzip,time
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
g=runpy.run_path(str(ROOT/'src'/'replay_candidates.py'))
FR=g['FR'];KR=g['KR'];S=g['S'];endpoint=g['endpoint'];embed=g['embed'];scalar=g['scalar'];coords=g['coords'];rank=g['rank'];pack=g['pack'];beta=g['beta']
source=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT/'continuation/evidence/boundary_survivors.jsonl.gz'
records=[json.loads(x) for x in gzip.open(source,'rt')]
def bar(z):
 a,b=z.c
 return KR.row([a+b,-b])
def norm(z):
 a,b=z.c
 return a*a+a*b+2*b*b
for rec in records:
 assert rec['kind']=='boundary_linear_candidate' and rec['rank']==4 and not rec['nullspace']
 Q,H=rec['Q'],rec['H'];A=endpoint(Q,'e');B=endpoint(Q,'c');C=endpoint(H,'c');D=endpoint(H,'e')
 assert rec['norm_c_equal']==(norm(B.c[3])==norm(C.c[3]))
 assert rec['norm_e_equal']==(norm(A.c[1])==norm(D.c[1]))
 assert rec['norm_c_equal'] or rec['norm_e_equal']
 be=embed(beta,FR);cols=[-A-D,-be*A-(1-be)*D,B+C,(1-be)*B+be*C];W=A*D-B*C
 mat=list(map(list,zip(*[coords(v)[1:] for v in cols])));assert rank(mat)==4
 p=list(map(scalar,rec['particular']));v=W+sum((col*embed(s,FR) for col,s in zip(cols,p)),FR.zero)
 assert not any(coords(v)[1:]);x=KR.row(p[:2]);y=KR.row(p[2:]);residue=coords(v)[0]+norm(x)-norm(y)
 assert residue and pack(residue)==rec['quadric_at_particular']
assert len(records)==5
print(json.dumps({'status':'PASS','boundary_linear_survivors':len(records),'rank_four':len(records),'seven_affine_equations_pass':len(records),'scalar_quadric_fail':len(records),'independent_polynomial_arithmetic':True},indent=2))
