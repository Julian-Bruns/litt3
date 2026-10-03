# Proof: a wild different exceeds the tiny area, and a lone branch gives an exact form

Version2. [Statement](../../Theorems/cartier_and_spin/wild_ramified_spin_two_branch_reduction.md). [Independent whole-implication review: PASS](../../Research/audits/WILD_RAMIFIED_SPIN_TWO_BRANCH_AUDIT_2026_10_02.md), with its [pure-inertia extension independently accepted](../../Research/audits/WILD_PURE_INERTIA_PROFILE_EXTENSION_AUDIT_2026_10_03.md). This is a computation-free joint deduction with the root researcher. All groups and maps are actual on the same source. Both selected genus-two endpoints are ordinary.

The local tower and free-source stabilizer argument of the [tame degree classification](tame_ramified_spin_degree_classification.md) does not require tameness: every inertia order e of H=G/K acting faithfully onΓ divides n=κ/k. At the distinguished image its order t=r/k satisfies n=t(2+u), u≥1; other Y→B fibers have uniform index e. The exact general Hurwitz area is
\[
2g(B)-2+\sum_b\delta_b/e_b=1/n,
\]
where δb is the local different exponent for the ACTUAL Galois Γ→B cover. This follows from2gΓ−2=8δ and|H|=8κδ/k exactly as in the tame proof.

## Wild inertia rules out three branches and two wild branches

At a wild inertia group of order e, its first positive lower ramification group has order at least FIVE. The different formula gives
\[
\delta\ge(e-1)+(5-1)=e+3,
\qquad\delta/e\ge1+3/e\ge1+3/n.
\]
At every other nontrivial inertia group, δ/e≥1−1/e≥1/2.

If g(B)≥1, the one wild contribution already exceeds1/n, impossible. Thus B=P¹. If there are at least three branch values, one wild and two other contributions give area at least3/n, strictly greater than1/n. If there are two wild values, they give area at least6/n, again impossible. Therefore there is exactly one wild branch value and at most one other branch value, which must be tame.

## One wild branch alone would contradict ordinarity

Suppose only the wild branch remains, of order e and different δ. Then δ/e−2=1/n, hence
\[
(n/e)\delta=2n+1.
\]
The integer n/e divides n and2n+1, so it is ONE. Thus e=n and δ=2n+1. The distinguished φ branch cannot lie over this value: its Γ inertia t satisfies t≤n/3, whereas the only branch inertia is n. Consequently its image is ordinary for Γ→B.

The actual Y→B map has exactly two branch fibers. Over the wild value it is totally ramified at a single point Q, of index n and different exponent2n+1: φ is étale there, and q is everywhere étale, so the completed local tower transfers the entire different. Over the distinguished ordinary Γ value it has the single tame ramified point P of index two and different one, with its unramified companions. There are no other branch values.

Choose a rational coordinate b on B with its sole simple pole at the wild value. Since Y→B is separating, db pulled toY is NONZERO. The canonical differential divisor formula gives
\[
\operatorname{div}(db)=R_{Y/B}-2(Y\to B)^*(\infty)
=P+(2n+1)Q-2nQ=P+Q.
\]
Thus db is a nonzero REGULAR exact differential onY. Cartier kills every exact differential, while ordinarity makes Cartier injective on H0(Y,ωY). This is the contradiction.

Hence the quotient has exactly two branch values, one wild and one tame. No assumption on the total group being prime to five or on a simultaneous endpoint Galois closure entered the argument.

## The numerical ledger, and a pure-wild-inertia reduction

Write e for the wild inertia order, Δ for its different exponent, m for
the tame inertia order and n for the effective spin degree. Set
A=n/e and B=n/m. These are positive integers. The area identity gives
\[
A(\Delta-e)=B+1.
\]
Thus gcd(A,B)=1, and consequently lcm(e,m)=n. In particular, the two
actual inertia orders generate the whole effective degree numerically;
this is not a statement that they generate the global monodromy group.

If e is a power of five, the first positive ramification group is the
whole inertia group. Therefore Δ≥2e−2. On the other hand, the same
area identity gives Δ=e+e/m+e/n≤3e/2+1. Hence e≤6 and e=5.
A cyclic order-five local extension has Δ=4(j+1), where its positive
lower break j is a positive integer prime to five. The upper bound now
forces Δ=8 and j=1. Since m is prime to five, lcm(5,m)=5m=n;
substitution yields3/5−1/m=1/(5m), hence m=2 and n=10.

Thus every surviving case with PURE five-power wild inertia has exactly
\[
(n,e,m,\Delta)=(10,5,2,8).
\]
The original normalization degree is10 or30 according to its kernel
order. This is a necessary local-profile reduction, not an exclusion of
that remaining profile. Wild inertia with a nontrivial tame quotient is
not covered by this final reduction.
