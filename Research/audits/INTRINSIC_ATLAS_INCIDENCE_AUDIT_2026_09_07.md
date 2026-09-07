# Intrinsic atlas incidence: independent major audit

Verdict: PASS.
Auditor: `/root/intrinsic_atlas_major_audit`.
Date: 2026-09-07.
Target: [statement](../../Theorems/Thm_intrinsic_atlas_incidence.md),
[definitions](../../Definitions/Def_intrinsic_atlas_incidence.md), and
[proof](../../Solutions/Sol_intrinsic_atlas_incidence.md).

No material objection. This is a prose audit, not formal verification.

The pushout/pullback equality is the global necessary and sufficient
condition for the extension morphism, whose uniqueness follows from
Hom(V,K)=0. The specified dual sequence fixes the dualization sign and
gives an additive fifth-semilinear map; it does not require identifying
twisted scalar differential operators.

The argument on the pullback K_p also applies when p or u_p has zeros.
Its induced quotient map is multiplication by ell(p,alpha), because
the source extension class is ell(p,alpha) times kappa and its subline
map is the identity. Thus ell=1 makes K_p -> K invertible and forces
u_p to have no zero fiber. This proves global surjectivity of p and
nonsingularity of the reconstructed form without omitting a boundary
stratum. The audited Hermitian bundle criterion then supplies the
actual finite etale atlas and its stated torsion character.

The normalization alpha -> t alpha, p -> t^-4 p is correct: the first
equation scales by t and ell scales by t^-3. The displayed extension
isomorphism scales the distinguished subline by t^-1; pulling back the
form and multiplying it by t gives precisely the asserted new column.
An arbitrary fixed j0 causes no obstruction, since H0(K)=k e and an
invertible atlas form maps the distinguished section to a nonzero
multiple of this section.

At a normalized solution the pushout of D(alpha) along K -> T has
middle term identified with the actual V, with subline u_p and quotient
p. Hence the kernel of its connecting map Hom(V,M) -> Ext1(V,T) is
exactly k p by stability. The linearized equations force dp=s p and
dalpha=s alpha, and the normalization forces 2s=0. Thus all tangent
spaces vanish, including when H0(V) is nonzero. Finite type over the
algebraically closed field then gives the claimed finite reduced scheme.
The dimension counts and the genus-nine 64-variable, 97-equation count
are correct.

Qualifications, already consistent with the statement: stability and
the given isomorphism j0 are hypotheses; this is an exact existence
criterion with those data, not a construction of j0 for arbitrary V.
The proof does not assert a moduli equivalence for families with every
possible marking, nor a basis comparison with the exported untwisted
tensor. It does not establish emptiness or solve the unmarked common-cover
problem. No scalar residue generalization is used as an unproved input.
