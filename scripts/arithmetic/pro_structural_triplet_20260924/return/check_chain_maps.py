"""Verify that the bounded chain-map approach produced no nontrivial maps."""
from core import *
import json

def main():
 T,Q=EQ['T'],EQ['Q']
 const=np.load(ROOT/'data'/'constant_chain_maps.npz');assert const['kernel'].shape==(457,0)
 d=np.load(ROOT/'data'/'linear_chain_maps.npz');A=d['A'];assert A.shape==(207,6,9,15)
 S,L=d['S'],d['L'];assert len(F.rref(S)[1])==138 and not F.matmul(L,S).any()
 Z=np.zeros((810,207),np.uint8)
 for a in range(9):
  for r in range(23):
   for k in range(6):Z[(k*9+a)*15:(k*9+a+1)*15,a*23+r]=T[k,r]
 assert len(F.rref(Z)[1])==207
 assert len(F.rref(np.column_stack((Z,A.reshape(207,-1).T)))[1])==207
 out={'constant_chain_maps':0,'linear_chain_maps_A_dimension':207,'all_linear_maps_trivial':True,
 'meaning_of_trivial':'A(v)=D*T(v) for a constant 9x23 matrix D; these maps vanish on ker T(v).',
 'geometric_conclusion':'NONE; this bounded approach did not prove a support inclusion.'}
 (ROOT/'certificates'/'chain_map_attempt.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
if __name__=='__main__':main()

