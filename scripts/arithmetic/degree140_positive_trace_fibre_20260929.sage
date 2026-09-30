"""Geometric (H,mu)-fibre elimination of the new global trace tests."""
import json,sys,time
from pathlib import Path
root=Path(sys.argv[1]); code=Integer(sys.argv[2]);start=time.time()
d=load(str(root/'global_positive_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def decode(n):
    s=K.zero();n=Integer(n)
    for i in range(4):
        c=n%25;n//=25;s+=(K(c%5)+(c//5)*beta)*a^i
    return s
q0=decode(code);Rh=PolynomialRing(K,'h');h=Rh.gen();sp=R.hom([h,q0],Rh)
ps=sp(d['Psi']);a0=sp(d['a0']);assert q0 and q0!=1 and q0!=decode(15383) and a0
S=PolynomialRing(K,['mu','h','s'],order='degrevlex');mu,hh,ss=S.gens();ih=Rh.hom([hh],S)
equations=[]
for j in range(3):
    cs=[c for c in d['coefficients'] if c[0]==j];dh=max(c[3][0] for c in cs);dp=max(c[3][2] for c in cs);p=S.zero()
    for _,n,N,(ah,aq,ap) in cs:
        p+=ih(sp(N)*h^(dh-ah)*ps^(dp-ap)/q0^aq)*mu^n
    equations.append(p)
    print('equation',j,'terms',len(p.dict()),'degrees',[p.degree(v) for v in S.gens()],flush=True)
localizer=ss*hh*mu*ih(ps)-1
I=S.ideal(equations+[localizer]);print('starting saturated fibre basis',code,'elapsed',time.time()-start,flush=True)
gb=I.groebner_basis(algorithm='libsingular:slimgb')
save({'q_code':code,'ideal_generators':equations+[localizer],'groebner_basis':gb},str(root/('positive_fibre_'+str(code))))
result={'q_code':int(code),'status':'empty' if len(gb)==1 and gb[0]==1 else 'nonempty_trace_locus','basis_size':len(gb),'seconds':time.time()-start}
(root/('positive_fibre_'+str(code)+'.json')).write_text(json.dumps(result)+'\n');print(result,flush=True)
