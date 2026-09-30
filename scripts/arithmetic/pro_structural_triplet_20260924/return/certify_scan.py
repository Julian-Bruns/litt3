"""Audit the exhaustive scan results and certify every reported exceptional point."""
from core import *
from scan_f25 import rank_fast
from collections import Counter
import json

def main():
 data=json.loads((ROOT/'data'/'f25_scan.json').read_text())
 assert data['complete'] and data['point_count']==sum(25**i for i in range(6))==10172526
 assert sorted(c['chart'] for c in data['charts'])==list(range(6))
 assert all(c['points']==25**(5-c['chart']) for c in data['charts'])
 hits=data['hits'];assert len(hits)==677 and len({tuple(h[:6]) for h in hits})==677
 distribution=Counter();nscroll=0;rank14=[]
 for h in hits:
  v=np.array(h[:6],np.uint8);j=next(i for i,x in enumerate(v) if x);assert v[j]==1
  rt=len(F.rref(lin(EQ['T'],v))[1]);rq=len(F.rref(lin(EQ['Q'],v))[1])
  assert [rt,rq]==h[6:]
  assert rank_fast(lin(EQ['T'],v))==rt and rank_fast(lin(EQ['Q'],v))==rq
  assert rt<14 or (rt==14 and rq<9)
  if rt==14:rank14.append(h[:6])
  nscroll+=on_scroll(v);distribution[(rt,rq)]+=1
 assert nscroll==676 and rank14==[[1,10,15,16,5,8]]
 rng=np.random.default_rng(260924)
 for _ in range(2000):
  v=rng.integers(0,25,6,dtype=np.uint8);t=lin(EQ['T'],v)
  assert rank_fast(t)==len(F.rref(t)[1])
 out={'status':'PASS','scope':'All stable F25-rational parameters, with morphism coefficients allowed in the full algebraic closure.',
 'point_count':10172526,'rank_15_points':10171849,'rank_drop_points':677,
 'rank_pair_counts':[{'T':a,'Q':b,'count':n} for (a,b),n in sorted(distribution.items())],
 'scroll_points_among_hits':nscroll,'unique_rank_14_point':rank14[0],
 'stable_strict_second_returns':0,'geometric_full_P5_decision':'NOT DECIDED',
 'proof':'A stable return is invariant, forces invariant quotient kernel dimension exactly one (rank T=14), and forces the invariant negative-line kernel zero (rank Q=9). No enumerated point meets both.',
 'independent_rank_checks':{'all_exceptional_points':677,'seeded_additional_parameters':2000}}
 (ROOT/'certificates'/'f25_exclusion.json').write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps(out,indent=2),flush=True)
if __name__=='__main__':main()

