"""Bounded F25 diagnostic: exact graph lifting of L+P^5 equations.

Not a production restart. Original input is read-only; every changed row
is checked by substitution. Solver output remains an unverified candidate.
"""
import argparse, hashlib, json, os, resource, subprocess, time
from pathlib import Path

parser=argparse.ArgumentParser()
parser.add_argument('--chart',type=int,default=24)
parser.add_argument('--seconds',type=int,default=30)
parser.add_argument('--out',required=True)
args=parser.parse_args()
assert 0<=args.chart<=31 and 0<args.seconds<=60
out=Path(args.out).resolve()
out.mkdir(parents=True,exist_ok=False)
source=Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')/('chart-%02d'%args.chart)
raw=(source/'input.ms').read_bytes()
meta=json.loads((source/'metadata.json').read_text())
assert hashlib.sha256(raw).hexdigest()==meta['input_sha256']
lines=raw.decode().strip().splitlines()
names=lines[0].split(',')
assert lines[1]=='5' and names[-1]=='a'
k=GF(25,'a',modulus=PolynomialRing(GF(5),'j')([2,4,1]))
a=k.gen()
R=PolynomialRing(k,names=names[:-1],order='degrevlex')
env=dict(zip(names[:-1],R.gens()),a=a)
expr=[line.strip().rstrip(',') for line in lines[2:]]
assert sage_eval(expr[-1],locals=env)==0
original=[R(sage_eval(f,locals=env)) for f in expr[:-1]]
print('Parsed original input',flush=True)
def fifth_power(f):
    return f.parent()({tuple(5*j for j in e):c**5 for e,c in f.dict().items()})
plans=[]
for i,f in enumerate(original):
    if f.total_degree()<=5:continue
    fifth={e:c for e,c in f.dict().items() if all(j%5==0 for j in e)}
    low=f-R(fifth)
    if low.total_degree()>1:continue
    root=R({tuple(j//5 for j in e):c**5 for e,c in fifth.items()})
    assert fifth_power(root)+low==f
    plans.append((i,low,root))
assert plans
P=PolynomialRing(k,names=names[:-1]+['fg%d'%i for i in range(len(plans))],order='degrevlex')
embed=R.hom(P.gens()[:R.ngens()],P)
by_index={i:(j,L,H) for j,(i,L,H) in enumerate(plans)}
lifted=[]
for i,f in enumerate(original):
    if i not in by_index:lifted.append(embed(f));continue
    j,L,H=by_index[i];z=P.gen(R.ngens()+j)
    lifted.extend([embed(L)+z**5,z-embed(H)])
sub=P.hom(list(R.gens())+[H for _,L,H in plans],R)
replayed=[]
for i,f in enumerate(original):
    if i not in by_index:replayed.append(sub(embed(f))==f);continue
    j,L,H=by_index[i];z=P.gen(R.ngens()+j)
    assert embed(f)==(embed(L)+z**5)-fifth_power(z-embed(H))
    replayed.extend([fifth_power(H)+L==f,sub(z-embed(H))==0])
assert all(replayed)
report=dict(chart=args.chart,input_sha256=meta['input_sha256'],changed_rows=len(plans),
    variables_before=R.ngens(),variables_after=P.ngens(),rows_before=len(original),rows_after=len(lifted),
    max_degree_before=max(f.total_degree() for f in original),max_degree_after=max(f.total_degree() for f in lifted),
    terms_before=sum(len(f.dict()) for f in original),terms_after=sum(len(f.dict()) for f in lifted),
    exact_graph_identities=True,solution_scheme_isomorphic=True,
    scope='One first-oper chart diagnostic, no atlas exclusion or performance forecast.')
(out/'transformation.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(json.dumps(report,default=int),flush=True)
program='ring r=(5,a),('+','.join(P.variable_names())+'),dp; minpoly=a^2-a+2; short=0;\n'
program+='ideal I='+',\n'.join(str(f).replace('**','^') for f in lifted)+';\n'
program+='option(prot); print("GRAPH_SOLVER_STARTED"); ideal G=slimgb(I);\n'
program+='print("GRAPH_SOLVER_FINISHED"); size(G); if(G[1]==1){print("UNIT_CANDIDATE");} quit;\n'
(out/'input.sing').write_text(program)
def limits():
    resource.setrlimit(resource.RLIMIT_CPU,(args.seconds+1,args.seconds+2))
started=time.monotonic()
envrun=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1')
with (out/'solver.log').open('w') as log:
    try:
        process=subprocess.run(['Singular','-q',str(out/'input.sing')],stdout=log,stderr=subprocess.STDOUT,
            timeout=args.seconds,preexec_fn=limits,env=envrun)
        status='candidate_finished' if process.returncode==0 else 'solver_error'
    except subprocess.TimeoutExpired:
        status='time_limit'
elapsed=time.monotonic()-started
tail=(out/'solver.log').read_text(errors='replace')[-4000:]
if status=='candidate_finished' and ('GRAPH_SOLVER_FINISHED' not in tail or '?' in tail):status='solver_error'
report.update(status=status,elapsed_seconds=elapsed,unit_candidate='UNIT_CANDIDATE' in tail,
    log_tail=tail,verification='Exact input-graph equivalence only; solver candidate not independently certified.')
(out/'result.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(json.dumps({key:report[key] for key in ('status','elapsed_seconds','unit_candidate')}),flush=True)
