"""Recompute all evidence used for the new claims. No network access is required."""
from __future__ import annotations
import gzip
import itertools
import json
from pathlib import Path
import time
import numpy as np
from exact import *
from literal_check import check as literal_check
from controls import determinant, reconstruct, lattice_checks
from support_scan import scan
from prolong import prolong_index, run_scan, matrix_prolong, monomial_tuples
from pure_power_test import run as pure_run
from incidence_search import rand_scan

ROOT=Path(__file__).resolve().parents[1]

def report(message):
 print(message,flush=True)

def field_and_portable_data():
 for a in range(25):
  assert ADD[a,NEG[a]]==0
  if a:assert MUL[a,INV[a]]==1
  q=1
  for _ in range(25):q=int(MUL[q,a])
  assert q==a
  for b in range(25):
   assert ADD[a,b]==ADD[b,a] and MUL[a,b]==MUL[b,a]
   for c in range(25):
    assert MUL[a,ADD[b,c]]==ADD[MUL[a,b],MUL[a,c]]
    assert MUL[MUL[a,b],c]==MUL[a,MUL[b,c]]
 assert MUL[5,5]==8  # beta^2 = beta+3
 assert power(e,25)==frob25(e)
 for m in u_basis+v_basis:assert power(mon(*m),25)==frob25(mon(*m))
 arr=np.load(ROOT/'data/pencils.npz')
 with gzip.open(ROOT/'data/pencils.json.gz','rt',encoding='utf-8') as f:portable=json.load(f)
 assert set(portable['arrays'])==set(arr.files)
 for k in arr.files:
  obj=portable['arrays'][k]
  assert obj['shape']==list(arr[k].shape)
  assert np.array_equal(np.array(obj['entries'],dtype=np.uint8),arr[k]),k
 report('PASS: field arithmetic, actual 25th powers, and portable JSON/NPZ agreement')

def check_minor(A,cert):
 rows=np.array(cert['row_indices'],dtype=int);cols=np.array(cert['column_indices'],dtype=int)
 d=determinant(A[rows][:,cols])
 assert d==cert['determinant'] and d!=0

def check_controls():
 arr=np.load(ROOT/'data/pencils.npz');T,Q=arr['T'],arr['Q']
 c=json.loads((ROOT/'certificates/f_zero_minor.json').read_text())
 check_minor(arr['C'][:152,:123],c);assert rank(arr['C'][:152,:123])==123
 s=json.loads((ROOT/'certificates/stable_control.json').read_text());z=np.array(s['z'],dtype=np.uint8)
 assert s['xi']==s['z']==[1]+[0]*18
 check_minor(pencil(T,z),s['T_minor']);check_minor(pencil(Q,z),s['Q_minor'])
 assert rank(pencil(T,z))==35 and rank(pencil(Q,z))==16
 # Pairing values used in the theoretical, everywhere stability proof.
 u=mon(-1,1)
 assert [mul(u,mon(i,j)).get((-1,2),0) for i,j in [(0,0),(4,0),(0,1)]]==[0,0,1]
 assert P_ROW[-1]==1 and 12*1+4*(-3)==0
 c=json.loads((ROOT/'certificates/excluded_boundary_map.json').read_text());z=np.array(c['z'],dtype=np.uint8);w=np.array(c['w'],dtype=np.uint8)
 assert c['xi']==c['z']
 assert rank(pencil(T,z))==c['rank_T']==33
 assert rank(pencil(Q,z))==c['rank_Q']==14
 assert not mm(pencil(T,z),w.reshape(-1,1)).any()
 H,g0,q0,U,V=reconstruct(z,w)
 assert [[encode(p) for p in row] for row in H]==c['H']
 for key,pol in [('g0',g0),('q0',q0),('U',U),('V',V)]:assert encode(pol)==c[key]
 assert lattice_checks(H,U,V)==c['checks']
 assert c['checks']['generic_rank']==1
 report('PASS: f=0 minor; stable control (0,0); excluded control (2,2), actual map, all lattice bounds, generic rank one')

