"""Generate the exact row certificate for the forced third-coefficient pole."""
import json,pathlib
import numpy as np
import field as F
import linear_system as L

def trace_matrix(M):
 return np.vstack([M,[L.equation({key:1}) for key in L.VARS if key[0]==1]])

def generate(root):
 M,t,blocks=L.build();M=trace_matrix(M)
 target=np.zeros(L.NV,dtype=np.int32)
 target[L.VARS.index((3,12,1))]=1;target[-1]=int(F.neg(359499))
 # Solve M^t lambda = target; free lambda-coordinates are set to zero.
 aug=np.column_stack([M.T,target]);R,piv=F.rref(aug)
 assert M.shape[0] not in piv
 lam=np.zeros(M.shape[0],dtype=np.int32)
 for i,j in enumerate(piv):lam[j]=R[i,-1]
 check=np.zeros(L.NV,dtype=np.int32)
 for i,c in enumerate(lam):
  if c:check=F.add(check,F.mul(c,M[i]))
 assert np.array_equal(check,target)
 cert={'statement':'coefficient of x^12*y in N3 equals c_alpha*kappa on the entire trace-zero linear kernel',
       'field_size':F.Q,'alpha_integer':25,'c_alpha':359499,'c_alpha_base25_digits':[24,4,0,23],
       'matrix':'linear_system.build(), followed by coordinate rows N1=0 in variable order',
       'number_of_rows':int(M.shape[0]),'target':target.tolist(),
       'row_combination':[[i,int(c)] for i,c in enumerate(lam) if c]}
 (root/'certificates'/'third_pole_row.json').write_text(json.dumps(cert,indent=2)+'\n')
 print('Row certificate verified:',len(cert['row_combination']),'nonzero row weights;',M.shape[0],'rows')
 print('c_alpha = [24] + [4] alpha + [23] alpha^3 = encoded integer 359499')
 return cert
if __name__=='__main__':generate(pathlib.Path(__file__).resolve().parents[1])
