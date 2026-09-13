#!/usr/bin/env python3
"""Higher-digit actual toric Prym unit roots, checked against prior precision."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,time,hashlib
from pathlib import Path
from sage.all import GF,ZZ,Zq,PolynomialRing,matrix
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.arithmetic.sieve_fixed_x_carriers import load_json,save_json
from scripts.arithmetic.toric_prym_unit_roots import (WittFrobenius,WITT_FROBENIUS,positive_norm,
    frob_matrix,inverse_unit_matrix,verify_kummer_twist)
from scripts.arithmetic.toric_ghost_coefficients import GhostCoefficients

p=argparse.ArgumentParser(description=__doc__);p.add_argument('model',type=Path)
p.add_argument('cartier_result',type=Path);p.add_argument('previous',type=Path)
p.add_argument('out',type=Path);p.add_argument('--seconds',type=int,default=600)
p.add_argument('--digits',type=int,default=3,choices=range(3,7))
args=p.parse_args();args.out.mkdir(exist_ok=True);start=time.monotonic();events=[]
def report(stage,**kw):
    event=dict(stage=stage,seconds=time.monotonic()-start,**kw);events.append(event)
    print(__import__('json').dumps(event),flush=True);save_json(args.out/'progress.json',events)
alarm(args.seconds)
try:
    data=load_json(args.model);d=data['field_degree'];diag=data['diagnostics']
    assert data['exact_birational_substitution'] and diag['interior_count']==8 and diag['all_edges_transverse']
    digits=args.digits
    previous=load_json(args.previous);assert previous['digits']==digits-1 and previous['field_degree']==d
    assert previous['model_sha256']==hashlib.sha256(args.model.read_bytes()).hexdigest()
    k=GF(5**d,'b',modulus=PolynomialRing(GF(5),'v')(data['modulus']),impl='pari_ffelt')
    O=Zq(5**d,prec=digits,type='fixed-mod',names='b',
         modulus=PolynomialRing(ZZ,'v')(data['modulus']),implementation='FLINT')
    phi=WittFrobenius(O,data['modulus'],digits,d);WITT_FROBENIUS[O]=phi
    f={tuple(e):O(c) for e,c in data['coefficients']};points=[tuple(v) for v in diag['interior_points']]
    engine=GhostCoefficients(f,O,phi,digits,report)
    matrices=[]
    levels=[5**(digits-1),5**digits]
    for m in levels:
        rows=[]
        for u in points:
            rows.append([engine.coefficient(m-1,(m*v[0]-u[0],m*v[1]-u[1]),digits) for v in points])
            report('requested_beta_row',power=m,row=len(rows))
        matrices.append(matrix(O,rows))
    U=matrices[1]*inverse_unit_matrix(frob_matrix(matrices[0],1))
    encode=lambda c:list(map(int,c._flint_rep().list()))
    save_json(args.out/'matrices.json.gz',dict(digits=digits,field_modulus=data['modulus'],dimension=8,
        beta_levels=levels,beta_previous=[encode(c) for c in matrices[0].list()],
        beta_current=[encode(c) for c in matrices[1].list()],
        unit_matrix=[encode(c) for c in U.list()],statistics=engine.statistics()))
    N=positive_norm(U,d);poly=N.charpoly('T');assert all(phi(c)==c for c in poly)
    coefficients=[]
    for c in poly:
        a=encode(c);assert all(v==0 for v in a[1:]);coefficients.append(a[0] if a else 0)
    assert [c%(5**(digits-1)) for c in coefficients]==previous['coefficients']
    result=dict(status='complete',digits=digits,field_degree=d,coefficients=coefficients,
        model=str(args.model.resolve()),model_sha256=previous['model_sha256'],
        verified_quadratic_twist=previous['verified_quadratic_twist'],
        actual_cartier_mod5_match=True,independent_previous_precision_match=True,
        seconds=time.monotonic()-start,scope='Actual carrier unit-root characteristic polynomial modulo'+str(5**digits))
    save_json(args.out/'result.json',result);report('higher_digit_unit_root_polynomial',digits=digits,coefficients=coefficients)
except AlarmInterrupt:report('time_limit_no_higher_precision_verdict')
finally:cancel_alarm()
