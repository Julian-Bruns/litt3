#!/usr/bin/env python3
"""Bounded ONE-core native SAT run, independent proof check, exact decoder."""
import argparse,hashlib,json,os,signal,subprocess,time
from pathlib import Path
from five_minor_auth_smt import decode
from two_moment_auth_smt import pair_table
from rank_reconstruction import unflat


def write(path,value):path.write_text(json.dumps(value,indent=2)+'\n')


def read_model(log,maximum):
    model={}
    for line in log.read_text().splitlines():
        if line.startswith('v '):
            for item in line.split()[1:]:
                lit=int(item)
                if lit:
                    key=abs(lit);assert key<=maximum
                    assert key not in model or model[key]==(lit>0);model[key]=lit>0
    assert len(model)==maximum,'expected a full native satisfying assignment'
    return model


def check_cnf(path,model):
    count=0
    with path.open() as f:
        for line in f:
            if line.startswith(('c','p')):continue
            clause=list(map(int,line.split()));assert clause[-1]==0
            assert any(model[abs(v)]==(v>0) for v in clause[:-1]);count+=1
    return count


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--instance-dir',required=True,type=Path)
    ap.add_argument('--circuit',required=True,type=Path);ap.add_argument('--tools-dir',required=True,type=Path)
    ap.add_argument('--seconds',type=int,default=600);ap.add_argument('--check-seconds',type=int,default=600)
    ap.add_argument('--proof-limit-MB',type=int,default=1536);args=ap.parse_args()
    out=args.instance_dir;cnf=out/'genuine.cnf';proof=out/'unsat.drat';log=out/'solver.log'
    status=out/'solve_result.json';checkpoint=out/'solve_checkpoint.json'
    assert not status.exists(),'preserve previous bounded run; use a fresh copied instance directory'
    meta=json.loads((out/'result.json').read_text());assert hashlib.sha256(cnf.read_bytes()).hexdigest()==meta['cnf_sha256']
    tools=json.loads((args.tools_dir/'provenance.json').read_text())
    command=[str(args.tools_dir/'kissat'),'--strict',f'--time={args.seconds}','--seed=0',str(cnf),str(proof)]
    result=dict(status='RUNNING',command=command,source_family=meta['source_family'],
        cnf_sha256=meta['cnf_sha256'],variables=meta['variables'],clauses=meta['clauses'],
        solver_provenance=tools,seconds_limit=args.seconds,checker_seconds_limit=args.check_seconds,
        proof_size_limit_MB=args.proof_limit_MB,cores=1,
        thread_environment={k:os.environ.get(k) for k in ('OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS')})
    begun=time.monotonic();reason=None
    with log.open('w') as stream:
        p=subprocess.Popen(command,stdout=stream,stderr=subprocess.STDOUT,start_new_session=True)
        result['pid']=p.pid;write(status,result)
        while p.poll() is None:
            elapsed=time.monotonic()-begun;size=proof.stat().st_size if proof.exists() else 0
            info=subprocess.run(['ps','-p',str(p.pid),'-o','rss='],text=True,capture_output=True)
            rss=int(info.stdout.strip() or '0')
            write(checkpoint,dict(pid=p.pid,status='RUNNING',seconds=elapsed,proof_bytes=size,RSS_KB=rss,cores=1))
            if elapsed>args.seconds+30:reason='host wall timeout'
            elif size>args.proof_limit_MB*1024**2:reason='proof size bound'
            elif rss>3500*1024:reason='3.5GB memory bound'
            if reason:
                os.killpg(p.pid,signal.SIGTERM)
                try:p.wait(timeout=3)
                except subprocess.TimeoutExpired:os.killpg(p.pid,signal.SIGKILL);p.wait()
                break
            time.sleep(10)
    result.update(exit_code=p.returncode,seconds=time.monotonic()-begun,
                  proof_bytes=proof.stat().st_size if proof.exists() else 0)
    text=log.read_text()
    if p.returncode==20 and '\ns UNSATISFIABLE\n' in '\n'+text:
        checklog=out/'checker.log';checker=[str(args.tools_dir/'drat-trim'),str(cnf),str(proof),'-t',str(args.check_seconds)]
        result.update(status='UNSAT; independent proof check pending',checker_command=checker);write(status,result)
        try:
            with checklog.open('w') as stream:
                checked=subprocess.run(checker,stdout=stream,stderr=subprocess.STDOUT,timeout=args.check_seconds+15)
            verified=checked.returncode==0 and any(line.strip()=='s VERIFIED' for line in checklog.read_text().splitlines())
            result.update(status='UNSAT independently proof-verified' if verified else 'UNSAT solver claim; proof check failed',
                checker_exit_code=checked.returncode,proof_verified=verified,
                proof_sha256=hashlib.sha256(proof.read_bytes()).hexdigest())
        except subprocess.TimeoutExpired:result.update(status='UNSAT solver claim; proof check UNKNOWN',proof_verified=False)
    elif p.returncode==10 and '\ns SATISFIABLE\n' in '\n'+text:
        model=read_model(log,meta['variables']);assert check_cnf(cnf,model)==meta['clauses']
        info=json.loads((out/'decode.json').read_text())
        moments=[unflat([next(i for i,lit in enumerate(vec) if model[lit]) for vec in row]) for row in info['moments']]
        choices={role:[next(int(i) for i,lit in domain.items() if model[lit]) for domain in domains] for role,domains in info['pair_domains'].items()}
        witness=decode(json.loads(args.circuit.read_text()),moments,choices,pair_table())
        result.update(status='SAT; ALL CNF clauses and full ORIGINAL witness verified',
            all_CNF_clauses_checked=meta['clauses'],witness=witness)
    else:result.update(status='UNKNOWN; no incidence decision',reason=reason or 'native solver time/conflict limit')
    write(status,result);write(checkpoint,dict(status=result['status'],seconds=result['seconds'],cores=1))
    print(json.dumps(result),flush=True)

if __name__=='__main__':main()
