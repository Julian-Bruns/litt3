"""Verify input polynomial identities and the original interpolation certificate."""
import json
from ff25 import *


def run():
    # Exhaustive small-field checks independently exercise the code convention.
    assert mul(5, 5) == 8  # a^2=a+3
    for a in range(25):
        assert add(a, neg(a)) == 0
        assert power(a, 25) == a
        if a:
            assert mul(a, inv(a)) == 1
        for b in range(25):
            assert mul(a, b) == mul(b, a)
            for c in range(25):
                assert mul(a, add(b, c)) == add(mul(a, b), mul(a, c))
                assert mul(mul(a, b), c) == mul(a, mul(b, c))
    assert derivative(Q) == pmul(P, ppow(A0, 2))
    assert pgcd(P, derivative(P)) == [1]
    assert pgcd(A0, derivative(A0)) == [1]
    assert pgcd(P, A0) == [1]
    B = interpolate_B()
    assert B == B_EXPECTED
    assert pmod(padd(ppow(B, 5), Q), P) == [0]
    # In fact the cancellation has order at least two at every root of P.
    assert pmod(padd(ppow(B, 5), Q), ppow(P, 2)) == [0]
    r = sub(mul(B[8], inv(B[9])), P[9])
    assert r == 18 and evaluate(P, r) == 12
    return {
        "status": "PASS", "field_axioms_exhaustively_checked": True,
        "Q_prime_equals_P_A0_squared": True,
        "P_squarefree": True, "A0_squarefree": True,
        "P_A0_coprime": True, "B": B,
        "B5_plus_Q_mod_P2": [0],
        "forced_missing_root_code": r,
        "P_at_forced_missing_root_code": evaluate(P, r),
        "scope": "Exact finite-field arithmetic; geometric consequences are proved in the report."
    }


if __name__ == "__main__":
    print(json.dumps(run(), indent=2))
