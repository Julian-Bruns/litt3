"""Combined reproducible replay. Every new source/algebra certificate is
freshly reconstructed. Historical large-prefix sampling is not repeated by
default; --all-history additionally runs the previous complete driver.
"""
import pathlib,subprocess,sys,time,json,ctypes as ct,ctypes.util,concurrent.futures,os,platform,hashlib,argparse
ROOT=pathlib.Path(__file__).resolve().parent.parent
LOG=ROOT/'logs';LOG.mkdir(exist_ok=True)
parser=argparse.ArgumentParser();parser.add_argument('--all-history',action='store_true');parser.add_argument('--jobs',type=int,default=3);args=parser.parse_args()
if args.jobs<1 or args.jobs>3:parser.error('--jobs must be 1, 2, or 3')
if sys.flags.optimize:raise RuntimeError('Verification requires assertions; do not use -O or -OO')
PY=sys.executable
ledger=[]

def run(cmd,label):
 start=time.time();p=subprocess.run(cmd,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
 text=p.stdout;record={'label':label,'command':cmd,'returncode':p.returncode,'seconds':round(time.time()-start,3),
      'output_sha256':hashlib.sha256(text.encode()).hexdigest(),'output_excerpt':text[-18000:]}
 print(('PASS' if p.returncode==0 else 'FAIL'),label,record['seconds'],flush=True)
 if p.returncode:raise RuntimeError(label+' failed:\n'+text)
 return record

def py(script,*argv):return [PY,'src/'+script+'.py',*map(str,argv)]
start=time.time()
first=[(['g++','-O3','-std=c++17','-fPIC','-shared','src/field.cpp','-o','src/libfield.so'],'compile-original-field'),
       (py('exact'),'exact-original-input'),
       (py('norm_element','--verify'),'fresh-45-actual-norm-source-algebras'),
       (py('ratio_eliminant_data','--verify'),'987-exact-residual-divisions'),
       (py('ratio_eliminant','--verify'),'inherited-three-ratio-determinants'),
       (py('verify_certificates_python'),'inherited-65-ratio-certificate-identities'),
       (py('verify_u_certificates_python'),'inherited-216-ratio-certificate-identities'),
       (py('verify_branch_geometry'),'inherited-complete-branch-geometry'),
       (py('verify_branch_certificates'),'inherited-21-branch-certificate-identities'),
       (py('test_fast_arithmetic'),'bounded-independent-fast-arithmetic-tests'),
       (py('prepare_endpoint_backend'),'prepare-checked-exact-backends')]
for cmd,label in first:ledger.append(run(cmd,label))

def endpoint_job(x):
 rows=[]
 commands=[('endpoint_geometry',[x,'--verify']),('endpoint_prepare',[x,'--verify']),
           ('endpoint_incidence',[x,'--verify']),('endpoint_gcd_evidence',[x,'--verify']),
           ('endpoint_primitive',[x,'--verify']),('verify_endpoint_global',[x])]
 commands += [('endpoint_check',[x,label,'--verify']) for label in ['0','4','quartic']]
 commands += [('verify_endpoint_residual',[x,label]) for label in ['0','4','quartic']]
 for script,argv in commands:rows.append(run(py(script,*argv),str(x)+'-'+script+'-'+str(argv[1:])))
 return rows
with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
 futures=[pool.submit(endpoint_job,x) for x in [211895,211959,145049]]
 for f in futures:ledger.extend(f.result())
for script in ['verify_endpoint_geometry','verify_endpoint_certificates','endpoint_boundary_factor','verify_endpoint_factorization']:
 argv=['--verify'] if script=='endpoint_boundary_factor' else []
 ledger.append(run(py(script,*argv),script))
if args.all_history:ledger.append(run(py('verify_branch_continuation'),'optional-full-historical-replay'))
gmp=ct.CDLL(ctypes.util.find_library('gmp'));gmpver=ct.c_char_p.in_dll(gmp,'__gmp_version').value.decode()
summary={'status':'passed','commands':ledger,'top_level_commands':len(ledger),'seconds':round(time.time()-start,3),
  'versions':{'python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],'gmp':gmpver,'platform':platform.platform()},
  'scope':{'fresh_actual_norm_source_algebras':45,'new_endpoint_geometries':3,'new_whole_scale_incidence_decompositions':3,
    'fresh_complete_quartic_algebras_dimension_each':1584,'fresh_actual_finite_norms':9,'independent_full_residual_comparisons':9,
    'independent_formal_root_recurrences':9,'literal_scale_gcd_witnesses':18,'literal_tail_unit_certificates':9,
    'literal_cauchy_unit_certificates':3,'direct_primitive_algebra_presentations':3,
    'global_fixed_resultant_complete_u_algebras':2271,'global_endpoint_product_complete_u_algebras':325,
    'historical_1375_prefix_samples_fresh':False,'historical_driver_additionally_run':args.all_history,
    'historical_large_scale_graph_norms_fresh_by_default':False},
  'global_square_locus_decision':'unresolved','proof_scope':'complete exclusion of all three endpoint-zero incidences; coprimality with P*t after inherited P-branch theorem'}
(LOG/'endpoint_continuation_checks.json').write_text(json.dumps(summary,indent=2)+'\n')
lines=['# Executed endpoint-continuation checks','', '**All listed commands passed. The global square-locus decision remains unresolved.**','',
       'Versions: Python '+sys.version.split()[0]+'; '+summary['versions']['compiler']+'; GMP '+gmpver+'.','',
       '| Check | Outcome | Seconds |','|---|---|---:|']
for r in ledger:lines.append('| '+r['label'].replace('|','/')+' | passed | '+str(r['seconds'])+' |')
lines += ['','Every new endpoint source/algebra computation was freshly regenerated. All nine finite norms were compared in all 141 coefficients with the separate actual residual array; both exclusion tails were independently recomputed by the coefficient square-root recurrence.',
          'The three quartic algebras were independently checked by direct polynomial substitution and the dimension/surjectivity argument. The full 18 scale-gcd identities and 12 tail/Cauchy unit identities were independently multiplied.',
          'All global polynomial identities use proved degree bounds, complete quotient-algebra evaluations and no coefficient-pivot localisation.',
          'The inherited 1,375 global-prefix source samples and historical large scale-graph norm reconstructions were not freshly rerun by default. Their archived prior clean-verification records remain in the ZIP; the default replays their relevant literal certificates and geometry. --all-history additionally runs the prior default driver.',
          'No global determinant expansion, full square-ideal Groebner computation, or square witness is claimed.']
(LOG/'ENDPOINT_EXECUTED_CHECKS.md').write_text('\n'.join(lines)+'\n')
print('ENDPOINT CONTINUATION PASSED',len(ledger),'commands; seconds',summary['seconds'],'GLOBAL DECISION UNRESOLVED',flush=True)
