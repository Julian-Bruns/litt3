#!/usr/bin/env python3
"""Regression tests for algebraic boundary handling; not geometric witnesses."""
from unittest.mock import patch
import structural_field as F
import moment_linearization as M

def point_test(a,b,c,d):
    # Supply a synthetic normalized determinant solely to exercise generic
    # vector-zero handling. This is NOT asserted to come from endpoint labels.
    synthetic=(a,b,c,d,F.F0,[],[])
    with patch.object(M,'data',return_value=synthetic):
        return M.test_point([0]*4,[0]*4,[0]*4)

def main():
    q=point_test(F.F0,F.F0,F.F0,F.F0)
    assert q['valid_nonzero_scale'] and not q['scale_unique']
    assert not point_test(F.F0,F.F0,F.F1,F.F0)['valid_nonzero_scale']
    assert not point_test(F.F1,F.F0,F.F0,F.F0)['valid_nonzero_scale']
    q=point_test(F.F1,F.F0,F.F1,F.F0)
    assert q['valid_nonzero_scale'] and q['scale_unique'] and q['epsilon']==F.F1
    q=M.analyze([0,29,58,87],[0,29,58,87])
    assert q['rank']==1 and q['status']=='affine_quadric_retained'
    try:M.sums([116,0,0,0])
    except ValueError:pass
    else:raise AssertionError('invalid endpoint label was not rejected')
    print('PASS: zero-left, zero-right, both-zero and unique-nonzero-scale cases retained correctly')
    print('PASS: lower-rank balanced affine quadric retained; invalid label rejected')
    print('SCOPE: generic software boundary tests, not new geometric claims')
if __name__=='__main__':main()
