#!/usr/bin/env python3
"""Exact four-value separation supporting the V4 logarithmic-variation lemma.

Uses the verified K=F25[alpha] arithmetic of the retained degree140 package.
This verifies the finite input, not the formal differential proof itself.
"""
import argparse
import json
from pathlib import Path
import sys


def main():
    p = argparse.ArgumentParser()
    p.add_argument("field_workspace", type=Path)
    p.add_argument("--out", type=Path, required=True)
    a = p.parse_args()
    sys.path.insert(0, str(a.field_workspace.resolve() / "src"))
    import ff
    P = [11,22,18,5,19,20,15,16,9,22,1]
    A = [1,21,14,22,13]
    Ap, App, Pp = ff.pder(A), ff.pder(ff.pder(A)), ff.pder(P)
    rows = []
    for j in range(4):
        alpha = ff.powf(25, 25**j)
        assert ff.peval(A, alpha) == 0
        aa, pa = ff.peval(Ap, alpha), ff.peval(P, alpha)
        rhs = ff.div(ff.mul(3, ff.mul(ff.powf(pa, 2), ff.powf(aa, 3))), ff.powf(13, 3))
        B = ff.powf(rhs, pow(29, -1, 390624))
        assert B and ff.powf(B, 29) == rhs
        lead_u = ff.div(ff.mul(13, ff.powf(B, 4)), aa)
        variation = ff.mul(lead_u, ff.sub(ff.div(ff.peval(Pp, alpha), pa), ff.div(ff.peval(App, alpha), aa)))
        assert variation
        rows.append({"j": j, "alpha": alpha, "B": B,
                     "variation": variation, "variation_29": ff.powf(variation, 29)})
    assert len({x["alpha"] for x in rows}) == 4
    assert len({x["variation_29"] for x in rows}) == 4
    expected = [68043,140725,52980,386664]
    assert [x["variation_29"] for x in rows] == expected
    # Universal formal calculation, z=1+T. R0'(z)=0 makes its variation
    # start in T^5, so these degrees suffice for the differential obstruction.
    def product(p, q):
        out = [0]*5
        for i, x in enumerate(p):
            for j, y in enumerate(q):
                if i+j < 5: out[i+j] = (out[i+j]+x*y)%5
        return out
    def power(p, n):
        out = [1,0,0,0,0]
        for _ in range(n): out = product(out,p)
        return out
    def divide(p, q):
        out = [0]*5
        for i in range(5):
            out[i] = ((p[i] if i<len(p) else 0)-sum(q[j]*out[i-j] for j in range(1,min(i,len(q)-1)+1)))*pow(q[0],-1,5)%5
        return out
    z = [1,1,0,0,0]
    z3,z4,z8 = power(z,3),power(z,4),power(z,8)
    denominator = [((1 if i==0 else 0)-3*z3[i])%5 for i in range(5)]
    f0 = divide([(2*(z4[i]-z[i]))%5 for i in range(5)],denominator)
    f1 = divide(z8,product(denominator,denominator))
    assert f0[:4] == [0,2,0,2]
    assert f1[:3] == [4,1,1]
    second_variation = (6*f0[3]+2*f1[2])%5
    assert second_variation == 4
    a.out.parent.mkdir(parents=True, exist_ok=True)
    a.out.write_text(json.dumps({
        "status": "PASS", "field_order": 390625,
        "encoding": "c0+25*c1+625*c2+15625*c3; beta^2=beta+3; alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0",
        "rows": rows,
        "universal_z_minus_one_series": {"F0_over_B": f0, "F1_over_B_Lambda": f1},
        "second_variation_coefficient": second_variation,
        "second_variation_meaning": "At invariant W0=B+B*Lambda*t+O(t^2), the local vector field has second derivative (4*Lambda/B)*t+O(t^2), nonzero.",
        "conclusion": "For the 116 endpoint labels, Lambda=c/B is nonzero and injective: within each mu29 orbit Lambda scales by zeta^4; the four Lambda^29 values differ.",
        "not_claimed": "This arithmetic alone does not prove the formal comparison lemma or exclude V4."
    }, indent=2) + "\n")
    print("PASS: the logarithmic-variation constants distinguish all116 endpoint labels.")


if __name__ == "__main__":
    main()
