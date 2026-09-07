"""Write every distinct oper index, without repeatedly expanding huge fields.

Each index is an exact algebraic tuple via the shared formulas in the README,
not a numerical approximation. All finite-field and cubic choices are explicit.
"""
import json
from pathlib import Path

root=Path(__file__).resolve().parents[1]
folder=root/'Research/computations'
factors=json.loads((folder/'normalized_oper_closed_points.json').read_text())['factors']
old=json.loads((folder/'invariant_oper_solutions.json').read_text())
assert len(old['solutions'])==55
points=[]
for i,point in enumerate(old['solutions']):
    points.append({'id':f'invariant_{i:02d}','invariant_row':i,'multiplicity':8})
for factor in factors:
    assert factor['multiplicity']==1 and factor['degree_F5']==2*factor['degree_F25']
    for j in range(factor['degree_F25']):
        for branch in range(3):
            points.append({'id':f'{factor["id"]}_{j:04d}_{branch}',
                'orbit':factor['id'],'frobenius_exponent':j,'cubic_branch':branch,'multiplicity':1})
assert len(points)==28990 and len({point['id'] for point in points})==28990
assert sum(point['multiplicity'] for point in points)==29375
result={
    'status':'complete_exact_algebraic_list; multiplicities retained',
    'distinct_points':28990,'total_multiplicity':29375,
    'normalized_closed_points':'normalized_oper_closed_points.json',
    'coordinate_polynomials':'normalized_oper_algebra_certificate.json',
    'invariant_points':'invariant_oper_solutions.json',
    'formula_conventions':'complete_oper_solutions_README.md',
    'points':points}
(folder/'complete_oper_solutions.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
print(f'Exported {len(points)} distinct exact tuple indices; total multiplicity29375; no repeated field expansions.')
