#!/usr/bin/env sage
"""Replay the backup nilpotent census without a radical or Groebner solver.

Explicit squarefree finite algebras produce 90 distinct solutions. Five
dormant solutions have three local equations in m^2, hence length>=8;
the 85 other Jacobian determinants are units. These lower bounds exhaust
the length-125 pure-leading-fifth presentation. No common span is claimed.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path


def run(path,output):
    started=time.monotonic();raw=Path(path).read_bytes();data=json.loads(raw)
    assert data['status']=='complete determinant-zero census with exact radical, multiplicities and zero profiles'
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'x')(data['field_modulus']));a=k.gen()
    B=PolynomialRing(k,names=['b0','b1','b2'],order='degrevlex');b0,b1,b2=B.gens()
    R=PolynomialRing(B,'u');u=R.gen();F=u*(u-1)*(u-2)*(u-3)*(u-a)
    num=4*F*F.derivative(2)+2*F.derivative()**2+(2*u**3+b0+b1*u+b2*u**2)*F
    curv=(F**2*num.derivative(2)-4*F*F.derivative()*num.derivative()
          +(6*F.derivative()**2-2*F*F.derivative(2))*num-3*num**2)
    h=F*curv.derivative()-4*F.derivative()*curv
    det=-h**2-3*curv*(F*h.derivative()+3*num*curv)
    horizontal,rem=det.quo_rem(F**5)
    assert not rem and not horizontal.derivative() and horizontal.degree()<=10
    original=[horizontal[j] for j in [0,5,10]]
    loc=dict(zip(B.variable_names(),B.gens()));loc['a']=a
    assert original==[B(sage_eval(f,locals=loc)) for f in data['original_equations']]
    assert [f.lm() for f in original]==[v**5 for v in B.gens()]
    assert all(f.lc()==-1 and f.total_degree()==5 for f in original)
    # Pairwise coprime leading monomials prove the standard-monomial count125.
    jacobian=matrix(B,[[f.derivative(v) for v in B.gens()] for f in original])
    jac=jacobian.det()
    quartic,rem=curv.quo_rem(F**2);assert not rem
    quartic/=3
    Z=PolynomialRing(k,'z');z=Z.gen()
    decode=lambda cs:sum((k(c)*a**i for i,c in enumerate(cs)),k.zero())
    poly=lambda cs:Z([decode(c) for c in cs])
    previous=[];distinct=dormant_count=active_count=0;classes={};actual_rows=[]
    for index,fiber in enumerate(data['squarefree_fiber_shapes']):
        b2_factor=poly(fiber['b2_factor'])
        assert b2_factor.is_monic() and b2_factor.is_irreducible()
        assert all(b2_factor.gcd(old)==1 for old in previous);previous.append(b2_factor)
        q,p0,p1,p2=[poly(cs) for cs in fiber['q_p0_p1_p2']]
        scalar=decode(fiber['separator_scalar'])
        assert q.is_monic() and q.gcd(q.derivative())==1
        assert b2_factor(p2)%q==0 and (p2+scalar*p1+scalar**2*p0-z)%q==0
        ev=B.hom([p0,p1,p2],Z)
        assert all(ev(f)%q==0 for f in original)
        dormant=q
        for c in quartic.list():dormant=dormant.gcd(ev(c)%q)
        assert all(ev(c)%dormant==0 for c in jacobian.list())
        assert q.gcd(ev(jac)%q)==dormant
        distinct+=q.degree();dormant_count+=dormant.degree();active_count+=q.degree()-dormant.degree()
        # Independently check C_3(s^4)=s in coefficient form on the full fiber.
        A=Z.quotient(q,names='zz');S=PolynomialRing(A,'t');t=S.gen()
        G=S([A(ev(c)) for c in quartic.list()]);base=t*(t-1)*(t-2)*(t-3)*(t-a)
        fourth=G**4*base**2
        assert all(fourth[5*j+4]==G[j]**5 for j in range(5))
        for factor,multiplicity in q.factor():
            assert multiplicity==1
            asleep=not dormant%factor
            expected=[row for row in data['closed_points'] if row['fiber_index']==index and poly(row['separator_factor'])==factor]
            assert len(expected)==1;row=expected[0]
            assert row['residue_degree_over_F125']==factor.degree()
            assert row['dormant']==bool(asleep) and row['local_multiplicity']==(8 if asleep else 1)
            if not asleep:
                L=Z.quotient(factor,names='zz');T=PolynomialRing(L,'t');t=T.gen()
                G=T([L(ev(c)) for c in quartic.list()]);base=t*(t-1)*(t-2)*(t-3)*(t-a)
                assert G.degree() in [3,4]
                branch=G.gcd(base);square=G.gcd(G.derivative()).monic()
                assert square.gcd(base)==1 and square.is_squarefree()
                residual,rem=G.quo_rem(branch*square**2)
                assert not rem and residual.degree()==0 and residual
                chosen=[i for i,b in enumerate([k(0),k(1),k(2),k(3),a]) if not G(b)]
                if G.degree()==3:chosen.append(5)
                assert len(chosen) in [0,2,4]
                if len(chosen)==4:chosen=[i for i in range(6) if i not in chosen]
                assert row['quadratic_root_two_torsion_branch_pair']==chosen
                assert row['quartic_zero_orders']==[2,2,2,2]
                assert branch.degree()+2*square.degree()+(G.degree()==3)==4
                key=tuple(chosen);classes[key]=classes.get(key,0)+factor.degree()
            actual_rows.append(row)
    assert len(actual_rows)==len(data['closed_points'])
    assert distinct==90 and dormant_count==5 and active_count==85
    assert 8*dormant_count+active_count==125
    assert len(classes)==16 and classes[()]==10 and all(v==5 for c,v in classes.items() if c)
    result={'status':'PASS independent no-solver nilpotent census replay',
            'certificate_sha256':hashlib.sha256(raw).hexdigest(),'scheme_length':125,
            'distinct_points':90,'dormant_points':5,'dormant_local_multiplicity':8,
            'active_points':85,'active_jacobian_units_verified':True,
            'normalized_generalized_Cartier_equation_verified':True,
            'all_active_quartics_have_four_double_zeros':True,
            'trivial_root_class_count':10,'each_of_15_nontrivial_root_class_count':5,
            'elapsed_seconds':time.monotonic()-started,
            'scope':'Exact endpoint algebra. Scalar connection geometry and multiplicity argument are author prose, not an independent mathematical audit. No common connection or source ordinarity is inferred.'}
    if output:
        target=Path(output);temporary=Path(str(target)+'.tmp')
        temporary.write_text(json.dumps(result,indent=2,default=int)+'\n');temporary.replace(target)
    print(json.dumps(result,indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificate',nargs='?',default='Research/computations/backup_genus_two_nilpotents.json')
    parser.add_argument('--output',default='Research/computations/backup_genus_two_nilpotents_verification.json')
    args=parser.parse_args();run(args.certificate,args.output)
