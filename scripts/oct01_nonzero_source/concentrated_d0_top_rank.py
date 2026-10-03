#!/usr/bin/env python3
"""Exact restricted two-form rank-drop polynomial on the d0 source family."""
import argparse,json,sys
from itertools import combinations
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,monomials
from cubic_extension import CubicExtension
from shifted_concentrated_projection import extended_gcd


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();base=Field(args.work/'cache');bp=Poly(base);e=CubicExtension(base);p=Poly(e)
    top=json.loads((args.work/'data/concentrated_top_compatibility.json').read_text())
    family=json.loads((args.work/'data/concentrated_d0_source_family.json').read_text())
    adapted=json.loads((args.work/'data/adapted_family.json').read_text())
    lookup={tuple(label):i for i,label in enumerate(top['top_labels'])};records=[]
    for item in top['records']:
        source=next(r for r in family['records'] if r['root_K_code']==item['root_K_code'])
        y0=item['y0_extension_code'];nums=source['source_numerators']
        factor=e.div(bp.eval(bp.derivative(adapted['t']),item['root_K_code']),y0)
        new=[p.scale(f,1) for f in item['new_compatibility_coefficients']]
        new=[[e.mul(c,e.power(factor,j)) for j,c in enumerate(f)] for f in new]
        old=[[c] if c else [] for c in top['ordinary_compatibility_coefficients']]
        v=p.scale(nums[13],y0)
        s4=[]
        p0=[]
        for index,scalar in zip((1,2,3,4),(12,1,24,3)):p0=p.add(p0,p.scale(nums[index],scalar))
        s4.append((0,0,p0))
        s4.extend((index,0,nums[index]) for index in range(1,5))
        s4.append((0,1,p.scale(nums[5],e.inv(y0))))
        rows=[]
        for forms in (old,new):
            row=[]
            for kk in range(3):
                value=p.mul(v,forms[lookup[(5,kk,0)]])
                for degree,char,coefficient in s4:
                    value=p.add(value,p.mul(coefficient,forms[lookup[(4,degree+kk,char)]]))
                row.append(value)
            for degree,char in monomials(10):row.append(p.mul(v,forms[lookup[(4,degree,char)]]))
            rows.append(row)
        minors=[p.sub(p.mul(rows[0][i],rows[1][j]),p.mul(rows[0][j],rows[1][i])) for i,j in combinations(range(8),2)]
        gcd=[];multipliers=[[] for _ in minors]
        for i,f in enumerate(minors):
            if not f:continue
            if not gcd:
                scale=e.inv(f[-1]);gcd=p.scale(f,scale);multipliers[i]=[scale]
            else:
                gcd,left,right=extended_gcd(p,gcd,f)
                multipliers=[p.mul(left,c) for c in multipliers];multipliers[i]=p.add(multipliers[i],right)
            if gcd==[1]:break
        total=[]
        for c,f in zip(multipliers,minors):total=p.add(total,p.mul(c,f))
        assert total==gcd and gcd
        excluded=p.mul(p.mul(source['common_denominator'],source['v0_numerator']),source['p4_numerator'])
        remaining=gcd
        while True:
            divisor=p.gcd(remaining,excluded)
            if divisor==[1]:break
            remaining=p.exactdiv(remaining,divisor)
        records.append({'root_K_code':item['root_K_code'],'sheet_suffix':item['sheet_suffix'],
                        'compatibility_rows':rows,'minor_pairs':list(combinations(range(8),2)),
                        'maximal_minors':minors,'maximal_minor_gcd':gcd,'gcd_identity':multipliers,
                        'excluded_H_R_p4_product':excluded,
                        'rank_drop_after_removing_excluded_factors':remaining})
    report={'scope':'exact restricted compatibility rank-drop on the one-parameter concentrated d0 source model',
            'coordinate_order':['m4_1','m4_x','m4_x2','m5_1','m5_x','m5_x2','m5_x3','m5_y'],
            'records':records}
    (args.work/'data/concentrated_d0_top_rank.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps([{key:r[key] for key in ('root_K_code','sheet_suffix')}|
                      {'minor_gcd_degree':len(r['maximal_minor_gcd'])-1,
                       'remaining_rank_drop_degree':len(r['rank_drop_after_removing_excluded_factors'])-1} for r in records]))


if __name__=='__main__':main()
