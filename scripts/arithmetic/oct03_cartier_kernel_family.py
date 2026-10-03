#!/usr/bin/env python3
"""Universal polynomial checks over F_5 for the marked Cartier-kernel chart.

No finite-field sampling or geometric emptiness assertion.  Stdlib only.
The variable a is independent of c, so the identities also apply at a=c-1.
"""

import argparse
import json
import platform
from pathlib import Path


class Poly:
    names = (
        "z", "a", "c", "d", "b", "e", "p0", "p1", "p2",
        "h0", "h1", "h2", "h3", "h11", "q0", "q1", "q2",
    )
    n = len(names)

    def __init__(self, data=0):
        if isinstance(data, Poly):
            self.terms = dict(data.terms)
        elif isinstance(data, int):
            self.terms = {(0,) * self.n: data % 5} if data % 5 else {}
        else:
            self.terms = {k: v % 5 for k, v in data.items() if v % 5}

    @classmethod
    def variable(cls, name):
        exponents = [0] * cls.n
        exponents[cls.names.index(name)] = 1
        return cls({tuple(exponents): 1})

    def __add__(self, other):
        result = dict(self.terms)
        for key, value in Poly(other).terms.items():
            result[key] = (result.get(key, 0) + value) % 5
        return Poly(result)

    __radd__ = __add__

    def __neg__(self):
        return Poly({key: -value for key, value in self.terms.items()})

    def __sub__(self, other):
        return self + (-Poly(other))

    def __rsub__(self, other):
        return Poly(other) - self

    def __mul__(self, other):
        result = {}
        for left, lv in self.terms.items():
            for right, rv in Poly(other).terms.items():
                key = tuple(x + y for x, y in zip(left, right))
                result[key] = (result.get(key, 0) + lv * rv) % 5
        return Poly(result)

    __rmul__ = __mul__

    def __pow__(self, power):
        result = Poly(1)
        base = self
        while power:
            if power & 1:
                result = result * base
            base = base * base
            power >>= 1
        return result

    def derivative(self):
        result = {}
        for exponents, value in self.terms.items():
            if exponents[0]:
                key = (exponents[0] - 1,) + exponents[1:]
                result[key] = value * exponents[0]
        return Poly(result)

    def over_z(self):
        assert all(key[0] > 0 for key in self.terms)
        return Poly({(key[0] - 1,) + key[1:]: value
                     for key, value in self.terms.items()})

    def is_zero(self):
        return not self.terms

    def coefficient(self, degree):
        return Poly({(0,) + key[1:]: value
                     for key, value in self.terms.items() if key[0] == degree})


def pair_add(left, right):
    return left[0] + right[0], left[1] + right[1]


def pair_mul(left, right, phi):
    return (left[0] * right[0] + phi * left[1] * right[1],
            left[0] * right[1] + left[1] * right[0])


