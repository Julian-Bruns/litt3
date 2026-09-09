# Eight-closure spin-series reduction audit

- Verdict: PASS (prose audit; not Lean verification).
- Auditor: /root/audit_eight_closure_spin_reduction.
- Date: 2026-09-08.
- Scope: version1 of [spin_series_etale_reduction](../../Theorems/Thm_spin_series_etale_reduction.md) and its [proof](../../Solutions/Sol_spin_series_etale_reduction.md), taking the alternating-growth and canonical-intersection inputs as stated. No computations or further agents were used.

No substantive objection found. Inseparability puts every section ratio
in the p-th powers; the globally generating section frames therefore
define a regular zero-p-curvature connection. Its invariance is with
respect to the specified pullback linearization over Y, so etale descent
and Cartier descent contradict degree1 on Y. Separability persists in
the actual etale tower.

For consecutive elliptic images, separability identifies the nonzero
differential lines. Normality at the two respective stages gives
stability under both endpoint groups in the infinite Galois union.
Dividing the m-th differential power by the common canonical tensor
gives exactly the finite-dimensional function space needed by the
finite-field descent lemma. Reduced zeros exclude a constant ratio.

The different is invariant and descends integrally at each normal
endpoint stage because the endpoint cover is etale. At even hyperbolic
stages its normalized degree is an integer in [0,2), hence0 or1.
Nonzero differents at6 and8 force both intervening inequalities to be
equalities, giving a singleton clump on Y, contrary to the existing
degree-m reduced clump and uniqueness. Thus the bound8 is justified.

Finally RR gives equally many sections of M and omega M^-1. Their
pullbacks exhaust the same complete section space, so a matching pair
of nonzero sections gives a rational isomorphism with globally invertible
pullback; faithful finite pullback detects every zero and pole. This
removes, rather than assumes away, a possible Picard-kernel twist.

Minor editorial issue only: in the last paragraph, the rational map
M -> M' pulls back to the **inverse** of the preceding isomorphism
phi^*M' -> L. Its invertibility and the conclusion are unaffected.

The audit does not establish descent of h or either endpoint field,
and does not turn these new etale quotients into the original two legs
or resolve the unmarked common-cover problem.