def verify_support_chain(s):
 T=np.load(ROOT/'data/pencils.npz')['T']
 prev=np.load(ROOT/f'data/support_{s}.npz')
 supp=np.array(list(itertools.combinations(range(35),s)),dtype=np.int16)
 assert np.array_equal(prev['supports'],supp)
 R=scan(T,supp);assert np.array_equal(R,prev['ranks'])
 ok=R[:,0].astype(int)-R[:,1]==13*s
 assert np.array_equal(ok,prev['excluded'])
 report(f'PASS: support {s}, degree 1: {len(supp)} tested, {int(ok.sum())} excluded')
 remaining=supp[~ok]
 prev=np.load(ROOT/f'data/prolong_{s}_2.npz');assert np.array_equal(prev['supports'],remaining)
 idx,nm=prolong_index(s,2);assert np.array_equal(idx,prev['indices'])
 R=run_scan(T,remaining,idx,nm);assert np.array_equal(R,prev['ranks'])
 ok=R[:,0].astype(int)-R[:,1]==13*nm
 assert np.array_equal(ok,prev['excluded'])
 report(f'PASS: support {s}, whole-block degree 2: {len(remaining)} tested, {int(ok.sum())} excluded')
 remaining=remaining[~ok]
 prev=np.load(ROOT/f'data/pure_{s}_2.npz');assert np.array_equal(prev['supports'],remaining)
 upper=monomial_tuples(s,2);pure=np.array([upper.index((i,i)) for i in range(s)],dtype=np.int64)
 assert np.array_equal(prev['indices'],idx) and np.array_equal(prev['pure'],pure)
 flags,R=pure_run(T,remaining,idx,nm,pure)
 assert np.array_equal(R,prev['ranks']) and np.array_equal(flags,prev['flags'])
 ok=np.all(flags,axis=1);assert np.array_equal(ok,prev['excluded'])
 report(f'PASS: support {s}, f-chart degree 2: {len(remaining)} tested, {int(ok.sum())} excluded')
 remaining=remaining[~ok]
 if s==4:
  prev=np.load(ROOT/'data/pure_4_3.npz');assert np.array_equal(prev['supports'],remaining)
  idx,nm=prolong_index(s,3);upper=monomial_tuples(s,3);pure=np.array([upper.index((i,)*3) for i in range(s)],dtype=np.int64)
  assert np.array_equal(prev['indices'],idx) and np.array_equal(prev['pure'],pure)
  flags,R=pure_run(T,remaining,idx,nm,pure)
  assert np.array_equal(R,prev['ranks']) and np.array_equal(flags,prev['flags'])
  ok=np.all(flags,axis=1);assert np.array_equal(ok,prev['excluded'])
  report(f'PASS: support 4, f-chart degree 3: {len(remaining)} tested, {int(ok.sum())} excluded')
  remaining=remaining[~ok]
 assert len(remaining)==0
 report(f'PASS: COMPLETE geometric support-{s} exclusion certificate coverage')
 if s==3:
  # Retained, unnecessary intermediate experiment, independently checked.
  first=np.load(ROOT/'data/prolong_3_2.npz');supp=first['supports'][~first['excluded']]
  saved=np.load(ROOT/'data/prolong_3_3.npz');assert np.array_equal(supp,saved['supports'])
  idx,nm=prolong_index(3,3);R=run_scan(T,supp,idx,nm)
  assert np.array_equal(R,saved['ranks'])
  assert np.array_equal(R[:,0].astype(int)-R[:,1]==13*nm,saved['excluded'])
  report('PASS: retained three-coordinate alternative degree-3 experiment')

def check_failed_full_degree_two():
 T=np.load(ROOT/'data/pencils.npz')['T'];meta=json.loads((ROOT/'data/bases.json').read_text())
 saved=np.load(ROOT/'data/global_degree_two.npz')
 zg=np.empty(19,dtype=np.int64);zg[[0,6,7]]=0;zg[list(range(1,6))+list(range(8,13))]=1;zg[13:]=2
 wg=np.array([(j+(1 if typ=='alpha' else 0))%3 for typ,i,j in meta['w_basis']],dtype=np.int64)
 rg=np.zeros(80,dtype=np.int64)
 for r in range(80):
  grades={(int(zg[z])+int(wg[w]))%3 for z,w in np.argwhere(T[:,r,:])};assert len(grades)==1;rg[r]=grades.pop()
 indices,nm=prolong_index(35,2);upper=monomial_tuples(35,2)
 mg=np.array([sum(wg[i] for i in m)%3 for m in upper],dtype=np.int64)
 cg=np.concatenate([(mg+zg[z])%3 for z in range(19)])
 rr=np.concatenate([(rg+wg[w])%3 for w in range(35)])
 assert np.array_equal(cg,saved['colgrade']) and np.array_equal(rr,saved['rowgrade'])
 M=matrix_prolong(T,np.arange(35),indices,nm);unit=np.zeros(19*nm,dtype=bool);ranks=[]
 for g in range(3):
  rows=np.flatnonzero(rr==g);cols=np.flatnonzero(cg==g);R,p=rref(M[rows][:,cols]);ranks.append(len(p))
  for i in np.flatnonzero(np.count_nonzero(R[:len(p)],axis=1)==1):unit[cols[p[i]]]=True
 assert ranks==saved['ranks'].tolist()==[942,909,949]
 assert np.array_equal(unit,saved['unit']) and not unit.any()
 assert not saved['flags'].any()
 report('PASS: full-space degree-two failed approach reproduced (rank 2800, no monomial row)')

def check_bounded_search():
 arr=np.load(ROOT/'data/pencils.npz');T,Q=arr['T'],arr['Q'];saved=json.loads((ROOT/'data/bounded_scan_0.json').read_text())
 zs=[kernel(T[:,:,j].T)[:,-1] for j in [11,12,28,29]]
 rng=np.random.default_rng(1000);total=0
 for iz,z in enumerate(zs):
  W=kernel(pencil(T,z));coef=rng.integers(0,25,(10000,W.shape[1]),dtype=np.uint8)
  i,w,zz,h=rand_scan(T,Q,W,coef);out=saved[iz]
  assert out['seed']==1000 and out['iz']==iz and out['source']==z.tolist()
  assert out['kernel_dim']==W.shape[1] and out['examined']==int(h.sum())
  assert out['histogram']==h.tolist() and out['hit_index']==int(i)==-1
  total+=int(h.sum())
 assert total==39970
 report('PASS: BOUNDED SEARCH reproduced: 39970 nonzero sampled directions, with possible repetitions; not a geometric decision')

def main():
 start=time.time()
 report('Verification of the distributed partial-result archive')
 field_and_portable_data()
 literal_check()
 check_controls()
 verify_support_chain(3)
 verify_support_chain(4)
 check_failed_full_degree_two()
 check_bounded_search()
 report(f'ALL EXECUTED CERTIFICATE CHECKS PASSED; elapsed {time.time()-start:.2f} seconds')
 report('MAIN DECISION: UNRESOLVED. No stable (1,0) witness or full-window exclusion is certified.')

if __name__=='__main__':main()
