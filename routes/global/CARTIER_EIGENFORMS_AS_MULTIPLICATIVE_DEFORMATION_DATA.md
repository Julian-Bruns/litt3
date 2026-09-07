# Cartier eigenforms: root data and the corrected extension boundary

Author source translation2026-09-05; corrected and shortened by root
2026-09-07. The original common-cover problem remains UNSOLVED.
[Bounded independent source check](../../Research/audits/NILPOTENT_SPIKE_COLLISION_SOURCE_CHECK_2026_09_07.md):
PASS/source restriction required, library_generalization_cleanup_max,
2026-09-07. This is not a fresh or whole-theorem audit.

## Exact root-form translation

Let C/Fbar5 be smooth projective, d divide4, r=5−4/d, and
0!=s in H^0(C,omega^d) satisfy C_(d−1)(s^r)=s. Write s=a(dt)^d.
Choose a connected component of b^d=a and put eta=b dt. Its actual
cyclic group has order dividing d and acts faithfully on eta.

The Cartier product rule gives

    C(a^r dt)=C(b^(5(d−1)) b dt)=b^(d−1) C(eta).

Hence the normalized tensor equation is EXACTLY C(eta)=eta. The form
is regular because eta^d is the separable differential pullback of s.
If the root cover has ramification index m over a zero of order e, then

    d ord(eta)=me+d(m−1),    sigma=(ord(eta)+1)/m=1+e/d.

Conversely a logarithmic character form on a cyclic cover of order
dividing d descends in its d-th power; this tensor is regular iff all
sigma>=1. These are rational identities plus tame valuation arithmetic,
not assertions about which projective-bundle extension is selected.

## Primary-source match and the necessary correction

Bouw–Wewers, [Definition4.1 and Lemma4.6](https://arxiv.org/pdf/math/0505275),
call this a deformation datum. With v=a^(−4/d), its logarithmic test
is D^4(v)=−1: quadratic case D^4(a^−2)=−1, quartic case D^4(a^−1)=−1.
Their Theorem4.11 states a correspondence with active nilpotent
indigenous bundles, but the GENERAL same-extension/marking assertion
must not be used here.

[Hoshi, AppendixA RemarkA.3.1(ii)–(iii)](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1867revised.pdf)
documents the failure of Bouw–Wewers Proposition3.6(iv): kernel/oper
collisions and p-curvature zeros need not be disjoint. The audited
[local and compact test](../../Research/NILPOTENT_ZERO_SOURCE_CHECK.md)
has a regular genus55 connection with quartic zero orders7 and12 at
unmarked points, although the older forward rule selects marked
extensions. The generic connection does not determine those marked lattices.

Use the independent [scalar model](../../Theorems/Thm_nilpotent_scalar_model.md):
a regular active nilpotent connection determines a unique normalized
quartic; its exact divisor is2D_collision+5R_spike, including overlap.
The ADMISSIBLE scope survives: simple quadratic zeros or double quartic
zeros give an unmarked active nilpotent admissible object. Hoshi
PropositionA.5 confirms this criterion. Active is not dormant, and
admissible is not ordinary.

## Boundaries that remain useful

The full quartic pool can contain more than squares; its root cover
may have order four. Any nonzero Cartier-fixed regular one-form alpha
gives alpha^d in all d=1,2,4 pools, so positive5-rank gives such
examples. Conversely ordinary Cartier on C alone does not classify
the higher pools. An empty quartic pool would exclude all active
regular nilpotent opers, including ordinary ones, with consequences
for the hyperbolic-ordinariness question recorded in
[Hoshi's introduction](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1970revised.pdf).

None of this produces a common invariant, bounds the Cartier-zero
primitive weight, or establishes compatible pullbacks of two endpoint
objects through the same actual finite etale source.
