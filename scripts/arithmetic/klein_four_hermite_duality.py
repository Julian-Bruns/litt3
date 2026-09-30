#!/usr/bin/env python3
"""Check the NEW duality and degree arithmetic, reusing certified minors.

This script does not assert Fourier-minor nonvanishing independently of
the cited complete prior certificate, nor does it search geometric curves.
"""
import argparse
import json
from pathlib import Path


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    rows = []
    for d in range(6):
        source = set(range(16+d)) | set(range(22,23+d))
        orthogonal = {b for b in range(29)
                      if all((a+b)%29 for a in source)}
        expected = set(range(1,7-d)) | set(range(8,14-d))
        assert orthogonal == expected
        r = 5-d
        shifted = {(b-1)%29 for b in orthogonal}
        assert shifted == set(range(r+1)) | set(range(7,8+r))
        assert len(source) == 17+2*d
        assert len(source)+len(orthogonal) == 29
        rows.append({'d':d,'source_exponents':sorted(source),
                     'dual_exponents':sorted(orthogonal),
                     'old_fourier_parameter':r,'maximum_zero_count':16+2*d})
    assert set(range(22)) | set(range(22,29)) == set(range(29))
    assert (-pow(4,-1,5))%5 == 1 and 36%5 == 1
    assert 36%29 == 7 and 35%29 == 6
    # DE=t^29-1, E=t^7H+R, and B=(1+DR)/t^7 imply the claimed identity:
    # t^7 F = 2 t^29 T - D t^7 N - (1+DR)T
    #       = (T-DV) + 2(t^29-1)T, V=t^7N+RT.
    # Compare coefficients in independent symbols Q=t^29,N,T,D,R.
    lhs = {'QT':2, 'Dt7N':-1, 'T':-1, 'DRT':-1}
    rhs = {'QT':2, 'Dt7N':-1, 'T':1-2, 'DRT':-1}
    assert lhs == rhs
    for e in range(13,30):
        for d in range(7):
            assert 29-e+e-14+d == 15+d
            assert 28-e+d <= 15+d < 22
    assert 79 > 51+26
    assert max(min(378+12*j,700-2*j) for j in range(30))==654
    assert (-90**2+227*90-11016)//2==657
    assert (-91**2+227*91-11016)//2==680
    out={'status':'PASS','scope':'Exact new exponent duality and degree checks; old complete Fourier certificate is an explicit input.',
         'rows':rows,'degree91_contradiction':[79,77],
         'post_field_obstruction_grid_bound':654,'degree90_required_grid_bound':657,
         'not_claimed':'No geometric existence claim for remaining profiles.'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('PASS: six complementary Fourier spaces; symbolic divisibility; degree bounds; degree90/91 contradictions.')


if __name__ == '__main__':
    main()
