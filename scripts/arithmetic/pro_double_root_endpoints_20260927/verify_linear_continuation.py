"""Fresh, reproducible checks for the scheme-exact linear continuation.

This is a verification driver, not a global square-ideal solver. Every claimed
fresh calculation is listed below. Historical endpoint norm reconstructions
are not repeated by default; --all-history runs their previous full driver.
"""
import argparse, ctypes as ct, ctypes.util, hashlib, json, pathlib, platform, subprocess, sys, time
ROOT=pathlib.Path(__file__).resolve().parent.parent
LOG=ROOT/'logs';LOG.mkdir(exist_ok=True)


def main():
    if sys.flags.optimize:raise RuntimeError('Assertions are required: do not use -O, -OO, or PYTHONOPTIMIZE')
    ap=argparse.ArgumentParser();ap.add_argument('--all-history',action='store_true');args=ap.parse_args()
    start=time.time();ledger=[]
    def py(name,*argv):return [sys.executable,'src/'+name+'.py',*map(str,argv)]
    commands=[
      (['g++','-O3','-std=c++17','-fPIC','-shared','src/field.cpp','-o','src/libfield.so'],'compile-original-field'),
      (py('exact'),'exact-original-input'),
      (py('norm_element','--verify'),'fresh-45-actual-norm-source-algebras'),
      (py('ratio_eliminant_data','--verify'),'all-987-global-residual-normalizations'),
      (py('test_fast_arithmetic'),'bounded-independent-exact-arithmetic-tests'),
      (py('lacunary_global','--verify'),'fresh-global-central-coefficient-certificate'),
      (py('verify_lacunary'),'independent-literal-central-coefficient-identity'),
      (py('late_linear_certificate','--verify'),'fresh-global-leading-coefficient-certificate'),
      (py('verify_late_linear'),'independent-literal-leading-coefficient-identity'),
      (py('audit_hasse_model','--verify'),'global-support-cone-and-exact-linear-circuits'),
      (py('test_hasse_linear'),'field-and-nilpotent-linear-model-tests'),
      (py('verify_hasse_actual',1,132),'whole-u-1-and-132-algebras-all-scale-circuit-comparisons'),
      (py('verify_hasse_minors'),'all-scale-generator-identity-and-six-direct-minor-checks'),
      (py('materialize_legacy_arrays','all'),'hash-checked-regeneration-of-three-omitted-expansions'),
      (py('check_normalization_limit'),'exact-counterexample-to-extra-polynomial-cancellation'),
      (py('ratio_eliminant','--verify'),'inherited-three-ratio-determinant-circuits'),
      (py('verify_certificates_python'),'inherited-65-all-scale-ratio-certificate-identities'),
      (py('verify_u_certificates_python'),'inherited-216-all-scale-ratio-certificate-identities'),
      (py('verify_branch_certificates'),'inherited-21-branch-unit-identities'),
      (py('verify_endpoint_certificates'),'inherited-endpoint-unit-identities-and-whole-quartic-presentations'),
    ]
    if args.all_history:commands.append((py('verify_endpoint_continuation','--all-history'),'optional-full-historical-drivers'))
    for cmd,label in commands:
        tic=time.time();p=subprocess.run(cmd,cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
        row={'label':label,'command':cmd,'returncode':p.returncode,'seconds':round(time.time()-tic,3),
             'output_sha256':hashlib.sha256(p.stdout.encode()).hexdigest(),'output_excerpt':p.stdout[-14000:]}
        ledger.append(row);print(('PASS' if p.returncode==0 else 'FAIL'),label,row['seconds'],flush=True)
        if p.returncode:
            (LOG/'linear_failed_check.json').write_text(json.dumps(row,indent=2)+'\n')
            raise RuntimeError(label+' failed:\n'+p.stdout)
    lib=ct.CDLL(ctypes.util.find_library('gmp'));gv=ct.c_char_p.in_dll(lib,'__gmp_version').value.decode()
    regen=json.loads((LOG/'legacy_materialization_all.json').read_text())
    scope={
      'fresh_actual_norm_source_algebras':45,'global_residual_coefficients_normalized':987,
      'fresh_global_polynomial_row_certificates':2,'independently_multiplied_global_identities':2,
      'specializations_in_global_identity_verification':0,
      'actual_complete_ratio_algebra_implementation_tests':[1,132],
      'scale_kept_polynomial_in_those_tests':True,'bounded_direct_71_by_71_determinants':6,
      'omitted_expansions_raw_hash_checked':3,'omitted_expansions_freshly_regenerated_this_run':regen['fresh_expansions'],
      'inherited_ratio_certificate_count':65+216,'inherited_branch_unit_identities':21,
      'inherited_endpoint_tail_and_cauchy_identities':12,'inherited_quartic_presentations_directly_checked':3,
      'historical_endpoint_source_norms_fresh_by_default':False,
      'historical_large_branch_scale_graph_norms_fresh_by_default':False,
      'optional_historical_drivers_run':args.all_history,
      'new_all_scale_ratio_exclusions':0,'global_linear_circuit_expansions_computed':False,
      'global_unit_ideal_decision_executed':False}
    summary={'status':'passed','commands':ledger,'top_level_commands':len(ledger),'seconds':round(time.time()-start,3),
      'versions':{'python':sys.version,'compiler':subprocess.check_output(['g++','--version'],text=True).splitlines()[0],
                  'gmp':gv,'platform':platform.platform()},'scope':scope,
      'global_square_locus_decision':'unresolved',
      'proof_scope':'two literal global coefficient identities; scheme-exact entirely linear square test, with polynomial bounded-scale circuits'}
    (LOG/'linear_continuation_checks.json').write_text(json.dumps(summary,indent=2)+'\n')
    text=['# Executed linear-continuation checks','',
      '**All listed commands passed. The global square-locus decision remains unresolved.**','',
      'Versions: Python '+sys.version.split()[0]+'; '+summary['versions']['compiler']+'; GMP '+gv+'.','',
      '| Check | Outcome | Seconds |','|---|---|---:|']
    for r in ledger:text.append('| '+r['label']+' | passed | '+str(r['seconds'])+' |')
    text += ['',
      'Both global polynomial identities were freshly constructed and independently multiplied in the full rank-nine ratio ring, with the scale left polynomial. No geometric specialization or generic-function-field localization is used by the literal verifiers.',
      'The entire actual norm element was reconstructed from the original source in all45 degree-bounded source algebras. All987 normalized residual coefficients and the global scale-support cone were checked.',
      'The two complete length-nine ratio-algebra comparisons, field/dual-number tests, and six direct scalar determinants are bounded implementation tests, not new ratio exclusions. The global scheme equivalence is proved in REPORT53–55.',
      'All three deliberately omitted legacy expansions have their raw hashes checked. Freshly regenerated in this run: '+', '.join(regen['fresh_expansions'])+'. Prefix regeneration, when needed, reconstructs1375 compressed complete-algebra samples under the inherited proved degree bound.',
      'Historical endpoint-source norm reconstructions and the older large branch-graph norm reconstructions were not freshly repeated by default. Their prior verification records and all source remain included; relevant literal identities and complete quartic presentations were rechecked.',
      'No expansion of the77 global generators, global Groebner/unit-ideal computation, new finite ratio exclusion, or square witness is claimed.']
    (LOG/'LINEAR_EXECUTED_CHECKS.md').write_text('\n'.join(text)+'\n')
    print('LINEAR CONTINUATION PASSED',len(ledger),'commands; seconds',summary['seconds'],'GLOBAL DECISION UNRESOLVED',flush=True)

if __name__=='__main__':main()
