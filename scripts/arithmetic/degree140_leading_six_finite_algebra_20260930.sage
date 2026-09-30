"""Describe the complete new degree-six leading exception algebra.

No assertion about an actual cover is inferred from membership in it.
This continues the short residue calculation, without rerunning it.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]); start=time.time()
d=load(str(root/'reciprocal_degree6_leading_locus.sobj'))
R=d['ring']; I=R.ideal(d['basis'])
assert I.dimension()==0
length=int(I.vector_space_dimension())
print('length',length,flush=True)
S=PolynomialRing(R.base_ring(),names=('H','q'),order='lex')
G=list(I.transformed_basis('fglm',S))
save({'ring':S,'basis':G,'original_basis':d['basis'],'length':length},
     str(root/'reciprocal_degree6_leading_lex'))
summary={'scope':'complete leading-coefficient exception algebra only',
         'length':length,'basis':[]}
for f in G:
    summary['basis'].append({'degrees':list(map(int,f.degrees())),
                             'terms':len(f.dict())})
print('lex shape',summary['basis'],flush=True)
H,q=S.gens(); Q=PolynomialRing(R.base_ring(),'q')
uni=[Q(f.subs({H:0})) for f in G if f.degree(H)==0]
if uni:
    assert len(uni)==1
    poly=uni[0]
    factors=list(poly.factor())
    summary['q_factor_degrees']=[(int(f.degree()),int(e)) for f,e in factors]
    summary['q_squarefree']=bool(poly.gcd(poly.derivative()).is_one())
    save({'ring':S,'basis':G,'q_polynomial':poly,'q_factors':factors},
         str(root/'reciprocal_degree6_leading_factors'))
    print('factor degrees',summary['q_factor_degrees'],flush=True)
summary['seconds']=time.time()-start
(root/'reciprocal_degree6_leading_finite_algebra.json').write_text(
    json.dumps(summary,indent=2)+'\n')
print(json.dumps(summary),flush=True)
