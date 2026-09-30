"""Exact source/Cramer/residual evaluation over K. Not a geometric exhaustive search."""
import json,sys,time
from pathlib import Path
import field as F
import poly as U
from reconstruct import setup,sumk
ROOT=Path(__file__).resolve().parents[1]

INP,P,A,Q,B,L,t,V=setup()
SOURCE=json.loads((ROOT/'data/source_affine.json').read_text())
EPS=F.code(INP['epsilon_K_digits']);ETA=F.code(INP['eta_K_digits'])
CA=F.code(INP['Ca_K_digits']);CD=F.code(INP['Cd_K_digits'])
Y=None

def smul(a,b,n=7):return U.mul(a,b)[:n]
def spow(a,k,n=7):
    out=[1]
    while k:
        if k&1:out=smul(out,a,n)
        a=smul(a,a,n);k//=2
    return out

def yseries(n=8):
    y=[1]
    target=[0]*n
    for i,p in enumerate(P):
        j=30-3*i
        if 0<=j<n:target[j]=p
    for i in range(1,n):
        c=U.coeff(spow(y,3,n),i)
        y.append(F.div(F.sub(target[i],c),3))
    assert (spow(y,3,n)+[0]*n)[:n]==target
    return y
Y=yseries()

def series_curve(a,pole,n=7):
    out=[0]*n
    ys=[[1],Y,spow(Y,2,n)]
    for j in range(3):
        for i,c in enumerate(a[j]):
            if not c:continue
            shift=pole-3*i-10*j
            assert shift>=0,(pole,i,j)
            if shift<n:
                for k,v in enumerate(ys[j]):
                    if shift+k<n:out[shift+k]=F.add(out[shift+k],F.mul(c,v))
    return U.trim(out)

def source(params):
    coeffs=[F.add(c,sumk(F.mul(v,d[i]) for v,d in zip(params,SOURCE['directions']))) for i,c in enumerate(SOURCE['constant'])]
    dic={b:U.zero() for b in ['D2','G3','G4','G5']}
    for (b,i,j),c in zip(SOURCE['unknowns'],coeffs):
        while len(dic[b][j])<=i:dic[b][j].append(0)
        dic[b][j][i]=c
    for b in dic:
        dic[b]=[U.trim(v) for v in dic[b]]
    dic['G2']=U.cmul(dic['D2'],U.monomial(0,2))
    return dic

def fj(dic):
    aa=U.scale(series_curve(dic['G2'],35),3)
    bb=U.scale(series_curve(dic['G3'],46),2)
    cc=series_curve(dic['G4'],57)
    assert U.coeff(bb,0)==F.scale(EPS,2) and U.coeff(aa,0)==0
    rho=[]
    for i in range(5):
        val=U.add(U.add(smul(aa,spow(rho,2)),smul(bb,rho)),cc)
        rho.append(F.neg(F.div(U.coeff(val,i),bb[0])))
    q=series_curve([Q,[],[]],57)
    g5=series_curve(dic['G5'],70)
    left=U.add(q,[0,0,F.powk(rho[0],5)])
    inner=U.add(smul(aa,spow(rho,3)),U.scale(smul(bb,spow(rho,2)),2))
    right=U.add(g5,U.shift(inner,2))[:7]
    fixed=series_curve(U.cmulpoly(U.cpow(U.monomial(0,1),10),U.powp(t,3)),127)
    out=U.add(smul(left,right),fixed)
    return (out+[0]*7)[:7],rho

def cramer(h,w):
    if not h or not w:raise ValueError('h,w must be nonzero')
    z=F.div(F.scale(w,2),EPS);c=F.add(F.mul(CA,h),F.mul(CD,w))
    e=F.neg(F.add(F.mul(c,z),F.div(ETA,F.mul(24,z))))
    f=F.neg(F.add(F.div(F.mul(w,w),EPS),F.mul(F.div(8,24),F.powk(z,5))))
    pars=[h,w,e,f,0,0]
    base,_=fj(source(pars))
    assert base[:4]==[0]*4
    dirs=[]
    for j in (4,5):
        pars[j]=1;fs,_=fj(source(pars));pars[j]=0
        dirs.append([F.sub(fs[k],base[k]) for k in (4,5)])
    a,c0=dirs[0];b,d=dirs[1]
    det=F.sub(F.mul(a,d),F.mul(b,c0))
    if not det:raise ValueError('Cramer pivot zero')
    ss=F.div(F.sub(F.mul(b,base[5]),F.mul(d,base[4])),det)
    uu=F.div(F.sub(F.mul(c0,base[4]),F.mul(a,base[5])),det)
    pars[4:]=[ss,uu];dic=source(pars);fs,rho=fj(dic)
    assert fs[:6]==[0]*6
    return dic,pars,fs,det

def csum(*args):
    out=U.zero()
    for a in args:out=U.cadd(out,a)
    return out

