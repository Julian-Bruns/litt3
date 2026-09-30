from exact import *
from macaulay import independent_equations,macaulay
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
T=np.load(root/'data/pencils.npz')['T'];grades=json.loads((root/'data/grades.json').read_text())
zA,zB,zC=grades['z_groups'];s0,s1,s2=grades['section_groups'];rows=grades['row_groups']
# Prove zA=0 for f in character 1, without using alpha.
B=np.load(root/'data/fonly_char1.npz')['B']
A=independent_equations(B[zA].transpose(1,0,2))
for d in range(1,5):
 M,mons,_=macaulay(A,d);R,p=rref(M)
 print('j1_zA',d,M.shape,len(p),flush=True)
 if len(p)==M.shape[1]:
  np.savez_compressed(root/'certificates/j1_zA.npz',A=A,d=np.array(d));break
# Grade 1 remaining zero-lower terms: alpha2*zB and alpha1*zC.
I=T[zB][:,rows[1],34].T
J=T[zC][:,rows[1],30:34].transpose(1,0,2)
print('I shape, rank',I.shape,rank(I),'J flat',rank(J.reshape(27,-1)),flush=True)
H=kernel(I.T).T
Jp=np.stack([mm(H,J[:,z,:]) for z in range(6)],axis=1)
Jp=independent_equations(Jp)
print('projected J',Jp.shape,flush=True)
for d in range(1,6):
 M,mons,_=macaulay(Jp,d);R,p=rref(M)
 print('j1_mid',d,M.shape,len(p),flush=True)
 if len(p)==M.shape[1]:
  np.savez_compressed(root/'certificates/j1_middle.npz',I=I,J=J,H=H,A=Jp,d=np.array(d));break
