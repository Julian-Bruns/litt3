# Proof record: Shared simple-root tensors force a core

Canonical statement: [`shared_tensor_core`](../Theorems/Thm_shared_tensor_core.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Shared equal-weight-zero tensors and positive-genus cores

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/contact_bound_to_core_audit, 2026-09-06;
[audit record](../routes/global/audits/UNIFORM_EQUAL_WEIGHT_CONTACT_FORCES_CORE_AUDIT_2026_09_06.md).
The first proof is now shortened to the stronger independently audited
[canonical-quotient theorem](Sol_canonical_marked_quotient.md),
which also removes the prime-to-p weight restriction. The positive-genus
lemma below is retained. This does not settle Litt's common-cover problem.

## Theorem 1: all degrees at once

Let k be algebraically closed of characteristic p>=5. Let
X <-f- Z -g-> Y be finite etale maps of smooth connected projective
curves of genus at least two. Suppose nonzero regular weight-d tensors,
for any d>=1, have equal actual differential pullbacks and

    div(s_X)=d D_X, div(s_Y)=d D_Y,

where D_X,D_Y are reduced. Then the span HAS A CORE:

    trdeg_k(f^*k(X) intersect g^*k(Y))=1.

There is no Jacobian hypothesis, Galois hypothesis, or bound on d or on
either covering degree. In particular, any shared one-form with only
simple zeros forces a core.

### Proof

The canonical-quotient theorem identifies the two endpoint quotients
and makes the normalized joint image a component of X x_S Y. The coarse
function field k(S), of transcendence degree one, therefore pulls back
into both endpoint fields inside k(Z). This is a core. Its construction
allows arbitrary weights, wild inertia, and non-Galois endpoint atlases.
QED.

## Lemma 2: a logarithmic form of low zero order forces a positive-genus core

Let p>=3. Suppose an actual cored bi-etale span has a shared nonzero
regular one-form alpha, Cartier-fixed after a common scalar normalization.
If every zero of its pullback on Z has order STRICTLY LESS than p-2,
then its coarse core has genus at least one.

### Proof

The [simultaneous etale-envelope argument](Sol_cored_orbifold_bridge.md)
gives a finite etale refinement W->Z that is Galois over both endpoints.
Let A=Gal(W/X),B=Gal(W/Y),G=<A,B> subset Aut(W), and C=W/G. The field of
C is the common core. The group is finite because W is hyperbolic.

The shared form alpha_W is fixed by A and B and hence by G. It descends
to a rational one-form beta on C, since k(W)/k(C) is separable. Cartier
commutes with this pullback and pullback is injective, so C(beta)=beta.
The field-level Cartier criterion writes beta=dlog q. In particular,
every pole of beta is simple. All zeros of alpha_W still have order<p-2,
because W->Z is etale.

Suppose beta has a pole at c, and choose w above it. Let e be the local
ramification index and delta the different exponent for W->C at w.
The valuation formula for pullback of a rational differential gives

    ord_w(alpha_W)=delta-e.                           (2)

For tame ramification delta=e-1, so (2) is -1, contrary to regularity.
For wild ramification the inertia group has |I_0|=e, |I_1|>=p, and

    delta=sum_(i>=0)(|I_i|-1) >= (e-1)+(|I_1|-1).

Consequently delta-e>=p-2, contrary to the zero-order hypothesis.
This bound includes inertia with a nontrivial tame part; the stronger
bound delta-e>=e-2 is NOT being assumed. Thus beta has no poles. It is
a nonzero regular one-form on C, proving g(C)>=1. QED.

## Corollary 3: orthogonal Jacobians cannot share a simple Cartier eigenform

In characteristic p>=5, if Hom(JX,JY)=0, no actual bi-etale span can
preserve a nonzero regular one-form with only simple zeros and nonzero
Cartier eigenvalue. Normalize its eigenvalue to one. Theorem 1 gives a
core and Lemma 2 makes its genus positive. Pullback of that core's
Jacobian gives a common positive-dimensional isogeny factor of JX,JY,
contradicting Hom(JX,JY)=0.

Both the existence of a core and its positive genus matter here: a
rational core alone would not contradict Jacobian orthogonality.

## Consequences for the fixed genus-nine/genus-twenty-five pair

For a CORELESS span, the canonical intersection is k or k[s], and the
generator has uniform zero order e. Theorem 1 excludes e=d for EVERY
primitive weight d prime to five, including unbounded Cartier-zero
weights. In weights two and four this excludes e2 and e4, respectively.

If the primitive weight is one, ordinarity of Y makes its Cartier scalar
nonzero. The [exact genus-nine eigenform certificate](Sol_fixed_x_cartier_eigenforms.md)
forces the uniform zero order to be one. Thus the ENTIRE coreless
primitive-weight-one branch is impossible, not just its large degrees.

The previous numerical limits160,320,640 remain true but were weaker
than this composition consequence. No enumeration of degrees below
those limits is needed to exclude these CORELESS branches.

What remains: A=k; positive intersections with e!=d (including the
Cartier-nonzero e/d=1/2 branch); other unbounded Cartier-zero weights;
and cored configurations not eliminated by an additional argument.
The theorem does not assert that an invariant tensor exists and does
not assert that every possible core has positive genus.
