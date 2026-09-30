"""Decide the one leading-cubic exception using the new global traces.
This is geometric elimination on the full q-line, not a point scan.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_global_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(K(c%5)+(c//5)*beta)*alpha^i
    return out
hh=-dec(156117)/dec(363030)
P=PolynomialRing(K,'q');qq=P.gen();sp=R.hom([hh,qq],P)
S=PolynomialRing(K,['mu','q','s'],order='degrevlex');mu,q1,s=S.gens();inc=P.hom([q1],S)
ps=sp(d['Psi']);a0=sp(d['a0']);equations=[]
for j in range(3):
    cs=[c for c in d['coefficients'] if c[0]==j]
    dq=max(c[3][1] for c in cs);dp=max(c[3][2] for c in cs)
    p=sum(inc(sp(N)*qq^(dq-aq)*ps^(dp-ap)/hh^ah)*mu^n for _,n,N,(ah,aq,ap) in cs)
    # Remove coefficient content supported on the already inverted chart.
    cc=[P(c) for c in p.polynomial(mu).coefficients()]
    equations.append(p)
    print('equation',j,'terms',len(p.dict()),'degrees',[p.degree(v) for v in S.gens()],flush=True)
localizer=s*mu*q1*inc(ps*a0)*(q1-1)*(q1-dec(15383))-1
save({'ring':S,'H':hh,'equations':equations,'localizer':localizer},str(root/'inverse_eta_cubic_exception_inputs'))
I=S.ideal(equations+[localizer]);G=list(I.groebner_basis(algorithm='libsingular:slimgb'))
save({'ring':S,'H':hh,'equations':equations,'localizer':localizer,'basis':G},str(root/'inverse_eta_cubic_exception'))
report={'scope':'entire geometric cubic-leading exception line','empty':G==[S.one()],
        'basis_size':len(G),'seconds':time.time()-start}
(root/'inverse_eta_cubic_exception.json').write_text(json.dumps(report,indent=2)+'\n')
print(report,flush=True)
