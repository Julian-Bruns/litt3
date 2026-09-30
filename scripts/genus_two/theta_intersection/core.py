"""Exact F_125, linear algebra, and genus-two arithmetic. Codes are base 5."""
import itertools, json, random
from pathlib import Path
p=5;q=125
D=[(i%5,(i//5)%5,i//25) for i in range(q)]
ADD=[[sum(((D[a][j]+D[b][j])%5)*5**j for j in range(3)) for b in range(q)] for a in range(q)]
NEG=[sum((-D[a][j]%5)*5**j for j in range(3)) for a in range(q)]
def _mul(a,b):
    c=[0]*5
    for i in range(3):
        for j in range(3): c[i+j]+=D[a][i]*D[b][j]
    for i in (4,3):
        c[i-3]-=c[i];c[i-2]-=c[i]
    return sum((c[i]%5)*5**i for i in range(3))
MUL=[[_mul(a,b) for b in range(q)] for a in range(q)]
def add(a,b):return ADD[a][b]
def sub(a,b):return ADD[a][NEG[b]]
def mul(a,b):return MUL[a][b]
def powf(a,n):
    r=1
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n>>=1
    return r
INV=[0]+[powf(a,123) for a in range(1,q)]
def div(a,b):
    assert b
    return mul(a,INV[b])
def sm(xs):
    r=0
    for x in xs:r=add(r,x)
    return r
def dot(a,b):return sm(mul(x,y) for x,y in zip(a,b))
def trim(f):
    f=list(f)
    while f and f[-1]==0:f.pop()
    return f
def pa(f,g):return trim([add(f[i] if i<len(f) else 0,g[i] if i<len(g) else 0) for i in range(max(len(f),len(g)))])
def pn(f):return [NEG[x] for x in f]
def ps(f,g):return pa(f,pn(g))
def pc(f,c):return trim([mul(x,c) for x in f])
def pm(f,g):
    if not f or not g:return []
    r=[0]*(len(f)+len(g)-1)
    for i,x in enumerate(f):
        for j,y in enumerate(g):r[i+j]=add(r[i+j],mul(x,y))
    return trim(r)
def pd(f,g):
    assert g
    r=list(f);z=[0]*max(0,len(f)-len(g)+1)
    while len(r)>=len(g):
        d=len(r)-len(g);c=div(r[-1],g[-1]);z[d]=c
        for i,x in enumerate(g):r[i+d]=sub(r[i+d],mul(c,x))
        r=trim(r)
    return trim(z),r
def pe(f,x):
    v=0
    for c in reversed(f):v=add(mul(v,x),c)
    return v
def monic(f):return pc(f,INV[f[-1]])
def pxgcd(a,b):
    s0,s1,t0,t1=[1],[],[],[1]
    while b:
        d,r=pd(a,b);a,b=b,r
        s0,s1=s1,ps(s0,pm(d,s1));t0,t1=t1,ps(t0,pm(d,t1))
    return monic(a),pc(s0,INV[a[-1]]),pc(t0,INV[a[-1]])
def pmod(f,g):return pd(f,g)[1]
def rref(A,ncols=None):
    A=[row[:] for row in A]
    n=ncols if ncols is not None else len(A[0]);r=0;piv=[]
    for c in range(n):
        t=next((j for j in range(r,len(A)) if A[j][c]),None)
        if t is None:continue
        A[r],A[t]=A[t],A[r];v=INV[A[r][c]]
        A[r]=[mul(x,v) for x in A[r]]
        for j in range(len(A)):
            if j!=r and A[j][c]:
                v=A[j][c];A[j]=[sub(x,mul(v,y)) for x,y in zip(A[j],A[r])]
        piv.append(c);r+=1
        if r==len(A):break
    return A,piv

def null(A,ncols=None):
    n=ncols if ncols is not None else len(A[0]);A,piv=rref(A,n)
    out=[]
    for c in range(n):
        if c in piv:continue
        v=[0]*n;v[c]=1
        for r,b in enumerate(piv):v[b]=NEG[A[r][c]]
        out.append(v)
    return out

def mv(M,v):return [dot(r,v) for r in M]
def tr(M):return list(map(list,zip(*M)))
def mm(A,B):return [[dot(a,b) for b in tr(B)] for a in A]
def normalize(v):
    a=next(x for x in v if x)
    return [div(x,a) for x in v]
def det(M):
    M=[r[:] for r in M];d=1
    for i in range(len(M)):
        j=next((j for j in range(i,len(M)) if M[j][i]),None)
        if j is None:return 0
        if i!=j:M[i],M[j]=M[j],M[i];d=NEG[d]
        v=M[i][i];d=mul(d,v)
        for j in range(i+1,len(M)):
            c=div(M[j][i],v)
            for h in range(i,len(M)):M[j][h]=sub(M[j][h],mul(c,M[i][h]))
    return d

alpha=5
beta=powf(alpha,5) # coefficient of the Frobenius-twisted curve
roots=[0,1,2,3,beta]
f=[1]
for a in roots:f=pm(f,[NEG[a],1])
assert len(f)==6
sq={mul(a,a):a for a in range(q)}
points=[(x,sq[pe(f,x)]) for x in range(q) if pe(f,x) in sq and pe(f,x)!=0]

def from_points(P,Q):
    x,y=P;z,w=Q
    assert x!=z
    A=pm([NEG[x],1],[NEG[z],1]);slope=div(sub(y,w),sub(x,z));B=[sub(y,mul(slope,x)),slope]
    return A,trim(B)
def coprime_add(a,b,c,d):
    g,s,t=pxgcd(a,c)
    assert g==[1]
    h=pmod(pm(s,ps(d,b)),c)
    A=pm(a,c);B=pa(b,pm(a,h))
    while len(A)>3:
        A,r=pd(ps(f,pm(B,B)),A);assert not r
        A=monic(A);B=pmod(pn(B),A)
    return A,B

def polar(x,z):
    # F-polar in the question
    return sm([mul(2,f[0]),mul(f[1],add(x,z)),mul(mul(2,f[2]),mul(x,z)),
               mul(f[3],mul(mul(x,z),add(x,z))),mul(mul(2,f[4]),mul(mul(x,x),mul(z,z))),
               mul(f[5],mul(mul(mul(x,x),mul(z,z)),add(x,z)))])

def kum(A,B):
    # Symmetric formula, valid for any degree-2 A=x^2-s*x+p with nonzero discriminant.
    assert len(A)==3 and A[-1]==1
    s=NEG[A[1]];p=A[0];disc=sub(mul(s,s),mul(4,p));assert disc
    b0=B[0] if B else 0;b1=B[1] if len(B)>1 else 0
    yy=sm([mul(b0,b0),mul(mul(b0,b1),s),mul(mul(b1,b1),p)])
    pol=sm([mul(2,f[0]),mul(f[1],s),mul(mul(2,f[2]),p),mul(f[3],mul(p,s)),
            mul(mul(2,f[4]),mul(p,p)),mul(f[5],mul(mul(p,p),s))])
    return [1,s,p,div(sub(pol,mul(2,yy)),disc)]

pairs=list(itertools.combinations(range(6),2))
def torsion(pair):
    a,b=pair
    A=[1]
    for j in pair:
        if j<5:A=pm(A,[NEG[roots[j]],1])
    return A,[]

def transmatrix(pair):
    C,D=torsion(pair);eq=[];samples=[]
    rng=random.Random(7381+6*pair[0]+pair[1])
    while len(samples)<10:
        P,Q=rng.sample(points,2)
        if P[0]==Q[0]:continue
        A,B=from_points(P,Q)
        if pxgcd(A,C)[0]!=[1]:continue
        E,G=coprime_add(A,B,C,D)
        try:X=kum(A,B);Y=kum(E,G)
        except AssertionError:continue
        samples.append([A,B,E,G])
        for j in range(1,4):
            row=[0]*16
            for c in range(4):
                row[j*4+c]=mul(Y[0],X[c]);row[c]=NEG[mul(Y[j],X[c])]
            eq.append(row)
    ns=null(eq);assert len(ns)==1,(pair,len(ns))
    v=normalize(ns[0]);M=[v[4*j:4*j+4] for j in range(4)]
    M2=mm(M,M);c=M2[0][0]
    assert c and M2==[[c if i==j else 0 for j in range(4)] for i in range(4)]
    return M,c,samples

mons2=[(i,j) for i in range(4) for j in range(i,4)]
def qval(v,x):return dot(v,[mul(x[i],x[j]) for i,j in mons2])
def quad_comp(v,M):
    out=[0]*10
    for (i,j),c in zip(mons2,v):
        if not c:continue
        for h in range(4):
            for l in range(4):
                a,b=sorted((h,l));idx=mons2.index((a,b));out[idx]=add(out[idx],mul(c,mul(M[i][h],M[j][l])))
    return out

def hommons(n,d):
    if n==1:return [(d,)]
    return [(i,)+t for i in range(d,-1,-1) for t in hommons(n-1,d-i)]
def monval(m,v):
    z=1
    for a,b in zip(m,v):z=mul(z,powf(b,a))
    return z

def setup():
    translations=[]
    for pair in pairs:
        M,c,samples=transmatrix(pair)
        translations.append({'pair':pair,'matrix':M,'square':c,'samples':samples})
    # theta for O(O) is kappa_1=0; translates are the sixteen nodes of the dual Kummer.
    tropes=[[1,0,0,0]]+[normalize(t['matrix'][0]) for t in translations]
    assert len(set(map(tuple,tropes)))==16
    mon4=hommons(4,4);equations=[]
    for v in tropes:
        for i in range(4):
            row=[]
            for m in mon4:
                if not m[i]:row.append(0)
                else:
                    e=list(m);e[i]-=1;row.append(mul(m[i]%5,monval(e,v)))
            equations.append(row)
    ns=null(equations);assert len(ns)==1,len(ns)
    K=normalize(ns[0])
    # The five given points in the moduli P^3.
    a0=0;a1=alpha;a2=a4=sub(4,alpha);a3=add(1,alpha)
    T=[0,1]
    W=[mul(3,a3),mul(3,a4),1]
    V=pa([NEG[a2]],pm([a4,2],W))
    Psi=ps(pa([mul(2,a0),NEG[mul(2,a1)]],pc(W,a2)),pm(V,W))
    Psi=monic(Psi)
    zpol=[[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18],[1]]
    evalcols=[pmod(pm(zpol[i],zpol[j]),Psi)+[0]*5 for i,j in mons2]
    evalrows=[[evalcols[j][i] for j in range(10)] for i in range(5)]
    for t in translations:
        M=tr(t['matrix']);c=t['square']
        comp=[]
        for j in range(10):
            u=[0]*10;u[j]=1;v=quad_comp(u,M);v[j]=sub(v[j],c);comp.append(v)
        invrows=tr(comp)
        assert len(null(invrows))==6
        ns=null(invrows+evalrows);assert len(ns)==1,(t['pair'],len(ns))
        v=normalize(ns[0]);t['quadric']=v
        t['node_values']=[qval(v,x) for x in tropes]
        assert quad_comp(v,M)==[mul(c,x) for x in v]
        assert all(dot(r,v)==0 for r in evalrows)
    return {'alpha':alpha,'beta':beta,'curve_coefficients':f,'Psi':Psi,'quadric_monomials':mons2,
            'quartic_monomials':mon4,'dual_Kummer':K,'dual_Kummer_nodes':tropes,'covers':translations}

if __name__=='__main__':
    from locations import certificate_dir
    HERE=certificate_dir()
    HERE.mkdir(parents=True,exist_ok=True)
    data=setup()
    with (HERE/'data.json').open('w') as fp:json.dump(data,fp,indent=2)
    print('beta=',beta,'F^5=',f,'Psi=',data['Psi'])
    print('Kummer=',list(zip(data['quartic_monomials'],data['dual_Kummer'])))
    for t in data['covers']:
        print(t['pair'],'Q=',t['quadric'],'nodes=',[i for i,x in enumerate(t['node_values']) if not x])
