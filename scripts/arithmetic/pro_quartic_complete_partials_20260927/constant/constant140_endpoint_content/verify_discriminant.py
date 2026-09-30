#!/usr/bin/env python3
"""Replay only the new exact discriminant certificates and bounded local fixtures.

The retained E table is checked against its source-reconstruction hash. Run verify.py
for complete regeneration of that table and all retained global certificates.
"""
from pathlib import Path
import hashlib,json,subprocess,sys,platform,shutil,time
ROOT=Path(__file__).resolve().parent

def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):h.update(b)
    return h.hexdigest()

def main():
    cxx=shutil.which('c++') or shutil.which('g++')
    if not cxx:raise RuntimeError('C++17 compiler with OpenMP required')
    build=ROOT/'build/new_check';build.mkdir(parents=True,exist_ok=True)
    regen=ROOT/'regenerated/new_check';regen.mkdir(parents=True,exist_ok=True)
    steps=[]
    def run(name,cmd):
        started=time.monotonic()
        with (build/(name+'.log')).open('w') as f:
            p=subprocess.run(cmd,cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
        if p.returncode:raise RuntimeError(f'{name} failed; see {build/name}.log')
        steps.append({'name':name,'command':cmd,'returncode':p.returncode,
                      'seconds':round(time.monotonic()-started,3)})
        print('PASS',name,flush=True)
    ex=json.loads((ROOT/'inputs/expected.json').read_text())
    found=False
    for row in ex['files'].values():
        if row['regenerated_filename']=='E_records.tsv':
            if sha(ROOT/'inputs/E_records.tsv')!=row['sha256']:raise RuntimeError('E table hash mismatch')
            found=True
    if not found:raise RuntimeError('E provenance hash not found')
    for name in ['check_discriminant','profile_discriminant','check_content','check_power','check_simple_content']:
        run('compile_'+name,[cxx,'-O3','-std=c++17','-Wall','-Wextra','-fopenmp',
                            'discriminant/'+name+'.cpp','-o','build/new_check/'+name])
    run('discriminant_identities',['build/new_check/check_discriminant','inputs/E_records.tsv','regenerated/new_check'])
    names=['H1_q3','H5_q15625','H31_q48151']
    run('squarefree_profiles',['build/new_check/profile_discriminant']+
        ['regenerated/new_check/'+n+'_discriminant.dat' for n in names])
    run('content_fixtures',['build/new_check/check_content'])
    run('power_fixtures',['build/new_check/check_power'])
    run('simple_content_fixture',['build/new_check/check_simple_content'])
    checked={}
    for key,row in json.loads((ROOT/'inputs/discriminant_expected.json').read_text())['files'].items():
        fn=Path(row['regenerated_path']).name
        for path in [regen/fn,ROOT/row['stored_path']]:
            if sha(path)!=row['sha256']:raise RuntimeError('Certificate mismatch: '+str(path))
        checked[key]=row['sha256']
    report={'status':'PASS','global_square_locus':'UNRESOLVED',
            'scope':'New exact fixed-ratio discriminant identities and factor certificates; bounded content, sharp power, and simple-content fixtures. The written global theorems have their stated proofs, not interpolation in the ratios.',
            'python':platform.python_version(),
            'compiler':subprocess.check_output([cxx,'--version'],text=True).splitlines()[0],
            'steps':steps,'exact_hash_count':len(checked),'exact_hashes':checked}
    (build/'summary.json').write_text(json.dumps(report,indent=2)+'\n')
    print('PASS',len(checked),'exact regenerated certificate hashes; GLOBAL SQUARE LOCUS UNRESOLVED')

if __name__=='__main__':
    try:main()
    except Exception as e:print('VERIFICATION FAILED:',e,file=sys.stderr);sys.exit(1)
