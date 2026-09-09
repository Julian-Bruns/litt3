"""Audited three-column normalized atlas system, first acyclic oper.

Replaces superseded weak-incidence/12-seed and dense576-row diagnostics.
All32 original Frobenius equations remain. One-core bounded diagnostics.
The selected-column theorem applies to all18; this loader is first-oper.
"""
import argparse, hashlib, json, os, resource, subprocess, time
from pathlib import Path
ap=argparse.ArgumentParser()
ap.add_argument('--out',required=True)
ap.add_argument('--seconds',type=int,default=0)
ap.add_argument('--lift',action='store_true',help='Exact graph lift of all32 fifth powers')
ap.add_argument('--chain',action='store_true',help='Use the exact six-chain section basis and its dual')
ap.add_argument('--factor',action='store_true',help='Factor the inverse cubics through a minimal shared bilinear space')
ap.add_argument('--solver',choices=['slimgb','sba'],default='slimgb')
ap.add_argument('--signature-order',type=int,choices=[0,1,2,3],default=0)
ap.add_argument('--frobenius-first',action='store_true',help='Order the pure Frobenius constraints first for incremental signatures')
ap.add_argument('--chart',type=int,choices=range(32),help='Restrict the ORIGINAL b coordinates to a solved projective chart; all basis variants preserve this same chart')
ap.add_argument('--slice-only',action='store_true',help='Diagnostic necessary subset: retain fixed-chart Frobenius roots, omit only the remaining nonlinear Frobenius equations')
ap.add_argument('--include-n',action='store_true',help='Also supply the 64 redundant rooted bilinear N equations; test low-degree generator order')
ap.add_argument('--compact-only',action='store_true',help='Use the already proved compact N/R/normalization system without inverse cubics')
args=ap.parse_args(); assert 0 <= args.seconds <= 300
if (args.include_n or args.compact_only) and (args.chain or args.factor or args.lift):
    ap.error('The new controlled N comparison uses the original, unlifted basis only')
out=Path(args.out).resolve(); out.mkdir(parents=True,exist_ok=False)
started=time.monotonic()
def log(*s): print(round(time.monotonic()-started,2),*s,flush=True)
base=Path(__file__).resolve().parents[1]/'Research/computations'
names=['canonical_atlas_system','wronskian_quadratic_bezout','wronskian_serre_dual']
raw=[(base/(n+'.json')).read_bytes() for n in names]
canon,bez,dual=map(json.loads,raw)
cert=json.loads((base/'inverse_cup_seed_certificate.json').read_text())
for name,blob in zip(names,raw):
    assert hashlib.sha256(blob).hexdigest()==cert['source_sha256'][name]
k=GF(25,'a',modulus=PolynomialRing(GF(5),'j')([2,4,1]));a=k.gen()
cache={}
def get(c):
    if c not in cache:cache[c]=k(sage_eval(c,locals={'a':a}))
    return cache[c]
