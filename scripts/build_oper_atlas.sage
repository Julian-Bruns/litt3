#!/usr/bin/env sage
"""Build the exact compact N/R atlas for any enumerated oper, with restart stages.

No acyclicity is assumed: ker(L on L32) may have dimension three.
Outputs live in the explicitly supplied external directory; no historical
first-oper inputs are modified. Run with Sage, --rep ID --output DIRECTORY.
"""
import argparse
import hashlib
import json
import multiprocessing
import os
import resource
import sys
import time
from pathlib import Path
from atlas_series import coefficient as series_coefficient, coefficients as series_coefficients
from atlas_series import transport as transport_series, from_terms as series_from_terms
from atlas_resources import fork_workers,release_scratch,resident_rss

ROOT = Path(__file__).resolve().parent.parent
exec(compile((ROOT/'scripts/oper_representatives.sage').read_text(),
             'oper_representatives.sage', 'exec'))


_DIRECTION_TASK=None
def _fork_direction_task(index):
    try:return _DIRECTION_TASK(index)
    except BaseException as error:
        raise RuntimeError('Atlas direction %s failed: %s: %s'%
                           (index,type(error).__name__,error)) from None


def build_oper_atlas(rep, output, verify_full=False, workers=1, memory_gib=8,direction_backend='auto',refresh_preparation=False):
    started = time.monotonic()
    controller_pid=os.getpid()
    out = Path(output).resolve()
    out.mkdir(parents=True, exist_ok=True)
    fingerprint = hashlib.sha256(b''.join((ROOT/name).read_bytes() for name in
        ['scripts/build_oper_atlas.sage','scripts/oper_representatives.sage',
         'scripts/atlas_series.py','scripts/atlas_resources.py','scripts/atlas_native_directions.py',
         'scripts/atlas_complete_directions.py','scripts/atlas_direction_kernel.cpp',
         'scripts/atlas_factored_R_witness.py',
         'scripts/atlas_native_rref.py','scripts/atlas_native_rref.cpp','scripts/atlas_residue_projection.py'])).hexdigest()
    manifest = out/'builder.json'
    preparation_offset=0.0
    # A mathematical cache-format identity is stable across profiling/worker
    # changes. A changed coordinate convention must explicitly bump it.
    identity = {'rep': rep, 'schema': 2,
                'cache_format':'compact_original_curve_safe_series_v2'}
    if manifest.exists():
        prior = json.loads(manifest.read_text())
        preparation_offset=float(prior.get('preparation_process_seconds',0))
        if prior.get('schema')==1:
            # This exact deployed predecessor was audited after the Sage
            # monomial-indexing report. Its polynomial/base-F25 coordinate
            # stages are unaffected; no old direction is silently adopted.
            assert prior.get('rep')==rep and prior.get('builder_sha256')== \
                '0fb5071da3197fd88c22f4a41cba38a9bafd340a155e89d90b7a55cc0e818c7f'
            assert not list(out.glob('direction_*.sobj')) and not (out/'canonical_atlas_system.json').exists(), \
                'Legacy directions require an explicit independent coefficient audit'
        else:
            assert all(prior.get(key) == val for key, val in identity.items()), \
                'Checkpoint coordinate convention changed; use a fresh output directory'
    def write_json(path, data):
        temp = Path(str(path)+'.tmp')
        temp.write_text(json.dumps(data, indent=2,
            default=lambda value: int(value) if isinstance(value, Integer) else str(value))+'\n')
        os.replace(temp, path)
    def elapsed():return preparation_offset+time.monotonic()-started
    def progress(stage):
        if os.getpid()==controller_pid:
            write_json(manifest, dict(identity, builder_sha256=fingerprint, stage=stage,
                       elapsed_seconds=elapsed(),preparation_process_seconds=preparation_offset))
        print(rep, stage, 'elapsed', round(elapsed(), 2), flush=True)
    computed_stages=[]
    def stage(name, fn):
        path = out/(name+'.sobj')
        if path.exists():
            result = load(str(path))
            progress('resumed '+name)
            return result
        progress('building '+name)
        result = fn()
        temp = out/(name+'.tmp.sobj')
        save(result, str(temp))
        os.replace(temp, path)
        progress('completed '+name)
        computed_stages.append(name)
        return result
    def oper_stage():
        return {key:val for key,val in load_oper(rep).items() if key != 'encode_element'}
    data = stage('oper', oper_stage)
    k, R, x, F = data['k'], data['R'], data['x'], data['F']
    P = tuple(data['P'])
    zero = (R.zero(),)*3
    Fp = F.derivative()
    def basis(n):
        return sorted([(i,j) for j in range(3) for i in range(n//3+1)
                       if 3*i+10*j <= n], key=lambda ij: 3*ij[0]+10*ij[1])
    def poly(v, mons):
        ans = [R.zero() for _ in range(3)]
        for c,(i,j) in zip(v, mons): ans[j] += c*x**i
        return tuple(ans)
    def mono(ij):
        ans = [R.zero() for _ in range(3)]
        ans[ij[1]] = x**ij[0]
        return tuple(ans)
    def coeff(v, mons): return vector(k, [v[j][i] for i,j in mons])
    def add(v,w): return tuple(f+g for f,g in zip(v,w))
    def sub(v,w): return tuple(f-g for f,g in zip(v,w))
    def scale(c,v): return tuple(c*f for f in v)
    def delta(v):
        ans = [R.zero() for _ in range(3)]
        for j,f in enumerate(v):
            ans[(j+2)%3] += f.derivative()*F**((j+2)//3)
            if j: ans[j-1] += 2*j*f*Fp
        return tuple(ans)
    def mul(v,w):
        ans = [R.zero() for _ in range(3)]
        for j,f in enumerate(v):
            for h,g in enumerate(w): ans[(j+h)%3] += f*g*F**((j+h)//3)
        return tuple(ans)
    def L(v): return sub(delta(delta(v)), mul(P,v))
    dP = delta(P)
    def Q(v): return add(add(delta(delta(delta(v))),mul(P,delta(v))),scale(3,mul(dP,v)))
    def kernel(mons):
        images = [L(mono(ij)) for ij in mons]
        deg = max(f.degree() for v in images for f in v)
        mat = matrix(k, [[v[j][i] for v in images]
                        for j in range(3) for i in range(deg+1)])
        K = mat.right_kernel().basis_matrix()
        assert mat*K.transpose() == 0
        return K
    monsU, mons64, mons192, mons320 = basis(112), basis(64), basis(192), basis(320)
    def polynomial_stage():
        KU, K40, K8 = kernel(monsU), kernel(mons192), kernel(basis(32))
        assert (KU.nrows(),K40.nrows()) == (32,64)
        images = [Q(mono(ij)) for ij in mons64]
        assert all(L(q) == zero for q in images)
        assert all(Q(L(mono(ij))) == zero for ij in mons64)
        QM = matrix(k,[coeff(q,monsU) for q in images]).transpose()
        assert all(poly(QM.column(h),monsU) == images[h] for h in range(56))
        assert QM.rank() == 32 and QM.column_space() == KU.row_space()
        Qc = KU.transpose().solve_right(QM)
        assert KU.transpose()*Qc == QM
        return KU,K40,Qc,K8.nrows()
    KU,K40,Qc,h0V = stage('polynomial', polynomial_stage)
    gaps = [1,2,4,5,7,8,11,14,17]
    domain = [-g for g in gaps]+list(range(1,32))
    target = [-g for g in gaps]+list(range(1,48))
    monsT = basis(197)
    # The curve, its uniformizer and residue pairings are defined over F25.
    # Do these computations there, including for polynomial-quotient towers;
    # only their final coefficients are transported to the oper field.
    curve_k = GF(25, name='a', modulus=PolynomialRing(GF(5),'z')([2,4,1]))
    curve_R = PolynomialRing(curve_k,'x')
    curve_a, curve_x = curve_k.gen(), curve_R.gen()
    embedding_cache = {}
    def embed(c):
        c = curve_k(c)
        if c not in embedding_cache:
            embedding_cache[c] = sum((k(cc)*data['a']**h
                for h,cc in enumerate(c.polynomial().list())), k.zero())
        return embedding_cache[c]
    assert embed(curve_a)**2+4*embed(curve_a)+2 == 0
    curve_F = (curve_x**10+(4*curve_a+2)*curve_x**9+(curve_a+4)*curve_x**8
        +(3*curve_a+1)*curve_x**7+3*curve_a*curve_x**6+4*curve_a*curve_x**5
        +(3*curve_a+4)*curve_x**4+curve_a*curve_x**3+(3*curve_a+3)*curve_x**2
        +(4*curve_a+2)*curve_x+2*curve_a+1)
    assert R([embed(c) for c in curve_F.list()]) == F
    def local_stage():
        precision = 800
        PS = PowerSeriesRing(curve_k,'t',default_prec=precision)
        t = PS.gen()
        Ft = curve_R(list(reversed(curve_F.list())))
        z = (t**3).add_bigoh(precision)
        for _ in range(11): z -= (z-t**3*Ft(z))/(1-t**3*Ft.derivative()(z))
        assert (z-t**3*Ft(z)).valuation() >= precision
        LS = LaurentSeriesRing(curve_k,'t',default_prec=precision)
        tt = LS.gen()
        xx = 1/LS(z)
        yy = xx**3/tt
        ex = {(i,j):xx**i*yy**j for i,j in monsT}
        dt = yy**2/xx.derivative()
        return LS,tt,ex,dt
    curve_LS,curve_tt,curve_expansions,curve_delta_t = stage('local', local_stage)
    LS = LaurentSeriesRing(k,'t',default_prec=800)
    tt = LS.gen()
    def embed_series(s):
        return transport_series(s,LS,embed)
    expansions=delta_t=reducers=None
    def remainder(s):
        assert s.valuation() >= -197 and s.precision_absolute() > 132
        for pole in sorted(reducers,reverse=True):
            c = series_coefficient(s,-pole)
            if c: s -= c*reducers[pole]
        return s
    def rho(s,exps):
        s = remainder(s)
        return vector(k,series_coefficients(s,exps))
    def series(v,exps): return series_from_terms(LS,dict(zip(exps,v)))
    def fifth(M): return M.apply_map(lambda c:c**5)
    def curve_coordinate_stage():
        theta = 1/curve_delta_t
        S = matrix(curve_k, [[series_coefficient(curve_tt**e*curve_expansions[m]*theta,-1)
                             for m in mons64] for e in target])
        assert S.rank() == 56
        curve_reducers = {3*i+10*j:v for (i,j),v in curve_expansions.items()}
        def curve_rho(s):
            assert s.valuation() >= -197 and s.precision_absolute() > 132
            for pole in sorted(curve_reducers,reverse=True):
                c = series_coefficient(s,-pole)
                if c: s -= c*curve_reducers[pole]
            return vector(curve_k,series_coefficients(s,domain))
        D = matrix(curve_k,[-curve_rho(curve_delta_t*(curve_tt**e).derivative())
                            for e in target]).transpose()
        powers = []
        for i,j in mons64:
            v = [curve_R.zero() for _ in range(3)]
            v[(5*j)%3] = curve_x**(5*i)*curve_F**((5*j)//3)
            powers.append(v)
        power_matrix = matrix(curve_k,[[v[j][i] for i,j in mons320] for v in powers]).transpose()
        piv5 = list(power_matrix.transpose().pivots())
        inverse5 = power_matrix.matrix_from_rows(piv5).inverse()
        return S,D,power_matrix,piv5,inverse5
    curve_S,curve_D,curve_power,curve_piv5,curve_inverse5 = stage('curve_coordinates',curve_coordinate_stage)
    def embed_matrix(M):
        return matrix(k,M.nrows(),M.ncols(),[embed(c) for c in M.list()])
    def coordinate_stage():
        S,D,power_matrix,inverse5 = map(embed_matrix,[curve_S,curve_D,curve_power,curve_inverse5])
        piv5 = curve_piv5
        Bc = S.transpose().solve_right(Qc.transpose())
        piv = list(Qc.pivots())
        Iproj = (S.matrix_from_columns(piv)*Qc.matrix_from_columns(piv).inverse()).transpose()
        assert S.transpose()*Bc == Qc.transpose()
        assert Iproj*Bc == identity_matrix(k,32)
        return S,Bc,Iproj,D,power_matrix,piv5,inverse5
    S,Bc,Iproj,D,power_matrix,piv5,inverse5 = stage('coordinates',coordinate_stage)
    if refresh_preparation and 'polynomial' in computed_stages and direction_backend!='laurent':
        # Sage/PARI retains substantial native allocation state after a fresh
        # kernel calculation. All preparation is immutable and checkpointed.
        # Replace ONLY this builder process before loading the direction data;
        # the owning controller and every checkpoint retain their identities.
        preparation_offset=elapsed()
        write_json(manifest,dict(identity,builder_sha256=fingerprint,
            stage='preparation_complete_fresh_process',elapsed_seconds=preparation_offset,
            preparation_process_seconds=preparation_offset))
        print(rep,'all preparation saved; refreshing arithmetic process',flush=True)
        os.execv(sys.executable,[sys.executable,__file__,*sys.argv[1:],'--prepared-process'])
    Bc5=T40=dT40=eta5=Dbc5=lambda5=Nprojection=None
    def direction(i):
        uv=KU.row(i)
        up = poly(uv,monsU)
        du = delta(up)
        wh = [sub(mul(up,dt),mul(tp,du)) for tp,dt in zip(T40,dT40)]
        wc = matrix(k,[coeff(v,mons320) for v in wh]).transpose()
        coords = inverse5*wc.matrix_from_rows(piv5)
        assert power_matrix*coords == wc
        assert all(poly(wc.column(h),mons320) == wh[h] for h in range(64))
        Nc = coords.transpose()*Nprojection
        U = sum((c*expansions[m] for c,m in zip(uv,monsU)),LS.zero())
        raw = matrix(k,[rho(tt**(-85)*remainder(U*eta5[h])-U*lambda5[h],target)
                        for h in range(32)]).transpose()
        return Nc,Iproj*raw,raw
    native_directions=None
    if direction_backend!='laurent':
        from atlas_complete_directions import CompleteNativeDirections
        progress('preparing native field and fixed-curve direction operators')
        try:
            native_directions=CompleteNativeDirections(data,KU,K40,Qc,Bc,Iproj,D,
                curve_power,piv5,curve_inverse5,curve_expansions,monsU,mons192,mons320,
                cache_directory=out/'complete_native')
        except NotImplementedError as error:
            if direction_backend=='native': raise
            print(json.dumps(dict(native_direction_fallback=str(error))),flush=True)
        else:
            direction=native_directions.direction
            progress('completed native field and fixed-curve direction operators')
            # The native operator owns its required inputs. Old polynomial
            # kernel scratch and transported Laurent series must not be
            # inherited by every worker. All final original-coordinate
            # bases are already checkpointed and are reloaded below.
            KU=K40=Qc=S=Bc=Iproj=D=power_matrix=inverse5=None
            T40=dT40=eta5=lambda5=Dbc5=Nprojection=None
            expansions=delta_t=None
            release_scratch()
    if native_directions is None:
        # Transported Laurent data and polynomial scratch are needed ONLY
        # by the explicitly retained original-coordinate fallback.
        progress('transporting fixed-curve Laurent coefficients')
        expansions={m:embed_series(s) for m,s in curve_expansions.items()}
        delta_t=embed_series(curve_delta_t)
        reducers={3*i+10*j:v for (i,j),v in expansions.items()}
        progress('completed fixed-curve Laurent transport')
        progress('preparing shared residue factors')
        Bc5=fifth(Bc)
        T40=[poly(row,mons192) for row in K40.rows()]
        dT40=[delta(v) for v in T40]
        eta5=[series(Bc5.column(h),[5*e for e in target]) for h in range(32)]
        Dbc5=fifth(D*Bc)
        lambda5=[series(Dbc5.column(h),[5*e for e in domain]) for h in range(32)]
        Nprojection=fifth(Qc.transpose())
        assert Nprojection==fifth(S).transpose()*Bc5
        progress('completed shared residue factors')
    def checkpoint_direction(i):
        stage('direction_%02d'%i,lambda:direction(i))
        if native_directions is not None:
            native_directions.bind_checkpoint(i,out/('direction_%02d.sobj'%i))
        release_scratch()
        return i
    pending=[int(i) for i in range(32) if not (out/('direction_%02d.sobj'%i)).exists()]
    rss=resident_rss()
    count,estimate=fork_workers(workers,len(pending),rss,memory_gib*1024**3)
    print(json.dumps(dict(direction_workers=count,directions_pending=pending,
        estimated_worker_rss_bytes=estimate),default=int),flush=True)
    if count==1:
        for i in pending: checkpoint_direction(i)
    else:
        global _DIRECTION_TASK
        _DIRECTION_TASK=checkpoint_direction
        # Never recycle PARI-using fork workers from Pool's management thread:
        # PARI's thread-local state belongs to the original main thread.
        # The large C++ arithmetic subprocess is fresh for EVERY direction;
        # only bounded decoding scratch remains in each original Sage worker.
        with multiprocessing.get_context('fork').Pool(int(count)) as pool:
            for i in pool.imap_unordered(_fork_direction_task,pending,chunksize=1):
                progress('completed direction_%02d'%i)
    if native_directions is not None:
        KU,K40,Qc,h0V=load(str(out/'polynomial.sobj'))
        S,Bc,Iproj,D,power_matrix,piv5,inverse5=load(str(out/'coordinates.sobj'))
    paths=[out/('direction_%02d.sobj'%i) for i in range(32)]
    if verify_full:
        if native_directions is not None:
            from atlas_factored_R_witness import FactoredRWitness
            def full_R():
                return FactoredRWitness(data,Bc,Iproj).verify(paths,out/'full_R_checks',workers,memory_gib)
            stage('coupled_R_certificate',full_R)
        else:
            tensors=[tuple(matrix(k,M.nrows(),M.ncols(),M.list())
                for M in load(str(path))) for path in paths]
            NN = block_matrix(k,1,32,[entry[0] for entry in tensors])
            RR = block_matrix(k,1,32,[entry[2] for entry in tensors])
            defect = (identity_matrix(k,56)-Bc*Iproj)*RR
            assert NN.stack(defect).rank() == NN.rank()
            tensors=NN=RR=defect=None
        progress('full coupled R image implication verified')
    enc = lambda row:[str(c) for c in row]
    encmat = lambda M:[enc(row) for row in M.rows()]
    # Encode only one block at a time. Retaining all128k large-field scalar
    # objects simultaneously can consume gigabytes of native CAS allocations.
    N_tensor=[];R_tensor=[]
    for i,path in enumerate(paths):
        binding=out/'complete_native'/('binding-%02d.json'%i)
        if native_directions is not None and binding.exists():
            # The full-R verifier has checked the binary/checkpoint binding.
            # Decode the same native bytes directly; PARI's generic .sobj
            # unpickler otherwise reevaluates thousands of long polynomials.
            assert json.loads(binding.read_text())['original_sha256']==hashlib.sha256(path.read_bytes()).hexdigest()
            one=native_directions.direction(i)
        else:one=load(str(path))
        N_tensor.append(encmat(one[0]));R_tensor.append(encmat(one[1]))
        one=None;release_scratch()
    result = {'schema':1,'rep':rep,'scope':'Exact compact untwisted atlas coefficients; no exclusion claimed',
        'field':str(k),'field_modulus':str(k.modulus()) if hasattr(k,'modulus') else None,
        'field_description':data.get('field_description'), 'oper_metadata':data.get('metadata'),
        'oper_alpha':str(data.get('alpha')),'c4':str(data['c4']),
        'coordinates':'U=sum_i u_i KU_i; eta=Bc beta; beta=i(eta) in SU*',
        'variables':{'u':32,'beta':32},'equation_counts':[64,32,1],
        'equations':['N(U) beta^[5]=0','R(U) beta^[5]=beta','sum_i u_i beta_i=2'],
        'tensor_axis_order':'u_direction,output_coordinate,beta_fifth_power_coordinate',
        'eta_exponents':target,'SU_monomials':monsU,'SU_basis':encmat(KU),
        'N_tensor':N_tensor,'R_tensor':R_tensor,
        'Bc':encmat(Bc),'Iproj':encmat(Iproj),'S40_basis':encmat(K40),'h0_V':h0V,
        'checks':{'SU_dimension':32,'S40_dimension':64,'Q_rank':32,
                  'all_Wronskians_fifth_power_identity':True,'Iproj_Bc_identity':True,
                  'coupled_R_image_verified':bool(verify_full)},
        'builder_sha256':fingerprint,'elapsed_seconds':elapsed()}
    if rep == 'orbit_0000':
        old = json.loads((ROOT/'Research/computations/canonical_atlas_system.json').read_text())
        for key in ['SU_basis','N_tensor','R_tensor','Bc','Iproj']:
            assert result[key] == old[key], 'First cached tensor mismatch: '+key
        result['checks']['first_cached_tensors_exactly_equal_same_bases'] = True
    write_json(out/'canonical_atlas_system.json',result)
    progress('complete')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--rep',required=True)
    parser.add_argument('--output',required=True)
    parser.add_argument('--verify-full',action='store_true',help='Also verify the full coupled R-image linear implication')
    parser.add_argument('--workers',type=int,default=1)
    parser.add_argument('--memory-gib',type=float,default=8)
    parser.add_argument('--direction-backend',choices=('auto','native','laurent'),default='auto')
    parser.add_argument('--prepared-process',action='store_true',help=argparse.SUPPRESS)
    args = parser.parse_args()
    if args.workers<1 or args.memory_gib<=0: parser.error('workers and memory-gib must be positive')
    build_oper_atlas(args.rep,args.output,args.verify_full,args.workers,args.memory_gib,
                     args.direction_backend,not args.prepared_process)
