#!/usr/bin/env python3
"""Verify the partial result. This program does not solve the return equations."""
from pathlib import Path
import argparse,sys,json,hashlib,tempfile,platform
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
import numpy as np,numba
from compute import *
import compute,geometry
from check_certificates import verify_first,verify_scroll_stability,compare_npz
import reduce_return,verify_reduced
from ffpoly import pp
ROOT=Path(__file__).resolve().parent

def hashes():
 f=ROOT/'MANIFEST.sha256'
 if not f.exists():
  print('Manifest not yet present (archive-assembly run).');return
 n=0
 for line in f.read_text().splitlines():
  if not line:continue
  digest,name=line.split('  ',1);p=ROOT/name
  assert p.is_file(),name
  assert hashlib.sha256(p.read_bytes()).hexdigest()==digest,name
  n+=1
 print('SHA-256 manifest:',n,'files PASS',flush=True)

def verify_actual_witnesses(recomputed):
 original=json.loads((ROOT/'data/rank_one_return_maps.json').read_text())
 for a,b in zip(original,recomputed):
  for k in ['xi','kernel','Hom_dimension','matrices']:assert a[k]==b[k],k
  xi=np.array(a['xi'],np.uint8)
  u=geometry.combine([mono(*m) for m in u_keys],xi[:6])
  v=geometry.combine([mono(*m) for m in v_keys],xi[6:])
  eta=np.array([pp([int(c)],5)[0] if c else 0 for c in xi],np.uint8)
  def decode(p):return {(i,j):c for i,j,c in p}
  q=[decode(p) for p in a['common_first_quotient_U']];qq=[decode(p) for p in a['common_second_quotient_U']]
  U=geometry.combine([power(mono(*m),5) for m in u_keys],eta[:6]);V=geometry.combine([power(mono(*m),5) for m in v_keys],eta[6:]);E5=power(e,5)
  qv=[q[0],add(q[1],mul(U,q[0])),add(q[2],mul(E5,q[1]),mul(add(V,mul(U,E5)),q[0]))]
  assert q[0]==mono()
  assert all(all(i>=0 for i,j in p) for p in q)
  assert all(all(3*i+10*j<=d for i,j in p) for p,d in zip(qv,[4,24,-31]))
  assert qq==[power(p,5) for p in q]
  for mat in a['matrices']:
   H=[[decode(p) for p in row] for row in mat['H_U']]
   assert all(H[i][j]==mul(H[i][0],qq[j]) for i in range(3) for j in range(3))
   # The column factor is itself a GLOBAL O(-5O) -> R map,
   # not merely a rational rank-one decomposition.
   col=[H[i][0] for i in range(3)]
   colv=[add(col[0],neg(mul(u,col[1])),neg(mul(v,col[2]))),add(col[1],neg(mul(e,col[2]))),col[2]]
   assert all(all(3*i+10*j<=d for i,j in poly) for poly,d in zip(colv,[4,0,11]))
  assert a['Hom_dimension']==4 and a['all_maps_factor_through_common_negative_line']
 print('At both supplied points every actual F^2R -> R map factors through one O(-5O); all are singular: PASS',flush=True)

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--rebuild',action='store_true',help='also rebuild every coefficient of the large quotient and full-return tensors');ap.add_argument('--hash-only',action='store_true');args=ap.parse_args()
 print('Python',platform.python_version(),'NumPy',np.__version__,'Numba',numba.__version__,flush=True)
 hashes()
 if args.hash_only:return
 for c in range(25):assert power(mono(c=c),25)==mono(c=c)
 assert power(mono(c=5),2)==mono(c=8) # beta^2=beta+3
 # Correct explicit point check (encoded arithmetic).
 assert MUL[MUL[14,14],14]==geometry.evaluate(P,5,0)
 verify_first(rebuild=True);verify_scroll_stability()
 data=np.load(ROOT/'data/hom_tensor.npz');red=np.load(ROOT/'data/reduced_return.npz')
 assert np.array_equal(matmul(red['SA'],data['A']),np.eye(235,dtype=np.uint8));assert not matmul(red['LA'],data['A']).any()
 assert np.array_equal(red['T'],data['T'])
 assert all(len(rref(a)[1])==35 for a in data['T'])
 for j in range(19):
  assert np.array_equal(red['lower_recovery'][j],NEG[matmul(red['SA'],data['B'][j])])
  assert np.array_equal(data['T'][j],matmul(red['LA'],data['B'][j]))
 neg=np.load(ROOT/'data/negative_second.npz')
 assert np.array_equal(matmul(red['SN'],neg['A']),np.eye(116,dtype=np.uint8));assert not matmul(red['LN'],neg['A']).any();assert np.array_equal(red['Q'],neg['Q'])
 print('Constant eliminations of 235 + 116 coefficients: PASS',flush=True)
 with tempfile.TemporaryDirectory(prefix='strict-return-verification-') as tmp:
  tmp=Path(tmp)
  if args.rebuild:
   old=compute.ROOT;compute.ROOT=tmp
   try:compute.build()
   finally:compute.ROOT=old
   fresh=np.load(tmp/'hom_tensor.npz');compare_npz(data,{k:fresh[k] for k in fresh.files})
   print('All quotient-tensor coefficients rebuilt from P,e: PASS',flush=True)
   fresh=reduce_return.build_reduced(output_dir=tmp);compare_npz(red,fresh)
   print('All full-return mixed tensors and evaluation/reconstruction tensors rebuilt: PASS',flush=True)
   old=geometry.ROOT;geometry.ROOT=tmp
   try:geometry.stability_sections()
   finally:geometry.ROOT=old
   assert json.loads((tmp/'stability_sections.json').read_text())==json.loads((ROOT/'data/stability_sections.json').read_text())
   print('Dual stability sections independently rebuilt: PASS',flush=True)
  else:print('Large-tensor coefficient rebuild not requested; use --rebuild for that additional check.',flush=True)
  outcome=verify_reduced.verify(output_path=tmp/'witnesses.json');verify_actual_witnesses(outcome)
 print('PASS: all requested checks completed.',flush=True)
 print('STATUS: PARTIAL. The stable strict-second-return existence decision is unresolved.',flush=True)
if __name__=='__main__':main()
