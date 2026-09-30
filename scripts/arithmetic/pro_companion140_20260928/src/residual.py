"""Actual fixed-(10,2) critical resultant and cubic norm, no degree-drop division.
The auxiliary curve variable zeta has zeta^3=P/q, and G_i=w*barG_i.
Returned Rbar=Rcal/q^25. Thus its normalized reciprocal polynomial
has exactly the same normalized square tails as the requested residual.
"""
from source import *
from laurent import LP

class Curve:
    __slots__=('cs',)
    PQ=None
    def __init__(self,a=0):
        if isinstance(a,Curve):self.cs=a.cs
        elif isinstance(a,list):self.cs=[trim(list(x)) for x in a]
        else:self.cs=[[a%5] if a%5 else [],[],[]]
    @staticmethod
    def scalar(c):return Curve([[c] if c else [],[],[]])
    @staticmethod
    def xp(a):return Curve([a,[],[]])
    def __add__(a,b):
        b=Curve(b);return Curve([pa(x,y) for x,y in zip(a.cs,b.cs)])
    __radd__=__add__
    def __neg__(a):return Curve([pn(x) for x in a.cs])
    def __sub__(a,b):return a+-Curve(b)
    def __rsub__(a,b):return -a+b
    def __mul__(a,b):
        b=Curve(b);r=[[],[],[]]
        for i,x in enumerate(a.cs):
            for j,y in enumerate(b.cs):
                if not x or not y:continue
                p=pm(x,y)
                if i+j>=3:p=pm(p,Curve.PQ)
                r[(i+j)%3]=pa(r[(i+j)%3],p)
        return Curve(r)
    __rmul__=__mul__
    def __pow__(a,n):
        r=Curve(1)
        while n:
            if n&1:r=r*a
            n>>=1
            if n:a=a*a
        return r
    def __eq__(a,b):return a.cs==Curve(b).cs
    def __bool__(a):return any(a.cs)

