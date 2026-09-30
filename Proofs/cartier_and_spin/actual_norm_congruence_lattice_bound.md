# Use the actual norm congruence before minimizing the support lattice

30 September2026.
[Statement](../../Theorems/cartier_and_spin/actual_norm_congruence_lattice_bound.md).
The principal marked-divisor kernel and its gauge are accepted inputs;
their Jacobian arithmetic is not replayed here. The new congruence is
Theorem B, Section4 of the accepted
[marked-norm reply](../../../litt3-computation-data/september29_evening_replies/marked_norm/marked_norm_analysis/REPORT.md).

Write a norm divisor as sum m_j R_j-delta O. Its pole degree is delta:
the common part of the two inverse images of O cancels before taking
the norm. In the rootwise triple(m_i,m_(i+4),m_(i+8)), put
a_i=m_i-m_(i+8) and b_i=m_(i+4)-m_(i+8). Principality says that
h=(a0,...,a3,b0,...,b3) belongs to the exact lattice I. The two-map
congruence says that every a_i and b_i is divisible by three. Thus
h belongs to I_actual=I intersect 3Z^8.

For completeness, the congruence retains both actual maps. In the marked
Jacobian subgroup Gamma, Gamma/3Gamma is F3^4; the three points in each
cubic fibre have the same basis-vector class. The actual push-pull
endomorphism h1_*h2^* restricts to Gamma. Its value on a finite marked
class is the corresponding incidence column, because the O-column has
zero class by principality of the opposite norm. Applying the functional
which sums the four coordinates gives n-M_(O,j) modulo three. Equal
input classes for the three sheets force these three incidence counts
to agree. Reverse the two maps for the other norm. No division by their
degree, Galois closure or presumed descent of an individual divisor is
used.

Removing complete cubic fibres makes the least nonnegative representative
of h have pole
N(h)=sum_(i=0)^3(a_i+b_i+3 max(0,-a_i,-b_i)).
Consequently delta>=N(h). The case h=0 is precisely a complete-fibre
zero divisor, so its function is a polynomial in x up to a constant.

The new exact lattice calculation starts with the eight rows T^j G modulo
T^8+T^4+1 from the principal-ideal theorem, intersects their integer row
lattice with3Z^8, and LLL-reduces the result. The index is81. The existing
exact rational gauge algorithm, applied to THIS NEW lattice, enumerates
307,068 nonzero vectors in its certified Euclidean ball. The minimum is
2,794,059 and there are twelve minimizing vectors. It uses no floating
point approximation in enumeration: N(h)<=U implies ||h||^2<=2U^2,
so its rational Gram--Schmidt recursion covers every possibly improving
vector. The short run took3.25 seconds on one calculation core.

New source:
[congruence intersection](../../scripts/arithmetic/marked_actual_norm_congruence_lattice_20260930.sage).
The unchanged exact gauge source is
[marked_lattice_shortest_effective_20260929.py](../../scripts/arithmetic/marked_lattice_shortest_effective_20260929.py).
The retained new inputs and outputs are
[the lattice](../../../litt3-computation-data/seventeen_hour_continuation_20260929/marked_actual_norm_lattice.json)
and [the enumeration receipt](../../../litt3-computation-data/seventeen_hour_continuation_20260929/marked_actual_norm_effective_bound.json).
Both label this as a necessary actual-norm lattice, with no realization
assertion. The already established old minimum is strictly smaller, so
all its twelve divisors are excluded at once; their individual functions
need not be reconstructed.

This closes an actual-map gap at the old minimum and raises the uniform
norm-invariance range. It does not exclude polynomial norms, construct a
shared Cartier line on an arbitrary common cover, or imply a common-cover
decision.
