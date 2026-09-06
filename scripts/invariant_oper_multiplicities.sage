#!/usr/bin/env sage
"""Exact local lengths at deck-invariant dormant opers.

Translate the full ideal to each closed point, formally eliminate the 21
nonsingular directions, and compute exact Macaulay ranks modulo powers of
the maximal ideal in three variables. Consecutive equal lengths certify
stabilization by Nakayama. All calculations occur over exact residue fields.
"""
import sys, json, time
from pathlib import Path

args = list(sys.argv)
source = Path('scripts/fixed_x_dormant_opers.sage').read_text()
sys.argv = ['fixed_x_dormant_opers.sage', '--invariant', '--build-only']
exec(compile(source, 'fixed_x_dormant_opers.sage', 'exec'))
Lex = PolynomialRing(k, names=names, order='lex')
GL = Lex.ideal([Lex(f) for f in I.groebner_basis()]).groebner_basis()
uni = next(f for f in GL if f.variables()==(Lex.gen(7),))
fac = list(uni.univariate_polynomial().factor())
tri = {f.leading_monomial():f for f in GL if len(f.variables())>1}
sys.argv = ['fixed_x_dormant_opers.sage', '--build-only']
exec(compile(source, 'fixed_x_dormant_opers.sage', 'exec'))
outpath = Path('Research/computations/invariant_oper_multiplicities.json')
saved=json.loads(outpath.read_text()) if '--export-only' in args else None
export={'coordinate_order':list(P.variable_names()),'base_field':'F_5[a]/(a^2+4*a+2)',
        'extension_convention':'For each orbit use F25[u]/h(u), with h the listed polynomial in b7. Coordinates are reduced polynomials in u. Row j is the 25^j-Frobenius conjugate of row zero.',
        'orbits':[],'solutions':[]}
results = {'method':'Formal elimination of 21 nonsingular directions; exact truncated Macaulay ranks in three variables; consecutive equal lengths certify the full local length by Nakayama.',
           'field':'F_5[a]/(a^2+4*a+2); for degree >1, u is a root of the listed factor.',
           'full_equation_count':len(coefficients),'points':[]}
max_degree = 1 if '--rational-only' in args else 23
def truncated_length(shifted, Q, K):
    """Exact m-adic truncations after the formal implicit function theorem.

    If lengths mod m^N and m^(N+1) agree, m^N=m*m^N in the
    noetherian completed local algebra; Nakayama forces m^N=0.
    """
    J = matrix(K, [[f.monomial_coefficient(v) for v in Q.gens()] for f in shifted])
    cols = list(J.pivots())
    rows = list(J.matrix_from_columns(cols).transpose().pivots())
    free = [i for i in range(Q.ngens()) if i not in cols]
    assert len(free)==3 and len(cols)==21
    M = J.matrix_from_rows_and_columns(rows,cols)
    Minv = M.inverse()
    T = PolynomialRing(K, names=['t0','t1','t2'], order='degrevlex')
    terms = [[(K(c),tuple(int(j) for j in e)) for e,c in f.dict().items()] for f in shifted]
    previous = None
    lengths=[]
    for N in range(2,31):
        def trunc(f):
            return T({e:c for e,c in f.dict().items() if sum(e)<N})
        def evaluate(ts, values):
            ans=T.zero()
            for c,e in ts:
                term=T(c)
                for j,power in enumerate(e):
                    if power: term=trunc(term*values[j]**power)
                ans+=term
            return trunc(ans)
        values=[T.zero() for _ in Q.gens()]
        for j,i in enumerate(free): values[i]=T.gen(j)
        for iteration in range(N):
            residual=vector(T,[evaluate(terms[i],values) for i in rows])
            correction=Minv.change_ring(T)*residual
            for j,i in enumerate(cols): values[i]=trunc(values[i]-correction[j])
            if not any(correction): break
        assert not any(evaluate(terms[i],values) for i in rows)
        residuals=[evaluate(ts,values) for ts in terms]
        exponents=[(i,j,h) for i in range(N) for j in range(N-i) for h in range(N-i-j)]
        monomials=[prod(T.gen(j)**e[j] for j in range(3)) for e in exponents]
        macaulay=[]
        for f in residuals:
            if not f: continue
            order=min(sum(e) for e in f.dict())
            for e,m in zip(exponents,monomials):
                if sum(e)+order<N:
                    fm=trunc(m*f)
                    macaulay.append([fm.monomial_coefficient(mm) for mm in monomials])
        mac=matrix(K,macaulay,ncols=len(monomials))
        rank=int(mac.rank())
        length=len(monomials)-rank
        G=[]
        lengths.append({'truncation_power':N,'length':length,'ambient_dimension':len(monomials),'relation_rank':rank})
        print('TRUNCATION',N,length,flush=True)
        if length==previous:
            return length,G,{'truncations':lengths,'pivot_columns':cols,'pivot_rows':rows,
                'free_columns':free,'eliminated_coordinates_mod_mN':[str(v) for v in values],
                'residual_equations_mod_mN':[str(f) for f in residuals],
                'macaulay_rank':rank,'macaulay_columns':[str(m) for m in monomials],
                'certificate':'Consecutive exact truncated lengths agree. Nakayama applied to m^(N-1) in the completed local quotient gives m^(N-1)=0.'}
        previous=length
    raise RuntimeError('No stabilization through degree 30')

