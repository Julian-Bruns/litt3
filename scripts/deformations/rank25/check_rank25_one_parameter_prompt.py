"""Check the raw plain-text prompt against its actual finite inputs."""
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import tempfile
import zipfile

root=Path(__file__).resolve().parents[3]
prompt=root/'Research/requests/rank25_one_parameter_request.txt'
text=prompt.read_text()
assert text.isascii()
assert not re.search(r'https?://|/Users/|sandbox:|\]\(',text)
assert text.count('Put all output files in one ZIP archive.')==1
assert 'Compute only L.' in text and 'other residual functions' in text
assert 'lambda^5*V' in text and 'lambda^(-10)' in text
archive=root/'Research/pro_inputs/rank25_one_parameter_inputs.zip'
assert archive.stat().st_size<=20000
with tempfile.TemporaryDirectory(prefix='rank25-plain-prompt-') as work:
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        assert sorted(z.namelist())==['README.md','algebra.py','inputs.json']
        z.extractall(work)
        uncompressed=sum(i.file_size for i in z.infolist())
    spec=importlib.util.spec_from_file_location('one_parameter_algebra',Path(work)/'algebra.py')
    alg=importlib.util.module_from_spec(spec);spec.loader.exec_module(alg)
    d=alg.load(work)
    for label,key in [('Xi0','xi_origin'),('V','direction')]:
        vector=[alg.ZERO]*75
        pattern=rf'^\s+{label}\s+\(([0-4]),([0-4])\)\s+([0-4]{{4}})\s+([0-4]{{4}})\s+([0-4]{{4}})\s*$'
        rows=re.findall(pattern,text,re.M)
        assert len(rows)==(4 if label=='Xi0' else 6)
        for i,j,a,b,c in rows:
            start=3*(5*int(i)+int(j));vector[start:start+3]=[tuple(map(int,v)) for v in (a,b,c)]
        assert vector==d[key],label
    omega=[alg.ZERO]*75
    rows=re.findall(r'^\s+\(([0-4]),([0-4])\)\s+([0-4]{4})\s+([0-4]{4})\s+([0-4]{4})\s*$',text,re.M)
    assert len(rows)==6
    for i,j,a,b,c in rows:
        start=3*(5*int(i)+int(j));omega[start:start+3]=[tuple(map(int,v)) for v in (a,b,c)]
    assert omega==d['dual_row']
    nu=[alg.ZERO]*75;nu[:3]=[alg.ONE,(0,1,0,0),(3,0,3,0)]
    assert nu==d['nu0']
    assert alg.digits(d['u0'])==(2,1,3,0)
    assert alg.digits(d['known_at_lambda1']['L'])==(2,0,1,0)
result={
    'status':'PASS','prompt':str(prompt),'words':len(text.split()),'bytes':len(text.encode()),
    'prompt_sha256':hashlib.sha256(prompt.read_bytes()).hexdigest(),
    'input':str(archive),'input_bytes':archive.stat().st_size,'uncompressed_bytes':uncompressed,
    'input_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),
    'checks':['plain ASCII without mathematical Markdown escapes','all Xi0/V/Omega entries parsed and compared',
              'nu0, constant, lambda powers and known value','three-file ZIP integrity and hard size cap',
              'one scalar only; vanishing not asserted sufficient for W5; one output ZIP'],
}
(root/'Research/computations/rank25_one_parameter_prompt_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
