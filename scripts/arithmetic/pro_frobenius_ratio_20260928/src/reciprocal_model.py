"""Boundary-independent reciprocal monic model from the global zero-scale identity.

At an allowed ratio the returned E satisfies mu*E=1 modulo (C71,C72),
and the returned reciprocal polynomial is monic of degree 54 even when
C72 drops scale degree. Tests below are implementation regressions; the
whole-curve assertion follows from the polynomial certificate.
"""
import json
from pathlib import Path
import ext
from ext import Element as E,EP
from ff import Poly,mul,power,div,neg
from residual import RATIO,peval,check_open,Tails
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]


def factor_value(data,fs,q):
    out=E(data['scalar'])
    for f,ex in zip(fs,data['exponents']):
        if ex:out=out*peval(f,q)**ex
    return out


def model_at(q,u,primitives,cert):
    check_open(q,u);rr,A=residual_jet(q,u,72);tt=Tails(A,max_n=72)
    f,g=tt.tail(71),tt.tail(72);assert f.degree()<=53 and g.degree()<=54
    b,c,d=[peval(RATIO[k],q) for k in ('b','c','d')];z=b*u
    g0=b**72*q**35*d**36*rr[0][0]
    weights=[]
    for n,key in ((71,'U'),(72,'V')):
        pp=primitives[n]
        bar=peval(pp.a.tolist(),q)+peval(pp.b.tolist(),q)*(3*c-z)
        den=factor_value(cert['tails'][str(n)]['content'],cert['unit_factors'],q)
        den=den*factor_value(cert['tails'][str(n)]['norm_unit'],cert['unit_factors'],q)
        wi=g0**63*peval(cert['bezout'][key],q)*bar/den
        weights.append(wi)
    combo=f*weights[0]+g*weights[1];assert combo[0]==1
    invmu=EP([-combo[j] for j in range(1,len(combo))])
    assert combo+EP([0,1])*invmu==1 and invmu.degree()<=53
    reciprocal=EP([combo[54-j] for j in range(55)])
    assert reciprocal.degree()==54 and reciprocal[54]==1
    return {'tail_degrees':[f.degree(),g.degree()],
            'inverse_mu_degree':invmu.degree(),'reciprocal_monic_degree':54,
            'reciprocal_constant_is_zero':not bool(reciprocal[0])}


def checks(primitives,cert):
    results=[]
    for qv in (1,2):
        b,c,e=[Poly(RATIO[k]).eval(qv) for k in ('b','c','e')]
        u=ext.context([mul(3,e),mul(2,c),b]);q=E(qv)
        info=model_at(q,u,primitives,cert)
        results.append({'case':f'complete quadratic algebra q={qv}','coefficient_dimension':2,**info})
    # One first-order Artin neighborhood on the ordinary ratio curve.
    q=ext.context([1,3,1]);q0,u0=1,283421
    b,c,e=[Poly(RATIO[k]) for k in ('b','c','e')]
    gu=mul(2,(b*Poly(u0)+c).eval(q0))
    gq=(b.derivative()*mul(u0,u0)+c.derivative()*mul(2,u0)+3*e.derivative()).eval(q0)
    u1=neg(div(gq,gu));u=E(u0)+u1*(q-1)
    info=model_at(q,u,primitives,cert)
    results.append({'case':'nonreduced first-order ratio neighborhood q=1','coefficient_dimension':2,**info})
    for sign in ('plus','minus'):
        dd=json.loads((ROOT/f'data/slope_{sign}_model.json').read_text())
        q=ext.context(dd['factors'][0]);u=-peval(dd['r0'],q)/(peval(RATIO['b'],q)*peval(dd['r1'],q))
        info=model_at(q,u,primitives,cert)
        assert info['tail_degrees'][1]<54 and info['reciprocal_constant_is_zero']
        results.append({'case':f'controlled leading-slope degree drop {sign}',
                        'coefficient_dimension':ext.D,**info})
    return results
