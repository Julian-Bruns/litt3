"""Exact optional GMP acceleration; no change to the coefficient field."""
from pathlib import Path
import ctypes as C
import numpy as np
from ff import Poly,u32p
lib=C.CDLL(str(Path(__file__).with_name('gmp_arith.so')))
lib.gp_mul.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,C.c_int];lib.gp_mul.restype=C.c_int
lib.gp_divrem.argtypes=[u32p,C.c_int,u32p,C.c_int,u32p,u32p];lib.gp_divrem.restype=C.c_int
lib.gp_version.restype=C.c_char_p
_orig_mul=Poly.__mul__;_orig_divmod=Poly.__divmod__
def fast_mul(a,b):
 b=Poly(b)
 if min(len(a),len(b))<64 or max(len(a),len(b))<256:return _orig_mul(a,b)
 r=np.zeros(len(a)+len(b)-1,dtype=np.uint32);assert lib.gp_mul(a.a,len(a),b.a,len(b),r,len(r))==1
 return Poly(r)
def fast_divmod(a,b):
 b=Poly(b)
 if len(b)<64 or len(a)-len(b)<64:return _orig_divmod(a,b)
 q=np.zeros(len(a)-len(b)+1,dtype=np.uint32);r=np.zeros(len(a),dtype=np.uint32);assert lib.gp_divrem(a.a,len(a),b.a,len(b),q,r)==1
 return Poly(q),Poly(r[:len(b)-1])
def install():Poly.__mul__=fast_mul;Poly.__rmul__=fast_mul;Poly.__divmod__=fast_divmod
