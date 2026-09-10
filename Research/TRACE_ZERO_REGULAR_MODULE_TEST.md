# A regular-module test for the bounded-five-part trace-zero strategy

2026-09-10. Author linear-algebra construction, not a geometric
counterexample or a new common-cover exclusion. It strengthens the
earlier warning that an injected short string can be the tail of a
long one. The actual bounded-degree cored maps are NOT realized here.

## 1. A parameterized model with the relevant regular deck character

Choose any even L>=2, m=5^L-1, and q=5 or25. Over bar(F5), set
G=C_q×C_m, with e=sigma-1 on C_q. Take

    V=k[G]^3.

This has exactly the regular negative-cohomology character of a
hypothetical etale Galois genus-two cover with group G. Its dimension
3qm is consistent with g(Z)=qm+1. Since8 divides m, an opposite
genus-nine etale degree qm/8 is numerically integral and divisible by5.
These are numerical consistencies, not constructed maps.

Decompose the C_m characters into multiplication-by5 orbits. The two
orbits of exponents +1 and -1 are disjoint and have length L. On one
of the three copies for each of these orbits use basis v_(i,j)^±,
0<=i<L and0<=j<q, and define a Frobenius-semilinear operator by

    Psi(v_(i,j))=v_(i+1,j)        if i<L-1,
    Psi(v_(L-1,j))=v_(0,j+1)     if j<q-1,
    Psi(v_(L-1,q-1))=0.

Here e v_(i,j)=v_(i,j+1), with final image0, and a generator of C_m
has character zeta^(±5^i) on v_(i,j)^±. Then Psi commutes with both
deck actions, with the coefficient Frobenius explicitly included.
On all other character-orbit copies use the same cyclic character
shift with an invertible final edge instead of e; those parts are
bijective for Psi.

The nilpotent Fitting part consists of TWO strings of length qL.
Its kernel and cokernel have dimension2; the cyclic five-part acts
trivially on each. Their characters are respectively

    ker Psi: zeta^(±5^(L-1)),  coker Psi: zeta^(±1).

Thus Frob(ker Psi) and coker Psi have the same deck character. The
dual cokernel is a faithful reciprocal two-dimensional representation,
as required by the Serre--Cartier character identity in the trace
argument. The full G-invariant V is3-dimensional and Psi-bijective,
consistent with an ordinary genus-two endpoint.

The P=C_q-invariants on the nilpotent part are the j=q-1 slices.
They give two strings of length L, again of defect2, while the original
source has two strings of length qL. Hence bounded q does not bound L.

## 2. Include both a short opposite injection and a surjective zero trace

Take a24-dimensional semilinear module V_X consisting of a single
zero line kx and23 bijective dimensions. Inject x into the SUM of
the two source nilpotent tails. This is a nonzero short X string,
not an eigenline for C_m. Embed the23-dimensional bijective part in
the large bijective summand of V, using a Frobenius-fixed basis.

Define a Psi-compatible trace t:V→V_X by sending BOTH nilpotent
heads v_(0,0)^± to x and every other vector on those strings to0.
On the bijective part, send23 independent complementary Frobenius-fixed
vectors onto the bijective basis of V_X and kill the chosen injected
copy. Such disjoint subspaces exist since the bijective part is large.
Then t is surjective, the injection j is injective, and

    t j=0=(qm/8)id in characteristic5.

This includes the surjectivity and degree-zero composition of the
coherent trace, not just an arbitrary inclusion. Dualizing t embeds
the X defect line into the dual source cokernel as the SUM of its two
reciprocal eigenvectors. Its projective C_m-orbit has size m/2, which
is unbounded. The P-orbit span of the entire injected V_X has dimension
at most24q<=600, smaller than the bound64*24 from the cored joint leg.
No nondegenerate pairing on that short orbit span is supplied.

## 3. Consequence for what to investigate next

For L>=26, these models exceed the existing faithful-image threshold
4(5^24+1), while q remains5 or25. Thus the following linear data alone
cannot restore the lost string-length bound: regular deck cohomology,
ordinary base invariants, defect2 with reciprocal characters, bounded
cyclic five-part, an injected short X string, a surjective trace whose
composition is the map degree, and a bounded P-orbit span.

This is NOT an actual curve, connection or two-leg span. In particular
it does not realize the small cored degree[k(X)k(T0):k(T0)]<=64 or
the function phi_X²/s_X. A successful next argument must use additional
geometric structure of those maps/functions, or a genuinely stronger
pairing/differential identity that excludes these modules.

The standard-library script verify_trace_zero_regular_model.py checks
the nilpotent modules, Frobenius character transport, trace and mixed
line orbit for bounded test parameters. The arbitrary-L construction
above is the explanation; finite tests are not its sole justification.
