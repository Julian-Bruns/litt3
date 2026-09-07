# Proof: construct the bundle from its extension by O

[Statement](../Theorems/Thm_intrinsic_atlas_incidence.md).
The only geometric atlas input is the audited
`hermitian_atlas_extension_criterion`. The proof below works directly
with E/O=V; it does not start with a choice of quotient extension of V
and then search for its rank-three lift. This is why neither auxiliary
identification parameters nor a separate torsion-gluing argument remains.

## 1. Dimensions and the unique extension morphism

Stability of V, of slope g-1>0, gives Hom(V,O)=Hom(V,T)=0.
Since K has filtration O,T, also Hom(V,K)=0. Riemann--Roch and Serre
duality give

    dim B=4(g-1), dim A=4(g-1), dim H=12(g-1).

For A, its dual Serre obstruction is H0(V tensor M^-1 tensor omega),
a stable bundle of slope -(g-1). For H, deg(K tensor V^vee)=-8(g-1)
and its rank is4. Applying Hom(V,-) to O->K->T proves that I is
injective and that H/I(B)=Ext1(V,T) has dimension8(g-1).
Serre duality makes ell perfect, using the fixed nonzero kappa to
identify H1(omega) with k.

For alpha in B put E=E_alpha and E^D=(F_C^*E)^vee tensor M.
The extension equation in(1) is EXACTLY the condition for a commutative
diagram of extensions

    0 -> O -> E   -> V ->0
         |e   |Phi   |p
    0 -> K -> E^D -> M ->0.

This is the usual pushout/pullback criterion for extension morphisms.
The lift Phi is unique because Hom(V,K)=0. Its adjoint is a Frobenius
form beta, and the diagram says beta(-,F_C^*e_E)=p composed with E->V.
It remains to prove nonsingularity; a formal extension morphism alone
would not suffice.

## 2. The pairing detects all invalid quotient strata

Suppose the first equation holds, without yet assuming ell=1. Since
p u_p=0, form the vector-bundle pullback K_p=E x_V T. It fits into

    0 -> O -> K_p -> T ->0,

with extension class u_p^*alpha=ell(p,alpha) kappa. This remains a
vector-bundle sequence even if u_p has zeros or is zero. The composite
K_p->E->E^D lands in K. Its map on O is the identity and its induced
map on the quotient T is multiplication by some c in k. Compatibility
of these two extensions gives

    ell(p,alpha) kappa = c kappa, hence c=ell(p,alpha).       (2)

If c!=0, the morphism K_p->K is an isomorphism. This forces u_p to be
nowhere zero: at a zero of u_p, the fiber map K_p->E has image contained
in the one-dimensional O fiber, so its composite to K could not be
invertible. Thus p is globally surjective, K_p is the actual kernel
of E->M, and Phi is a morphism of the two filtrations K_p subset E and
K subset E^D, with isomorphisms on both associated pieces. Consequently
Phi is an isomorphism everywhere.

In particular ell=1 forces all these conclusions. Conversely if Phi is
an isomorphism and p is surjective, then K_p->K is an isomorphism, so
ell!=0 by(2). This argument does not require a preferred trivialization
of det Phi, or discard points at poles of rational coordinates.

The distinguished preimage K_p is a nonsplit extension with class kappa
when ell=1. Thus the reconstructed E,beta meet the audited normalized
atlas criterion, giving the actual finite etale atlas with torsion tau.

## 3. Every actual atlas can be normalized into(1)

Start with an atlas giving E,beta and an identification E/O=V. Its
adjoint Phi:E->E^D maps the distinguished O into K=F_C^*V^vee tensor M,
via j0. Now H0(K)=k e: the quotient T has negative degree. Since Phi
is everywhere invertible, Phi(e_E)=a e for a nonzero constant a.
Replace beta by a^-1 beta. This scalar change does not change the
projective form or the atlas. The resulting Phi has the diagram in
Section1 for some p, so its extension class alpha satisfies the first
equation. Section2 gives c=ell(p,alpha)!=0.

For t in k^x replace

    alpha'=t alpha,       p'=t^-4 p.

Because D is5-semilinear and L is bilinear, the first equation is
preserved: both sides are multiplied by t. Meanwhile
ell(p',alpha')=t^-3 c. Choose t^3=c to make it1. This uses a genuine
cube root over algebraically closed k, not replacement of fifth powers
by independent variables.

For completeness this scaling preserves actual atlas data. There is
an extension isomorphism f:E_alpha'->E_alpha inducing t^-1 on O and
the identity on V. Set beta'=t beta(f(-),F_C^*f(-)). Its distinguished
column is p'=t^-4p and Phi'(e)=e. This is an isomorphism followed by a
nonzero scalar change of a projective form. No endpoint or finite etale
map has been replaced by merely separable data.

This proves necessity and sufficiency. The chosen j0 is harmless:
the same argument begins with ANY fixed j0, since H0(K)=k e.

## 4. Fixed coefficient tensors and finiteness

Choose bases of A,B,H and Z. The operations I and pullback L are linear
and bilinear. Dual Frobenius sends cocycle coefficients to fifth powers,
with the fixed dualization sign already included in D. Hence the exact
polynomial equations are as stated. A splitting of I gives the stated
8(g-1)+4(g-1) blocks. No Cartier or ordinary field trace is involved.

At a geometric solution, linearize. Because d(alpha_j^5)=0,

    I(dalpha)=L(dp,D(alpha)).                               (3)

Projecting to H/I(B)=Ext1(V,T) yields dp^*eta=0, where eta is the
pushout of D(alpha) along K->T. The reconstructed Phi identifies its
quotient by O with the ACTUAL fixed V. Therefore eta is the extension
0->T->V->M->0 determined by this solution (including its identifications).
Apply Hom(V,-) to that sequence. The kernel of

    Hom(V,M) --eta--> Ext1(V,T)

is the image of Hom(V,V)=k, since V is stable. It is precisely k p.
Thus dp=s p. Equation(3) and injectivity of I imply dalpha=s alpha.
Finally the differential of ell=1 is2s=0, and2 is invertible in
characteristic5. Both variations vanish.

The polynomial solution scheme has zero cotangent space at every
geometric point. Its local rings are fields by Nakayama; as a finite-type
affine scheme over algebraically closed k it is finite and reduced.
The empty scheme is allowed. This is an assertion about the displayed
polynomial scheme, not an unstated representability claim for every
possible family of markings over an arbitrary base.

## Scope and implementation boundary

For a fixed dormant W the normalized V=W theta tau^2 satisfies the
required determinant and oper identification for each tau^3=O. The
proof therefore treats every torsion choice without scalarizing it or
postulating symmetry of a cup matrix. On the fixed genus-nine curve,
it gives64 variables and97 equations uniformly, including h0(V)>0.

The old scalar N/R tensors are a separately verified implementation in
the untwisted case. Comparing bases with this intrinsic tensor is a
concrete future task, not an assumption used here. Nor is a nonempty
atlas scheme an answer to the original two-curve common-cover problem.
