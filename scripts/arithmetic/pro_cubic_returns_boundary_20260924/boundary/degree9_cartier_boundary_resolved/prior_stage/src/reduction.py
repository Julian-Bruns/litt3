"""Construct and certify all four geometric support reductions."""
from extension import *

def field_checks():
    def gcd(a,b):
        while b:a,b=b,pdiv(a,b)[1]
        return pscale(a,inv[a[-1]])
    def mpow(a,n,m):
        r=[1]
        while n:
            if n&1:r=pdiv(pmul(r,a),m)[1]
            a=pdiv(pmul(a,a),m)[1];n//=2
        return r
    def derivative(a):return trim([mul[(i+1)%5][a[i+1]] for i in range(len(a)-1)])
    assert gcd(P,derivative(P))==[1]
    assert gcd(A,derivative(A))==[1]
    assert gcd(P,A)==[1]
    assert derivative(Q)==pmul(P,ppow(A,2))
    _,rem=pdiv(padd(Q,pscale(ppow(B0,5),4)),ppow(P,2));assert not rem
    L=INPUT['L']
    assert not pdiv(padd(Q,pscale(ppow(L,5),4)),ppow(A,3))[1]
    # A quartic is irreducible if it has no factors of degree one or two.
    irred=[]
    for d in [1,2]:
        g=gcd(A,padd(mpow([0,1],25**d,A),[0,4]));assert g==[1];irred.append(g)
    assert mpow([0,1],25**4,A)==[0,1]
    assert modA==INPUT['extension_modulus_ascending_F25']
    t=25
    roots=[epow(t,25**i) for i in range(4)]
    assert len(set(roots))==4
    for a in roots:
        s=0
        for c in modA[::-1]:s=ea(em(s,a),c)
        assert s==0 and em(a,ei(a))==1
    # Field implementation cross-checks, including Frobenius on a finite basis.
    for a in [0,1,2,5,24,25,625,15625,123456,390624]:
        assert epow(a,25**4)==a
        if a:assert em(a,ei(a))==1
    return {'P_squarefree':True,'A_squarefree':True,'P_A_coprime':True,
            'Q_prime_equals_P_A_squared':True,'Q_minus_B0_fifth_divisible_P_squared':True,
            'Q_minus_L_fifth_divisible_A_cubed':True,'A_irreducible_degree':4,
            'irreducibility_gcds':irred,'omitted_roots':roots}

def finite_pole_data():
    summaries=[]
    for depth in range(1,5):
        cs,rs,M=matrix(depth);ker=nullspace(M)
        projection=[[v[i] for i,c in enumerate(cs) if c[0]==0] for v in ker]
        rr,piv=rref(projection);pb=[r for r in rr if any(r)]
        assert pb==INPUT['trace_pencil_basis']
        summaries.append({'depth':depth,'rows':len(rs),'columns':len(cs),
                          'rank':len(cs)-len(ker),'nullity':len(ker),'v_projection':pb})
    assert [s['nullity'] for s in summaries]==[7,12,19,28]
    assert len(cs)==128 and len(rs)==100 and len(ker)==28
    # Direct multiplication, independent of the nullspace construction.
    for z in ker:
        assert all(sum_base([mul[a][b] for a,b in zip(row,z)])==0 for row in M)
    return {'columns':cs,'rows':rs,'matrix':M,'kernel':ker,'summaries':summaries}

def sum_base(v):
    z=0
    for x in v:z=add[z][x]
    return z

def local_data(data,omitted_root):
    cs=data['columns'];ker=data['kernel'];L=INPUT['L']
    b3,rem=epd(modA,[en(omitted_root),1]);assert not rem
    b32=epp(b3,2)
    D,rem=epd(epa(Q,eps(epp(L,5),4)),epp(b3,3));assert not rem
    P3mod=epd(epp(P,3),b32)[1]
    rows=[(0,r,i) for r in range(3) for i in range(6)]+[(1,r,i) for r in range(3) for i in range(3)]
    idx={a:i for i,a in enumerate(rows)};MM=[[0]*29 for _ in rows]
    c0=[epp(eps(L,4),4-j) for j in range(5)]
    c1=[eps(epp(eps(L,4),3-j),4-j) for j in range(4)]+[[]]
    for z,k in enumerate(ker):
        M0=[[],[],[]];M1=[[],[],[]]
        for val,(j,r,i) in zip(k,cs):
            if val:
                M0[r]=epa(M0[r],[0]*i+eps(c0[j],val))
                M1[r]=epa(M1[r],[0]*i+eps(c1[j],val))
        for r in range(3):
            for i,x in enumerate(epd(epm(D,M0[r]),b32)[1]):MM[idx[(0,r,i)]][z]=x
            for i,x in enumerate(epd(M1[r],b3)[1]):MM[idx[(1,r,i)]][z]=x
    for i,x in enumerate(P3mod):MM[idx[(0,0,i)]][28]=x
    ns=ens(MM);assert len(ns)==3
    for z in ns:assert all(sumf([em(a,b) for a,b in zip(row,z)])==0 for row in MM)
    full=[expand(a[:28],ker)+[a[28]] for a in ns]
    normal,pivots=err(full)
    assert pivots==[0,1,12]
    assert normal[0][:4]==INPUT['trace_pencil_basis'][0]
    assert normal[1][:4]==INPUT['trace_pencil_basis'][1]
    assert normal[2][:4]==[0,0,0,0] and normal[2][-1]==0
    # Precisely one y-dependent basis vector; no y^2 components survive.
    for k,row in enumerate(normal):
        for (j,r,i),v in zip(cs,row):
            if v:assert r==(1 if k==2 else 0)
    ex=em(en(normal[0][-1]),ei(normal[1][-1]))
    return {'omitted_root':omitted_root,'modulus':modA,'b3':b3,'D':D,
            'rows':rows,'matrix':MM,'kernel':ns,'rank':26,
            'full_kernel':full,'normal_basis':normal,'pivots':pivots,
            'kappa_lambda':normal[0][-1],'kappa_mu':normal[1][-1],
            'excluded_ratio_mu_over_lambda':ex}

def all_reductions():
    field=field_checks();finite=finite_pole_data()
    locals_=[local_data(finite,t) for t in field['omitted_roots']]
    for i,r in enumerate(locals_):
        power=25**i
        assert r['normal_basis']==[[epow(x,power) for x in row] for row in locals_[0]['normal_basis']]
    assert locals_[0]['kappa_lambda']==347224
    assert locals_[0]['kappa_mu']==249499
    assert locals_[0]['excluded_ratio_mu_over_lambda']==309462
    return field,finite,locals_
