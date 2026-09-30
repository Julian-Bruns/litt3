"""Small exact algebra for new weighted source-energy numerators.

Uses the critical algebra of dimension <=3 and the order-four
Frobenius thickening. This does not replay any incoming verifier.
The executable examples are local model probes, not cover decisions.
"""
import json, sys, time
from pathlib import Path

def energy_numerators(K, q, S_coefficients, tau, v, delta, p=5, m=2, weights=(0,1,2)):
    L = PolynomialRing(K, 'ell'); ell = L.gen()
    LK = L.fraction_field(); Wring = PolynomialRing(LK, 'W'); W = Wring.gen()
    phi = W**p + q
    S = sum(Wring(a)*W**i for i,a in enumerate(S_coefficients))
    D = S.derivative(); d = D.degree()
    assert d >= 0 and D and tau and v
    F = ell*v*phi**m + phi*S + tau
    A = phi*S + tau
    deltaS = sum(Wring(delta(a))*W**i for i,a in enumerate(S_coefficients))
    deltaA = delta(q)*S + phi*deltaS + delta(tau)
    B = v*phi*deltaA-A*(phi*delta(v)+m*v*delta(q))
    assert D.gcd(phi).degree() == 0
    if d:
        Dc = D.monic()
        MF = matrix(LK,d,d,lambda i,j: ((F*W**j)%Dc)[i])
        norm = MF.det()
        adj_one = MF.adjugate().column(0)
        adjF = sum(adj_one[i]*W**i for i in range(d))
        Delta = L(D.leading_coefficient()**F.degree()*norm)
        critical = (B**2 * (phi**4).inverse_mod(Dc) * adjF / v**2) % Dc
        crit_num = [D.leading_coefficient()**(F.degree()-1)*
                    ((W**j*critical)%Dc)[d-1] for j in weights]
    else:
        Delta = L(D[0]**F.degree())
        crit_num = [LK.zero() for j in weights]
    P4 = phi**4
    Vd = D.inverse_mod(P4)
    R = (phi*S+ell*v*phi**m)/tau
    Vf = sum((-R)**i for i in range(4))/tau
    polar = (B**2*Vd*Vf/v**2) % P4
    polar_res = [((W**j*polar)%P4)[4*p-1] for j in weights]
    numerators = [L(-cn-Delta*pr) for cn,pr in zip(crit_num,polar_res)]
    bound = d+(3//m)
    assert all(N.degree() <= bound for N in numerators)
    return Delta, numerators

def direct_at_one(K,q,coeffs,tau,v,delta,weights=(0,1,2)):
    R=PolynomialRing(K,'W'); W=R.gen(); phi=W**5+q
    S=sum(coeffs[i]*W**i for i in range(len(coeffs)))
    F=v*phi**2+phi*S+tau
    Fdelta=(delta(v)*phi**2+2*v*phi*delta(q)+delta(q)*S+
        phi*sum(delta(coeffs[i])*W**i for i in range(len(coeffs)))+delta(tau))
    Fm=F.monic(); FW=F.derivative()
    dw=(-Fdelta*FW.inverse_mod(Fm))%Fm
    common=(dw**2*phi.inverse_mod(Fm))%Fm
    return [((FW*W**j*common)%Fm)[9]/v for j in weights]

if __name__ == '__main__':
    started=time.time()
    out=Path(sys.argv[1]); out.mkdir(parents=True,exist_ok=True)
    R=PolynomialRing(GF(5),'r'); r=R.gen(); K=R.fraction_field(); r=K(r)
    delta=lambda f: K(f).derivative()
    result={'scope':'new exact residue algorithm; two local probes only',
            'source_degree':10,'critical_degree':2,'critical_repeated':True,
            'threads':1,'examples':[]}
    for name,tau in [('tame_cubic',K(1)),('flat_tame_cubic',1+r-r**4)]:
        q=1+r; coeffs=[-1-q,K(0),K(0),K(1)]
        Delta,N=energy_numerators(K,q,coeffs,tau,K(1),delta)
        direct=direct_at_one(K,q,coeffs,tau,K(1),delta)
        E=[K(P(1)/Delta(1)) for P in N]
        assert E==direct
        def ord0(f):
            return 'infinity' if not f else int(f.numerator().valuation()-f.denominator().valuation())
        result['examples'].append({'name':name,'Delta_degree':int(Delta.degree()),
            'numerator_degrees':[int(P.degree()) for P in N],
            'orders_at_r_zero':[ord0(f) for f in E],
            'exact_energies':[str(f) for f in E],
            'direct_trace_agrees':True})
    result['seconds']=time.time()-started
    (out/'local_models.json').write_text(json.dumps(result,indent=2,default=int)+'\n')
    print(json.dumps(result,indent=2,default=int),flush=True)
