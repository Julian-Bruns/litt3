# Proof: every two-character factor has already been excluded

2026-09-11. This is an elementary isogeny-decomposition corollary, not
an independent audit of the retained finite arithmetic inputs.

The maximal elementary-abelian two-cover exists by the mod-two
abelianization of the geometric fundamental group. Its group is
A=(Z/2)^18. For each nontrivial character chi of A, its kernel gives
the actual connected double X_chi->X. Rational character idempotents,
or the pullback and norm maps of these quotients, give

    J(X_[2]) ~ J(X) x product_(chi!=1) Prym(X_chi/X).

This is an isogeny of geometric abelian varieties. The dimensions are
9+(2^18-1)*8=1+8*2^18, agreeing with etale Riemann--Hurwitz. There is
no need to construct the genus-2,097,153 cover by explicit equations.

[The complete Prym theorem](../../Theorems/genus_two/backup_degree_two_atlas_exclusion.md)
excludes a geometric J(B) factor from EVERY nontrivial character
Prym, not just from a choice of 1,533 individual doubles. Its full
Frobenius/F4 orbit and torsion-label arguments cover all 262,143
characters. The same proof also verifies ordinarity of every such
Prym. Absolute simplicity of J(X) and J(B), of dimensions nine and
two respectively, excludes Hom(J(B),J(X)). Hence every factor on the
right has zero Hom from J(B), proving the displayed vanishing.

A nonconstant morphism of smooth proper curves U->B gives an
injective pullback J(B)->J(U) up to isogeny: norm composed with
pullback is multiplication by its positive degree. This remains
valid for inseparable maps. Thus X_[2] cannot map nonconstantly to B.
An intermediate U would give such a map by composition if U->B
existed. Finally, a cover whose Galois closure over X is elementary
abelian is dominated by X_[2]. Applying this to the actual X-leg
retains its original second map to B and gives the contradiction.

Ordinarity is isogeny-invariant. The character decomposition shows
that the nonordinary contribution of J(X_[2]) is inherited from
J(X); it must not be replaced by an assertion that the whole cover
is ordinary. No conclusion about new Jacobian factors after a
further nontrivial cover is used.
