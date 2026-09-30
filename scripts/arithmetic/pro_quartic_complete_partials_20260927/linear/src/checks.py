"""Independent fixed-degree checks and Frobenius-section rank diagnostics.
No bounded search is represented as a geometric decision.
"""
import json,time,random,sys
from pathlib import Path
import field as F
import poly as U
import evaluate as E
import cube_free as CF
from reconstruct import row_reduce,sumk
ROOT=Path(__file__).resolve().parents[1]

def determinant(rows):
    A=[r.copy() for r in rows];n=len(A);det=1
    for i in range(n):
        p=next((j for j in range(i,n) if A[j][i]),None)
        if p is None:return 0
        if p!=i:A[p],A[i]=A[i],A[p];det=F.neg(det)
        det=F.mul(det,A[i][i]);ai=F.inv(A[i][i])
        for j in range(i+1,n):
            a=F.mul(A[j][i],ai)
            if a:
                for k in range(i,n):A[j][k]=F.sub(A[j][k],F.mul(a,A[i][k]))
    return det

def sylvester(f,g,m=10,n=2):
    f=(f+[0]*(m+1))[:m+1];g=(g+[0]*(n+1))[:n+1]
    f=f[::-1];g=g[::-1];rows=[]
    for i in range(n):rows.append([0]*i+f+[0]*(n-1-i))
    for i in range(m):rows.append([0]*i+g+[0]*(m-1-i))
    return determinant(rows)

def universal_check():
    rng=random.Random(9262026);cases=[]
    # Cases deliberately include leading-degree drops, not just generic points.
    for a,b,l in [(1,2,3),(0,2,3),(0,0,3),(1,2,0),(0,2,0),(0,0,0)]:
        for _ in range(4):
            c,d,q,C=[rng.randrange(F.ORDER) for _ in range(4)]
            S=[d,c,F.scale(b,3),F.scale(a,2)]
            z5q=[q]+[0]*4+[1]
            f=U.add(U.add(U.scale(U.powp(z5q,2),l),U.mul(z5q,S)),[C])
            D=[c,b,a]
            direct=sylvester(f,D)
            args=[[[v],[],[]] for v in [a,b,c,d,q,C,l]]
            val=E.resultant(*args)
            assert not val[1] and not val[2]
            compact=U.coeff(val[0],0)
            assert direct==compact,(a,b,c,d,q,C,l,direct,compact)
            cases.append({'a':a,'b':b,'c':c,'d':d,'Q':q,'C':C,'l':l,'fixed_resultant':direct})
    return cases

def full_source_check(dic):
    # Verify the original binomial congruences (1) directly rather than only
    # the reduced matrix equations. Also verify every infinity inequality (3).
    from math import comb
    zero=U.zero();v=[F.neg(9),1]
    N=[ [v,[],[]],zero,dic['G2'],dic['G3'],dic['G4'],U.cadd(dic['G5'],[U.mul(v,E.Q),[],[]])]
    for j in range(1,6):
        ff=zero
        for i in range(j+1):
            coef=comb(5-i,j-i)%5
            ff=U.cadd(ff,U.cscale(U.cmulpoly(N[i],U.powp(U.neg(E.B),j-i)),coef))
        assert all(not p for p in U.cmod_y(ff,j)),j
    for j in range(11):
        ff=N[j] if j<6 else zero
        if 0<=j-5<6:ff=U.cadd(ff,U.cmulpoly(N[j-5],E.Q))
        if j==10:ff=U.cadd(ff,U.cmulpoly(U.cpow(U.monomial(0,1),10),U.powp(E.t,3)))
        assert U.pole(ff)<=10+12*j-max(0,j-5),(j,U.pole(ff))
    # Direct coefficient expansion in W for (2), modulo t^(5-j).
    qL=U.sub(E.Q,U.frob(E.L))
    for j in range(5):
        nn=zero
        for i in range(6):
            if j<=5-i:
                nn=U.cadd(nn,U.cscale(U.cmulpoly(N[i],U.powp(U.neg(E.L),5-i-j)),comb(5-i,j)%5))
        ff=U.cmulpoly(nn,qL)
        if j==0:ff=U.cadd(ff,U.cmulpoly(U.cpow(U.monomial(0,1),10),U.powp(E.t,3)))
        assert all(not p for p in U.crem_poly(ff,U.powp(E.t,5-j))),j
    assert U.pole(dic['D2'])==13 and U.evalp(dic['D2'][0],9)==0
    return True

def cube_free_residual(H,q,mu):
    dat=json.loads((ROOT/'data/cube_free.json').read_text())
    dd=F.add(47171,F.mul(357608,q))
    ng=[CF.evaluate(CF.fromdata(dat['barred_numerators']['g'+str(i)]),H,q) for i in range(2,6)]
    Qstar=[[],U.scale(dat['Qbar_x_polynomial'],F.powk(q,2)),[]]
    ll=U.scale([F.neg(9),1],F.mul(dd,F.mul(q,mu)))
    C=U.scale(U.powp(E.t,3),F.mul(dd,F.powk(q,4)))
    U.set_curve(U.scale(E.P,F.inv(q)))
    try:
        rr=E.resultant(U.cscale(ng[0],3),U.cscale(ng[1],2),ng[2],ng[3],Qstar,[C,[],[]],[ll,[],[]])
        nr=U.norm(rr)
        quot=U.exactdiv(nr,U.mul(U.powp(E.t,15),U.powp([F.neg(9),1],3)))
        result=U.scale(quot,F.mul(F.powk(q,-51),F.powk(dd,-36)))
    finally:U.set_curve(E.P)
    return result

