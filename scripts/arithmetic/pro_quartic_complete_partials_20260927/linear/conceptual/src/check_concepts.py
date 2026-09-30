"""Exact diagnostics of new formulas and an ambient example, NOT a source search."""
from __future__ import annotations
import hashlib,json,platform,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
import field as F
import poly as U
import evaluate as E
import cube_free as CF
import polynomial_model as PM

def sumc(*args):
    r=U.zero()
    for a in args:r=U.cadd(r,a)
    return r

def adj(a):
    A,B,C=a
    return [U.sub(U.mul(A,A),U.mul(U.mul(B,C),E.P)),
            U.sub(U.mul(U.mul(C,C),E.P),U.mul(A,B)),
            U.sub(U.mul(B,B),U.mul(A,C))]

def univariate_xgcd(a,b):
    aa,bb=a,b;s0,s1=[1],[];t0,t1=[],[1]
    while bb:
        q,r=U.divmodp(aa,bb)
        aa,bb=bb,r;s0,s1=s1,U.sub(s0,U.mul(q,s1));t0,t1=t1,U.sub(t0,U.mul(q,t1))
    z=F.inv(aa[-1])
    return U.scale(aa,z),U.scale(s0,z),U.scale(t0,z)

def theta_for(dic,lam):
    g2,g3,g4,g5,qbar=E.barred(dic)
    rr=E.resultant(U.cscale(g2,3),U.cscale(g3,2),g4,g5,qbar,
                    [U.powp(E.t,3),[],[]], [U.scale([F.neg(9),1],lam),[],[]])
    theta=[U.exactdiv(p,U.mul(U.powp(E.t,5),[F.neg(9),1])) for p in rr]
    return theta

def theta_model(H,q,mu):
    dat=PM.DATA;dd=F.add(47171,F.mul(357608,q))
    ng=[CF.evaluate(CF.fromdata(dat['barred_numerators']['g'+str(i)]),H,q) for i in range(2,6)]
    Qstar=[[],U.scale(dat['Qbar_x_polynomial'],F.powk(q,2)),[]]
    ll=[U.scale([F.neg(9),1],F.mul(dd,F.mul(q,mu))),[],[]]
    C=[U.scale(U.powp(E.t,3),F.mul(dd,F.powk(q,4))),[],[]]
    U.set_curve(U.scale(E.P,F.inv(q)))
    try:
        rr=E.resultant(U.cscale(ng[0],3),U.cscale(ng[1],2),ng[2],ng[3],Qstar,C,ll)
        th=[U.scale(U.exactdiv(p,U.mul(U.powp(E.t,5),[F.neg(9),1])),F.powk(q,-5)) for p in rr]
        nm=U.norm(th)
    finally:U.set_curve(E.P)
    assert nm==PM.evaluate_polynomial(H,q,mu)
    return th