for factor, exponent in fac:
    d = factor.degree()
    if d>max_degree: continue
    if d == 1:
        K = k
        root = -factor[0]/factor[1]
    else:
        Z=PolynomialRing(GF(5),'z')
        h0=Z([c[0] for c in factor.list()])
        h1=Z([c[1] for c in factor.list()])
        norm=h0**2+h0*h1+2*h1**2
        assert norm.is_irreducible() and norm.degree()==2*d
        K=GF(5**(2*d),name='u',modulus=norm)
        root = K.gen()
        ak=-h0(root)/h1(root)
        assert ak**2+4*ak+2==0
        K.register_coercion(k.hom([ak],K))
    special = Lex.hom([K.zero()]*7+[root], K)
    vals = [-special(tri[Lex.gen(i)])/K(tri[Lex.gen(i)].monomial_coefficient(Lex.gen(i))) for i in range(7)] + [root]
    Q = PolynomialRing(K, names=P.variable_names(), order='negdegrevlex')
    shift = P.hom([Q.gen(i)+Q(vals[i]) for i in range(8)]+list(Q.gens()[8:]), Q)
    shifted = [shift(f) for f in coefficients]
    print('START residue degree', d, 'factor', factor, flush=True)
    t = time.monotonic()
    if '--export-only' in args:
        length=next(r['local_length'] for r in saved['points'] if r['factor']==str(factor))
        G=[]
        certificate={}
    else:
        length,G,certificate=truncated_length(shifted,Q,K)
    row = {'residue_degree':int(d),'factor':str(factor), 'b_values':[str(t) for t in vals],
           'local_length':int(length), 'standard_basis':[str(f) for f in G],
           'leading_monomials':[str(f.lm()) for f in G], 'seconds':time.monotonic()-t,
           **certificate}
    results['points'].append(row)
    print('DONE', d, length, row['seconds'], flush=True)
    # Artifact serialization is an output of the exact computation.
    if '--export-only' not in args:
        outpath.write_text(json.dumps(results, indent=2)+'\n')
    if '--export-only' in args:
        orbit_id=len(export['orbits'])
        export['orbits'].append({'orbit_id':orbit_id,'degree':int(d),'factor':str(factor),'multiplicity':int(length)})
        if d>1:
            relative=factor.parent().quotient(factor,names='u')
            ru=relative.gen()
            def show(c):
                result=relative(sum(relative(ci)*ru**i for i,ci in enumerate(c.polynomial().list())))
                assert sum(K(ci)*root**i for i,ci in enumerate(result.lift().list()))==c
                return str(result)
        else:
            def show(c): return str(c)
        seen=set()
        conjugates=list(vals)+[K.zero()]*16
        for j in range(d):
            assert tuple(conjugates) not in seen
            seen.add(tuple(conjugates))
            ev=P.hom(conjugates,K)
            assert all(ev(f)==0 for f in coefficients)
            assert sum(K(factor[i])*conjugates[7]**i for i in range(d+1))==0
            export['solutions'].append({'orbit_id':orbit_id,'frobenius_exponent':int(j),
                'coordinates':[show(c) for c in conjugates],'multiplicity':int(length)})
            conjugates=[c**25 for c in conjugates]
        assert conjugates==list(vals)+[K.zero()]*16
if '--export-only' in args:
    assert sum(f.degree() for f,e in fac)==55
    assert all(fac[i][0].gcd(fac[j][0])==1 for i in range(len(fac)) for j in range(i))
    assert len(export['solutions'])==55
    export['verification']={'all_96_equations_each_row':True,'distinct_within_orbits':True,
        'distinct_between_orbits':'The six b7 minimal polynomials are pairwise coprime.',
        'distinct_solution_count':int(55),'sum_local_multiplicities':int(sum(r['multiplicity'] for r in export['solutions']))}
    Path('Research/computations/invariant_oper_solutions.json').write_text(json.dumps(export,indent=2)+'\n')
    print('EXPORTED AND VERIFIED 55 solutions',flush=True)
