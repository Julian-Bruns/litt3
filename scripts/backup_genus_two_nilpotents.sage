#!/usr/bin/env sage
"""Bounded full determinant-zero algebra on the backup's regular oper chart.

This checks the rational p-curvature determinant and its actual coefficient
ideal. The nilpotent/Cartier bridge is a separate author theorem. No shared
connection or common-cover compatibility is asserted by this endpoint census.
"""
import argparse
import json
import time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(seconds,output):
    started=time.monotonic()
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'x')([1,1,0,1]));a=k.gen()
    B=PolynomialRing(k,names=['b0','b1','b2'],order='lex');b0,b1,b2=B.gens()
    R=PolynomialRing(B,'u');u=R.gen();F=u*(u-1)*(u-2)*(u-3)*(u-a)
    numerator=4*F*F.derivative(2)+2*F.derivative()**2+(2*u**3+b0+b1*u+b2*u**2)*F
    curvature=(F**2*numerator.derivative(2)-4*F*F.derivative()*numerator.derivative()
        +(6*F.derivative()**2-2*F*F.derivative(2))*numerator-3*numerator**2)
    h=F*curvature.derivative()-4*F.derivative()*curvature
    determinant=-h**2-3*curvature*(F*h.derivative()+3*numerator*curvature)
    assert not determinant.derivative()
    global_det,rem=determinant.quo_rem(F**5)
    assert not rem and global_det.degree()<=10
    assert all(not c for i,c in enumerate(global_det.list()) if i%5)
    original=[global_det[i] for i in [0,5,10]]
    assert all(f.total_degree()==5 for f in original)
    out={'status':'determinant equations built; census pending','field_modulus':[1,1,0,1],
         'potential':'r=(4FF_second+2F_first^2+(2u^3+b0+b1u+b2u^2)F)/F^2',
         'determinant':'-E_first^2-3E(E_second+3rE), E=r_second-3r^2',
         'original_equations':[str(f) for f in original],
         'global_horizontal_divisibility_verified':True,'closed_points':[],
         'scope':'One endpoint only. Geometric bridge author-proof audit pending.'}
    target=Path(output);target.parent.mkdir(parents=True,exist_ok=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temp=Path(str(target)+'.tmp');temp.write_text(json.dumps(out,indent=1,default=int)+'\n');temp.replace(target)
    encode=lambda c:[int(v) for v in k(c).polynomial().list()]
    try:
        alarm(max(1,seconds-(time.monotonic()-started)))
        graded=PolynomialRing(k,names=['b0','b1','b2'],order='degrevlex')
        graded_eq=[graded(f) for f in original]
        assert [f.lm() for f in graded_eq]==[v**5 for v in graded.gens()]
        assert all(f.lc()==-1 for f in graded_eq)
        graded_ideal=graded.ideal(graded_eq)
        out['scheme_length']=int(graded_ideal.vector_space_dimension())
        assert out['scheme_length']==125
        ideal=B.ideal(original);gb=list(ideal.groebner_basis(algorithm='libsingular:std'))
        out['groebner_basis']=[str(f) for f in gb];checkpoint()
        print('full scheme length125',time.monotonic()-started,flush=True)
        radical=ideal.radical();rgb=list(radical.groebner_basis(algorithm='libsingular:std'))
        out['radical_groebner_basis']=[str(f) for f in rgb]
        out['geometric_point_count']=int(radical.vector_space_dimension());checkpoint()
        assert all(not f.reduce(rgb) for f in original)
        print('candidate radical points',out['geometric_point_count'],time.monotonic()-started,flush=True)
        Z=PolynomialRing(k,'z');z=Z.gen()
        transformed=PolynomialRing(k,names=['c0','c1','z'],order='lex');c0,c1,zz=transformed.gens()
        sub=transformed.hom([Z.zero(),Z.zero(),z],Z)
        jac=matrix(B,[[f.derivative(v) for v in B.gens()] for f in original]).det()
        Epoly,rem=curvature.quo_rem(F**2);assert not rem and Epoly.degree()<=4
        out['active_quartic_polynomial']=[str(c/3) for c in Epoly.list()]
        b2_eliminants=[f for f in rgb if f.degree(b0)==f.degree(b1)==0]
        assert len(b2_eliminants)==1
        eliminant=Z(b2_eliminants[0].univariate_polynomial())
        assert eliminant.gcd(eliminant.derivative())==1
        out['b2_eliminant']=[encode(c) for c in eliminant.list()]
        out['squarefree_fiber_shapes']=[]
        distinct=dormant_count=active_count=0
        inject=Z.hom([b2],B)
        for b2_factor,b2_multiplicity in eliminant.factor():
            assert b2_multiplicity==1
            relation=inject(b2_factor)
            # Reducing BEFORE changing coordinates avoids expanding the
            # degree-82 eliminant in three variables. Each fiber has degree<=5.
            fiber_eq=[f.reduce([relation]) for f in rgb]+[relation]
            shape=None
            for index in range(125):
                scalar=k(index%5)+k((index//5)%5)*a+k(index//25)*a**2
                change=B.hom([c0,c1,zz-scalar*c1-scalar**2*c0],transformed)
                candidates=list(transformed.ideal([change(f) for f in fiber_eq]).groebner_basis(algorithm='libsingular:std'))
                if (len(candidates)==3 and candidates[0]==c0+transformed(sub(candidates[0])) and
                    candidates[1]==c1+transformed(sub(candidates[1])) and
                    candidates[2]==transformed(sub(candidates[2]))):
                    shape=candidates;break
            assert shape is not None
            p0=-sub(shape[0]);p1=-sub(shape[1]);p2=z-scalar*p1-scalar**2*p0;q=sub(shape[2])
            assert q.is_monic() and q.gcd(q.derivative())==1
            evaluation=B.hom([p0,p1,p2],Z)
            assert all(evaluation(f)%q==0 for f in original)
            assert b2_factor(p2)%q==0
            assert (p2+scalar*p1+scalar**2*p0-z)%q==0
            dormant=q
            for c in Epoly.list():dormant=dormant.gcd(evaluation(c)%q)
            jac_reduced=evaluation(jac)%q
            assert q.gcd(jac_reduced)==dormant
            distinct+=q.degree();dormant_count+=dormant.degree();active_count+=q.degree()-dormant.degree()
            out['squarefree_fiber_shapes'].append({
                'b2_factor':[encode(c) for c in b2_factor.list()],
                'separator_scalar':encode(scalar),
                'q_p0_p1_p2':[[encode(c) for c in f.list()] for f in [q,p0,p1,p2]],
                'original_equations_and_separator_verified':True,
                'jacobian_vanishes_exactly_at_dormant_points':True})
            for factor,multiplicity in q.factor():
              assert multiplicity==1
              dormant_here=not dormant%factor
              row={'residue_degree_over_F125':int(factor.degree()),
                 'fiber_index':len(out['squarefree_fiber_shapes'])-1,
                 'separator_factor':[encode(c) for c in factor.list()],
                 'local_multiplicity':8 if dormant_here else 1,'dormant':bool(dormant_here)}
              if not dormant_here:
                L=Z.quotient(factor,names='zeta');zeta=L.gen()
                T=PolynomialRing(L,'t');t=T.gen()
                ev=B.hom([L(p0),L(p1),L(p2)],L)
                quartic=T([ev(c)/3 for c in Epoly.list()])
                base=t*(t-1)*(t-2)*(t-3)*(t-a)
                assert quartic.degree() in [3,4]
                branch=quartic.gcd(base);square=quartic.gcd(quartic.derivative()).monic()
                assert square.gcd(base)==1 and square.is_squarefree()
                residual,rem=quartic.quo_rem(branch*square**2)
                assert not rem and residual.degree()==0 and residual
                chosen=[i for i,b in enumerate([k(0),k(1),k(2),k(3),a]) if not quartic(b)]
                if quartic.degree()==3:chosen.append(5)
                assert len(chosen) in [0,2,4]
                if len(chosen)==4:chosen=[i for i in range(6) if i not in chosen]
                assert branch.degree()+2*square.degree()+(quartic.degree()==3)==4
                row.update({'quartic_zero_orders':[2,2,2,2],
                            'quadratic_root_two_torsion_branch_pair':chosen,
                            'nonbranch_root_polynomial_degree':int(square.degree())})
              out['closed_points'].append(row)
            checkpoint()
        # These are 90 explicitly distinct solutions, not an unverified
        # invocation of radical(). Distinct fibers have coprime b2-polynomials;
        # within a fiber the squarefree separator identifies every point.
        # At a dormant point all three determinant equations start in degree2,
        # so the zero-dimensional complete intersection has length>=2^3.
        assert distinct==90 and dormant_count==5 and active_count==85
        assert 8*dormant_count+active_count==out['scheme_length']
        out['dormant_geometric_count']=int(dormant_count)
        out['active_geometric_count']=int(active_count)
        out['explicit_distinct_solution_count']=int(distinct)
        out['completeness_certificate']='90 disjoint squarefree explicit solutions; five dormant local complete intersections have length at least 8; 85 active Jacobian determinants are nonzero; total lower bound equals 125'
        out['total_local_lengths_verified']=int(8*dormant_count+active_count)
        out['status']='complete determinant-zero census with exact radical, multiplicities and zero profiles'
    except (AlarmInterrupt,KeyboardInterrupt) as exc:
        out['status']='bounded determinant-zero census incomplete';out['interruption']=type(exc).__name__
    finally:
        cancel_alarm();checkpoint()
    print(json.dumps({key:out[key] for key in ['status','elapsed_seconds','scheme_length','geometric_point_count'] if key in out},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--seconds',type=int,default=60)
    parser.add_argument('--output',default='Research/computations/backup_genus_two_nilpotents.json')
    args=parser.parse_args();run(args.seconds,args.output)
