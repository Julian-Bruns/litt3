# Proof: constant isogeny markings and embedded finite kernels

[Combined statement](../../Theorems/jacobians/common_bt_central_types.md).
Only the original common source and its two specified field embeddings
are used. No simultaneous Galois closure is needed.

## 1. Embedded finite subgroups

Let $B_0=\operatorname{Spec}A$ be finite over $k$. A finite locally
free subgroup of fixed rank $d$ is a quotient of the constant vector
bundle $A\otimes\mathcal O$ of rank $d$, with Hopf ideal kernel.
Such quotients are represented by a closed subscheme $\mathcal S_d$
of the corresponding Grassmannian: stability under multiplication,
counit, comultiplication and antipode gives closed equations in
the universal quotient. Thus $\mathcal S_d$ is projective.

The two embedded subgroups give maps
$s_X:X\to\mathcal S_d$, $s_Y:Y\to\mathcal S_d$ with
$s_Xf=s_Yg$. If their common reduced image had dimension one,
its function field would embed compatibly in both $k(X)$ and
$k(Y)$ inside $k(Z)$. This contradicts corelessness.
The image is therefore one point over $k$. Since the endpoint
curves are reduced, their maps factor through that reduced point.
The subgroups are both constant, with the same embedding in $B_0$.

This argument is about embedded subgroups. Abstractly isomorphic
quotients do not supply the equality of the two Grassmannian maps.

## 2. Comparisons between constant full groups are constant

For finite $k$-group schemes $B_0,B_1$ and a proper connected
smooth curve $C/k$, every morphism
$B_0\times C\to B_1\times C$ over $C$ comes from $k$.
Indeed its Hopf algebra matrix has entries in
$H^0(C,\mathcal O_C)=k$; all Hopf identities are then identities
over $k$. Applying this at every finite level proves
\[
\operatorname{Hom}_C(G_0\times C,G_1\times C)
=\operatorname{Hom}_k(G_0,G_1)
\]
for constant full $p$-divisible groups. After inverting $p$, the
same equality holds for quasi-homomorphisms. In particular a
quasi-isogeny between constant groups over $Z$ is constant.

## 3. Make the two isogeny markings agree

Choose quasi-isogenies
$\alpha_X:G_{0,X}\times X\dashrightarrow G_X$ and
$\alpha_Y:G_{0,Y}\times Y\dashrightarrow G_Y$.
The composition
\[
u=(g^*\alpha_Y)^{-1}\eta(f^*\alpha_X)
:G_{0,X}\times Z\dashrightarrow G_{0,Y}\times Z
\]
is a constant quasi-isogeny by Section2. Replace the second
marking by $\alpha_Yu$, so both markings start with
$G_0:=G_{0,X}$ and agree after pullback to $Z$.

Multiplying both by one sufficiently large common power of $p$
makes them actual isogenies
$a_X:G_0\times X\to G_X$ and $a_Y:G_0\times Y\to G_Y$,
still satisfying $\eta f^*a_X=g^*a_Y$.
The uniform power exists because the curves are quasi-compact
and the markings are quasi-isogenies. Their finite locally free
kernels are killed by one common $p^N$ and are therefore
subgroups of the same constant finite group $G_0[p^N]$.
Compatibility gives equality of the pulled-back embedded kernels.

Section1 makes both kernels equal to $K_0\times C$ for a fixed
$K_0\subset G_0[p^N]$. Consequently
\[
G_X\simeq (G_0/K_0)\times X,\qquad
G_Y\simeq (G_0/K_0)\times Y.
\]
Because both quotient maps agree under the original $\eta$,
these isomorphisms carry $\eta$ to the identity. These are
actual group isomorphisms, not merely quasi-isogenies.

## 4. The rational-crystalline formulation

On a smooth curve over a perfect field the crystalline Dieudonne
functor is fully faithful, and its rational form identifies
quasi-homomorphisms with morphisms of rational Dieudonne crystals.
See [de Jong, Corollary2.4.9 and Theorem4.1.1](https://www.numdam.org/article/PMIHES_1995__82__5_0.pdf).
If the rational crystal of an actual full group is constant,
evaluate it at a $k$-point. That fiber supplies a constant
$p$-divisible group whose rational crystal is the specified one.
Full faithfulness gives the quasi-isogeny required in Section3.

Here constancy includes the connection and Frobenius, rather than
only the Newton polygon or fiberwise rational Dieudonne modules.
There is no assertion that such a trivialization follows from a
constant Newton polygon. Likewise, a comparison only at a finite
truncation need not lift to an isomorphism of the full groups, so
it does not give the constant quasi-isogeny $u$ used above.

This proves the constant-rational section of the combined theorem.
The hypothesis does not follow from a constant Newton polygon and
does not supply a descent construction for a varying BT1 quotient.
