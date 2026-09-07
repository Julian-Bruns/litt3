#!/usr/bin/env sage
"""No-solver replay of all240 exact order-four halves and Bol rank minors.

Sixteen distinct valid halves exhaust each fiber of [2] on a genus-two
Jacobian. The proof of the torsion/divisor and twisted-basis dictionary
is separate author prose; this verifier checks every numerical identity.
"""
import argparse,hashlib,itertools,json,time
from pathlib import Path


def run(path,output):
    started=time.monotonic();raw=Path(path).read_bytes();data=json.loads(raw)
    assert data['status']=='complete exact 240-class order-four torsion and five-oper twisted Bol-kernel test'
    P=PolynomialRing(GF(5),'x')
    small=GF(5**6,name='rho',modulus=P(data['small_field_modulus']));rho=small.gen()
    large=GF(5**30,name='c',modulus=P(data['large_field_modulus']));c=large.gen()
    dec_small=lambda cs:small(P(cs));dec_large=lambda cs:large(P(cs))
    a=dec_small(data['alpha_image']);assert a**3+a+1==0 and a**5!=a
    embedding=small.hom([dec_large(data['small_generator_image_in_large_field'])],large);aa=embedding(a)
    b0,b1,b2=[dec_large(cs) for cs in data['oper_parameters_in_large_field']]
    assert b2**(15625**5)==b2 and b2**15625!=b2
    opers=json.loads((Path(__file__).resolve().parents[1]/'Research/computations/backup_genus_two_preparation.json').read_text())['opers']
    base_decode=lambda cs:sum((large(co)*aa**i for i,co in enumerate(cs)),large.zero())
    assert sum((base_decode(cs)*b2**i for i,cs in enumerate(opers['separator_coefficients'])),large.zero())==0
    assert b0==sum((base_decode(cs)*b2**i for i,cs in enumerate(opers['b0_coefficients'])),large.zero())
    assert b1==sum((base_decode(cs)*b2**i for i,cs in enumerate(opers['b1_coefficients'])),large.zero())
    R=PolynomialRing(large,'u');u=R.gen();K=R.fraction_field()
    F=u*(u-1)*(u-2)*(u-3)*(u-aa)
    potential=K(F.derivative(2))/(4*F)-3*K(F.derivative()**2)/(16*F**2)+(2*u**3+b0+b1*u+b2*u**2)/F
    assert potential.derivative(2)==3*potential**2
    def mul(x,y):return (x[0]*y[0]+F*x[1]*y[1],x[0]*y[1]+x[1]*y[0])
    def add(x,y):return (x[0]+y[0],x[1]+y[1])
    def scale(a,x):return (a*x[0],a*x[1])
    def d(x):return (x[0].derivative(),x[1].derivative()+K(F.derivative())*x[1]/(2*F))
    def inv(x):
        n=x[0]**2-F*x[1]**2;assert n
        return (x[0]/n,-x[1]/n)
    B=PolynomialRing(small,names=['c0','c1','q0','q1']);c0,c1,q0,q1=B.gens()
    S=PolynomialRing(B,'t');t=S.gen();base=t*(t-1)*(t-2)*(t-3)*(t-a)
    branch=[small(0),small(1),small(2),small(3),a]
    expected={tuple(subset) for size in [1,2] for subset in itertools.combinations(branch,int(size))}
    seen=set();seen_divisors=set();count=0
    for row in data['halving_classes']:
        subset=tuple(dec_small(cs) for cs in row['finite_branch_subset']);assert subset in expected and subset not in seen;seen.add(subset)
        size=len(subset);E=prod(t-b for b in subset);quotient,rem=base.quo_rem(E);assert not rem
        C=c0+c1*t;Q=q0+q1*t+(2 if size==1 else c1)*t**2
        polynomial=C**2*E-quotient-Q**2;assert polynomial.degree()<=3
        equations=[polynomial[i] for i in range(4)]
        jac=matrix(B,[[f.derivative(v) for v in B.gens()] for f in equations]).det()
        solutions=set()
        for point in row['solutions']:
            values=tuple(dec_small(cs) for cs in point['parameters']);assert values not in solutions;solutions.add(values)
            assert all(f(*values)==0 for f in equations)
            assert jac(*values)==dec_small(point['jacobian_determinant']) and jac(*values)
            cc0,cc1,qq0,qq1=[embedding(value) for value in values]
            EE=R(prod(u-embedding(b) for b in subset));CC=cc0+cc1*u
            QQ=qq0+qq1*u+(large(2) if size==1 else cc1)*u**2
            UU=QQ/QQ[2];VV=(-CC*EE)%UU
            assert UU.is_monic() and UU.degree()==2 and UU.gcd(UU.derivative())==UU.gcd(F)==1
            assert (VV**2-F)%UU==0 and CC**2*EE-F//EE==QQ**2
            divisor_key=(tuple(UU.list()),tuple(VV.list()))
            assert divisor_key not in seen_divisors;seen_divisors.add(divisor_key)
            hh=(K(CC**2*EE+F//EE),K(2*CC));assert hh[0]**2-F*hh[1]**2==QQ**4
            ell=add(scale(large(1)/4,mul(d(hh),inv(hh))),(-K(F.derivative())/F,K.zero()))
            curvature=add(add(d(ell),mul(ell,ell)),(-potential,K.zero()))
            basis=[(K.one(),K.zero()),(K(u),K.zero()),(K(VV)/UU,K.one()/UU)]
            images=[add(add(d(d(f)),scale(large(2),mul(ell,d(f)))),mul(curvature,f)) for f in basis]
            denominator=lcm([R(part.denominator()) for image in images for part in image])
            polys=[[R(denominator*image[part]) for image in images] for part in range(2)]
            degree=max(f.degree() for component in polys for f in component)
            assert degree==point['coefficient_degree_bound'] and point['kernel_dimension_per_oper']==0
            coeffs=[[component[j][i] for j in range(3)] for component in polys for i in range(degree+1)]
            selected=point['full_rank_rows'];assert len(selected)==len(set(selected))==3
            minor=matrix(large,[coeffs[i] for i in selected],implementation='generic')
            assert minor==matrix(large,[[dec_large(cs) for cs in line] for line in point['full_rank_minor_matrix']],implementation='generic')
            assert minor.det()*dec_large(point['determinant_inverse'])==1
            count+=1
        assert len(solutions)==16
    assert seen==expected and count==len(seen_divisors)==240
    result={'status':'PASS independent no-solver order-four torsion/Bol replay',
            'certificate_sha256':hashlib.sha256(raw).hexdigest(),'halving_fibers':15,
            'distinct_halves_per_fiber':16,'exact_order4_classes':240,
            'oper_frobenius_orbit_over_F15625':5,'order4_twisted_kernel_cases_verified':1200,
            'all_order4_twisted_kernels_zero':True,'elapsed_seconds':time.monotonic()-started,
            'scope':'Exact identities and rank minors only; the divisor/torsion/twisted-basis application is author prose, not an independent mathematical audit.'}
    target=Path(output);temp=Path(str(target)+'.tmp');temp.write_text(json.dumps(result,indent=2,default=int)+'\n');temp.replace(target)
    print(json.dumps(result,indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificate',nargs='?',default='Research/computations/backup_genus_two_four_torsion.json')
    parser.add_argument('--output',default='Research/computations/backup_genus_two_four_torsion_verification.json')
    args=parser.parse_args();run(args.certificate,args.output)
