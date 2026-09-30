#!/usr/bin/env python3
"""Restartable exact Hermite values of three whole-curve resultant norms.

This is polynomial identity reconstruction data, not a finite-field square
search. The degree bounds in resultant_pole_bounds.json are indispensable.
"""
from pathlib import Path
import argparse,ctypes as C,json,hashlib,time,os
from concurrent.futures import ProcessPoolExecutor,as_completed
import numpy as np
from ff import u32p,power,mul,add
ROOT=Path(__file__).resolve().parents[1]
LIB=None;PACK=None;OUT=None;OFFSETS=None

def init(out):
 global LIB,PACK,OUT,OFFSETS
 OUT=Path(out);OUT.mkdir(parents=True,exist_ok=True)
 LIB=C.CDLL(str(ROOT/'src/fast_tails.so'));i32p=np.ctypeslib.ndpointer(dtype=np.int32,ndim=1,flags='C_CONTIGUOUS')
 LIB.ft_set_normalization.argtypes=[u32p,i32p,C.c_int,i32p,C.c_int]
 LIB.ft_coset_resultants.argtypes=[u32p,C.c_uint32,u32p,C.c_int]
 factors=json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']
 bounds=json.loads((ROOT/'data/resultant_pole_bounds.json').read_text())['resultants'];exps=np.zeros((3,len(factors)),dtype=np.int32)
 for n in range(72,75):
  for k,v in bounds[str(n)]['finite_valuation_lower_bounds'].items():exps[n-72,int(k)]=-v
  for k,f in enumerate(factors):
   if len(f)==2:exps[n-72,k]+=2
 assert LIB.ft_set_normalization(np.array(sum(factors,[]),dtype=np.uint32),np.array(list(map(len,factors)),dtype=np.int32),len(factors),exps.ravel(),3)
 G=np.load(ROOT/'data/global_residual.npz')['coefficients'];assert hashlib.sha256(G.astype('<u4').tobytes()).hexdigest()=='b7da17bf2b8553a8019909fe87214464ba4123cbfe44599f5011e04005b04a44';PACK=G[:,:75,:,:].transpose(3,0,1,2).copy().ravel()
 g=power(25,626);sub=[0]+[power(g,i)for i in range(624)]
 assert len(set(sub))==625 and power(25,625)!=25
 OFFSETS=[mul(25,b)for b in sub]

def one(i):
 dst=OUT/f'{i:03d}.npz';off=OFFSETS[i]
 if dst.exists():
  d=np.load(dst);assert int(d['offset'])==off and d['values'].shape==(625,6)
  return i,'retained',0
 t=time.time();v=np.zeros((625,6),dtype=np.uint32)
 assert LIB.ft_coset_resultants(PACK,off,v.ravel(),74)==1,('coset calculation failed',i,off)
 tmp=dst.with_name(dst.name+f'.{os.getpid()}.tmp')
 with open(tmp,'wb')as f:np.savez_compressed(f,offset=np.uint32(off),values=v)
 os.replace(tmp,dst)
 return i,hashlib.sha256(v.astype('<u4').tobytes()).hexdigest(),round(time.time()-t,3)

def main():
 p=argparse.ArgumentParser();p.add_argument('--output',default=str(ROOT/'scratch/resultant_samples'));p.add_argument('--workers',type=int,default=5);p.add_argument('--first',type=int,default=0);p.add_argument('--last',type=int,default=625);a=p.parse_args()
 t=time.time();print('EXACT_HERMITE_RECONSTRUCTION_DATA; NOT A SQUARE-POINT SEARCH',flush=True)
 with ProcessPoolExecutor(a.workers,initializer=init,initargs=(a.output,))as ex:
  fs=[ex.submit(one,i)for i in range(a.first,a.last)]
  for f in as_completed(fs):print(json.dumps(dict(zip(['coset','sha256','seconds'],f.result()))),flush=True)
 print('COMPLETE_SECONDS',round(time.time()-t,3),flush=True)
if __name__=='__main__':main()
