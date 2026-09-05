"""Exact 210-partition ordinarity certificate; run with sage -python.

Labels 0,...,6 mean zeta^i, and label 7 means infinity. No optimized
extension-field matrix routine, point count, or random choice is used.
"""

from itertools import combinations
from sage.all import GF, PolynomialRing, prod

prime = GF(5)
R0 = PolynomialRing(prime,"z")
z = R0.gen()
modulus = sum(z**i for i in range(7))
assert modulus.is_irreducible()
k = GF(5**6,name="zeta",modulus=modulus)
zeta = k.gen()
assert zeta != 1 and zeta**7 == 1
R = PolynomialRing(k,"t")
t = R.gen()
labels = tuple(range(8))
infinity = 7
cache = {}

def ordinary_data(subset):
    subset = tuple(sorted(subset))
    if subset in cache:
        return cache[subset]
    genus = (len(subset)-2)//2
    assert genus in [1,2]
    polynomial = prod(t-zeta**i for i in subset if i != infinity)
    assert polynomial.is_squarefree()
    assert polynomial.degree() == (2*genus+1 if infinity in subset
                                    else 2*genus+2)
    squared = polynomial**2
    # These entries precede the coefficientwise inverse Frobenius in
    # the Cartier matrix. Their determinant is nonzero iff Cartier is
    # bijective. Taking fifth roots cannot change that test.
    entries = [[squared[5*(i+1)-(j+1)] for j in range(genus)]
               for i in range(genus)]
    determinant = (entries[0][0] if genus == 1 else
                   entries[0][0]*entries[1][1]-entries[0][1]*entries[1][0])
    actual_cartier = [[c**(5**5) for c in row] for row in entries]
    actual_determinant = (actual_cartier[0][0] if genus == 1 else
                          actual_cartier[0][0]*actual_cartier[1][1]
                          -actual_cartier[0][1]*actual_cartier[1][0])
    assert actual_determinant**5 == determinant
    cache[subset] = (determinant,polynomial,entries)
    return cache[subset]

partition_count = 0
ordinary_count = 0
for first in combinations(labels,2):
    remaining = [i for i in labels if i not in first]
    for second in combinations(remaining,2):
        if first > second:
            continue
        third = tuple(i for i in remaining if i not in second)
        determinants = [ordinary_data(first+second)[0],
                        ordinary_data(first+third)[0],
                        ordinary_data(second+third)[0]]
        partition_count += 1
        ordinary_count += int(all(d != 0 for d in determinants))
assert partition_count == 210 and ordinary_count == 210
assert len(cache) == 98
assert all(data[0] != 0 for data in cache.values())

first,second,third = (0,1),(2,3),(4,5,6,7)
selected = [first+second,first+third,second+third]
expected_coefficients = [[4,1,2,2,1,4],[4,1,0,0,1,4],[4,4,0,3,4,3]]
for subset,coefficients in zip(selected,expected_coefficients):
    determinant,polynomial,entries = ordinary_data(subset)
    expected = sum(k(c)*zeta**i for i,c in enumerate(coefficients))
    assert determinant == expected and determinant != 0
    print("branch labels",tuple(sorted(subset)),"polynomial",polynomial)
    print("Cartier coefficient matrix before fifth roots",entries)
    print("nonzero determinant",determinant)
print("PASS: all 210 partitions work; all 98 pair-union curves are ordinary.")
print("Selected blocks: {0,1}, {2,3}, {4,5,6,infinity}.")
