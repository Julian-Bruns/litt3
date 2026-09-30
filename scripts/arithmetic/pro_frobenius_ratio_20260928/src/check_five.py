"""Implementation regressions for the complete Frobenius-five model.
These tests supplement, and do not replace, the universal proof in REPORT.md.
"""
import argparse,json,time,random
from pathlib import Path
import ext
from ext import Element as E, EP
from ff import Poly,mul
from residual import RATIO,check_open,Tails
from residual_jet import residual_jet
from frobenius_five import test_polynomials,linear_model
from leading_slope import top_coefficients,c72_leading
ROOT=Path(__file__).resolve().parents[1]


def verify_model(A,check_bounds=False):
    B,defects,D=test_polynomials(A)
    ts=Tails(A)
    assert all(B[n]==ts.C(n) for n in range(71))
    # Exact triangular change: E_n=-sum_{i=71}^n (a^2)_(n-i)*tail_i.
    for n in range(71,141):
        val=EP()
        for i in range(71,n+1):val=val-D[n-i]*ts.tail(i)
        assert val==defects[n-71],('triangular transform',n)
    rows,rhs,prefix=linear_model(A)
    assert len(rows)==112 and all(len(r)==42 for r in rows)
    assert prefix==B[:29]
    for k,(row,rr) in enumerate(zip(rows,rhs)):
        val=EP()
        for z,bb in zip(row,B[29:]):val=val+z*bb
        val=val-rr
        assert val==(EP() if k<42 else defects[k-42])
        if k<42:
            assert row[k]==1 and all(not z for z in row[k+1:])
    if check_bounds:
        assert all(x.degree()<=min(6,3*n//4) for n,x in enumerate(A))
        assert all(x.degree()<=3*n//4 for n,x in enumerate(B))
        assert all(x.degree()<=12 for row in rows for x in row)
        assert all(defects[n-71].degree()<=64 for n in range(71,141) if n%5)
    return B,defects


def run_checks():
    start=time.time();cases=[]
    for qv in [1,2,3,29]:
        b,c,e=[Poly(RATIO[k]).eval(qv) for k in ['b','c','e']]
        u=ext.context([mul(3,e),mul(2,c),b]);q=E(qv);check_open(q,u)
        _,A=residual_jet(q,u,140)
        B,defects=verify_model(A,True)
        aa,bb,dd=top_coefficients(q,u)
        assert A[4][3]==aa and A[8][6]==bb
        assert B[28][21]==aa**5*dd
        assert Tails(A,max_n=72).C(72)[54]==c72_leading(q,u)
        assert c72_leading(q,u)
        cases.append({'q':qv,'dimension':ext.D,'all_70_defects_checked':True,'all_112_linear_rows_checked':True,'top_weight_formula_checked':True})
    # A nonreduced coefficient ring. No generic-field replacement is used.
    delta=ext.context([0,0,1])
    pos=[EP() for _ in range(71)];pos[0]=EP(1)
    pos[1]=EP([E(17)+delta,E(8)])
    pos[5]=EP([delta,E(23)])
    pos[25]=EP([E(131),delta])
    pos[70]=EP([E(7)+delta])
    A=[EP() for _ in range(141)]
    for i in range(71):
        for j in range(71):
            if pos[i] and pos[j]:A[i+j]=A[i+j]+pos[i]*pos[j]
    B,df=verify_model(A)
    assert B==pos and not any(df)
    negatives=[]
    for coefficient in [E(1),delta]:
        A=[EP() for _ in range(141)];A[0]=EP(1);A[125]=EP(coefficient)
        B,df=verify_model(A)
        assert df[125-71]==EP(2*coefficient) and bool(df[125-71])
        negatives.append({'a125':coefficient.serialize(),'defect125':df[54].serialize(),'rejected':True})
    out={'status':'passed; universal proof is in REPORT.md','actual_ratio_regressions':cases,
         'nilpotent_algebra':'K[delta]/delta^2','positive_degree70_root_recovered':True,
         'late_carry_regressions':negatives,'elapsed_seconds':round(time.time()-start,3)}
    print('FIVE_VERIFICATION_SUMMARY_JSON='+json.dumps(out,sort_keys=True),flush=True)
    return out

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--save-summary',action='store_true');args=ap.parse_args()
    out=run_checks()
    if args.save_summary:(ROOT/'checks/five_verification.json').write_text(json.dumps(out,indent=2)+'\n')
