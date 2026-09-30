#!/usr/bin/env python3
"""Reproduce exact input checks and algebraic bookkeeping.

NOT an existence search, not a Groebner computation, not a check of an
admissible model. The mathematical lemmas are proved in REPORT.md.
"""
from __future__ import annotations
import argparse
import json
import platform
import sys
from pathlib import Path
from itertools import product
import ff25 as F
import trace_field

ROOT = Path(__file__).resolve().parents[1]


def require(test: bool, message: str) -> None:
    if not test:
        raise AssertionError(message)


def bezout(label: str, a: list[int], b: list[int]) -> dict:
    g, s, t = F.xgcd(a, b)
    require(g == [1], f"{label}: nontrivial gcd")
    require(F.padd(F.pmul(a,s), F.pmul(b,t)) == [1], f"{label}: bad Bezout")
    return {"label":label, "a":a, "b":b, "s":s, "t":t, "gcd":g}


def addv(*args: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(sum(v[i] for v in args) for i in range(len(args[0])))


def sv(a: int, v: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(a*x for x in v)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT / "evidence/checks.json")
    parser.add_argument("--reference", type=Path, help="compare with recorded evidence, ignoring interpreter version")
    args = parser.parse_args()
    data = json.loads((ROOT / "input/endpoint.json").read_text())
    require(F.mul(5,5) == F.add(5,3), "beta relation")
    for a,b,c in product(range(25), repeat=3):
        require(F.mul(a,F.add(b,c)) == F.add(F.mul(a,b),F.mul(a,c)), "distributivity")
        require(F.mul(F.mul(a,b),c) == F.mul(a,F.mul(b,c)), "associativity")
    for a in range(1,25):
        require(F.mul(a,F.inv(a)) == 1, "inverse")
    P, A = data["P"], data["A"]
    pp, ap = F.derivative(P), F.derivative(A)
    certs = [bezout("P squarefree", P, pp),
             bezout("A squarefree", A, ap),
             bezout("P and A coprime", P, A),
             bezout("P and A-prime coprime", P, ap),
             bezout("A-prime squarefree", ap, F.derivative(ap))]
    # Integrate P*A^2 exactly, with coefficients of x^(5j) in Q set to zero.
    PA2 = F.pmul(P,F.pmul(A,A))
    Q = [0]*(len(PA2)+1)
    for i,c in enumerate(PA2):
        if (i+1) % 5 == 0:
            require(c == 0, "P*A^2 is not a polynomial derivative")
        else:
            Q[i+1] = F.mul(c,F.inv((i+1) % 5))
    require(F.derivative(Q) == PA2, "Q-prime=P*A^2")
    cv = F.critical_value_polynomial(A)
    require(len(cv) == 4 and cv[-1] == 1 and cv[0] != 0,
            "critical values: degree or zero value")
    certs.append(bezout("critical values distinct", cv, F.derivative(cv)))
    # Exponents of (epsilon,t), q=epsilon^4*t^-13, H=epsilon^-17*t^48.
    q, H = (4,-13), (-17,48)
    lattice = {
        "determinant": 4*48-(-13)*(-17),
        "q^48_H^13": list(addv(sv(48,q),sv(13,H))),
        "q^17_H^4": list(addv(sv(17,q),sv(4,H))),
        "epsilon^7_q^11_H^3": list(addv((7,0),sv(11,q),sv(3,H))),
        "epsilon^-1_q^-4_H^-1": list(addv((-1,0),sv(-4,q),sv(-1,H)))
    }
    require(lattice["determinant"] == -29, "determinant")
    require(lattice["q^48_H^13"] == [-29,0], "constant invariant")
    require(lattice["q^17_H^4"] == [0,-29], "parameter power")
    require(lattice["epsilon^7_q^11_H^3"] == [0,1], "parameter reconstruction")
    require(lattice["epsilon^-1_q^-4_H^-1"] == [0,4], "fourth parameter power")
    # Monomial computations in (delta,t,R,b), where R=P(v)/P(u), b=dv/du.
    # Relations: delta^3=epsilon^-17, b^3=delta^3*t^48*R^2.
    r3 = (3,48,3,-3)
    r3_reduced = addv(r3, (0,0,0,3), (-3,-48,-2,0))
    require(r3_reduced == (0,0,1,0), "r^3=R")
    theta_ratio = (-2,-32,-2,3)  # b/r^2
    theta_reduced = addv(theta_ratio, (3,48,2,-3))
    require(theta_reduced == (1,16,0,0), "theta ratio")
    # Under a^29=1, (t,epsilon)->(a*t,a^-4*epsilon) preserves both equations.
    gauge_q_exp = -4*4-13
    gauge_H_exp = (-4)*(-17)+48
    require(gauge_q_exp % 29 == 0 and gauge_H_exp % 29 == 0, "mu29 action")
    integer_checks = []
    for n in range(data["n_min"],data["n_max"]+1):
        bound = min(n,data["genus_upper_absolute"])
        require(3*(2*bound-2) < 16*n, "noncube RH inequality")
        integer_checks.append({"n":n,"genus_upper":bound,
                               "cube_embedding_degree_integral": n % 3 == 0,
                               "3*(2*gmax-2)":3*(2*bound-2),"16*n":16*n})
    # Local Kummer index table, illustrative finite check of an all-integer proof.
    local = []
    from math import gcd
    for m in range(1,19):
        d = gcd(3,m)
        e_pi = 3//d
        e_h = m//d
        require((e_h == 1) == (m in (1,3)), "local Kummer criterion")
        local.append({"endpoint_index":m,"Kummer_index":e_pi,"map_to_X_index":e_h})
    # Pole difference: 3*(h_v^*O-h_u^*O)=3*pi^*(D0-Dinf).
    # Ordering D,D0,Dinf.
    pole_u, pole_v = (1,0,3),(1,3,0)
    difference = addv(pole_v,sv(-1,pole_u))
    require(difference == (0,3,-3), "pole-divisor difference")
    trace_certificate=trace_field.certificate(P,A)
    result = {
        "status":"PASS",
        "purpose":"exact input checks and proof bookkeeping; NOT a solution-locus search",
        "python_version":platform.python_version(),
        "implementation":platform.python_implementation(),
        "dependencies":"Python standard library only",
        "field_axiom_triples_checked":25**3,
        "P_prime":pp,"A_prime":ap,"critical_value_polynomial":cv,
        "Q":Q,"P_times_A_squared":PA2,"Q_prime_equals_P_A_squared":True,
        "bezout_certificates":certs,"exponent_lattice":lattice,
        "trace_field_certificate":trace_certificate,
        "r3_reduced_exponents":list(r3_reduced),
        "theta_ratio_reduced_exponents":list(theta_reduced),
        "gauge_exponents":[gauge_q_exp,gauge_H_exp],
        "noncube_integer_sanity_checks":integer_checks,
        "local_index_table_illustrative_m_1_to_18":local,
        "pole_difference":list(difference),
        "actual_candidates_constructed":0,
        "unknown_geometric_parameters_searched":False,
        "new_degrees_excluded":[],
        "target_existence_status":"UNRESOLVED"
    }
    if args.reference:
        expected = json.loads(args.reference.read_text())
        omit = {"python_version", "implementation"}
        require({k:v for k,v in expected.items() if k not in omit} ==
                {k:v for k,v in result.items() if k not in omit},
                "recomputed evidence differs from reference")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+"\n")
    print("PASS: exact F_25 arithmetic (15,625 triples), 24 inverses")
    print("PASS: six polynomial Bezout certificates")
    print("Critical-value polynomial (ascending F_25 codes):", cv)
    print("PASS: exponent identities, mu_29 gauge, cubic reconstruction, pole difference")
    print("PASS: exact polynomial primitive Q-prime=P*A^2")
    print("PASS: irreducible A, canonical endpoint labels, c normal basis determinant [2]")
    print("PASS: trace(c)/eta=[17] not in F_5; short-relation Frobenius exponents")
    if args.reference:
        print("PASS: recomputed evidence agrees with reference (interpreter version ignored)")
    print(f"PASS: {len(integer_checks)} noncube inequality sanity checks; local table m=1..18")
    print("NOT RUN: any search over branch polynomials, endpoint functions, or geometric parameters")
    print("LEGACY STAGE: original reductions alone did not exclude a degree; see verify_moments.py for the new n=14 result")
    print("Wrote", args.output.name)

if __name__ == "__main__":
    main()
