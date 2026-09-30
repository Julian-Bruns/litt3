#!/usr/bin/env python3
"""Replay every decisive generic and norm-boundary survivor independently."""
import json,sys
from pathlib import Path
from reference import *
path=Path(sys.argv[1])if len(sys.argv)>1 else ROOT/'full/evidence/generic_survivors.jsonl'
bp=Path(sys.argv[2])if len(sys.argv)>2 else ROOT/'full/evidence/boundary_survivors.jsonl'
generic=[json.loads(t)for t in path.read_text().splitlines()if t]
boundary=[json.loads(t)for t in bp.read_text().splitlines()if t]
checks=[]
for r in generic:
 assert r['kind']=='generic_Z_candidate'
 A=endpoint(r['Q'],'e');B=endpoint(r['Q'],'c');C=endpoint(r['H'],'c');D=endpoint(r['H'],'e')
 dx,dy,x,y,Z,T,v=moments_and_residuals(A,B,C,D)
 assert packS(dx)==r['delta_x'] and packS(dy)==r['delta_y']
 assert packK(x)==r['x'] and packK(y)==r['y'] and packK(T)==r['T']
 assert not Z and T and packK(v.c[0])==r['equation6_residual'] and not any(v.c[1:])
 # In fact the final nonscalar linear coordinate is already nonzero.
 assert v.c[0].c[1]
 checks.append({'q_index':r['q_index'],'h_index':r['h_index'],'orbit':r['orbit'],'determinant_residual':packK(v.c[0]),'beta_coordinate_nonzero':True})
for r in boundary:
 assert r['kind']=='boundary_linear_candidate' and r['rank']==4 and not r['nullspace']
 A=endpoint(r['Q'],'e');B=endpoint(r['Q'],'c');C=endpoint(r['H'],'c');D=endpoint(r['H'],'e')
 assert norm(B.c[3])==norm(C.c[3]) and norm(A.c[1])==norm(D.c[1])
 be=scalar(beta);cols=[-A-D,-be*A-(1-be)*D,B+C,(1-be)*B+be*C];W=A*D-B*C
 coords=lambda z:[a for c in z.c for a in c.c]
 matrix=[list(row)for row in zip(*[coords(c)[1:]for c in cols])]
 assert rank(matrix)==4
 par=list(map(unpackS,r['particular']));v=W+sum((col*scalar(z)for col,z in zip(cols,par)),FR.zero)
 assert not any(coords(v)[1:])
 x=KR.row(par[:2]);y=KR.row(par[2:]);res=original_determinant(A,B,C,D,x,y)
 assert not any(coords(res)[1:]) and coords(res)[0] and packS(coords(res)[0])==r['quadric_at_particular']
checks_b=[{'q_index':r['q_index'],'scalar_residual':r['quadric_at_particular']}for r in boundary]
print(json.dumps({'status':'PASS','arithmetic':'independent polynomial arithmetic in the explicitly compatible field tower','generic_survivors':len(generic),'boundary_survivors':len(boundary),'generic_details':checks,'boundary_details':checks_b},indent=2,sort_keys=True))
