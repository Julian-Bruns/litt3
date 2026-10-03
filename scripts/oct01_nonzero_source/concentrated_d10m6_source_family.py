#!/usr/bin/env python3
"""Polynomial two-column source module for concentrated d10,m6."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from shifted_concentrated_projection import extended_gcd
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k);data=args.work/'data'
    source=json.loads((data/'concentrated_source_ranks.json').read_text())['records'];out=[]
    for record in source:
        if (record['d'],record['m'])!=(10,6):continue
        pivots=record['pivot_columns'];rows=record['row_echelon'];assert pivots==list(range(1,17))
        last=rows[-1];H,R,C=last[16],last[0],last[17];columns=[]
        for free in (0,17):
            nn=[[] for _ in range(18)];nn[free]=H
            for col,row in reversed(list(zip(pivots,rows))):
                total=[]
                for j in range(18):
                    if j!=col:total=p.add(total,p.mul(row[j],nn[j]))
                nn[col]=p.exactdiv(p.neg(total),row[col])
            for original in record['polynomial_matrix']:
                total=[]
                for coefficient,number in zip(original,nn):total=p.add(total,p.mul(coefficient,number))
                assert not total
            columns.append(nn)
        quotient,remainder=p.divmod(C,H);assert not remainder
        gcd,a,b=extended_gcd(p,H,R);assert gcd==[1] and p.add(p.mul(a,H),p.mul(b,R))==[1]
        out.append({'root':record['root_K_code'],'H':H,'R':R,'C':C,'C_over_H':quotient,'H_R_bezout':[a,b],'kappa_numerators':columns[0],'cy_numerators':columns[1],'boundary_relation':'H*(c3+(C/H)*cy)+R*kappa=0; H=0 impossible for kappa=1','max_degrees':[max(len(f)-1 for f in nn) for nn in columns]})
    (data/'concentrated_d10m6_source_family.json').write_text(json.dumps({'scope':'necessary polynomial source module; H=0 excluded by HR identity with C divisibleH; no realization claim','records':out},separators=(',',':'))+'\n')
    print([(r['root'],len(r['H'])-1,r['max_degrees']) for r in out])
if __name__=='__main__':main()
