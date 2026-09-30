"""Exact companion identities and the global leading-square-tail boundary.
This file does NOT decide the full companion square ideal.
"""
from tails import *
import math

def disc_sigma(sigma):
    a=ps(I['a0'],scale(I['d'],sigma));b,c,e=[I[k] for k in ['b','c','e']]
    return pa(pa(pm(ppow(b,2),ppow(c,2)),pm(a,ppow(c,3))),pa(pm(ppow(b,3),e),pa(scale(pm(ppow(a,2),ppow(e,2)),3),scale(pm(pm(a,b),pm(c,e)),3))))

def lc72(q,u,s):
    m=div(power(q,7),power(u,9))
    U=div(mul(power(Q[-1],6),m),power(s,3))
    V=mul(mul(2,power(EPS,6)),m)
    return mul(2,mul(power(mul(U,V),5),mul(power(sub(U,V),2),power(add(U,V),6))))

def ddf_degrees(f):
    f=scale(f,inv(f[-1]));x=[0,1];h=x;d=1;out=[]
    while 2*d<=len(f)-1:
        h=ppow(h,N,f)
        g=pgcd(f,ps(h,x))
        if len(g)>1:
            out += [d]*((len(g)-1)//d)
            f=pdm(f,g)[0]
            if len(f)>1:h=pdm(h,f)[1]
        d+=1
    if len(f)>1:out.append(len(f)-1)
    return sorted(out)

def run():
    ts=time.time()
    binomial_row=trim([(math.comb(63,j)*math.comb(63,18-j))%5 for j in range(19)])
    factor_row=scale(pm(ppow([0,1],5),pm(ppow([4,1],2),ppow([1,1],6))),2)
    assert binomial_row==factor_row
    C0=ps(ppow(I['c'],2),scale(pm(I['b'],I['e']),3))
    Delta=ps(ppow(I['c'],2),scale(pm(I['b'],I['e']),4))
    assert C0==I['C']
    b,c,e=[I[k] for k in ['b','c','e']]
    def qa(x,y):return [pa(x[0],y[0]),pa(x[1],y[1])]
    def qm(x,y):return [pa(pm(x[0],y[0]),pm(pm(x[1],y[1]),C0)),pa(pm(x[0],y[1]),pm(x[1],y[0]))]
    def qs(x,p):return [pm(x[0],p),pm(x[1],p)]
    tn=[scale(c,3),[1]]
    an=qa(qa(qs(tn,pn(pm(b,e))),qs(qm(tn,tn),pn(c))),qs(qm(qm(tn,tn),tn),[4]))
    Dsc=pa(ppow(c,3),scale(pm(pm(b,c),e),3))
    assert an==[pn(Dsc),C0]
    S0=pa(pm(I['a0'],ppow(e,2)),Dsc);S1=pn(C0);Sd=pm(I['d'],ppow(e,2))
    assert ps(ppow(S0,2),ppow(C0,3))==scale(pm(ppow(e,2),disc_sigma(0)),2)
    assert len(pgcd(C0,deriv(C0)))==1
    for name in ['b','e','c']:
        if name!='e':assert len(pgcd(Delta,I[name]))==1
    assert len(pgcd(Delta,I['e']))==1
    # c+3xi has norm 2 Delta; u^{-1}=(3c+xi)/e.
    # Check symbolic coefficients of 1 and xi in the product formula.
    assert ps(pa(scale(ppow(I['c'],2),3),scale(C0,3)),Delta)==[]
    assert ps(ps(ppow(I['c'],2),scale(C0,4)),scale(Delta,2))==[]
    sigma0=div(power(Q[-1],2),mul(3,power(EPS,2)))
    zeta6=EXP[N1//6]
    sigmas=[mul(sigma0,power(zeta6,i)) for i in range(6)]
    assert len(set(sigmas))==6
    product=[1];rows=[]
    for sig in sigmas:
        f=disc_sigma(sig)
        ss=ps(S0,scale(Sd,sig))
        assert ps(ppow(ss,2),ppow(C0,3))==scale(pm(ppow(e,2),f),2)
        assert len(f)==25
        sf=pdm(f,pgcd(f,deriv(f)))[0]
        fs=ddf_degrees(sf)
        a=ps(I['a0'],scale(I['d'],sig));b,c,e=[I[k] for k in ['b','c','e']]
        dn=pm(a,ps(ppow(b,2),scale(pm(a,c),3)))
        nu=ps(ps(pm(ppow(a,2),e),pm(pm(a,b),c)),ppow(b,3))
        gcd,di,unused=pxgcd(dn,f);assert gcd==[1]
        up=pdm(pm(nu,di),f)[1]
        gcd,ei,unused=pxgcd(e,f);assert gcd==[1]
        xp=pdm(pm(pa(scale(pm(Delta,up),2),scale(pm(c,e),3)),ei),f)[1]
        assert pdm(ps(ppow(xp,2),C0),f)[1]==[]
        assert pdm(ps(pm(C0,xp),ss),f)[1]==[]
        assert pdm(pa(pa(pm(Delta,ppow(up,2)),scale(pm(pm(c,e),up),3)),scale(ppow(e,2),2)),f)[1]==[]
        assert pdm(pa(pa(pa(pm(a,ppow(up,3)),pm(b,ppow(up,2))),pm(c,up)),e),f)[1]==[]
        rows.append({'sigma':sig,'discriminant':f,'squarefree_degree':len(sf)-1,'irreducible_factor_degrees':fs,
                     'selected_u_mod_discriminant':up,'xi_mod_discriminant':xp,'u_denominator':dn,'u_denominator_inverse_mod_discriminant':di})
        product=pm(product,f)
    assert len(product)==145
    licensed=[0,1]
    for p in [I['d'],I['b'],I['e'],Delta,I['C']]+[[neg(q),1] for q in I['excluded_q']+[1,2]]:
        licensed=pm(licensed,p)
    gcd,BU,BV=pxgcd(product,licensed);assert gcd==[1]
    assert pa(pm(BU,product),pm(BV,licensed))==[1]
    out={'sigma0':sigma0,'zeta6':zeta6,'s_numerator_constant':S0,'s_numerator_xi':S1,'s_denominator':Sd,'fibres':rows,'product_degree':144,'squarefree_product_degree':len(pdm(product,pgcd(product,deriv(product)))[0])-1,
         'Delta':Delta,'leading_boundary_product':product,'licensed_q_pole_product':licensed,'pole_bezout_U':BU,'pole_bezout_V':BV,'all_144_ratios_allowed':True,'K_rational_q_count':sum(r['irreducible_factor_degrees'].count(1) for r in rows)}
    (ROOT/'data/leading_tail_boundary.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    print(json.dumps({'C_matches':True,'C_squarefree':True,'linear_s_formula_and_norm':'PASS','companion_inverse_formula':'PASS','sigma0':sigma0,'zeta6':zeta6,'fibres':[{'sigma':r['sigma'],'degree':24,'factor_degrees':r['irreducible_factor_degrees']} for r in rows],'boundary_product_degree':144,'squarefree_product_degree':out['squarefree_product_degree'],'all_144_ratios_allowed':True,'K_rational_q_count':out['K_rational_q_count'],'constant_s_algebra_identities':'PASS','seconds':round(time.time()-ts,3)}))
if __name__=='__main__':run()
