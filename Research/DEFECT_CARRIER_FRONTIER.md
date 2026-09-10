# Defect carriers after the Galois one-defect exclusion

2026-09-10. Research continuation, not a new audited theorem. The
prime-to-five descent and its main-pair application are already in
[defect_preserving_etale_descent](../Theorems/Thm_defect_preserving_etale_descent.md).
The observations below identify the exact limitations of that mechanism.
Both original finite etale legs remain required throughout.

## 1. The exact linear condition for the same descent proof

Let h:T→C be an actual finite etale map, with compatible active data.
Write V_C=H1(C,T_C), V_T=H1(T,T_T), and Q_h=V_T/h*V_C. Pullback
on these negative cohomology spaces is injective at every degree.
The matched Hodge variation operators induce Psi on Q_h.

The all-level proof works whenever Psi on Q_h is bijective. Indeed,
for the difference xi_T between a compatible upper lift and a lifted
lower reference, Psi_T(xi_T) lies in h*V_C. In the quotient this says
Psi([xi_T])=0. Bijectivity forces xi_T=h*xi_C. The rest of the proof
descends the original map and the complete previous filtered tuple.

The snake sequence for 0→V_C→V_T→Q_h→0 shows that this condition is
equivalent to BOTH

    h*:ker Psi_C → ker Psi_T is an isomorphism,
    h*:coker Psi_C → coker Psi_T is injective.

Equal defects alone give the first condition. They do not give the
second when the degree is divisible by five. This is a criterion for
an actual intermediate map, not evidence that such a map exists in
either of the remaining branches.

## 2. A sharp obstruction to removing the degree restriction

Suppose h is Galois and d_C=d_T=d>0. When its degree is prime to five,
normalized trace makes the cokernel map an isomorphism. If five divides
its degree, the cokernel map is instead ZERO.

First take a five-group P. By
[etale_p_witt_obstruction](../Theorems/Thm_etale_p_witt_obstruction.md),
the upper cokernel D needs d generators over k[P], and pullback is
the norm action on its coinvariants. Since dim_k D=d, its radical
is zero: D is a trivial P-module. The norm acts by |P|=0, so the
cokernel pullback vanishes.

For a general Galois group of order divisible by five, take a subgroup
P of order five and factor T→T/P→C. Defect monotonicity and equality
at the endpoints give defect d also on T/P. Apply the cyclic case to
T→T/P; the original cokernel map factors through this zero map.

The same snake sequence now gives

    dim ker(Psi on Q_h)=dim coker(Psi on Q_h)=d.

Thus the complementary operator is genuinely not invertible. The
constant-defect two/four cyclic towers already constructed in
[symplectic_p_cover_section_growth](../Theorems/Thm_symplectic_p_cover_section_growth.md)
realize this operator behavior. This does NOT by itself construct a
failure of full-tower descent: that would require actual higher
obstruction or lift data, not only these dimensions.

## 3. What a higher-defect carrier would have to control

For a prime-to-five Galois cover Z→Y with defect representation
U=ker Psi_Z, take H=ker(G→GL(U)) and C=Z/H. The pulled-back kernel
on C is U^H=U, by equivariant descent, so Z→C preserves defect.
The new theorem descends every compatible upper Witt tower to C.
Its genus satisfies

    g(C)-1=|image(G→GL(U))|*(g(Y)-1).

In the one-defect case the actual symplectic tangent bundle forces
the image to have order two. This is the bounded-genus step used in
the completed main-pair exclusion. In higher dimension the group
image is not bounded by dimension alone: reciprocal characters and
dihedral representations already allow unbounded prime-to-five
orders. This is a representation-theoretic limitation, not a claim
that these representations occur in a hypothetical main span.

For a non-Galois source, passage to its Galois closure can increase
the defect. A one-dimensional space on Z must not be treated as a
one-dimensional representation of that larger Galois group.

## 4. A symmetry retained by every compatible bad-double tower

For the explicit genus-three bad double write

    k(C)=k(u,kappa,gamma),
    kappa²=u(u-3), gamma²=(u-1)(u-2)(u-t), v=kappa*gamma.

There are three involutions:

* tau negates kappa and gamma. Its quotient is the ORIGINAL etale
  genus-two map C→Y.
* iota fixes kappa and negates gamma. It is hyperelliptic.
* sigma=iota*tau negates kappa and fixes gamma. Its quotient is the
  elliptic curve gamma²=(u-1)(u-2)(u-t); this quotient is RAMIFIED.

The connection is invariant under all three. The defect quadratic
phi=gamma*eta² is fixed by sigma and negated by tau and iota. The
simple-zero Serre pairing gives the same signs on ker Psi.

Consequently sigma lifts to EVERY existing compatible finite or full
Witt tower with the specified canonical W2 marking. Inductively it
already preserves the lower tuple. Its action on the nonempty torsor
of compatible next lifts has trivial linear part, so it is translation
by a kernel vector. Since sigma²=1 and two is invertible, this
translation is zero. Marked lift uniqueness (H0(T_C)=0) gives an
actual involution and compatible full filtered data at each level.

