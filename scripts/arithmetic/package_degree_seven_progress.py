#!/usr/bin/env python3
"""Package the new local recognition results, without creating a Pro request."""
from pathlib import Path
import hashlib
import json
import shutil
import zipfile

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT.parent/'litt3-computation-data/degree_six_actual_return_20260924'
OUT = EVIDENCE/'deliverables'
OUT.mkdir(exist_ok=True)
DEST = OUT/'degree_seven_local_results'
DEST.mkdir(exist_ok=True)

def copy(src, dst):
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src,dst)

names = ['degree_seven_new_line_recognition',
         'degree_seven_genus_one_comparison_exclusion',
         'new_line_degree_six_genus_bound',
         'degree_six_new_line_models', 'new_line_comparison_normal_form',
         'new_line_low_pole_reconstruction']
for name in names:
    p=ROOT/'Theorems/cartier_and_spin'/f'{name}.md'
    copy(p,DEST/p.relative_to(ROOT))
proofs = ['degree_seven_rational_comparison_exclusion',
          'degree_seven_genus_one_comparison_exclusion',
          'new_line_degree_six_genus_bound','pole_degree_six_contact_polynomial',
          'degree_six_tensor_exclusion','degree_six_new_line_models',
          'new_line_comparison_normal_form','new_line_low_pole_reconstruction']
for name in proofs:
    p=ROOT/'Proofs/cartier_and_spin'/f'{name}.md'
    copy(p,DEST/p.relative_to(ROOT))
for genus in [0,1]:
    for name in [f'degree7_genus{genus}_boundary.cpp',
                 f'verify_degree7_genus{genus}_reference.py',
                 f'audit_degree7_genus{genus}_formulas.py']:
        p=ROOT/'scripts/arithmetic'/name
        copy(p,DEST/p.relative_to(ROOT))
shared=Path('scripts/arithmetic/pro_degree6_actual_return_20260924/degree6/src')
for name in ['genus0_boundary.cpp','boundary_input.hpp','reference_field.py','ff25.py']:
    copy(ROOT/shared/name,DEST/shared/name)
copy(EVIDENCE/'runs/degree6/data/boundary_input.json',DEST/'data/boundary_input.json')
local=EVIDENCE/'local'
files=['degree7_genus1_boundary.bin','degree7_genus1_exhaust.log',
       'degree7_genus1_final_replay.log','degree7_genus1_reference.json',
       'degree7_genus1_reference.log','degree7_genus1_formula_audit.log',
       'degree7_genus0_reference.json','degree7_genus0_reference.log',
       'degree7_genus0_formula_audit.log']
for j in range(4):
    files += [f'degree7_genus0_final_j{j}.bin',f'degree7_genus0_final_j{j}.log',
              f'degree7_genus0_replay_j{j}.log']
for name in files:
    copy(local/name,DEST/'evidence'/name)
copy(ROOT/'Research/audits/DEGREE_SIX_ACTUAL_RETURN_FOCUSED_2026_09_24.md',
     DEST/'Research/audits/DEGREE_SIX_ACTUAL_RETURN_FOCUSED_2026_09_24.md')

