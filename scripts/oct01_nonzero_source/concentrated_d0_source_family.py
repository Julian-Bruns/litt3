#!/usr/bin/env python3
"""Exact one-parameter d=0,m=12 concentrated source model, including bad slopes."""
import argparse,json,sys
from pathlib import Path
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from shifted_concentrated_projection import extended_gcd


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k)
    data=json.loads((args.work/'data/concentrated_source_ranks.json').read_text())
    records=[]
    for item in data['records']:
        if (item['d'],item['m'])!=(0,12):continue
        pivots=item['pivot_columns'];rows=item['row_echelon']
        assert pivots==list(range(1,18))
        index=pivots.index(13);row=rows[index];H=row[13];R=row[0]
        gcd,a,b=extended_gcd(p,H,R);assert gcd==[1]
        assert p.add(p.mul(a,H),p.mul(b,R))==[1]
        numerators=[[] for _ in range(18)];numerators[0]=H
        for index in reversed(range(17)):
            col=pivots[index];row=rows[index];total=p.mul(row[0],H)
            for cc in range(col+1,18):total=p.add(total,p.mul(row[cc],numerators[cc]))
            numerators[col]=p.exactdiv(p.neg(total),row[col])
        assert numerators[13]==p.neg(R)
        assert all(not f for f in numerators[14:])
        for original in item['polynomial_matrix']:
            total=[]
            for coefficient,number in zip(original,numerators):total=p.add(total,p.mul(coefficient,number))
            assert not total
        assert p.gcd(H,p.derivative(H))==[1]
        records.append({'root_K_code':item['root_K_code'],'source_numerators':numerators,
                        'common_denominator':H,'v0_numerator':p.neg(R),
                        'H_R_bezout_multipliers':[a,b],
                        'p4_numerator':numerators[4],
                        'bad_H_slopes_impossible_with_kappa_one':True,
                        'actual_v_nonzero_requires_R_nonzero':True,
                        'actual_m12_requires_p4_numerator_nonzero':True})
    report={'scope':'exact d0m12 concentrated necessary source family; H=0 boundary excluded by verified HR unit identity, no irreducibility/etaleness claim',
            'coordinate_frame':'P72 normalized source coordinates u_tilde_i=y0^(e_i-1)u_i',
            'records':records,'source_parameters':['eta']}
    (args.work/'data/concentrated_d0_source_family.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps([{key:item[key] for key in ('root_K_code',)}|
                      {'denominator_degree':len(item['common_denominator'])-1,
                       'v_numerator_degree':len(item['v0_numerator'])-1,
                       'p4_numerator_degree':len(item['p4_numerator'])-1,
                       'source_numerator_max_degree':max(len(f)-1 for f in item['source_numerators'])} for item in records]))


if __name__=='__main__':main()
