"""Build the fixed nine-sheet content norm from the new jet factor.

Work polynomially after multiplying each source coefficient by w^5.
Only three length-three local jets and three cubic norms are needed.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
old=load(str(root/'trace_leading_bezout.sobj'))
K=old['target'].parent().base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(K(c%5)+(c//5)*beta)*alpha^i
    return out
X=PolynomialRing(K,'x');x=X.gen()
P=X([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
Q=X([dec(c) for c in [0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]])
AA=X([dec(c) for c in [1,21,14,22,13]])
L0=X([dec(c) for c in [18,20,20,15]])
tx=AA//(x-alpha)/dec(13)
U0,remainder=(Q-L0^5).quo_rem(tx^3);assert not remainder
R=PolynomialRing(K,names=('H','w'));H,w=R.gens()
YY=PolynomialRing(R,'Y');Y=YY.gen()
it=iter((root/'family.txt').read_text().split());families=[]
for k in range(4):
    families.append([tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))])
norms=[];records=[]
for i in range(1,4):
    r=alpha^(25^i);pr=P(r);tp=tx.derivative()(r);assert pr and tp
    C=YY.quotient(Y^3-R(pr),names='yy');yy=C.gen()
    J=PowerSeriesRing(C,'z',default_prec=3);z=J.gen()
    l1=P.derivative()(r)/(3*pr)
    l2=(P.derivative(2)(r)/(2*pr)-3*l1^2)/3
    xs=J(r)+z;ys=J(yy)*(1+l1*z+l2*z^2)
    xs=xs.add_bigoh(3);ys=ys.add_bigoh(3)
    xp=[xs^j for j in range(23)];yp=[ys^j for j in range(3)]
    gs=[]
    for terms in families:
        value=J.zero()
        for ix,iy,hh,ww,c in terms:
            exponent=ww-hh+5;assert exponent>=0
            value+=C(dec(c)*H^hh*w^exponent)*xp[ix]*yp[iy]
        gs.append(value)
    ls=sum((L0[j]*xp[j] for j in range(L0.degree()+1)),J.zero())
    us=sum((U0[j]*xp[j] for j in range(U0.degree()+1)),J.zero())
    es=gs[3]-ls*gs[2]+ls^2*gs[1]-ls^3*gs[0]
    cs=gs[2]-2*ls*gs[1]+3*ls^2*gs[0]
    bs=gs[1]-3*ls*gs[0]
    ker=us*es+ys^10*C(w^5)
    assert ker[0]==ker[1]==cs[0]==0
    kk=ker[2]/C(tp^2);chi=cs[1]/C(tp);bb=bs[0]
    ee=-yy^10/C(U0(r));assert es[0]==ee*C(w^5)
    rr=kk*bb^5+C(U0(r))*chi^2*bb^4+2*ee*C(w^5)*chi^5
    coeff=rr.lift().list();coeff+= [R.zero()]*(3-len(coeff))
    n=coeff[0]^3+pr*coeff[1]^3+pr^2*coeff[2]^3-3*pr*coeff[0]*coeff[1]*coeff[2]
    norms.append(n);records.append({'root':r,'scaled_R':rr,'norm':n})
    save({'ring':R,'records':records,'source_scaling':'scaled_R=w^30*R'},str(root/'endpoint_content_norm_partial'))
    print('endpoint',i,'norm degrees',n.degrees(),'terms',len(n.dict()),'seconds',time.time()-start,flush=True)
product=prod(norms)
hh=min(e[0] for e in product.exponents());ww=min(e[1] for e in product.exponents())
reduced=R({(int(e[0]-hh),int(e[1]-ww)):c for e,c in product.dict().items()})
assert all(e[1]%3==0 for e in reduced.exponents())
S=PolynomialRing(K,names=('H','q'))
normq=S({(int(e[0]),int(e[1]/3)):c for e,c in reduced.dict().items()})
save({'ring':S,'norm':normq,'records':records,'removed_H_w':(hh,ww),
      'raw_norm_scaling':'product norm(scaled_R)=w^270*Norm(R)'},str(root/'endpoint_content_norm'))
report={'scope':'nine-sheet content norm only','H_degree':int(normq.degree(S.gen(0))),
        'q_degree':int(normq.degree(S.gen(1))),'terms':len(normq.dict()),
        'removed_H_w':list(map(int,[hh,ww])),'seconds':time.time()-start}
(root/'endpoint_content_norm.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
