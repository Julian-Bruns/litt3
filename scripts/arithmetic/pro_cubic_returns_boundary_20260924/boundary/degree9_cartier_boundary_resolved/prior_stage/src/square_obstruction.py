"""Univariate ideal/saturation certificate excluding every geometric parameter
in the nu=0 subfamily. No finite-field witness search is performed.
"""
from discriminant import *

def pgcd(a,b):
    while b:a,b=b,epd(a,b)[1]
    return eps(a,ei(a[-1])) if a else []

def strip_leading_roots(g,l):
    while g:
        h=pgcd(g,l)
        if len(h)<=1:break
        g,r=epd(g,h);assert not r
    return eps(g,ei(g[-1])) if g else []

def direct_square(a):
    a=trim(a[:]);n=len(a)-1
    if n<0:return False,{'reason':'zero discriminant'}
    if n%2:return False,{'reason':'odd degree','degree':n}
    aa=eps(a,ei(a[-1]));d=n//2;u=[1]
    for j in range(1,d+1):
        s=sumf([em(u[r],u[j-r]) for r in range(1,j)])
        u.append(em(3,es(aa[n-j],s)))
    sq=epp(u[::-1],2);rem=epa(aa,eps(sq,4))
    return not rem,{'degree':n,'monic_sqrt_trial':u[::-1],'remainder':rem}

def square_data(data,local):
    aa=data['coefficients_x_ascending_then_parameter_ascending'];L=aa[-1];d=18
    U=[[1]];lp=[[1]];g=[];checks=[]
    for j in range(1,2*d+1):lp.append(epm(lp[-1],L))
    for j in range(1,d+1):
        s=[]
        for r in range(1,j):s=epa(s,epm(U[r],U[j-r]))
        U.append(eps(epa(epm(aa[36-j],lp[j-1]),eps(s,4)),3))
    # Just two necessary coefficients already give the unit ideal after saturation.
    for j in [19,20]:
        s=[]
        for r in range(max(0,j-d),min(d,j)+1):s=epa(s,epm(U[r],U[j-r]))
        F=epa(epm(aa[36-j],lp[j-1]),eps(s,4))
        raw=pgcd(g,F);g=strip_leading_roots(raw,L)
        checks.append({'j':j,'constraint':F,'raw_gcd':raw,'saturated_gcd':g})
    assert g==[1]
    exceptional=pgcd(L,aa[35])
    kappa_monic=[em(local['kappa_lambda'],ei(local['kappa_mu'])),1]
    assert exceptional==epp(kappa_monic,5)
    assert exceptional==[264747,0,0,0,0,1]
    excluded=local['excluded_ratio_mu_over_lambda']
    assert ev(kappa_monic,excluded)==0
    assert all(ev(p,excluded)==0 for p in aa)
    at_infinity=[p[16] if len(p)>16 else 0 for p in aa]
    ok,trial=direct_square(at_infinity);assert not ok and trial['degree']==36
    assert len(trial['remainder'])==18 and trial['remainder'][-1]==375984
    return {'leading_coefficient_a36':L,'scaled_monic_sqrt_coefficients_U':U,
            'constraints':checks,'open_leading_final_saturated_gcd':g,
            'gcd_a36_a35':exceptional,'monic_kappa':kappa_monic,
            'excluded_parameter':excluded,'delta_zero_at_kappa_zero':True,
            'lambda_zero_mu_one':{'square':ok,**trial},
            'conclusion':'No geometric [lambda:mu] with kappa != 0 makes delta a square. Hence nu=0 has no actual etale witness.'}
