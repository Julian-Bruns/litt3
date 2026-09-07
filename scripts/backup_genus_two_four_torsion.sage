#!/usr/bin/env sage
"""Bounded complete order-four torsion and twisted Bol-kernel calculation.

For each nonzero gamma=O(D_E-jO) in J[2], halves L=O(D-2O) satisfy
 (C^2 E-F/E)=Q^2, deg C<=1, deg Q=2.
For j=1 fix lead Q=2; for j=2 fix lead Q=lead C. These are four
quadratic equations in four variables. Every actual half occurs and
the verified sixteen nonsingular solutions exhaust [2]^{-1}(gamma).
Their h4=C^2 E+F/E+2Cv has divisor4D-8O. On z^4=h4, the complete
twisted quadratic basis is z*(1,u,(v+V)/U)*eta^2.
No rank vanishing, common cover, or atlas conclusion is assumed.
"""
import argparse,itertools,json,time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(seconds,output):
    started=time.monotonic();root=Path(__file__).resolve().parents[1]
    data=json.loads((root/'Research/computations/backup_genus_two_preparation.json').read_text())['opers']
    prime=GF(5);X=PolynomialRing(prime,'x');x=X.gen()
    # The exact Tate-module bounds put ALL J[4] over F125^2.
    small=GF(5**6,name='rho');rho=small.gen()
    a=(PolynomialRing(small,'t')([1,1,0,1])).roots(multiplicities=False)[0]
    large=GF(5**30,name='c');c=large.gen()
    Tlarge=PolynomialRing(large,'t')
    rho_image=Tlarge(small.modulus()).roots(multiplicities=False)[0]
    embedding=small.hom([rho_image],large);aa=embedding(a)
    decode=lambda cs:sum((large(cc)*aa**i for i,cc in enumerate(cs)),large.zero())
    oper_polynomial=Tlarge([decode(cs) for cs in data['separator_coefficients']])
    assert oper_polynomial.degree()==5
    b2=oper_polynomial.roots(multiplicities=False)[0]
    assert b2**(125**5)==b2 and b2**125!=b2
    b0=sum((decode(cs)*b2**i for i,cs in enumerate(data['b0_coefficients'])),large.zero())
    b1=sum((decode(cs)*b2**i for i,cs in enumerate(data['b1_coefficients'])),large.zero())
    R=PolynomialRing(large,'u');u=R.gen();K=R.fraction_field()
    F=u*(u-1)*(u-2)*(u-3)*(u-aa)
    potential=K(F.derivative(2))/(4*F)-3*K(F.derivative()**2)/(16*F**2)+(2*u**3+b0+b1*u+b2*u**2)/F
    assert potential.derivative(2)==3*potential**2
    encode=lambda value:[int(cc) for cc in value.polynomial().list()]
    def add(f,g):return (f[0]+g[0],f[1]+g[1])
    def neg(f):return (-f[0],-f[1])
    def mul(f,g):return (f[0]*g[0]+F*f[1]*g[1],f[0]*g[1]+f[1]*g[0])
    def scalar(cc,f):return (cc*f[0],cc*f[1])
    def derivative(f):return (f[0].derivative(),f[1].derivative()+K(F.derivative())*f[1]/(2*F))
    def inverse(f):
        norm=f[0]**2-F*f[1]**2;assert norm
        return (f[0]/norm,-f[1]/norm)
    B=PolynomialRing(small,names=['c0','c1','q0','q1'],order='degrevlex');c0,c1,q0,q1=B.gens()
    S=PolynomialRing(B,'t');t=S.gen();base=t*(t-1)*(t-2)*(t-3)*(t-a)
    branches=[small(0),small(1),small(2),small(3),a]
    out={'status':'bounded order-four torsion and Bol-kernel calculation in progress',
         'small_field_degree':6,'small_field_modulus':[int(co) for co in small.modulus().list()],'alpha_image':encode(a),
         'large_field_degree':30,'large_field_modulus':[int(co) for co in large.modulus().list()],
         'small_generator_image_in_large_field':encode(rho_image),
         'oper_parameters_in_large_field':[encode(bb) for bb in [b0,b1,b2]],
         'halving_classes':[],'scope':'Exact endpoint algebra; torsion parameterization and twisted-basis geometry are author prose pending audit. No actual common cover is asserted.'}
    target=Path(output);target.parent.mkdir(parents=True,exist_ok=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temp=Path(str(target)+'.tmp');temp.write_text(json.dumps(out,indent=1,default=int)+'\n');temp.replace(target)
    try:
        alarm(max(1,seconds-(time.monotonic()-started)))
        for size in [1,2]:
          for subset in itertools.combinations(branches,int(size)):
            E=prod(t-b for b in subset);quotient,rem=base.quo_rem(E);assert not rem
            C=c0+c1*t;Q=q0+q1*t+(2 if size==1 else c1)*t**2
            polynomial=C**2*E-quotient-Q**2
            equations=[polynomial[i] for i in range(4)]
            assert polynomial.degree()<=3 and all(f.total_degree()<=2 for f in equations)
            ideal=B.ideal(equations);gb=list(ideal.groebner_basis(algorithm='libsingular:std'))
            assert ideal.vector_space_dimension()==16
            points=ideal.variety(ring=small);assert len(points)==16
            jac=matrix(B,[[f.derivative(vv) for vv in B.gens()] for f in equations]).det()
            row={'finite_branch_subset':[encode(b) for b in subset],
                 'quadratic_equations':[str(f) for f in equations],'scheme_length':16,'solutions':[]}
            for point in points:
                values=[small(point[vv]) for vv in B.gens()]
                assert all(f(*values)==0 for f in equations) and jac(*values)
                assert any(value**125!=value for value in values)
                cc0,cc1,qq0,qq1=[embedding(value) for value in values]
                EE=R(prod(u-embedding(b) for b in subset));CC=cc0+cc1*u
                QQ=qq0+qq1*u+(large(2) if size==1 else cc1)*u**2
                UU=QQ/QQ[2];VV=(-CC*EE)%UU
                assert UU.degree()==2 and UU.is_monic() and UU.gcd(F)==1
                assert UU.gcd(UU.derivative())==1 and (VV**2-F)%UU==0
                assert CC**2*EE-F//EE==QQ**2
                hh=(K(CC**2*EE+F//EE),K(2*CC))
                assert hh[0]**2-F*hh[1]**2==QQ**4
                ell=add(scalar(large(1)/4,mul(derivative(hh),inverse(hh))),(-K(F.derivative())/F,K.zero()))
                rho=add(add(derivative(ell),mul(ell,ell)),(-potential,K.zero()))
                basis=[(K.one(),K.zero()),(K(u),K.zero()),(K(VV)/UU,K.one()/UU)]
                images=[add(add(derivative(derivative(f)),scalar(large(2),mul(ell,derivative(f)))),mul(rho,f)) for f in basis]
                denominator=lcm([R(part.denominator()) for image in images for part in image])
                components=[[R(denominator*image[part]) for image in images] for part in range(2)]
                degree=max(f.degree() for component in components for f in component)
                M=matrix(large,[[component[j][i] for j in range(3)] for component in components for i in range(degree+1)],implementation='generic')
                rank=M.rank();answer={'parameters':[encode(value) for value in values],
                    'jacobian_determinant':encode(small(jac(*values))),
                    'kernel_dimension_per_oper':int(3-rank)}
                if rank==3:
                    selected=list(M.transpose().pivots())[:3];minor=M.matrix_from_rows(selected)
                    determinant=minor.det();assert determinant
                    answer.update({'full_rank_rows':selected,'coefficient_degree_bound':int(degree),
                        'full_rank_minor_matrix':[[encode(co) for co in line] for line in minor.rows()],
                        'determinant_inverse':encode(1/determinant)})
                else:
                    kernel=M.right_kernel().basis();assert all(M*vv==0 for vv in kernel)
                    answer['kernel_basis']=[[encode(co) for co in vv] for vv in kernel]
                row['solutions'].append(answer)
            out['halving_classes'].append(row);checkpoint()
            print('halving class',len(out['halving_classes']),'kernel dimensions',[p['kernel_dimension_per_oper'] for p in row['solutions']],
                  'seconds',time.monotonic()-started,flush=True)
        assert len(out['halving_classes'])==15
        out['exact_order4_classes']=240
        out['all_order4_twisted_kernels_zero']=all(p['kernel_dimension_per_oper']==0 for row in out['halving_classes'] for p in row['solutions'])
        out['status']='complete exact 240-class order-four torsion and five-oper twisted Bol-kernel test'
    except (AlarmInterrupt,KeyboardInterrupt) as exc:
        out['status']='bounded order-four torsion and kernel test incomplete';out['interruption']=type(exc).__name__
    finally:cancel_alarm();checkpoint()
    print(json.dumps({'status':out['status'],'halving_classes_completed':len(out['halving_classes']),
                      'elapsed_seconds':out['elapsed_seconds']},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--seconds',type=int,default=45)
    parser.add_argument('--output',default='Research/computations/backup_genus_two_four_torsion.json')
    args=parser.parse_args();run(args.seconds,args.output)