def rank(A):
    return len(row_reduce([r+[0] for r in A],len(A[0]))[1]) if A else 0

def section_matrix(R):
    power=U.mul(U.powp(R,3),U.frob(U.powp(R,2)))
    assert len(power)<=1821
    return [[U.coeff(power,25*i+j) for j in range(25)] for i in range(73)]

def square_circuit(R):
    """All 54+16 equations, exactly as in the problem; degree 140 expected."""
    assert len(R)==141
    A=list(reversed(R));L=A[0]
    A2=U.mul(A,A)[:125];A3=U.mul(A2,A)[:125]
    C=U.mul(U.mul(A3,U.frob(A2)[:125])[:125],U.frob(A2,2)[:125])[:125]
    C=(C+[0]*125)[:125];B=C[:71]
    assert not U.trim(U.sub(U.mul(C,C),U.scale(A,F.powk(L,125)))[:125])
    late=U.sub(U.mul(B,B),U.scale(A,F.powk(L,125)))
    return {'first_54':C[71:125],'last_16':[U.coeff(late,m) for m in range(125,141)]}

def rank_checks(R):
    M=section_matrix(R)
    rk=rank(M);rk4=rank([row[21:25] for row in M])
    # A square of the full target degree: all section-rank conditions must hold.
    rng=random.Random(271828)
    J=[rng.randrange(F.ORDER) for i in range(71)];J[-1]=1
    sq=U.powp(J,2);Ms=section_matrix(sq)
    assert E.square_test(sq)[0]
    assert all(v==0 for v in square_circuit(sq)['first_54']+square_circuit(sq)['last_16'])
    assert rank(Ms)<=3 and rank([r[21:25] for r in Ms])<=2
    # Essential warning: the rank tests are NOT a complete square criterion.
    falsepositive=U.shift(U.powp([4,1],15),125)
    Mf=section_matrix(falsepositive)
    assert len(falsepositive)==141
    assert rank(Mf)<=3 and rank([r[21:25] for r in Mf])<=2
    assert not E.square_test(falsepositive)[0]
    fc=square_circuit(falsepositive)
    assert fc['first_54']==[0]*54
    assert [(125+i,v) for i,v in enumerate(fc['last_16']) if v]==[(125,4),(130,3),(135,2),(140,1)]
    return {'diagnostic_R_rank_73_by_25':rk,'diagnostic_R_last_four_columns_rank':rk4,
            'square_control_rank':rank(Ms),'square_control_last_four_rank':rank([r[21:25] for r in Ms]),
            'false_positive_polynomial':'x^125*(x-1)^15',
            'false_positive_rank':rank(Mf),'false_positive_last_four_rank':rank([r[21:25] for r in Mf]),
            'rank_tests_are_only_necessary':True,
            'false_positive_passes_all_first_54_tails':True,
            'false_positive_nonzero_late_tails':[(125+i,v) for i,v in enumerate(fc['last_16']) if v]}

def run():
    start=time.time()
    assert U.gcd(E.A,U.deriv(E.A))==[1] and U.gcd(E.A,E.P)==[1]
    assert U.gcd(E.t,U.deriv(E.t))==[1]
    cases=universal_check()
    point_checks=[]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        dic,pars,fs,det=E.cramer(h,w);assert fs[6]
        assert full_source_check(dic)
        R=E.residual(dic,lam);q=F.powk(w,3)
        cf=cube_free_residual(F.div(h,w),q,F.div(lam,w))
        assert cf==U.scale(R,F.powk(q,13))
        leading=F.powk(F.mul(F.mul(F.scale(F.powk(h,3),3),F.powk(E.EPS,8)),fs[6]),3)
        assert len(R)==141 and R[-1]==leading
        assert all(q!=v for v in E.INP['removed_q_K_codes'])
        point_checks.append({'h':h,'w':w,'lambda':lam,'H':F.div(h,w),'q':q,'mu':F.div(lam,w),'F6':fs[6],
                             'original_source_conditions_1_to_4':True,'graph_5':True,'F4_F5':True,
                             'cube_free_residual_agrees':True,'degree_R':140})
    dic,_,_,_=E.cramer(1,1);R=E.residual(dic,1)
    # Independent source translation route, retaining the full removed P^40.
    assert E.residual(dic,1,unbarred=True)==R
    ranks=rank_checks(R)
    summary={'fixed_degree_Sylvester_cases':len(cases),'included_degree_drop_patterns':6,
             'A_squarefree_and_coprime_to_P':True,'t_squarefree':True,
             'source_and_cube_free_residual_checks':point_checks,
             'unbarred_and_barred_residual_agree':True,'rank_diagnostics':ranks,
             'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/checks_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    (ROOT/'evidence/fixed_resultant_cases.json').write_text(json.dumps(cases,separators=(',',':'))+'\n')
    print(json.dumps(summary,indent=2))
if __name__=='__main__':run()
