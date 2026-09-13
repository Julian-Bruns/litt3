"""Bounded ten-order module elimination diagnostic of ORIGINAL low rows.

The32 v coordinates are module components, not polynomial variables.
Pure component1 outputs are exact b-only consequences. Failure to find
them is not an atlas result; high Frobenius/saturation equations remain.
"""
import argparse,concurrent.futures,hashlib,json,os,random,subprocess,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--chart',type=int,default=23)
ap.add_argument('--out',required=True);ap.add_argument('--seconds',type=int,default=30)
ap.add_argument('--term-first',action='store_true',help='Direct target-membership tests with degree before module component; do not force elimination of all v components first')
ap.add_argument('--workers',type=int,default=10);args=ap.parse_args()
assert 1<=args.workers<=10 and 1<=args.seconds<=600
folder=Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')/('chart-%02d'%args.chart)
out=Path(args.out);out.mkdir(parents=True,exist_ok=False)
raw=(folder/'initial_rref.json').read_bytes(); data=json.loads(raw)
k=GF(25,'a',modulus=PolynomialRing(GF(5),'j')([2,4,1]));a=k.gen()
bnames=['b%d'%i for i in range(args.chart+1,32)]
P=PolynomialRing(k,names=['v%d'%i for i in range(32)]+bnames)
loc=dict(zip(P.variable_names(),P.gens()));loc['a']=a
rows=[P(sage_eval(s,locals=loc)) for s in data['rows']]
vectors=[]
for f in rows:
    assert all(sum(ex[:32])<=1 for ex in f.dict())
    coeff=[f.derivative(z) for z in P.gens()[:32]]
    const=f-sum((z*c for z,c in zip(P.gens(),coeff)),P.zero())
    assert not any(sum(e[:32]) for e in const.dict())
    assert f==const+sum(z*c for z,c in zip(P.gens(),coeff))
    vectors.append('['+','.join(str(g).replace('**','^') for g in [const]+coeff)+']')
source='module M='+',\n'.join(vectors)+';\n'
rng=random.Random(int(20260908));orders=[bnames,list(reversed(bnames))]
while len(orders)<args.workers:
    order=bnames.copy();rng.shuffle(order)
    if order not in orders:orders.append(order)
orders=orders[:args.workers]
receipt=dict(source=str(folder/'initial_rref.json'),source_sha256=hashlib.sha256(raw).hexdigest(),
    exact_component_reconstruction=True,rows=len(rows),module_rank=33,polynomial_variables=len(bnames),
    workers=int(args.workers),seconds_limit=int(args.seconds),
    term_first=bool(args.term_first),
    scope='Low-row module diagnostic only. No high Frobenius equations; a checked unit suffices, failure does not decide atlas existence.')
(out/'input.json').write_text(json.dumps(receipt,indent=2,default=int)+'\n')
def solve(job):
    i,names=job;sub=out/('order-%02d'%i);sub.mkdir();started=time.monotonic()
    ringorder=('(dp,C)' if i%4==0 else '(dp,c)' if i%4==1 else '(Dp,C)' if i%4==2 else '(Dp,c)') if args.term_first else '(C,dp)'
    program='ring r=(5,a),('+','.join(names)+'),'+ringorder+'; minpoly=a^2-a+2; short=0;\n'+source
    program+='option(prot); print("MODULE_STARTED"); module G=std(M); print("MODULE_FINISHED"); size(G);\n'
    if args.term_first:
        program+='module T=[1]; module remainder=reduce(T,G); if(size(remainder)==0){print("MODULE_UNIT_CANDIDATE");}\n'
        program+='write("'+str(sub/'basis.sing')+'",G); quit;\n'
    else:
        program+='module R; int i,j,only; for(i=1;i<=size(G);i++){only=1; for(j=2;j<=33;j++){if(G[i][j]!=0){only=0;}} if(only){R=R,G[i];}}\n'
        program+='R=simplify(R,2); print("PURE_COUNT"); size(R); write("'+str(sub/'basis.sing')+'",G);\n'
        program+='if(size(R)>0){matrix H=lift(M,R); write("'+str(sub/'relations.sing')+'",R); write("'+str(sub/'lift.sing')+'",H); if(M*H==R){print("LIFT_REPLAY_PASS");}else{ERROR("lift mismatch");}} quit;\n'
    (sub/'input.sing').write_text(program)
    env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
    with (sub/'solver.log').open('w') as log:
        try:
            done=subprocess.run(['Singular','-q',str(sub/'input.sing')],stdout=log,stderr=subprocess.STDOUT,
                env=env,timeout=int(args.seconds));status='finished_needs_inspection' if done.returncode==0 else 'error'
        except subprocess.TimeoutExpired:status='time_limit'
    tail=(sub/'solver.log').read_text(errors='replace')[-4000:]
    if status=='finished_needs_inspection' and ('MODULE_FINISHED' not in tail or '?' in tail):status='error'
    result=dict(order=names,module_order=ringorder,status=status,seconds=time.monotonic()-started,
        unit_candidate='MODULE_UNIT_CANDIDATE' in tail,log_tail=tail)
    (sub/'result.json').write_text(json.dumps(result,indent=2,default=int)+'\n')
    print(i,status,round(result['seconds'],2),tail[-300:],flush=True);return result
with concurrent.futures.ThreadPoolExecutor(max_workers=int(args.workers)) as pool:
    results=list(pool.map(solve,enumerate(orders)))
(out/'results.json').write_text(json.dumps(results,indent=2,default=int)+'\n')
