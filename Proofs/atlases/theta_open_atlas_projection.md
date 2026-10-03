# Proof: Schur rigidity retains all actual extension coordinates

[Statement](../../Theorems/atlases/theta_open_atlas_projection.md).
Keep the actual extensions and normalization of
[intrinsic atlas incidence](intrinsic_atlas_incidence.md).
For a fixed alpha write E=E_alpha and E^D=(F_C^*E)^vee tensor M.
The underlying sequence is O->E->V. D(alpha) is the ACTUAL
sequence K->E^D->M, not merely a class with the same determinant.

## 1. Rectangular rank at every actual atlas

At a normalized atlas, ell(p,alpha)=1 implies alpha!=0, and
the intrinsic theorem constructs an isomorphism E~E^D.
Apply Hom(V,-) to O->E->V:
\[
0\longrightarrow\operatorname{Hom}(V,E)
\longrightarrow\operatorname{End}(V)
\xrightarrow{\partial}\operatorname{Ext}^1(V,O),
\qquad \partial(1)=\alpha.
\]
Hom(V,O)=0 by stability and positive slope. Since V is stable,
End(V)=k, and alpha!=0 makes the displayed boundary injective.
Hence Hom(V,E)=Hom(V,E^D)=0.
The connecting map of K->E^D->M is precisely
L_alpha:Hom(V,M)->Ext1(V,K); its kernel is the image of
Hom(V,E^D), so L_alpha is injective.

This uses no H0(V)=0 assumption and no sampled minor.
Every actual atlas is retained on U_rk, whose definition covers
all full-column-rank minors.

## 2. Projective recovery with the exact normalization open

The entries of L_alpha have degree five, so on U_rk they give the
displayed subbundle of H tensor O and its rank8n quotient Q.
The linear I defines O(-1)->Q, hence s_I in H0(Q(1)).
On its zero scheme the equation I(alpha)=L_alpha(p) has a unique
solution in every maximal-minor chart, also over nonreduced rings.
These local solutions glue with weight minus four:
\[
L_{t\alpha}=t^5L_\alpha,\qquad I(t\alpha)=tI(\alpha),
\qquad p_{t\alpha}=t^{-4}p_\alpha.
\]
Therefore ell(p,alpha) has weight minus three, and its nonzero
locus is well-defined projectively.

On that locus the intrinsic incidence theorem proves that the
actual extension morphism is invertible and reconstructs the atlas.
In any representative chart, adjoining a scale t with
t^3=ell(p,alpha) gives EXACTLY the normalized affine incidence.
The root equation is finite étale since ell is a unit and3!=0.
Conversely every normalized atlas is on this locus by Section1.
These local covers glue to the free mu_3 action
(alpha,p)->(zeta alpha,zeta^-4p).
Thus the normalized scheme is a mu_3-torsor over Z.

The normalized intrinsic scheme is finite and reduced by its
established tangent argument. Étale descent gives the same for Z.
For each projective alpha, linear uniqueness gives one p up to the
prescribed scaling; its three roots form exactly one mu_3 orbit.
After algebraic closure the quotient therefore has distinct image
points in P(B). Its finite reduced coordinate algebra is generated
by projective coordinates on any affine chart containing those points,
by the Chinese remainder theorem. This proves a closed immersion;
the assertion descends through a faithfully flat field extension.
No extra nilpotents or actual atlases are lost.

To describe Q as a Frobenius pullback, write
L_alpha=sum_j alpha_j^5 L_j, with constant coefficient matrices L_j.
Take fifth roots of EVERY entry of the L_j, including the cup-map
coefficients, and first form the linear pencil in independent
coordinates. Its Frobenius pullback and full-rank open recover L and Q.
Variable fifth powers are not replaced by independent unknowns
in the original atlas equations.

## 3. Retain the whole acyclic special case

The quotient V_alpha=E^D/j0(e O) is globally a vector bundle,
with sequence T->V_alpha->M. Since H0(T)=0,
H0(V_alpha)=ker C_alpha; both cup spaces have dimension3n.
This proves the stated theta-open description.

Suppose H0(V_alpha)=0 and a p in ker L_alpha lifts to
h:V->E^D. Its composite psi:V->V_alpha cannot have rank one:
its image is a line quotient of stable V of degree greater than n,
so Riemann--Roch gives a nonzero section, contradicting acyclicity.
If psi=0, h factors through O and is zero.
If psi has rank two, equal determinants make it an isomorphism.
Then h splits E^D->V_alpha. Acyclicity makes the distinguished
j0(e) lie in the constant O summand; the retraction would split
the prescribed nonsplit O->K->T. This is impossible.
Hence L_alpha is injective on ALL of U_theta.

For a nonzero unnormalized incidence solution on U_theta,
the intrinsic extension morphism induces psi:V->V_alpha.
It is nonzero because I is injective. The same rank-one exclusion
makes psi, and then the extension morphism, isomorphisms.
The intrinsic pairing criterion gives ell!=0 automatically.
At an actual atlas V_alpha~V. Thus acyclic V retains every atlas
on U_theta; when H0(V)>0 this smaller open contains none of them.
The new U_rk covers both cases.

## 4. One finite-algebra recovery argument

In the affine lemma, full column rank makes v unique for each b
at every actual point; c^-1 is unique as well.
After algebraic closure the finite étale source is a finite set
of reduced points with distinct b-tuples. The evaluation map
k[b] onto its product coordinate algebra is surjective by the
Chinese remainder theorem, and descends faithfully flatly.
This gives closed immersion, radicality and polynomial recovery.

A finite reduced candidate algebra over a perfect field is a
product of separable field extensions. On each factor matrix rank,
linear consistency, residual vanishing and nonzero c persist
after every field embedding. Rank loss permits no actual point
by hypothesis. On a full-rank factor the unique solution is
retained EXACTLY when all residuals and c pass.
Every original point lies over the candidate algebra because J
consists of necessary consequences. Conversely every retained
graph satisfies the FULL original equations. Both are finite
reduced, so the resulting schemes agree.

For the rooted scalar charts, the actual swapped-pencil lemma
from [compact atlas incidence](compact_etale_atlas_system.md)
gives ker[v'->n(v',b)]=kv. Adding s_j(-,b), whose value on v is1,
makes H_j full rank. Apply the affine lemma with all higher
residuals b_h-s_h(v,b)^5 and c=v.s(v,b).
This proves every former rooted projection/recovery claim,
without identifying its scalar basis with the intrinsic one.
An admissibility inverse w=c^-1 and the existing three-lift
torsor are retained.

Finally reducedness makes g^(5^e) ideal membership equivalent
to g membership. Extracting an actual polynomial fifth power
roots the coefficients too. Necessary low-degree consequences
alone need not define a finite candidate algebra; such a claim
or a preferred nonzero minor still requires evidence.
Neither quotient-bundle rank nor projection proves emptiness.
