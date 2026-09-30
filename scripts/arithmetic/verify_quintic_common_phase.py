"""Independent polynomial-basis checks of all 32 retained affine candidates.

The exhaustive linear rejection is performed by quintic_common_phase.cpp;
this verifier checks every remaining obstruction in a different field basis.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent / "pro_quartic_complete_partials_20260927/quartic/src"))
from exact_fields import K, F, T, zeta, beta, embed, evaluate, code, sigma, T_to_F

t = zeta + zeta ** 28
def prime_seven(n):
    r = K.zero
    p = K.one
    for _ in range(7):
        r += (n % 5) * p
        p *= t
        n //= 5
    assert n == 0
    return r

c0 = evaluate([22, 7, 9, 23], T.gen)
e0 = evaluate([1, 3, 8, 15], T.gen)
cs, es = [], []
for _ in range(4):
    cs.append(T_to_F(c0)); es.append(T_to_F(e0))
    c0, e0 = sigma(c0), sigma(e0)
eta = embed(code(22), F)

count = 0
for line in Path(sys.argv[1]).read_text().splitlines():
    if line.startswith("SUMMARY"):
        assert line == "SUMMARY tested 78416 linear 32 lower 0 unique_quadric 0 unique_fourth 0 ranks 0 0 0 0 32"
        continue
    parts = line.split()
    assert len(parts) == 9 and parts[0] == "LINEAR"
    ql, hl = list(map(int, parts[1])), list(map(int, parts[2]))
    phase, x0, x1, y0, y1, residual = map(int, parts[3:])
    x = prime_seven(x0) + embed(beta, K) * prime_seven(x1)
    y = prime_seven(y0) + embed(beta, K) * prime_seven(y1)
    cq = sum((cs[i] for i in ql), F.zero) / eta
    eq = sum((es[i] for i in ql), F.zero) / eta
    ch = sum((cs[i] for i in hl), F.zero) * embed(zeta ** (5 * phase), F) / eta
    eh = sum((es[i] for i in hl), F.zero) * embed(zeta ** (8 * phase), F) / eta
    det = (eq-embed(x.frob(7), F))*(eh-embed(x, F)) - (cq-embed(y, F))*(ch-embed(y.frob(7), F))
    assert residual != 0
    assert det == embed(prime_seven(residual), F), (ql, hl, phase)
    count += 1
assert count == 32
print("PASS: all32 affine candidates fail the original determinant in independent polynomial arithmetic")