def checks():
    v = {name: Poly.variable(name) for name in Poly.names}
    z, a, c, d, b, e = [v[name] for name in ("z", "a", "c", "d", "b", "e")]
    phi = a * z**5 + c * z**4 + d
    f = b * z**2 + e * z**3
    u = f.derivative() * phi - 2 * c * z**3 * f
    vv = u.derivative() * phi - c * z**3 * u

    # Multiply g C + 3g' B + g'' A by w^7 for the explicit p=1 example.
    f0 = e * z**3
    u0 = f0.derivative() * phi - 2 * c * z**3 * f0
    vv0 = u0.derivative() * phi - c * z**3 * u0
    first = pair_mul(pair_mul((f0, z), (Poly(0), Poly(1)), phi),
                     (e * phi + c * e * z**4, -c * z**2), phi)
    second = pair_mul((3 * u0, 3 * phi), (2 * c * z**3, e * z), phi)
    total = pair_add(pair_add(first, second), (vv0, Poly(0)))
    assert all(item.is_zero() for item in total)

    # Check the full general-chart elimination, without division at a root.
    p = v["p0"] + v["p1"] * z + v["p2"] * z**2
    h0 = v["h0"] + v["h1"] * z + v["h2"] * z**2 + v["h3"] * z**3
    h1 = 3 * v["p1"] + v["h11"] * z
    q1 = v["q0"] + v["q1"] * z + v["q2"] * z**2
    db = 2 * p.derivative() * phi + 2 * c * z**3 * p
    dc = (4 * p.derivative().derivative() + 2 * v["h11"]) * phi + 4 * c * z**3 * h1
    q0 = -(z * dc + f * (q1 + 4 * h0.derivative())
           + 3 * (db + phi * h1) + 3 * f.derivative() * h0).over_z()
    assert all(key[0] <= 4 for key in q0.terms)
    odd = z * (dc + q0) + f * (q1 + 4 * h0.derivative()) + 3 * (db + phi * h1) + 3 * f.derivative() * h0
    assert odd.is_zero()
    even = (f * phi * (dc + q0)
            + z * phi * ((q1 + 4 * h0.derivative()) * phi + c * z**3 * h0)
            + 3 * phi**2 * h0 + 3 * u * (db + phi * h1) + vv * p)
    r = phi - f.over_z()**2
    z1 = u - f.over_z() * phi
    v1 = u.derivative() - c * z**2 * f
    t0 = c * z**4 + 3 * phi - 3 * (f * f.derivative()).over_z()
    reduced = (z * r * q1 + 4 * z * r * h0.derivative()
               + 3 * (4 * v["p2"] + v["h11"]) * z * z1
               + p * v1 + t0 * h0)
    assert (even - phi * reduced).is_zero()
    assert all(key[0] <= 8 for key in reduced.terms)

    # Universal b=0 solutions for every p of degree <=2 and h11.
    h0s = e * z * (v["p0"] + v["p1"] * z + v["h11"] * z**2)
    q1s = 2 * e * v["p0"] + 3 * e * v["p1"] * z - e * v["h11"] * z**2
    r0 = phi - e**2 * z**4
    z10 = 2 * e * z**2 * (a * z**5 + d)
    v10 = e * z * (a * z**5 + d)
    t00 = 3 * a * z**5 + 4 * (c - e**2) * z**4 + 3 * d
    special = (z * r0 * q1s + 4 * z * r0 * h0s.derivative()
               + 3 * (4 * v["p2"] + v["h11"]) * z * z10
               + p * v10 + t00 * h0s)
    assert special.is_zero()

    # The canonical degree-three-line gate in the entire marked chart.
    pp = v["p0"]
    hh = v["h0"] + v["h1"] * z
    line_gate = (z * r * (v["q0"] + 4 * v["h1"])
                 + pp * v1 + t0 * hh)
    assert (line_gate.coefficient(0) - d * (2 * b * pp + 3 * v["h0"])).is_zero()
    assert (line_gate.coefficient(2) - 4 * b**2 * v["h0"]).is_zero()
    assert (line_gate.coefficient(3) + b**2 * v["q0"]).is_zero()
    assert (line_gate.coefficient(6) - a * (v["q0"] + e * pp + 2 * v["h1"])).is_zero()
    return {
        "status": "PASS",
        "field": "F_5 with independent symbolic parameters",
        "checks": [
            "explicit p=1 annihilator identity, even and odd coefficients zero",
            "general chart odd-character elimination and deg Q0<=4",
            "general chart even numerator equals Phi times the displayed reduced equation",
            "reduced equation has z-degree<=8",
            "b=0 family solves the reduced equation for every p0,p1,p2,h11",
            "canonical degree-three-line gate has the four decisive coefficients displayed in the report",
        ],
        "scope": "Universal polynomial identities only; local/global regularity is proved in the prose report.",
        "python": platform.python_version(),
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = checks()
    rendered = json.dumps(result, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")
