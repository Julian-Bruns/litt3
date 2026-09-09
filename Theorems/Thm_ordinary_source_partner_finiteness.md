# Finite partner sets with an ordinary common connection

Work over k=bar(F_5). Curves are smooth, projective, connected and of
genus at least two. Ordinary below means ordinary NILPOTENT indigenous
connection, equivalently zero tangent space in the fixed-curve nilpotent
scheme. It does not mean ordinary Jacobian or reduced dormant point.

## 1. Uniform finiteness, allowing every connection on the fixed endpoint

Fix a curve C and an integer h>=2. There are only finitely many
isomorphism classes of genus-h curves B admitting an ACTUAL span

    C <-a- W -b-> B

with both maps finite etale, and regular nilpotent connections satisfying

    a^*r_C=b^*r_B=r_W,       T_nil(W,r_W)=0.

The connection r_C is allowed to vary. Neither map degree is bounded;
neither leg need be Galois or have degree prime to five. No core or
Jacobian hypothesis is imposed. The conclusion remains true if one
fixes r_C, or requires a coreless witness.

For the genus-two family v²=u(u−1)(u−2)(u−3)(u−t), this gives a finite
set of parameters with such a witness, hence a nonzero polynomial
vanishing on that set. This is not an effective coefficient/degree bound.

## 2. Exact source test and an unbounded monodromy subclass

For an admissible active r_C, let E_(r_C) be its functorial rank-four
tangent bundle on C^(1). The extra source hypothesis is exactly

    H^0(W^(1), a^(1)*E_(r_C))=0.                         (1)

Equivalently, the canonical dormant pair on the canonical double of W
has zero dormant tangent spaces, with the split case interpreted on
both components. This equivalence is the existing canonical-double
theorem, not a new reducedness assertion upstairs.

Here is a sufficient test involving the ACTUAL one-leg monodromy.
Fix N prime to5 and suppose

    H^0(C^(1), E_(r_C) tensor L)=0 for all L in Pic(C^(1))[N]. (2)

If the Galois closure group of a:W→C fits into

    1→P→G→A→1,      P a5-group, A abelian of exponent dividing N,

then (1) holds. Consequently all fixed-genus compatible partners
witnessed by these covers form a finite set. In particular, an ordinary
r_C suffices for ALL covers with5-group Galois closure (N=1).
This controls arbitrarily large, possibly non-Galois degrees. It does
not say that (2) holds for all N, or for every ordinary connection.

## 3. Precise remaining gap

The hypothesis can be tested on the joint normalization with field
a^*k(C)b^*k(B). It is equivalent to existence of an ordinary witness:
ordinariness descends under finite etale pullback, and the joint
normalization itself is a witness. A nonzero tangent cannot be removed
by further etale refinement of a fixed witness.

This theorem gives NO finiteness for partners all of whose compatible
joint witnesses are nonordinary. It gives no compatible connection
when the common-connection space is empty. If r_C is nonordinary,
its entire ordinary-source partner subclass is empty.

Version1,2026-09-09. Source-checked author synthesis of Mochizuki's
canonical lifting and characteristic-zero partner finiteness, extending
the supplied Pro reduction to the finite union over r_C and the
explicit monodromy subclass. Not independently audited or Lean verified.
[Proof](../Solutions/Sol_ordinary_source_partner_finiteness.md).