mat=lambda rows:matrix(k,[[get(c) for c in row] for row in rows])
Rc=[mat(m) for m in canon['R_tensor']]
Nc=[mat(m) for m in canon['N_tensor']] if args.include_n or args.compact_only else None
Bc=mat(canon['Bc']); S=mat(dual['S_matrix'])
Bt=[(tuple(q['pair']),mat(q['matrix'])) for q in bez['tensor']]
T=PolynomialRing(k,'x'); x=T.gen()
F=T([2*a+1,4*a+2,3*a+3,a,3*a+4,4*a,3*a,3*a+1,a+4,4*a+2,1])
pos={tuple(q):j for j,q in enumerate(dual['monomials_L64'])}
mons=[tuple(q) for q in bez['L32_monomials']]
products=[]
for p,q in mons:
    for r,s in mons:
        row=vector(k,56)
        for h,c in enumerate((x**(p+r)*F**((q+s)//3)).list()):
            if c:row[pos[h,(q+s)%3]]=c
        products.append(row)
Pm=matrix(k,products); selected=(4,21,23)
assert [mons[j] for j in selected]==[(0,1),(10,0),(4,2)]
mult=matrix(k,[Pm.row(24*i+j) for j in selected for i in range(24)])
assert mult.rank()==56
Gs=[]
for j in range(32):
    row=Pm*(Bc.column(j)*S)
    Gs.append(matrix(k,24,24,[c**5 for c in row]))
log('source hashes, full Gamma and spanning three-column minor PASS')
if args.chain:
    from atlas_chain_coordinates import chain_coordinates
    change=chain_coordinates(k,mat(canon['SU_basis']),canon['SU_monomials'])
    ci=change.inverse();ci5=ci.apply_map(lambda c:c**5)
    # Section coordinates transform by change^T; the dual coordinates
    # transform by change^-1. These are coefficient, not variable, powers.
    oldRc=Rc
    Rc=[change*sum((change[i,j]*oldRc[j] for j in range(32)),zero_matrix(k,32))*ci5 for i in range(32)]
    gflat=ci5.transpose()*matrix(k,[G.list() for G in Gs])
    Gs=[matrix(k,24,24,row) for row in gflat.rows()]
    newflat=zero_matrix(k,528,576)
    bflat=[B.list() for _,B in Bt]
    for h in range(576):
        sym=zero_matrix(k,32)
        for z,((i,j),B) in enumerate(Bt):
            sym[i,j]=bflat[z][h] if i==j else bflat[z][h]/2
            sym[j,i]=sym[i,j]
        transformed=change*sym*change.transpose()
        for z,((i,j),B) in enumerate(Bt):
            newflat[z,h]=transformed[i,j]*(1 if i==j else 2)
    Bt=[(pair,matrix(k,24,24,newflat.row(i))) for i,(pair,_) in enumerate(Bt)]
    (out/'chain_change.json').write_text(json.dumps([[str(c) for c in row] for row in change.rows()])+'\n')
    log('invertible six-chain and dual basis changes PASS')
entries=[(r,c) for c in selected for r in range(24)]
H=zero_matrix(k,72,16897)
for h,((i,j),B) in enumerate(Bt):
    rows=[]
    for G in Gs:
        bg=B*G; rows.append([bg[r,c] for r,c in entries])
    H.set_block(0,32*h,matrix(k,rows).transpose())
for z,(r,c) in enumerate(entries):
    if r==c:H[z,16896]=-1
counts=[sum(bool(c) for c in row) for row in H.rows()]
log('all72 cubic coefficient rows ready',sum(counts),'terms')
factor_data=None
if args.factor:
    receipt=Path('/Users/julian/Documents/litt3-computation-data/pencil-bezout-first-20260908-v2/certificate.json')
    pd=json.loads(receipt.read_text())
    assert pd['source_sha256']['wronskian_quadratic_bezout']==hashlib.sha256(raw[1]).hexdigest()
    assert pd['all528_quadratic_matrices_replayed'] and pd['constant_cech_scale']=='4'
    Ps=[matrix(T,3,6,[T([get(c)**5 for c in ff]) for rr in pp for ff in rr]) for pp in pd['P_coefficient_frobenius']]
    Ji=mat(pd['frame_pairing_frobenius']).apply_map(lambda c:c**5).inverse()
    if args.chain:
        oldPs=Ps;chroot=change.apply_map(lambda c:c**5)
        Ps=[sum((chroot[i,j]*oldPs[j] for j in range(32)),zero_matrix(T,3,6)) for i in range(32)]
    Gactual=[G.apply_map(lambda c:c**5) for G in Gs]
    Hbil=zero_matrix(k,198,1024)
    monindex={p:i for i,p in enumerate(mons)}
    for cc,c in enumerate(selected):
        Gc=matrix(k,[G.column(c) for G in Gactual]).transpose()
        for i,pp in enumerate(Ps):
            convolution=matrix(k,66,24,lambda rr,ll:pp[mons[ll][1],rr//11][rr%11+mons[ll][0]+1])
            Hbil.set_block(66*cc,32*i,convolution*Gc)
    Sbil=matrix(k,32,1024,lambda rr,ll:Rc[ll//32][rr,ll%32]**5)
    assert Sbil.rank()==32
    combined=Sbil.stack(Hbil)
    independent=list(combined.transpose().pivots())
    assert independent[:32]==list(range(32))
    shared=combined.matrix_from_rows(independent);rho=shared.nrows()
    piv=list(shared.pivots());left=combined.matrix_from_columns(piv)*shared.matrix_from_columns(piv).inverse()
    assert left*shared==combined
    factor_rows=[]
    for cc,c in enumerate(selected):
        for r in range(24):
            deg,sheet=mons[r];coeff=zero_matrix(k,32,rho)
            for i,pp in enumerate(Ps):
                pj=pp*Ji
                for alpha in range(6):
                    for j in range(11):
                        if j<=deg and pj[sheet,alpha][deg-j]:
                            coeff[i]+=4*pj[sheet,alpha][deg-j]*left.row(32+66*cc+11*alpha+j)
            # Replay every coefficient after substituting the shared bilinears.
            expanded=coeff*shared;row=vector(k,16897)
            for z,((i,j),_) in enumerate(Bt):
                for l in range(32):
                    row[32*z+l]=expanded[i,32*j+l]+(expanded[j,32*i+l] if i!=j else 0)
            if r==c:row[-1]=-1
            assert row==H.row(24*cc+r).apply_map(lambda z:z**5),('factored inverse coefficient',r,c)
            factor_rows.append(coeff)
    factor_data=dict(shared_rank=rho,all72_expansion_identities=True,
        graph_terms=sum(bool(c) for c in shared.list()),
        inverse_terms=sum(sum(bool(c) for c in m.list()) for m in factor_rows),
        original_bilinears=230,independent_rows=independent)
    (out/'factor_certificate.json').write_text(json.dumps(factor_data,indent=2,default=int)+'\n')
    log('minimal shared factorization PASS',factor_data)
varnames=['v%d'%i for i in range(32)]+['b%d'%i for i in range(32)]
if args.factor:varnames+=['h%d'%i for i in range(rho)]
elif args.lift:varnames+=['z%d'%i for i in range(32)]
P=PolynomialRing(k,names=varnames,order='degrevlex'); nv=P.ngens()
v=P.gens()[:32]; b=P.gens()[32:64]
exponents=[]
for (i,j),_ in Bt:
    for h in range(32):
        e=[0]*nv;e[i]+=1;e[j]+=1;e[32+h]=1;exponents.append(tuple(e))
exponents.append(tuple([0]*nv))
inverse=[P({exponents[j]:c**5 for j,c in enumerate(row) if c}) for row in H.rows()]
s=[]
for r in range(32):
    terms={}
    for i in range(32):
        for j in range(32):
            c=Rc[i][r,j]
            if c:
                e=[0]*nv;e[i]=1;e[32+j]=1;terms[tuple(e)]=c**5
    s.append(P(terms))
frob=lambda f:P({tuple(5*j for j in e):c**5 for e,c in f.dict().items()})
equations=inverse+[b[i]-frob(s[i]) for i in range(32)]
if args.factor:
    hh=P.gens()[64:]
    graph=[]
    for h,row in enumerate(shared.rows()):
        terms={}
        for j,c in enumerate(row):
            if c:
                e=[0]*nv;e[j//32]+=1;e[32+j%32]+=1;terms[tuple(e)]=c
        graph.append(hh[h]-P(terms))
    facinverse=[]
    for cc,m in enumerate(factor_rows):
        terms={}
        for i in range(32):
            for j in range(rho):
                if m[i,j]:
                    e=[0]*nv;e[i]+=1;e[64+j]+=1;terms[tuple(e)]=m[i,j]
        facinverse.append(P(terms)-(1 if entries[cc][0]==entries[cc][1] else 0))
    equations=graph+facinverse+[b[i]-hh[i]**5 for i in range(32)]
elif args.lift:
    z=P.gens()[64:]
    equations=inverse+[z[i]-s[i] for i in range(32)]+[b[i]-z[i]**5 for i in range(32)]
if Nc is not None:
    n=[]
    for r in range(64):
        terms={}
        for i in range(32):
            for j in range(32):
                c=Nc[i][r,j]
                if c:
                    e=[0]*nv;e[i]=1;e[32+j]=1;terms[tuple(e)]=c**5
                    assert (c**5)**5==c
        n.append(P(terms))
    # Compact N/R plus the scalar normalization is an existing exact
    # criterion, not a new theorem. Adding N to the audited inverse system
    # is redundant, but may change the elimination substantially.
    core=[] if args.compact_only else equations[:-32]
    core+=n
    if args.chart is None:
        core+=[sum((v[i]*s[i] for i in range(32)),P.zero())-2]
    equations=core+equations[-32:]
    if args.compact_only: entries=[]
    log('original rooted N coefficient powers replayed',64,
        'inverse retained',not args.compact_only)
if args.slice_only and args.chart is None:
    raise ValueError('--slice-only needs --chart')
if args.chart is not None:
    chart=args.chart
    names=['v%d'%i for i in range(32)]+['b%d'%i for i in range(chart+1,32)]+list(P.variable_names()[64:])+['chart_inverse']
    small=PolynomialRing(k,names=names,order='degrevlex');ng=small.ngens()
    old_b=vector(small,[0]*chart+[1]+list(small.gens()[32:63-chart]))
    new_b=change.change_ring(small)*old_b if args.chain else old_b
    # Every input term uses at most one b variable, with exponent 1 or 5.
    # Expand just that linear form, using Frobenius sparsity for exponent5.
    # This avoids repeated generic substitution of 800k cubic terms.
    linear=[list(f.dict().items()) for f in new_b]
    def chart_substitute(f):
        terms={}
        for ex,c in f.dict().items():
            base=list(ex[:32])+[0]*(31-chart)+list(ex[64:])+[0]
            used=[i for i in range(32) if ex[32+i]]
            if not used:
                key=tuple(base);terms[key]=terms.get(key,k.zero())+c;continue
            assert len(used)==1
            j=used[0];power=ex[32+j];assert power in (1,5)
            for eb,cb in linear[j]:
                key=tuple(h+power*z for h,z in zip(base,eb))
                terms[key]=terms.get(key,k.zero())+c*cb**power
        return small({ex:c for ex,c in terms.items() if c})
    core=[chart_substitute(f) for f in equations[:-32]]
    primitive=list(P.gens()[64:96]) if args.factor or args.lift else s
    primitive=vector(small,[chart_substitute(f) for f in primitive])
    norm=sum((small.gen(i)*primitive[i] for i in range(32)),small.zero())
    # Projective chart normalization is s_j=1, NOT v.s=2. The inverse
    # equation therefore reads B Gamma=(v.s/2)I, with v.s invertible.
    # Fixing the right side to I would silently keep only a smaller slice.
    inverse_start=rho if args.factor else 0
    for z,(r,c) in enumerate(entries):
        if r==c:core[inverse_start+z]+=1-norm/2
    # The script's coefficient-root convention transforms s_new=C^[5]s_old,
    # whereas b_new=C b_old. Undo that change BEFORE taking chart roots.
    if args.chain:primitive=ci.apply_map(lambda c:c**5).change_ring(small)*primitive
    fixed=[primitive[i]-(1 if i==chart else 0) for i in range(chart+1)]
    chart_fifth=lambda f:small({tuple(5*j for j in ex):c**5 for ex,c in f.dict().items()})
    remaining=[] if args.slice_only else [old_b[i]-chart_fifth(primitive[i]) for i in range(chart+1,32)]
    equations=core+fixed+remaining+[small.gen(ng-1)*norm-1]
    P=small;nv=ng
    log('same ORIGINAL chart specialized',chart,'equations',len(equations),'variables',nv,
        'remaining Frobenius omitted',args.slice_only)
if args.frobenius_first:
    if args.chart is not None:
        count=args.chart+1 if args.slice_only else 32
        equations=equations[-count-1:-1]+equations[:-count-1]+equations[-1:]
    else:equations=equations[-32:]+equations[:-32]
elif Nc is not None:
    # Low degree first is the point of this controlled comparison.
    # This is only a permutation; all original Frobenius and guard equations
    # remain. A successful unit still needs an original-equation certificate.
    equations.sort(key=lambda f:(f.total_degree(),len(f.dict())))
report=dict(source_sha256=cert['source_sha256'],variables=nv,selected_columns=list(selected),
    selected_monomials=[mons[j] for j in selected],multiplication_rank=56,
    inverse_equations=0 if args.compact_only else 72,inverse_terms=counts,frobenius_equations=32,
    rooted_n_equations=64 if Nc is not None else 0,compact_only=bool(args.compact_only),
    total_equations=len(equations),graph_lift=bool(args.lift),six_chain_basis=bool(args.chain),factored=factor_data,
    solver=args.solver,signature_order=int(args.signature_order),frobenius_first=bool(args.frobenius_first),
    theorem=('rooted_atlas_charts; complete compact N/R/normalization' if args.compact_only else
             'inverse_cup_atlas_system v5 Section9, audited selected-column equivalence'),
    chart=args.chart,slice_only=bool(args.slice_only),
    projective_inverse_scale='v.s/2' if args.chart is not None else '1',
    chart_guard_equations=1 if args.chart is not None else 0,
    scope=('First oper; necessary chart subset only' if args.slice_only else
           'First oper; full normalized locus. Fixed-chart fifth powers replaced by their roots, so point-equivalent, not scheme-equivalent.' if args.chart is not None else
           'First oper; full normalized scheme, ALL Frobenius conditions'),
    elapsed_seconds=time.monotonic()-started)
(out/'input_certificate.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
log('polynomials ready',len(equations),'equations',nv,'variables')
program='ring r=(5,a),('+','.join(P.variable_names())+'),dp; minpoly=a^2-a+2; short=0;\n'
program+='ideal I='+',\n'.join(str(f).replace('**','^') for f in equations)+';\n'
engine_call='sba(I,%d,1)'%args.signature_order if args.solver=='sba' else 'slimgb(I)'
program+='option(prot); print("THREE_COLUMN_STARTED"); ideal G='+engine_call+';\n'
program+='write("'+str(out/'basis.sing')+'",G);\n'
program+='print("THREE_COLUMN_FINISHED"); size(G); if(G[1]==1){print("UNIT_CANDIDATE");} quit;\n'
(out/'input.sing').write_text(program)
log('input written',len(program),'bytes')
if args.seconds:
    def limits():resource.setrlimit(resource.RLIMIT_CPU,(args.seconds+1,args.seconds+2))
    env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
    t0=time.monotonic()
    with (out/'solver.log').open('w') as f:
        try:
            run=subprocess.run(['Singular','-q',str(out/'input.sing')],stdout=f,stderr=subprocess.STDOUT,
                env=env,preexec_fn=limits,timeout=args.seconds)
            status='candidate_finished' if run.returncode==0 else 'solver_error'
        except subprocess.TimeoutExpired:status='time_limit'
    tail=(out/'solver.log').read_text(errors='replace')[-5000:]
    if status=='candidate_finished' and ('THREE_COLUMN_FINISHED' not in tail or '?' in tail):status='solver_error'
    result=dict(status=status,seconds=time.monotonic()-t0,unit_candidate='UNIT_CANDIDATE' in tail,
        log_tail=tail,verification='Audited exact input reduction; solver output needs independent certificate.')
    (out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
    log('bounded diagnostic',result['status'],result['seconds'])