By contrast tau acts on the first kernel parameter by z→-z. At W3
only z=0 preserves that specified involution. Thus a hypothetical
nonzero compatible full tower can retain its elliptic involution
while losing BOTH the free and hyperelliptic involutions. No such
nonzero full tower has been constructed here. The elliptic quotient
must not be substituted for the original finite etale Y-leg.

## 5. Pro target reassessment

The next-Witt request subsequently RETURNED; it was not broken. Its
algebraic candidate P_t=z-beta*z^5 replayed, but the focused geometric
audit found missing Hodge-correction carry and reference comparisons;
see [the result note](W4_DEFECT_ADDITIVE_RESULT.md). Do not resend the
old prompt unchanged: the audited bounded-carrier/finiteness proof has already
excluded its entire original Galois one-defect main-pair application.
The actual function P_t remains a useful arithmetic invariant, but its present
marginal value is lower than a mechanism reaching higher defects or
non-Galois sources. The delayed-descent prompt subsequently RETURNED.
Its initial canonical-reference case and all-level compatible-reference
case are audited in cyclic_five_compatible_reference_descent. The
uniform claim initially omitted an incompatible-reference lower-left
error, with a quadratic graph term surviving at n3. The secondary
transfer request has now RETURNED and resolved this gap: compare two
compatible upper objects and their marked deck translates. The
constant next obstruction is eta0. The relative calculation extends
to all n>=3 and has focused medium audit PASS. Combined with the
initial case this proves full cyclic_five_delayed_descent, including
the actual full-tower and main C10 carrier consequence (also audited).
The subsequent dihedral Pro has also RETURNED and passed its focused
audit: actual AS products kill the ordinary quadratic without an
involution. cyclic_five_delayed_descent VERSION2 now verifies general
simple-defect inputs and all reduced C10,D10,C2×D10 carriers with
five-part exactly5, retaining the original genus3 carrier count.
The symbolic D10 source-defect test was executed before that request.
The initial cyclic25 request has now returned and is integrated as
cyclic_twentyfive_initial_descent v1: Theta=d5e, hence given-W3 descent
from compatible W5, with a compatible reference. Focused geometric and
general-scope audits PASS; ring and independent jet checks PASS.
The new ready model-only request is
PRO_CYCLIC25_UNIFORM_DESCENT_REQUEST.md, asking all-level descent
without assuming a later compatible lower reference. Submission has
not yet been reported. No uniform cyclic25 theorem is assumed.

The new canonical
[two-defect deck reduction](../Theorems/Thm_two_defect_deck_reduction.md)
is now focused medium-AUDITED, including the complementary trivial-
five-action part. Every actual Sylow5 subgroup is cyclic. After an
actual prime-to5 defect-neutral quotient, nontrivial five-action leaves
three cyclic/dihedral tower shapes; trivial five-action leaves a cyclic
five-group acted on by a self-dual two-dimensional prime-to5 image.
The cyclic exponent and, in the second branch, that image's order
remain unbounded. Do not turn this reduction into a cover exclusion.

In particular, neither dropping the prime-to-five hypothesis nor
assuming a small defect representation on a Galois closure is a
justified next lemma. Check existing packet and restricted-theta work
before choosing a group-specific or Prym question: much of that work
already exists. Prompt files themselves remain model-directed only;
this tracking belongs in research state and chat.

## 6. New two-leg bounds and the exact trace-zero residual

Two further mechanisms are now canonical and focused medium-audited:

- [The defect-orbit bound](../Theorems/Thm_two_leg_defect_orbit_bound.md)
  uses an actual nonzero X defect quadratic phi_X. The common ratio
  phi_X²/s_X has X-degree<=64, and its Y-deck orbit of size b bounds
  the actual joint Y-degree by64b. For source defect2 and nontrivial
  five-action, b<=10. The existing parameter excludes this entire
  nonordinary-X branch without assuming a core.
- [The Frobenius-string bound](../Theorems/Thm_frobenius_defect_order_bound.md)
  handles prime-to5 Galois Y-legs. Normalized f-trace preserves a
  nonzero Psi string of length<=24. Equivariant Serre--Cartier duality
  forces each faithful defect-image element of order>2 to have order
  dividing5^ell±1 for some ell<=24. Thus the actual defect quotient
  T has genus<2^59. The cored span X←Z→T has X-atlas degree<=64;
  counting such T and their genus2 quotients excludes the branch
  for the UNCHANGED main pair, with no original-source degree bound.

Consequently the remaining nonordinary-X/source-defect2 Galois-Y
case has a nontrivial cyclic five-part acting trivially on both defect
directions, and large cyclic/dihedral prime-to5 projective image
(order>=5250). It is not excluded. The degree of f is divisible by5,
so a short X string can sit at the bottom of a longer source string;
the trace argument does not apply. Constant-defect cyclic towers
already show why equal defects alone are insufficient.

There is still an actual cored intermediate T0=Z/ker(defect), etale
Galois prime to5 over Y, but no genus bound for it. The joint curve
R of X,T0 is etale over both, with deg(R/T0)<=64. This bounded
refinement is the next mechanism being tested, not a theorem about
string lengths. A normal closure over the common orbifold has bounded
degree on the X side, but its Sylow quotient can have wild stabilizers.
Neither dropping those stabilizers nor assuming a simultaneous
Galois refinement of the original coreless span is legitimate.
