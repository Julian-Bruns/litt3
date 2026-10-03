#!/usr/bin/env -S sage -python
"""Fresh bounded expansions only: no Groebner basis or candidate sweep.

The field is F5[omega]/(omega^2+omega+1), with the actual centered
quadratic constant D=2*omega+1. All receipts live outside litt3.
"""
import json
import signal
import time
from pathlib import Path

from sympy.polys.domains import GF
from sympy.polys.rings import ring


def alarm_handler(signum, frame):
    raise TimeoutError("three-second mathematical phase expired")


def quartic_disc(L, B, C, E1, E0):
    return (256*L**3*E0**3 - 192*L**2*B*E1*E0**2
            - 128*L**2*C**2*E0**2 + 144*L**2*C*E1**2*E0
            - 27*L**2*E1**4 + 144*L*B**2*C*E0**2
            - 6*L*B**2*E1**2*E0 - 80*L*B*C**2*E1*E0
            + 18*L*B*C*E1**3 + 16*L*C**4*E0
            - 4*L*C**3*E1**2 - 27*B**4*E0**2
            + 18*B**3*C*E1*E0 - 4*B**3*E1**3
            - 4*B**2*C**3*E0 + B**2*C**2*E1**2)


def receipt(name, names, build):
    R, *gens = ring("X,z," + ",".join(names) + ",omega", GF(5))
    X, z = gens[:2]
    omega = gens[-1]
    qrel = omega**2 + omega + 1
    reduce = lambda f: f.rem(qrel)
    f, opens, meta = build(X, z, gens[2:-1], omega)
    f = reduce(f)
    coefficients = []
    for j in range(5):
        coefficients.append(R.from_dict({(ex[0], 0, *ex[2:]): co
                                         for ex, co in f.items() if ex[1] == j}))
    assert all(ex[1] <= 4 for ex in f)
    disc = reduce(quartic_disc(*coefficients[::-1]))
    dcoeffs = {}
    for j in range(max(ex[0] for ex in disc)+1):
        cj = R.from_dict({(0, *ex[1:]): co for ex, co in disc.items() if ex[0] == j})
        dcoeffs[str(j)] = str(cj.as_expr())
    assert all(ex[1] == 0 for ex in disc)
    leading = R.from_dict({(0, *ex[1:]): co for ex, co in disc.items() if ex[0] == 8})
    predicted = reduce(3*meta["a"]**4*coefficients[0]**2)
    assert leading == predicted
    return {"name": name, "parameter_names": names,
            "quartic": str(f.as_expr()),
            "quartic_coefficients_ascending": [str(c.as_expr()) for c in coefficients],
            "discriminant_degree_X": 8,
            "discriminant_coefficients_ascending": dcoeffs,
            "required_opens": {k: str(reduce(v).as_expr()) for k, v in opens.items()},
            "leading_discriminant_assertion": "3*a^4*quartic_constant^2",
            "status": "EXACT_EXPANSION_ONLY"}


def genus_two(X, z, p, omega):
    a, A0, A1, A2 = p
    D = 2*omega+1
    A = A2*z**2+A1*z+A0
    f = z**3*(z-a)*X**2-2*z**2*A*X+A**2-D*a*(1-z**3)
    opens = {"a": a, "constant": A0**2-D*a,
             "degree_five": A2**2-D}
    return f, opens, {"a": a}


def elliptic_build(delta):
    def build(X, z, p, omega):
        u, L0, L1 = p
        qrel = omega**2+omega+1
        reduce = lambda f: f.rem(qrel)
        D = 2*omega+1
        inv = 3*omega+1
        assert reduce((omega-1)*inv) == 1
        v = reduce((delta*omega**2*(omega+u)-(1+u))*inv)
        w = reduce(1+u-v)
        a = reduce(omega**2*w**2)
        assert reduce(2*u-v**2+a+1+omega) == 0
        assert reduce(u**2-2*v*w-a*(1+omega)-omega) == 0
        L = L1*z+L0
        f = (z**3*(z-a)*X**2-2*z**2*(z+u)*L*X
             +(z-1)*(z-omega)*L**2-D*(v*z+w)**2*(z-omega**2))
        opens = {"a": a, "w": w, "a_plus_u": a+u,
                 "va_plus_w": v*a+w, "degree_three": L1**2+D,
                 "root_zero": L0**2+D*omega**2*a}
        return f, opens, {"a": a}
    return build


def main():
    signal.signal(signal.SIGALRM, alarm_handler)
    signal.setitimer(signal.ITIMER_REAL, 3.0)
    start = time.process_time()
    rows = [receipt("genus_two", ["a", "A0", "A1", "A2"], genus_two)]
    for delta in (1, -1):
        rows.append(receipt("elliptic_coprime_delta_"+str(delta),
                            ["u", "L0", "L1"], elliptic_build(delta)))
    elapsed = time.process_time()-start
    signal.setitimer(signal.ITIMER_REAL, 0)
    out = Path(__file__).resolve().parents[2].parent / "litt3-computation-data" / "oct03_q0_degree_four_sparse_discriminants" / "discriminants.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    payload = {"field_relation": "omega^2+omega+1=0", "centered_D": "2*omega+1",
               "CPU_seconds": elapsed, "mathematical_wall_cap_seconds": 3,
               "rows": rows, "scope": "Exact necessary discriminant expansions; no solving, Groebner, sweep or exclusion"}
    out.write_text(json.dumps(payload, indent=2)+"\n")
    print(json.dumps({"output": str(out), "CPU_seconds": elapsed,
                      "rows": [r["name"] for r in rows], "status": "PASS_EXPANSION_ONLY"}))


if __name__ == "__main__":
    main()
