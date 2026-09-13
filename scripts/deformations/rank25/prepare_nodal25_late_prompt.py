"""Package and check the bounded nodal25 Pro request, without external data."""
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import zipfile

ROOT=Path(__file__).resolve().parents[3]
PROMPT=ROOT/'Research/requests/nodal25_late_descent_request.txt'
ARCHIVE=ROOT/'Research/pro_inputs/nodal25_late_descent_inputs.zip'


def main():
    question=PROMPT.read_text()
    assert not re.search(r'https?://|sandbox:|/Users/|/mnt/|\]\(',question)
    assert question.count('Put all output files in one ZIP.')==1
    assert 'T6=>T4 over the given C3' in question
    assert 'proposed lemma, not an established input' in question
    assert 'not include the earlier W2-to-W3 bootstrap' in question
    for n in range(3,20):
        m=n-1
        assert 2*n>=n+3  # square-zero curve comparison
        assert (2*m<m+3)==(n==3)  # graph square survives exactly here
        assert 2*m+1>=m+3  # first times second repair vanishes
    files={
        'README.md':(ROOT/'Research/notes/deformations/nodal25_late_input_readme.md').read_bytes(),
        'algebra_checks.py':(ROOT/'scripts/deformations/rank25/check_nodal25_late_inputs.py').read_bytes(),
    }
    with zipfile.ZipFile(ARCHIVE,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as out:
        for name,data in files.items():
            info=zipfile.ZipInfo(name,date_time=(2026,9,13,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED
            out.writestr(info,data,compresslevel=9)
    assert ARCHIVE.stat().st_size<=20000
    extracted=sum(map(len,files.values()))
    assert extracted<=20000
    with tempfile.TemporaryDirectory(prefix='nodal25-prompt-') as task_dir:
        with zipfile.ZipFile(ARCHIVE) as src:
            assert set(src.namelist())==set(files)
            assert all(src.read(n)==v for n,v in files.items())
            src.extractall(task_dir)
        env=dict(os.environ,OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1')
        replay=subprocess.run([sys.executable,'algebra_checks.py'],cwd=task_dir,
            env=env,text=True,capture_output=True,timeout=60,check=True)
        assert 'PASS: 24' in replay.stdout and not replay.stderr
    receipt={
        'status':'PASS: scope, literal precision indices, flat packet and isolated replay',
        'prompt_words':len(question.split()),'prompt_bytes':PROMPT.stat().st_size,
        'zip_bytes':ARCHIVE.stat().st_size,'uncompressed_bytes':extracted,
        'members':{n:{'bytes':len(d),'sha256':hashlib.sha256(d).hexdigest()} for n,d in files.items()},
        'prompt_sha256':hashlib.sha256(PROMPT.read_bytes()).hexdigest(),
        'zip_sha256':hashlib.sha256(ARCHIVE.read_bytes()).hexdigest(),
        'isolated_replay':replay.stdout.strip(),
        'claim_boundary':'Input tests are not an all-coefficient algebraic or geometric proof.',
    }
    (ROOT/'Research/computations/nodal25_late_prompt_checks.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':
    main()