def parameters(q,u):
    cr=json.loads((ROOT/'data/cramer.json').read_text())
    D=0
    for i,j,c in cr['kernel_determinant']:
        assert i==0 and (j-2)%3==0
        D=add(D,mul(c,power(q,(j-2)//3)))
    if not q or not u or not D:raise ValueError('outside source chart')
    def transform(terms,extra):
        z=0
        for i,j,c in terms:
            assert (j-2*i+extra)%3==0
            z=add(z,mul(c,mul(power(u,i),power(q,(j-2*i+extra)//3))))
        return z
    E=transform(cr['e'],1)
    FF=transform(cr['f'],1)
    K0=div(transform(cr['kernel0_numerator'],-1),D)
    K1=div(transform(cr['kernel1_numerator'],-1),D)
    return [1,div(u,q),1,E,FF,K0,K1]

def source_bar(q,u):
    pars=parameters(q,u)
    data=json.loads((ROOT/'data/affine_source.json').read_text())['source_G']
    gs=[Curve([[ ],[],[]]) for _ in range(4)]
    for i,sc in enumerate(pars):
        for j in range(4):
            gs[j]=gs[j]+Curve([scale(p,sc) for p in data[i][j]])
    return gs

def critical_resultant(gs,EV,QV,V):
    """Returns [lambda^0,lambda^1,lambda^2] with arbitrary commutative-ring inputs."""
    A,B,C,D=3*gs[0],2*gs[1],gs[2],gs[3]
    # A^n tr(Z^n), for the quadratic A Z^2+B Z+C.
    U=[2,-B]
    for n in range(2,8):U.append(-B*U[-1]-A*C*U[-2])
    K0=C**5-QV*B**5+A**5*QV**2
    Nv=A**2*D**2+A*(C**3-B*C*D)+B**3*D+2*B**2*C**2
    TrV=B**3-A*B*C+2*A**2*D
    X=C**2*(B*U[3]-U[4])+D*U[5]+QV*A**3*TrV
    T=B**10-2*A**5*C**5-2*A**5*B**5*QV+2*A**10*QV**2
    Y=A**3*B*U[7]-A**4*C*U[6]+A**5*D*U[5]+A**8*QV*B*U[2]-A**9*QV*C*U[1]+2*A**10*QV*D
    return [A**3*K0*Nv+EV*Y+EV**2*A**10,V*(K0*X+EV*T),V**2*K0**2]

# A polynomial in scale with K[x] coefficients.
def mpa(a,b):
    c=list(a)+[[] for _ in range(max(0,len(b)-len(a)))]
    for i,p in enumerate(b):c[i]=pa(c[i],p)
    return c

def mps(a,b):return mpa(a,[pn(p) for p in b])
def mpm(a,b):
    c=[[] for _ in range(len(a)+len(b)-1)]
    for i,p in enumerate(a):
        for j,q in enumerate(b):c[i+j]=pa(c[i+j],pm(p,q))
    return c

def mpx(a,x):return [pm(p,x) for p in a]

def residual(q,u,check=True):
    Curve.PQ=scale(P,inv(q))
    gs=source_bar(q,u)
    E=Curve([[],T3P3,[]])
    co=critical_resultant(gs,E,Curve.xp(Q),Curve.xp(v))
    a,b,c=[[co[i].cs[j] for i in range(3)] for j in range(3)]
    norm=mpa(mpa(mpm(mpm(a,a),a),mpx(mpm(mpm(b,b),b),Curve.PQ)),mpx(mpm(mpm(c,c),c),pm(Curve.PQ,Curve.PQ)))
    norm=mps(norm,mpx(mpm(mpm(a,b),c),scale(Curve.PQ,3)))
    denominator=pm(ppow(P,40),pm(ppow(t,15),ppow(v,3)))
    rr=[]
    for pol in norm:
        quo,rem=pdm(pol,denominator)
        assert not rem,'fixed denominator does not divide norm'
        rr.append(quo)
    assert len(rr[0])==141 and all(len(p)<=140 for p in rr[1:])
    if check:
        aa,bb,cc,ee,dd=[peval(I[k],q) for k in ['a0','b','c','e','d']]
        s=div(add(add(aa,div(bb,u)),add(div(cc,power(u,2)),div(ee,power(u,3)))),dd)
        expect=mul(power(mul(3,power(EPS,8)),3),div(mul(power(s,3),power(u,18)),power(q,24)))
        assert rr[0][-1]==expect,('leading coefficient discrepancy',rr[0][-1],expect)
    return rr

def normalized_a(rr,n=141):
    lead=rr[0][140]
    assert lead
    return [[div(rr[j][140-i],lead) if 140-i<len(rr[j]) else 0 for j in range(7)] for i in range(n)]

def companion(q):
    b,c,e=[peval(I[k],q) for k in ['b','c','e']]
    C=sub(mul(c,c),mul(3,mul(b,e)))
    D=sub(mul(c,c),mul(4,mul(b,e)))
    if not C or not D or not b or not e:return []
    # Returns both sheets only when the quadratic splits over K.
    if LOG[C]%2:return []
    xi=EXP[LOG[C]//2]
    return [(div(mul(e,add(c,mul(3,x))),D),x) for x in [xi,neg(xi)]]

def find_allowed(start=1):
    for q in range(start,N):
        if q in I['excluded_q']:continue
        for u,xi in companion(q):
            dd=peval(I['d'],q)
            if not dd:continue
            aa,bb,cc,ee=[peval(I[k],q) for k in ['a0','b','c','e']]
            s=div(add(add(aa,div(bb,u)),add(div(cc,power(u,2)),div(ee,power(u,3)))),dd)
            if s:return q,u,xi,s
    raise ValueError('no K point found')

if __name__=='__main__':
    import argparse
    ap=argparse.ArgumentParser();ap.add_argument('--q',type=int);ap.add_argument('--u',type=int);ap.add_argument('--output');args=ap.parse_args()
    ts=time.time()
    if args.q is None:q,u,xi,s=find_allowed()
    else:q,u=args.q,args.u;xi=s=None
    rr=residual(q,u)
    out={'q':q,'u':u,'xi':xi,'s':s,'Rbar_scale_ascending':rr}
    name=args.output or 'data/sample_residual.json'
    (ROOT/name).write_text(json.dumps(out,separators=(',',':'))+'\n')
    print(json.dumps({'q':q,'u':u,'scale_degrees_x':[len(p)-1 for p in rr],'leading_coefficient':rr[0][-1],'denominator_division':'exact','leading_formula':'PASS','seconds':round(time.time()-ts,3)}))
