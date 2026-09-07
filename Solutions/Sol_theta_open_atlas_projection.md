# Proof: acyclicity excludes rank-one morphisms, not just a generic pivot

[Statement](../Theorems/Thm_theta_open_atlas_projection.md).
Use the fixed intrinsic extension and determinant conventions.

The quotient V_alpha exists globally because j0(e O) is a sub-line-bundle
of K and hence of E_alpha^D. Its extension0->T->V_alpha->M->0 gives
H0(V_alpha)=ker C_alpha, since H0(T)=0. Both cup spaces have dimension
3(g-1), so the determinant describes the asserted open exactly. Scaling
alpha does not change its zero set because D is5-semilinear.

## 1. Rectangular injectivity on the entire open set

Fix alpha with H0(V_alpha)=0. A p in ker L_alpha lifts through the
extension D(alpha) to a homomorphism h:V->E_alpha^D. Let psi be its
composite with E_alpha^D->V_alpha. If psi=0 then h factors through O
and is zero, since Hom(V,O)=0; hence p=0.

If psi has generic rank one, its image is a rank-one torsion-free
quotient R of the stable V. Its degree is strictly greater than g-1.
Consequently h0(R)>=deg R+1-g>0, by Riemann--Roch. The injection
R->V_alpha contradicts H0(V_alpha)=0.

If psi has rank two, it is an isomorphism: both determinants equal T M,
so its nonzero determinant is a nonzero global constant. The map h then
splits E_alpha^D->V_alpha. In a splitting O+V_alpha, the distinguished
global section j0(e) belongs to the O summand, because H0(V_alpha)=0,
and is a nonzero constant there. The retraction to O restricts on K to
a retraction of e:O->K. This contradicts the prescribed nonsplitting
of K. Thus this case is impossible too, proving ker L_alpha=0.

The argument is uniform in alpha, and never chooses a square minor.
Pointwise full rank makes L a subbundle map on the stated projective open.

## 2. All bad extension morphisms lie outside this open

Suppose alpha!=0 and I(alpha)=L_alpha(p), with H0(V_alpha)=0. The
intrinsic theorem constructs Phi:E_alpha->E_alpha^D fixing O. Its
quotient is psi:V->V_alpha, and its composite to M is p. Necessarily
p!=0 by injectivity of I. Thus psi!=0. The same rank-one argument as
above shows that psi is an isomorphism. Since Phi is the identity on O,
it too is an isomorphism. The intrinsic nondegeneracy argument gives
ell(p,alpha)!=0, and normalization produces the actual atlas.

Conversely an actual atlas makes V_alpha isomorphic to V. If H0(V)=0,
its alpha lies in precisely this open. Part1 gives unique p there.
If H0(V)>0, its alpha does not lie in the open; such an atlas has not
been excluded by the present reduction.

Equivalently every nonzero degenerate solution of the unnormalized
intrinsic equations has H0(V_alpha)>0. This explains why the cup
determinant, unlike a sampled polar determinant, removes all invalid
solutions in the acyclic branch.

## 3. Projectivization and the three normalizations

The entries of L_alpha have degree5 in alpha. Its injectivity on U
therefore gives the stated vector-bundle exact sequence, and the linear
inclusion I: B->H gives O(-1)->Q, or s_I in H0(U,Q(1)). The equation
s_I=0 is exactly membership in im L_alpha. On every full-rank minor
chart it uniquely recovers p by ordinary linear algebra. These local
solutions glue with weight-4 under alpha->t alpha, because

    L_(t alpha)=t^5 L_alpha,      I(t alpha)=t I(alpha).

By Section2 the resulting ell has no geometric zero on Z, hence is a
unit locally there. The condition t^3=ell gives a finite etale mu_3-
torsor, and yields exactly the normalized affine equations. This works
also over nonreduced local coefficient rings: the linear reconstruction
uses invertible minors, and the root equation is etale because3!=0.
The normalized scheme is finite and reduced by the audited intrinsic
theorem. Its quotient Z has the same properties (or use the etale root
cover to lift tangent vectors). No new field equations are introduced.

The Frobenius-pullback description of Q concerns its coefficient tensor:
write D(alpha)=D_c alpha^[5] in fixed bases, take fifth roots of D_c,
and first form the linear map in independent coordinates on P(B).
Pulling that map and its full-rank open back by Frobenius gives the
displayed L and Q. This is not a claim that the original problem is
unchanged after replacing unknown fifth powers independently.

The section's rank exceeds the base dimension, which explains generic
emptiness only. Nothing here establishes that our specific s_I avoids
zero. This is a robust elimination of variables, not an atlas exclusion.
