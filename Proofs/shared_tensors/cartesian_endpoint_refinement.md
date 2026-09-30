# Proof: full Cartesian endpoint covers and invariant degree

[Statement](../../Theorems/shared_tensors/cartesian_endpoint_refinement.md).
The inputs are the one-clump theorem and the invariant Picard
and root-height statements in
[saturated divisor relations](saturated_divisor_relations.md).

## 1. Corelessness and clump descent

Since the full product Z' is connected, it is a G_X times G_Y
Galois cover of Z. Write F',G',E' for the actual new endpoint and
source fields. G_X acts on F' with fixed field F=k(X) and fixes G'
pointwise; G_Y acts conversely. An element of F' intersect G' is
therefore fixed by both groups, hence belongs to F intersect G=k.
This proves corelessness of the new span.

Pullback of an old clump is plainly a clump in the full product.
Conversely, let S' be a clump upstairs. Each deck transformation
acts on the span, with its corresponding automorphism of one
endpoint. It carries S' to another clump. Corelessness and the
one-clump theorem make S' invariant under both deck groups.
Thus S' is the full inverse image of a nonempty finite set S in Z.

To check saturation of S, choose z in S and z_2 with f(z_2)=f(z).
Choose any lift x' of this common point and lifts y'_1,y'_2 of
g(z),g(z_2). Both (x',z,y'_1) and (x',z_2,y'_2) are points of Z'.
The first lies in S', so its saturation under the X'-leg puts the
second in S'. Hence z_2 lies in S. The same argument on the other
side proves that S is a clump. Use of the FULL connected product
is essential at this step.

## 2. Descent of the invariant triple, including its gluing

