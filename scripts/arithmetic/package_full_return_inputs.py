#!/usr/bin/env python3
"""Small self-contained optional input for the nineteen-coordinate return task."""
from pathlib import Path
import argparse, hashlib, json, zipfile

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / 'scripts/arithmetic/pro_degree6_actual_return_20260924/return/src'

def main():
    p = argparse.ArgumentParser()
    p.add_argument('output', type=Path)
    a = p.parse_args()
    a.output.mkdir(parents=True, exist_ok=True)
    stage = a.output / 'full_return_inputs'
    (stage/'src').mkdir(parents=True, exist_ok=True)
    (stage/'data').mkdir(exist_ok=True)
    for name in ('compute.py','geometry.py','negative_quotient.py'):
        (stage/'src'/name).write_bytes((SOURCE/name).read_bytes())
    (stage/'README.md').write_text('''# Actual rank-three return reconstruction inputs

The accompanying self-contained prompt states the mathematical problem.
These are unchanged previously checked arithmetic and reconstruction sources.
No mixed 19-by-19 tensor, black-box geometric ideal, or field-point bound
is supplied. All coefficients use F25=F5[b]/(b^2-b-3), code a+5b.

Run `python3 verify.py` from this extracted directory. Requirements: Python,
NumPy and Numba (tested with Python3.14.7, NumPy2.3.5, Numba0.65.1).
This verifies source hashes, reconstructs the full quotient matrix T and
negative-line matrix Q, and constructs the19 Serre-dual stability sections.
Outputs are generated in data/. This is input reconstruction, not a solution
of any return locus. geometry.full_column evaluates F25 parameters only;
extend its coefficient ring before making geometric claims.

compute.build constructs the exact constant235-column elimination and T.
negative_quotient.build_negative(25,-1) constructs Q. geometry.full_column
is the direct474-equation actual morphism recovery, and determinant3 gives
its determinant. The prompt inlines the same formulas over arbitrary k.
''')
    (stage/'verify.py').write_text('''from pathlib import Path
import hashlib,json,sys
import numpy as np
root=Path(__file__).resolve().parent
for name,h in json.loads((root/'SHA256.json').read_text()).items():
 assert hashlib.sha256((root/name).read_bytes()).hexdigest()==h,name
sys.path.insert(0,str(root/'src'))
import compute as c
import geometry as g
import negative_quotient as n
c.ROOT.mkdir(exist_ok=True)
T=c.build()
assert T.shape==(19,80,35)
_,_,Q,_,_=n.build_negative(25,-1)
assert Q.shape==(19,43,16)
np.savez_compressed(root/'data/negative_second.npz',Q=Q)
g.stability_sections();g.regression()
print('PASS exact input reconstruction; no geometric return decision asserted.')
''')
    files=sorted([stage/'README.md',stage/'verify.py']+
                 [stage/'src'/n for n in ('compute.py','geometry.py','negative_quotient.py')])
    manifest={str(x.relative_to(stage)):hashlib.sha256(x.read_bytes()).hexdigest() for x in files}
    (stage/'SHA256.json').write_text(json.dumps(manifest,indent=2)+'\n')
    files += [stage/'SHA256.json']
    output=a.output/'full_return_inputs.zip'
    with zipfile.ZipFile(output,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for x in files:z.write(x,'full_return_inputs/'+str(x.relative_to(stage)))
    with zipfile.ZipFile(output) as z:
        assert z.testzip() is None
        uncompressed=sum(i.file_size for i in z.infolist())
    info={'zip':str(output),'compressed_bytes':output.stat().st_size,
          'uncompressed_bytes':uncompressed,'sha256':hashlib.sha256(output.read_bytes()).hexdigest()}
    assert info['compressed_bytes']<=20000
    (a.output/'input_sizes.json').write_text(json.dumps(info,indent=2)+'\n')
    print(json.dumps(info))

if __name__=='__main__':main()
