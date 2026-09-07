#!/usr/bin/env sage
"""Test/certify projected radial identity modulo the restricted N equations."""
from pathlib import Path
source=Path('scripts/wronskian_linear_syzygy.sage').read_text()
marker='# Precompute every equation (at most128 nonzeros). Unknown order ell[i,r].'
assert source.count(marker)==1
head,tail=source.split(marker)
exec(preparse(head))
grad=json.loads(Path('Research/computations/wronskian_line_gradient.json').read_text())
dual=json.loads(Path('Research/computations/wronskian_serre_dual.json').read_text())
rtensor=json.loads(Path('Research/computations/wronskian_universal_image.json').read_text())
Qc=matrix(k,[parse(row) for row in grad['Qc_matrix']])
S=matrix(k,[parse(row) for row in dual['S_matrix']])
piv=list(Qc.pivots()); inv=Qc.matrix_from_columns(piv).inverse()
proj=S.matrix_from_columns(piv)*inv
Rs=[matrix(k,[parse(row) for row in M]) for M in rtensor['R_tensor']]
RJ=[M*BJ5 for M in Rs]
for i,j in wquad:
    rr=proj.column(i)*RJ[i] if i==j else proj.column(j)*RJ[i]+proj.column(i)*RJ[j]
    wquad[i,j]=rr-2*wquad[i,j]
identical=all(v==0 for v in wquad.values())
print('radial difference identically zero:',identical,flush=True)
# Reuse the exact streamed elimination implementation and its explicit
# coefficient verification, with a distinct destination and statement.
assert tail.count('Research/computations/wronskian_linear_syzygy.json')==1
tail=tail.replace('Research/computations/wronskian_linear_syzygy.json','Research/computations/wronskian_radial_syzygy.json')
tail=tail.replace('Degree-one polynomial row-syzygy sufficient-certificate search only; failure does not imply an atlas','Projected radial difference modulo restricted N; no atlas exclusion')
tail=tail.replace('W(U), unknown','i_proj(R_U e)(U)-2W(U,e), unknown')
tail=tail.replace("data['W_quadratic_coefficients']","data['radial_difference_quadratic_coefficients']")
progress="    if q%512==511: print('equations processed',q+1,'rank',len(pivots),flush=True)"
assert tail.count(progress)==1
tail=tail.replace(progress,progress+'''
    if q>=2047 and q%512==511:
        trial=vector(k,2048)
        for pp in sorted(pivots,reverse=True):
            prow,prhs,pcomb=pivots[pp]
            trial[pp]=prhs-sum(v*trial[h] for h,v in prow.items() if h!=pp)
        if all(sum(c*trial[h] for h,c in erow.items())==erhs for erow,erhs in equations):
            print('Candidate verified against ALL equations; stopping elimination early',flush=True)
            break
''')
tail=tail.replace("Path('Research/computations/wronskian_radial_syzygy.json').write_text", "data['radial_difference_identically_zero']=identical\ndata['projection_matrix']=[enc(row) for row in proj.rows()]\ndata['all16896_coefficient_equations_verified']=bool(witness is None)\nPath('Research/computations/wronskian_radial_syzygy.json').write_text")
exec(preparse(tail))
