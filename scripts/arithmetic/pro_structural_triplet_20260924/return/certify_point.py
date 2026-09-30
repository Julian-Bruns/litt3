"""Certify the additional stable, nonperiodic F25 point and all its Hom maps."""
from core import *
import json

def solve(A,b):
 R,p=F.rref(np.column_stack((A,b[:,None])),A.shape[1]);r=len(p)
 assert not R[r:,-1].any()
 z=np.zeros(A.shape[1],np.uint8)
 for i,j in enumerate(p):z[j]=R[i,-1]
 return z

def main():
 v=np.array([1,10,15,16,5,8],np.uint8)
 t=lin(EQ['T'],v);q=lin(EQ['Q'],v);z=mix(EQ['C'],v,v)
 kc=F.kernel(t);ks=F.kernel(q)
 assert kc.shape==(15,1) and ks.shape==(9,1)
 s=solve(q,F.NEG[F.matmul(z,kc)[:,0]])
 C0,S0=embed(np.zeros(15,np.uint8),ks[:,0]);C1,S1=embed(kc[:,0],s)
 K=np.column_stack((np.r_[C0,S0],np.r_[C1,S1]))
 A=regularity(v)
 assert not F.matmul(A,K).any()
 assert len(F.rref(K)[1])==2 and A.shape[1]-len(F.rref(A)[1])==2
 assert stability_gcd(v)==F.mono() and not on_scroll(v)
 out={'v_codes':v.tolist(),'field':'F25','geometrically_stable':True,'stability_gcd':poly_json(stability_gcd(v)),
 'on_first_scroll':False,'rank_T_invariant':14,'rank_Q_invariant':8,'rank_T_full':len(F.rref(lin(D['T'],v))[1]),
 'rank_Q_full':len(F.rref(lin(D['Q'],v))[1]),'full_Hom_dimension':2,'basis':[]}
 HH=[]
 for cc,ss in [(C0,S0),(C1,S1)]:
  H,res,free=reconstruct(v,cc,ss)
  assert not res.any()
  ev=np.array([[evaluate(p,5,14) for p in row] for row in H],np.uint8)
  assert np.array_equal(ev,point_matrix(v,v,cc,ss))
  HH.append(H)
  out['basis'].append({'c35':cc.tolist(),'s16':ss.tolist(),'free_polynomials':{k:poly_json(p) for k,p in free.items()},
   'H_U':matrix_json(H),'H_at_P_star':ev.tolist(),'infinity_residual_lengths':[152,163,159],
   'infinity_residual_nonzero_counts':[int(np.count_nonzero(res[:152])),int(np.count_nonzero(res[152:315])),int(np.count_nonzero(res[315:]))]})
 # Since every global determinant is constant, four evaluations certify the
 # whole homogeneous binary cubic det(a H0 + b H1) identically zero, including
 # coefficients in arbitrary extensions. We also expand the global determinants.
 determinants=[]
 for a,b in [(1,0),(0,1),(1,1),(1,2)]:
  H=[[F.add(F.scale(a,HH[0][r][s]),F.scale(b,HH[1][r][s])) for s in range(3)] for r in range(3)]
  ev=np.array([[evaluate(p,5,14) for p in row] for row in H],np.uint8)
  assert det(ev)==0
  dg=determinant3(H);assert not dg
  determinants.append({'a':a,'b':b,'det_at_P_star':0,'global_determinant':[]})
 out['determinant_checks']=determinants
 (ROOT/'certificates'/'additional_point.json').write_text(json.dumps(out,indent=2)+'\n')
 print('PASS: stable over algebraic closure; outside first scroll; full Hom dimension 2; all 474 infinity conditions for both recovered basis maps; four global determinant identities',flush=True)
 print('negative-line basis s0:',out['basis'][0]['free_polynomials']['s0'],flush=True)
 print('wrote certificates/additional_point.json',flush=True)
if __name__=='__main__':main()

