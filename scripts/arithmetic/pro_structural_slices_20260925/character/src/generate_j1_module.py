"""Exact source-linear equations on the chart alpha_(y^2)=1, j=1."""
from pathlib import Path
import json
from exact import *
root=Path(__file__).resolve().parents[1];D=np.load(root/'data/pencils.npz');T=D['T'];g=json.loads((root/'data/grades.json').read_text());zA,zB,zC=g['z_groups'];s0,s1,s2=g['section_groups'];rows=g['row_groups']
D2=np.load(root/'data/j1_nonzero_alpha2_branch.npz');rec=D2['recovery'];proj=D2['projected']
# Variables a0..a3 denote coefficients of alpha1; w0..w14 are f and alpha0.
# Every equation is linear in c=(z13..z18). b=-rec(c,a).
relations=[]
def put(dic,key,c):
 old=dic.get(key,0);new=int(ADD[old,c])
 if new:dic[key]=new
 else:dic.pop(key,None)
for r in range(proj.shape[0]):
 rel={}
 for c in range(6):
  for a in range(4):put(rel,(c,(a,)),int(proj[r,c,a]))
 if rel:relations.append(rel)
for r in rows[0]:
 rel={}
 for c in range(6):
  for w,s in enumerate(s1):put(rel,(c,(4+w,)),int(T[zC[c],r,s]))
  for b in range(10):
   for a in range(4):
    for aa in range(4):put(rel,(c,tuple(sorted((a,aa)))),int(NEG[MUL[T[zB[b],r,30+aa],rec[b,c,a]]]))
 relations.append(rel)
for r in rows[2]:
 rel={}
 for c in range(6):
  put(rel,(c,()),int(T[zC[c],r,34]))
  for b in range(10):
   for a in range(4):
    for w,s in enumerate(s1):put(rel,(c,(a,4+w)),int(NEG[MUL[T[zB[b],r,s],rec[b,c,a]]]))
 relations.append(rel)
# Row-reduce all coefficients, prioritizing high-degree monomials.
cols=sorted({key for rel in relations for key in rel},key=lambda cm:(-len(cm[1]),tuple(-x for x in cm[1]),cm[0]))
M=np.array([[rel.get(key,0) for key in cols] for rel in relations],dtype=np.uint8)
R,p=rref(M);relations=[{cols[j]:int(c) for j,c in enumerate(row) if c} for row in R[:len(p)]]
print('relations',len(relations),'degrees',{d:sum(max(map(lambda cm:len(cm[1]),rel))==d for rel in relations) for d in range(3)},'nonzero',sum(len(r) for r in relations))
portable={'field':'F25 beta^2=beta+3','nz':6,'nw':19,'variables':['a0','a1','a2','a3']+[f'w{i}' for i in range(15)],'source_variables':zC,'relations':[[[c,list(mon),coeff] for (c,mon),coeff in rel.items()] for rel in relations]}
(root/'data/j1_nonzero_alpha2_module.json').write_text(json.dumps(portable,indent=2)+'\n')
for d in [2,3,4,5]:
 with open(root/f'data/j1_module_degree{d}.txt','w') as f:
  f.write(f'{len(relations)} 6 19 {d}\n')
  for rel in relations:
   f.write(str(len(rel))+'\n')
   for (c,mon),coeff in rel.items():f.write(' '.join(map(str,[c,coeff,len(mon)]+list(mon)))+'\n')
