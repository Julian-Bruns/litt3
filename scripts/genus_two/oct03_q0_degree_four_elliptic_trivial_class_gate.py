#!/usr/bin/env -S sage -python
"""One fresh bounded test of the coprime elliptic trivial derivative class.

Only necessary equations are tested, with both mu3 sign families retained.
The actual centered quadratic is scaled to X^2+1; this test does not use P.
The mathematical phase, including the basis test, has one total three-second cap.
No timeout or nonunit ideal is an exclusion. Receipts live outside litt3.
"""
import json
import signal
import time
import sympy as sp
from pathlib import Path
from sympy.polys.domains import GF
from sympy.polys.rings import ring


def expire(signum, frame):
    raise TimeoutError("total three-second mathematical budget expired")


def main():
    out = Path(__file__).resolve().parents[2].parent / "litt3-computation-data" / "oct03_q0_degree_four_elliptic_trivial_class_gate"
    out.mkdir(parents=True, exist_ok=True)
    payload = {"scope": "coprime elliptic Q-nonWeier necessary trivial derivative-class equations ONLY",
               "normalization": "D=1, omega^2+omega+1=0", "cases": [],
               "mathematical_wall_cap_seconds": 3, "single_core": True}
    signal.signal(signal.SIGALRM, expire)
    start, cpu = time.monotonic(), time.process_time()
    signal.setitimer(signal.ITIMER_REAL, 3)
    try:
        for delta in (1, -1):
            row = {"delta": delta, "status": "deriving"}
            payload["cases"].append(row)
            R, z, u, l0, l1, om = ring("z,u,l0,l1,om", GF(5))
            relation = om**2+om+1
            red = lambda f: f.rem(relation)
            v = red((delta*om**2*(om+u)-(1+u))*(3*om+1))
            w = red(1+u-v)
            a = red(om**2*w**2)
            Q, L = z-a, l1*z+l0
            b, c = v*z+w, z+u
            A, B = c*L, b*L
            phi = red(z*(L**2+(z-om**2)*Q))
            U = red(A.diff(z)*z*Q-A*(2*z-a))
            C = red(B.diff(z)*Q-B)
            V = red((b.diff(z)*phi+3*b*phi.diff(z))*Q-b*(3*phi-2*a*phi.exquo(z)))
            W = red((c.diff(z)*phi+3*c*phi.diff(z))*Q-c*phi)
            ba, ca = red(v*a+w), red(a+u)
            equations = [red(U**2+ba*(2*V+ba*phi)), red(C**2+ca*(2*W+ca*phi))]
            assert red(2*W+ca*phi-(Q*c*phi.diff(z)-ca*phi)) == 0
            coeffs = []
            for eq in equations:
                assert all(ex[0] <= 4 for ex in eq)
                for j in range(5):
                    coeffs.append(R.from_dict({(0, *ex[1:]): co for ex, co in eq.items() if ex[0] == j}))
            opens = {"a": a, "w": w, "b_at_a": ba, "c_at_a": ca,
                     "v": v, "l1": l1, "phi_degree_three": l1**2+1,
                     "phi_simple_zero": red(l0**2+om**2*a), "L_at_a": red(l1*a+l0),
                     "U_degree_two": red(l0+(u+a)*l1)}
            open_product = R.one
            for value in opens.values():
                assert value != 0
                open_product = red(open_product*value)
            row.update({"equations": [str(f.as_expr()) for f in coeffs],
                        "opens": {k: str(f.as_expr()) for k, f in opens.items()},
                        "status": "derived"})
            singular = lambda f: str(f.as_expr()).replace("**", "^")
            text = ("ring r=5,(inv,u,l0,l1,om),dp;\nideal I="+
                    ",".join(singular(f) for f in coeffs)+
                    ",om^2+om+1,inv*("+singular(open_product)+")-1;\n"+
                    "ideal J=std(I);\nprint(\"BEGIN_BASIS\");\nJ;\nprint(\"END_BASIS\");\nquit;\n")
            source = out / ("delta_"+str(delta)+".sing")
            source.write_text(text)
            inv, su, sl0, sl1, som = sp.symbols("inv u l0 l1 om")
            basis = sp.groebner([f.as_expr() for f in coeffs]+[som**2+som+1, inv*open_product.as_expr()-1],
                                inv, su, sl0, sl1, som, modulus=5, order="grevlex")
            row.update({"status": "completed", "backend": "SymPy grevlex GF5",
                        "basis": [str(f.as_expr()) for f in basis.polys],
                        "unit_ideal": list(basis) == [1]})
    except TimeoutError:
        payload["budget_expired"] = True
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        payload["CPU_seconds_python"] = time.process_time()-cpu
        payload["wall_seconds"] = time.monotonic()-start
        (out / "gate_sympy.json").write_text(json.dumps(payload, indent=2)+"\n")
    print(json.dumps({"cases": [(r["delta"], r["status"], r.get("unit_ideal")) for r in payload["cases"]],
                      "budget_expired": payload.get("budget_expired", False),
                      "wall_seconds": payload["wall_seconds"], "receipt": str(out / "gate_sympy.json")}))


if __name__ == "__main__":
    main()