def resultant(a,b,c,d,q,C,l):
    # Compact universal fixed-degree (10,2) polynomial formula.
    cm,cp,cs=U.cmul,U.cpow,U.cscale
    E=U.csub(cm(a,d),cm(b,c));D=csum(cp(b,2),cm(a,c))
    a5=cp(a,5);b5=cp(b,5)
    T=csum(cp(c,5),cs(cm(q,b5),4),cm(cp(q,2),a5))
    UU=U.csub(cs(cm(q,a5),2),b5)
    VV=csum(cs(cm(d,b5),4),cs(cm(cp(c,2),cp(b,4)),3),
             cs(cm(cm(a,cp(b,2)),cp(c,3)),2),cs(cm(cp(a,2),cp(c,4)),3),
             cm(q,csum(cs(cm(a5,d),2),cs(cm(cm(cp(a,4),b),c),4),cm(cp(a,3),cp(b,3)))))
    W=csum(cm(cp(a,2),cp(d,2)),cs(cm(cm(cm(a,b),c),d),4),
            cs(cm(cp(b,2),cp(c,2)),2),cm(cp(b,3),d),cm(a,cp(c,3)))
    M=U.csub(cm(UU,csum(cs(cm(a,E),2),cm(b,D))),cm(cp(a,2),VV))
    out=csum(cm(cp(l,2),cp(T,2)),cm(l,csum(cm(T,VV),cm(C,U.csub(cp(UU,2),cs(cm(a5,T),2))))),
             cm(cp(a,3),csum(cm(T,W),cm(C,M))),cm(cp(C,2),cp(a,10)))
    return out

def barred(dic):
    G2,G3,G4,G5=[dic[k] for k in ['G2','G3','G4','G5']]
    b2=U.powp(B,2);b3=U.mul(b2,B)
    g2=U.cexact_y(G2,2)
    g3=U.cexact_y(U.csub(G3,U.cscale(U.cmulpoly(G2,B),3)),3)
    g4=U.cexact_y(csum(G4,U.cscale(U.cmulpoly(G3,B),3),U.cscale(U.cmulpoly(G2,b2),3)),4)
    g5=U.cexact_y(csum(G5,U.cscale(U.cmulpoly(G4,B),4),U.cmulpoly(G3,b2),U.cscale(U.cmulpoly(G2,b3),4)),5)
    qbar=U.cmulpoly(U.monomial(0,1),U.exactdiv(U.sub(Q,U.frob(B)),U.powp(P,2)))
    return g2,g3,g4,g5,qbar

def residual(dic,lam,unbarred=False):
    if unbarred:
        g2,g3,g4,g5=[dic[k] for k in ['G2','G3','G4','G5']]
        qbar=[Q,[],[]];C=U.cmulpoly(U.cpow(U.monomial(0,1),10),U.powp(t,3))
    else:
        g2,g3,g4,g5,qbar=barred(dic);C=[U.powp(t,3),[],[]]
    rs=resultant(U.cscale(g2,3),U.cscale(g3,2),g4,g5,qbar,C,
                  [U.scale([F.neg(9),1],lam),[],[]])
    numer=U.norm(rs);denom=U.mul(U.powp(t,15),U.powp([F.neg(9),1],3))
    if unbarred:denom=U.mul(denom,U.powp(P,40))
    return U.exactdiv(numer,denom)

def square_test(R):
    if not R:return True,[],None
    if (len(R)-1)%2:return False,[],None
    n=(len(R)-1)//2;L=R[-1]
    # Normalized root of R/L at infinity; K is not assumed to contain sqrt(L).
    A=U.scale(list(reversed(R)),F.inv(L));b=[1]
    for i in range(1,n+1):
        b.append(F.div(F.sub(U.coeff(A,i),U.coeff(U.mul(b,b),i)),2))
    tails=U.sub(U.mul(b,b),A)
    first=next((i for i in range(n+1,2*n+1) if U.coeff(tails,i)),None)
    return first is None,b,first

def run(h=1,w=1,lam=1):
    start=time.time();dic,pars,fs,det=cramer(h,w)
    if not fs[6]:raise ValueError('F6 zero')
    q=F.powk(w,3)
    assert q not in INP['removed_q_K_codes']
    R=residual(dic,lam)
    leading=F.powk(F.mul(F.mul(F.scale(F.powk(h,3),3),F.powk(EPS,8)),fs[6]),3)
    assert len(R)==141 and R[-1]==leading
    ok,b,first=square_test(R)
    out={'h':h,'w':w,'lambda':lam,'H':F.div(h,w),'q':q,'mu':F.div(lam,w),
         'parameters':pars,'F':fs,'det':det,'degree_R':len(R)-1,'leading_R':R[-1],
         'gcd_R_derivative_degree':len(U.gcd(R,U.deriv(R)))-1,
         'geometrically_square':ok,'first_failed_normalized_tail':first,'seconds':round(time.time()-start,3)}
    print(json.dumps(out,indent=2))
    (ROOT/'evidence/numerical_evaluation.json').write_text(json.dumps(out,indent=2)+'\n')
    (ROOT/'data/example_nonsquare.json').write_text(json.dumps({'summary':out,'G':dic,'R':R,'normalized_formal_root':b},separators=(',',':'))+'\n')

if __name__=='__main__':run(*(list(map(int,sys.argv[1:])) or [1,1,1]))
