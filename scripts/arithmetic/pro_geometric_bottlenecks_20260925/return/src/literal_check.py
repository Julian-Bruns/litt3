"""Independent implementation of the literal equations (2) and (3).
Checks every stored constant column and every source/direction coefficient.
Does not re-prove the accepted completeness of the reconstruction formulas.
"""
from exact import *
import pathlib,json,time
ROOT=pathlib.Path(__file__).resolve().parents[1]

def literal(f,alpha,U,V,E,g0={},q0={},VE=None):
 a=add(positive(mul(e,f)),alpha)
 p=add(a,neg(mul(e,f)))
 g=add(neg(positive(mul(U,f))),g0)
 q=add(positive(add(mul(e,g),neg(mul(U,p)))),q0)
 VE=add(V,mul(U,E)) if VE is None else VE
 B=add(mul(E,g),mul(VE,f));h=neg(positive(B))
 D=add(neg(mul(e,h)),mul(E,add(q,neg(mul(e,g)))),mul(VE,p))
 return np.concatenate([vector(B,obstruction_basis(-144)),vector(D,obstruction_basis(-155))])

def check():
 t=time.time();arr=np.load(ROOT/'data/pencils.npz');meta=json.load(open(ROOT/'data/bases.json'));E=frob25(e)
 for j,(typ,i,k) in enumerate(meta['c_basis']):
  got=literal({},{},{},{},E,**{typ:mon(i,k)})
  assert np.array_equal(got,arr['C'][:,j]),('C',j)
 print('literal constant C: all 235 columns match',flush=True)
 for z in range(19):
  U=frob25(mon(*u_basis[z])) if z<6 else {}
  V=frob25(mon(*v_basis[z-6])) if z>=6 else {}
  VE=add(V,mul(U,E))
  for j,(typ,i,k) in enumerate(meta['w_basis']):
   f=mon(i,k) if typ=='f' else {};alpha=mon(i,k) if typ=='alpha' else {}
   got=literal(f,alpha,U,V,E,VE=VE)
   assert np.array_equal(got,arr['raw'][z,:,j]),('raw',z,j)
  for j,m in enumerate(basis(24)):
   n=mon(*m);got=vector(add(mul(E,negative(mul(U,n))),mul(V,n)),obstruction_basis(-151))
   assert np.array_equal(got,arr['Qraw'][z,:,j]),('Qraw',z,j)
  print('literal source coefficient',z,': 35 T and 16 Q columns match; elapsed',round(time.time()-t,2),flush=True)
 for j,m in enumerate(basis(124)):
  assert np.array_equal(vector(mul(E,mon(*m)),obstruction_basis(-151)),arr['A'][:,j]),('A',j)
 assert np.array_equal(mm(arr['H'],arr['C']),np.eye(235,dtype=np.uint8))
 assert not mm(arr['N'],arr['C']).any()
 assert np.array_equal(mm(arr['HQ'],arr['A']),np.eye(116,dtype=np.uint8))
 assert not mm(arr['NQ'],arr['A']).any()
 assert rank(arr['N'])==80 and rank(arr['NQ'])==43
 assert rank(np.vstack([arr['H'],arr['N']]))==315
 assert rank(np.vstack([arr['HQ'],arr['NQ']]))==159
 for i in range(19):
  assert np.array_equal(mm(arr['N'],arr['raw'][i]),arr['T'][i])
  assert np.array_equal(mm(arr['NQ'],arr['Qraw'][i]),arr['Q'][i])
 print('all literal equations, left inverses, cokernel maps, and pencils VERIFIED; elapsed',round(time.time()-t,2),flush=True)
if __name__=='__main__':check()
