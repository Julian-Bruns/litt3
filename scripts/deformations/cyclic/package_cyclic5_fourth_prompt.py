#!/usr/bin/env python3
"""Package the checked cyclic-five prompt and its exact input sources."""
import hashlib
import json
from pathlib import Path
import zipfile


def main():
    root = Path(__file__).resolve().parents[3]
    names = {
        'PROMPT.md': 'Research/requests/cyclic5_fourth_lift_request.md',
        'scripts/deformations/cyclic/prepare_cyclic5_fourth_prompt.py': 'scripts/deformations/cyclic/prepare_cyclic5_fourth_prompt.py',
        'scripts/deformations/cyclic/cyclic5_witt_obstruction.sage': 'scripts/deformations/cyclic/cyclic5_witt_obstruction.sage',
        'scripts/deformations/compute_genus2_w3_obstruction.py': 'scripts/deformations/compute_genus2_w3_obstruction.py',
        'inputs/cyclic5_small_field_fourth_inputs.json': 'Research/computations/cyclic5_small_field_fourth_inputs.json',
        'inputs/cyclic5_small_field_fourth_inputs_p300.json': 'Research/computations/cyclic5_small_field_fourth_inputs_p300.json',
        'reference/neutral5_witt_algebra.py': 'scripts/deformations/cyclic/neutral5_witt_algebra.py',
        'reference/neutral5_gmp_convolution.py': 'scripts/deformations/cyclic/neutral5_gmp_convolution.py',
    }
    a, b = [json.loads((root/names[name]).read_text()) for name in
            ('inputs/cyclic5_small_field_fourth_inputs.json',
             'inputs/cyclic5_small_field_fourth_inputs_p300.json')]
    volatile = {'seconds', 'precision'}
    assert {k:v for k,v in a.items() if k not in volatile} == {
        k:v for k,v in b.items() if k not in volatile}, 'Precision replay mismatch'
    assert [a['precision'],b['precision']] == [220,300]
    assert a['source_sha256'] == hashlib.sha256(
        (root/names['scripts/deformations/cyclic/prepare_cyclic5_fourth_prompt.py']).read_bytes()).hexdigest()
    assert a['helper_sha256'] == hashlib.sha256(
        (root/names['scripts/deformations/cyclic/cyclic5_witt_obstruction.sage']).read_bytes()).hexdigest()
    files = {name:(root/source).read_bytes() for name,source in names.items()}
    prompt = files['PROMPT.md'].decode()
    for name in ('primary_repair','kernel_d','kernel_b','obstruction_dual_rows',
                 'hodge_matrix','trace_matrix'):
        assert name in prompt and name in a
    assert prompt.count('\\[') == prompt.count('\\]')
    assert prompt.count('\\(') == prompt.count('\\)')
    assert '\ufffd' not in prompt and 'sandbox:' not in prompt
    manifest = {
        'format_version':1,
        'scope':'One actual cyclic-five cover; primary geometry and repair plane only. The fourth obstruction is the requested new computation.',
        'precision_replay':'All algebraic fields identical at 220 and 300',
        'files':{name:{'sha256':hashlib.sha256(data).hexdigest(),'bytes':len(data)}
                 for name,data in files.items()},
    }
    target = root/'Research/pro_inputs/cyclic5_fourth_lift_inputs.zip'
    with zipfile.ZipFile(target,'w',compression=zipfile.ZIP_DEFLATED) as archive:
        for name,data in files.items(): archive.writestr(name,data)
        archive.writestr('MANIFEST.json',json.dumps(manifest,indent=2)+'\n')
    with zipfile.ZipFile(target) as archive:
        assert archive.testzip() is None
        for name,data in files.items(): assert archive.read(name) == data
    print(json.dumps(dict(status='PASS packet, hashes, both precisions, prompt fields and delimiters',
                          path=str(target),files=len(files)+1,bytes=target.stat().st_size,
                          sha256=hashlib.sha256(target.read_bytes()).hexdigest(),
                          prompt_words=len(prompt.split())),indent=2))


if __name__ == '__main__':
    main()
