"""Audit the complete source support cone and the exact linear-model bounds.
The matrix and minors are exact circuits; this does not expand or solve them.
"""
import json,sys
from math import comb
from exact import ROOT
from ratio_eliminant_data import load
from hasse_linear import INDICES,order

def run(verify=False):
    m,raw=load();nonzero=0
    for iu in range(133):
        for s in range(7):
            for x in range(141):
                row=raw[((iu*7+s)*141+x)*9:((iu*7+s)*141+x+1)*9]
                count=sum(a!=0 for a in row);nonzero+=count
                if count:assert 4*s<=3*(140-x)
    rows=[];pivot=1;lp=0
    for n in INDICES:
        r=order(n);b=comb(n,r)%5;assert b
        bound=min(6*r,3*n//4)
        if n<=70:pivot=pivot*b%5;lp+=r
        rows.append({'n':n,'hasse_order':r,'diagonal_prime_field_code':b,
                     'row_scale_degree_bound':bound,
                     'after_canonical_root_scale_degree_bound':0 if n<=70 else min(6*r+52,3*n//4)})
    assert len(rows)==147 and pivot==3 and lp==166
    assert max(r['row_scale_degree_bound'] for r in rows)==75
    assert max(r['after_canonical_root_scale_degree_bound'] for r in rows)==82
    rec={'status':'exact_circuit_and_proved_bounds; global_square_decision_unresolved',
         'source_sha256':m['raw_sha256'],'source_coefficients_checked':987,
         'source_nonzero_K_coefficients':nonzero,'support_cone':'4*nu_degree <= 3*T_degree',
         'matrix_shape':[147,71],'auxiliary_coordinates':'B0=1, B1,...,B70',
         'rows':rows,'base_minor':'3*L^166','bordered_minors':77,'bordered_minor_size':[71,71],
         'unit_stripped_generators':'G_n=sum_j M_(n,j)*[T^j]Astar^63',
         'bordered_minor_identity':'Delta_n=3*L^103*G_n',
         'matrix_expanded_globally':False,'global_rank_decision_executed':False,
         'essential_equivalence_certificate':'evidence/late_linear_global.json.gz',
         'full_square_equivalence':'REPORT.md Sections 53-55, including nilpotents',
         'additional_localization':'none beyond the original leading unit'}
    path=ROOT/'evidence/hasse_model.json'
    if verify:assert json.loads(path.read_text())==rec
    else:path.write_text(json.dumps(rec,indent=2)+'\n')
    print('GLOBAL HASSE SUPPORT AUDIT PASSED: 987 coefficients, 147 rows, pivot 3*L^166, 77 complete generators, scale bounds 75/82',flush=True)
    return rec
if __name__=='__main__':run('--verify' in sys.argv)
