"""Exact squarehood test for the entire constant-v degree-138 stratum.
Uses the finite parameter algebra, not a bounded search over field elements.
"""
from extarith import *
from residual import adapted_basis,combine,deserialize,ROOT
from infinity_series import deserialize_poly
import json,time

FORM=json.loads((ROOT/'data'/'resultant_inverse_kappa.json').read_text())

def eval_fp_at(p,s):
    r=E()
    for c in reversed(FP(p).c):r=r*s+E(c)
    return r

def weighted_eval(poly,sv,lam,weight=2,totalweight=2):
    r=E()
    for e,c in poly.items():
        assert e[2]==e[3]==0
        n=e[0]+weight*e[1]-totalweight;assert n%3==0
        r+=E(c.v)*(sv**(n//3))*(lam**e[1])
    return r

def build_constant_context():
    j=json.loads((ROOT/'data'/'constant_deep_boundary.json').read_text())
    wpoly=FP(j['eliminants'][0])//x**4
    assert all(not c or i%3==0 for i,c in enumerate(wpoly.c))
    g=FP([wpoly[3*i] for i in range(wpoly.deg//3+1)]).monic()
    assert g.gcd(g.derivative())==1 and g[0]
    setup(g.c);sv=E([0,1]);Sinv=sv.inverse()
    aa=FP(j['A']);bb=FP(j['B']);assert set(i for i,c in enumerate(aa.c) if c)=={4,7}
    assert all(not c or i%3==0 for i,c in enumerate(bb.c))
    BS=FP([bb[3*i] for i in range(bb.deg//3+1)])
    lam=-eval_fp_at(BS,sv)/(sv**2*(E(aa[7])*sv+E(aa[4])))
    j2=json.loads((ROOT/'data'/'degree_strata_0.json').read_text())
    pbar=weighted_eval(deserialize_poly(j2['p_solution']),sv,lam)
    qbar=weighted_eval(deserialize_poly(j2['q_solution']),sv,lam)
    ep=-E(fdiv(mul(2,219628),epsilon))-E(fdiv(mul(eta,epsilon),mul(24,2)))*Sinv
    fp=-E(inv(epsilon))-E(mul(fdiv(8,24),power(fdiv(2,epsilon),5)))*sv
    s=json.loads((ROOT/'data'/'linear_spaces.json').read_text())['spaces'][0]
    right,ker,_=adapted_basis(s);No,_,_=deserialize(s['origin']);cols=[]
    for col in right+ker:
        Ns,_,_=combine(s,col);cols.append([nn-no for nn,no in zip(Ns,No)])
    Hs=[]
    for i in range(2,6):
        assert not cols[0][i][0] and not cols[0][i][2]
        assert not cols[2][i][1] and not cols[2][i][2]
        for j in [1,3,4,5,6]:assert not cols[j][i][0] and not cols[j][i][1]
        c2=EP()
        for val,j in zip([lam,ep,fp,pbar,qbar],[1,3,4,5,6]):c2+=EP(cols[j][i][2])*EP(val)
        Hs.append(ER([EP(cols[2][i][0]),EP(cols[0][i][1]),c2*EP(sv)]))
    ER.curveP=EP(P)*EP(Sinv)
    return g,sv,lam,pbar,qbar,Hs

def inverse_kappa_resultant(Hs,v=FP(1)):
    vals=list(Hs)+[ER(Q),ER([0,EP(t**3*P**3),0]),ER(v)]
    powers=[]
    for j,a in enumerate(vals):
        m=max(e[j] for e,c in FORM['terms']);po=[ER(1)]
        for i in range(1,m+1):
            if i==5:po.append(a.frob())
            elif i>5:po.append(po[5]*po[i-5])
            else:po.append(po[-1]*a)
        powers.append(po)
    out=[ER(),ER(),ER()]
    for it,(es,c) in enumerate(FORM['terms']):
        z=ER(c)
        for j,e in enumerate(es[:-1]):
            if e:z=z*powers[j][e]
        out[es[-1]]+=z
    return out

def tmul(a,b):
    o=[EP()]*(len(a)+len(b)-1)
    for i,u in enumerate(a):
        for j,v in enumerate(b):o[i+j]=o[i+j]+u*v
    return o

def norm_quadratic(rr):
    a,b,c=[[r[j] for r in rr] for j in range(3)]
    aaa=tmul(tmul(a,a),a);bbb=tmul(tmul(b,b),b);ccc=tmul(tmul(c,c),c);abc=tmul(tmul(a,b),c)
    pp=ER.curveP;pp2=pp*pp
    return [aaa[i]+bbb[i]*pp+ccc[i]*pp2-abc[i]*pp*EP(3) for i in range(7)]

def square_equations(rcoeff,expected_degree,number_of_errors=2):
    n=expected_degree//2
    assert max(r.deg for r in rcoeff)==expected_degree
    assert all(not r[expected_degree] for r in rcoeff[1:])
    lc=rcoeff[0][expected_degree];lci=lc.inverse()
    Rrows=[EP([r[i]*lci for r in rcoeff]) for i in range(expected_degree+1)]
    J=[EP()]*(n+1);J[n]=EP(1)
    for k in range(1,n+1):
        target=2*n-k;s=EP()
        for i in range(n-k+1,n+1):
            ii=target-i
            if i<=ii<=n:s+=(J[i]*J[ii])*(EP(1) if i==ii else EP(2))
        J[n-k]=(Rrows[target]-s)*EP(3)
    errors=[]
    for target in range(n-1,max(-1,n-1-number_of_errors),-1):
        q=EP()
        for i in range(n+1):
            ii=target-i
            if i<=ii<=n:q+=(J[i]*J[ii])*(EP(1) if i==ii else EP(2))
        errors.append(Rrows[target]-q)
    return lc,J,errors

def main():
    start=time.monotonic();g,sv,lam,pbar,qbar,Hs=build_constant_context()
    print('Finite parameter algebra dimension',g.deg,'setup seconds',time.monotonic()-start,flush=True)
    rr=inverse_kappa_resultant(Hs)
    print('Quadratic resultant computed seconds',time.monotonic()-start,flush=True)
    nm=norm_quadratic(rr)
    den=EP(P**40*t**15);rc=[p//den for p in nm]
    print('Residual inverse-kappa coefficient x-degrees',[p.deg for p in rc],'seconds',time.monotonic()-start,flush=True)
    lc,J,errors=square_equations(rc,138)
    print('Square error degrees',[e.deg for e in errors[:4]],'seconds',time.monotonic()-start,flush=True)
    gcd,S,T=errors[0].xgcd(errors[1]);assert errors[0]*S+errors[1]*T==gcd
    print('First two error gcd degree',gcd.deg,'seconds',time.monotonic()-start,flush=True)
    data={'status':'partial until all final assertions pass','parameter_modulus':list(g.c),'s_element':list(sv.c),'lambda':list(lam.c),'pbar':list(pbar.c),'qbar':list(qbar.c),'Hbar':[h.data() for h in Hs],'inverse_kappa_R_coefficients':[r.data() for r in rc],'leading_coefficient':list(lc.c),'monic_root_coefficients':[z.data() for z in J],'first_two_errors':[z.data() for z in errors[:2]],'gcd':gcd.data(),'bezout':[S.data(),T.data()]}
    if gcd==1:data['status']='geometrically excluded, all constant-v degree-138 points'
    elif all(not gcd[i] for i in range(gcd.deg)):
        data['status']='geometrically excluded for nonzero inverse-kappa; gcd is a monomial'
    else:data['status']='not excluded by first two errors'
    (ROOT/'data'/'constant_138_square.json').write_text(json.dumps(data,indent=2)+'\n')
    print(data['status'],flush=True)

if __name__=='__main__':main()
