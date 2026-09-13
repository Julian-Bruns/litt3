# Adapted from the fully replayed returned neutral5 certificate, 2026-09-11.
"""Exact nonnegative integer convolution using GMP Kronecker substitution.

No floating-point arithmetic. Each coefficient occupies a 64-bit digit;
the explicit coefficient bound excludes carries between polynomial degrees.
"""
import ctypes as C
import ctypes.util
import atexit
import numpy as np
lib=C.CDLL(ctypes.util.find_library('gmp'))
class Mpz(C.Structure):
 _fields_=[('_mp_alloc',C.c_int),('_mp_size',C.c_int),('_mp_d',C.POINTER(C.c_ulong))]
init=getattr(lib,'__gmpz_init');init.argtypes=[C.POINTER(Mpz)]
clear=getattr(lib,'__gmpz_clear');clear.argtypes=[C.POINTER(Mpz)]
imp=getattr(lib,'__gmpz_import');imp.argtypes=[C.POINTER(Mpz),C.c_size_t,C.c_int,C.c_size_t,C.c_int,C.c_size_t,C.c_void_p]
mul=getattr(lib,'__gmpz_mul');mul.argtypes=[C.POINTER(Mpz)]*3
exp=getattr(lib,'__gmpz_export');exp.argtypes=[C.c_void_p,C.POINTER(C.c_size_t),C.c_int,C.c_size_t,C.c_int,C.c_size_t,C.POINTER(Mpz)]
A,B,D=Mpz(),Mpz(),Mpz()
for z in [A,B,D]:init(C.byref(z))
@atexit.register
def cleanup():
 for z in [A,B,D]:clear(C.byref(z))
def conv(a,b):
 a=np.ascontiguousarray(a,dtype=np.uint64);b=np.ascontiguousarray(b,dtype=np.uint64)
 assert min(len(a),len(b))*int(a.max(initial=0))*int(b.max(initial=0)) < 2**63
 imp(C.byref(A),len(a),-1,8,0,0,a.ctypes.data)
 imp(C.byref(B),len(b),-1,8,0,0,b.ctypes.data)
 mul(C.byref(D),C.byref(A),C.byref(B))
 out=np.zeros(len(a)+len(b)-1,dtype=np.uint64);count=C.c_size_t()
 exp(out.ctypes.data,C.byref(count),-1,8,0,0,C.byref(D))
 assert count.value<=len(out)
 return out.view(np.int64)
if __name__=='__main__':
 import time
 for n in [50,1500,4000]:
  a=np.random.default_rng(0).integers(0,625,n,dtype=np.int64);b=a[::-1].copy()
  start=time.monotonic();x=np.convolve(a,b);t1=time.monotonic()-start
  start=time.monotonic();y=conv(a,b);t2=time.monotonic()-start
  print(n,t1,t2,np.array_equal(x,y))
