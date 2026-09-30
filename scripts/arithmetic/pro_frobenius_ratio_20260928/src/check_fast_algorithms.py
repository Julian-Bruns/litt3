"""Bounded exact implementation regressions; not a geometric point search."""
import argparse,json,random,time
from pathlib import Path
from global_curve import QC
from ff import Poly
from half_gcd import xgcd
ROOT=Path(__file__).resolve().parents[1]

def run(save=False):
    t=time.time();rng=random.Random(723525);records=[]
    for n in (33,64,129,257,1000,4000,15000):
        a=Poly([rng.randrange(390625) for _ in range(n)]+[1])
        b=Poly([rng.randrange(390625) for _ in range(max(1,n-7))]+[1])
        common=Poly([rng.randrange(390625) for _ in range(n//3)]+[1])
        aa,bb=a*common,b*common
        q,r=divmod(aa,bb);assert q*bb+r==aa and r.degree()<bb.degree()
        g,s,u=xgcd(aa,bb);assert s*aa+u*bb==g
        assert not aa%g and not bb%g and g==common
        records.append({'input_degree':n,'common_factor_degree':common.degree(),'outcome':'exact division and Bezout passed'})
    out={'status':'passed; bounded arithmetic regressions only','cases':records,'seconds':round(time.time()-t,3)}
    if save:(ROOT/'checks/fast_algorithms.json').write_text(json.dumps(out,indent=2)+'\n')
    print('FAST_ALGORITHMS_SUMMARY_JSON='+json.dumps(out,sort_keys=True),flush=True)
    return out
if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--save-summary',action='store_true');args=ap.parse_args();run(args.save_summary)