report=r'''# Local recognition progress, 24 September 2026

The original unmarked common-cover problem is UNSOLVED. This archive is
a results packet, not a follow-up request or a submission.

## Completed new results

1. Two actual finite etale maps from the SAME smooth proper source to
the fixed genus-nine X, sharing its specified Cartier line or tensor,
recognize the same embedded X-field in every covering degree at most
seven. The new degree-seven proof excludes both possible simultaneous
quotient genera, zero and one.
2. On the ENTIRE comparison-pole-degree-six branch, the minimal
common-pole denominator D gives a NONZERO polynomial
d-epsilon*s^7*b divisible by D_red. If u counts double roots of D,
the quotient genus satisfies g<=u+9<=9+floor((n-6)/3)<=38.
If D is squarefree, g<=9. The potentially exceptional zero polynomial
is excluded by the full quartic equation and unique simple formal root,
not by a finite computation or assumed divisor descent.

These are conditional recognition results, not an extraction of a
shared tensor from an arbitrary unmarked span. Higher-degree comparison
models, the actual stable strict-second-return problem, and the original
common-cover problem remain unresolved.

## Endpoint and mathematical inputs

The characteristic is five and k is an algebraic closure. Coefficients
[a+5b] mean a+b*beta in F25, beta^2-beta-3=0. In ascending order,
P=(11,22,18,5,19,20,15,16,9,22,1) and A=(1,21,14,22,13).
The endpoint is X:y^3=P(x), with its unique infinity point O,
theta=dx/y^2, and tau=A(x)^16*theta^13. The specified embedded
Cartier line is the saturated line of a primitive f with df=A^2*theta.

The earlier established inputs, explicitly separated from the new work,
are the exact line/tensor normal form, recognition through degree six,
the entire comparison-pole-degree-three exclusion, and reconstruction
of both actual maps. For distinct jointly minimal fields, the comparison
function s has pole degree d in the semigroup <3,10>, d<=n, and
n<=d+29*floor(d/2). When d=6 the simultaneous cubic quotient S has
k(S)=k(s,x_1)=k(s,x_2), degree two over k(s), unramified at zero and
infinity. Its common pole divisor has degree n-6; the polynomial
denominator has exponents one or two at at most29 normalized values.
The two-end constants and their exact finite-field rows are included.
The supporting proof copies spell out these inputs; their older full
certificate archives are not duplicated here or represented as new work.

## Claim-to-evidence index

| Claim | Human-readable proof | Executed evidence |
|---|---|---|
| No elliptic quotient in degree seven | Proofs/cartier_and_spin/degree_seven_genus_one_comparison_exclusion.md | Complete 6,356,452-case record and replay; independent 1,115 records including all726 final cases; 12 symbolic identities |
| No rational quotient in degree seven | Proofs/cartier_and_spin/degree_seven_rational_comparison_exclusion.md | Four full partitions, total6,468,160; independent1,778 records including all958 exceptional contacts; nine symbolic identities |
| Recognition through degree seven | Theorems/cartier_and_spin/degree_seven_new_line_recognition.md | The two exclusions plus exact joint-minimal reduction and prior lower-degree result |
| Genus bound38 on the whole pole-degree-six branch | Proofs/cartier_and_spin/pole_degree_six_contact_polynomial.md | Geometric proof: common-pole divisibility on all sheets, certified H-value injectivity, and simple-root formal uniqueness |

All 958 rational contact configurations already fail the opposite-sheet
equation. Optional missing-pole and squarefreeness filters in the native
source are not needed. Ramified common poles and zero endpoint leading
differences are retained. The finite records cover forced discrete
boundary choices; continuous coefficients are excluded over the algebraic
closure by polynomial gcds, not searched in a bounded finite field.

## Reproduction

Run python3 verify.py from this directory. It checks every retained hash,
compiles the C++17 programs, fully replays all native records, runs the
symbolic audits, and performs both independent arithmetic checks.
Requirements: a C++17 compiler, Python with SymPy, and SageMath 10.9
or compatible. --native-only skips the independent and symbolic checks
and reports that reduced scope. No assertions may be disabled.

The local executed environment was Apple clang21, Python3.14.7 with
SymPy1.14.0, and Sage10.9. All native complete replays passed. No GPU,
floating-point rank test, new subagent, automatic submission, or external
message was used. Logs and exact check counts are in evidence/.

Canonical source files are copied with their workspace paths. Some
historical links inside supporting proof copies refer to the research
workspace; the claim-to-evidence table above and the included verifier
identify the complete new evidence in this archive.
'''
(DEST/'README.md').write_text(report)
verifier=r'''#!/usr/bin/env python3
import argparse, concurrent.futures, hashlib, json, os
from pathlib import Path
import shutil, subprocess, sys
p=argparse.ArgumentParser()
p.add_argument('--native-only',action='store_true')
args=p.parse_args()
root=Path(__file__).resolve().parent
os.chdir(root)
manifest=json.loads((root/'MANIFEST.json').read_text())
for name,info in manifest.items():
    b=(root/name).read_bytes()
    assert len(b)==info['bytes'] and hashlib.sha256(b).hexdigest()==info['sha256'],name
print('All retained hashes match',flush=True)
build=root/'replay';build.mkdir(exist_ok=True)
cc=os.environ.get('CXX',shutil.which('c++'))
assert cc,'C++17 compiler is required'
def run(cmd,log):
    with open(build/log,'w') as f:
        subprocess.run([str(x) for x in cmd],stdout=f,stderr=subprocess.STDOUT,check=True)
    print('PASS',log,flush=True)
for g in [0,1]:
    run([cc,'-O3','-std=c++17',f'scripts/arithmetic/degree7_genus{g}_boundary.cpp',
         '-o',build/f'g{g}'],f'compile_g{g}.log')
run([build/'g1','--verify','0','evidence/degree7_genus1_boundary.bin'],'g1_complete.log')
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    futures=[pool.submit(run,[build/'g0','--verify-j',j,
              f'evidence/degree7_genus0_final_j{j}.bin'],f'g0_complete_j{j}.log') for j in range(4)]
    for f in futures:f.result()
if not args.native_only:
    for g in [0,1]:
        run([sys.executable,f'scripts/arithmetic/audit_degree7_genus{g}_formulas.py'],f'g{g}_symbolic.log')
    run([sys.executable,'scripts/arithmetic/verify_degree7_genus1_reference.py',
         '--data','data/boundary_input.json','--certificate','evidence/degree7_genus1_boundary.bin',
         '--output',build/'g1_reference.json'],'g1_reference.log')
    sage=shutil.which('sage');assert sage,'SageMath is required for independent absolute-field check'
    run([sage,'-python','scripts/arithmetic/verify_degree7_genus0_reference.py',
         '--data','data/boundary_input.json','--directory','evidence',
         '--output',build/'g0_reference.json'],'g0_reference.log')
print('PASS:', 'hashes and complete native replays only' if args.native_only else
      'hashes, complete native replays, symbolic audits and independent checks')
'''
(DEST/'verify.py').write_text(verifier)
manifest={}
for p in sorted(DEST.rglob('*')):
    if p.is_file() and p.name!='MANIFEST.json' and 'replay' not in p.relative_to(DEST).parts:
        b=p.read_bytes();manifest[str(p.relative_to(DEST))]={'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
(DEST/'MANIFEST.json').write_text(json.dumps(manifest,indent=2)+'\n')
archive=OUT/'degree_seven_local_results.zip'
with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for name in [*manifest,'MANIFEST.json']:
        z.write(DEST/name,'degree_seven_local_results/'+name)
info={'archive':str(archive),'compressed_bytes':archive.stat().st_size,
      'uncompressed_bytes':sum(i['bytes'] for i in manifest.values())+(DEST/'MANIFEST.json').stat().st_size,
      'sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),'files':len(manifest)+1}
(OUT/'degree_seven_local_results_manifest.json').write_text(json.dumps(info,indent=2)+'\n')
print(json.dumps(info,indent=2))
