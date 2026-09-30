# Proof: the dormant model and exact finite-height tests

[Statement](../../Theorems/deformations/pointed_extensions_frobenius.md).

## 1. The final Frobenius step is the actual dormant jet model

Put E'=F^(h−1)*E and b=5^(h−1), with det E'=omega_1^b.
The first-instability argument in
[joint tangent dormancy, Section4](pointed_bundle_instability.md)
makes E' semistable and the maximal line N⊂F*E' have degree5b+1.
Its nonhorizontal second fundamental map is an isomorphism
N→Q⊗omega_0, where Q=F*E'/N. Hence

    Q²=omega_0^(5b−1),   Q=omega_0^((5b−1)/2)⊗tau.

Pullback by relative Frobenius identifies the two-torsion on C1 and C0;
write tau=F*tau1. Set L1=omega_1^((1−b)/2)⊗tau1.
The canonical flat bundle H=F*(E'⊗L1) has oper sequence

    0→omega_0³→H --q--> omega_0²→0

and determinant omega_0^5 with its canonical Frobenius connection.
Its quotient and connection define

    H→J¹(omega_0²),
    v↦j¹(q(v))−inclusion(q(nabla v)).                       (3)

Leibniz makes this map O-linear. On quotient and kernel it is the
identity and minus the second fundamental isomorphism, respectively,
so it is an isomorphism.

In jet coordinates a horizontal vector is (a,a'), with scalar equation
a''=r a+c a'. The determinant of (3) is an automorphism of omega_0^5,
hence constant; both determinant connections are canonical. Thus c=0.
Regularity, the projective transformation rule and zero p-curvature
give a regular dormant r. The [jet realization of V_r](../projective_connections/tangent_bundle_cyclic_refinements.md#1-dormant-tangent-bundle-and-its-stability)
identifies its Cartier descent with E'⊗L1, proving (1).

## 2. Sections recover the first-height pointed extensions

The jet determinant gives det V_r=omega_1. A nonzero section of the
stable degree-two bundle E=V_r⊗tau1 is nowhere zero: its saturation
O(D) has deg D<1. Its quotient is therefore omega_1, and the extension
is nonsplit by stability. The oper line omega_0³⊗tau destabilizes F*E.

There is at most one section up to scalar. Two independent sections
with zero wedge would generate the same trivial line and be constant
multiples. A nonzero wedge is a canonical section and has a zero;
at that point a nontrivial constant linear combination vanishes,
again impossible. This proves the first-height classification.

For h>=2, the bundle in (1) has degree2b. Serre duality and
V_r^dual⊗omega_1≅V_r reduce H¹ to the dual of

    H⁰(V_r⊗omega_1^((1−b)/2)⊗tau1)=0.

Its slope is negative. Riemann–Roch gives h⁰=2b−2.
The additional pointed-extension condition is imposed by the next test.

## 3. Use the exact polynomial cohomology matrices

For C_T:v²=F_T(u)=u(u−1)(u−2)(u−3)(u−T), put P=5^h and
A=F_T^((P−1)/2). The
[general polynomial theorem](../../Theorems/deformations/genus_two_pointed_polynomial_test.md)
constructs the whole connecting map

    H0(O((P−1)O) tensor tau) -> H1(O(−(P+1)O) tensor tau),

for all sixteen two-torsion labels R, using only coefficients of
R*A and (F_T/R)*A. Its kernel is Hom(omega^((P+1)/2) tensor tau,F^h*E).
The theorem proves that absence of these kernels is equivalent to
semistability through index h, including earlier possible instability.
Its proof supplies the two Cech bases, every matrix entry and the
Frobenius transport of projective parameters. No dormant quotient-jet
identification from Section1 is needed for this numerical criterion.

For R1 the parity blocks have column counts(P+1)/2 and(P−5)/2;
for the other labels they have counts(P−1)/2 and(P−3)/2. Each has
exactly two more rows than columns. This yields n13,10 or12,11 at
P25 and n63,60 or62,61 at P125.

## 4. Identify the matrices used in the frozen computations

The original [builder](../../scripts/deformations/verify_pointed_extensions.sage)
used the Laurent parameter z=u²/v and basis z^-3,z^-1,z of
H1(omega^-1). It ran at precisions180 and780 for P25 andP125.
The original precision proof and its audit remain preserved. The new
polynomial construction also gives an entirely finite comparison:
for every block and all three coefficient matrices,

    T*M_polynomial,j = sum_(a=0)^2 L[a,j]^P*M_computed,a.     (4)

Here L is the lower-unitriangular3-by3 change from v/u,v/u²,v/u³
and T is the lower-unitriangular target change. The
[comparison proof](genus_two_pointed_polynomial_test.md#4-exact-comparison-with-existing-evidence)
gives their entries and the
[executed comparison](../../scripts/deformations/check_pointed_polynomial_comparison.py)
checks all96 matrix identities at EACH height in exact finite-field
arithmetic. The two receipts are
[height2](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/height2_polynomial_comparison.json)
and [height3](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/height3_polynomial_comparison.json).

For transferring the computed ranks it suffices that these finite
matrix identities hold and that det T=det L=1. Thus the numerical
proof can now use the exact polynomial cohomology dictionary directly;
it does not require a new Laurent-tail estimate. The original outputs
and all field-code conventions remain unchanged.

## 5. Replace the projective charts by a published resultant

Use Busé's notation: a block transpose defines
phi:O(-1)^(n+2)→O^n on P², with rank threshold r=n−1.
[Busé, Propositions5.2 and5.4](https://arxiv.org/pdf/math/0209404),
specialized to m=n+2, d_i=1, k_i=0 and d=n, identify its resultant
with the determinant of the square maximal-minor coefficient map

    sigma_n:k^binomial(n+2,2)→k[x0,x1,x2]_n.

Thus phi has rank n at every geometric projective point exactly when
det(sigma_n)!=0. This principal case is valid in every characteristic,
as explained in Busé, Section3.3; its algebraic input is
[Bruns–Vetter, Theorem2.16](https://www.home.uni-osnabrueck.de/wbruns/brunsw/detrings.pdf),
the Eagon–Northcott resolution.

Set (x0,x1,x2)=(lambda0,lambda1,lambda2). At T=alpha,
alpha³+alpha+1=0, the [verifier](../../scripts/deformations/verify_pointed_extensions.sage)
rebuilds both blocks for all sixteen labels and finds all32 determinants
nonzero. Dehomogenizing x0=1 identifies degree-n forms with polynomials
of total degree at most n, so the coefficient calculation retains
points on x0=0. Run

    sage scripts/deformations/verify_pointed_extensions.sage

for the original second-height test. It writes no files; --verbose prints
the individual determinants. All32 checks pass in about90 seconds.

The larger third-height matrices admit the following exact general
replacement. For an (n+2)-by-n linear matrix M over K, choose n+1
distinct elements a_i and n+1 distinct elements b_j. Evaluation at
the q=binomial(n+2,2) nodes (1,a_i,b_j), i+j<=n, is an isomorphism
on the complete space of homogeneous degree-n forms. After x0=1,
the Newton polynomials

    product_(h<i)(x1−a_h) product_(h<j)(x2−b_h), i+j<=n,

give a triangular matrix in total-degree order with nonzero diagonal.
This uses distinct differences, not factorials, so n may exceed the
characteristic. Homogenization recovers every coefficient, including
those on x0=0.

If a node already has rank less than n, the test fails there.
Otherwise let u,v be any basis of its two-dimensional left kernel.
Exterior duality identifies u wedge v with the complementary maximal
minors, up to the SAME nonzero scalar at that node and the fixed
complementary signs. Consequently the matrix W of Pluecker rows obeys

    W = D V C J,

where C is the maximal-minor coefficient matrix, V is the invertible
evaluation matrix, D is invertible diagonal, and J consists of the
fixed complementary signs and any indexing permutation. Thus rank W
equals rank C exactly. In particular full rank proves geometric
constant rank; a deficient W proves a geometric failure even when
every chosen node had full rank. This is a coefficient-resultant
calculation, not a finite parameter search.

At P125, n<=63, so F125 supplies enough nodes. The
[exact evaluator](../../scripts/deformations/probe_pointed_frobenius.py)
reuses the original Laurent builder at precision780 and transports
its matrices through an explicit isomorphism from the original field
to Sage's canonical F125 presentation. This avoids an observed dense
kernel failure in the custom presentation. Every node kernel product
is checked; all recorded field codes are transported back.
The [complete third-height receipt](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/height3_evaluation_resultant.json)
records full ranks in all32 blocks, with largest coefficient size2080,
in274 seconds. The [audit](../../Research/audits/POINTED_FROBENIUS_EVALUATION_AUDIT_2026_09_15.md)
checks the interpolation, actual P125 cohomology setup, software
transport and an independent replay at increased precision with
changed field embedding and node order. Original second-height
evidence is retained.

For the fourth height the same geometric rank condition has a much
smaller exact test. Normalize the constant coefficient matrix of
each pencil by field row operations to
\[
\begin{pmatrix}x_0I+x_1A+x_2B\\x_1C+x_2D\end{pmatrix}.
\]
On \(x_1\ne0\), set \(t=x_2/x_1\). A rank drop at some
geometric \(x_0\) is equivalent to an eigenvector of \(A+tB\)
in \(\ker(C+tD)\). By Cayley--Hamilton, this occurs exactly
when the rows
\[
(C+tD)(A+tB)^j,\qquad 0\le j<n,
\]
fail to generate the whole module \(k[t]^n\). This is the WHOLE
module condition, not merely rank n over \(k(t)\): a nonunit
invariant factor would still have a geometric root. The chart
\(x_1=0\) is checked separately with the constant observation
rows \(DB^j\), and \([1:0:0]\) was checked in normalization.

The [native engine](../../scripts/deformations/pointed_popov_native.cpp)
uses exact finite-field polynomial arithmetic and weak-Popov row
insertion. Each reduction uses only a nonzero field scalar, retains
both generators after a swap, and strictly decreases the active
degree/leading-position measure. No polynomial saturation is used.
Full rank with row-degree sum zero proves the entire module is
generated. The [implementation audit](../../Research/audits/POINTED_POPOV_NATIVE_AUDIT_2026_09_16.md)
compares every stage on42 independent small pencils and35 direct
modules, including a failure appearing only over an extension field.
Its certified dimension range includes every fourth-height block.

The [wrapper](../../scripts/deformations/run_pointed_popov_native.py)
builds the actual polynomial matrices over canonical F125, verifies
each inverse and infinity rank, and compares four whole initial
Krylov-row hashes against independent Sage polynomial multiplication.
All32 known third-height blocks pass this engine as a calibration.
The [complete fourth-height receipt](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/native_height4_all/receipt.json)
then proves all32 blocks generate their full modules, with column
counts310,311,312,313. The final observation powers are155 or156.
Preparation and computation took2,105 seconds. The receipt records
the exact field embedding, every stage, all infinity ranks, and
hashes of the wrapper, engine, builder and input packet. This is
independent of the Kummer/theta dictionary.

## 6. A short uniform parameter-degree bound

Write a=(P−1)/2 and n0=a+1. For a chosen R let delta be1 or0
according as u−T divides R. The entries of the two polynomial blocks
have T-degree at most

    a+delta,    a+1−delta,

because F_T, R and F_T/R have T-degrees1,delta,1−delta. Taking a
coefficient of u or lambda cannot increase this degree. If an
(n+2)-by-n block has entry degree at most D, each maximal minor
has coefficient degree at most nD. Its square coefficient determinant
has size q=binomial(n+2,2), hence degree at most nDq.

For R1 the bounds are n0*a*binomial(n0+2,2) and
(a−2)*(a+1)*binomial(a,2). Every other block has n<=a and D<=a+1,
so its bound is at most a*(a+1)*binomial(a+2,2), smaller than the
first R1 bound. Therefore a single bound works for ALL32 blocks:

    B(P)=(P²−1)(P+3)(P+5)/32.                              (5)

It gives B25=16380, B125=8124480 and B625=4829577480.
These are bounds on the
POLYNOMIAL-basis coefficient determinants, not on kernel coordinates
or on the former Laurent-basis determinants. Each belongs to F5[T]
and is nonzero at alpha by(4) and the completed rank tests. Thus it
cannot vanish at any t with [F5(t):F5]>B(P). No product of the32
determinants is needed. This replaces the longer Laurent-weight
sum and improves both numerical thresholds by a factor of two.

The [joint-tangent theorem](pointed_bundle_instability.md) supplies
a finite first-instability index for a nonzero shared tangent over
bar(F5). On the fourth-height endpoints Sections3–6 exclude indices
one through four. Parts7--8 of the
[two-leg extension theorem](two_leg_negative_extensions.md)
then force the unique simultaneous W2 lift for exceptional clump
sizes4,24,124,624 and put any joint tangent at size at least3124.
This is a corollary input only for that final statement; the polynomial
calculation uses no assumed span or clump. No all-height semistability
or common-cover conclusion follows.

The original [second-height audit](../../Research/audits/POINTED_FROBENIUS_HEIGHT2_AUDIT_2026_09_09.md)
and the [third-height numerical audit](../../Research/audits/POINTED_FROBENIUS_EVALUATION_AUDIT_2026_09_15.md)
retain their scopes. The [polynomial audit](../../Research/audits/POINTED_POLYNOMIAL_RECURRENCE_AUDIT_2026_09_15.md)
covers the new cohomology construction and full basis comparisons.
Section1's general dormant quotient-jet model retains author-proof status
and is independent of the finite-height numerical proof above.

The already selected main parameter still qualifies: its degree
over F25 is a prime larger than the fixed arithmetic bound K,
and \(K>336000^2=112896000000>B(625)\). Its degree over F5
is at least that large. This uses the same parameter as before.

## 7. Exact first-height classification and cubic transfer

At P=5, one of the32 blocks has no columns. For each of the31
others the [symbolic calculation](../../scripts/deformations/probe_pointed_first_height_family.py)
forms the complete maximal-minor coefficient matrix over F5(T),
then verifies its determinant is a nonzero polynomial in F5[T].
The largest such matrix is10 by10. Factoring these small
determinants is an exact symbolic calculation, not a parameter
sample. Section5's determinantal criterion makes their union of
zero sets exactly the failure locus.

After removing the singular parameters0,1,2,3, their distinct
factors consist of T+1 and twenty irreducible cubics. Let B(T)
be the monic product of these cubics. The
[full receipt](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/first_height_rosenhain_invariant_20260916.json)
records all31 determinants and verifies
\[
z^{60}B(z^{-1}-1)=1+2A^2+4A^3,
\qquad A=(z^5-z)^4.
\]
The Hasse determinant is \(3(T+1)^4\); thus the sixty cubic
failures are ordinary. The coordinate change
\(u\mapsto1/(u+1)\) sends the five fixed branch points to F5.
Its affine group \(z\mapsto az+b\), with a nonzero and a,b
in F5, preserves the branch set and has invariant A. Each orbit
outside F5 has twenty points, exactly one fiber of A.

For z in F125 outside F5, put \(w=z^5-z\). Trace zero gives
\(w^{25}+w^5+w=0\), whence
\[
A^6+A+1=(A^3+3A^2+4)(A^3+2A^2+4A+4)=0.
\]
Both cubics are irreducible. Conversely their six roots give
trace-zero nonzero w in F125 and hence twenty z in F125 per root.
The good and bad sets each consist of three affine orbits, cyclically
permuted by Frobenius. Direct substitution places the backup alpha
in the good set. All sixty good cubic curves are therefore isomorphic
to coefficient twists of the backup. Isomorphism and field Frobenius
preserve the pointed-extension problem at every fixed height,
so the completed fourth-height test applies to all sixty.
