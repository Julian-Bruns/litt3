#!/usr/bin/env -S sage -python
"""One fresh exact univariate necessary gate; no parameter or root sweep.

The two alpha signs are finite-field conjugates. Both remaining choices of
the nonzero branch root use the same unnamed r,s variables. Original
equations are checked by direct polynomial multiplication before the gcd.
"""
import json
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def expire(signum, frame):
    raise TimeoutError("ten-second mathematical budget expired")


def main():
    out = Path(__file__).resolve().parents[2].parent / "litt3-computation-data" / "oct03_q0_degree_four_proportional_univariate_gate"
    out.mkdir(parents=True, exist_ok=True)
    payload = {"scope": "remaining proportional elliptic Q-nonWeier two-root classes ONLY",
               "characteristic": 5, "alpha_relation": "alpha^2=3",
               "timeout_seconds": 10, "single_core": True}
    signal.signal(signal.SIGALRM, expire)
    started, cpu = time.monotonic(), time.process_time()
    signal.setitimer(signal.ITIMER_REAL, 10)
    try:
        base = PolynomialRing(GF(5), "aa")
        aa = base.gen()
        field = GF(25, name="alpha", modulus=aa**2-3)
        alpha = field.gen()
        R = PolynomialRing(field, "u")
        u = R.gen()
        K = R.fraction_field()
        ZR = PolynomialRing(K, "Z")
        Z = ZR.gen()
        C, D, E, k = 2+alpha, 3+alpha, 4+3*alpha, 4-2*alpha
        n = 4+C*u+D*u**2
        M = 4+D*u
        N = M+u*n
        T = N+k*u**2*n
        sigma, m = 1+u, 1+C*u
        v = (1+2*alpha)*u**2-2-C*u
        eps = K(N)/(k*u**2)
        rho = K(M)/n
        t = K(N)/T
        Ms = 3+E*u
        L = sigma**3-t*u*Ms**2
        h, j = 1+(3-alpha)*u, 1+(3+2*alpha)*u
        A = Z**2+m*Z+v
        UU = A.derivative()*Z*(Z-1)-A*(2*Z-1)
        CC = A.derivative()*(Z-1)-A
        assert UU(h) == CC(j) == 0
        assert 4*(Z-h)**2-3*(Z-j)**2 == (Z-1)*(Z-sigma)
        assert A(sigma) == u*Ms
        raw = t*A**2+(L-Z**3)*(Z-1)-(t-1)*(Z-eps)**2*(Z-rho)*(Z-sigma)
        assert raw[4] == raw[3] == 0
        eqs = [R(raw[i]*k*u**2*T) for i in (2, 1, 0)]
        E2 = k*u**2*N*(2+E*u**2)+n*N**2+2*k*u**2*N*(M+n*sigma)+k**2*u**4*M*sigma
        E1 = k*u**2*(T*sigma**3+N*(2*m*v-u*Ms**2)-2*N*M*sigma)-N**2*(M+n*sigma)
        E0 = k*u**2*(N*(v**2+u*Ms**2)-T*sigma**3)+N**2*M*sigma
        assert eqs == [E2, E1, E0]
        assert sigma**2*E2+sigma*E1+E0 == 0
        opens = {"u": K(u), "n": K(n), "N": K(N), "T": K(T),
                 "integration_nonzero": L, "U_degree_two": K(2+C*u),
                 "rho": rho, "sigma": K(sigma), "distinct_branch_roots": rho-sigma,
                 "eps": eps, "eps_not_Q": eps-1,
                 "eps_ordinary_r": eps-rho, "eps_ordinary_s": eps-sigma}
        open_poly = R.one()
        for value in opens.values():
            assert value != 0
            open_poly *= value.numerator()
        g12, a2, a1 = E2.xgcd(E1)
        g, b12, b0 = g12.xgcd(E0)
        multipliers = [b12*a2, b12*a1, b0]
        assert sum(f*q for f,q in zip(eqs,multipliers)) == g
        residual = g
        removed = []
        while residual.degree() > 0:
            bad = residual.gcd(open_poly)
            if bad.degree() == 0:
                break
            removed.append(str(bad))
            residual = residual.quo_rem(bad)[0]
        payload.update({"status": "COMPLETED", "equations_degrees": [int(f.degree()) for f in eqs],
                        "equations": [str(f) for f in eqs],
                        "opens_numerators": {name: str(value.numerator()) for name,value in opens.items()},
                        "open_product": str(open_poly), "gcd": str(g),
                        "bezout_multipliers": [str(q) for q in multipliers],
                        "removed_open_factors": removed, "residual_gcd": str(residual),
                        "empty_on_actual_open": residual.degree() == 0,
                        "assertions": ["direct quartic multiplication", "both norm-root identities",
                                       "coefficient equation derivation", "root-induced syzygy", "Bezout identity"]})
        if residual.degree() == 0 and g.degree() > 0:
            assert (open_poly**g.degree()).quo_rem(g)[1] == 0
            payload["all_gcd_roots_in_bad_open_verified"] = True
    except TimeoutError:
        payload["status"] = "TIMEOUT_NO_CLAIM"
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        payload["wall_seconds"] = time.monotonic()-started
        payload["CPU_seconds"] = time.process_time()-cpu
        (out / "gate.json").write_text(json.dumps(payload, indent=2)+"\n")
    print(json.dumps({"status": payload.get("status"), "gcd": payload.get("gcd"),
                      "residual_gcd": payload.get("residual_gcd"),
                      "empty_on_actual_open": payload.get("empty_on_actual_open"),
                      "CPU_seconds": payload["CPU_seconds"], "receipt": str(out / "gate.json")}))


if __name__ == "__main__":
    main()
