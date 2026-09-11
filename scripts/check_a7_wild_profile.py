"""Small exact checks for the alternating Hermitian quotient (not a cover census)."""
from fractions import Fraction
from itertools import permutations
import json


def compose(p, q):
    return tuple(p[q[i]] for i in range(7))


def inverse(p):
    result = [0] * 7
    for i, j in enumerate(p):
        result[j] = i
    return tuple(result)


def even(p):
    return sum(p[i] > p[j] for i in range(7) for j in range(i + 1, 7)) % 2 == 0


identity = tuple(range(7))
generator = (1, 2, 3, 4, 0, 5, 6)
powers = [identity]
for _ in range(4):
    powers.append(compose(generator, powers[-1]))
group = [p for p in permutations(range(7)) if even(p)]
assert len(group) == 2520
normalizer, centralizer, sylows, action = [], [], set(), set()
for p in group:
    conjugate = compose(compose(p, generator), inverse(p))
    conjugate_subgroup = frozenset(compose(compose(p, h), inverse(p)) for h in powers)
    sylows.add(conjugate_subgroup)
    if conjugate in powers:
        normalizer.append(p)
        action.add(powers.index(conjugate))
    if conjugate == generator:
        centralizer.append(p)
assert len(normalizer) == 20 and len(centralizer) == 5
assert len(sylows) == 126 and action == {1, 2, 3, 4}
assert Fraction(18, 2520) == Fraction(1, 140)
assert -2 + Fraction(43, 20) > Fraction(1, 140)
tame_sum = Fraction(18, 2520) + 2 - Fraction(23, 20)
assert tame_sum == Fraction(6, 7)
assert 1 / (1 - tame_sum) == 7
assert 280 * 50 == 14000 and 14000 * 3 == 42000
print(json.dumps(dict(status="PASS", group_order=len(group),
    sylow_five_subgroups=len(sylows), normalizer_order=len(normalizer),
    centralizer_order=len(centralizer), conjugation_multipliers=sorted(action),
    wild_inertia=20, wild_break=1, wild_different=23, tame_order=7,
    orbifold_canonical_degree="1/140", psu_index=50,
    scope="Elementary group and Hurwitz checks; geometric proof and embedding separate."), indent=2))
