#!/usr/bin/env python3
"""Independent Gaussian check of the two maximal minors in each unit identity."""
import argparse,json,sys
from pathlib import Path
import numpy as np
ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly
from cubic_extension import CubicExtension


def numeric_determinant(e,array):
    a=np.array(array,dtype=np.uint64,copy=True);value=1
    for j in range(len(a)):
        rows=np.flatnonzero(a[j:,j])
        if not len(rows):return 0
        row=j+int(rows[0])
        if row!=j:a[[j,row]]=a[[row,j]];value=e.neg(value)
        pivot=int(a[j,j]);value=e.mul(value,pivot)
        a[j]=e.mulv(a[j],e.inv(pivot))
        rows=np.flatnonzero(a[j+1:,j])+j+1
        if len(rows):
            factors=e.mulv(a[rows,j],4)
            a[rows]=e.addv(a[rows],e.mulv(factors[:,None],a[j][None,:]))
    return value


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();e=CubicExtension(Field(args.work/'cache'));p=Poly(e);records=[]
    for suffix in ('','_sheet1','_sheet2'):
        data=json.loads((args.work/'data'/('shifted_concentrated_projection'+suffix+'.json')).read_text())
        for item in data['records']:
            matrix=item['polynomial_matrix'];used=[i for i,f in enumerate(item['gcd_identity_multipliers']) if f]
            assert used==[0,1]
            for omitted in used:
                minor=matrix[:omitted]+matrix[omitted+1:]
                # A coarse determinant degree bound is nine times the maximum
                # entry degree, at most 27. Twenty-eight distinct values prove
                # the two polynomial determinants, not just sampled ranks.
                assert max(len(f)-1 for row in minor for f in row)<=3
                expected=item['maximal_minors_by_omitted_row'][omitted]
                assert len(expected)-1<=27
                for slope in range(28):
                    numeric=[[p.eval(f,slope) for f in row] for row in minor]
                    assert numeric_determinant(e,numeric)==p.eval(expected,slope)
            identity=[]
            for coefficient,minor in zip(item['gcd_identity_multipliers'],item['maximal_minors_by_omitted_row']):
                identity=p.add(identity,p.mul(coefficient,minor))
            assert identity==[1]
            records.append({'sheet_suffix':suffix,'root_K_code':item['root_K_code'],
                            'verified_maximal_minors':used,'distinct_values':28,
                            'degree_bound':27,'unit_identity_verified':True})
    output={'scope':'polynomial unisolvence verifies determinant identities, then literal Bezout product verifies unit ideal',
            'checks':records,'outcome':'PASS'}
    (args.work/'data/shifted_concentrated_minors_verification.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
    print(json.dumps({'outcome':'PASS','endpoint_records':len(records),'exact_determinant_values':len(records)*2*28}))


if __name__=='__main__':main()
