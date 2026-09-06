#!/usr/bin/env sage
"""Exact c4=0 local lengths from certified full local presentations."""
import sys,json,time
from pathlib import Path
sys.argv=['fixed_x_dormant_opers.sage','--build-only']
exec(compile(Path('scripts/fixed_x_dormant_opers.sage').read_text(),'fixed_x_dormant_opers.sage','exec'))
top=eqs[2].leading_coefficient()
target=P.gen(23)-P.gen(12)**2
unit=top.monomial_coefficient(P.gen(23))
assert unit and top==unit*target
print('TOP IDENTITY:',eqs[2].degree(),top,flush=True)
saved=json.loads(Path('Research/computations/invariant_oper_multiplicities.json').read_text())
answer={'ideal':'I+(c4), I the full 96 dormant-oper quadrics',
        'method':'Reuse certified full local presentations modulo m^5 with m^4=0; adjoin the formal c4 expression and take exact Macaulay ranks.',
        'top_third_equation':{'x_degree':int(eqs[2].degree()),'coefficient':str(top),'unit':str(unit),'normalized_identity':'a10-c4^2=0'},
        'points':[]}
H=PolynomialRing(k,'b7')
for row in saved['points']:
    started=time.monotonic()
    d=row['residue_degree']
    factor=H(row['factor'])
    if d==1:
        K=k
        root=-factor[0]/factor[1]
        ak=a
    else:
        Z=PolynomialRing(GF(5),'z')
        h0=Z([c[0] for c in factor.list()])
        h1=Z([c[1] for c in factor.list()])
        norm=h0**2+h0*h1+2*h1**2
        assert norm.is_irreducible()
        K=GF(5**(2*d),name='u',modulus=norm)
        root=K.gen()
        ak=-h0(root)/h1(root)
        K.register_coercion(k.hom([ak],K))
    T=PolynomialRing(K,names=['t0','t1','t2'],order='degrevlex')
    loc={'a':ak,'u':root,**dict(zip(T.variable_names(),T.gens()))}
    parse=lambda s:T(sage_eval(s,locals=loc))
    c4=parse(row['eliminated_coordinates_mod_mN'][12])
    residuals=[parse(s) for s in row['residual_equations_mod_mN']]+[c4]
    assert row['truncations'][-2]['truncation_power']==4 and row['truncations'][-1]['truncation_power']==5
    assert row['truncations'][-2]['length']==row['truncations'][-1]['length']==8
    assert c4.constant_coefficient()==0 and all(c4.monomial_coefficient(t)==0 for t in T.gens())
    checks=[]
    for N in [4,5]:
        exponents=[(i,j,h) for i in range(N) for j in range(N-i) for h in range(N-i-j)]
        monomials=[prod(T.gen(j)**e[j] for j in range(3)) for e in exponents]
        macaulay=[]
        for f in residuals:
            f=T({e:c for e,c in f.dict().items() if sum(e)<N})
            if not f: continue
            order=min(sum(e) for e in f.dict())
            for e,m in zip(exponents,monomials):
                if sum(e)+order<N:
                    fm=m*f
                    macaulay.append([fm.monomial_coefficient(mm) for mm in monomials])
        mac=matrix(K,macaulay,ncols=len(monomials))
        rank=int(mac.rank())
        checks.append({'power':int(N),'ambient_dimension':len(monomials),'rank':rank,'length':len(monomials)-rank})
    assert checks[0]['length']==checks[1]['length']
    local_length=checks[-1]['length']
    answer['points'].append({'residue_degree':d,'factor':str(factor),'local_length':local_length,
        'jacobian_rank':int(21),'c4_mod_m5':str(c4),'rank_checks':checks,
        'full_certificate':'invariant_oper_multiplicities.json, corresponding factor row'})
    print('SLICE',d,local_length,'seconds',time.monotonic()-started,flush=True)
answer['total_invariant_contribution']=int(sum(r['residue_degree']*r['local_length'] for r in answer['points']))
Path('Research/computations/invariant_oper_c4_slice.json').write_text(json.dumps(answer,indent=2)+'\n')
print('TOTAL INVARIANT CONTRIBUTION',answer['total_invariant_contribution'],flush=True)
