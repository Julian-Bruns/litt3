# Proof: higher characters at one seed, then arithmetic transport

Original character evidence,2026-09-11; hindsight,3 October2026.

The [first-height cubic classification](../../deformations/pointed_extensions_frobenius.md)
and [affine branch symmetry](../../curve_arithmetic/prime_field_branch_family.md)
give three Frobenius-conjugate roots of I³+2I²+4I+4, each with twenty
affine parameters. The backup has I=alpha+1. Thus every stated Y_t is
an actual affine isomorphism or coefficient Frobenius twist of B.
Jacobian ordinarity and the maximal abelian [m]-pullback commute with
both operations. A moved Abel base point changes the map by a Jacobian
translation; lifting that translation through [m] gives an isomorphism
of the actual covers over the transported curve. Coefficient Frobenius
transports coefficients and actual morphisms by the field automorphism.
It suffices to prove the seed, with all original
higher-character computational qualifications retained.

For the maximal abelian exponent-m cover of B, m prime to 5, the
character lines on B^(1) are precisely J(B^(1))[m]. The projection
formula and etale compatibility of the exact-differential bundle give

    a(B_m)=sum_(L in J(B^(1))[m]) h0(B^(1), B_B tensor L).

This proves ordinarity exactly when every character summand vanishes.

For m=6 the lower-order character vanishing needs no new table.
Since alpha has degree three, it is outside F25. The
[maximal-two theorem](../../../Theorems/jacobians/ordinary_covers/genus_two_maximal_two_cover.md)
makes B and its actual maximal elementary-two cover ordinary. Every
connected cyclic double is an intermediate quotient and is ordinary.
This replaces the former fifteen elliptic-Hasse calculations.

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
[torsion generator](../../../scripts/genus_two/backup_genus_two_torsion.sage)
and [cyclic checker](../../../scripts/genus_two/backup_genus_two_cyclic_covers.sage)
reconstruct the complete length-40 norm algebra, the full higher-character
coefficient identity and a polynomial inverse in
each of the fifteen length-40 algebras. From the repository root,
run them in this order:

```sh
sage scripts/genus_two/backup_genus_two_torsion.sage --output ../litt3-computation-data/backup_abelian_ordinarity/torsion.json
sage scripts/genus_two/backup_genus_two_cyclic_covers.sage --include-six --seconds 600 --torsion ../litt3-computation-data/backup_abelian_ordinarity/torsion.json --output ../litt3-computation-data/backup_abelian_ordinarity/cyclic.json
```

The required final output has completed status, forty connected cubic covers,
fifteen six-torsion translates, and zero bad primitive-character
pairs. Lower characters are the already ordinary quotients.
This proves ordinarity for every degree1,2,3,6 cyclic cover, and hence
for the maximal exponent-six cover by the displayed character sum.

For m=4, order-dividing-two points vanish by the same maximal-two theorem. The command

    sage scripts/genus_two/verify_genus_two_four_torsion.sage \
      --output ../litt3-computation-data/backup_abelian_ordinarity/four_torsion.json

uses the single actual backup seed. In F5[a]/(a^6+a^4+4a^3+a^2+2), it
chooses t=a^3+2a^2+4a+1 and verifies t^3+t+1=0. It constructs all
256 distinct J[4] classes, checks each actual order, and for all 240
exact-order-four classes checks BOTH the original Cartier determinant
and the compressed Raynaud quadric. All are nonzero. It additionally
replays all 236 coprime additions by independent Cantor and Cramer
formulas.

For completeness, put tau=t^5, alpha=(0,1,2,3,tau) and
F1(u)=prod_j(u−alpha_j). For i=0,1,2,3 choose r_j²=alpha_i−alpha_j,
r_i=0, and let s_j be their elementary symmetric functions. The pairs
\[
U_i=(alpha_i-u)^2+s_2(alpha_i-u)+s_4,\qquad
V_i=(s_3-s_1s_2)(alpha_i-u)-s_1s_4
\]
represent halves H_i of [(alpha_i,0)−O] by
[Zarhin, Theorem3.2 and Example3.7](https://arxiv.org/html/1809.03061v2).
The verifier also checks F1−(s_1U_i+V_i)²=(u−alpha_i)U_i².
The four two-classes are independent, so their halves generate all
J[4]≅(Z/4)^4. On every exact-order-four class the degree-two open
chart is verified, and the [Raynaud determinant theorem](../theta_divisors/raynaud_genus_two_determinant.md)
identifies both determinant tests with the actual character section.
Thus this seed proof is independent of the family Hodge bound.
No high-parameter avoidance bound is used for the backup. Coefficient
conjugation and the affine transport above extend both maximal-cover
conclusions to the entire sixty-parameter locus. Original double tables
remain evidence for the historical independent assembly audit; their
producer is no longer a proof input and is deleted.

An étale Galois p-group cover preserves ordinariness by
[Crew, Corollary1.8.3](https://numdam.org/item/CM_1984__52_1_31_0.pdf#page=7).
Ordinariness descends to every separable intermediate by injectivity
of pullback on Cartier-zero differentials.

Every abelian cover of exponent dividing four or six is a quotient
of the corresponding maximal cover, so ordinariness descends to it.
The Crew theorem then gives ordinariness after any connected etale
five-group cover. The stronger actual-span monodromy exclusion is
proved by the [unit-root theorem](../isogeny_sieves/five_by_abelian_unit_root_exclusion.md),
which includes the exponent-four and exponent-six quotients.
