"""One-dimensional exact resultant decision for the cubic exception."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_cubic_exception_inputs.sobj'))
K=d['ring'].base_ring();P=PolynomialRing(K,'q');q=P.gen()
R=PolynomialRing(K,['mu','q'],order='degrevlex');mu,qq=R.gens()
sp=d['ring'].hom([mu,qq,0],R);eq=[sp(f) for f in d['equations']]
chart=P(-sp(d['localizer']+1).subs(mu=1)) if False else None
base=load(str(root/'inverse_eta_global_rational_coefficients.sobj'))
hh=d['H'];ps=P(base['Psi'](hh,q));a0=P(base['a0'](hh,q))
alpha=K.gen();beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    z=K.zero()
    for i in range(4):
        c=n%25;n//=25;z+=(K(c%5)+(c//5)*beta)*alpha^i
    return z
chart=q*ps*a0*(q-1)*(q-dec(15383))
def strip(f):
    f=P(f)
    if not f:return f
    while True:
        g=gcd(f,chart)
        if g.degree()<=0:return f.monic()
        f=f//g
reduced=[]
for j,f in enumerate(eq):
    coeffs=[P(f.monomial_coefficient(mu^i)) for i in range(int(f.degree(mu))+1)] if False else [P(f.polynomial(mu)[i]) for i in range(int(f.degree(mu))+1)]
    content=gcd(coeffs);print('content',j,'degree',content.degree(),flush=True)
    # Only chart-supported coefficient content is a harmless unit.
    unit=content//strip(content)
    reduced.append(f//R(unit))
eq=reduced;results=[];g=None
for j in [1,2]:
    r=P(eq[0].resultant(eq[j],mu));r=strip(r)
    results.append(r);g=r if g is None else gcd(g,r)
    print('resultant',j,'remaining degree',r.degree(),'common',g.degree(),'seconds',time.time()-start,flush=True)
    save({'ring':R,'H':hh,'equations':eq,'chart':chart,'resultants':results,'gcd':g},str(root/'inverse_eta_cubic_exception_resultants_partial'))
assert g is not None
gg=g.monic();bez=results[0].xgcd(results[1]);assert bez[0]==gg
save({'ring':R,'H':hh,'equations':eq,'chart':chart,'resultants':results,'gcd':gg,'bezout':bez},str(root/'inverse_eta_cubic_exception_resultants'))
report={'scope':'entire cubic-leading exception line; necessary resultant projection',
        'empty':bool(gg.degree()==0),'residual_q_degree':int(gg.degree()),
        'resultant_degrees':[int(r.degree()) for r in results],'seconds':time.time()-start}
(root/'inverse_eta_cubic_exception_resultants.json').write_text(json.dumps(report,indent=2)+'\n')
print(report,flush=True)
