# Proof: one component theorem for geometry, descent and root height

[Statement](../../Theorems/shared_tensors/cartesian_endpoint_refinement.md).
The inputs are the one-clump theorem and the invariant Picard and exact
canonical-root theorem in [saturated divisor relations](saturated_divisor_relations.md).
All endpoint fields, line comparisons and component maps are the actual ones.

## 1. Component geometry

Let W be a connected component and H its stabilizer in G_X times G_Y. Then W->Z is a connected
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

## 2. Descent of the invariant triple, including its gluing

Suppose the full product is connected. Write Z'=W, P'=P_W and
G=H=G_X times G_Y.
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

## 3. Scalar obstructions and the $p$-group descent special case

Automorphisms of an invariant triple are simultaneous multiplication by
one scalar in $k^*$: proper connectedness makes the endpoint automorphisms
scalars, and the source comparison identifies them. Thus an $H$-invariant
triple has its linearization obstruction in $H^2(H,k^*)$, with trivial
scalar action. Positive group cohomology is killed by $|H|$.
In characteristic $p$, raising scalars to their $p$th power is an
automorphism of the cochain complex. Therefore $m=|H|_{p'}$ already
kills $H^i(H,k^*)$ for $i>0$.

Taking an $m$th tensor power kills the obstruction and gives an actual
$H$-linearization of the triple, including its source comparison.
The kernels $K_X=\ker(H\to G_X)$ and $K_Y=\ker(H\to G_Y)$ act on
their respective endpoint lines by characters. Each character has
order dividing $m$, since a finite subgroup of $k^*$ has order prime
to $p$. Another $m$th power kills both characters. The endpoint actions
then factor through $G_X,G_Y$, so the endpoint lines and the equivariant
comparison descend to an ORIGINAL triple along $W\to Z$.
Thus every invariant triple has its $m^2$th power in the pullback image.

If $H$ is a $p$-group, $m=1$. Both $H^2(H,k^*)$ and $H^1(H,k^*)$
vanish, and the kernel characters are trivial. Linearization therefore
exists uniquely up to isomorphism; the same uniqueness descends
isomorphisms of triples. This proves $P\simeq P_W^H$ for $p$-group
components, even in the clump case. For a full connected product,
Section2 already proves integral descent in every characteristic.

## 4. The degree index is prime to $p$ and divides $m$

Suppose there is no clump. The invariant Picard theorem gives
\[
0\longrightarrow T_W\longrightarrow P_W
\xrightarrow{\deg_{Y'}}e_W\mathbf Z\longrightarrow0
\]
with $T_W$ finite of order prime to $p$. Pullback multiplies degree by
$d_Y$, so $e_W\mid d_Ye$. Choose $x\in P_W$ of degree $e_W$.
Since $hx-x\in T_W$, its $N$th power is $H$-invariant.
Section3 descends the $Nm^2$th power of $x$. Hence
$D=d_Ye/e_W$ divides $Nm^2$, and $p\nmid D$.
In the full connected-product case Section2 descends the $N$th power
already, giving $D\mid N$.

Norm the ACTUAL comparison of $x$ along $W\to Z$.
The kernel quotients $W/K_X$ and $W/K_Y$ are respectively
$Z\times_X X'$ and $Z\times_Y Y'$: both are the connected torsors
with the same equivariant quotient map. Transitivity and base change
of finite étale line-bundle norms give
\[
\operatorname{Nm}_{W/Z}(f_W^*L_{X'})
\simeq f^*\operatorname{Nm}_{X'/X}(L_{X'})^{\otimes |K_X|},
\qquad
\operatorname{Nm}_{W/Z}(g_W^*L_{Y'})
\simeq g^*\operatorname{Nm}_{Y'/Y}(L_{Y'})^{\otimes |K_Y|}.
\]
This supplies an original invariant triple without choosing a
linearization. Norm of a line bundle preserves divisor degree on
curves, so its $Y$-degree is $|K_Y|e_W$.
Since $d_Y|K_Y|=|H|$, we get $d_Ye\mid |H|e_W$.
Thus $D\mid |H|$, and the already proved $p\nmid D$ sharpens this
to $D\mid m$. With a full connected product, $D\mid\gcd(N,m)$.
For $p$-groups $m=1$, giving the entire older degree-equality assertion.

## 5. Every canonical root height is preserved

Étale Hurwitz and the index calculation give
\[
\frac{2g(Y')-2}{e_W}=D\frac{2g(Y)-2}{e},\qquad p\nmid D.
\]
The exact canonical-root theorem identifies a $p^a$-root in a no-clump
span with $p^a\mid(2g(Y)-2)/e$. Apply it to both spans.
Their root conditions agree for every $a$, and for $p$-groups their
normalized degrees agree exactly. Using the pulled-back rational
frames makes $\xi_W$ precisely the pullback of $\xi$, including the
specified endpoint embeddings. In the clump case Section1 gives
clumps on both spans, and the same root theorem gives all heights.

## 6. Independence detected by Artin--Schreier characters

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

Both individual connectedness hypotheses remain essential.
No arbitrary selected component, missing root or common cover is supplied.
