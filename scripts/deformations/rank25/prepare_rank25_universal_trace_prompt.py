"""Make trace-only finite inputs; retain full evidence outside the Pro ZIP."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import ast
import hashlib
import io
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import zipfile

from scripts.deformations.rank25 import rank25_pro_data_model as m
from scripts.deformations.rank25.prepare_rank25_one_parameter import pack

ROOT = Path(__file__).resolve().parents[3]
NAME = 'PRO_RANK25_UNIVERSAL_FIFTH_TRACE'

README = '''# Finite inputs for the universal fifth trace

These supplement the self-contained mathematical question. They contain
the already established fourth-level data, not a higher-Witt replay engine.

Field: F5[t]/(t^4+4t^3+t^2+4t+3). A field coefficient is encoded as the
integer a0+5*a1+25*a2+125*a3. This differs from the prompt's four-character
notation a0a1a2a3. Sparse tensors have row-major shape/nonzero records.
algebra.py decodes these to tuples and provides exact field arithmetic.

data.json contains M (75x75), the nine kernel vectors as rows, xi_*, the
trace row, and normal4. The latter is the full canonical75-coordinate
normal polynomial for x7=x8=0:
 constant + sum ordinary[i]*x_i + sum frobenius[i]*x_i^5
          + sum quadratic[i,j]*x_i^5*x_j^5.
It is valid before imposing the two remaining fourth equations. At a
candidate, solving M*zeta^[5]=normal4 gives a compatible fourth digit.
The third-displacement coordinates and every kernel direction retain
their original marking and sign.

first_affine.json contains the actual affine primitive u_U at xi_*, then
its seven coefficient-Frobenius variations: u_U=U_*+sum x_i^5*U_i.
Each [i,j,v_power,u_power,c] means c*w1^i*w2^j*v^v_power*u^u_power.
Its sign is u_U=-affine(rho2); the full regular infinity primitive is
(rho2+u_U)/z^2. These are finite affine polynomials, not truncated tails.

Use algebra.load() to decode both files. Running python3 algebra.py checks
the field, primary ranks, all kernel and trace identities, and primitive
degrees. These finite checks do not evaluate the requested fifth trace.
Coefficient inverse Frobenius a^125 applies only to this finite field.
'''


def main():
    old = ROOT / 'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip'
    with zipfile.ZipFile(old) as archive:
        raw = json.loads(archive.read('data.json'))
        fourth = json.loads(archive.read('fourth.json'))
        first = archive.read('first_repairs.json')
    original = m.unpack(raw)
    payload = {
        'hodge_matrix': raw['hodge_matrix'],
        'kernel_basis': raw['kernel_basis'],
        'primary_repair': raw['primary_repair'],
        'trace_row': pack(original['obstruction_dual_rows'][0]),
        'normal4': fourth['normal_on_candidates'],
    }
    source = (ROOT / 'scripts/deformations/rank25/rank25_pro_data_model.py').read_text()
    tree = ast.parse(source)
    needed = {'digits', 'unpack', 'add', 'neg', 'mul', 'power', 'total', 'mv', 'rank'}
    functions = [ast.get_source_segment(source, n) for n in tree.body
                 if isinstance(n, ast.FunctionDef) and n.name in needed]
    algebra = '''"""Exact finite input arithmetic; no higher inverse-Cartier engine."""
import json
from pathlib import Path
from math import prod
ZERO=(0,0,0,0)
ONE=(1,0,0,0)
\n''' + '\n\n'.join(functions) + '''

def load(directory=None):
    base=Path(directory) if directory else Path(__file__).resolve().parent
    data=unpack(json.loads((base/'data.json').read_text()))
    first=json.loads((base/'first_affine.json').read_text())
    return data, [[(*r[:4],digits(r[4])) for r in row] for row in first]

if __name__=='__main__':
    data,first=load()
    M,N,L=data['hodge_matrix'],data['kernel_basis'],data['trace_row']
    assert power((0,1,0,0),5)==(2,3,0,0)
    assert rank(M)==66 and rank(N)==9
    assert all(mv(M,[power(c,5) for c in row])==[ZERO]*75 for row in N)
    assert mv(list(zip(*M)),L)==[ZERO]*75 and mv(N,L)==[ZERO]*9
    assert len(first)==8
    assert [max(r[0]+r[1] for r in row) for row in first]==[2,0,1,1,2,2,3,3]
    print('PASS: finite-field/rank/kernel/trace identities and actual first-repair degrees.')
'''
    files = {
        'README.md': README.encode(),
        'algebra.py': algebra.encode(),
        'data.json': (json.dumps(payload, separators=(',', ':'))+'\n').encode(),
        'first_affine.json': first,
    }
    with tempfile.TemporaryDirectory(prefix='rank25-trace-input-check-') as path:
        for name, content in files.items():
            (Path(path)/name).write_bytes(content)
        test = subprocess.run([sys.executable, 'algebra.py'], cwd=path,
                              capture_output=True, text=True, timeout=60)
        assert test.returncode == 0, test.stdout+test.stderr
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for name, content in files.items():
            info=zipfile.ZipInfo(name,date_time=(2026,9,12,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            archive.writestr(info, content, compresslevel=9)
    blob=buffer.getvalue()
    assert len(blob)<=20000
    with zipfile.ZipFile(io.BytesIO(blob)) as archive:
        assert archive.testzip() is None
        assert all(archive.read(n)==b for n,b in files.items())
    prompt=(ROOT/f'Research/{NAME}_REQUEST.txt').read_text()
    assert not re.search(r'https?://|sandbox:|/Users/|/mnt/|\]\(',prompt)
    assert 'Put all output\nfiles in one ZIP.' in prompt
    # Check literal direction table against all original coordinates.
    parsed = [[m.ZERO]*75 for _ in range(4)]
    for vector,i,j,*coefficients in re.findall(
            r'^\s+nu([3-6])\s+\((\d),(\d)\)\s+([0-4]{4})\s+([0-4]{4})\s+([0-4]{4})\s*$',prompt,re.M):
        offset=3*(5*int(i)+int(j))
        parsed[int(vector)-3][offset:offset+3]=[tuple(map(int,c)) for c in coefficients]
    assert parsed == original['kernel_basis'][3:7]
    assert 'Lambda0[72:75]=(4420,1200,2000)' in prompt
    assert original['obstruction_dual_rows'][0]==[m.ZERO]*72+[(4,4,2,0),(1,2,0,0),(2,0,0,0)]
    # The two-quadrics table is literal primary output, not a new fit.
    f=m.unpack(fourth)['obstruction']
    terms={(i,j):row for i,j,row in f['quadratic']}
    for rowindex,label in [(1,'F0'),(2,'G0')]:
        line=re.search(r'^\s+'+label+r'\s+((?:[0-4]{4}\s+){5}[0-4]{4})\s*$',prompt,re.M)
        assert line
        actual=[tuple(map(int,c)) for c in line.group(1).split()]
        expected=[f['constant'][rowindex],f['frobenius'][3][rowindex],f['frobenius'][4][rowindex],
                  terms[(3,3)][rowindex],terms[(3,4)][rowindex],terms[(4,4)][rowindex]]
        assert actual==expected,(label,actual,expected)
    target=ROOT/f'Research/{NAME}_INPUTS.zip'
    target.write_bytes(blob)
    receipt={
        'status':'PASS', 'archive':str(target), 'bytes':len(blob),
        'uncompressed_bytes':sum(map(len,files.values())), 'hard_limit_bytes':20000,
        'files':{n:{'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()} for n,b in files.items()},
        'sha256':hashlib.sha256(blob).hexdigest(),
        'source_packet_sha256':hashlib.sha256(old.read_bytes()).hexdigest(),
        'prompt_words':len(prompt.split()),'prompt_bytes':len(prompt.encode()),
        'prompt_sha256':hashlib.sha256(prompt.encode()).hexdigest(),
        'literal_direction_and_quadrics_tables':'PASS against original exact data',
        'isolated_check_output':test.stdout.strip(),
        'omitted':'All reports/logs/archives, prior prompts, fifth replay engines, eight irrelevant dual rows and four-component quotient matrices.',
        'scope':'One absolute fifth trace on the full fourth-lift locus. Candidate universal trace unproved outside the accepted surface.'
    }
    (ROOT/'Research/computations/rank25_universal_trace_prompt_checks.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':
    main()
