# Connected endpoint covers preserve the clump and canonical root obstruction

Version1,16 September2026. Let k be algebraically closed and let
X<-f-Z-g->Y be an actual coreless finite étale span of smooth
projective connected hyperbolic curves. Let X'->X and Y'->Y be
connected finite étale Galois covers with groups G_X,G_Y and degrees
d_X,d_Y. Assume the FULL fiber product
\[
Z'=X'\times_X Z\times_Y Y'
\]
is connected; selecting a connected component is not a substitute.

The new span X'<-Z'->Y' is coreless. It has a clump if and only if
the original span does. In the positive case the new clump is the
full inverse image of the old one.

Let P,P' be the groups of invariant line-bundle triples on the two
spans, including their actual pullback identifications. The group
G=G_X times G_Y acts on P', and pullback gives
\[
P\xrightarrow{\sim}(P')^G.
\]
This integral descent statement holds in any characteristic and for
arbitrary finite Galois groups. The gluing identification removes
the possible projective obstruction to linearizing an endpoint line.

Suppose now char(k)=p, both covering groups are p-groups, and there
is no clump. Let e,e' be the positive generators of the Y- and
Y'-degree images of P,P'. Then
\[
e'=d_Y e,\qquad
\frac{2g(Y')-2}{e'}=\frac{2g(Y)-2}{e}.
\]
Consequently the exact p-root height of the canonical class in the
actual multiplicative quotient is unchanged. Independent p-group
endpoint covers cannot create a missing p-power root in this case.

There is a stronger component version. For arbitrary finite Galois
endpoint covers, suppose only that each of Z times_X X' and
Z times_Y Y' is connected. Every connected component W of the
full product is then coreless and has a clump exactly when Z does.
Write H for its stabilizer in G_X times G_Y; H projects onto both
factors. If the two groups are p-groups, pullback identifies
\[
P\xrightarrow{\sim}P_W^H.
\]
In the no-clump case the same formula e_W=d_Y e holds, and the
canonical p-root height is again unchanged. The one-leg connectedness
hypotheses cannot be dropped; this is not an assertion about arbitrary
endpoint refinements.

## When the full product is connected

For any actual bi-etale span in characteristic p, not necessarily
coreless, the following are equivalent:

- every pair of connected finite étale Galois p-group endpoint covers
  has connected full product;
- the combined pullback
\[
H^1_{\mathrm{et}}(X,\mathbf F_p)\oplus
H^1_{\mathrm{et}}(Y,\mathbf F_p)
\longrightarrow H^1_{\mathrm{et}}(Z,\mathbf F_p)
\]
is injective;
- with compatible geometric base points the map from pi_1(Z) to
  the product of the two maximal pro-p endpoint quotients is surjective.

A sufficient condition is Hom(J(X),J(Y))=0 and both original covering
degrees prime to p. No ordinariness, simplicity, Galois condition on
the original legs or joint minimality is needed.

For either selected pair, this condition holds on the branch
5 not dividing deg(f). Thus all simultaneous Galois five-group
endpoint towers are available there, but the no-clump degree
obstruction survives unchanged. No arbitrary-degree span is
excluded, and no clump or common cover is constructed.

[Proof](../../Proofs/shared_tensors/cartesian_endpoint_refinement.md).
