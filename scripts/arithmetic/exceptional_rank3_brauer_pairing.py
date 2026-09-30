#!/usr/bin/env sage-python
"""Check all degree-three 5-Brauer characters of the two perfect triple covers.

Run with Sage. The published GAP Character Table Library is the
classification input; this script does not reconstruct that library.
"""
import argparse
import json
from pathlib import Path
from sage.all import gap


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert str(gap('LoadPackage("ctbllib")'))=='true'
    result=[]
    for name,count in [('3.A6',11),('3.A7',20)]:
        gap.eval(f'tab:=BrauerTable("{name}",5);; rows:=Irr(tab);;')
        degrees=[int(x) for x in gap('List(rows,x->x[1])')]
        assert len(degrees)==count and degrees.count(3)==2
        positions=[i+1 for i,n in enumerate(degrees) if n==3]
        rows=[]
        for pos in positions:
            gap.eval(f'chi:=ValuesOfClassFunction(Irr(tab)[{pos}]);;')
            assert str(gap('GaloisCyc(chi,5)=GaloisCyc(chi,-1)'))=='true'
            coefficients=[[int(c) for c in row] for row in gap('List(chi,x->CoeffsCyc(x,21))')]
            rows.append(dict(position=pos,values=str(gap('chi')),
                             cyclotomic_21_coefficients=coefficients,
                             fifth_galois_equals_dual=True))
        result.append(dict(group=name,all_irreducible_degrees=degrees,
                           regular_class_orders=[int(x) for x in gap('OrdersClassRepresentatives(tab)')],
                           degree_three_rows=rows))
    receipt=dict(status='PASS',characteristic=5,
                 gap_version=str(gap('GAPInfo.Version')),
                 ctbllib_version=str(gap('PackageInfo("ctbllib")[1].Version')),
                 scope='Every degree-three irreducible character of 3.A6 and3.A7 has fifth-coefficient Frobenius equal to its dual. Completeness of the Brauer tables is the cited primary input.',
                 results=result)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS all four degree-three Brauer characters have Frobenius-dual pairing')


if __name__=='__main__':main()
