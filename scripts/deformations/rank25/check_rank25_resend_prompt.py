"""Check newly inlined mathematical inputs; this does not calculate W5."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import hashlib
import json
from pathlib import Path
import re

from scripts.deformations.rank25.analyze_rank25_w4_germ import ZERO, ONE, elt, add, mul, power, rank
from scripts.deformations.rank25.check_rank25_fifth_return_and_family import mv

root=Path(__file__).resolve().parents[3]
p=root/'Research/requests/rank25_all_fifth_lifts_request.md'
s=p.read_text()
d=json.loads((root/'Research/computations/rank25_small_field_fourth_inputs.json').read_text())
assert not re.search(r'https?://|\]\(|reference/|inputs/|scripts/|\.(?:json|zip|py|md)\b',s)
for a,b in [(r'\[',r'\]'),(r'\(',r'\)')]:assert s.count(a)==s.count(b)
assert re.findall(r'\\begin\{([^}]+)\}',s)==re.findall(r'\\end\{([^}]+)\}',s)

# Parse the actual printed tables, not their generating code.
recovered={}
for n in range(3,7):
    marker=rf'For \(\nu_{n}\):'
    body=s.split(marker,1)[1].lstrip().split('\n\n',1)[0]
    v=[ZERO]*75
    for i,j,a,b,c in re.findall(r'\| ([0-4]),([0-4]) \| ([0-4]{4}) \| ([0-4]{4}) \| ([0-4]{4}) \|',body):
        start=3*(5*int(i)+int(j))
        v[start:start+3]=[tuple(map(int,x)) for x in (a,b,c)]
    assert v==[elt(x) for x in d['kernel_basis'][n]],n
    recovered[n]=v

# Independently expand the compact q0, w*q0, w2*q0 and xi_* formulas.
t=(0,1,0,0)
q=[ONE,t,(3,0,3,0)]
for n,blocks in [(0,{(0,0):ONE}),(1,{(1,0):ONE,(0,1):t}),(2,{(0,1):ONE})]:
    v=[ZERO]*75
    for (i,j),a in blocks.items():v[3*(5*i+j):3*(5*i+j)+3]=[mul(a,c) for c in q]
    assert v==[elt(x) for x in d['kernel_basis'][n]],n
    recovered[n]=v
xi=[ZERO]*75
xi[:3]=[(3,2,4,2),(4,0,1,4),ZERO]
c=[(4,3,4,0),(0,4,3,4),(1,1,2,1)]
for (i,j),a in { (2,0):ONE,(1,1):mul(elt(2),t),(0,2):power(t,2)}.items():
    xi[3*(5*i+j):3*(5*i+j)+3]=[mul(a,b) for b in c]
assert xi==[elt(x) for x in d['primary_repair']]
M=d['hodge_matrix']
assert mv(M,[power(a,5) for a in xi])==[elt(a) for a in d['base_reference_rho']]
assert rank(list(recovered.values()))==7
for v in recovered.values():assert mv(M,[power(a,5) for a in v])==[ZERO]*75
assert mul((2,0,1,0),(3,2,2,3))==ONE
assert power(t,5)==(2,3,0,0)
assert max(sum(d['basis_indices'][i][:2]) for v in recovered.values() for i,a in enumerate(v) if a!=ZERO)==3
assert 'Put all output files in one ZIP archive.' in s
assert 's=0' in s and 'outside the requested theorem' in s
result={'status':'PASS','scope':'Inline tables, actual primary repair and seven kernel vectors; no file links; delimiters; one output ZIP. New open target and candidate/established distinction reviewed.',
        'prompt_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'words':len(s.split()),
        'kernel_vectors_compared':7,'primary_repair_coordinates_compared':75,
        'new_W5_computation':'Separate bounded geometric point replay recorded in rank25_two_family_returns_checks.json; this script is only an input check.',
        'self_contained_math_review':'Base/cover/C2 and twist explicit; Psi plus Cech reduction reconstructs M; all9 fourth directions eliminated; open q!=0 target, boundary excluded from claimed scope; trace candidate not assumed.'}
print(json.dumps(result,indent=2))
(root/'Research/computations/rank25_resend_inline_checks.json').write_text(json.dumps(result,indent=2)+'\n')
