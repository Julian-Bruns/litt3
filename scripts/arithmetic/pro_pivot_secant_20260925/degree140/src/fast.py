import ctypes as ct
from pathlib import Path
import numpy as np
import exact as E
from atlas import fixed_data
class Fast:
 def __init__(self,path,tables):
  self.lib=ct.CDLL(str(path));self.ptr=np.ctypeslib.ndpointer(dtype=np.int32,flags='C_CONTIGUOUS')
  self.lib.fast_init.argtypes=[ct.c_char_p];assert self.lib.fast_init(str(tables).encode())==0
  self.lib.fast_residual.argtypes=[self.ptr]*7
  self.lib.fast_errors.argtypes=[self.ptr]*2
  self.lib.fast_formal74.argtypes=[self.ptr]*2
  self.lib.fast_resultant.argtypes=[self.ptr,ct.c_int,self.ptr,ct.c_int,ct.c_int,ct.c_int]
  self.lib.fast_gcd.argtypes=[self.ptr,ct.c_int,self.ptr,ct.c_int,self.ptr]
  self.lib.fast_divrem.argtypes=[self.ptr,ct.c_int,self.ptr,ct.c_int,self.ptr,self.ptr]
  self.lib.fast_valuation.argtypes=[self.ptr,ct.c_int,self.ptr,ct.c_int]
 def residual(self,H,root,P=None,t=None):
  P0,A,Q,B,L,t0,Ct=fixed_data()
  if P is None:P=P0
  if t is None:t=t0
  Hpad=np.zeros((4,3,32),np.int32)
  for i,g in enumerate(H):
   for j,c in enumerate(g):Hpad[i,j,:len(c)]=c
  v=np.array([1,0] if root is None else [E.F.N(root),1],np.int32)
  out=np.zeros((7,141),np.int32)
  assert self.lib.fast_residual(Hpad,np.ascontiguousarray(P),Q,B,np.ascontiguousarray(t),v,out)==0
  return out
 def errors(self,R):
  out=np.zeros((70,105),np.int32);assert self.lib.fast_errors(np.ascontiguousarray(R),out)==0;return out
 def formal74(self,R):
  out=np.zeros((4,105),np.int32);assert self.lib.fast_formal74(np.ascontiguousarray(R),out)==0;return out
 def resultant(self,a,b,md,nd):
  a=np.ascontiguousarray(a);b=np.ascontiguousarray(b);v=self.lib.fast_resultant(a,len(a),b,len(b),md,nd);assert v>=0;return v
 def gcd(self,a,b):
  a=np.ascontiguousarray(a);b=np.ascontiguousarray(b);out=np.zeros(max(len(a),len(b)),np.int32);n=self.lib.fast_gcd(a,len(a),b,len(b),out);assert n>=0;return out[:n]

 def divrem(self,a,b):
  a=np.ascontiguousarray(a);b=np.ascontiguousarray(b);q=np.zeros(len(a),np.int32);r=q.copy();n=self.lib.fast_divrem(a,len(a),b,len(b),q,r);assert n>=0;return E.poly(q),E.poly(r)
 def valuation(self,a,b):
  a=np.ascontiguousarray(a);b=np.ascontiguousarray(b);v=self.lib.fast_valuation(a,len(a),b,len(b));assert v>=0;return v
