#!/usr/bin/env sage
"""Exact rooted chart preprocessing/export, no Groebner solver.

Run: sage scripts/export_rooted_atlas.sage [--tensor PATH] [--chart J] [--output DIRECTORY]
Coefficients use the exact serialized finite field, including towers.
Inputs over F5 include every defining equation of the coefficient field.
"""
import argparse, functools, hashlib, json, multiprocessing, os, resource, time
from pathlib import Path
from atlas_resources import fork_workers
from sage.misc.persist import save as save_object,load as load_object

ap=argparse.ArgumentParser()
ap.add_argument('--chart',type=int)
ap.add_argument('--tensor',type=Path)
ap.add_argument('--force',action='store_true',help='Regenerate even validated existing exports')
ap.add_argument('--workers',type=int,default=1,help='Independent chart workers; coefficient data are shared by fork')
ap.add_argument('--memory-gib',type=float,default=8,help='Conservative aggregate RSS budget for chart workers')
ap.add_argument('--max-charts',type=int,help='Export at most this many missing charts, retaining the complete manifest')
ap.add_argument('--audit-generic',action='store_true',help='Also run the old generic specialization on bounded regression inputs')
ap.add_argument('--linear-backend',choices=('auto','sage','flint'),default='auto')
ap.add_argument('--rooting-backend',choices=('auto','sage','native'),default='auto')
ap.add_argument('--audit-linear-algebra',action='store_true',help='Compare every native RREF and row identity with Sage')
ap.add_argument('--output',type=Path,default=Path('/Users/julian/Documents/litt3-computation-data/atlas-rooted-first'))
args=ap.parse_args()
if args.workers<1 or args.memory_gib<=0 or (args.max_charts is not None and args.max_charts<1):
    ap.error('workers, memory budget, and max-charts must be positive')
load_started=time.monotonic()
root=Path(__file__).resolve().parents[1]
source=args.tensor or root/'Research/computations/canonical_atlas_system.json'
def file_sha256(path):
    digest=hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda:stream.read(1024*1024),b''): digest.update(chunk)
    return digest.hexdigest()
with source.open() as stream: d=json.load(stream)
source_sha=file_sha256(source)
description=d.get('field_description') or dict(kind='finite_field',characteristic=5,
    degree=2,generator='a',modulus=[2,4,1])
layers=[]; field_locals={}
def decode(value,level):
    fld,desc=layers[level]
    if desc['kind']=='finite_field': return fld(value)
    return fld([decode(c,level-1) for c in value])
def make_field(desc):
    name=desc['generator']
    if desc['kind']=='finite_field':
        assert desc['characteristic']==5
        fld=GF(5**int(desc['degree']),name=name,
               modulus=PolynomialRing(GF(5),'z')(desc['modulus']),check_irreducible=False)
    else:
        assert desc['kind']=='polynomial_quotient_field'
        base=make_field(desc['base']); T=PolynomialRing(base,'fieldvariable')
        fld=T.quotient(T([decode(c,len(layers)-1) for c in desc['modulus']]),names=name)
    layers.append((fld,desc)); field_locals[name]=fld.gen()
    return fld
k=make_field(description)
field_locals={name:k(value) for name,value in field_locals.items()}
if 'base_F25_generator' in description:
    field_locals['a']=decode(description['base_F25_generator'],len(layers)-1)
field_degree=prod(int(desc['degree']) for fld,desc in layers)
inverse_frobenius_exponent=5**(field_degree-1)
native_rref=None; native_rooting=None
if args.linear_backend in ('auto','flint') or args.rooting_backend in ('auto','native'):
    from atlas_native_rref import NativeRref
    try: field_bridge=NativeRref(k,layers)
    except NotImplementedError as error:
        if args.linear_backend=='flint' or args.rooting_backend=='native': raise
        print(json.dumps({'native_field_fallback':str(error)}),flush=True)
    else:
        if args.linear_backend in ('auto','flint'): native_rref=field_bridge
        if args.rooting_backend=='native' or (args.rooting_backend=='auto' and
                (len(layers)==1 or field_degree>12)):
            native_rooting=field_bridge
