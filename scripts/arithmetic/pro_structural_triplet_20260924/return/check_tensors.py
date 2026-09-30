"""Coefficient-wise verification of the full equivariant specialization.
The independent target/source tests are identities, not random point samples.
"""
from core import *
import json,time

def main():
 start=time.time();n=0
 # All tensor zero-patterns and recovered polynomial character sectors.
 I=EQ['c_indices'];J=EQ['s_indices'];tr=EQ['T_rows'];nr=EQ['N_rows']
 assert len(I)==15 and len(J)==9 and len(tr)==23 and len(nr)==14
 assert np.array_equal(EQ['T'],D['T'][:,tr,:][:,:,I])
 assert np.array_equal(EQ['C'],D['C'][:,:,nr,:][:,:,:,I])
 assert np.array_equal(EQ['Q'],D['Q'][:,nr,:][:,:,J])
 assert not np.delete(D['T'][:,:,I],tr,axis=1).any()
 assert not np.delete(D['C'][:,:,:,I],nr,axis=2).any()
 assert not np.delete(D['Q'][:,:,J],nr,axis=1).any()
 for j in range(6):
  eta=np.eye(6,dtype=np.uint8)[j]
  for ci in I:
   cc=np.eye(35,dtype=np.uint8)[ci];ss=np.zeros(16,np.uint8)
   for i in range(6):
    v=np.eye(6,dtype=np.uint8)[i]
    H,res,parts=reconstruct_independent(v,eta,cc,ss)
    assert not F.matmul(D['SA'],res[:315,None]).any()
    assert np.array_equal(F.matmul(D['LA'],res[:315,None])[:,0],D['T'][j,:,ci])
    assert not F.matmul(D['SN'],res[315:,None]).any()
    assert np.array_equal(F.matmul(D['LN'],res[315:,None])[:,0],D['C'][i,j,:,ci])
    ev=np.array([[evaluate(p,5,14) for p in row] for row in H],np.uint8)
    assert np.array_equal(ev,point_matrix(v,eta,cc,ss))
    weights=[[0,0,2],[0,0,2],[1,1,0]]
    for rr in range(3):
     for kk in range(3):assert all(yy==weights[rr][kk] for xx,yy in H[rr][kk])
    n+=1
  for si in J:
   v=np.zeros(6,np.uint8);cc=np.zeros(35,np.uint8);ss=np.eye(16,dtype=np.uint8)[si]
   H,res,parts=reconstruct_independent(v,eta,cc,ss)
   assert not res[:315].any()
   assert not F.matmul(D['SN'],res[315:,None]).any()
   assert np.array_equal(F.matmul(D['LN'],res[315:,None])[:,0],D['Q'][j,:,si])
   ev=np.array([[evaluate(p,5,14) for p in row] for row in H],np.uint8)
   assert np.array_equal(ev,point_matrix(v,eta,cc,ss));n+=1
  print('source',j,'coefficient tests completed',n,flush=True)
 out={'status':'PASS','independent_target_source_coefficient_tests':n,'interpretation':'540 mixed c tests and 54 s tests verify every coefficient of the equivariant tensors, recovery and point evaluation over any extension field','seconds':round(time.time()-start,4)}
 (ROOT/'certificates'/'tensor_checks.json').write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps(out),flush=True)
if __name__=='__main__':main()

