"""Exact discriminant certificate for the nu=0 subfamily.

The identity is certified on a 337 by 17 product grid. This is a polynomial
identity certificate, NOT a search for geometric witnesses. Its degree bounds
are (336,16), as proved in REPORT.md.
"""
from extension import *

def ev(p,x):
    r=0
    for a in p[::-1]:r=ea(em(r,x),a)
    return r

def resultant(a,b):
    a=trim(a[:]);b=trim(b[:]);res=1
    while True:
        if not b:return 0
        m=len(a)-1;n=len(b)-1
        if n==0:return em(res,epow(b[0],m))
        _,r=epd(a,b)
        if not r:return 0
        k=len(r)-1
        fac=epow(b[-1],m-k)
        if (m*n)%2:fac=en(fac)
        res=em(res,fac);a,b=b,r

def disc(a,formal_degree=9):
    """Binary/formal degree-n discriminant, also when the leading term vanishes.
    In particular Disc_n(0,a_(n-1),...) = a_(n-1)^2 Disc_(n-1).
    """
    a=trim(a[:]);n=len(a)-1
    if n<formal_degree-1:return 0
    if n==formal_degree-1:return em(epow(a[-1],2),disc(a,n))
    if n<=1:return 1
    b=trim([em((i+1)%5,a[i+1]) for i in range(n)])
    r=em(resultant(a,b),ei(a[-1]))
    return en(r) if n*(n-1)//2%2 else r

def determinant(M):
    M=[r[:] for r in M];ans=1;n=len(M)
    for c in range(n):
        pivot=next((i for i in range(c,n) if M[i][c]),None)
        if pivot is None:return 0
        if pivot!=c:M[c],M[pivot]=M[pivot],M[c];ans=en(ans)
        a=M[c][c];ans=em(ans,a);ia=ei(a)
        for i in range(c+1,n):
            if M[i][c]:
                b=em(M[i][c],ia)
                for j in range(c+1,n):M[i][j]=es(M[i][j],em(b,M[c][j]))
                M[i][c]=0
    return ans

def sylvester_resultant(a,b):
    a=trim(a[:]);b=trim(b[:]);m=len(a)-1;n=len(b)-1
    if not a or not b:return 0
    M=[]
    for i in range(n):M.append([0]*i+a[::-1]+[0]*(n-1-i))
    for i in range(m):M.append([0]*i+b[::-1]+[0]*(m-1-i))
    return determinant(M)

def polys(row,cs,r):
    out=[]
    for j in range(5):
        p=[]
        for (h,s,i),v in zip(cs,row):
            if h==j and s==r:
                if len(p)<=i:p += [0]*(i+1-len(p))
                p[i]=v
        out.append(trim(p))
    return out

def interpolate(xs,ys):
    p=[];basis=[1]
    for x,y in zip(xs,ys):
        c=em(es(y,ev(p,x)),ei(ev(basis,x)))
        p=epa(p,eps(basis,c));basis=epm(basis,[en(x),1])
    return p

def discriminant_data(finite,local):
    cs=finite['columns'];br=local['normal_basis'];b3=local['b3']
    N=[polys(row,cs,0) for row in br[:2]]
    xs=[x for x in range(500) if ev(P,x) and ev(b3,x)][:337]
    ts=[x for x in range(50) if ea(20,em(x,11))][:17]
    assert len(xs)==337 and len(ts)==17
    def polynomial(x,t):
        ns=[ea(ev(N[0][j],x),em(t,ev(N[1][j],x))) for j in range(5)]
        kap=ea(br[0][-1],em(t,br[1][-1]))
        m=epm([ev(Q,x),0,0,0,0,1],ns[::-1])
        m[0]=ea(m[0],em(kap,em(epow(ev(b3,x),3),epow(ev(P,x),3))))
        return trim(m)
    def val(x,t):
        den=em(epow(ev(P,x),24),epow(ev(b3,x),20))
        return em(disc(polynomial(x,t)),ei(den))
    values=[[val(x,t) for x in xs] for t in ts]
    px=[interpolate(xs[:37],v[:37]) for v in values]
    coeffs=[interpolate(ts,[p[i] if i<len(p) else 0 for p in px]) for i in range(37)]
    assert max(map(len,coeffs))<=17
    for t,row in zip(ts,values):
        p=[ev(c,t) for c in coeffs]
        for x,value in zip(xs,row):assert ev(p,x)==value
    # Independent determinant algorithm on 24 nondegenerate grid polynomials.
    sylvester_checks=[]
    for t in ts:
        for x in xs:
            a=polynomial(x,t)
            if len(a)!=10:continue
            der=trim([em((i+1)%5,a[i+1]) for i in range(9)])
            r=resultant(a,der);s=sylvester_resultant(a,der);assert r==s
            sylvester_checks.append([x,t,r])
            if len(sylvester_checks)==24:break
        if len(sylvester_checks)==24:break
    return {'chart':'lambda=1, mu=t_parameter, nu=0; parameter is NOT the omitted-root t',
            'x_degree_bound_delta':36,'parameter_degree_bound_delta':16,
            'numerator_x_degree_bound':336,'identity_grid_x':xs,'identity_grid_parameter':ts,
            'identity_grid_delta_values':values,'coefficients_x_ascending_then_parameter_ascending':coeffs,
            'checked_identity_grid_points':337*17,'independent_sylvester_checks':sylvester_checks}
