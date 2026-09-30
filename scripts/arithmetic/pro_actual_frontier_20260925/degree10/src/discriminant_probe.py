"""Bounded exploratory discriminant computations, not an exhaustive cover test."""
import json,pathlib,random,sys,time
import numpy as np
import sympy as sp
import field as F
import linear_system as L
from profile_probe import subspace, restrict
ZERO=np.array([0],dtype=np.int32)
ONE=np.array([1],dtype=np.int32)

def rmul(a,b):
 out=[ZERO.copy() for _ in range(3)]
 for i in range(3):
  if not np.any(a[i]):continue
  for j in range(3):
   if not np.any(b[j]):continue
   z=L.pmul(a[i],b[j]);r=i+j
   if r>=3:z=L.pmul(z,L.P);r-=3
   out[r]=L.padd(out[r],z)
 return out

def radd(a,b):return [L.padd(x,y) for x,y in zip(a,b)]
def rscale(a,c):return [L.trim(F.mul(x,c)) for x in a]
def rpows(a,n):
 r=[[ONE,ZERO,ZERO]]
 for _ in range(n):r.append(rmul(r[-1],a))
 return r

def norm(a):
 v=L.padd(L.ppow(a[0],3),L.pmul(L.ppow(a[1],3),L.P))
 v=L.padd(v,L.pmul(L.ppow(a[2],3),L.ppow(L.P,2)))
 return L.padd(v,F.mul(L.pmul(L.pmul(L.pmul(a[0],a[1]),a[2]),L.P),2))

def pgcd(a,b):
 a=L.trim(a);b=L.trim(b)
 while np.any(b):a,b=b,L.pdiv(a,b)[1]
 return L.trim(F.mul(a,F.inv(a[-1])))

def sample(seed=1, root_value=None, write=True, return_record=False):
 root=pathlib.Path(__file__).resolve().parents[1]
 data=json.loads((root/'data/linear_system.json').read_text())
 K=np.array(data['polynomial_v_kernel'],dtype=np.int32)
 if root_value is None:
  K=subspace(K,0,12,16,17)
  v_index=L.VARS.index((0,0,0))
 else:
  K=subspace(K,1,10,13,14)
  row1=L.equation({(0,0,0):1,(0,1,0):root_value})
  row2=L.equation({(2,i,2):int(F.pow(root_value,i)) for i in range(5)})
  K=restrict(K,[row1,row2])
  v_index=L.VARS.index((0,1,0))
 assert K.shape[1]==8
 rng=random.Random(seed);co=np.array([rng.randrange(25) for _ in range(K.shape[1])],dtype=np.int32)
 z=np.zeros(K.shape[0],dtype=np.int32)
 for i,c in enumerate(co):z=F.add(z,F.mul(K[:,i],c))
 assert z[-1] and z[v_index]
 z=F.mul(z,F.inv(z[v_index]))
 assert z[L.VARS.index((2,4,2) if root_value is None else (2,11,0))]
 Ns=[]
 for i in range(6):
  comps=[np.zeros(30,dtype=np.int32) for _ in range(3)]
  for col,(ii,a,j) in enumerate(L.VARS):
   if ii==i:comps[j][a]=z[col]
  Ns.append([L.trim(p) for p in comps])
 t=np.array(data['tB'],dtype=np.int32);kap=int(z[-1]);v=Ns[0][0]
 c=[ZERO,F.mul(L.pmul(L.ppow(t,3),L.ppow(L.P,3)),kap),ZERO]
 symbols=sp.symbols('a b c d f k')
 expr=sp.sympify((root/'data/generic_resultant.txt').read_text(),locals=dict(zip('abcdfk',symbols)))
 pol=sp.Poly(expr,*symbols,modulus=5)
 inputs=[Ns[2],Ns[3],Ns[4],Ns[5],[np.array(L.Q,dtype=np.int32),ZERO,ZERO],c]
 powers=[rpows(a,max(e[i] for e,_ in pol.terms())) for i,a in enumerate(inputs)]
 vv=[L.ppow(v,i) for i in range(13)]
 out=[ZERO,ZERO,ZERO]
 for k,(ex,coef) in enumerate(pol.terms()):
  prod=[ONE,ZERO,ZERO]
  for i,e in enumerate(ex):prod=rmul(prod,powers[i][e])
  ve=12-sum(ex[i] for i in [0,1,2,3,5]);assert ve>=0
  prod=rmul(prod,[vv[ve],ZERO,ZERO]);out=radd(out,rscale(prod,int(coef)%5))
 n=norm(out)
 # Norm discriminant = -kap^15 t^45 N(R_G)/(v^51 P^40).
 # This is an exact sample computation, not a claimed universal divisibility certificate.
 p40=L.ppow(L.P,40);nn,rem=L.pdiv(n,p40);assert not np.any(rem)
 full=F.mul(L.pmul(L.ppow(t,45),nn),int(F.neg(F.pow(kap,15))))
 # fixed discriminant collision factor t^60 from five sheets at each selected point.
 residual,rem=L.pdiv(full,L.ppow(t,60));assert not np.any(rem)
 if root_value is not None:
  old_residual=residual
  residual,rem=L.pdiv(residual,L.ppow(v,3))
  if np.any(rem):
   valuation=0;pol=old_residual
   while True:
    quo,re=L.pdiv(pol,v)
    if np.any(re):break
    valuation+=1;pol=quo
   raise AssertionError(('linear v divisibility failure',v.tolist(),valuation,'degree',len(old_residual)-1))
 residual=L.trim(F.mul(residual,F.inv(residual[-1])))
 gcd=pgcd(residual,L.pder(residual))
 print('sample',seed,'v root',root_value,'residual degree',len(residual)-1,'gcd with derivative degree',len(gcd)-1,flush=True)
 output={'seed':seed,'root_value':root_value,'restriction':('constant v, infinity partition (4,4,2)' if root_value is None else 'linear v, infinity partition (3,3,1)')+'; coefficient candidate only; not asserted etale','parameter_coefficients':co.tolist(),'variables':z.tolist(),'residual_discriminant_norm':residual.tolist(),'repeated_part_gcd':gcd.tolist()}
 if write:
  filename=('discriminant_sample_%d.json'%seed) if root_value is None else ('discriminant_linear_%d.json'%root_value)
  (root/'data'/filename).write_text(json.dumps(output,separators=(',',':'))+'\n')
 return output if return_record else residual

if __name__=='__main__':
 start=time.time()
 for seed in map(int,sys.argv[1:] or ['1']):sample(seed)
 print('elapsed seconds',time.time()-start)
