# Exact scalar certificate for the cubic Kummer parameter.
# Run from the repository root with:
# sage -c "load('routes/global/EXPLICIT_C3_CUBIC_DIAMOND_WEIL_CERTIFICATE.sage')"
#
# This uses only scalar finite-field arithmetic and polynomial operations;
# in particular, it does not call optimized extension-field matrix rank.

F5 = GF(5)
R5.<x> = PolynomialRing(F5)
k.<a> = GF(5^2, modulus=x^2-x+2)
K.<b> = GF(5^4, modulus='conway')
emb = k.embeddings(K)[0]

assert a^2-a+2 == 0
lam = a+3
assert lam != 0 and lam != 1

def cube_fiber_size(value):
    if value == 0:
        return 1
    Q = value.parent().cardinality()
    assert Q % 3 == 1
    return 3 if value^((Q-1)//3) == 1 else 0

def point_count(field, parameter, kind):
    # The initial 1 is the unique point over infinity.  Each denominator
    # zero below is another totally ramified fiber and contributes one.
    total = 1
    for t in field:
        if kind == 'plus' and t == 1:
            total += 1
            continue
        if kind != 'plus' and t == parameter:
            total += 1
            continue
        if kind == 'Y':
            value = t*(t-1)^2/(t-parameter)
        elif kind == 'plus':
            value = t*(t-parameter)/(t-1)
        elif kind == 'minus':
            value = t*(t-1)/(t-parameter)
        else:
            raise ValueError(kind)
        total += cube_fiber_size(value)
    return total

lamK = emb(lam)
counts = {
    'Y': (point_count(k, lam, 'Y'), point_count(K, lamK, 'Y')),
    'plus': (point_count(k, lam, 'plus'), point_count(K, lamK, 'plus')),
    'minus': (point_count(k, lam, 'minus'), point_count(K, lamK, 'minus')),
}
assert counts == {'Y': (28, 724), 'plus': (22, 592), 'minus': (10, 598)}

Z.<T> = PolynomialRing(ZZ)

def weil_from_counts(N1, N2):
    q = 25
    s1 = q+1-N1
    s2 = q^2+1-N2
    c1 = -s1
    c2 = (s1^2-s2)//2
    return T^4+c1*T^3+c2*T^2+q*c1*T+q^2

PY = weil_from_counts(*counts['Y'])
Pplus = weil_from_counts(*counts['plus'])
Pminus = weil_from_counts(*counts['minus'])

assert PY == (T^2+T+25)^2
assert Pplus == T^4-4*T^3-9*T^2-100*T+625
assert Pminus == (T^2-8*T+25)^2
assert PY[2] % 5 != 0
assert Pplus.is_irreducible()

L = NumberField(Pplus, 'beta')
assert L.discriminant() == 7056
quadratic_subfields = sorted(
    [field.defining_polynomial().discriminant().squarefree_part()
     for field, inclusion, reverse in L.subfields()
     if field.degree() == 2]
)
assert quadratic_subfields == [-21, -3, 7]

# Character-pair genera for the full C_3^3 Kummer cover.  Its inertia
# vectors are e_1,e_2,e_3,-e_1-e_2-e_3.  Pair a character with its negative.
pair_counts = {2: 0, 3: 0, 4: 0}
seen = set()
for i in range(3):
    for j in range(3):
        for ell in range(3):
            chi = (i, j, ell)
            if chi == (0, 0, 0) or chi in seen:
                continue
            negative = tuple((-entry) % 3 for entry in chi)
            seen.add(chi)
            seen.add(negative)
            ramified = sum(entry % 3 != 0 for entry in
                            (i, j, ell, i+j+ell))
            pair_counts[ramified] += 1
assert pair_counts == {2: 6, 3: 4, 4: 3}
assert sum((ramified-2)*number for ramified, number in pair_counts.items()) == 10

print('PASS: exact point counts', counts)
print('PASS: Y is ordinary and its elliptic CM field is Q(sqrt(-11))')
print('PASS: the other Frobenius fields are Q(i) and Q(sqrt(-3),sqrt(7))')
print('PASS: neither can meet Q(sqrt(-11)) nontrivially')
print('PASS: C3^3 character-pair counts', pair_counts, 'give genus 10')
