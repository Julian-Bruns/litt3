#!/usr/bin/env -S sage -python
"""Prepared bounded quadratic/resultant gate; no parameter/root sweep.

Both remaining coprime two-root classes are encoded by an unnamed s.
Beta includes both square-root signs. No execution is claimed until the
external receipt exists. This does not replay any fixed-X arithmetic.
"""
import json
import signal
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def expire(signum, frame):
    raise TimeoutError("ten-second mathematical budget expired")


def main():
    out = Path(__file__).resolve().parents[2].parent / "litt3-computation-data" / "oct03_q0_degree_four_coprime_quadratic_gate"
    out.mkdir(parents=True, exist_ok=True)
    payload = {"scope": "remaining coprime elliptic nonWeier two-root classes only",
               "timeout_seconds": 10, "single_core": True, "rows": []}
    signal.signal(signal.SIGALRM, expire)
    start, cpu = time.monotonic(), time.process_time()
    signal.setitimer(signal.ITIMER_REAL, 10)
    try:
        prime = PolynomialRing(GF(5), "aa")
        aa = prime.gen()
        field = GF(25, name="omega", modulus=aa**2+aa+1)
        om = field.gen()
        BR = PolynomialRing(field, "beta")
        beta = BR.gen()
        BK = BR.fraction_field()
        SR = PolynomialRing(BK, "zeta")
        ze = SR.gen()
        SK = SR.fraction_field()
        ZR = PolynomialRing(SK, "z")
        z = ZR.gen()
        for delta in (1, -1):
            row = {"delta": delta, "status": "DERIVING"}
            payload["rows"].append(row)
            b2 = beta**2
            if delta == 1:
                uden = b2-2
                u = BK(3*om**2)/uden
            else:
                uden = (3*om+2)*b2+4*om+1
                u = BK(-(4*om+3)*(b2+1))/uden
            v = BK((delta*om**2*(om+u)-(1+u))*(3*om+1))
            w = 1+u-v
            a = om**2*w**2
            ca, ba = a+u, v*a+w
            assert b2 == 2*ba/(v*ca)
            assert ba == delta*om*w*ca
            J = -(b2*ze+a*(1+2*u/v**2))/(2*beta)
            j, h = a+J, a+beta*J
            s = a+3*ze
            ell = 2*ze/b2-a
            T = -3*(s-om**2)/(ze*(3+2/b2)**2)
            phi = z*(T*(z+ell)**2+(z-om**2)*(z-a))
            E = SR(J**2-ca*ze).monic()
            assert E.degree() == 2
            assert phi(s) == 0
            cc, bb = z+u, v*z+w
            Abar, Bbar = cc*(z+ell), bb*(z+ell)
            U = Abar.derivative()*z*(z-a)-Abar*(2*z-a)
            C = Bbar.derivative()*(z-a)-Bbar
            V = (v*phi+bb*phi.derivative()/2)*(z-a)-bb*(3*phi-2*a*phi.quo_rem(z)[0])
            W = (phi+cc*phi.derivative()/2)*(z-a)-cc*phi
            assert phi.quo_rem(z)[1] == 0
            for value in (C(j), U(h)):
                assert value.numerator().quo_rem(E)[1] == 0
            divphi, rem = phi.quo_rem(z-s)
            assert rem == 0
            G1, G2 = 4*v*divphi*(z-h)**2, 3*divphi*(z-j)**2
            for value in (G1(a)+ba*phi(a), G2(a)+ca*phi(a)):
                assert value.numerator().quo_rem(E)[1] == 0
            norms = [G1*(2*V-G1)-phi*T*U**2,
                     G2*(2*W-G2)-phi*T*C**2]
            equations, raw_coeffs = [], []
            for norm in norms:
                for coeff in norm.list():
                    if coeff:
                        raw_coeffs.append(str(coeff))
                        reduced = coeff.numerator().quo_rem(E)[1]
                        assert reduced.degree() <= 1
                        if reduced:
                            equations.append(reduced)
            known_open = BR(beta*(beta**2-1)*uden)
            for value in (a, w, v, ba, ca):
                assert value != 0
                known_open *= value.numerator()*value.denominator()
            derived_denoms = BR.one()
            for poly in [E]+equations:
                for coeff in poly.list():
                    derived_denoms *= coeff.denominator()
            missing_poles = derived_denoms
            while missing_poles.degree() > 0:
                bad = missing_poles.gcd(known_open)
                if bad.degree() == 0:
                    break
                missing_poles = missing_poles.quo_rem(bad)[0]
            resultants = [BR(E.resultant(eq).numerator()) for eq in equations]
            g = BR.zero()
            for value in resultants:
                if value:
                    g = g.gcd(value)
            residual = g
            removed = []
            if residual:
                while residual.degree() > 0:
                    bad = residual.gcd(known_open)
                    if bad.degree() == 0:
                        break
                    removed.append(str(bad))
                    residual = residual.quo_rem(bad)[0]
            all_linear_zero = residual
            if residual:
                for eq in equations:
                    all_linear_zero = all_linear_zero.gcd(eq[1].numerator())
            f25_roots_only = bool(residual) and (BR(beta**25-beta).quo_rem(residual)[1] == 0)
            row.update({"status": "COMPLETED", "u": str(u), "v": str(v), "w": str(w),
                        "quadratic": str(E), "norm_coefficients": raw_coeffs,
                        "reduced_linear_equations": [str(eq) for eq in equations],
                        "resultants": [str(r) for r in resultants],
                        "known_actual_open": str(known_open),
                        "uncontrolled_pole_factor": str(missing_poles),
                        "gcd": str(g), "removed_open_factors": removed,
                        "residual_gcd": str(residual), "F25_roots_only": f25_roots_only,
                        "all_linear_coefficients_zero_gcd": str(all_linear_zero),
                        "generic_empty": bool(residual) and residual.degree() == 0})
    except TimeoutError:
        payload["timeout"] = True
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        payload["wall_seconds"] = time.monotonic()-start
        payload["CPU_seconds"] = time.process_time()-cpu
        (out / "gate.json").write_text(json.dumps(payload, indent=2)+"\n")
    print(json.dumps({"rows": [{k:r.get(k) for k in ["delta", "status", "residual_gcd", "F25_roots_only", "uncontrolled_pole_factor", "all_linear_coefficients_zero_gcd"]} for r in payload["rows"]],
                      "timeout": payload.get("timeout", False), "CPU_seconds": payload["CPU_seconds"],
                      "receipt": str(out / "gate.json")}))


if __name__ == "__main__":
    main()
