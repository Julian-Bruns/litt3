#!/usr/bin/env python3
"""Exact constants for the reciprocal-character determinant; no search."""
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).parent/'pro_quadratic_scalar_20260926'))
from field25 import Field

F=Field([5,2,6,7,1])
c=tuple([22,7,9,23]);f=tuple([20,12,13,8])
c2,c3,c4=[F.projection(c,i) for i in [2,3,4]]
f2,f3,f4=[F.projection(f,i) for i in [2,3,4]]
for factors,target in [([c2,f4,f3,c4],9),([c2,c3,f4,f4],8),
                       ([f2,f3,c4,c4],6),([f2,c3,c4,f4],10)]:
    result=F.one
    for v in factors:result=F.mul(result,v)
    assert result==F.scalar(target)
    print('PASS: reciprocal determinant product',target)
assert F.mul(c3,f2)==F.scalar(5) and F.mul(c2,f3)==F.scalar(17)
assert all(v!=F.zero for v in [c2,c3,c4,f2,f3,f4])
print('PASS: all projection factors and both odd determinant constants.')
