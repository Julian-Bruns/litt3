# Exact certificate for Lemma 53.1.
# Run with: sage routes/global/53_X_AUTOMORPHISM_CERTIFICATE.sage

F5 = GF(5)
R5.<x> = PolynomialRing(F5)
f = x^7 - x + 1

# The first three point counts determine the genus-three Weil polynomial.
counts = []
for n in [1, 2, 3]:
    Kn = GF(5^n, name='a')
    count = 1  # the point at infinity
    for xx in Kn:
        value = xx^7 - xx + 1
        count += 1 if value == 0 else (2 if value.is_square() else 0)
    counts.append(count)

assert counts == [8, 30, 134]
RT.<T> = PolynomialRing(ZZ)
weil = T^6 + 2*T^5 + 4*T^4 + 8*T^3 + 20*T^2 + 50*T + 125
power_sums = [5^n + 1 - counts[n - 1] for n in [1, 2, 3]]
assert power_sums == [-2, -4, -8]
c1 = -power_sums[0]
c2 = -(power_sums[1] + c1*power_sums[0])/2
c3 = -(power_sums[2] + c1*power_sums[1] + c2*power_sums[0])/3
reconstructed = T^6 + c1*T^5 + c2*T^4 + c3*T^3 \
                + 5*c2*T^2 + 25*c1*T + 125
assert weil == reconstructed
assert weil == (T^2 - 3*T + 5)*(T^2 + T + 5)*(T^2 + 4*T + 5)

# The branch polynomial has one linear and one irreducible degree-six factor,
# so all eight branch points are rational over its degree-six splitting field.
assert sorted(g.degree() for g, multiplicity in f.factor()) == [1, 6]
K.<a> = f.splitting_field()
RK.<X> = PolynomialRing(K)
roots = [root for root, multiplicity in RK(f).roots()]
points = [vector(K, [root, 1]) for root in roots]
points.append(vector(K, [1, 0]))  # infinity
assert len(points) == 8

def projective_key(point):
    if point[0] == 0:
        return (K(0), K(1))
    return (K(1), point[1]/point[0])

def normalized(matrix_value):
    first = next(entry for entry in matrix_value.list() if entry != 0)
    return first^(-1)*matrix_value

def map_three_points(source, target):
    rows = []
    for source_point, target_point in zip(source, target):
        px, py = source_point
        qx, qy = target_point
        rows.append([qy*px, qy*py, -qx*px, -qx*py])
    kernel = matrix(K, rows).right_kernel()
    if kernel.dimension() != 1:
        return None
    candidate = matrix(K, 2, 2, kernel.basis()[0])
    return candidate if candidate.det() != 0 else None

branch_set = set(projective_key(point) for point in points)
source_triple = points[:3]
stabilizer = {}

from itertools import permutations
for image_indices in permutations(range(8), int(3)):
    target_triple = [points[index] for index in image_indices]
    candidate = map_three_points(source_triple, target_triple)
    if candidate is None:
        continue
    image_set = set(projective_key(candidate*point) for point in points)
    if image_set == branch_set:
        candidate = normalized(candidate)
        stabilizer[tuple(candidate.list())] = candidate

assert len(stabilizer) == 1
assert next(iter(stabilizer.values())) == identity_matrix(K, 2)
print("PASS: Weil polynomial factored and reduced branch stabilizer is trivial")
