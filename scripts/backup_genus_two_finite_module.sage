#!/usr/bin/env sage
"""Certify a finite algebra for the backup chart-zero necessary subideal.

No stabilized Hilbert function is promoted to finiteness.  The certificate
contains exact row-module identities, polynomial annihilator/border
identities, three commuting multiplication matrices, and an exact
representation satisfying all eight original projected rows.  A replay
uses no native solver.  Frobenius graph and inverse-norm equations are
NOT dropped or claimed excluded by this stage.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path


def exponents(bound):
    return sorted((ex for ex in itertools.product(range(bound+1), repeat=3)
                   if sum(ex) <= bound), key=lambda ex: (sum(ex), ex))


def atomic_json(path, data):
    path=Path(path); temporary=Path(str(path)+'.tmp')
    temporary.write_text(json.dumps(data, indent=1, default=int)+'\n')
    temporary.replace(path)


def prepare(tensor_path):
    from atlas_field_maps import from_power_coordinates,inverse_frobenius_map
    raw=Path(tensor_path).read_bytes(); data=json.loads(raw)
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**data['field_degree'], name='c', modulus=prime(data['field_modulus']))
    decode=lambda cs:from_power_coordinates(k,cs)
    I=matrix(k,[[decode(co) for co in row] for row in data['I']],implementation='generic')
    pivots=list(I.transpose().pivots());assert len(pivots)==4
    selector=matrix(k,4,12,implementation='generic')
    for j,h in enumerate(pivots):selector[j,h]=1
    left=I.matrix_from_rows(pivots).inverse()*selector
    projection=matrix(k,[[k(h==j)-sum(I[h,a]*left[a,j] for a in range(4))
                         for j in range(12)] for h in range(12) if h not in pivots],implementation='generic')
    assert left*I==identity_matrix(k,4) and projection*I==0
    tensor=matrix(k,[[decode(data['tensor'][i][j][h]) for i in range(4) for j in range(4)]
                     for h in range(12)],implementation='generic')
    N=projection*tensor;S=-left*tensor
    root=inverse_frobenius_map(k)
    Nroot=N.apply_map(root);Sroot=S.apply_map(root)
    assert Nroot.apply_map(lambda c:c**5)==N and Sroot.apply_map(lambda c:c**5)==S
    B=PolynomialRing(k,names=['b1','b2','b3'],order='degrevlex')
    b=[B.one()]+list(B.gens())
    rows=[[sum((Nroot[a,4*i+j]*b[j] for j in range(4)),B.zero()) for i in range(4)] for a in range(8)]
    s0=[sum((Sroot[0,4*i+j]*b[j] for j in range(4)),B.zero()) for i in range(4)]
    return {'data':data,'tensor_sha256':hashlib.sha256(raw).hexdigest(),'k':k,'B':B,
            'Nroot':Nroot,'Sroot':Sroot,'rows':rows,'s0':s0,
            'left':left,'projection':projection}


def row_difference(first,second):
    return [a-b for a,b in zip(first,second)]


def check_certificate(ctx,certificate):
    """Only original polynomial arithmetic; no RREF or dimension count."""
    from atlas_field_maps import from_power_coordinates
    started=time.monotonic()
    k=ctx['k'];N=ctx['Nroot'];S=ctx['Sroot']
    assert certificate['tensor_sha256']==ctx['tensor_sha256']
    assert certificate['chart_first_nonzero_b']==0
    decode=lambda cs:from_power_coordinates(k,cs)
    def decode_matrix(values):
        return matrix(k,[[decode(c) for c in row] for row in values],implementation='generic')
    def decode_poly(terms):
        result={}
        for ex,co in terms:
            ex=tuple(int(n) for n in ex)
            assert len(ex)==3 and min(ex)>=0 and ex not in result
            result[ex]=decode(co)
        return {ex:co for ex,co in result.items() if co}
    zero=(0,0,0)
    def add_scaled(target,poly,scale,shift=zero):
        if not scale:return
        for ex,co in poly.items():
            key=tuple(a+b for a,b in zip(ex,shift))
            target[key]=target.get(key,k.zero())+scale*co
    def add_product(target,first,second,scale):
        for ex,co in first.items():add_scaled(target,second,scale*co,ex)
    def linear_row(coefficients):
        keys=[zero,(1,0,0),(0,1,0),(0,0,1)]
        return {ex:co for ex,co in zip(keys,coefficients) if co}
    n_rows=[[linear_row([N[a,4*i+j] for j in range(4)]) for i in range(4)] for a in range(8)]
    s0=[linear_row([S[0,4*i+j] for j in range(4)]) for i in range(4)]
    words=[tuple(int(n) for n in ex) for ex in certificate['basis_word_exponents']]
    assert len(words)==8 and words[0]==(0,0,0) and len(set(words))==8
    generators=decode_matrix(certificate['generator_coordinates'])
    multiplication=[decode_matrix(M) for M in certificate['multiplication_matrices']]
    assert generators.dimensions()==(4,8) and len(multiplication)==3
    assert all(M.dimensions()==(8,8) for M in multiplication)
    annihilators=[decode_poly(f) for f in certificate['annihilator_polynomials']]
    assert annihilators and all(f for f in annihilators)
    all_weights=[[decode_poly(f) for f in row] for row in certificate['original_projected_row_multipliers']]
    assert len(all_weights)==len(annihilators)+4 and all(len(row)==8 for row in all_weights)
    border_weights=[[decode_poly(f) for f in row] for row in certificate['border_annihilator_multipliers']]
    assert len(border_weights)==24 and all(len(row)==len(annihilators) for row in border_weights)
    print(json.dumps({'stage':'solver-free coefficient decode complete','replay_seconds':time.monotonic()-started}),flush=True)
    # Direct coefficient convolution avoids a fresh Singular field
    # conversion for every generic multivariate polynomial product.
    # Every original coefficient is still checked in independent Sage
    # scalar finite-field arithmetic.
    for h,weights in enumerate(all_weights):
        for i in range(4):
            residual={}
            for a in range(8):add_product(residual,weights[a],n_rows[a][i],k.one())
            if h<len(annihilators):add_product(residual,annihilators[h],s0[i],-k.one())
            else:
                generator=h-len(annihilators)
                residual[zero]=residual.get(zero,k.zero())-k(generator==i)
                for a in range(8):add_scaled(residual,s0[i],generators[generator,a],words[a])
            assert not any(residual.values())
    print(json.dumps({'stage':'16 original projected coefficient identities PASS','replay_seconds':time.monotonic()-started}),flush=True)
    for a in range(8):
        for j in range(3):
            ex=list(words[a]);ex[j]+=1;residual={tuple(ex):k.one()}
            for h in range(8):add_scaled(residual,{words[h]:k.one()},-multiplication[j][a,h])
            for f,g in zip(border_weights[3*a+j],annihilators):add_product(residual,f,g,-k.one())
            assert not any(residual.values())
    print(json.dumps({'stage':'24 polynomial border coefficient identities PASS','replay_seconds':time.monotonic()-started}),flush=True)
    # The f*S0 identities and S0=1 place every annihilator in the affine
    # nine-row ideal.  Polynomial borders and the four generator identities
    # prove generation there; this representation proves independence.
    unit=vector(k,[1]+[0]*7);identity=identity_matrix(k,8)
    operators=[identity]+multiplication
    assert all(A*Bmat==Bmat*A for A in multiplication for Bmat in multiplication)
    for a in range(8):
        assert sum((N[a,4*i+j]*(generators.row(i)*operators[j])
                    for i in range(4) for j in range(4)),vector(k,8))==0
    s0_image=sum((S[0,4*i+j]*(generators.row(i)*operators[j])
                  for i in range(4) for j in range(4)),vector(k,8))
    assert s0_image==unit
    for a,ex in enumerate(words):
        image=unit
        for j,power in enumerate(ex):image=image*multiplication[j]**power
        assert image==vector(k,[int(a==h) for h in range(8)])
    return {'original_projected_row_identities':len(annihilators)+4,
            'polynomial_annihilator_border_identities':24,
            'commuting_multiplication_matrices':3,
            'original_projected_relations_in_representation':8,
            'basis_words_represent_standard_basis':True,
            's0_represents_unit':True,
            'necessary_nine_row_affine_quotient_dimension':8,
            'core_certificate_alone_does_not_check_frobenius_or_inverse_norm':True}


def finite_conditions(ctx,certificate,engine=None):
    """Evaluate ALL remaining conditions, retaining the exact frozen field.

    This returns a finite-algebra identity only.  It is not counted as an
    atlas exclusion until a polynomial lift to all13 original rows exists
    and has passed the separate atlas verifier.
    """
    from atlas_field_maps import from_power_coordinates,inverse_frobenius_map
    k=ctx['k'];S=ctx['Sroot'];data=ctx['data']
    decode=lambda cs:from_power_coordinates(k,cs)
    decode_matrix=lambda values:matrix(k,[[decode(c) for c in row] for row in values],implementation='generic')
    encode=lambda c:[int(v) for v in k(c).polynomial().list()]
    generators=decode_matrix(certificate['generator_coordinates'])
    matrices=[decode_matrix(M) for M in certificate['multiplication_matrices']]
    operators=[identity_matrix(k,8)]+matrices
    unit=vector(k,[1]+[0]*7)
    word_operators=[]
    for ex in certificate['basis_word_exponents']:
        operator=identity_matrix(k,8)
        for j,power in enumerate(ex):operator=operator*matrices[j]**int(power)
        word_operators.append(operator)
    def operator_of(row):
        return sum((c*M for c,M in zip(row,word_operators)),matrix(k,8,8,implementation='generic'))
    v_operators=[operator_of(row) for row in generators.rows()]
    s_vectors=[sum((S[a,4*i+j]*(generators.row(i)*operators[j])
                    for i in range(4) for j in range(4)),vector(k,8)) for a in range(4)]
    assert s_vectors[0]==unit
    s_operators=[operator_of(row) for row in s_vectors]
    graphs=[unit*(operators[j]-s_operators[j]**5) for j in range(1,4)]
    root=inverse_frobenius_map(k)
    ell=[[root(decode(co)) for co in row] for row in data['ell']]
    assert all(ell[i][j]**5==decode(data['ell'][i][j]) for i in range(4) for j in range(4))
    norm=sum((ell[i][j]*(unit*v_operators[i]*s_operators[j])
              for i in range(4) for j in range(4)),vector(k,8))
    span=matrix(k,[graph*word for graph in graphs for word in word_operators],implementation='generic')
    if engine is not None:
        answer=engine.solve_or_dual(span,unit)
        target_kind='one'
        if answer['dual']:
            answer=engine.solve_or_dual(span,unit*operator_of(norm)**8)
            target_kind='inverse_norm_eighth_power'
    else:
        saved=certificate['all_remaining_conditions_in_finite_algebra']
        target_kind=saved['target_kind'];assert target_kind in ['one','inverse_norm_eighth_power']
        target=unit if target_kind=='one' else unit*operator_of(norm)**8
        answer={'dual':not saved['target_membership_identity'],
                'vector':vector(k,[decode(c) for c in saved['exact_graph_word_multipliers_or_dual']])}
        if answer['dual']:assert span*answer['vector']==0 and target*answer['vector']==1
        else:assert answer['vector']*span==target
    status=('finite_quotient_exact_exclusion_identity_pending_original13_lift' if not answer['dual']
            else 'finite_quotient_nonzero_after_all_graph_and_inverse_norm_conditions_requires_review')
    result={'status':status,'rooted_graph_equations_evaluated':[1,2,3],
            'rooted_graph_coordinate_vectors':[[encode(c) for c in row] for row in graphs],
            'rooted_inverse_norm_coordinate_vector':[encode(c) for c in norm],
            'graph_ideal_dimension':int(span.rank()),'target_kind':target_kind,
            'target_membership_identity':not answer['dual'],
            'exact_graph_word_multipliers_or_dual':[encode(c) for c in answer['vector']],
            'graph_word_order':'graph1 then graph2 then graph3; within each, stored eight basis words',
            'original13_polynomial_lift_verified':False}
    if engine is None:assert result==saved
    return result


def build(tensor_path,output,summary):
    from backup_native_linear import NativeLinear
    started=time.monotonic();ctx=prepare(tensor_path)
    k=ctx['k'];B=ctx['B'];s0=ctx['s0'];rows=ctx['rows']
    source_exponents=exponents(3);target_exponents=exponents(4)
    monomials=[B({ex:k.one()}) for ex in source_exponents]
    def flatten(row):
        ds=[{tuple(ex):co for ex,co in f.dict().items()} for f in row]
        return [ds[i].get(ex,k.zero()) for i in range(4) for ex in target_exponents]
    sources=[[m*f for f in row] for row in rows for m in monomials]
    M=matrix(k,[flatten(row) for row in sources],implementation='generic')
    print(json.dumps({'stage':'bounded finite-module kernel','matrix_shape':list(M.dimensions()),
                      'field_degree':ctx['data']['field_degree'],
                      'preparation_seconds':time.monotonic()-started},default=int),flush=True)
    engine=NativeLinear(k,cache_directory=Path(output).resolve().parent/'bounded_native_module_cache')
    assert engine.module_self_test()
    kernel=engine.right_kernel(M)
    result={'status':'finite_module_not_certified','tensor_path':str(Path(tensor_path).resolve()),
            'tensor_sha256':ctx['tensor_sha256'],'twist_index':ctx['data']['twist_index'],
            'field_degree':ctx['data']['field_degree'],'field_modulus':ctx['data']['field_modulus'],
            'chart_first_nonzero_b':0,'truncated_kernel_columns':int(kernel.ncols()),
            'degree_of_original_row_multipliers':3,
            'scope':'This necessary nine-row quotient is NOT the full atlas; all three Frobenius graph equations and the inverse-norm equation remain.'}
    if kernel.ncols()!=8:
        result['reason']='The bounded kernel does not have the target dimension eight; no finiteness inference.'
    else:
        # A length-eight algebra can require cubic basis words.  These
        # still give S0 words of degree at most FOUR, inside the SAME
        # degree-three multiplier matrix; no larger module matrix is used.
        candidates=exponents(3)
        candidate_rows=[[B({ex:k.one()})*f for f in s0] for ex in candidates]
        candidate_coordinates=matrix(k,[flatten(row) for row in candidate_rows],implementation='generic')*kernel
        pivots=list(candidate_coordinates.transpose().pivots())
        result['s0_word_rank_through_degree']={str(d):int(candidate_coordinates.matrix_from_rows([i for i,ex in enumerate(candidates) if sum(ex)<=d]).rank()) for d in range(4)}
        if len(pivots)!=8 or pivots[0]!=0:
            result['reason']='The specified degree-three S0 words do not give an eight-element basis containing S0.'
        else:
            words=[candidates[a] for a in pivots];basis=[candidate_rows[a] for a in pivots]
            coordinate_map=kernel*candidate_coordinates.matrix_from_rows(pivots).inverse()
            generators=[[B(i==j) for j in range(4)] for i in range(4)]
            coordinates=matrix(k,[flatten(row) for row in generators],implementation='generic')*coordinate_map
            candidate_monomials=[B({ex:k.one()}) for ex in candidates]
            annihilator_coefficients=candidate_coordinates.left_kernel().basis_matrix()
            annihilators=[sum((co*m for co,m in zip(row,candidate_monomials)),B.zero()) for row in annihilator_coefficients.rows()]
            assert len(annihilators)==12 and all(annihilators)
            ann_sources=[];ann_source_indices=[]
            for a,f in enumerate(annihilators):
                for ex in exponents(4-int(f.total_degree())):
                    ann_sources.append(B({ex:k.one()})*f);ann_source_indices.append((a,ex))
            def flatten_poly(f):
                ds={tuple(ex):co for ex,co in f.dict().items()}
                return [ds.get(ex,k.zero()) for ex in target_exponents]
            ann_matrix=matrix(k,[flatten_poly(f) for f in ann_sources],implementation='generic')
            ann_kernel=engine.right_kernel(ann_matrix)
            result['annihilator_border_matrix_shape']=list(ann_matrix.dimensions())
            result['annihilator_truncated_kernel_columns']=int(ann_kernel.ncols())
            if ann_kernel.ncols()!=8:
                result['reason']='The degree-four polynomial border space has not been certified eight-dimensional.'
                result.update(native_records=engine.records,elapsed_seconds=time.monotonic()-started)
                if summary:atomic_json(summary,result)
                print(json.dumps(result,indent=1,default=int),flush=True)
                return
            basis_monomials=[B({ex:k.one()}) for ex in words]
            basis_coordinates=matrix(k,[flatten_poly(f) for f in basis_monomials],implementation='generic')*ann_kernel
            assert basis_coordinates.rank()==8
            ann_coordinate_map=ann_kernel*basis_coordinates.inverse()
            borders=[B.gen(j)*basis_monomials[a] for a in range(8) for j in range(3)]
            border_coordinates=matrix(k,[flatten_poly(f) for f in borders],implementation='generic')*ann_coordinate_map
            border_residuals=[f-sum((border_coordinates[h,a]*basis_monomials[a] for a in range(8)),B.zero()) for h,f in enumerate(borders)]
            border_coefficients=engine.row_identities(ann_matrix,matrix(k,[flatten_poly(f) for f in border_residuals],implementation='generic'))
            border_polynomials=[[B.zero() for _ in annihilators] for _ in borders]
            for h in range(24):
                for col,(a,ex) in enumerate(ann_source_indices):
                    border_polynomials[h][a]+=border_coefficients[h,col]*B({ex:k.one()})
            residuals=[[f*g for g in s0] for f in annihilators]
            residuals += [row_difference(row,[sum((coordinates[h,a]*basis[a][i] for a in range(8)),B.zero()) for i in range(4)]) for h,row in enumerate(generators)]
            targets=matrix(k,[flatten(row) for row in residuals],implementation='generic')
            print(json.dumps({'stage':'16 exact annihilator/generator identities','basis_words':words,
                              's0_word_ranks':result['s0_word_rank_through_degree'],
                              'elapsed_seconds':time.monotonic()-started},default=int),flush=True)
            weights=engine.row_identities(M,targets)
            print(json.dumps({'stage':'16 native and independent scalar row identities PASS',
                              'elapsed_seconds':time.monotonic()-started},default=int),flush=True)
            encode=lambda c:[int(v) for v in k(c).polynomial().list()]
            encode_matrix=lambda mat:[[encode(c) for c in row] for row in mat.rows()]
            polynomial_weights=[]
            encode_poly=lambda f:[[list(ex),encode(co)] for ex,co in f.dict().items()]
            for h in range(len(residuals)):
                polynomial_weights.append([[[list(ex),encode(weights[h,a*len(monomials)+j])]
                                             for j,ex in enumerate(source_exponents) if weights[h,a*len(monomials)+j]] for a in range(8)])
            multiplication=[matrix(k,[border_coordinates.row(3*a+j) for a in range(8)],implementation='generic') for j in range(3)]
            result.update(basis_word_exponents=words,generator_coordinates=encode_matrix(coordinates),
                          multiplication_matrices=[encode_matrix(T) for T in multiplication],
                          original_projected_row_multipliers=polynomial_weights,
                          annihilator_polynomials=[encode_poly(f) for f in annihilators],
                          border_annihilator_multipliers=[[encode_poly(f) for f in row] for row in border_polynomials])
            result['status']='bounded_finite_module_checkpoint_polynomial_replay_pending'
            result.update(native_records=engine.records,elapsed_seconds=time.monotonic()-started)
            atomic_json(output,result)
            print(json.dumps({'stage':'bounded row identities checkpointed before polynomial replay',
                              'elapsed_seconds':time.monotonic()-started},default=int),flush=True)
            result['exact_certificate_checks']=check_certificate(ctx,result)
            result['status']='finite_eight_dimensional_necessary_quotient_exact_border_certificate'
            result.update(native_records=engine.records,elapsed_seconds=time.monotonic()-started)
            atomic_json(output,result)
            result['all_remaining_conditions_in_finite_algebra']=finite_conditions(ctx,result,engine)
    result.update(native_records=engine.records,elapsed_seconds=time.monotonic()-started)
    if result['status'].startswith('finite_eight'):atomic_json(output,result)
    receipt={key:value for key,value in result.items() if key not in
             ['field_modulus','generator_coordinates','multiplication_matrices','original_projected_row_multipliers',
              'annihilator_polynomials','border_annihilator_multipliers','all_remaining_conditions_in_finite_algebra']}
    if 'all_remaining_conditions_in_finite_algebra' in result:
        conditions=result['all_remaining_conditions_in_finite_algebra']
        receipt['all_remaining_conditions_in_finite_algebra']={key:conditions[key] for key in
            ['status','rooted_graph_equations_evaluated','graph_ideal_dimension','target_kind',
             'target_membership_identity','original13_polynomial_lift_verified']}
    if result['status'].startswith('finite_eight'):
        receipt['certificate_path']=str(Path(output).resolve())
        receipt['certificate_sha256']=hashlib.sha256(Path(output).read_bytes()).hexdigest()
    if summary:atomic_json(summary,receipt)
    print(json.dumps(receipt,indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True)
    parser.add_argument('--output',required=True)
    parser.add_argument('--summary')
    parser.add_argument('--replay',action='store_true')
    args=parser.parse_args()
    if args.replay:
        started=time.monotonic();ctx=prepare(args.tensor)
        certificate=json.loads(Path(args.output).read_text())
        checks=check_certificate(ctx,certificate)
        conditions=(finite_conditions(ctx,certificate) if 'all_remaining_conditions_in_finite_algebra' in certificate
                    else {'status':'all_frobenius_graph_and_inverse_norm_conditions_still_pending'})
        result={'status':'finite_module_solver_free_replay_PASS','certificate_sha256':hashlib.sha256(Path(args.output).read_bytes()).hexdigest(),
                'checks':checks,'all_remaining_conditions_status':conditions['status'],
                'elapsed_seconds':time.monotonic()-started}
        if args.summary:atomic_json(args.summary,result)
        print(json.dumps(result,indent=1,default=int),flush=True)
    else:build(args.tensor,args.output,args.summary)
