#!/usr/bin/env -S sage -python
"""NEW signed elliptic necessary norm gates; no GB or parameter sweep.

Two positive-sign F25 univariate square gates and one negative r=-1
F5 univariate necessary gate. Also direct fresh coefficient assertions
for the hand r=1 proof. One worker, ten mathematical CPU seconds.
"""
import json
import math
import resource
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing

out = (Path(__file__).resolve().parents[2].parent / 'litt3-computation-data'
       / 'oct03_q0_degree_six_elliptic_involution_norm_gates')
out.mkdir(parents=True, exist_ok=True)
path = out/'gate.json'
started = time.process_time()
receipt = {'scope': 'actual one-uniform elliptic d6 signed necessary '
                    'derivative norm; positive sign and negative r=-1 only',
           'budget_cpu_seconds': 10, 'cases': [], 'assertions': {}}


def save():
    receipt['cpu_seconds'] = time.process_time()-started
    path.write_text(json.dumps(receipt, indent=2)+'\n')


class BudgetExpired(Exception):
    pass


def timeout(signum, frame):
    raise BudgetExpired()


def strip_physical(poly, physical):
    removed = []
    poly = poly.monic() if poly else poly
    while poly and poly.degree() > 0:
        common = poly.gcd(physical)
        if common.degree() == 0:
            break
        common = common.monic()
        removed.append(str(common))
        poly = (poly//common).monic()
    return poly, removed


def certificate(case, nums, physical):
    ring = physical.parent()
    raw = ring.zero()
    weights = []
    for value in nums:
        new, left, right = raw.xgcd(value)
        weights = [left*x for x in weights]+[right]
        raw = new
    if raw:
        lead = raw.leading_coefficient()
        raw /= lead
        weights = [x/lead for x in weights]
    assert sum(w*v for w, v in zip(weights, nums)) == raw
    residual, removed = strip_physical(raw, physical)
    case.update({'equations': [str(v) for v in nums],
                 'physical_polynomial': str(physical),
                 'raw_gcd': str(raw), 'raw_gcd_degree': int(raw.degree()),
                 'bezout_weights': [str(x) for x in weights],
                 'bezout_identity_verified': True,
                 'removed_physical_factors': removed,
                 'residual_gcd': str(residual),
                 'residual_degree': int(residual.degree()),
                 'unit_on_physical_open': bool(raw) and residual.degree() == 0,
                 'status': 'completed'})
    save()


signal.signal(signal.SIGPROF, timeout)
signal.setitimer(signal.ITIMER_PROF, 10)
cpu_limit = math.floor(started)+10
resource.setrlimit(resource.RLIMIT_CPU, (cpu_limit, cpu_limit))
save()
try:
    # Direct multiplication, not an ideal-membership/GB replay.
    C0 = PolynomialRing(GF(5), names=('la', 'mu'))
    la, mu = C0.gens()
    T0 = PolynomialRing(C0, 't'); t = T0.gen()
    ell, m = la**2, mu**2
    A, B, C = ell+1, 2*la*mu, m-2*ell+1
    phi = A*(t**4+1)+B*(t**3-t)+C*t**2
    N1 = (phi+t*phi.derivative()/2)**2-(2*la*t+mu)**2*phi
    expected1 = [A*(A-m), m*B,
                 3*B**2+4*A*(C-ell)-m*C, B*(m+2),
                 4*C**2+A**2-4*ell*C-2*B**2-m*A,
                 4*B, A*(2*C-4*ell), 0, 4*A**2]
    assert all(N1[j] == expected1[j] for j in range(9))
    Nm = (phi.derivative()/2)**2-(3*la*t**2+2*mu*t-la)**2*phi
    expectedm = [ell*(m-A), B*(4*m+1),
                 m**2+2*ell**2+2*ell*m+3*m+ell+1,
                 B*(4*m+2), m**2+4*ell*m+2*ell+4,
                 2*B, 3*ell**2+3*ell*m+m+4, 4*B, ell*A]
    assert all(Nm[j] == expectedm[j] for j in range(9))
    receipt['assertions']['negative_r1_direct_coefficients'] = True
    receipt['assertions']['negative_rminus1_direct_coefficients'] = True
    save()

    base = PolynomialRing(GF(5), 'n'); n = base.gen()
    K25 = GF(25, name='nu', modulus=n**2-n-3); nu = K25.gen()
    assert (nu+2)**2 == 2
    Rh = PolynomialRing(K25, 'h'); hp = Rh.gen()
    Kh = Rh.fraction_field(); h = Kh(hp)
    Th = PolynomialRing(Kh, 't'); t = Th.gen()
    for ell in (nu+2, -nu-2):
        case = {'sign': 'positive', 'ell': str(ell), 'status': 'started'}
        receipt['cases'].append(case); save()
        A, C = Kh(ell+1), Kh(1-2*ell)
        U, V, W = h+1/h+2, h+1/h-2, h-1/h
        phi = A*(t**4+1)+C*t**2
        Du, Dv = phi/2+t*phi.derivative()/4, -phi.derivative()/4
        N = (U*(Du**2-ell*t**2*phi)
             +V*(Dv**2-ell*(3*t**2-1)**2*phi/4)
             +W*(2*Du*Dv+ell*t*(3*t**2-1)*phi))
        J = 4*ell+U
        assert N[8] == A*J and N[0] == 4*N[8]
        assert N[7] == N[1] == 2*W*A
        assert N[5] == W*(3*ell-1) and N[3] == W*(3+4*ell)
        assert N[6] == 3*U*A*C+V*A**2-V*ell*C-(U+V)*ell*A
        assert N[2] == 4*V*C**2+U*A*C-4*V*ell*C-(U+V)*ell*A
        P = N/N[8]
        q3 = P[7]/2
        q2 = (P[6]-q3**2)/2
        q1 = (P[5]-2*q3*q2)/2
        q0 = (P[4]-2*q3*q1-q2**2)/2
        Q = t**4+q3*t**3+q2*t**2+q1*t+q0
        remainder = P-Q**2
        assert remainder.degree() <= 3
        equations = [remainder[j] for j in range(4)]
        physical = hp*(hp**2+(2+4*ell)*hp+1)
        for value in equations:
            residual, _ = strip_physical(Rh(value.denominator()), physical)
            assert residual.degree() == 0
        case.update({'norm': str(N), 'monic_square_remainder': str(remainder),
                     'physical_opens': ['h', 'h^2+(2+4*ell)h+1']})
        certificate(case, [Rh(x.numerator()) for x in equations], physical)
    receipt['assertions']['positive_direct_coefficients_both_ell'] = True

    Rk = PolynomialRing(GF(5), 'k'); kp = Rk.gen()
    Kk = Rk.fraction_field(); k = Kk(kp)
    d, n = 1-k, k**2+2*k+4
    M = k**3+2*k**2+3*k+1
    Z = n**2+d**2
    An, L = M*d, M*d-Z
    assert Z == k**4+4*k**3+3*k**2+4*k+2
    assert An == 4*k**4+4*k**3+4*k**2+2*k+1
    assert L == 3*k**4+k**2+3*k+4
    ell, m, A, s = L/Z, M/d, An/Z, n/d
    assert A == ell+1 and m == s*k+1 and m/A == s**2+1
    assert s+(3-k)*k == m+3
    H = (L**2*d**2+3*L*M*Z*d+M**2*Z**2
         +2*M*Z**2*d+3*Z**2*d**2)
    R = ((2+2*k)*L**3*d+(1-k)*L**2*Z*d
         +3*(1-k)*L*Z**2*d+4*Z**3*d+L*M*(3*L+4*Z)*Z)
    assert H == (ell**2+3*ell*m+m**2+2*m+3)*Z**2*d**2
    n6 = 3*ell**2+3*ell*m+m+4
    assert R == (n6*A-m-2*(3-k)*ell*A**2)*Z**3*d
    nums = [Rk(H), Rk(R)]
    physical = Rk(d*n*Z*M*L)
    case = {'sign': 'negative', 'r': '-1', 'status': 'started',
            'rational_parameter': {'s': str(s), 'm': str(m), 'ell': str(ell)},
            'physical_opens': ['1-k', 'k^2+2k+4', str(Z), str(M), str(L)]}
    receipt['cases'].append(case); save()
    certificate(case, nums, physical)
    receipt['assertions']['negative_rminus1_rational_reconstruction'] = True
except BudgetExpired:
    receipt['budget_expired'] = True
except Exception as exc:
    receipt['failure'] = {'type': type(exc).__name__, 'message': str(exc)}
    raise
finally:
    signal.setitimer(signal.ITIMER_PROF, 0)
    save()
print(json.dumps({'cases': [(x['sign'], x.get('ell', x.get('r')), x['status'],
                             x.get('residual_degree')) for x in receipt['cases']],
                  'assertions': receipt['assertions'],
                  'cpu_seconds': receipt['cpu_seconds'],
                  'budget_expired': receipt.get('budget_expired', False),
                  'receipt': str(path)}))
