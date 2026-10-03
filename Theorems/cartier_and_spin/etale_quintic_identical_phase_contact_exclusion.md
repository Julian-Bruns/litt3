# Identical endpoint phases contradict quintic etale normalization

Version2,2 October2026. [Focused independent review](../../Research/audits/ETALE_QUINTIC_IDENTICAL_PHASE_AUDIT_2026_10_02.md) PASS. The original conductor argument is retained; Version2 adds full-fiber stripping and the mixed-profile bounds.
Let pi:T->S be a finite etale degree-five map of smooth connected projective curves in characteristic5. Let H be a line bundle of positive degree m and a a primitive section of pi^*H with reduced zero divisor. Suppose each fiber meeting div(a) has EXACTLY two zero sheets. Thus m is even and there are5m/2 such fibers. In the etale local splitting assume:

* The two zero sections differ to order at least3.
* The three nonzero values lie in one orbit under multiplication by a primitive cube root of unity.
* Whenever two nonzero values coincide, their sections differ to order at least2.

Then no such source and section exist. No Galois assumption is made. The proof combines the exact section-order contact budget10m, low-degree coefficient vanishing and a globally regular conductor-derived section whose trace contradicts the even discriminant valuation.

More generally, strip all complete five-sheet zero fibers from a and H. Let the reduced degree again be m>0 and let n_k count its zero fibers with k=1,2,3,4 zero sheets. Suppose all zero pairs differ to order at least3, the nonzero values at each such fiber lie in one C3 orbit, and repeated nonzero values differ to order at least2. Any surviving source must satisfy
\[
n_1+2n_2+3n_3+4n_4=5m,\qquad n_2\ge3n_3+10n_4,
\qquad n_2+9n_3+42n_4\le2n_1.
\]
In particular NO source with no residual singleton zero fiber survives. Complete fibers do not evade this conclusion: their base factor can be stripped without changing comparison ratios; reduced degree zero makes the section descend and is incompatible with a primitive nonconstant comparison.

In the ACTUAL primitive degree-five character comparison, retain both original finite etale maps h:T->X,q:T->Y from the SAME source and the intermediate pi through which q factors. If the exact normalized X comparisons have only ONE finite root/phase label, these local hypotheses hold at every noncomplete infinity fiber. Such a configuration is excluded in EVERY degree when there is no singleton infinity fiber after stripping, or when either displayed necessary inequality fails. Many-singleton profiles are not excluded.

For the actual n10,e5 residual comparison of [the scalar-one endpoint theorem](scalar_one_self_dual_endpoint_restriction.md), the two fivefold packets CANNOT be identical, in EITHER pole30 incidence profile. Profile(2^5) uses the uniform theorem above. Profile(3,2^2,1^3) has total section contact at least21, exceeding20. The remaining pole30 cases have two DISTINCT packet labels; neither those cases nor an arbitrary unmarked span are excluded here.

[Proof](../../Proofs/cartier_and_spin/etale_quintic_identical_phase_contact_exclusion.md).
