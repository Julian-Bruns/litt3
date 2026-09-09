"""Fast certificate verification, not a replay of the oper search.

Global length29375 is a mathematical input (fixed_x_dormant_equations).
Construct28935 distinct non-invariant points and length>=8 quotients at
55 distinct invariant points. Their lengths exhaust29375; no exceptional
slice Groebner basis or formal elimination search is needed.
"""
import argparse,hashlib,json,os,subprocess,sys,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--out',required=True);args=ap.parse_args()
out=Path(args.out).resolve();out.mkdir(parents=True,exist_ok=False)
root=Path(__file__).resolve().parents[1];base=root/'Research/computations'
started=time.monotonic()
def log(*s):print(round(time.monotonic()-started,2),*s,flush=True)
env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
subprocess.run(['sage',str(root/'scripts/certify_oper_parametrization.sage'),
    str(base/'normalized_oper_a9_parametrization.json'),'--output',str(out/'normalized.json')],
    check=True,env=env)
normalized=json.loads((out/'normalized.json').read_text())
R=PolynomialRing(GF(5),'z',implementation='FLINT');z=R.gen();mod=R(normalized['P'])
assert mod.degree()==19290 and mod.gcd(mod.derivative())==1
assert R(normalized['lambda']).gcd(mod)==1
closed=json.loads((base/'normalized_oper_closed_points.json').read_text())['factors']
factors=[R(row['polynomial']) for row in closed]
assert prod(factors)==mod and all(h.is_irreducible() for h in factors)
assert all(h.degree()==2*row['degree_F25'] and row['multiplicity']==1 for h,row in zip(factors,closed))
log('non-invariant algebra, squarefreeness, all12 factors and invertible cubic scale PASS')

# Regenerate the96 original equations; no stored large basis is read.
oldargv=sys.argv;sys.argv=['fixed_x_dormant_opers.sage','--build-only']
ns=dict(globals());exec(compile((root/'scripts/fixed_x_dormant_opers.sage').read_text(),
    'fixed_x_dormant_opers.sage','exec'),ns);sys.argv=oldargv
k=ns['k'];a=k.gen();P=ns['P'];equations=ns['coefficients'];assert len(equations)==96
data=json.loads((base/'invariant_oper_multiplicities.json').read_text())
records=[];oldfactors=[]
T0=PolynomialRing(k,'b7');b7=T0.gen()
for row in data['points']:
    h=T0(sage_eval(row['factor'],locals={'a':a,'b7':b7}));d=int(h.degree())
    assert h.is_irreducible();oldfactors.append(h)
    if d==1:
        K=k;ak=a;uk=None
    else:
        h0=R([c[0] for c in h.list()]);h1=R([c[1] for c in h.list()])
        norm=h0**2+h0*h1+2*h1**2
        assert norm.degree()==2*d and norm.is_irreducible()
        K=GF(5**(2*d),'u',modulus=norm);uk=K.gen();ak=-h0(uk)/h1(uk)
        assert ak**2+4*ak+2==0
    emb=k.hom([ak],K)
    T=PolynomialRing(K,names=['t0','t1','t2']);tt=T.gens()
    loc=dict(a=ak,t0=tt[0],t1=tt[1],t2=tt[2])
    if uk is not None:loc['u']=uk
    trunc=lambda f:T({e:c for e,c in T(f).dict().items() if sum(e)<4})
    phi=[trunc(sage_eval(s,locals=loc)) for s in row['eliminated_coordinates_mod_mN']]
    assert len(phi)==24 and all(f.constant_coefficient()==0 for f in phi)
    assert [phi[i] for i in row['free_columns']]==list(tt)
    vals=[K(sage_eval(s,locals=loc)) for s in row['b_values']]+[K.zero()]*16
    assert sum(emb(c)*vals[7]**i for i,c in enumerate(h.list()))==0
    values=[T(c)+f for c,f in zip(vals,phi)]
    terms=[[(tuple(e),emb(c)) for e,c in f.dict().items()] for f in equations]
    monomial_values={}
    for eq in terms:
        for e,c in eq:
            if e not in monomial_values:
                v=T.one()
                for i,n in enumerate(e):
                    if n:v=trunc(v*values[i]**n)
                monomial_values[e]=v
    residuals=[sum((c*monomial_values[e] for e,c in eq),T.zero()) for eq in terms]
    assert all(f.constant_coefficient()==0 for f in residuals)
    exps=[(i,j,l) for i in range(4) for j in range(4-i) for l in range(4-i-j)]
    mons=[tt[0]**i*tt[1]**j*tt[2]**l for i,j,l in exps]
    multiples=[]
    for f in residuals:
        if not f:continue
        order=min(sum(e) for e in f.dict())
        for e,m in zip(exps,mons):
            if sum(e)+order<4:
                fm=trunc(m*f);multiples.append([fm.monomial_coefficient(n) for n in mons])
    mat=matrix(K,multiples,ncols=20);rank=mat.rank();assert rank==12
    records.append(dict(residue_degree=d,quotient_dimension=20-int(rank),
        all96_original_relations_used=True,surjective_via_free_coordinates=True))
    log('local length >=8 certificate PASS, residue degree',d)
assert sum(h.degree() for h in oldfactors)==55
assert all(oldfactors[i].gcd(oldfactors[j])==1 for i in range(6) for j in range(i))
assert 3*19290//2+8*55==29375
report=dict(status='PASS_given_global_oper_length_theorem',global_length_input=29375,
    noninvariant_distinct_points=28935,invariant_distinct_points=55,
    invariant_lower_length=8,total_lower_length=29375,distinct_points=28990,
    consequence='Lengths exhausted: no other points; noninvariant multiplicity1 and invariant multiplicity8.',
    source_hashes={name:hashlib.sha256((base/name).read_bytes()).hexdigest() for name in
        ['normalized_oper_a9_parametrization.json','normalized_oper_closed_points.json','invariant_oper_multiplicities.json']},
    invariant_checks=records,normalized_residue_degrees=[r['degree_F25'] for r in closed],
    elapsed_seconds=time.monotonic()-started,
    scope='Rank-two census only, not atlas exclusion, common-cover solution, or Lean verification.')
(out/'verification.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
log('COMPLETE census certificate PASS; multiplicities preserved; no discovery rerun')
