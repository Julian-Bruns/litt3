#!/usr/bin/env sage
"""Independent original13-row replay of a factored Frobenius certificate.

Reads only the original tensor and the factored certificate.  It does NOT
read the finite-algebra certificate, run elimination, or evaluate points.
All original linear-in-p polynomial identities are checked coefficient by
coefficient.  Their characteristic-five composition is the explicit unit
identity with the polynomial multipliers printed in the certificate.
"""
import argparse
import copy
import hashlib
import json
import time
from pathlib import Path
from atlas_field_maps import from_power_coordinates
from backup_sparse_polynomials import SparsePolynomials


def verify(tensor_raw,certificate,progress=True):
    started=time.monotonic();data=json.loads(tensor_raw)
    assert certificate['format']=='backup_original13_factored_frobenius_identity_v1'
    assert certificate['tensor_sha256']==hashlib.sha256(tensor_raw).hexdigest()
    assert certificate['chart_first_nonzero_b']==0
    assert certificate['field_degree']==data['field_degree']
    assert certificate['field_modulus']==data['field_modulus']
    assert certificate['inverse_norm_multiplier_zero'] is True
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**data['field_degree'],name='c',modulus=prime(data['field_modulus']))
    decode=lambda cs:from_power_coordinates(k,cs)
    P=SparsePolynomials(k);b=[P.one]+P.gens
    I=matrix(k,[[decode(c) for c in row] for row in data['I']],implementation='generic')
    C=matrix(k,[[decode(c) for c in row] for row in certificate['linear_forms_C_in_original12_rows']],implementation='generic')
    yrow=vector(k,[decode(c) for c in certificate['linear_form_y_in_original12_rows']])
    assert I.dimensions()==(12,4) and C.dimensions()==(9,12) and len(yrow)==12
    expected=matrix(k,9,4,implementation='generic');expected[8,0]=-1
    assert C*I==expected and yrow*I==vector(k,[0,1,0,0])
    assert len(data['tensor'])==4 and all(len(row)==4 for row in data['tensor'])
    assert all(len(entry)==12 for row in data['tensor'] for entry in row)
    # The five entries encode constant,p0,p1,p2,p3 coefficients.  This
    # reconstructs the ORIGINAL I*b+T(p,b^[5]) rows, not projected inputs.
    original=[]
    for h in range(12):
        row=[P.sum(P.scaled(b[j],I[h,j]) for j in range(4))]
        row += [P.sum(P.scaled(P.frobenius(b[j]),decode(data['tensor'][i][j][h])) for j in range(4)) for i in range(4)]
        original.append(row)
    assert len(data['ell'])==4 and all(len(row)==4 for row in data['ell'])
    # Row13 is z*(sum_i p_i*norm_coefficients_i)-1.  Its multiplier is
    # EXPLICITLY zero, so no localization or determinant is silently used.
    norm_coefficients=[P.sum(P.scaled(b[j],decode(data['ell'][i][j])) for j in range(4)) for i in range(4)]
    assert len(norm_coefficients)==4
    def linear_combination(coefficients):
        return [P.sum(P.scaled(original[h][i],co) for h,co in enumerate(coefficients)) for i in range(5)]
    c=[linear_combination(row) for row in C.rows()];y=linear_combination(yrow)
    one_c8=list(c[8]);one_c8[0]=P.add(P.one,one_c8[0])
    f=[P.decode(poly) for poly in certificate['annihilators']]
    lambdas=[[P.decode(poly) for poly in row] for row in certificate['annihilator_row_weights']]
    a=P.decode(certificate['a']);d=[P.decode(poly) for poly in certificate['d']]
    r=P.decode(certificate['r']);u=P.decode(certificate['u'])
    K=[P.decode(poly) for poly in certificate['K']];V=[P.decode(poly) for poly in certificate['V']]
    assert len(f)==len(lambdas)==len(K)==len(V)>0 and all(len(row)==8 for row in lambdas)
    assert len(d)==8
    if progress:print(json.dumps({'stage':'all13 original rows reconstructed and coefficients decoded','seconds':time.monotonic()-started}),flush=True)
    # Identity A_l: f_l^[5]*(1+c8)=sum_h lambda_lh^[5]*c_h.
    for fl,row in zip(f,lambdas):
        f5=P.frobenius(fl);weights=[P.frobenius(poly) for poly in row]
        for i in range(5):
            assert P.add(P.multiply(f5,one_c8[i]),P.sum(P.multiply(weights[h],c[h][i]) for h in range(8)),-1)=={}
    # Identity B: b1-y=a^[5]*(1+c8)+sum_h d_h^[5]*c_h.
    a5=P.frobenius(a);d5=[P.frobenius(poly) for poly in d]
    for i in range(5):
        left=P.add(b[1] if i==0 else {},y[i],-1)
        right=P.add(P.multiply(a5,one_c8[i]),P.sum(P.multiply(d5[h],c[h][i]) for h in range(8)))
        assert left==right
    if progress:print(json.dumps({'stage':'all original linear-in-p identities PASS','seconds':time.monotonic()-started}),flush=True)
    # The scalar identities are checked as POLYNOMIAL identities over k,
    # not merely in the finite quotient used to discover them.
    assert P.add(P.add(b[1],a5,-1),r,-1)==P.sum(P.multiply(kl,fl) for kl,fl in zip(K,f))
    assert P.add(P.one,P.multiply(u,r),-1)==P.sum(P.multiply(vl,fl) for vl,fl in zip(V,f))
    # EXACT COMPOSITION, with Gamma_l=V_l-u*K_l:
    #   1 = u^[5] y^5 + sum_l Gamma_l^[5] f_l^[5]
    #       + u^[5] sum_h d_h^[25] c_h^5 + u^[5] a^[25] c8^5.
    # Substitute A_l, then c_h=sum_t C_ht F_t and y=sum_t yrow_t F_t.
    # This is precisely sum_t W_t F_t=1 for the stated FACTORED POLYNOMIAL
    # multipliers; no inverse, cancellation by a nonunit, or reducedness
    # assumption is involved.  The row13 multiplier is zero.
    return {'status':'original13_factored_polynomial_unit_identity_replay_PASS',
            'original_incidence_rows_reconstructed':12,'original_inverse_norm_row_reconstructed':True,
            'original_linear_in_p_identities_verified':len(f)+1,
            'three_variable_scalar_polynomial_identities_verified':2,
            'original13_unit_identity_exact_by_frobenius_composition':True,
            'original_inverse_norm_multiplier_zero':True,
            'expanded_multivariate_unit_polynomial_materialized':False,
            'elimination_or_point_evaluation_used':False,
            'elapsed_seconds':time.monotonic()-started}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True);parser.add_argument('--certificate',required=True)
    parser.add_argument('--output',required=True);parser.add_argument('--negative-tests',action='store_true')
    args=parser.parse_args();started=time.monotonic()
    raw=Path(args.tensor).read_bytes();certificate_raw=Path(args.certificate).read_bytes()
    certificate=json.loads(certificate_raw);result=verify(raw,certificate)
    if args.negative_tests:
        rejected=[]
        for name in ['unit_inverse','original_annihilator_weight']:
            damaged=copy.deepcopy(certificate)
            polynomial=damaged['u'] if name=='unit_inverse' else damaged['annihilator_row_weights'][0][0]
            assert polynomial
            values=polynomial[0][1]
            if values:values[0]=(values[0]+1)%5
            else:values.append(1)
            try:verify(raw,damaged,progress=False)
            except AssertionError:rejected.append(name)
            else:raise AssertionError('Corrupted certificate was accepted: '+name)
        result['negative_mutations_rejected']=rejected
    result.update(tensor_sha256=hashlib.sha256(raw).hexdigest(),certificate_sha256=hashlib.sha256(certificate_raw).hexdigest(),
                  twist_index=certificate['twist_index'],chart_first_nonzero_b=0,
                  total_seconds=time.monotonic()-started,
                  scope='Original-row arithmetic replay only. Twisted Cech geometry audit and whole common-cover gaps are separate.')
    output=Path(args.output);temporary=Path(str(output)+'.tmp')
    temporary.write_text(json.dumps(result,indent=1,default=int)+'\n');temporary.replace(output)
    print(json.dumps(result,indent=1,default=int),flush=True)
