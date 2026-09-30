# Supersingular fibers detect the actual next-level comparison

Version1,21 September2026. Work over $k=\overline{\mathbf F}_5$.
Use the universal group, determinant convention and strict formal
symmetry groups $\mathscr A_N$ of
[the sharp transport theorem](versal_bt3_transport_jet.md).
Write $G_0$ for its supersingular closed fiber and $\sigma$ for
Witt Frobenius. All groups and isomorphisms below are ACTUAL.

## The obstruction at every truncation level

Let $\Gamma_N$ be the group of determinant-one automorphisms of
$G_0[5^N]$ inducing the identity on both Hodge graded lines.
Let $\Gamma_N^{\mathrm{lift}}$ be the image of determinant-one
automorphisms of the FULL $G_0$ with that normalization.
It is also the image of $\Gamma_{N+1}\to\Gamma_N$.

Every $U\in\Gamma_N$ has a factorization
\[
U=(I+5^{N-1}[z]E_{21})g,
\qquad g\in\Gamma_N^{\mathrm{lift}},\quad z\in k.
\tag{1}
\]
The class of $z$ modulo $\mathbf F_{25}$ is well-defined. It gives
an exact sequence of ABSTRACT groups of geometric points
\[
1\longrightarrow\Gamma_N^{\mathrm{lift}}
\longrightarrow\Gamma_N
\xrightarrow{\;U\mapsto2(z^{1/5}-z^5)\;}(k,+)
\longrightarrow0.
\tag{2}
\]
Here $|\Gamma_N^{\mathrm{lift}}|=5^{3N-1}$. Formula (2) uses an
inverse Frobenius on $k$; it is not asserted to be an untwisted
morphism of algebraic group schemes.

For every $\varphi\in\mathscr A_N$, restrict its unique actual
comparison to the closed fiber and use (1). Then
\[
a_N(\varphi)=2(z^{1/5}-z^5).
\tag{3}
\]
Consequently the polar coefficient vanishes if and only if that
SUPPLIED closed-fiber marking lifts one truncation level, equivalently
to the full supersingular group. This is weaker than lifting the
comparison over the entire formal disc. Formula (3) is valid for
every $N\ge1$; it does not supply a general coordinate-jet bound.

## Arbitrary local references and proper-curve detection

Let $H_N$ be everywhere versal, height two and dimension one, on a
smooth proper curve $C/k$. Suppose its supersingular divisor $S$
is reduced and nonempty. Let $A,B$ be normalized marked
BT$_{N+1}$ extensions of the SAME $H_N$.
At each $x\in S$, the following conditions are equivalent:

1. The principal part of $\Delta_N(A,B)$ at $x$ vanishes.
2. The specified level-$N$ marking at $x$ lifts to a
   determinant-preserving isomorphism $A_x\simeq B_x$.

In particular
\[
A\simeq B\text{ as normalized marked groups on }C
\quad\Longleftrightarrow\quad
\text{condition2 holds at EVERY }x\in S.
\tag{4}
\]
The global isomorphism in (4) is unique. The choices of closed-fiber
isomorphisms need not be unique and are not asserted to extend
individually. What is detected is existence with the given
level-$N$ marking and determinant.

For an ACTUAL common span $X\xleftarrow fZ\xrightarrow gY$ with
specified compatible $H_N$, and supplied endpoint next extensions
$A_X,B_Y$, the required normalized marked comparison on the SAME
$Z$ therefore exists exactly when its marking lifts at every
supersingular point of $Z$. This gives a finite closed-fiber test
for a supplied pair of next extensions. It neither constructs an
endpoint extension nor forces those fiber tests to hold.

[Proof](../../Proofs/deformations/versal_bt_fiber_obstruction.md).
