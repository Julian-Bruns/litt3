"""Expand the small invariant-center description into the exact55-row list.

The full local multiplicity8 is the audited census theorem's input here.
Coordinates and distinctness are checked in the original96 equations.
"""
import argparse,json,sys
from pathlib import Path
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out',required=True,type=Path)
parser.add_argument('--compare-existing',type=Path)
args=parser.parse_args()
root=Path(__file__).resolve().parents[3]
source=root/'scripts/atlases/opers/fixed_x_dormant_opers.sage'
oldargv=sys.argv;sys.argv=['fixed_x_dormant_opers.sage','--build-only']
ns=dict(globals());exec(compile(source.read_text(),str(source),'exec'),ns);sys.argv=oldargv
k=ns['k'];a=k.gen();P=ns['P'];equations=ns['coefficients']
data=json.loads((root/'Research/computations/invariant_oper_centers.json').read_text())
R=PolynomialRing(k,'b7');b7=R.gen()
decode=lambda h:R([k(c[0])+k(c[1])*a for c in h])
H=decode(data['modulus']);Bs=[decode(h) for h in data['coordinates']]
factors=[decode(h) for h in data['factors']]
assert H.degree()==55 and H.is_squarefree() and prod(factors)==H
assert all(h.is_irreducible() for h in factors) and Bs[7]==b7
export={'coordinate_order':list(P.variable_names()),'base_field':'F_5[a]/(a^2+4*a+2)',
    'extension_convention':'For each orbit use F25[u]/h(u), with h the listed polynomial in b7. Coordinates are reduced polynomials in u. Row j is the 25^j-Frobenius conjugate of row zero.',
    'orbits':[],'solutions':[]}
for orbit_id,h in enumerate(factors):
    d=int(h.degree())
    if d==1:K=k;u=-h[0]/h[1]
    else:K=R.quotient(h,names='u');u=K.gen()
    vals=[sum((K(c)*u**i for i,c in enumerate(f.list())),K.zero()) for f in Bs]+[K.zero()]*16
    initial=list(vals);seen=set()
    export['orbits'].append({'orbit_id':orbit_id,'degree':d,'factor':str(h),'multiplicity':8})
    for j in range(d):
        assert tuple(vals) not in seen;seen.add(tuple(vals))
        ev=P.hom(vals,K);assert all(ev(f)==0 for f in equations)
        export['solutions'].append({'orbit_id':orbit_id,'frobenius_exponent':j,
            'coordinates':[str(c) for c in vals],'multiplicity':8})
        vals=[c**25 for c in vals]
    assert vals==initial
assert len(export['solutions'])==55
export['verification']={'all_96_equations_each_row':True,'distinct_within_orbits':True,
    'distinct_between_orbits':'The six b7 minimal polynomials are pairwise coprime.',
    'distinct_solution_count':55,'sum_local_multiplicities':440}
if args.compare_existing:
    previous=json.loads(args.compare_existing.read_text())
    assert export==previous,'Expanded invariant list differs from retained original'
args.out.parent.mkdir(parents=True,exist_ok=True)
args.out.write_text(json.dumps(export,indent=2,default=int)+'\n')
print('PASS all55 rows and original equations; exported',args.out,flush=True)
