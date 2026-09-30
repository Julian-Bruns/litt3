"""Exact symbolic small-critical-root expansion on the entire lower-degree boundary.
The ring allows Laurent exponents only in w=d/kappa. No finite-field sampling.
"""
from symfield import K,FE
from exact import *
from residual import adapted_basis,boundary_constants,combine,deserialize,ROOT
from sympy.polys.rings import ring
import json,time,argparse

R,w,h,p,q=ring('w,h,p,q',K)
ONE=R.one;ZERO=R.zero

def cn(c):return R.ground_new(FE.code(c))
def negwpoly(poly):
    """Clear the least w exponent only; returns (polynomial, exponent multiplied)."""
    if not poly:return poly,0
    m=min(e[0] for e in poly)
    if m<0:return poly*R.from_dict({(-m,0,0,0):K.one}),-m
    return poly,0

def winv():return R.from_dict({(-1,0,0,0):K.one})
def sadd(a,b,L):return [(a[i] if i<len(a) else ZERO)+(b[i] if i<len(b) else ZERO) for i in range(L)]
def sscale(a,c):return [v*c for v in a]
def shift(a,n,L):return ([ZERO]*n+a)[:L]
def smul(a,b,L):
    out=[ZERO for _ in range(L)]
    for i,aa in enumerate(a[:L]):
        if aa:
            for j,bb in enumerate(b[:L-i]):
                if bb:out[i+j]+=aa*bb
    return out

def frob(poly):return R.from_dict({tuple(5*i for i in e):c**5 for e,c in poly.items()})
def sfrob(a,L):
    out=[ZERO for _ in range(L)]
    for i,c in enumerate(a):
        if 5*i>=L:break
        out[5*i]=frob(c)
    return out

def yunit(L):
    # Y(s)^3=P(s^-3)*s^30, Y(0)=1.
    a=[0]*L;a[0]=1
    for n in range(1,L):
        target=P[10-n//3] if n%3==0 else 0
        v=0
        for i in range(n+1):
            for j in range(n-i+1):
                z=n-i-j
                if max(i,j,z)<n:v=add(v,mul(mul(a[i],a[j]),a[z]))
        a[n]=mul(2,sub(target,v))
    return a

def cr_series(cr,shift0,L,yy):
    """s^shift0 cr(s^-3,s^-10 Y(s)), through s^(L-1)."""
    yp=[[1]+[0]*(L-1),yy]
    yy2=[0]*L
    for i in range(L):
        for j in range(L-i):yy2[i+j]=add(yy2[i+j],mul(yy[i],yy[j]))
    yp.append(yy2)
    out=[0]*L
    for (a,b),c in cr.terms().items():
        e=shift0-3*a-10*b
        if e<0:raise ValueError(('negative exponent',e,shift0,cr.pole()))
        for i in range(L-e):
            if yp[b][i]:out[e+i]=add(out[e+i],mul(c,yp[b][i]))
    return [cn(c) for c in out]

def symbolic_series(s,L=11,verbose=True):
    ca,cd=boundary_constants(s);z=w*cn(fdiv(2,epsilon));c=h*cn(ca)+w*cn(cd)
    e=-c*z-cn(fdiv(mul(eta,epsilon),mul(24,2)))*winv()
    f=-w*w*cn(inv(epsilon))-frob(z)*cn(fdiv(8,24))
    scalars=[ONE,h,w,e,f,p,q]
    right,ker,_=adapted_basis(s)
    No,_,D0=deserialize(s['origin']);cols=[]
    for col in right+ker:
        N,_,_=combine(s,col);cols.append([nn-no for nn,no in zip(N,No)])
    yy=yunit(L)
    S={}
    for idx,ss in [(2,35),(3,46),(4,57),(5,70)]:
        ser=[ZERO]*L
        for coeff,col in zip(scalars,cols):ser=sadd(ser,sscale(cr_series(col[idx],ss,L,yy),coeff),L)
        S[idx]=ser
    AA=sscale(S[2],cn(3));BB=sscale(S[3],cn(2));CC=S[4]
    assert not AA[0] and BB[0]==cn(mul(2,epsilon))
    invB=cn(inv(mul(2,epsilon)))
    rho=[ZERO]*L
    rho[0]=-CC[0]*invB;assert rho[0]==z
    for n in range(1,L):
        rhs=CC[n]
        for i in range(1,n+1):rhs+=BB[i]*rho[n-i]
        for i in range(1,n+1):
            if AA[i]:
                rhs+=AA[i]*sum((rho[j]*rho[n-i-j] for j in range(n-i+1)),ZERO)
        rho[n]=-rhs*invB
        if verbose:print('rho',n,'terms',len(rho[n]),flush=True)
    r2=smul(rho,rho,L);r3=smul(r2,rho,L)
    HS=sadd(S[5],shift(sadd(smul(AA,r3,L),sscale(smul(BB,r2,L),cn(2)),L),2,L),L)
    QS=cr_series(CR(Q),57,L,yy)
    TS=sadd(QS,shift(sfrob(rho,L),2,L),L)
    FS=sadd(smul(TS,HS,L),cr_series(y**10*t**3,127,L,yy),L)
    VV=cr_series(CR(FP(s['v'])),0 if s['root'] is None else 3,L,yy)
    GS=shift(smul(VV,smul(TS,TS,L),L),13 if s['root'] is None else 10,L)
    assert all(not FS[i] for i in range(4))
    return FS,GS,rho

def serialize(poly):return [[list(e),c.v] for e,c in sorted(poly.items())]
def deserialize_poly(d):return R.from_dict({tuple(e):FE.code(c) for e,c in d})

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--index',type=int,default=0);ap.add_argument('--length',type=int,default=11);args=ap.parse_args()
    s=json.loads((ROOT/'data'/'linear_spaces.json').read_text())['spaces'][args.index]
    st=time.monotonic();F,G,rho=symbolic_series(s,args.length)
    for i,poly in enumerate(F):
        print('F',i,'terms',len(poly),'degrees',[max([e[j] for e in poly],default=-1) for j in range(4)],flush=True)
        if len(poly)<25:print(poly,flush=True)
    out={'space_index':args.index,'root':s['root'],'variables':['w=d/kappa','h=a/kappa','p=kernel_0/kappa','q=kernel_1/kappa'],'F':[serialize(p) for p in F],'G':[serialize(p) for p in G],'rho':[serialize(p) for p in rho]}
    (ROOT/'data'/f'infinity_{args.index}.json').write_text(json.dumps(out,indent=2)+'\n')
    print('Seconds',time.monotonic()-st)

if __name__=='__main__':main()
