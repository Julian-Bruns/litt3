"""Explore the fixed endpoint contribution to low-degree critical traces."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]); source=root/'family.txt'
F=GF(5); Rz=PolynomialRing(F,'z'); z=Rz.gen()
u=z^4+2*z^3+z^2+2*z; v=z^3+z^2+1
K=GF(5^8,'a',modulus=u^2+u*v-3*v^2); a=K.gen(); beta=-u(a)/v(a)
def code(n):
    n=int(n); out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(c%5+(c//5)*beta)*a^i
    return out
R=PolynomialRing(K,'x');x=R.gen()
P=R([code(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
A=R([code(c) for c in [1,21,14,22,13]])
Q=R([code(c) for c in [0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]])
L=R([code(c) for c in [18,20,20,15]])
B0=R([code(c) for c in [8,14,19,2,10,19,3,24,18,16]])
tau=(A/(code(13)*(x-a))).numerator()
E=K.extension(x^3-P(a),'b'); b=E.gen()
PREC=40
PS=PowerSeriesRing(E,'r',default_prec=PREC); r=PS.gen()
LS=LaurentSeriesRing(E,'r',default_prec=PREC)
lines=iter(source.read_text().splitlines());family=[]
for k in range(4):
    count=int(next(lines));family.append([tuple(map(int,next(lines).split())) for _ in range(count)])

def evaluate(h,w,point=1,full=False):
    rt=E(a^(25^point)); y0=b^(25^point);xx=rt+r
    pser=PS(P(xx)); yy=PS(y0)
    for step in range(6): yy=(yy-(yy^3-pser)/(3*yy^2)).add_bigoh(PREC)
    gs=[]
    for terms in family:
        gs.append(sum(E(code(c)*h^hh*w^ww)*xx^i*yy^j for i,j,hh,ww,c in terms).add_bigoh(PREC))
    ll=PS(L(xx));q0=PS(Q(xx))-ll^5
    s2=gs[1]-3*gs[0]*ll
    s1=3*gs[0]*ll^2-2*gs[1]*ll+gs[2]
    vv=PS(0)
    for step in range(6): vv=(vv-(3*gs[0]*vv^2+2*s2*vv+s1)/(6*gs[0]*vv+2*s2)).add_bigoh(PREC)
    zz=vv-ll; phi=LS((vv^5+q0)/yy^5)
    ss=LS((gs[0]*zz^3+gs[1]*zz^2+gs[2]*zz+gs[3])/yy^5)
    tt=LS(tau(xx)^3)
    lam=-ss/phi-tt/phi^2
    eta=LS((3*gs[1]-gs[0]*zz)/(2*yy^3))
    omega=LS(1/(3*yy^2))
    if full:
        WW=PolynomialRing(LS,'W'); W=WW.gen()
        bo=LS(B0(xx)); ay=LS(gs[0]/yy^2)
        by=LS((gs[1]-3*bo*gs[0])/yy^3)
        cy=LS((gs[2]-2*bo*gs[1]+3*bo^2*gs[0])/yy^4)
        ey=LS((gs[3]-bo*gs[2]+bo^2*gs[1]-bo^3*gs[0])/yy^5)
        qb=LS((Q(xx)-bo^5)/yy^5)
        SP=ay*W^3+by*W^2+cy*W+ey; PH=W^5+qb
        dSP=WW([s.derivative()/omega for s in SP.list()])
        B=qb.derivative()/omega; dt=tt.derivative()/omega; NN=dt-B*SP
        DD=[4*tt^2*B^2,-4*tt*B*NN,NN^2-4*tt*B*dSP,2*NN*dSP,dSP^2]
        zb=LS(gs[1]/gs[0])-LS(zz)
        wb=[LS((zz+bo)/yy),LS((zb+bo)/yy)]
        etas=[eta,LS((3*gs[1]-gs[0]*zb)/(2*yy^3))]
        phs=[phi,LS((zb^5+Q(xx))/yy^5)]
        corrections={}
        for m in [0,-1]:
            for n in range(3 if m==0 else 6):
                k=4-m-2*n; pieces=[]; hp=WW.zero()
                for j in range(max(0,k)):
                    cj=sum(WW(DD[i])*binomial(-n-1,j-i)*SP^(j-i)*tt^(-n-1-j+i) for i in range(min(j,4)+1))*(-1)^(n+1)
                    hp+=cj.quo_rem(PH^(k-j))[0]
                    pieces.append((cj,k-j))
                psis=[]
                for s in range(2):
                    ps=etas[s]*(sum(cj(wb[s])/phs[s]^d for cj,d in pieces)-hp(wb[s]))*omega
                    psis.append(ps)
                om=eta*phi^m*lam.derivative()^2/omega*lam^(-n-1)
                value=psis[0]+psis[1]-om
                corrections[str(m)+','+str(n)]=[(LS(xx^j)*value)[-1] for j in range(3)]
        return corrections
    ans={'h':str(h),'w':str(w),'s2':str(s2[0]),'eta':str(eta[0]),'lambda_pole':int(lam.valuation()),
         'lambda_lead':str(lam[-1]),'eta_lambda':str(eta[0]*lam[-1]),'eta_over_lambda':str(eta[0]/lam[-1])}
    for m in [0,-1]:
        cc=[]
        for n in range(3 if m==0 else 6):
            om=eta*phi^m*lam.derivative()^2/omega*lam^(-n-1)
            cc.append(str(-om[-1]))
        ans['endpoint_coefficients_m'+str(m)]=cc
    return ans

start=time.time();res=[]
if len(sys.argv)>2 and sys.argv[2]=='full':
    h,w=K(2),K(3);combined={}
    for point in [1,2,3]:
        ans=evaluate(h,w,point,True)
        for key,vals in ans.items():
            tr=[3*c.lift()[0] for c in vals]
            if key not in combined:combined[key]=[K.zero()]*3
            combined[key]=[x+y for x,y in zip(combined[key],tr)]
        print('endpoint',point,'done',time.time()-start,flush=True)
    def encode(c):
        # A small explicit inverse of the prescribed K basis.
        basis=[a^i for i in range(4)]; bas8=[v for z in basis for v in (z,beta*z)]
        mat=matrix(GF(5),[list(z.polynomial())+[0]*(8-len(z.polynomial().list())) for z in bas8]).transpose()
        vv=mat.solve_right(vector(GF(5),list(c.polynomial())+[0]*(8-len(c.polynomial().list()))))
        return sum(int(vv[i])*5^i for i in range(8))
    out={key:list(map(encode,vals)) for key,vals in combined.items()}
    (root/'endpoint_corrected_low_traces_2_3.json').write_text(json.dumps({'h':2,'w':3,'corrections':out,'seconds':time.time()-start},indent=2,default=int)+'\n')
    print(json.dumps(out,default=int),flush=True)
else:
    for h,w in [(2,3),(3,3),(4,3),(2,4)]:
        ans=evaluate(K(h),K(w));res.append(ans);print(json.dumps(ans),flush=True)
    (root/'endpoint_local_exploration.json').write_text(json.dumps({'results':res,'seconds':time.time()-start},indent=2)+'\n')
