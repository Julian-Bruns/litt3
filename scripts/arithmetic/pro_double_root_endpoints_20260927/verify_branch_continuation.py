"""Clean-extraction verification of the complete cubic-branch boundary exclusion.
Default replays the inherited suite as well. --new-only skips inherited replay,
not the new 45-algebra actual-source reconstruction or any new certificate.
No mode here claims to decide the complementary global square ideal.
"""
from pathlib import Path
import argparse,json,subprocess,sys,time
ROOT=Path(__file__).resolve().parent.parent
p=argparse.ArgumentParser(description=__doc__);p.add_argument('--new-only',action='store_true');p.add_argument('--full-prefix',action='store_true');args=p.parse_args()
if args.new_only and args.full_prefix:p.error('--full-prefix requires inherited replay')
commands=[['g++','-O3','-std=c++17','-fPIC','-shared','src/field.cpp','-o','src/libfield.so']]
if not args.new_only:
 cmd=[sys.executable,'src/verify_ratio_eliminant_continuation.py']
 if args.full_prefix:cmd+=['--full-prefix']
 commands.append(cmd)
commands += [[sys.executable,'src/exact.py'],
 [sys.executable,'src/norm_element.py','--verify'],
 [sys.executable,'src/branch_geometry.py','--verify'],
 [sys.executable,'src/verify_branch_geometry.py'],
 [sys.executable,'src/test_large_quotient.py'],
 [sys.executable,'src/branch_exclude.py','all','--verify'],
 [sys.executable,'src/branch_remaining.py','--graphs-only','--verify'],
 [sys.executable,'src/verify_branch_certificates.py'],
 [sys.executable,'src/verify_branch_residual.py'],
 [sys.executable,'src/branch_boundary_factor.py','--verify'],
 [sys.executable,'src/verify_branch_factorization.py']]
start=time.time();records=[]
for cmd in commands:
 tic=time.time();print('\n$ '+' '.join(cmd),flush=True)
 subprocess.run(cmd,cwd=ROOT,check=True)
 records.append({'command':' '.join(cmd),'outcome':'passed','seconds':round(time.time()-tic,3)})
result={'status':'passed','python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],
 'commands':records,'seconds':round(time.time()-start,3),'inherited_suite_replayed':not args.new_only,
 'inherited_1375_prefix_samples_fresh':args.full_prefix,'fresh_actual_norm_source_algebras':45,
 'complete_branch_geometries_regenerated':10,'fresh_actual_all_scale_residue_fields':12,
 'new_explicit_all_scale_ratio_points':77,'finite_scale_graphs_regenerated':9,
 'length_of_each_scale_graph':486,'geometric_points_of_each_scale_graph':375,
 'finite_scale_graphs_retain_nilpotents':True,'independent_complete_global_residual_comparisons':9,
 'literal_bezout_identities_independently_checked':21,'global_boundary_factor_nu_degree':19,'global_resultant_factorization_verified':True,
 'new_global_theorem':'Every actual square residual on the original ordinary-double-root open is coprime to P(x).',
 'global_square_decision':'unresolved','remaining_gap':'Complete square ideal on the complementary open, including the determinant-zero ratio algebra.'}
logs=ROOT/'logs';logs.mkdir(exist_ok=True)
(logs/'branch_continuation_checks.json').write_text(json.dumps(result,indent=2)+'\n')
lines=['# Executed cubic-branch continuation checks','',
 '**All listed checks passed. The original global square-locus decision remains unresolved.**','',
 'Versions: '+result['python'].splitlines()[0]+'; '+result['compiler']+'.','',
 '| Command | Outcome | Seconds |','|---|---|---:|']
for r in records:lines.append('| `'+r['command']+'` | '+r['outcome']+' | '+str(r['seconds'])+' |')
lines += ['',
 'The inherited suite was '+('replayed.' if not args.new_only else 'not replayed in this invocation.'),
 'The inherited 1375 prefix samples were '+('freshly reconstructed.' if args.full_prefix else 'not freshly reconstructed; the default inherited suite replays their archived digests.'),
 'The norm element was freshly reconstructed from the actual fixed-degree source resultant in all 45 complete u-algebras; its global degree bound is proved in REPORT16.',
 'All ten branch specializations, exact unit divisions, fraction-free eliminations, complete projection algebras and scale graphs were regenerated.',
 'An independent polynomial-long-division check verifies every fraction-free remainder identity, every content removal and every pivot on the whole finite algebra.',
 'All twelve distinguished-branch residue fields were reconstructed from the original source with the entire geometric scale variable retained, then their actual square-tail Bezout certificates regenerated.',
 'Each of the nine other branches was checked in the full degree486 quotient, not merely its reduced points. Each first square tail is a unit.',
 'All 141 norm coefficients in each finite graph algebra were independently matched against the separate global residual array.',
 'Twenty-one Bezout identities were independently multiplied with schoolbook K-polynomial arithmetic.',
 'The arithmetic regression tests are explicitly bounded implementation tests, not exclusions of geometric parameter sets.',
 'The final sixteen square equations are never discarded from the full problem. A unit certificate using a subset of necessary equations excludes that full problem on the stated boundary.',
 'The degree19 product is expanded globally. Its unit assertion is proved by the complete boundary exclusions, not by coefficient inspection.',
 'No new global determinant expansion, common-zero computation or square witness is claimed.','']
(logs/'BRANCH_EXECUTED_CHECKS.md').write_text('\n'.join(lines))
print('ALL CUBIC-BRANCH CONTINUATION CHECKS PASSED',json.dumps(result),flush=True)
