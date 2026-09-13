"""Check the delivered surface packet in isolation and its literal prompt data."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import zipfile

root=Path(__file__).resolve().parents[3]
prompt=root/'Research/requests/rank25_surface_fifth_request.txt'
archive=root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip'
text=prompt.read_text()
assert text.isascii()
assert not re.search(r'https?://|/Users/|sandbox:|\]\(',text)
assert text.count('Put all output files in one ZIP.')==1
assert 'reported but UNPROVED trace expression' in text
assert 'ENTIRE curve s=lambda^(-2) is now proved' in text
assert 's in k and' in text and 'lambda in k*' in text
assert 'FACTORIZED Witt equation' in text
assert 'Xi0+lambda^5*V+(u0+s^5)*nu0' in text
assert archive.stat().st_size<=20000
with tempfile.TemporaryDirectory(prefix='rank25-surface-prompt-') as work:
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        assert sorted(z.namelist())==['README.md','algebra.py','surface.json']
        uncompressed=sum(v.file_size for v in z.infolist())
        z.extractall(work)
    run=subprocess.run([sys.executable,'algebra.py'],cwd=work,check=True,
                       capture_output=True,text=True)
    spec=importlib.util.spec_from_file_location('surface_algebra',Path(work)/'algebra.py')
    alg=importlib.util.module_from_spec(spec);spec.loader.exec_module(alg)
    d=alg.load()
    for label,key,count in [('Xi0','xi_origin',4),('V','direction',6)]:
        vector=[alg.Z]*75
        pattern=rf'^\s+{label}\s+\(([0-4]),([0-4])\)\s+([0-4]{{4}})\s+([0-4]{{4}})\s+([0-4]{{4}})\s*$'
        rows=re.findall(pattern,text,re.M);assert len(rows)==count
        for i,j,a,b,c in rows:
            start=3*(5*int(i)+int(j));vector[start:start+3]=[tuple(map(int,v)) for v in (a,b,c)]
        assert vector==d[key],label
    nu=[alg.Z]*75;nu[:3]=[alg.O,(0,1,0,0),(3,0,3,0)]
    assert nu==d['nu0'] and alg.digits(d['u0'])==(2,1,3,0)
    J={(a,b):M for a,b,M in d['relative_J']}
    K=[[(2,0,1,3),(1,0,4,1)],[(3,2,4,3),(2,2,3,1)]]
    assert [[J[0,25][i][j] for j in (7,8)] for i in (7,8)]==K
    assert alg.add(alg.mul(K[0][0],K[1][1]),
                   alg.mul((4,0,0,0),alg.mul(K[0][1],K[1][0])))!=alg.Z
    for e,M in J.items():
        if e!=(0,25):assert all(M[i][j]==alg.Z for i in (7,8) for j in (7,8))
    L={-75:(1,0,0,3),-25:alg.Z,5:(1,1,0,1),25:(3,3,2,2),75:(2,1,4,4)}
    assert L=={int(e):alg.digits(c) for e,c in d['known_curve_L'].items()}
    G=[alg.Z]*31
    for i,c in {0:(4,3,1,4),16:(3,3,2,3),20:(0,1,2,1),30:(1,2,4,2)}.items():G[i]=c
    assert G==list(map(alg.digits,d['known_curve_G']))
    candidate={(25,50):(3,0,4,0),(0,0):(2,0,1,0)}
    assert candidate=={(i,j):alg.digits(c) for i,j,c in d['candidate_trace_NOT_PROVED']}
    assert alg.digits(d['known_excluded_root']['lambda'])==(3,2,2,2)
    assert list(map(alg.digits,d['known_excluded_root']['quotient']))==[
        alg.Z,alg.Z,(0,4,2,2),(3,0,4,4)]
    trace=[alg.Z]*75;trace[72:]=[(4,4,2,0),(1,2,0,0),(2,0,0,0)]
    assert trace==d['dual'][0]
    assert 'c0=(4+4t+2t^2)*rho[72]+(1+2t)*rho[73]+2*rho[74]' in text
    low=[alg.Z]*75
    for i,v in {0:(3,3,3,3),1:(1,3,2,0),18:(1,1,0,0),19:(0,1,1,0),20:(3,3,3,3)}.items():low[i]=v
    assert low==d['optional_replacement_fourth_digit_10_0']
    assert 'a_low=3+3t+3t^2+3t^3, b_low=1+3t+2t^2.' in text
    assert [v[2] for v in d['filtered_fourth_source_degrees']]==[6,3,7,8,0,4,5,2]
    assert [10,236,1] in d['G_irreducible_factors']
    assert 'lambda^2+(1+2t+4t^2+t^3)*lambda+2t=0' in text
result={
    'status':'PASS','prompt_words':len(text.split()),'prompt_bytes':len(prompt.read_bytes()),
    'prompt_sha256':hashlib.sha256(prompt.read_bytes()).hexdigest(),
    'archive_bytes':archive.stat().st_size,'uncompressed_bytes':uncompressed,
    'archive_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),
    'isolated_packet_run':run.stdout.strip(),
    'checks':['all literal Xi0/V rows and nu0/u0 match finite inputs',
              'K pivot nonzero; lambda exponent and both parameter domains explicit',
              'known scalar data and complete curve-exclusion Bezout checked',
              'literal trace row, quadratic calibration and degree2 replacement checked',
              'candidate trace labeled unproved; no W5 conclusion from one component',
              'three-file ZIP below20000bytes; no paths/links in prompt; one output ZIP'],
}
(root/'Research/computations/rank25_surface_prompt_literal_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
