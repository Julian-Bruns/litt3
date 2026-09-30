"""Exact global polynomial model S=(q*d(q))^36 Rcal.

The degree bounds proved in REPORT.md are deg_H<=72, deg_q<=198,
deg_mu<=6, and deg_x<=140. The numerical evaluator requires q!=0;
it does not require H, mu, or d(q) to be nonzero. Only the stated open
chart is relevant to the square decision.
"""
import json,time
from pathlib import Path
import field as F
import poly as U
import evaluate as E
import cube_free as CF
ROOT=Path(__file__).resolve().parents[1]
DATA=json.loads((ROOT/'data/cube_free.json').read_text())

def evaluate_polynomial(H,q,mu):
    if not q:raise ValueError('This evaluator uses q!=0; the model extends polynomially to q=0.')
    dd=F.add(47171,F.mul(357608,q))
    ng=[CF.evaluate(CF.fromdata(DATA['barred_numerators']['g'+str(i)]),H,q) for i in range(2,6)]
    Qstar=[[],U.scale(DATA['Qbar_x_polynomial'],F.powk(q,2)),[]]
    ll=[U.scale([F.neg(9),1],F.mul(dd,F.mul(q,mu))),[],[]]
    C=[U.scale(U.powp(E.t,3),F.mul(dd,F.powk(q,4))),[],[]]
    U.set_curve(U.scale(E.P,F.inv(q)))
    try:
        rr=E.resultant(U.cscale(ng[0],3),U.cscale(ng[1],2),ng[2],ng[3],Qstar,C,ll)
        nn=U.norm(rr)
        quot=U.exactdiv(nn,U.mul(U.powp(E.t,15),U.powp([F.neg(9),1],3)))
        out=U.scale(quot,F.powk(q,-15))
    finally:U.set_curve(E.P)
    return out

def psi_at(H,q):
    out=0
    for (hp,qp),c in DATA['Psi']:
        out=F.add(out,F.mul(c,F.mul(F.powk(H,hp),F.powk(q,qp))))
    return out

def run():
    start=time.time();rows=[]
    for name,terms in DATA['barred_numerators'].items():
        rows.append({'name':name,'H_max':max(e[0] for e,c in terms),'q_max':max(e[1] for e,c in terms),
                     'weighted_q_min':min(3*e[1]-e[3] for e,c in terms)})
    assert [(r['H_max'],r['q_max'],r['weighted_q_min']) for r in rows]==[(2,5,0),(2,6,1),(2,6,2),(2,6,3)]
    checked=[]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        q=F.powk(w,3);H=F.div(h,w);mu=F.div(lam,w);dd=F.add(47171,F.mul(357608,q))
        pp=evaluate_polynomial(H,q,mu)
        dic,_,_,_=E.cramer(h,w);rr=E.residual(dic,lam)
        assert pp==U.scale(rr,F.mul(F.powk(q,49),F.powk(dd,36)))
        lc=F.mul(244991,F.mul(F.powk(q,49),F.mul(F.powk(dd,30),F.mul(F.powk(H,9),F.powk(psi_at(H,q),3)))))
        assert len(pp)==141 and pp[-1]==lc
        checked.append({'h':h,'w':w,'lambda':lam,'model_agrees_with_scaled_residual':True,'leading_coefficient_agrees':True})
    model={'name':'S_model','coefficient_ring':'K[H,q,mu]','x_degree':140,
           'definition':'q^(-15)*Norm_{Y^3=P/q}(Res_(10,2)(fstar,Dstar))/(t^15*v^3)',
           'relation':'S_model=(q*d(q))^36*Rcal',
           'degree_bounds':{'H':72,'q':198,'mu':6,'x':140},
           'lowest_possible_q_power':1,
           'leading_x_coefficient':{'constant_K_code':244991,'q_exponent':49,'d_exponent':30,'H_exponent':9,'Psi_exponent':3},
           'source_for_fstar_and_Dstar':'data/cube_free.json',
           'square_equivalence':'On the requested open chart, multiplying by (q*d)^36 is multiplication by the square ((q*d)^18)^2.',
           'expanded_coefficient_array_computed':False}
    (ROOT/'data/polynomial_model.json').write_text(json.dumps(model,indent=2)+'\n')
    summary={'source_bounds_checked_from_exact_arrays':rows,'parameter_checks':checked,
             'degree_bound_proof':'REPORT.md: Global polynomial normalization',
             'global_coefficients_not_expanded':True,'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/polynomial_model_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
if __name__=='__main__':run()
