# Proof: uniform elimination for degree140 squares

25 September2026. The [statement](../../Theorems/cartier_and_spin/degree140_nonzero_pivot_reduction.md)
is a scoped coefficient-locus result, not a common-cover decision.

## Returned reductions

The entire incoming package is retained at
[degree140_continuation](../../../litt3-computation-data/nonzero_pivot_secant_replies_20260925/degree140/degree140_continuation/).
Its full verifier, including its self-contained prior package, passed
locally. The original archive, CRC, manifests and source copies are
recorded in the integration audit.

The prior/INPUT.md supplies the original eleven coefficient spaces
and the fixed-degree residual. The returned proof covers these entire
spaces. Its prior/REPORT.md proves that the normalized residual has
inverse-scale degree6, whose top coefficient is t*v times a nonzero
square. It therefore cannot be square at projective inverse-scale
infinity. The projective square incidence is proper over the ratio
base and avoids that infinity section, so it is also affine and
hence finite. The formal root errors have degree at most104 in
inverse scaling; in the constant case one has an everywhere nonzero
degree75 error. This proves the fiber bounds. A nonzero necessary
Sylvester determinant in each ratio plane bounds dimension by one.
These arguments include zero scaling only as an auxiliary boundary.

The current REPORT.md identifies all zeros of the highest H-coefficient
of Psi. For constant v its only permitted nonzero zero is15383.
For each linear case there are two nonzero roots, one the forbidden
Cramer pivot and one the value in the theorem. On the permitted
boundary its proof reconstructs the ENTIRE residual tensor and formal
root coefficients using proved interpolation degrees. Fixed-degree
Sylvester determinants retain degree-drop loci. For constant v two
resultants have an explicit Bezout identity1. For every linear case
their common target is a fifth power of a squarefree degree-nine
polynomial. Separate identities1 in the full degree-nine quotient
ring exclude every geometric root and every scaling. The latter
step is indispensable; the common target was not discarded.

The complete eleven-boundary replay passed. Its portable coefficient,
determinant-bound, large Bezout and quotient-ring certificates remain
with the archive. None is interpreted as a global nonzero-pivot
exclusion.

## A complete new constant-ratio fiber

The local extension uses q=1 in the CONSTANT-v family only.
Write the exact normalized residual as R(H,q,mu,x), and let
\[
\widehat R(T)=T^{140}R(H,q,\mu,T^{-1}).
\]
The cube-free source has H-degree at most1, so R has H-degree at
most36. At q=1 its full 37-by-7-by-141 tensor, including H=0, was
reconstructed and compared with the returned exact source formula.

At q=1,
\[
\Psi(H,1)=[342103]_K+[60463]_K H,\quad
\operatorname{lc}_xR=c_1 H^9\Psi(H,1)^3,\quad c_1\ne0.
\]
Here bracketed K-codes use the theorem's eight-dimensional F5 encoding,
not reduction of those integers modulo5. Complete tensor support gives
H=0 valuation at least -9m/4 and H-infinity growth at most3m/2 for
the normalized reversed coefficient of index m. It also gives
4*deg_mu<=3m.

Let j_m be the unique formal root coefficients with j_0=1. In
characteristic5,
\[
\sqrt B=B^{63}\pmod{T^{125}},\qquad B(0)=1.
\]
Indeed (B^63)^2=B*B^125 is B modulo T^125, and2 is invertible.
Thus for m=71,...,74, multiplying j_m by H^167*Psi^189 clears
all finite H-poles. Its H-degree is at most467. Exact interpolation
and a separate coefficient checker verify those identities at468
distinct valid H-values. Only allowed powers of H were removed.

The four resulting polynomials P_m have (H,mu)-degrees
(441,47),(446,47),(449,48),(454,48). The removed H-powers from
H^167*Psi^189*j_m are respectively21,18,16,13. Every square
satisfies all four P_m=0.

The two normalized necessary resultants are
\[
G_{12}=\frac{\operatorname{Res}_{47,47}(P_{71},P_{72})}
 {H^{1814}\widehat\Psi^{6762}},\quad
G_{14}=\frac{\operatorname{Res}_{47,48}(P_{71},P_{74})}
 {H^{1865}\widehat\Psi^{6681}},
\]
where widehat(Psi) is its monic H-associate. The exact determinant
degree bounds are22865 and23505; their actual degrees are22865 and
23502. Integer assignment-dual certificates prove both the allowed
divisibilities and the degree bounds. Complete additive-grid
interpolation reconstructs the two polynomials.

A supplied and separately verified Bezout identity is
\[
a(H)G_{12}(H)+b(H)G_{14}(H)=1.
\]
The multiplier degrees are23501 and22864. The difference has degree
at most46366, and the identity was verified at78125 distinct exact
field elements. Consequently no geometric H or mu on this q=1
fiber can give a square.

The source is
[degree140_constant_ratio.py](../../scripts/arithmetic/degree140_constant_ratio.py).
Complete new data, logs and compiled-work provenance are at
[constant_q1](../../../litt3-computation-data/nonzero_pivot_secant_replies_20260925/local/constant_q1/).
The compiled files are reproducibility aids, not opaque certificate inputs.

## Uniform support bounds, rather than extrapolation from q=1

An empty fiber alone does NOT rule out a component dominating q: its
H-coordinates could go to infinity at q=1. The following uniform degree
check is necessary to prevent that mistake.

Every cube-free source coefficient G_i/d has H-degree at most1,
q-exponents in [-1,4], and Y-degree at most2, with d a fixed nonzero
constant and Y^3=P/q. In the original degree-(10,2) resultant the
last constant term simplifies as
\[
(qt)^3Y^{10}=t^3P^3Y,
\]
so it has q-exponent zero. All other f and derivative coefficients
have the same q-range [-1,4] and Y-degree at most2.

