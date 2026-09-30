# Proof: the two returned rank-three refinements

[Statement](../../Theorems/cartier_and_spin/rank_three_radical_orbit_constraints.md).
Version2,23September2026. Focused author integration of the two rank-three
replies. Their coefficient computation passes and agrees with the
existing positive plane up to scalar. Keep all actual relative twists.

## The actual trace and its defect

The inclusion ell_0->q^*B_Y, followed by finite étale trace
adjunction, gives I=image(q_*ell_0->B_Y). After q-pullback this
is the sum of the actual inclusions, including stabilizer multiplicity;
no degree is inverted in the ground field. The coefficient is strongly
semistable of slope-3/8 because it splits after q-pullback.
Thus 3 mu(I)=deg I>=-9/8, hence deg I>=-1 and tau<=e+1.

Dualizing the same map with the actual Cartier pairing gives
\[
B_Y\longrightarrow q_*h^*O_X(19O),
\]
whose pullback kernel is the intersection of all h_i^*U.
This is the actual annihilator; it does not supply an X-component.

## Local incidence and the canonical filtration

At a point where the evaluated A generator has order m<=3,
subtract its Frobenius-constant primitive component and change
formal parameter to write its class as z^(m+1).
In the basis z,z^2,z^3,z^4 of B, its perpendicular omits z^(4-m).
An orbit line has primitive sum b_j(z^5)z^j and evaluation
sum j b_j(z^5)z^(j-1) dz, whose zeros are all simple.
For m=3 its constant evaluation term vanishes, forcing a simple
zero. For m=2 the linear coefficient is absent, forbidding a simple
zero. This proves the simultaneous triple/double incidence claims.
It also proves that the full E evaluation image is omega(-R_A[3]).

The gcd of the reduced orbit divisors is invariant and descends to
C. Degree31d bounds deg C by3. Outside E/I the orbit generates E,
so its evaluated gcd is precisely R_A[3]. The extra reduced support
has size at most tau. For e=-1 there is no defect and the gcd is exact.

In the same local model the three Taylor-filtration image defects are
(0,0,0), (1,0,0), (1,1,0), (1,1,1) for m=0,1,2,3,
respectively. This gives the three stated line bundles. Their degrees
sum to12-deg R_A=5e. If e=-1, the degree of the first grade is
6-deg(R_A)_red<=-5/3, yielding the lower bound8.

## The orbit-plane degree gap

Set A_T=q^*A and P_i=Sat(A_T+ell_i). The full orbit permutes these
planes, so their degree is a common m. They cannot all be equal,
since the radical orbit has rank3. For two distinct planes their
saturated intersection is exactly A_T; their sum is contained in q^*E.
Therefore 2m-deg A_T<=8de, giving m<=8d(e-1).
The generating lines give m>=deg A_T-3d=(8e-19)d.

The line P_i/ell_i sits in h_i^*(O(6O)+O(10O)).
If its projection to O(6O_i) is nonzero it has degree at most6d,
so m<=3d. Otherwise saturation makes it exactly O(10O_i),
so m=7d and P_i=h_i^*P_X. This argument works after any actual
étale pullback, not only on X itself.

The [canonical positive-plane theorem](../../Theorems/cartier_and_spin/positive_cartier_plane_orbits.md)
contains the explicit quotient, reduced branch divisor and stability
calculation. The returned polynomial V=(20,3,24,23,4) equals [20]A;
the alternate quotient row is a scalar multiple of r_2. Its rational
kernel generator has infinity coefficient valuations21,19,26,
recovering O(19O) in the evaluation sequence. H^0(P_X)=0 follows
from linear independence of the three quotient polynomials.

## The exceptional positive case

When e=2 and m=7d, A has degree0 and V_Y=E/A has rank2, degree2.
The lines P_i/A_T of degree7d generate its pullback generically.
Their trace coefficient is strongly semistable of slope7/8. The
all-height quotient slope bound follows. A nonsemistable F_Y^*V_Y
would have a rank-one quotient of integral degree at most4,
contradicting35/8; hence it is semistable.

In P_X the local evaluation orders are (0,1) off R_P and (0,2)
on its simple branch locus. A saturated horizontal line has only
these possible positive zero orders. Applied to the actual A_T
inclusions, this proves that its double-zero fibers lie in all R_i
and its simple-zero fibers avoid all R_i. Their invariant gcd has
degree at most floor(13/8)=1 downstairs. If R_A=2P, it already
contains P and thus equals P.

There is a further contact consequence using the canonical second
line lambda_i of degree-2d. The lines q^*A and lambda_i are distinct
by degree, and their determinant in P_i has zero degree9d.
If R_A=2P, at each point over P both horizontal lines evaluate to
order two. They therefore have the same fiber direction in the
positive plane, the unique direction with vanishing evaluation.
Their determinant vanishes on the corresponding reduced divisor
q^(1)*F_Y(P), of degree8d. Subtract it to obtain an effective
residual of degree d. The full orbit permutes these divisors; an
invariant nonempty common support would contain a fiber of degree8d
and is impossible. If R_A=P+Q is split, its simple-zero fibers avoid
R_i, so lambda_i evaluates nontrivially there whereas q^*A vanishes.
The two directions are distinct and the contact divisor avoids both
fibers. This remains a one-sided incidence statement.

Neither equality of this gcd nor the degree gap proves saturation
through h_i. The argument supplies no whole rank-three exclusion.
The original and rebuilt coefficient files are retained in the
external [manifest](../../../litt3-computation-data/radical_orbit_replies_20260923/manifest.json);
the source [verifier](../../scripts/arithmetic/pro_cartier_orbit_plane.py)
has no dependencies outside the Python standard library.
