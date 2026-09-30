#!/usr/bin/env sage-python
"""Interpolate and test a candidate exceptional D10 fourth-obstruction polynomial.

This produces candidates for direct geometric verification. Finite evaluation
checks do not certify a global support bound.
"""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, vector, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--base',required=True)
    ap.add_argument('--samples',required=True)
    ap.add_argument('--model',required=True)
    ap.add_argument('--output',required=True)
    ap.add_argument('--separate-frobenius',action='store_true')
    ap.add_argument('--positive-only',action='store_true',help='Search just the two hyperelliptic-preserving directions.')
    args=ap.parse_args()
    samples=Path(args.samples)
    model=json.loads(Path(args.model).read_text())
    f=PolynomialRing(GF(5),'t')
    k=GF(625,'t',modulus=f(model['field_modulus']))
    R=PolynomialRing(k,['y0','y1','y2','y3'],order='degrevlex');y=R.gens()
    enc=lambda a:[int(a.polynomial()[i]) for i in range(4)]
    baseline=json.loads(Path(args.base).read_text())
    assert baseline['status'].startswith('PASS complete')
    const=vector(k,[k(c) for c in baseline['c4']])
    def read(label):
        rec=json.loads((samples/label/'receipt.json').read_text())
        assert rec['status']=='PASS'
        for n,h in rec['outputs'].items():
            assert hashlib.sha256((samples/label/n).read_bytes()).hexdigest()==h
        return rec,vector(k,[k(c) for c in rec['c4']])
    E=vector(R,const)
    quadratic=vector(R,[0]*4)
    lin=[];sq=[]
    for i in range(4):
        _,plus=read(f'e{i}_1');_,minus=read(f'e{i}_4')
        li=(plus-minus)/k(2);qu=(plus+minus-2*const)/k(2)
        lin.append(li);sq.append(qu)
        E+=vector(R,li)*y[i]+vector(R,qu)*y[i]**2
        quadratic+=vector(R,qu)*y[i]**2
    for i in range(4):
        for j in range(i+1,4):
            _,v=read(f'e{i}_e{j}')
            mixed=v-const-lin[i]-lin[j]-sq[i]-sq[j]
            E+=vector(R,mixed)*y[i]*y[j]
            quadratic+=vector(R,mixed)*y[i]*y[j]
    frobenius_checks=[]
    if args.separate_frobenius:
        ordinary=[];fifth=[];tau=k.gen()
        for i in range(4):
            _,p=read(f'e{i}_tau_1');_,m=read(f'e{i}_tau_4')
            odd=(p-m)/k(2)
            ordinary.append((odd-tau*lin[i])/(tau**125-tau))
            fifth.append(lin[i]-ordinary[-1])
            frobenius_checks.append(bool((p+m-2*const)/k(2)==tau**2*sq[i]))
        E=vector(R,const)+vector(R,[e(*[z**5 for z in y]) for e in quadratic])
        for i in range(4):
            E+=vector(R,ordinary[i])*y[i]+vector(R,fifth[i])*y[i]**5
    extra=[]
    for label in ['field_check_1','field_check_2']:
        rec,actual=read(label)
        point=[k(c) for c in rec['fingerprint']['parameters']]
        if args.separate_frobenius:point=[c**125 for c in point]
        predicted=vector(k,[e(*point) for e in E])
        extra.append(dict(label=label,match=actual==predicted,
                          actual=[enc(c) for c in actual],predicted=[enc(c) for c in predicted]))
    I=R.ideal(list(E));dim=int(I.dimension())
    print('Candidate dimension',dim,'extra checks',[r['match'] for r in extra],
          'quadratic Frobenius checks',frobenius_checks,flush=True)
    points=[]
    if dim==0 and not args.positive_only:
        for p in I.variety(ring=k):
            pt=[p[z] for z in y]
            points.append(dict(parameters=[enc(c**5 if args.separate_frobenius else c) for c in pt],
                               candidate_jacobian_rank=int(matrix(k,[[e.derivative(z)(*pt) for z in y] for e in E]).rank())))
    positive=R.ideal(list(E)+[y[2],y[3]])
    pd=int(positive.dimension())
    if pd==0:
        for p in positive.variety(ring=k):
            pt=[p[z] for z in y]
            record=dict(parameters=[enc(c**5 if args.separate_frobenius else c) for c in pt],
                        candidate_jacobian_rank=int(matrix(k,[[e.derivative(z)(*pt) for z in y] for e in E]).rank()))
            if record not in points:points.append(record)
    encode_poly=lambda p:[dict(exponents=[int(i) for i in ex],coefficient=enc(c)) for ex,c in sorted(p.dict().items())]
    result=dict(status='EXPLORATORY candidate; support and actual zeros require further proof',
                dimension=dim,positive_dimension=pd,extra_checks=extra,
                coordinate_convention='actual x; sample parameters y=x^5' if args.separate_frobenius else 'fifth-power y',
                searched_only_positive=args.positive_only,
                quadratic_frobenius_checks=frobenius_checks,
                polynomials=[encode_poly(e) for e in E],
                groebner_basis=[encode_poly(e) for e in I.groebner_basis()],
                candidate_rational_points=points)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print('Candidates overF625',len(points),flush=True)
    print(json.dumps(points,indent=2))


if __name__=='__main__':main()
