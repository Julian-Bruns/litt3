# Endpoint refinement preserves clumps and characteristic-primary root height

Version2,3 October2026. Let $k$ be algebraically closed and retain an
actual coreless finite étale span $X\xleftarrow f Z\xrightarrow gY$
of smooth projective connected curves of genus at least two.
Let $X'\to X$ and $Y'\to Y$ be connected finite étale Galois covers
with groups $G_X,G_Y$ and degrees $d_X,d_Y$. Assume BOTH individual
pullbacks $Z\times_X X'$ and $Z\times_Y Y'$ are connected.

Let $W$ be ANY connected component of $X'\times_X Z\times_Y Y'$.
Keep its actual maps to $X',Y',Z$. Its stabilizer
$H\subset G_X\times G_Y$ projects onto both factors, and $W\to Z$
is an $H$-torsor.

## Geometry and integral Picard descent

The refined span is coreless. It has a clump exactly when the original
span does; in that case its clump is the full inverse image on $W$
of the original clump.

Let $P,P_W$ be the groups of invariant line-bundle triples, INCLUDING
their specified comparisons on the source. Pullback gives
\[
P\xrightarrow{\sim}P_W^H
\]
in either of the following cases:

- the FULL product is connected, with arbitrary finite endpoint groups
  and in any characteristic;
- $\operatorname{char}k=p>0$ and the endpoint groups are $p$-groups,
  even if the full product is disconnected.

The comparison removes the projective linearization obstruction in the
first case. In the second case scalar group cohomology and endpoint-kernel
characters vanish. No integral isomorphism is asserted for an arbitrary
component with arbitrary finite groups.

## Exact characteristic-primary height and a sharp degree index

Suppose $\operatorname{char}k=p>0$ and there is no clump.
Let $e,e_W$ be the positive generators of the $Y$- and $Y'$-degree
images of $P,P_W$. Put $m=|H|_{p'}$ and
$N=\exp(T_W)$, with $N=1$ when the degree-zero subgroup $T_W$ is zero.
Then $T_W$ is finite of order prime to $p$, and
\[
e_W\mid d_Ye,\qquad D:=\frac{d_Ye}{e_W}\mid m.
\]
If the full product is connected, $D\mid\gcd(N,m)$.
In particular, for $p$-group endpoint covers,
\[
e_W=d_Ye,\qquad
\frac{2g(Y')-2}{e_W}=\frac{2g(Y)-2}{e}.
\]
For arbitrary finite endpoint groups the two normalized canonical
degrees have the same $p$-adic valuation.

For rational endpoint differentials form the actual canonical class
$\xi=[f^*\theta_X/g^*\theta_Y]$ in
$k(Z)^*/(f^*k(X)^*g^*k(Y)^*)$, and form $\xi_W$ using their pulled-back
differentials on $W$. For EVERY $a\ge1$,
\[
\xi\text{ has a }p^a\text{-root}
\quad\Longleftrightarrow\quad
\xi_W\text{ has a }p^a\text{-root}
\]
in their respective actual multiplicative quotients.
If a clump exists, both classes have roots of every height.
The connectedness hypotheses cannot be dropped: this does not create
a root or make an opposite monodromy torsor connected.

## When all full $p$-group products are connected

For any actual finite bi-étale span in characteristic $p$, without a
corelessness hypothesis, the following are equivalent:

1. Every pair of connected finite étale Galois $p$-group endpoint covers
   has connected full product.
2. The combined pullback
\[
H^1_{\mathrm{et}}(X,\mathbf F_p)\oplus H^1_{\mathrm{et}}(Y,\mathbf F_p)
\longrightarrow H^1_{\mathrm{et}}(Z,\mathbf F_p)
\]
   is injective.
3. With compatible basepoints, $\pi_1(Z)$ surjects onto the product
   of the two maximal pro-$p$ endpoint quotients.

A sufficient condition is $\operatorname{Hom}(J(X),J(Y))=0$ and both
original covering degrees prime to $p$. No ordinariness, simplicity,
original Galois property or joint minimality is needed.
For either selected pair this holds on the branch $5\nmid\deg(f)$.
All simultaneous Galois five-group endpoint towers are available
there, while the no-clump degree and root obstructions remain.
No arbitrary-degree span is excluded and no common cover is constructed.

[Proof](../../Proofs/shared_tensors/cartesian_endpoint_refinement.md).
