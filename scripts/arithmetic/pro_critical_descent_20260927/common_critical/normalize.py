"""Symbolic solution of F4=F5=0; generates exact H,q-polynomial source."""
from algebra import *
from laurent import LP
import json,time
h=LP.mono((1,0));w=LP.mono((0,1))
source=json.loads((ROOT/'data/affine_source.json').read_text())
MAX=6
ZERO=lambda:[LP(0) for _ in range(MAX+1)]
def sa(a,b):return [x+y for x,y in zip(a,b)]
def sm(a,b):
    c=ZERO()
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b[:MAX+1-i]):
                if y:c[i+j]=c[i+j]+x*y
    return c
def spow(a,n):
    c=ZERO();c[0]=LP(1)
    while n:
        if n&1:c=sm(c,a)
        n>>=1
        if n:a=sm(a,a)
    return c
def shift(a,n):return [LP(0)]*n+a[:MAX+1-n]
# Y^3= sum P_i xi^(30-3i)
Y=ZERO();Y[0]=LP(1)
for n in range(1,MAX+1):
    r=spow(Y,3)[n]
    c=P[(30-n)//3] if (30-n)%3==0 and 0<=30-n<=30 else 0
    Y[n]=(LP(c)-r)*inv(3)
Yp=[spow(Y,j) for j in range(3)]

def source_lp(u=LP(0),v=LP(0)):
    z0=2*w/Epsilon;c=Cd*w
    e=-c*z0-LP(Eta)/(24*z0)
    f=-w**2/Epsilon-LP(div(8,24))*z0**5
    coords=[LP(1),h,w,e,f,u,v]
    G=[{}, {}, {}, {}]
    for name,co in zip(['particular','h','w','e','f','u','v'],coords):
        for i,a,b,c in source[name]:
            vals=mon(a,b)
            if i==2:vals=cmul(vals,mon(0,2))
            for j,row in enumerate(vals):
                for m,d in enumerate(row):
                    if d:
                        key=(m,j)
                        G[i-2][key]=G[i-2].get(key,LP(0))+co*mul(c,d)
    return [{k:v for k,v in g.items() if v} for g in G]

def curve_series(G,d):
    out=ZERO()
    for (m,j),co in G.items():
        s=d-3*m-10*j
        assert s>=0,(m,j,d)
        if s<=MAX:
            for n in range(MAX+1-s):
                if Yp[j][n]:out[n+s]=out[n+s]+co*Yp[j][n]
    return out

def Fser(G):
    aa=[c*3 for c in curve_series(G[0],35)]
    bb=[c*2 for c in curve_series(G[1],46)]
    cc=curve_series(G[2],57)
    qq=curve_series({(i,0):LP(c) for i,c in enumerate(Q) if c},57)
    gg=curve_series(G[3],70)
    t10=cmul(cscalar(ppow(t,3)),cpow(mon(0,1),10))
    tt=curve_series({(i,j):LP(c) for j,row in enumerate(t10) for i,c in enumerate(row) if c},127)
    rho=ZERO()
    assert not aa[0] and bb[0]==LP(mul(2,Epsilon))
    for n in range(MAX+1):
        r=sa(sa(sm(aa,spow(rho,2)),sm(bb,rho)),cc)[n]
        rho[n]=-r/div(mul(2,Epsilon),1)
    assert rho[0]==2*w/Epsilon
    term1=sa(qq,shift(spow(rho,5),2))
    term2=sa(gg,shift(sa(sm(aa,spow(rho,3)),[c*2 for c in sm(bb,spow(rho,2))]),2))
    return sa(sm(term1,term2),tt)

def main():
    st=time.time()
    G=source_lp();F=Fser(G)
    Fu=Fser(source_lp(LP(1),LP(0)));Fv=Fser(source_lp(LP(0),LP(1)))
    assert all(not c for c in F[:4])
    a,b=Fu[4]-F[4],Fv[4]-F[4];c,d=Fu[5]-F[5],Fv[5]-F[5]
    det=a*d-b*c
    print('F4/F5 determinant',det,flush=True)
    assert len(det.d)==1 and next(iter(det.d))==(0,2)
    u=(-F[4]*d+b*F[5])/det;v=(-a*F[5]+F[4]*c)/det
    G=source_lp(u,v);F=Fser(G)
    assert all(not c for c in F[:6])
    # Verify F6 exactly equals supplied Psi/(q<299619>^2), with q=w^3,H=h*w.
    a0=[89654,311173,214299,163299,315361,33043,356725,245794]
    psi=sum((LP(cc)*w**(3*i) for i,cc in enumerate(a0)),LP(0))+w**3*(LP(299833)+LP(232505)*w**3)*h*w
    assert F[6]==psi/(w**3*LP(299619)**2)
    print('F0 through F5 zero; supplied F6 verified exactly',flush=True)
    # Output U,V,Z for G_i=w U_i + y V_i + y^2/w^4 Z_i(H,q,x).
    out={}
    for i,g in enumerate(G,2):
        rows=[]
        for (m,j),co in sorted(g.items()):
            for (ha,wa),cc in sorted(co.d.items()):
                if j==0:
                    assert (ha,wa)==(0,1),(i,m,j,co)
                    rows.append([m,j,0,0,cc])
                elif j==1:
                    assert (ha,wa)==(0,0),(i,m,j,co)
                    rows.append([m,j,0,0,cc])
                else:
                    assert (wa+4-ha)%3==0
                    qa=(wa+4-ha)//3
                    assert qa>=0 and ha>=0
                    rows.append([m,j,ha,qa,cc])
        out[str(i)]=rows
        print('G',i,'coefficient records',len(rows),'Hdegree',max(r[2] for r in rows),'qdegree',max(r[3] for r in rows),flush=True)
    (ROOT/'data/normalized_source.json').write_text(json.dumps(out,indent=2)+'\n')
    (ROOT/'data/kernel_and_series.json').write_text(json.dumps({'kernel_u':u.data(),'kernel_v':v.data(),'F6':F[6].data(),'determinant':det.data()},indent=2)+'\n')
    print('elapsed_seconds',round(time.time()-st,3),flush=True)
if __name__=='__main__':main()
