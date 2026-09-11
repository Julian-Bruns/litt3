# Proof: complete character tests at the actual backup

Version 1, 2026-09-11. A short specialization and cover-theoretic
corollary, with inherited evidence qualifications retained.

For the maximal abelian exponent-m cover of B, m prime to 5, the
character lines on B^(1) are precisely J(B^(1))[m]. The projection
formula and etale compatibility of the exact-differential bundle give

    a(B_m)=sum_(L in J(B^(1))[m]) h0(B^(1), B_B tensor L).

This proves ordinarity exactly when every character summand vanishes.

For m=6, the complete degree-1,2,3,6 cyclic-cover tests in Section 2
of [the audited no-cored proof](Sol_backup_cored_span_exclusion.md)
give this vanishing. They include all 40 cyclic cubic subgroups and
all 600 cyclic subgroups of exact order six, hence all primitive
characters as well as the lower-order characters. This is not an
inference from separate exponent-two and exponent-three ordinarity.

For m=4, order-dividing-two points are covered by the same complete
double-cover argument. The newly executed command

    sage scripts/verify_genus_two_four_torsion.sage \
      --parameter-polynomial 1,1,0,1 \
      --output Research/computations/backup_maximal_four_ordinarity.json

uses the actual backup parameter, not the different cubic specialization
in the original high-degree proof. In F5[a]/(a^6+a^4+4a^3+a^2+2), it
chooses t=a^3+2a^2+4a+1 and verifies t^3+t+1=0. It constructs all
256 distinct J[4] classes, checks each actual order, and for all 240
exact-order-four classes checks BOTH the original Cartier determinant
and the compressed Raynaud quadric. All are nonzero. It additionally
replays all 236 coprime additions by independent Cantor and Cramer
formulas. Runtime after startup is 0.312 seconds.

The torsion completeness, open-chart support, and original matrix
interpretation are the arguments of
[the four-torsion proof](Sol_genus_two_maximal_four_cover.md), Sections
1-3, using [the Raynaud determinant](Sol_raynaud_genus_two_determinant.md).
No high-parameter avoidance bound is used for the backup. Any root of
t^3+t+1 gives the same result by coefficient conjugation.

An etale Galois 5-group cover of an ordinary curve remains ordinary:
apply the invariant-vector argument to the etale-compatible bundle of
exact differentials. Every nonzero characteristic-five representation
of a finite 5-group has nonzero invariants. Thus vanishing of sections
downstairs implies vanishing upstairs. A non-Galois intermediate is
ordinary by injectivity of pullback of sections.

Finally, let W be the genuine Galois closure of the actual B-leg of
a proposed span. W/P is an abelian cover of the allowed exponent,
dominated by the corresponding maximal cover, so it is ordinary.
Then W is ordinary. But W->Z->X is an actual finite etale map and
pulls a nonzero Cartier-zero differential on nonordinary X back
injectively. This is a contradiction. Both original legs have been
retained throughout.

This extends the main pair's exponent-four obstruction to the backup
and adds exponent six using the separately audited complete cyclic
tests. It does not finish the coreless problem.
