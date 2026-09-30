"""Exact diagnostics for the unlocalized arithmetic of the global prototype.

These four previously used parameter values only validate implementation.
They are NOT a new fibre exclusion or an exhaustive geometric search.
"""
from __future__ import annotations
import json, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
import field as F,poly as U,evaluate as E


def run():
    if sys.flags.optimize:raise RuntimeError('Assertions must be enabled')
    data=json.loads((ROOT/'data/cube_free.json').read_text())
    answers=[]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        U.set_curve(E.P)
        dic,pars,fs,det=E.cramer(h,w)
        original=E.residual(dic,lam)
        q=F.powk(w,3); H=F.div(h,w); mu=F.div(lam,w)
        d=F.add(47171,F.mul(357608,q))
        def evaluate(rows):
            out=U.zero()
            for (hp,qp,xp,yp),c in rows:
                exponent=qp+1-yp
                assert exponent>=0
                cc=F.mul(c,F.mul(F.powk(H,hp),F.powk(q,exponent)))
                while len(out[yp])<=xp:out[yp].append(0)
                out[yp][xp]=F.add(out[yp][xp],cc)
            return [U.trim(p) for p in out]
        ng={i:evaluate(data['barred_numerators']['g'+str(i)]) for i in (2,3,4,5)}
        U.set_curve(U.scale(E.P,F.powk(q,2)))
        qb=[[],U.scale(data['Qbar_x_polynomial'],q),[]]
        cap=[U.scale(U.powp(E.t,3),F.mul(d,F.powk(q,5))),[],[]]
        ell=[U.scale([F.neg(9),1],F.mul(F.mul(d,F.powk(q,2)),mu)),[],[]]
        r=E.resultant(U.cscale(ng[2],3),U.cscale(ng[3],2),ng[4],ng[5],qb,cap,ell)
        denominator=U.scale(U.mul(U.powp(E.t,5),[F.neg(9),1]),F.powk(q,15))
        theta=[U.exactdiv(p,denominator) for p in r]
        rr=U.norm(theta)
        target=U.scale(original,F.mul(F.powk(q,55),F.powk(d,36)))
        assert rr==target
        psi=0
        for (hp,qp),c in data['Psi']:
            psi=F.add(psi,F.mul(c,F.mul(F.powk(H,hp),F.powk(q,qp))))
        lead=244991
        for z,e in [(q,55),(d,30),(H,9),(psi,3)]:lead=F.mul(lead,F.powk(z,e))
        assert len(rr)==141 and rr[-1]==lead
        U.set_curve(E.P)
        answers.append({'h':h,'w':w,'lambda':lam,'H':H,'q':q,'mu':mu,
                        'upstairs_divisions_exact':True,
                        'norm_scaling_identity':True,
                        'leading_coefficient_identity':True,
                        'degree':140,'new_square_test':False})
    out={'status':'PASS','diagnostic_only':True,
         'all_ratios_previously_used_in_archive':True,
         'points':answers,'global_solver_executed':False,
         'complete_decision':'UNRESOLVED'}
    (ROOT/'decision/data/model_diagnostics.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out,indent=2))
if __name__=='__main__':run()