Pullback gives a map P->(P')^G. Consider a fixed isomorphism class
represented by (L_X',L_Y',phi). For sigma in G_X, invariance gives
an isomorphism of triples from its sigma-translate to itself.
The induced automorphism of L_Y' is a scalar, because Y' is proper
and connected. Rescale both components by its inverse. The
Y'-component is now the identity, and the X'-component is UNIQUE:
any two choices would differ by a scalar whose pullback fixes phi,
so that scalar would be one.

Compositions of these normalized isomorphisms remain normalized,
hence uniqueness gives the cocycle condition. They define an actual
G_X-linearization of L_X', with L_Y' unchanged and phi equivariant.
Repeat for G_Y, fixing the X'-component. The resulting actions on
the two pulled-back lines commute: one is pulled from the X'
coordinate and the other from the Y' coordinate. Thus phi is
equivariant under the whole product group.

Finite étale descent gives lines L_X,L_Y on the old endpoints and
descends phi along Z'->Z to f*L_X~g*L_Y. This proves surjectivity.
The same uniqueness shows injectivity: if two descended triples
become isomorphic, an upstairs isomorphism intertwines the unique
normalized actions and descends. This proof neither divides by
a group order nor assumes vanishing of a Schur multiplier.
The specified gluing, and normalization on the opposite endpoint,
supply the linearizations.

## 3. The degree lattice under p-group covers

Assume there is no clump. By Section1 this also holds upstairs.
The saturated-divisor theorem gives
\[
0\longrightarrow T'\longrightarrow P'\xrightarrow{\deg_{Y'}}
e'\mathbf Z\longrightarrow0,
\]
where T' is finite of order prime to p. Let G be the product of
the two p-groups, let N=|G|, and choose x in P' of degree e'.
Use additive notation. For gamma in G put t_gamma=gamma x-x in T'
and put S=sum_gamma t_gamma. Then
\[
\delta S=S-Nt_\delta.
\]
Multiplication by N is an automorphism on T'. Put b=N^(-1)S.
The equation gives delta(x+b)=x+b for every delta. Thus P'^G
contains an element of the minimal positive degree e'.

Section2 identifies P'^G with P. Pullback multiplies Y-degree
by d_Y, so its degree image is d_Y e Z. It is also e' Z by the
preceding correction. Consequently e'=d_Y e. Étale
Riemann--Hurwitz multiplies the Y canonical degree by the same
factor, proving equality of the normalized canonical degrees.
Their p-adic valuation is the exact root height by the cited theorem.
The rational canonical class itself pulls back compatibly, using
the pulled-back rational endpoint frames.

## 4. Independence detected by Artin--Schreier characters

The Galois torsor Z'->Z has group G_X times G_Y. Its connectedness
is equivalent to surjectivity of the monodromy image H inside that
finite product. A proper subgroup of a finite p-group is contained
in a maximal subgroup, and every maximal subgroup is normal of
index p. Thus H is proper if and only if some nonzero F_p-valued
character of the product vanishes on H.

Such a character is a pair of endpoint Artin--Schreier characters.
Injectivity of the stated combined pullback therefore makes every
full product connected. Conversely, any nonzero kernel pair
produces endpoint Z/p-torsors (using the identity cover for a zero
component) whose product has non-surjective monodromy. This proves
the exact equivalence. The pro-p formulation follows because finite
product quotients form a cofinal neighborhood basis and the image
of a profinite group is closed.

For the sufficient geometric condition, put n=deg(f), m=deg(g).
On Jacobians, Hom-zero and duality give
\[
\operatorname{Nm}_f g^*=0,\qquad
\operatorname{Nm}_g f^*=0.
\]
The two same-leg norm compositions are [n] and [m].
Their differentials show that the combined pullback on H^1(O)
is injective when n,m are units in k: applying the two norms to
f*a+g*b=0 gives na=0 and mb=0.

For a proper connected curve over algebraically closed k,
the [Artin--Schreier sequence](https://stacks.math.columbia.edu/tag/0A3J)
identifies H^1_et(C,F_p) with the Frobenius-fixed subgroup of
H^1(C,O_C); the constants contribute no cokernel because t^p-t
is surjective on k. This identification is functorial. Injectivity
on H^1(O) therefore implies the required character injectivity.

These results retain both original maps and the actual Cartesian
cover. They do not replace a disconnected product by a chosen
component, infer an invariant section, or make a missing root
exist by enlarging the endpoint p-towers.

## 5. Components when both individual base changes are connected

Under the stated weaker hypothesis let W be a connected component
and H its stabilizer in G_X times G_Y. Then W->Z is a connected
H-torsor. Each projection H->G_X,G_Y is surjective, because the
corresponding individual pullback torsor on Z is connected.

Put K=k(X') intersect k(Y') inside k(W). It is preserved by H,
and K^H is contained in both k(X')^H=k(X) and k(Y')^H=k(Y).
Thus K^H=k. A field is finite over the fixed field of a finite
group of automorphisms, so K is algebraic over k and equals k.
The component span is therefore coreless.

Its unique clump, if present, is H-invariant and descends as a
finite set S in Z. To descend saturation, fix x' above f(z).
For any z_2 with f(z_2)=f(z), the map from the H-torsor W_(z_2)
to the G_X-torsor X'_(f(z)) is surjective, since H->G_X is onto.
Thus W contains a point above z_2 with precisely that x'
coordinate. Saturation upstairs puts it in the clump. The other
leg is identical. Pulling back an old clump proves the converse.

For the additional p-group assertion, the automorphism group of an
invariant line-bundle triple on W is k*, acting diagonally. An
H-fixed isomorphism class has its usual linearization obstruction
in H^2(H,k*). This group is zero: multiplication by |H| is an
automorphism of k*, while positive group cohomology is killed by
|H|. The same observation gives H^1(H,k*)=0, so a linearization
exists and is unique up to isomorphism.

On the X'-line, the kernel of H->G_X acts trivially on the curve
and hence by scalar automorphisms of the line. This is a character
of a p-group into k*, and is trivial. Its linearization therefore
factors through G_X. Similarly the other line's action factors
through G_Y. Descend both lines and the H-equivariant gluing along
W->Z. Uniqueness of the H-linearization also descends isomorphisms,
proving P=P_W^H.

With no clump, T_W is finite of order prime to p. Apply the same
explicit correction from Section3 to the p-group H acting on P_W.
Its invariant subgroup has the full degree image e_W Z. Descent
identifies this image with d_Y e Z, proving the claimed degree
and root-height formulas for every such component.
