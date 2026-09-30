"""Exact characteristic-five normalized square-root truncation, scale polynomial."""
from residual import *

def series_mul(a,b,n):
    c=[[] for _ in range(n)]
    for i,p in enumerate(a[:n]):
        if p:
            for j,q in enumerate(b[:n-i]):
                if q:c[i+j]=pa(c[i+j],pm(p,q))
    return c

def series_frob(a,p,n):
    c=[[] for _ in range(n)]
    for i,pol in enumerate(a):
        if i*p>=n:break
        rr=[0]*max(0,((len(pol)-1)*p+1))
        for j,co in enumerate(pol):rr[j*p]=power(co,p)
        c[i*p]=trim(rr)
    return c

def tails(rr,n=141):
    a=[trim(p) for p in normalized_a(rr,n)]
    a2=series_mul(a,a,n);a3=series_mul(a2,a,n)
    a63=series_mul(series_mul(a3,series_frob(a2,5,n),n),series_frob(a2,25,n),n)
    equations={i:a63[i] for i in range(71,min(n,125))}
    if n>125:
        a1pow125=series_frob([a[1]],125,1)[0]
        for i in range(125,n):equations[i]=pa(a63[i],scale(pm(a1pow125,a63[i-125]),2))
    return a,a63,equations

def verify_square_test(rr,scale_value):
    aa=[peval(p,scale_value) for p in normalized_a(rr)]
    # Ordinary coefficient recursion uses only the unit 2, not division by n.
    root=[1]
    for n in range(1,141):
        t0=0
        for j in range(1,n):t0=add(t0,mul(root[j],root[n-j]))
        root.append(div(sub(aa[n],t0),2))
    return root,not any(root[71:])

if __name__=='__main__':
    ts=time.time()
    z=json.loads((ROOT/'data/sample_residual.json').read_text());rr=z['Rbar_scale_ascending']
    a,a63,eq=tails(rr,74)
    gcd71_72,U,V=pxgcd(eq[71],eq[72])
    assert pa(pm(U,eq[71]),pm(V,eq[72]))==gcd71_72
    gcd123=pgcd(gcd71_72,eq[73])
    out={'q':z['q'],'u':z['u'],'C71':eq[71],'C72':eq[72],'C73':eq[73], 'gcd_C71_C72':gcd71_72,'bezout_U':U,'bezout_V':V,'gcd_first_three':gcd123}
    (ROOT/'data/sample_tails.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    print(json.dumps({'q':z['q'],'u':z['u'],'degrees':[len(eq[i])-1 for i in [71,72,73]],'gcd_C71_C72_degree':len(gcd71_72)-1,'gcd_first_three_degree':len(gcd123)-1,'a1':a[1],'seconds':round(time.time()-ts,3)}))
