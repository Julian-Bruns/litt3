# Proof: complete character tests at the actual backup

Version 1, 2026-09-11. A short specialization and cover-theoretic
corollary, with inherited evidence qualifications retained.

For the maximal abelian exponent-m cover of B, m prime to 5, the
character lines on B^(1) are precisely J(B^(1))[m]. The projection
formula and etale compatibility of the exact-differential bundle give

    a(B_m)=sum_(L in J(B^(1))[m]) h0(B^(1), B_B tensor L).

This proves ordinarity exactly when every character summand vanishes.

For m=6 the following complete character tests give the vanishing.
The base curve is ordinary. Its fifteen etale doubles are the
biquadratic curves obtained by splitting the six hyperelliptic branch
points into a pair and its complement. Their complementary elliptic
quotients y²=S are ordinary: every coefficient[u^4]S² is nonzero.

For each of the40 cyclic cubic subgroups, the
[complete norm algebra](../../quotient_geometry/endpoint_exclusions/backup_hermitian_atlas_exclusion.md#1-complete-finite-candidate-list)
gives h=v−A with div(h)=3D−6O and D's monic quadratic U. On z³=h,
the two primitive differential lines are z eta and U eta/z,
eta=du/v. Since deg A≤3, Cartier(A du)=0. The three remaining Cartier
coefficients equal gamma times the fifth-power coefficient vector of U,
where gamma=[u^14]((F+A²)F²). A saved inverse for gamma in the entire
length40 algebra proves that both arrows are nonzero at every point.

Adding each of the15 nonzero two-classes to those cubic classes gives
all600 cyclic subgroups of exact order6. This last test is essential:
separate order2 and3 ordinarity alone would not test mixed characters.
Here is its divisor formula. Normalize A=a3 B, lambda=a3^(-2), w=v/a3,
so B²−lambda F=U³. Represent a two-class by the product E of one or
two branch factors, and choose W≡B mod U, W≡0 mod E. The remaining
quadratic in (F−W²/lambda)/(UE) is Unew, up to its nonzero leading
coefficient. The norm and addition identities give

    h6=lambda^(-2)(w−W)^6(w+B)²/(U^6 E³),
    div(h6)=6Dnew−12O,     h6=A6(u)+w B3(u),

with deg A6=6 and deg B3≤3. On z^6=h6 the primitive lines are again
z eta and Unew eta/z. Their Cartier arrows are nonzero exactly when
[u^14](A6 F²)≠0; the B3 du term has zero Cartier image. The
[cyclic certificate](../../../Research/computations/backup_genus_two_cyclic_covers.json)
checks the full coefficient identity and a polynomial inverse in all15
length40 algebras. Lower characters are the already ordinary quotients.
This proves ordinarity for every degree1,2,3,6 cyclic cover, and hence
for the maximal exponent-six cover by the displayed character sum.
The [original small-packet audit](../../../Research/audits/BACKUP_CORED_COMPLETION_AUDIT_2026_09_11.md)
checked this geometry and its complete finite tests.

For m=4, order-dividing-two points are covered by the same complete
double-cover argument. The newly executed command

    sage scripts/genus_two/verify_genus_two_four_torsion.sage \
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
[the four-torsion proof](genus_two_maximal_four_cover.md), Sections
1-3, using [the Raynaud determinant](../theta_divisors/raynaud_genus_two_determinant.md).
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
