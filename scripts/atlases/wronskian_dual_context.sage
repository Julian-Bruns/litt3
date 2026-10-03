#!/usr/bin/env sage
"""Dual section and residue constructors used by the complete tensor sieve."""
load('scripts/atlases/wronskian_section_context.sage')
mons192=basis(192); mons64=basis(64); mons320=basis(320)
K40=kernel(mons192)
assert K40.nrows()==64
T40=[poly(row,mons192) for row in K40.rows()]
def power5poly(v): return mul(mul(mul(mul(v,v),v),v),v)
powers=[power5poly(poly(vector(k,[int(h==j) for h in range(len(mons64))]),mons64)) for j in range(len(mons64))]
power_matrix=matrix(k,[coeff(v,mons320) for v in powers]).transpose()
assert power_matrix.rank()==56
theta=1/delta_t
S=matrix(k,[[((tt**e)*expansions[m]*theta)[-1] for m in mons64] for e in target])
assert S.rank()==56
S5=matrix(k,[[c**5 for c in row] for row in S.rows()])
