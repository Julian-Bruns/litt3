#!/usr/bin/env sage
"""Lift the saved finite quotient's first-graph unit to original13 rows.

No elimination is run.  The output stores explicit factored polynomial
Nullstellensatz multipliers.  Its separate checker reads only this output
and the ORIGINAL tensor, not the finite-quotient certificate or its solver.
"""
import argparse
import hashlib
import json
import runpy
import time
from pathlib import Path
from atlas_field_maps import from_power_coordinates
from backup_sparse_polynomials import SparsePolynomials


def run(tensor_path,finite_path,output):
    started=time.monotonic()
    scope=runpy.run_path(str(Path(__file__).with_name('backup_genus_two_finite_module.sage')),
                        run_name='backup_finite_certificate_library',init_globals=globals())
    ctx=scope['prepare'](tensor_path)
    finite_raw=Path(finite_path).read_bytes();certificate=json.loads(finite_raw)
    scope['check_certificate'](ctx,certificate)
    conditions=scope['finite_conditions'](ctx,certificate)
    assert conditions['target_kind']=='one' and conditions['target_membership_identity']
    k=ctx['k'];P=SparsePolynomials(k);S=ctx['Sroot'];N=ctx['Nroot']
    decode=lambda cs:from_power_coordinates(k,cs)
    decode_matrix=lambda rows:matrix(k,[[decode(c) for c in row] for row in rows],implementation='generic')
    encode=lambda c:[int(v) for v in k(c).polynomial().list()]
    encode_matrix=lambda M:[[encode(c) for c in row] for row in M.rows()]
    words=[tuple(int(n) for n in ex) for ex in certificate['basis_word_exponents']]
    matrices=[decode_matrix(M) for M in certificate['multiplication_matrices']]
    generator_coordinates=decode_matrix(certificate['generator_coordinates'])
    f=[P.decode(poly) for poly in certificate['annihilator_polynomials']]
    weights=[[P.decode(poly) for poly in row] for row in certificate['original_projected_row_multipliers']]
    lambdas=weights[:len(f)];generator_weights=weights[len(f):]
    borders=[[P.decode(poly) for poly in row] for row in certificate['border_annihilator_multipliers']]
    def polynomial_of(coordinates):
        return P.sum(P.monomial(ex,co) for ex,co in zip(words,coordinates))
    cache={P.zero:(vector(k,[1]+[0]*7),[{} for _ in f])}
    def monomial_reduction(ex):
        if ex in cache:return cache[ex]
        j=next(i for i,n in enumerate(ex) if n)
        before=list(ex);before[j]-=1;coordinates,old_weights=monomial_reduction(tuple(before))
        new_coordinates=coordinates*matrices[j]
        shift=tuple(int(i==j) for i in range(3))
        new_weights=[P.shift(poly,shift) for poly in old_weights]
        for a,co in enumerate(coordinates):
            if co:
                for h in range(len(f)):new_weights[h]=P.add(new_weights[h],borders[3*a+j][h],co)
        cache[ex]=(new_coordinates,new_weights)
        return cache[ex]
    def reduce_polynomial(poly):
        coordinates=vector(k,8);multipliers=[{} for _ in f]
        for ex,co in poly.items():
            row,row_weights=monomial_reduction(ex);coordinates+=co*row
            for h in range(len(f)):multipliers[h]=P.add(multipliers[h],row_weights[h],co)
        normal=polynomial_of(coordinates)
        assert P.add(P.add(poly,normal,-1),P.sum(P.multiply(a,b) for a,b in zip(multipliers,f)),-1)=={}
        return normal,multipliers
    b=[P.one]+P.gens
    coefficient_rows=[P.sum(P.scaled(b[j],S[1,4*i+j]) for j in range(4)) for i in range(4)]
    generator_polynomials=[polynomial_of(row) for row in generator_coordinates.rows()]
    substituted=P.sum(P.multiply(c,e) for c,e in zip(coefficient_rows,generator_polynomials))
    a,reduction_weights=reduce_polynomial(substituted)
    d=[P.add(P.sum(P.multiply(coefficient_rows[i],generator_weights[i][h]) for i in range(4)),
             P.sum(P.multiply(reduction_weights[l],lambdas[l][h]) for l in range(len(f)))) for h in range(8)]
    for i in range(4):
        s1=P.sum(P.scaled(b[j],S[1,4*i+j]) for j in range(4))
        s0=P.sum(P.scaled(b[j],S[0,4*i+j]) for j in range(4))
        n=[P.sum(P.scaled(b[j],N[h,4*i+j]) for j in range(4)) for h in range(8)]
        assert P.add(P.add(s1,P.multiply(a,s0),-1),P.sum(P.multiply(dh,nh) for dh,nh in zip(d,n)),-1)=={}
    r,K=reduce_polynomial(P.add(b[1],P.frobenius(a),-1))
    assert r==polynomial_of([decode(c) for c in conditions['rooted_graph_coordinate_vectors'][0]])
    unit_coefficients=[decode(c) for c in conditions['exact_graph_word_multipliers_or_dual']]
    assert len(unit_coefficients)==24 and not any(unit_coefficients[8:])
    u=polynomial_of(unit_coefficients[:8])
    zero,V=reduce_polynomial(P.add(P.one,P.multiply(u,r),-1));assert zero=={}
    C=ctx['projection'].stack(-ctx['left'].matrix_from_rows([0]))
    y=ctx['left'].row(1)
    result={'format':'backup_original13_factored_frobenius_identity_v1',
            'status':'explicit_original13_factored_polynomial_lift_pending_independent_replay',
            'tensor_path':str(Path(tensor_path).resolve()),'tensor_sha256':ctx['tensor_sha256'],
            'source_finite_certificate_path':str(Path(finite_path).resolve()),
            'source_finite_certificate_sha256':hashlib.sha256(finite_raw).hexdigest(),
            'field_degree':ctx['data']['field_degree'],'field_modulus':ctx['data']['field_modulus'],
            'twist_index':ctx['data']['twist_index'],'chart_first_nonzero_b':0,
            'variables':['p0','p1','p2','p3','b1','b2','b3','z'],
            'linear_forms_C_in_original12_rows':encode_matrix(C),
            'linear_form_y_in_original12_rows':[encode(co) for co in y],
            'annihilators':[P.encode(poly) for poly in f],
            'annihilator_row_weights':[[P.encode(poly) for poly in row] for row in lambdas],
            'a':P.encode(a),'d':[P.encode(poly) for poly in d],
            'r':P.encode(r),'u':P.encode(u),
            'K':[P.encode(poly) for poly in K],'V':[P.encode(poly) for poly in V],
            'factored_original_multiplier_formula':
                'Set c=C*F, y=yrow*F, Gamma_l=V_l-u*K_l, beta_h=sum_l Gamma_l*lambda_lh (h<8), beta_8=-sum_l Gamma_l*f_l, d_8=a. For each original row t<12: W_t=u^[5]*y^4*yrow_t+sum_h C_ht*(beta_h^[5]+u^[5]*d_h^[25]*c_h^4). Then sum_t W_t*F_t=1. Original inverse-norm multiplier W_12=0. All bracket powers are exact polynomial Frobenius, not coefficient-only powers.',
            'inverse_norm_multiplier_zero':True,
            'original13_row_independent_replay_passed':False,
            'scope':'Explicit polynomial provenance for this one chart. No common cover or whole representative is claimed before separate replay and geometric authority checks.',
            'elapsed_seconds':time.monotonic()-started}
    scope['atomic_json'](output,result)
    print(json.dumps({'status':result['status'],'elapsed_seconds':result['elapsed_seconds'],
                      'output':str(Path(output).resolve()),'bytes':Path(output).stat().st_size,
                      'sha256':hashlib.sha256(Path(output).read_bytes()).hexdigest(),
                      'polynomial_term_counts':{'a':len(a),'u':len(u),'r':len(r),
                           'd':[len(poly) for poly in d],'K':[len(poly) for poly in K],'V':[len(poly) for poly in V]}},indent=1),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True);parser.add_argument('--finite-certificate',required=True)
    parser.add_argument('--output',required=True)
    args=parser.parse_args();run(args.tensor,args.finite_certificate,args.output)
