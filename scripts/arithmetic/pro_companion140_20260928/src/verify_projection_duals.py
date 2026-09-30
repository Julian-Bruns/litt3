"""Check degree-bound dual witnesses using only integer arithmetic.

This verifies the determinant valuation/degree step independently of the
native assignment algorithm. Source-to-coefficient valuations are checked
by the separate exact global reconstruction and valuation replay.
"""
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent

def run():
    data=json.loads((ROOT/'data/projection_bounds.json').read_text())
    cert=json.loads((ROOT/'data/projection_duals.json').read_text())
    seen=set();sums={}
    for z in cert['duals']:
        pair,place,sheet=z['pair'],z['place'],z['sheet']
        assert (pair,place,sheet) not in seen;seen.add((pair,place,sheet))
        vals=data['infinity_coefficient_valuations'] if place<0 else data['places'][place]['coefficient_valuations']
        f,g=vals[0][sheet],vals[pair+1][sheet];m,n=len(f)-1,len(g)-1
        u,v=z['row_potentials'],z['column_potentials'];assert len(u)==len(v)==m+n
        for i in range(n):
            for j,w in enumerate(f):
                if w<100000000:assert u[i]+v[i+m-j]<=w
        for i in range(m):
            for j,w in enumerate(g):
                if w<100000000:assert u[n+i]+v[i+n-j]<=w
        assert sum(u)+sum(v)==z['lower_bound']
        sums[pair,place]=sums.get((pair,place),0)+z['lower_bound']
    for pair in range(2):
        degree=0
        for place in range(-1,len(data['places'])):
            sheets=2 if place<0 or data['places'][place]['kind']!=2 else 1
            assert all((pair,place,s) in seen for s in range(sheets))
            expected=data['infinity_valuation_bounds'][pair] if place<0 else data['places'][place]['norm_resultant_valuation_bounds'][pair]
            assert sums[pair,place]==expected
            degree-=expected*(1 if place<0 else len(data['places'][place]['modulus'])-1)
        assert degree==data['projected_degree_bounds'][pair]
    print(json.dumps({'independent_integer_dual_checks':'PASS','dual_count':len(seen),'projected_degree_bounds':data['projected_degree_bounds']}))
if __name__=='__main__':run()