def diagnostics():
    rows=[]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        dic,_,fs,_=E.cramer(h,w)
        th=theta_for(dic,lam);R=E.residual(dic,lam)
        assert U.norm(th)==R
        assert U.pole(th)==140
        assert all(len(th[j])-1<=bound for j,bound in enumerate([46,43,40]))
        g2,g3,g4,g5,qbar=E.barred(dic)
        a=U.cscale(g2,3);b=U.cscale(g3,2);c=g4;d=g5
        Delta=sumc(U.cpow(b,2),U.cmul(a,c))
        original=sumc(U.cscale(U.cpow(dic['G3'],2),4),U.cscale(U.cmul(dic['G2'],dic['G4']),3))
        assert [U.exactdiv(p,U.powp(E.P,2)) for p in original]==Delta
        assert U.pole(Delta)==32 and U.coeff(Delta[2],4)==F.scale(F.powk(E.EPS,2),4)
        t0=theta_for(dic,0);tp=theta_for(dic,1);tm=theta_for(dic,4)
        t1=U.cscale(U.csub(tp,tm),F.inv(2))
        t2=U.cscale(U.csub(U.cadd(tp,tm),U.cscale(t0,2)),F.inv(2))
        assert th==sumc(t0,U.cscale(t1,lam),U.cscale(t2,F.powk(lam,2)))
        T=sumc(U.cpow(c,5),U.cscale(U.cmul(qbar,U.cpow(b,5)),4),U.cmul(U.cpow(qbar,2),U.cpow(a,5)))
        UU=U.csub(U.cscale(U.cmul(qbar,U.cpow(a,5)),2),U.cpow(b,5))
        KK=sumc(U.cmul(U.cpow(a,3),qbar),U.cmul(d,Delta),U.cscale(U.cmul(b,U.cpow(c,2)),2))
        Gamma=sumc(U.cmul(T,KK),U.cmulpoly(U.cmul(Delta,UU),U.powp(E.t,3)))
        disc=U.csub(U.cpow(t1,2),U.cscale(U.cmul(t2,t0),4))
        assert U.cmulpoly(disc,U.powp(E.t,10))==U.cmul(U.cpow(Delta,3),U.cpow(Gamma,2))
        assert U.cmulpoly(t2,U.powp(E.t,5))==U.cmulpoly(U.cpow(T,2),[F.neg(9),1])
        q=F.powk(w,3);H=F.div(h,w);mu=F.div(lam,w);dd=F.add(47171,F.mul(357608,q))
        thstar=theta_model(H,q,mu)
        scalar=F.mul(F.powk(w,49),F.powk(dd,12))
        assert thstar==[U.scale(th[j],F.mul(scalar,F.powk(w,j))) for j in range(3)]
        rows.append({'h':h,'w':w,'lambda':lam,'theta_norm_equals_R':True,
                     'theta_character_degrees':[len(p)-1 for p in th], 'Delta_pole':U.pole(Delta),
                     'scale_discriminant_identity':True,'quadratic_leading_twist':True,
                     'theta_star_norm_equals_model':True,'theta_star_scaling':True})
        if h==w==lam==1:
            (ROOT/'conceptual/data/diagnostic_upstairs.json').write_text(json.dumps(
               {'scope':'existing diagnostic (1,1,1), NOT a square point','Theta':th,'Delta':Delta,
                'theta_scale_coefficients':[t0,t1,t2]},separators=(',',':'))+'\n')
    return rows

def ambient_example():
    u=[[1],[0]*20+[1],[]]
    theta_square=U.cpow(u,2);theta_pair=adj(u)
    J=U.add([1],U.shift(E.P,60))
    assert U.norm(u)==J
    assert U.norm(theta_square)==U.mul(J,J)==U.norm(theta_pair)
    assert theta_pair==[[1],[0]*20+[4],[0]*40+[1]]
    gcd,s,t=univariate_xgcd(J,U.deriv(J))
    assert gcd==[1] and U.add(U.mul(s,J),U.mul(t,U.deriv(J)))==[1]
    assert U.gcd(J,E.P)==[1]
    result={'scope':'ambient L140 norm-square examples, NOT members certified in the source family',
            'u':u,'theta_square':theta_square,'theta_nonsquare_on_X':theta_pair,'J':J,
            'squarefree_J_bezout':{'s':s,'t':t,'identity':'s*J+t*J_derivative=1'},
            'degree_J':len(J)-1,'pole_each_theta':140,'branch_pair_count_of_second_theta':70,
            'second_theta_A4_quartic_genus':78}
    (ROOT/'conceptual/data/ambient_example.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
    return {'both_norm_identities':True,'J_squarefree_exact_bezout':True,'degree_J':70,
            'J_coprime_P':True,'not_an_admissible_family_witness':True}

def main():
    if sys.flags.optimize:raise RuntimeError('Do not use python -O')
    assert U.gcd(E.P,U.deriv(E.P))==[1]
    assert U.gcd(E.t,U.deriv(E.t))==[1]
    assert U.gcd(E.t,E.P)==[1]
    out={'scope':'four retained diagnostics and explicit ambient examples; no parameter search',
         'python':platform.python_version(), 't_squarefree_and_coprime_P':True,
         'diagnostics':diagnostics(),'ambient_example':ambient_example()}
    (ROOT/'conceptual/evidence/concept_checks.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out,indent=2))
if __name__=='__main__':main()