The resultant is homogeneous of degrees2 and10 in these two
coefficient lists. Before Y-reduction its q-range is [-12,48]
and Y-degree at most24; after reduction its q-range is contained
in [-20,48]. Its cubic norm has q-range in [-62,144].
Dividing by (P/q)^40*(qt)^15 adds25 to this range. The remaining
polynomial division in x is by a polynomial independent of q
and cannot enlarge that range. Consequently
\[
\deg_H R\le36,\qquad q^{37}R\in K[q,H,\mu,x],\qquad
\deg_q(q^{37}R)\le206.
\]
These are uniform bounds, including all coefficient cancellations.

Write Psi=a0(q)+a1(q)H. The exact chart has deg(a0)<=7 and
deg(a1)<=2. Translating H to H-a0/a1 and multiplying by a1^36
therefore gives q-degree at most206+7*36=458. This is a bound on
every translated coefficient, not only on selected parameter values.

The local program evaluates the full H-tensor at459 distinct q-values
with q*a0*a1 nonzero. At each it uses37 H-values, sufficient for
degree36. Thus zero entries and translated-zero entries verified
throughout these459 tensors are polynomial identities over every
extension field. In particular the following are uniform: the
maximum H-degree, minimum H-order and minimum Psi-order of every
coefficient needed below. This is not a search for F_(5^8)-rational
square points.

To propagate the bounds to index71--74 use the exact base-five identity
\[
\widehat R^{63}=\widehat R^3(\widehat R^2)^5(\widehat R^2)^{25}.
\]
Ordinary upper/lower support convolution proves bounds for each
individual mu coefficient. Cancellation may improve these bounds,
never invalidate them. The computed uniform bounds coincide with
the needed q=1 degree bounds. They show that the following are
polynomials in H, with coefficients rational in q:
\[
Q_m=c_1^{-63}H^{-d_m}[T^m]\widehat R^{63},\qquad
(d_{71},d_{72},d_{73},d_{74})=(421,418,416,413).
\]
At q=1 these are exactly P_m. Every geometric square forces Q_m=0.
The last implication follows from the formal root identity and
does not require any unproved relative coefficient normalization.

Applying integer assignment-dual bounds to the entire coefficient
supports gives, uniformly over K(q):

| Resultant | H divisibility | H-degree upper bound | Psi divisibility |
| --- | ---: | ---: | ---: |
| Res_(47,47)(Q71,Q72) |1814|31441|6762|
| Res_(47,48)(Q71,Q74) |1865|32051|6681|

The first Psi-bound uses a newly constructed dual: three inequalities
of the original specialized dual were too strong for a direct
support proof, but a different valid dual achieves the SAME total
6762. This detail is retained in the exact record, rather than
silently declaring all specialized entry valuations universal.
There are no additional mu coefficients beyond the declared degrees.

The source is
[degree140_constant_uniform_support.py](../../scripts/arithmetic/degree140_constant_uniform_support.py).
Its uniform_support.json contains the459 tensor hashes, individual
coefficient bounds, both new duals, exact degree comparisons and
the original specialized-dual failures. Full replay verifies all
new global-dual inequalities.

## A nonzero elimination function in q

Define G12(H,q),G14(H,q) from Q_m by the two normalized resultant
formulas above, now over K(q). Their H-degree bounds are22865 and
23505. All coefficients are regular after inverting q*a1(q).
To see this without silently deleting a boundary, first divide by
the proved H-power. Then divide by the monic power
(H+a0/a1)^b. Polynomial long division has coefficients in
K[q,1/(q*a1)], and its generic remainder is zero. Hence its
remainder is identically zero in that ring. At zeros of a0 the
two factors H and Psi can meet, but no a0 inversion is needed in
the final identity.

Consider the fixed-degree determinant
\[
\mathcal D(q)=\operatorname{Res}_{22865,23505}
  (G_{12}(H,q),G_{14}(H,q)).
\]
This is a completely specified rational arithmetic circuit over K.
At q=1 the first degree is still exactly22865, the second drops
only to23502, and the two polynomials are coprime by the recorded
Bezout identity. The padded determinant is the ordinary nonzero
resultant multiplied by the third power of the first leading
coefficient. In particular D(1)!=0; D is not the zero function.

Any valid square has H!=0 and Psi!=0, so both normalized resultants
vanish at its H. Their fixed-degree resultant D(q) must then vanish.
For constant v, a1(q)=q(299833+232505*q); its only nonzero root15383
was already excluded by the returned theorem. Thus all remaining
q-values are zeros of the nonzero numerator of D. There are only
finitely many over the algebraic closure.

The numerator is specified by the determinant circuit, not supplied
as an expanded coefficient list. No root count, factorization or
elimination of the remaining q-fibers is claimed. In particular,
vertical curve components over these finitely many q-values are
not ruled out by this argument. It does, however, exclude every
positive-dimensional square component with nonconstant q in the
constant-v family.

## Reproduction and limits

Run the full incoming verifier in its extracted package, then the
two local scripts with that package and an external output directory.
The local constant-fiber script compiles only retained C++ sources,
reconstructs the exact residual, verifies coefficient identities,
reconstructs fixed-degree determinants and produces and checks the
Bezout identity. The uniform-support script reuses that exact field
and residual engine, checks all459 parameter evaluations and
reconstructs the global Newton and assignment bounds.

These checks are geometric polynomial identity certificates with
proved degree bounds. Neither the scope of a finite-field point
search nor an assumed proper projection to q is used. No actual
common source or etale maps are constructed.
