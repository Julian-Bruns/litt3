#!/usr/bin/env python3
"""Normalize an ACTUAL quartic Prym carrier into a small Newton model.

Only the coprime, squarefree degree-two Q chart is used here. Every
division and change of variable is checked. The polygon/edge diagnostics
are recorded separately; no Jacobian-factor verdict is inferred.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,Polyhedron,matrix,gcd,ZZ
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from fixed_x_monomial_jacobian import FixedXMonomialJacobian
from construct_fixed_x_two_torsion import recover_norm
from sieve_fixed_x_carriers import load_json,save_json


def newton_diagnostics(poly):
    points=[tuple(map(int,e)) for e in poly.dict()]
    polygon=Polyhedron(vertices=points,base_ring=ZZ)
    interior=[tuple(map(int,p)) for p in polygon.integral_points() if polygon.interior_contains(p)]
    edges=[];k=poly.base_ring();R=PolynomialRing(k,'v');v=R.gen()
    for face in polygon.faces(1):
        ends=[tuple(map(int,z)) for z in face.vertices()];a,b=ends
        step0=b[0]-a[0];step1=b[1]-a[1];length=int(gcd(abs(step0),abs(step1)))
        step=(step0//length,step1//length)
        coeffs=[poly.monomial_coefficient(poly.parent().monomial(*
                    (a[0]+j*step[0],a[1]+j*step[1]))) for j in range(length+1)]
        f=R(coeffs);assert f[0] and f[length]
        good=f.gcd(f.derivative()).degree()==0
        edges.append(dict(start=a,end=b,lattice_length=length,squarefree_in_torus=bool(good)))
    return dict(vertices=[list(map(int,z)) for z in polygon.vertices()],
                interior_points=interior,interior_count=len(interior),edges=edges,
                all_edges_transverse=all(e['squarefree_in_torus'] for e in edges))


def toric_model(P,Q,R):
    k=P.base_ring();x=P.parent().gen()
    assert Q.degree()==2 and Q.is_squarefree() and P.gcd(Q).degree()==0
    p=(R*P.inverse_mod(Q))%Q
    aa,ra=(p*p-P).quo_rem(Q)
    bb,rb=(p**3+2*P*p+2*R).quo_rem(Q**2)
    cc,rc=(p**4+4*P*p*p-2*R*p+2*P*P).quo_rem(Q**3)
    assert not ra and not rb and not rc
    S=PolynomialRing(k,['x','z']);xx,z=S.gens()
    embed=lambda f:S({(i,0):c for i,c in f.dict().items()})
    raw=embed(Q)*z**4+embed(p)*z**3+embed(aa)*z*z+embed(bb)*z+embed(cc)
    Z=embed(Q)*z-embed(p)
    assert Z**4+4*embed(P)*Z**2+2*embed(R)*Z+2*embed(P)**2==embed(Q)**3*raw
    shift=k.zero()
    if P.degree()==6:
        kk=R.leading_coefficient()/P.leading_coefficient()
        assert kk*kk==P.leading_coefficient() and kk**3==R.leading_coefficient()
        shift=kk/Q.leading_coefficient();answer=raw(z=z-shift*xx)
    else:answer=raw
    return answer,p,shift


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('field_source',type=Path)
    p.add_argument('matrix',type=Path);p.add_argument('out',type=Path)
    p.add_argument('--seconds',type=int,default=300)
    args=p.parse_args();args.out.mkdir(exist_ok=False);start=time.monotonic()
    def report(stage,**kw):print(json.dumps(dict(stage=stage,seconds=time.monotonic()-start,**kw)),flush=True)
    alarm(args.seconds)
    try:
        data=load_json(args.field_source);d=data['field_degree']
        k=GF(5**d,'b',modulus=PolynomialRing(GF(5),'v')(data['modulus']),impl='pari_ffelt')
        J=FixedXMonomialJacobian(k,k(data['a']));wd=load_json(args.matrix)
        w=matrix(k,wd['rows'],wd['columns'],[k(c) for c in wd['coefficients']])
        norm=recover_norm(J,w);save_json(args.out/'norm.json.gz',norm)
        decode=lambda coeffs:J.f.parent()([k(c) for c in coeffs])
        P,Q,R=map(decode,[norm['P'],norm['Q'],norm['R']])
        assert P**3+J.f*Q**3==R**2
        report('actual_norm_recovered',degrees=norm['degrees'])
        f,pp,shift=toric_model(P,Q,R);diag=newton_diagnostics(f)
        encode=lambda c:list(map(int,c.polynomial().list()))
        save_json(args.out/'model.json.gz',dict(field_degree=d,modulus=data['modulus'],
            field_source=str(args.field_source.resolve()),matrix_source=str(args.matrix.resolve()),
            variables=['x','z'],coefficients=[[list(e),encode(c)] for e,c in sorted(f.dict().items())],
            finite_shift=[encode(c) for c in pp],infinity_shift=encode(shift),
            exact_birational_substitution=True,diagnostics=diag))
        save_json(args.out/'diagnostics.json',dict(status='complete',terms=len(f.dict()),
            degrees=norm['degrees'],seconds=time.monotonic()-start,**diag,
            scope='Actual birational carrier; nondegeneracy must use genus plus edge argument'))
        report('actual_newton_model',terms=len(f.dict()),diagnostics=diag)
    except AlarmInterrupt:report('time_limit_no_verdict')
    finally:cancel_alarm()


if __name__=='__main__':main()
