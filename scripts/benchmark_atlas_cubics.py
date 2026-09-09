#!/usr/bin/env python3
"""Ten short, fully logged tests of the72-cubic FIRST STAGE only.

No finite-field restriction, specialization, R equation or boundary deletion.
A nonempty answer has dimension at least8; it is not an atlas solution set.
"""
import argparse,concurrent.futures,hashlib,json,os,random,re,subprocess,time
from pathlib import Path

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--out',required=True)
    ap.add_argument('--workers',type=int,default=10);ap.add_argument('--seconds',type=int,default=60)
    args=ap.parse_args();assert 1<=args.workers<=10 and 1<=args.seconds<=600
    out=Path(args.out).resolve();out.mkdir(parents=True,exist_ok=False)
    base=Path('/Users/julian/Documents/litt3-computation-data')
    sources=[]
    for name in ['atlas-three-column-20260908','atlas-three-column-chain-20260908']:
        folder=base/name;blob=(folder/'input.sing').read_bytes();s=blob.decode()
        cert=json.loads((folder/'input_certificate.json').read_text())
        assert cert['inverse_equations']==72 and cert['selected_columns']==[4,21,23]
        eq=s.split('ideal I=',1)[1].split(';\n',1)[0].split(',\n')[:72]
        assert len(eq)==72 and not any(re.search(r'\bz\d+\b',f) for f in eq)
        sources.append(dict(equations=eq,sha256=hashlib.sha256(blob).hexdigest(),source=str(folder/'input.sing'),
                            six_chain_basis=cert.get('six_chain_basis',False)))
    v=['v%d'%i for i in range(32)];b=['b%d'%i for i in range(32)]
    rng=random.Random(20260908);perm=list(range(32));rng.shuffle(perm)
    orders=[v+b,b+v,list(reversed(v))+list(reversed(b)),
            [name for i in range(32) for name in (v[i],b[i])],
            [v[i] for i in perm]+[b[i] for i in perm]]
    jobs=[(i,sources[i//5],orders[i%5]) for i in range(10)]
    record=dict(first_stage_only=True,variables=64,equations=72,degree=3,
        nonempty_component_dimension_lower_bound=8,retained_frobenius_equations=0,
        scope='First acyclic representative, cubic inverse incidence only; no atlas exclusion unless unit is independently certified.',
        source_files=[{k:v for k,v in s.items() if k!='equations'} for s in sources])
    (out/'input.json').write_text(json.dumps(record,indent=2)+'\n')
    def run(job):
        i,source,order=job;sub=out/('order-%02d'%i);sub.mkdir()
        program='ring r=(5,a),('+','.join(order)+'),dp; minpoly=a^2-a+2; short=0;\n'
        program+='ideal I='+',\n'.join(source['equations'])+';\n'
        program+='option(prot); print("CUBIC_STAGE_STARTED"); ideal G=slimgb(I); print("CUBIC_STAGE_FINISHED");\n'
        program+='write("'+str(sub/'basis.sing')+'",G); print("BASIS_SIZE"); size(G); print("DIMENSION"); dim(G);\n'
        program+='if(G[1]==1){print("UNIT_CANDIDATE");} quit;\n'
        (sub/'input.sing').write_text(program);started=time.monotonic()
        env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
        with (sub/'solver.log').open('w') as f:
            try:
                proc=subprocess.run(['Singular','-q',str(sub/'input.sing')],stdout=f,stderr=subprocess.STDOUT,
                                    env=env,timeout=args.seconds)
                status='candidate_finished' if proc.returncode==0 else 'error'
            except subprocess.TimeoutExpired:status='time_limit'
        tail=(sub/'solver.log').read_text(errors='replace')[-5000:]
        if status=='candidate_finished' and ('CUBIC_STAGE_FINISHED' not in tail or '?' in tail):status='error'
        result=dict(status=status,seconds=time.monotonic()-started,six_chain_basis=source['six_chain_basis'],
            variable_order=order,log_tail=tail,verified_result=False)
        (sub/'result.json').write_text(json.dumps(result,indent=2)+'\n')
        print(i,status,round(result['seconds'],2),tail[-200:],flush=True);return result
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:results=list(pool.map(run,jobs))
    (out/'results.json').write_text(json.dumps(results,indent=2)+'\n')

if __name__=='__main__':main()
