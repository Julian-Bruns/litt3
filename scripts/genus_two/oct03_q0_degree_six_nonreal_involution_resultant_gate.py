#!/usr/bin/env -S sage -python
"""NEW necessary nonreal signed elliptic gate: 2x4 small resultants.

Only source-quartic remainder, resultant_mu and univariate l xgcd;
no GB, norm-point sweep or subsequent gate. Ten mathematical CPU
seconds, one worker. Genuine residual roots are preserved.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_six_nonreal_involution_resultant_gate')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'actual one-uniform elliptic d6 negative eta, all four '
                    'nonreal r; source-Hasse/derivative-square necessary gate',
           'budget_cpu_seconds': 10, 'cases': []}


def save():
    receipt['cpu_seconds'] = time.process_time()-started
    path.write_text(json.dumps(receipt, indent=2)+'\n')


class BudgetExpired(Exception):
    pass


def timeout(signum, frame):
    raise BudgetExpired()


def strip_physical(poly, physical):
    poly = poly.monic() if poly else poly
    removed = []
    while poly and poly.degree() > 0:
        common = poly.gcd(physical)
        if common.degree() == 0:
            break
        common = common.monic()
        removed.append(str(common))
        poly = (poly//common).monic()
    return poly, removed


def rational_string(poly):
    return [str(x) for x in poly.list()]


signal.signal(signal.SIGPROF, timeout)
signal.setitimer(signal.ITIMER_PROF, 10)
cpu_limit = math.floor(started)+10
resource.setrlimit(resource.RLIMIT_CPU, (cpu_limit, cpu_limit))
save()
try:
    R0 = PolynomialRing(GF(5), 'n'); n = R0.gen()
    K25 = GF(25, name='nu', modulus=n**2-n-3); nu = K25.gen()
    Rl = PolynomialRing(K25, 'l'); lp = Rl.gen()
    Kl = Rl.fraction_field(); l = Kl(lp)
    Rm = PolynomialRing(Kl, 'mu'); mu = Rm.gen()
    T = PolynomialRing(Rm, 't'); t = T.gen()
    for alpha, h in ((2, nu+2), (3, 3*nu+1)):
        assert h**2 == alpha
        U = K25(4)/(1-alpha)
        case = {'alpha': alpha, 'h': str(h), 'U': str(U),
                'status': 'started', 'resultants': []}
        receipt['cases'].append(case); save()
        la = h*l
        ell = alpha*l**2
        A, B, C = 1+ell, h*(2*l*mu-U), mu**2-2*ell+3
        K = 1+(1-alpha)*ell
        L = la*(t**2-1)+mu*t
        phi = A*(t**4+1)+B*(t**3-t)+C*t**2
        Eprime = h*la*(3*t**2-1)+(2*h*mu-2*la)*t-mu
        D = (3*A*t**4+2*h*A*t**3+(2*C+4*h*B)*t**2
             +(B+h*C)*t+(A+2*h*B))
        assert Eprime == ((h*t-1)*L).derivative()
        assert D == phi+(t+h)*phi.derivative()/2
        N = D**2-Eprime**2*phi
        assert N[8] == 4*A*K
        I = (alpha*l**2-mu**2)**2+(U*alpha*l-mu)**2+2
        assert I.is_monic() and I.degree() == 4
        assert I == 2*A**2-2*B**2+C**2
        physical = Rl(A*K)
        P = N/(4*A*K)
        q3 = P[7]/2
        q2 = (P[6]-q3**2)/2
        q1 = (P[5]-2*q3*q2)/2
        q0 = (P[4]-2*q3*q1-q2**2)/2
        Q = t**4+q3*t**3+q2*t**2+q1*t+q0
        remainder = P-Q**2
        assert remainder.degree() <= 3
        nums = []
        for j in range(4):
            equation = Rm(remainder[j] if j % 2 == 0 else remainder[j]/h)
            reduced = equation % I
            assert reduced.degree() <= 3
            for value in reduced.list():
                den_rem, _ = strip_physical(Rl(value.denominator()), physical)
                assert den_rem.degree() == 0
                assert all(c**5 == c for c in value.numerator().list())
                assert all(c**5 == c for c in value.denominator().list())
            resultant = I.resultant(reduced)
            den_rem, _ = strip_physical(Rl(resultant.denominator()), physical)
            assert den_rem.degree() == 0
            numerator = Rl(resultant.numerator())
            nums.append(numerator)
            case['resultants'].append({'coefficient': j,
                                       'reduced_equation_coefficients': rational_string(reduced),
                                       'resultant_numerator': str(numerator),
                                       'resultant_degree': int(numerator.degree()),
                                       'resultant_denominator': str(resultant.denominator())})
            save()
        raw = Rl.zero(); weights = []
        for value in nums:
            new, left, right = raw.xgcd(value)
            weights = [left*w for w in weights]+[right]
            raw = new
        if raw:
            lead = raw.leading_coefficient()
            raw /= lead; weights = [w/lead for w in weights]
        assert sum(w*v for w, v in zip(weights, nums)) == raw
        residual, removed = strip_physical(raw, physical)
        case.update({'source_Hasse_coefficients': rational_string(I),
                     'physical_opens': {'A': str(A), 'K': str(K)},
                     'physical_polynomial': str(physical),
                     'raw_gcd': str(raw), 'raw_degree': int(raw.degree()),
                     'bezout_weights': [str(x) for x in weights],
                     'bezout_identity_verified': True,
                     'removed_physical_factors': removed,
                     'residual_gcd': str(residual),
                     'residual_degree': int(residual.degree()),
                     'unit_on_physical_open': bool(raw) and residual.degree() == 0,
                     'status': 'completed'})
        save()
except BudgetExpired:
    receipt['budget_expired'] = True
except Exception as exc:
    receipt['failure'] = {'type': type(exc).__name__, 'message': str(exc)}
    raise
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['alpha'], x['status'], x.get('raw_degree'),
                             x.get('residual_degree')) for x in receipt['cases']],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False),
                  'receipt': str(path)}))
