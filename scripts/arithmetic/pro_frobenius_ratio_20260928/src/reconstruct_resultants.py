#!/usr/bin/env python3
"""Recover three exact global elimination polynomials by full-field Hermite data.

Degree bounds, including all removed q-fibers, certify the identity. The
extra h^2 factor gives legitimate zero jets at precisely the rational
normalization holes; it is divided out exactly after reconstruction.
"""
from pathlib import Path
import argparse,ctypes as C,hashlib,json,time
import numpy as np
from ff import u32p,power,mul,va,vm,Poly
from gmp_poly import install
install()
ROOT=Path(__file__).resolve().parents[1]

def reconstruct(samples,output):
 t=time.time();lib=C.CDLL(str(ROOT/'src/fast_tails.so'));lib.ft_field_hermite.argtypes=[u32p,u32p,C.c_int,u32p]
 sub=np.array([0]+[power(power(25,626),j)for j in range(624)],dtype=np.uint32);offs=vm(sub,np.uint32(25));seen=np.zeros(390625,dtype=np.uint8);data=np.zeros((390625,6),dtype=np.uint32);chunks=[]
 for i,off in enumerate(offs):
  f=Path(samples)/f'{i:03d}.npz';d=np.load(f);assert int(d['offset'])==int(off);v=d['values'];assert v.dtype==np.uint32 and v.shape==(625,6);ns=va(sub,off);assert not seen[ns].any();seen[ns]=1;data[ns]=v;chunks.append(hashlib.sha256(v.astype('<u4').tobytes()).hexdigest())
 assert seen.all();print('COMPLETE_FIELD_HERMITE_DATA',390625,'distinct nodes; two jets each',flush=True)
 vs=data[:,::2].copy().ravel();ds=data[:,1::2].copy().ravel();out=np.zeros((781250,3),dtype=np.uint32);assert lib.ft_field_hermite(vs,ds,3,out.ravel())==1;print('EXACT_HERMITE_INTERPOLATION_SECONDS',round(time.time()-t,3),flush=True)
 fs=[Poly(f)for f in json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']];h=Poly(1)
 for f in fs:
  if f.degree()==1:h=h*f
 assert h.degree()==13
 bounds=json.loads((ROOT/'data/resultant_pole_bounds.json').read_text())['resultants'];arr={};results={}
 for i,n in enumerate((72,73,74)):
  bd=bounds[str(n)]['degree_bound'];assert not out[bd+27:,i].any(),('exceeds certified Hermite bound',n)
  raw=Poly(out[:,i]);p=raw//(h*h);assert p.degree()<=bd;arr[str(n)]=p.a
  results[n]={'degree_bound':bd,'actual_degree':p.degree(),'canonical_sha256':hashlib.sha256(p.a.astype('<u4').tobytes()).hexdigest(),'multiplied_h_square_degree':raw.degree(),'coefficients_above_bound_checked_zero':len(out)-bd-27}
  print('GLOBAL_RESULTANT_RECONSTRUCTED',n,results[n],flush=True)
 Path(output).parent.mkdir(parents=True,exist_ok=True);np.savez_compressed(output,**arr)
 result={'status':'exact whole-curve elimination polynomials reconstructed; this alone is not an emptiness proof','coefficient_field_size':390625,'distinct_field_nodes':390625,'jet_order':2,'hermite_modulus':'(q^390625-q)^2','normalization_h_degree':13,'complete_coset_hashes':chunks,'resultants':results,'seconds':round(time.time()-t,3)}
 (ROOT/'checks/resultant_reconstruction.json').write_text(json.dumps(result,indent=2)+'\n');print('RESULTANT_RECONSTRUCTION_COMPLETE',round(time.time()-t,3),flush=True)
 return arr
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--samples',default=str(ROOT/'scratch/resultant_samples'));p.add_argument('--output',default=str(ROOT/'scratch/global_resultants.npz'));a=p.parse_args();reconstruct(a.samples,a.output)
