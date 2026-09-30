"""Refresh the archive's case catalogue from completed joined verifications.
This is documentation generation, not mathematical verification.
"""
from pathlib import Path
import gzip,json,re
ROOT=Path(__file__).resolve().parents[1]
LABELS=['small','large0','large1','large2'];RS=[145049,211895,211959]
def main():
 cases=[]
 for r in RS:
  for b,label in enumerate(LABELS):
   name=f'{r}_{label}';v=ROOT/'evidence/branches'/name/'verification.json'
   if not v.exists():continue
   d=json.loads(v.read_text());assert d['status']=='PASS' and (d['r'],d['branch'])==(r,b)
   desc=json.loads((ROOT/'data/branches'/name/'descriptor.json').read_text());row=dict(d,name=name,label=label)
   row['tail_degrees']=[];row['scalar_degrees']=[]
   for n in (71,72):
    p=ROOT/desc['files'][f'C{n}']['file']
    with gzip.open(p,'rt') as f:lines=f.read().splitlines()
    row['tail_degrees'].append([int(line.split()[0])-1 for line in lines])
    with gzip.open(ROOT/desc['files'][f'certificate{n}']['file'],'rt') as f:row['scalar_degrees'].append(int(f.readline().split()[0])-1)
   row['stripped_degrees']=list(map(int,re.findall(r'stripped_degree=(\d+)',d['global_certificate_output'])))
   row['unit_algebras']=sum(z['status']=='unit_identity_verified' for z in d['finite_records']);cases.append(row)
 n=len(cases);done={(c['r'],c['branch']) for c in cases};remaining=[(r,b) for r in RS for b in range(4) if (r,b) not in done]
 names=[c['name'] for c in cases];complete=n==12
 status='COMPLETE: the entire positive fixed-content square locus is empty.' if complete else f'PARTIAL: {n} complete rational-scale branches are excluded; {12-n} remain unresolved.'
 concise=', '.join(f'<{c["r"]}>/{c["label"]}' for c in cases)
 report=ROOT/'REPORT.md';s=report.read_text();a=s.index('## 1. Scope and current conclusion');b=s.index('## 2. Denominator-free')
 s=s[:a]+f'''## 1. Scope and current conclusion

**{status}** No degree-70 square-root witness is claimed.

The completed cases are {concise}. Each is a whole-curve geometric
exclusion with all retained denominator fibres covered, not a bounded
field-point search. Section 9 explains the exact method and the first
case; Section 12 records every completed case and its own certificates.

The prior B1=0 boundary and the new J=0 boundary are excluded at all
three endpoints. All four necessary scales are covered on J=0. These
are separate boundary proofs, not silent localizations. INPUTS.md gives
the complete source and accepted reductions, including B=0, Delta=0,
and the four-scale necessity. The content-free locus is outside scope.

'''+s[b:]
 a=s.index('## 5. What remains open');b=s.index('## 6. Approaches')
 s=s[:a]+f'''## 5. What remains open

{status} The case catalogue in Section 12 gives the exact scope.
No assertion is made about the content-free square locus, which is
outside the user's specified question.

'''+s[b:]
 a=s.index('## 11. Exact remaining problem');s=s[:a]+'''## 11. Exact remaining problem

'''
 if complete:
  s+='''There is no remaining gap in the requested positive fixed-content
exclusion, relative to the accepted inputs. To see that the case
coverage is exhaustive, choose any marked positive-content point of a
hypothetical square. It lies above one of the three endpoints. The
accepted B=0 and Delta=0 exclusions, followed by the proved B1=0 and
J=0 exclusions, put it on the integral chart. Its nonzero scale is one
of the four input alternatives. The corresponding one of the twelve
complete case exclusions gives a contradiction. This proves emptiness
for positive content even at one sheet. Multiple endpoint contents do
not evade the argument: choose any one of them. The content-free locus
remains outside scope.

'''
 else:
  s+='The still-unresolved complete branches are:\n\n'+', '.join(f'`<{r}>/{LABELS[b]}`' for r,b in remaining)+'.\n\n'
  s+='''A branch is not counted as complete merely because generic tails,
elimination scalars, or finite-fibre calculations have been generated.
Both the whole generic complement and every retained exceptional fibre
must have verified identities. A positive answer would require all
coefficients of an actual degree-70 square root and all original opens.
The content-free locus remains outside scope.

'''
 s+='''## 12. Completed-case catalogue

The label `small` is mu=-kappa/m^2. The labels `large0`, `large1`,
`large2` are the three j=0,1,2 large-root scales in the input, respectively.
The proof of Section 9 applies to each row using its own exact data.
For every row, the displayed scalar product identities and support
chains are checked in K[v,S]/FS, the final Bezout identity is checked in
K[v], and every retained support-zero fibre has an exact unit identity
in its full allowed algebra. No irreducibility of FS or rationality of
varying parameters is assumed. Factor coverage and all pointwise open
saturations are independently checked.

| Endpoint and scale | support degree | scalar degrees | stripped scalar degrees | retained unit algebras | total K-dimension |
|---|---:|---|---|---:|---:|
'''
 for c in cases:s+=f'| `<{c["r"]}>/{c["label"]}` | {c["support_degree"]} | {c["scalar_degrees"]} | {c["stripped_degrees"]} | {c["unit_algebras"]} | {c["retained_algebra_dimension"]} |\n'
 for c in cases:
  s+=f'''\n### Case <{c['r']}>/{c['label']}

Files: `data/branches/{c['name']}/` and
`evidence/branches/{c['name']}/`. Joined check:
`python src/verify_branch.py {c['name']}`.

Complete support factor degrees: `{c['factor_degrees']}`.
C71 denominator/numerator degrees: `{c['tail_degrees'][0]}`.
C72 denominator/numerator degrees: `{c['tail_degrees'][1]}`.
Each degree row lists the base denominator first, followed by the six
S-coefficient numerator degrees. The finite verification JSON lists each
factor, exclusions, allowed algebra dimensions, and whether C71 alone
or a combination of C71,C72 supplies the unit.
'''
 s+='''
### Scheme-theoretic coverage

All original pointwise denominator and nonzero-scale conditions are
preserved. Factoring the squarefree base support loses no infinitesimal
counterexample: any nonempty square subscheme over its zero set has a
point on one of the base factors, where the displayed fibre ideal is
already the unit ideal. Equivalently, a unit modulo a nilpotent base
thickening's defining ideal lifts to a unit. Within every allowed S
fibre the computation retains the complete quotient algebra rather than
replacing it by its reduced quotient. The scalar product identities on
the complementary open likewise hold in the full monic algebra. Thus
nilpotents and coefficient-degree drops cannot supply omitted cases.
'''
 report.write_text(s)
 loops=' '.join(names)
 readme=f'''# One-sheet content and degree-140 squares

## Objective and status

Decide the entire geometric positive fixed-content square locus specified
in INPUTS.md.

**{status}** The complete case list and exact certificate sizes are in
REPORT.md Section 12. The B1=0 and J=0 boundaries are independently
excluded at all three endpoints. All statements range over the algebraic
closure; no geometric parameter is restricted to the coefficient field.
The content-free locus is outside scope.

## Files

- INPUTS.md: exact source, constants, conventions and accepted reductions.
- REPORT.md: proofs, dependencies, localization coverage, case catalogue.
- RESUME.md and claims.json: latest state and claim-to-evidence index.
- src/: complete Python standard-library and C++17 source.
- data/: reconstructed source, compact residual Ehat, integral charts/scales.
- data/branches/ and evidence/branches/: compressed exact tails/scalar
  certificates, short support chains, Bezout identities, every finite
  fibre certificate, and joined verification summaries.
- evidence/J_tails_*.txt and evidence/tails_*.txt: J and prior B1 certificates.
- logs/ and evidence/*checks.json: executed checks and implementation audits.
- SHA256SUMS: hashes of all distributed files except the manifest itself.

Bulky expanded residuals, binaries, field lookup tables and multiplication
matrix checkpoints are regenerable and omitted. Large essential
polynomials are deterministic gzip chunks; ZIP creation is streamed.
No conversation history, prior archive, external data or network is needed.

## Software

Executed versions: Python 3.13.5, g++ 14.2.0, GMP 6.3.0, Linux.
Requirements: Python >=3.10, g++ with C++17 support, GMP development
headers/library, and OpenMP for parallel regeneration. The optional locked
continuation driver requires a POSIX environment (fcntl). Python uses only
its standard library. No certificate uses floating point.

## Exact certificate verification

From the extracted archive root, `python src/verify_all.py` checks the
manifest, both boundaries and all installed whole-branch certificates.
Equivalent individual commands:

```sh
sha256sum -c SHA256SUMS
python src/verify_boundary.py
python src/verify_J.py
python src/replay_arithmetic_audits.py
for name in {loops}; do
  python src/verify_branch.py "$name"
done
```

The branch verifier checks the full global polynomial identities,
univariate Bezout identity, factor coverage, and independent Python
finite-algebra unit/open/saturation identities. It does not regenerate
the tail values from Ehat. Use the following stronger commands for that.

## Full regeneration from exact inputs

```sh
python src/replay.py
python src/replay_continuation.py
for name in {loops}; do
  python src/replay_branch.py "$name" --workdir "build/fresh_$name" --threads 2
done
```

Use fresh work directories. The --resume option is allowed only when
the recorded source/input hashes match; coefficient and matrix stages
are restartable. The execution record distinguishes completed stages,
independent certificate checks, and any driver not yet executed end-to-end.
The inherited fresh_extraction_checks.json certifies only the original
checkpoint; it must not be used as evidence for later files.
'''
 (ROOT/'README.md').write_text(readme)
 resume=f'''# Resume — verified case checkpoint

## Status

{status}

## Proved results

The entire prior B1=0 boundary is excluded (13 certificates, dimension45).
The entire J=0 boundary is excluded on all four scales (12 certificates
in three dimension30 algebras, total dimension90). The integral sextic
and exact scale formulas are proved; [H^6]j=B1^4*J identifies the remaining
H-degree-drop boundary. Completed whole branches: {concise}.

Each complete branch has a global two-tail Bezout exclusion plus every
retained denominator fibre. See REPORT.md Section12 and the branch
verification JSON files. No finite-field point search is used.

## Verification and replay

Follow README.md. Do not discard a base fibre merely because its defining
polynomial is a unit over K(v). All coefficient calculations are exact
in monic algebras; every extra support fibre must be covered.

## Remaining problem

'''
 resume+=('No gap remains for positive content, relative to the stated accepted inputs.\nThe content-free locus is outside scope.\n' if complete else ', '.join(f'<{r}>/{LABELS[b]}' for r,b in remaining)+' remain unresolved.\nA positive result must include the full degree70 square root.\n')
 (ROOT/'RESUME.md').write_text(resume)
 p=ROOT/'claims.json';claims=json.loads(p.read_text());claims['overall_status']='complete' if complete else 'partial'
 for c in claims['claims']:
  if c['id']=='full_decision':c.update(depends_on=['input_reductions','source','B1_exclusion','J_boundary_exclusion']+['complete_branch_'+name for name in names],status='proved_by_exact_computational_certificates' if complete else 'open',statement=status,evidence=['REPORT.md#12-completed-case-catalogue','RESUME.md'])
  if 'depends_on' in c:c['depends_on']=[{'accepted_inputs':'input_reductions','source_reconstruction':'source'}.get(x,x) for x in c['depends_on']]
 ids={c['id'] for c in claims['claims']}
 for c in cases:
  cid='complete_branch_'+c['name']
  if cid not in ids:claims['claims'].append({'id':cid,'status':'proved_by_exact_computational_certificates','statement':f'The complete geometric {c["label"]} branch at r=<{c["r"]}> has no square, including every retained denominator fibre.','evidence':['REPORT.md#12-completed-case-catalogue',f'data/branches/{c["name"]}/descriptor.json',f'evidence/branches/{c["name"]}/verification.json','src/verify_branch.py'], 'depends_on':['input_reductions','source','B1_exclusion','J_boundary_exclusion'], 'certificate_glob':f'evidence/branches/{c["name"]}/**/*'})
 p.write_text(json.dumps(claims,indent=2)+'\n');(ROOT/'evidence/complete_case_catalogue.json').write_text(json.dumps({'status':claims['overall_status'],'completed':[{'r':c['r'],'branch':c['branch'],'name':c['name']} for c in cases],'remaining':[{'r':r,'branch':b,'name':f'{r}_{LABELS[b]}'} for r,b in remaining]},indent=2)+'\n');print(status)
if __name__=='__main__':main()
