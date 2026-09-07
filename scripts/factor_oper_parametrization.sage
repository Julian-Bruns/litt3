"""Factor the certified normalized univariate algebra; retain all powers."""
import json,time
from pathlib import Path
source=Path('Research/computations/normalized_oper_algebra_certificate.json')
data=json.loads(source.read_text())
assert data['status']=='CERTIFIED_normalized_algebra_with_full_multiplicities'
R=PolynomialRing(GF(5),'z',implementation='FLINT');z=R.gen();P=R(data['P'])
assert P.degree()==19290 and P.gcd(P.derivative())==1
print('factoring squarefree P of degree19290 overF5',flush=True)
started=time.monotonic()
factors=list(P.factor())
assert prod(f**e for f,e in factors)==P
out=[]
for i,(f,e) in enumerate(sorted(factors,key=lambda pair:(pair[0].degree(),tuple(int(c) for c in pair[0].list())))):
    assert f.is_irreducible() and f.degree()%2==0 and e==1
    out.append({'id':f'orbit_{i:04d}','degree_F5':int(f.degree()),'degree_F25':int(f.degree()//2),
        'multiplicity':int(e),'polynomial':[int(c) for c in f.list()]})
assert sum(row['degree_F25']*row['multiplicity'] for row in out)==9645
result={'status':'certified_factorization_with_F25_embedding_given_by_zeta_coordinate',
    'source_certificate':str(source),'elapsed_seconds':time.monotonic()-started,
    'normalized_distinct_geometric_points':9645,'normalized_length':9645,
    'factors':out}
destination=Path('Research/computations/normalized_oper_closed_points.json')
destination.write_text(json.dumps(result,separators=(',',':'),default=int)+'\n')
print('factor degrees overF25:',[(row['degree_F25'],row['multiplicity']) for row in out],flush=True)
print('Saved',destination,flush=True)
