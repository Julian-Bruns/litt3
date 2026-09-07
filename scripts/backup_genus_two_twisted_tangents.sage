#!/usr/bin/env sage
"""Exact Bol kernels for all five backup opers and all sixteen J[2] twists.

For chi=O(D-jO), with E the product of j=1 or2 branch factors,
z^2=E trivializes chi on its actual etale double cover. The three
regular twisted quadratics are z*(1,u,v/E)*eta^2. These form the
complete space by their finite valuations, infinity poles and RR.
The operator is D_u^2-r in the horizontal chi frame. No vanishing is
assumed; nonzero kernels are saved if present.
"""
import argparse
import itertools
import json
import time
from pathlib import Path


def run(output):
    started=time.monotonic();root=Path(__file__).resolve().parents[1]
    data=json.loads((root/'Research/computations/backup_genus_two_preparation.json').read_text())['opers']
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'x')([1,1,0,1]));a=k.gen()
    Z=PolynomialRing(k,'z');z=Z.gen()
    decode=lambda cs:sum((k(c)*a**i for i,c in enumerate(cs)),k.zero())
    poly=lambda cs:Z([decode(c) for c in cs])
    q=poly(data['separator_coefficients']);assert q.degree()==5 and q.is_irreducible()
    A=Z.quotient(q,names='b2');b2=A.gen()
    b0=A(poly(data['b0_coefficients']));b1=A(poly(data['b1_coefficients']))
    R=PolynomialRing(A,'u');u=R.gen();K=R.fraction_field()
    F=u*(u-1)*(u-2)*(u-3)*(u-a)
    potential=K(F.derivative(2))/(4*F)-3*K(F.derivative()**2)/(16*F**2)+(2*u**3+b0+b1*u+b2*u**2)/F
    assert potential.derivative(2)==3*potential**2
    encode=lambda c:[int(v) for v in k(c).polynomial().list()]
    encpoly=lambda f:[encode(c) for c in Z(f).list()]
    rows=[];branches=[k(0),k(1),k(2),k(3),a]
    for size in [0,1,2]:
      for subset in itertools.combinations(branches,int(size)):
        E=R(prod(u-b for b in subset));common=F**2*E**2
        logA=K(E.derivative())/(2*E)-K(F.derivative())/F
        rho=logA.derivative()+logA**2-potential
        if size==0:
            images=[R(common*(C.derivative(2)+2*logA*C.derivative()+rho*C)) for C in [R.one(),u,u**2]]
            M=matrix(A,[[image[i] for image in images] for i in range(max(f.degree() for f in images)+1)])
            row_descriptors=[['rational',i] for i in range(M.nrows())]
        else:
            logB=-K(E.derivative())/(2*E)-K(F.derivative())/(2*F)
            images=[R(common*rho),R(common*(2*logA+u*rho)),R(common*(logB.derivative()+logB**2-potential))]
            degree=max(f.degree() for f in images)
            coefficients=[[images[0][i],images[1][i],A.zero()] for i in range(degree+1)]
            coefficients += [[A.zero(),A.zero(),images[2][i]] for i in range(degree+1)]
            M=matrix(A,coefficients)
            row_descriptors=[['z_over_F',i] for i in range(degree+1)]+[['one_over_zv',i] for i in range(degree+1)]
        rank=M.rank();pivots=list(M.transpose().pivots())
        row={'finite_branch_subset':[encode(b) for b in subset],
             'kernel_dimension_per_oper':int(3-rank),'matrix_rank':int(rank),
             'coefficient_row_descriptors':row_descriptors,
             'matrix':[[encpoly(c.lift()) for c in line] for line in M.rows()]}
        if rank==3:
            selected=pivots[:3];minor=M.matrix_from_rows(selected).det().lift()
            gcd,s0,t0=q.xgcd(minor)
            assert gcd==1 and s0*q+t0*minor==1
            row.update({'full_rank_rows':selected,'full_rank_minor':encpoly(minor),
                        'bezout_q_multiplier':encpoly(s0),'bezout_minor_multiplier':encpoly(t0)})
        else:
            kernel=M.right_kernel().basis()
            assert all(M*vector(A,v)==0 for v in kernel)
            row['kernel_basis']=[[encpoly(c.lift()) for c in v] for v in kernel]
        rows.append(row)
    assert len(rows)==16
    result={'status':'complete exact five-oper sixteen-two-torsion Bol-kernel test',
            'field_modulus':[1,1,0,1],'oper_separator':data['separator_coefficients'],
            'twists':rows,'all_twisted_kernels_zero':all(row['kernel_dimension_per_oper']==0 for row in rows),
            'elapsed_seconds':time.monotonic()-started,
            'scope':'Endpoint twisted quadratic tangent spaces only; no atlas or common-cover conclusion is automatic. Basis/gluing argument is author prose pending audit.'}
    target=Path(output);temporary=Path(str(target)+'.tmp')
    temporary.write_text(json.dumps(result,indent=1,default=int)+'\n');temporary.replace(target)
    print(json.dumps({'status':result['status'],'kernel_dimensions':[row['kernel_dimension_per_oper'] for row in rows],
                      'elapsed_seconds':result['elapsed_seconds']},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',default='Research/computations/backup_genus_two_twisted_tangents.json')
    args=parser.parse_args();run(args.output)