cache={}
def get(c):
    key=c if isinstance(c,str) else json.dumps(c,separators=(',',':'))
    if key not in cache:
        cache[key]=k(sage_eval(c,locals=field_locals)) if isinstance(c,str) else decode(c,len(layers)-1)
    return cache[key]
root_cache={}
def fifth_root(c):
    value=get(c)
    if value not in root_cache:
        rooted=(native_rooting.from_native(native_rooting.to_native(value)**inverse_frobenius_exponent)
                if native_rooting is not None else value**inverse_frobenius_exponent)
        assert rooted**5==value
        root_cache[value]=rooted
    return root_cache[value]
args.output.mkdir(parents=True,exist_ok=True)
rooted_folder=args.output/'rooted_coefficients';rooted_folder.mkdir(exist_ok=True)
def _root_json(path,value):
    temporary=Path(str(path)+'.tmp')
    temporary.write_text(json.dumps(value,default=int)+'\n');temporary.replace(path)
def _rooted_block(i):
    started=time.monotonic();path=rooted_folder/('block_%02d.sobj'%i)
    meta_path=rooted_folder/('block_%02d.json'%i)
    if path.exists() and meta_path.exists():
        meta=json.loads(meta_path.read_text())
        assert meta['source_sha256']==source_sha and meta['block']==i
        assert meta['all_fifth_power_identities_verified'] and meta['sha256']==file_sha256(path)
        block=load_object(str(path));assert block['source_sha256']==source_sha and block['block']==i
        n,r=block['N_root'],block['R_root'];resumed=True
    else:
        n=[[fifth_root(c) for c in row] for row in d['N_tensor'][i]]
        r=[[fifth_root(c) for c in row] for row in d['R_tensor'][i]]
        assert all(c**5==get(old) for row,oldrow in zip(n,d['N_tensor'][i]) for c,old in zip(row,oldrow))
        assert all(c**5==get(old) for row,oldrow in zip(r,d['R_tensor'][i]) for c,old in zip(row,oldrow))
        block=dict(source_sha256=source_sha,block=i,N_root=n,R_root=r)
        temporary=rooted_folder/('block_%02d.tmp.sobj'%i)
        save_object(block,str(temporary));temporary.replace(path)
        _root_json(meta_path,dict(source_sha256=source_sha,block=i,sha256=file_sha256(path),
            all_fifth_power_identities_verified=True,rooting_backend='native' if native_rooting is not None else 'sage'))
        resumed=False
    assert len(n)==64 and len(r)==32 and all(len(row)==32 for row in n+r)
    # Preserve useful small-field repetitions across blocks, but bound the
    # per-worker high-degree coefficient cache.
    cache_limit=max(16,min(16384,200000//int(field_degree)))
    if len(cache)>cache_limit: cache.clear()
    if len(root_cache)>cache_limit: root_cache.clear()
    print(json.dumps(dict(rooted_coefficient_block=int(i),resumed=resumed,pid=os.getpid(),
                         seconds=time.monotonic()-started)),flush=True)
    return int(i),n,r
rss=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
if os.uname().sysname!='Darwin': rss*=1024
root_workers,root_estimate=fork_workers(args.workers,32,rss,args.memory_gib*1024**3)
print(json.dumps(dict(rooted_coefficient_workers=root_workers,blocks=32,
    estimated_worker_rss_bytes=root_estimate,rooting_backend='native' if native_rooting is not None else 'sage'),default=int),flush=True)
coeff=[None]*32;rcoeff=[None]*32;root_done=0;root_started=time.monotonic()
def accept_root_block(result):
    global root_done
    i,n,r=result;coeff[i]=n;rcoeff[i]=r;root_done+=1
    _root_json(args.output/'rooted_coefficient_progress.json',dict(source_sha256=source_sha,
        completed_blocks=root_done,total_blocks=32,workers=root_workers,
        elapsed_seconds=time.monotonic()-root_started,updated=time.time()))
if root_workers==1:
    for i in range(32): accept_root_block(_rooted_block(i))
else:
    with multiprocessing.get_context('fork').Pool(root_workers) as pool:
        for result in pool.imap_unordered(_rooted_block,range(32),chunksize=1):accept_root_block(result)
assert root_done==32 and all(block is not None for block in coeff+rcoeff)
# Retain only the rooted tensors, not another full set of long coefficient
# strings plus decoded originals while processing the charts.
del d['N_tensor'],d['R_tensor']
cache.clear(); root_cache.clear()
def save(path,obj):
    tmp=path.with_suffix(path.suffix+'.tmp')
    tmp.write_text(json.dumps(obj,indent=2,default=int)+'\n'); tmp.replace(path)

def peak_rss():
    value=resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    return int(value if os.uname().sysname=='Darwin' else value*1024)

def coefficient_terms(value,level):
    fld,desc=layers[level]; value=fld(value)
    cp=value.polynomial() if desc['kind']=='finite_field' else value.lift()
    for h,c in enumerate(cp.list()):
        if not c: continue
        if level==0: yield (h,),GF(5)(c)
        else:
            for ex,prime in coefficient_terms(c,level-1): yield ex+(h,),prime

def coefficient_from_terms(terms,level):
    """Evaluate one power-basis coefficient, never a multivariate polynomial.

    The constructors also reduce the few defining field relations. Thus
    this remains exact for noncanonical exponents and arbitrary towers.
    """
    if not terms: return layers[level][0].zero()
    groups={}
    for ex,c in terms.items():
        groups.setdefault(ex[level],{})[ex[:level]]=c
    values=[0]*(max(groups)+1)
    for h,group in groups.items():
        values[h]=group[()] if level==0 else coefficient_from_terms(group,level-1)
    fld,desc=layers[level]
    if desc['kind']=='finite_field' and len(values)>int(desc['degree']):
        values=(fld.modulus().parent()(values)%fld.modulus()).list()
    return fld(values)

@functools.lru_cache(maxsize=int(max(16,min(8192,200000//int(field_degree)))))
def encoded_coefficient(value):
    terms=tuple(coefficient_terms(value,len(layers)-1))
    assert coefficient_from_terms(dict(terms),len(layers)-1)==value
    return terms

def specialize_sparse(q,F):
    groups={}; n=F.ngens()
    for ex,c in q.dict().items():
        groups.setdefault(tuple(ex[:n]),{})[tuple(ex[n:])]=c
    return F({ex:coefficient_from_terms(terms,len(layers)-1) for ex,terms in groups.items()})

def project_sparse(f,F,indices):
    """Variable renaming/restriction on an already verified support."""
    missing=set(range(f.parent().ngens()))-set(indices)
    terms={}
    for ex,c in f.dict().items():
        assert all(ex[h]==0 for h in missing)
        terms[tuple(ex[h] for h in indices)]=c
    return F(terms)

def row_reduce(polys,P,track=False):
    # Bilinear/nonlinear monomials first; then linear v, then any linear b,
    # then constant. The initial input has only bilinear, v, and constant.
    mons=set(m for f in polys for m in f.monomials())
    names=P.variable_names()
    def key(m):
        deg=m.total_degree()
        if deg>1: return (0,str(m))
        if deg==1: return (1 if str(m).startswith('v') else 2,names.index(str(m)))
        return (3,0)
    mons=sorted(mons,key=key)
    exponents=[tuple(m.exponents()[0]) for m in mons]
    dictionaries=[{tuple(ex):c for ex,c in f.dict().items()} for f in polys]
    M=matrix(k,[[terms.get(ex,k.zero()) for ex in exponents] for terms in dictionaries])
    assert all(P({ex:c for ex,c in zip(exponents,row) if c})==f for row,f in zip(M.rows(),polys))
    if native_rref is not None:
        A,C=native_rref.rref(M,audit_sage=args.audit_linear_algebra)
        rank=A.nrows()
        if not track: C=None
    elif track:
        E=M.augment(identity_matrix(k,len(polys))).echelon_form()
        rank=sum(1 for p in E.pivots() if p<len(mons))
        A=E[:rank,:len(mons)]; C=E[:rank,len(mons):]
        assert C*M==A
    else:
        E=M.echelon_form(); rank=E.rank(); A=E[:rank,:]; C=None
    reduced=[P({ex:c for c,ex in zip(row,exponents) if c}) for row in A.rows()]
    return reduced,C,{'rows':len(polys),'columns':len(mons),'rank':rank}

def frob(f):
    return f.parent()({tuple(5*i for i in ex):c**5 for ex,c in f.dict().items()})

def export_chart(j):
    started=time.monotonic(); folder=args.output/('chart-%02d'%j); folder.mkdir(exist_ok=True)
    phase_times={}; phase_started=started; last_progress=0
    def phase(name,done=0,total=0):
        nonlocal phase_started,last_progress
        now=time.monotonic()
        if done==0:
            previous=getattr(phase,'name',None)
            if previous: phase_times[previous]=now-phase_started
            phase.name=name; phase_started=now
        if done==0 or done==total or now-last_progress>=1:
            save(folder/'export_progress.json',dict(chart=j,pid=os.getpid(),source_sha256=source_sha,
                phase=name,units_done=done,units_total=total,phase_seconds=now-phase_started,
                elapsed_seconds=now-started,phase_timings_seconds=phase_times,peak_rss_bytes=peak_rss(),updated=time.time()))
            last_progress=now
    if not args.force and (folder/'metadata.json').exists():
        old=json.loads((folder/'metadata.json').read_text())
        assert old['source_sha256']==source_sha
        if old['status']=='excluded_exact_constant_combination':
            assert old['constant_combination_identity_verified']
            return old
        assert file_sha256(folder/'input.ms')==old['input_sha256']
        assert old['coefficient_specialization_and_text_roundtrip_verified']
        return old
    phase('tensor_substitution')
    names=['v%d'%i for i in range(32)]+['b%d'%i for i in range(j+1,32)]+['w']
    P=PolynomialRing(k,names=names,order='degrevlex'); vv=P.gens()[:32]
    b=[P.zero()]*j+[P.one()]+list(P.gens()[32:-1]); w=P.gens()[-1]
    def tensor(C,count):
        rows=[{} for r in range(count)]
        for i in range(32):
            for h in range(j,32):
                ex=[0]*P.ngens(); ex[i]=1
                if h>j: ex[31+h-j]=1
                ex=tuple(ex)
                for r in range(count):
                    if C[i][r][h]: rows[r][ex]=C[i][r][h]
        return [P(row) for row in rows]
    n=tensor(coeff,64); s=tensor(rcoeff,32)
    originals=n+[s[h]-(1 if h==j else 0) for h in range(j+1)]
    phase('initial_rref')
    low,C,stat=row_reduce(originals,P,True)
    meta={'chart':j,'field':str(k),'field_description':description,'field_degree_F5':field_degree,
          'source_sha256':source_sha,'original_v_variables':32,'original_remaining_b_variables':31-j,
          'chart_substitution':{'b%d'%h:('1' if h==j else '0') for h in range(j+1)},
          'original_low_equation_order':'n0..n63, s0,...,s(j-1),sj-1 after chart substitution',
          'initial_rref':stat,'rref_column_order':'degree>=2, linear v, other linear, constant',
          'coefficient_fifth_root_verified':True,
          'scope':'Fixed genus-nine untwisted oper. Quotient chart, three normalized lifts. No all-torsion/common-cover claim.',
          'oper_representative':d.get('rep','orbit_0000')}
    for row,f in enumerate(low):
        if f and f.total_degree()==0:
            weights=C.row(row)/k(f)
            assert sum((c*g for c,g in zip(weights,originals)),P.zero())==1
            meta.update(status='excluded_exact_constant_combination',constant_combination=[str(c) for c in weights],
                        constant_combination_identity_verified=True,elapsed_seconds=time.monotonic()-started)
            phase('complete'); meta.update(phase_timings_seconds=phase_times,peak_rss_bytes=peak_rss(),
                linear_algebra_backend=args.linear_backend,native_linear_algebra=native_rref.records if native_rref else [])
            save(folder/'metadata.json',meta)
            print(json.dumps({'chart':j,'status':meta['status'],'seconds':meta['elapsed_seconds']},default=int),flush=True)
            return meta
    # Preserve an exact initial basis-change certificate, compact constant matrix.
    save(folder/'initial_rref.json',{'row_combinations':[[str(c) for c in row] for row in C.rows()],
                                 'rows':[str(f) for f in low],
                                 'identity_C_times_original_equals_rows_verified':True})
    first_low=list(low); reconstruction=list(P.gens()); steps=[]
    phase('affine_elimination')
    # Recompute all nonlinear equations only after substitutions stabilize.
    # Each step solves an affine equation with a nonzero CONSTANT v coefficient.
    # Saved equations plus simultaneous substitutions are an exact elimination
    # certificate; no localization or variable denominator is introduced.
    for iteration in range(33):
        elim={}
        for f in low:
            if f.total_degree()!=1: continue
            candidates=[z for z in vv if f.monomial_coefficient(z)]
            if not candidates: continue
            z=candidates[0]; cc=f.monomial_coefficient(z)
            if z in elim: raise RuntimeError('RREF repeated affine v pivot')
            elim[z]=-(f-cc*z)/cc
        if not elim: break
        assert all(not set(g.variables()).intersection(elim) for g in elim.values())
        images=[elim.get(z,z) for z in P.gens()]; sub=P.hom(images,P)
        steps.append({'iteration':iteration,'solved_equations':[str(z-g) for z,g in elim.items()],
                      'substitution':{str(z):str(g) for z,g in elim.items()}})
        reconstruction=[sub(g) for g in reconstruction]
        low=[sub(f) for f in low]; low=[f for f in low if f]
        low,unused,stat=row_reduce(low,P,False)
        steps[-1]['next_rref']=stat
        if any(f and f.total_degree()==0 for f in low):
            # This cannot be silently claimed to have the stronger constant
            # certificate. Save the exact elimination trail and export the
            # original constant-row-reduced chart for independent solving.
            save(folder/'needs_polynomial_certificate.json',{'steps':steps,'rows':[str(f) for f in low]})
            meta['affine_unit_without_constant_certificate']='Original chart retained for solver; no direct exclusion claimed.'
            low=first_low; reconstruction=list(P.gens()); steps=[]
            break
    else: raise RuntimeError('Affine elimination did not terminate')
    phase('final_equations')
    if reconstruction==list(P.gens()):
        ss=s; vfinal=vv
    else:
        sub=P.hom(reconstruction,P)
        assert all(sub(g)==g for g in reconstruction)
        ss=[sub(f) for f in s]; vfinal=[sub(z) for z in vv]
    cfinal=sum((z*t for z,t in zip(vfinal,ss)),P.zero())
    equations=low+[frob(ss[h])-b[h] for h in range(j+1,32)]+[w*cfinal-1]
    equations=[f for f in equations if f]
    # Retain any remaining affine b constraints; v elimination is exhaustive.
    assert 'affine_unit_without_constant_certificate' in meta or not any(f.total_degree()==1 and any(f.monomial_coefficient(z) for z in vv) for f in low)
    used=set(z for f in equations for z in f.variables())
    # Variables occurring only in reconstruction would be genuine free
    # parameters and must also be retained rather than silently forgotten.
    used.update(z for f in reconstruction for z in f.variables())
    finalnames=[str(z) for z in P.gens() if z in used]
    F=P if finalnames==names else PolynomialRing(k,names=finalnames,order='degrevlex')
    indices=[names.index(name) for name in finalnames]
    shrink=(lambda f:f) if F is P else (lambda f:project_sparse(f,F,indices))
    ff=[shrink(f) for f in equations]
    # One final variable per field layer; coefficients are expanded exactly
    # in the prescribed power bases, never by sampling finite-field values.
    fieldnames=[desc['generator'] for fld,desc in layers]
    assert not set(finalnames).intersection(fieldnames)
    Q=PolynomialRing(GF(5),names=finalnames+fieldnames,order='degrevlex')
    eval25=lambda q:specialize_sparse(q,F)
    generic_eval25=Q.hom(list(F.gens())+[k(fld.gen()) for fld,desc in layers],F) if args.audit_generic else None
    def encode_polynomial(f):
        terms={}
        for ex,cc in f.dict().items():
            for powers,prime in encoded_coefficient(cc):
                terms[tuple(ex)+powers]=prime
        q=Q(terms)
        assert eval25(q)==f
        if generic_eval25 is not None: assert generic_eval25(q)==f
        return q
    defining=[]
    for level,(fld,desc) in enumerate(layers):
        terms={}
        for h,c in enumerate(desc['modulus']):
            if level==0:
                if c: terms[(0,)*len(finalnames)+(h,)+(0,)*(len(layers)-1)]=GF(5)(c)
            else:
                for ex,prime in coefficient_terms(decode(c,level-1),level-1):
                    terms[(0,)*len(finalnames)+ex+(h,)+(0,)*(len(layers)-level-1)]=prime
        relation=Q(terms); assert eval25(relation)==0; defining.append(relation)
    target=folder/'input.ms'; temporary=folder/'input.ms.tmp'
    # Write and parse one equation at a time: large power-basis fields must
    # not require a second full encoded tensor or whole input-text copy.
    encoded_count=encoded_terms=encoded_degree=0
    phase('coefficient_export')
    stream=temporary.open('w'); stream.write(','.join(Q.variable_names())+'\n5\n')
    for f in ff:
        q=encode_polynomial(f)
        stream.write(str(q)+',\n'); encoded_count+=1
        encoded_terms+=len(q.dict()); encoded_degree=max(encoded_degree,q.total_degree())
        phase('coefficient_export',encoded_count,len(ff)+len(defining))
    for index,q in enumerate(defining):
        stream.write(str(q)+(',' if index+1<len(defining) else '')+'\n')
        encoded_count+=1; encoded_terms+=len(q.dict()); encoded_degree=max(encoded_degree,q.total_degree())
    stream.close()
    phase('text_verification')
    with temporary.open() as stream:
        assert stream.readline().strip()==','.join(Q.variable_names()) and stream.readline().strip()=='5'
        for index,expected in enumerate(ff):
            assert eval25(Q(stream.readline().strip().rstrip(',')))==expected
            phase('text_verification',index+1,len(ff)+len(defining))
        for expected in defining:
            assert Q(stream.readline().strip().rstrip(','))==expected
        assert not stream.read(1)
    temporary.replace(target)
    save(folder/'reconstruction.json',{'coefficient_field':str(k),'original_ring_variables':names,
        'final_variables':finalnames,'b_fixed':meta['chart_substitution'],
        'original_variable_expressions':{name:str(shrink(f)) for name,f in zip(names,reconstruction)},
        'affine_elimination_steps':steps,'reconstruction_substitution_idempotent_verified':True,
        'normalized_lifts':'For chart c=v.s, choose z^3=c/2; normalized v=z^-4*v_chart,b=z^5*b_chart, U=v^5.'})
    phase('complete')
    meta.update(status='exported_exact_preprocessed_chart',final_variables=list(Q.variable_names()),
                final_v_count=sum(name.startswith('v') for name in finalnames),
                final_b_count=sum(name.startswith('b') for name in finalnames),
                variable_count_F25=len(finalnames),variable_count_F5=Q.ngens(),
                eliminated_v_count=32-sum(name.startswith('v') for name in finalnames),
                variable_count_coefficient_field=len(finalnames),
                affine_elimination_rounds=len(steps),equation_count_F25=len(ff),equation_count_F5=encoded_count,
                max_degree_F25=max(f.total_degree() for f in ff),max_degree_F5=encoded_degree,
                terms_F25=sum(len(f.dict()) for f in ff),terms_F5=encoded_terms,
                input_file=str(target),input_sha256=file_sha256(target),
                input_bytes=target.stat().st_size,coefficient_specialization_and_text_roundtrip_verified=True,
                sparse_specialization=True,phase_timings_seconds=phase_times,peak_rss_bytes=peak_rss(),
                linear_algebra_backend=args.linear_backend,native_linear_algebra=native_rref.records if native_rref else [],
                elapsed_seconds=time.monotonic()-started)
    save(folder/'metadata.json',meta)
    print(json.dumps({name:meta[name] for name in ['chart','status','final_v_count','final_b_count','max_degree_F5','terms_F5','elapsed_seconds']},default=int),flush=True)
    return meta

def write_manifest():
    jobs=[]
    for j in range(32):
        folder=args.output/('chart-%02d'%j); file=folder/'metadata.json'
        if not file.exists(): continue
        m=json.loads(file.read_text()); assert m['source_sha256']==source_sha
        if m['status']=='excluded_exact_constant_combination':
            row={'chart':j,'status':'linear_certificate_verified',
                 'certificate':str(file.relative_to(args.output)),
                 'input':None,'sha256':None,'nvars':0,'terms':1,'max_degree':0}
        else:
            row={'chart':j,'status':'ready','input':str((folder/'input.ms').relative_to(args.output)),
                 'sha256':m['input_sha256'],'nvars':m['variable_count_F5'],
                 'terms':m['terms_F5'],'max_degree':m['max_degree_F5'],
                 'eliminated_v_count':m['eliminated_v_count']}
        jobs.append(row)
    save(args.output/'manifest.json',{'source_sha256':source_sha,'jobs':jobs,'all_32_complete':len(jobs)==32})

start=time.monotonic(); charts=[]; write_manifest()
requested=[int(args.chart)] if args.chart is not None else list(reversed(range(32)))
if not all(0<=j<32 for j in requested): raise ValueError('Chart index must be0..31')
pending=[]
for j in requested:
    if not args.force and (args.output/('chart-%02d'%j)/'metadata.json').exists():
        charts.append(export_chart(j)) # Includes exact source/input hash checks.
    else:
        pending.append(j)
if args.max_charts is not None: pending=pending[:args.max_charts]
# A field-heavy parent can itself be large. Counting its RSS once per worker
# is deliberately conservative, even though fork shares the immutable tensor.
estimated_worker_rss=max(512*1024**2,2*peak_rss())
workers=max(1,min(int(args.workers),len(pending),int(args.memory_gib*1024**3/estimated_worker_rss)))
session=dict(schema=1,source_sha256=source_sha,pid=os.getpid(),workers=workers,
    coefficient_field_degree_F5=int(field_degree),coefficient_load_seconds=start-load_started,
    estimated_worker_rss_bytes=estimated_worker_rss,charts_preserved=len(charts),
    charts_requested=pending,charts_new_complete=0,status='running',started=time.time())
save(args.output/'export_session.json',session)
print(json.dumps({'export_workers':workers,'charts_pending':pending,
    'coefficient_load_seconds':session['coefficient_load_seconds']},default=int),flush=True)
def completed(meta):
    charts.append(meta); write_manifest()
    session.update(charts_new_complete=session['charts_new_complete']+1,
        elapsed_seconds=time.monotonic()-start,updated=time.time())
    save(args.output/'export_session.json',session)
    save(args.output/('summary.json' if args.chart is None else 'summary-chart-%02d.json'%args.chart),
         {'source_sha256':source_sha,'charts':charts,'all_32_complete':len(charts)==32,
          'elapsed_seconds':time.monotonic()-start,'solver_run':False,'workers':workers})
if workers==1:
    for j in pending: completed(export_chart(j))
else:
    # Workers only write their distinct chart directories. The parent alone
    # atomically publishes the manifest, so interruption retains every fully
    # verified chart and never exposes a partially written input.
    with multiprocessing.get_context('fork').Pool(int(workers)) as pool:
        for meta in pool.imap_unordered(export_chart,pending,chunksize=1): completed(meta)
session.update(status='complete',elapsed_seconds=time.monotonic()-start,updated=time.time())
save(args.output/'export_session.json',session)
