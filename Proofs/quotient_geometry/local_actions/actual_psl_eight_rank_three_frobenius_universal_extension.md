# Proof of the universal equivariant third Frobenius flag

Version1, 3 October2026. The
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_rank_three_frobenius_universal_extension.md)
retains the complete hypotheses of the
[actual natural-root flag theorem](actual_psl_eight_root_frobenius_flags_and_wild_constraints.md).
The new cohomology and extension argument has independent
[review PASS](../../../Research/notes/oct03_ten_hour/eight_module_actual_rank_three_universal_extension_audit.md),
which pins the unchanged source
[note](../../../Research/notes/oct03_ten_hour/eight_module_actual_rank_three_universal_extension.md).
The derived coarse pushforward argument below retains the audit's
explicit wild-cohomology justification.
No computation is used.

## The third flag is a genuine extension

The accepted first flag is an everywhere subbundle
\[
R_2=\mathcal O\oplus\omega^{-1}\subset E.
\]
It is therefore a subbundle of \(R_3\). Its rank-one quotient is
torsion-free on the actual smooth atlas, hence a line.
The accepted genuine determinant \(\det R_3=\omega^{-5}\) gives
\[
0\longrightarrow\mathcal O\oplus\omega^{-1}
 \longrightarrow R_3\longrightarrow\omega^{-4}\longrightarrow0.
\tag{1}
\]
All these are genuine comparisons on \(\mathcal S\).

## Coarse canonical lattices and the wild higher pushforward

At the actual wild point the different exponent is eight.
For the invariant rational canonical frame \(du\), regularity
of \(h(u)(du)^m\) is
\(v_u(h)\ge-\lfloor8m/5\rfloor\).
At the tame point the corresponding bound is
\(-\lfloor m/2\rfloor\).
It follows directly that
\[
\pi_*\omega^m=
\mathcal O_{\mathbf P^1}
(-2m+\lfloor8m/5\rfloor+\lfloor m/2\rfloor).
\tag{2}
\]
For \(m=3,4\) these are \(\mathcal O(-1)\) and \(\mathcal O\);
their first cohomology vanishes.

For clarity, \(\pi_*\) is not declared exact at the wild point.
Over a small affine coarse chart the quotient is a finite-group
quotient of an affine atlas. Its coherent derived invariants are
computed by finite-group cochains. After completion, the atlas
over a branch value is the product indexed by actual point cosets;
Shapiro reduces those cochains to the inertia group at one point.
The finite difference/norm matrices commute with flat completion.
Higher local invariants vanish away from the wild point, because
ordinary inertia is trivial and the tame order two is invertible.
Thus \(R^1\pi_*\omega^m\) is supported at the one coarse wild point,
with completed stalk the actual cyclic \(H^1\) calculated below.
The low-degree Leray sequence, using \(H^2(\mathbf P^1,-)=0\),
identifies \(H^1(\mathcal S,\omega^m)\) with that stalk for \(m=3,4\).
No vanishing of higher wild \(R^j\pi_*\) is assumed.

## Explicit cyclic local cohomology

Choose the actual weak local normalization
\[
g(t)=t/(1+t),\qquad y=t^{-1},\qquad
u=(y^5-y)^{-1}=t^5/(1-t^4).
\]
Then \(g(y)=y+1\), and \(v_t(du)=8\).
In the invariant rational frame \((du)^m\), the coefficient module
is \(t^{-8m}k[[t]]\).
Multiplication by an invariant power of \(u\) identifies it
equivariantly with \(I_1=t k[[t]]\) for \(m=3\), and
with \(I_3=t^3k[[t]]\) for \(m=4\).
Write \(A=k[[u]]\), \(\Delta=g-1\) and
\(\mathrm N=1+g+\cdots+g^4=\Delta^4\). The first cyclic cohomology is
\(\ker\mathrm N/\Delta I\).

For \(I_1\), an exact \(A\)-basis is
\(u,uy,uy^2,uy^3,uy^4\).
Their valuations are the five required classes.
Translation has successive unit coefficients \(1,2,3,4\);
the norm sends \(uy^4\) to \(-u\).
Hence its norm kernel equals the difference image, giving zero \(H^1\).

For \(I_3\), an exact \(A\)-basis is
\[
e_0=u,\quad e_1=uy,\quad e_2=uy^2,\quad
e_3=u^2y^3,\quad e_4=u^2y^4.
\]
Their valuations \(5,4,3,7,6\) are distinct modulo five and supply
the complete integral lattice.
The difference map is
\[
\Delta e_0=0,\quad \Delta e_1=e_0,\quad
\Delta e_2=2e_1+e_0,
\]
\[
\Delta e_3=3u e_2+3u e_1+u e_0,\qquad
\Delta e_4=4e_3+u e_2+4u e_1+u e_0.
\]
Only \(e_4\) has nonzero norm, namely \(-u e_0\).
Consequently
\[
\ker\mathrm N=Ae_0+Ae_1+Ae_2+Ae_3,\qquad
\Delta I_3=Ae_0+Ae_1+A(u e_2)+Ae_3.
\]
Thus its first cohomology is \(A/(u)=k\).
Together with (2) and Leray this proves
\[
H^1(\mathcal S,\omega^3)=0,\qquad H^1(\mathcal S,\omega^4)=k.
\tag{3}
\]

## One universal nonsplit extension

The class of (1) lies in
\[
\operatorname{Ext}^1(\omega^{-4},
                 \mathcal O\oplus\omega^{-1})
=H^1(\omega^4)\oplus H^1(\omega^3)=k\oplus0.
\]
Hence it splits off the prescribed \(\omega^{-1}\)-kernel and gives
\[
R_3=\omega^{-1}\oplus K,\qquad
0\longrightarrow\mathcal O\longrightarrow K
 \longrightarrow\omega^{-4}\longrightarrow0.
\]

If the remaining class were zero, the third Frobenius column
\(\omega^{-6}\to R_3\) would have components in
\(H^0(\omega^6),H^0(\omega^5),H^0(\omega^2)\).
Formula (2) gives coarse degree zero for each.
A nonzero section has exact wild orders THREE, ZERO and ONE,
respectively, by \(8m-5\lfloor8m/5\rfloor\).
Thus its first and third components vanish at every wild point.
The third column's value would be a multiple of the second column.
But the retained nonrational two-socle ratio makes
\(\sigma^{[25]}(0)\) and \(\sigma^{[5]}(0)\) independent.
This contradiction proves that \(K\)'s genuine extension class
is NONZERO.
Since the extension space is one-dimensional, all nonzero classes
have the same middle bundle up to endpoint rescaling.

The splitting off is unique. Applying the two Hom functors to the
extension for \(K\) gives
\[
\operatorname{Hom}(\omega^{-1},K)=0,\qquad
\operatorname{Hom}(K,\omega^{-1})=0,
\]
using \(H^0(\omega)=H^0(\omega^{-3})=0\) and
\(H^0(\omega^{-1})=H^0(\omega^3)=0\), respectively.
These vanishings follow from (2) and negative actual degree.

## Forgetting equivariance and shifting the first flag

On the ACTUAL curve \(D\), \(H^1(D,\omega_D^4)=0\) by Serre duality.
Its positive canonical degree gives \(g(D)>1\).
Thus the ordinary bundle \(K|_D\) splits and
\[
R_3|_D=\mathcal O_D\oplus\omega_D^{-1}\oplus\omega_D^{-4}.
\]
This does not split the genuine equivariant extension.

Frobenius pull of the everywhere first flag, followed by the retained
comparison \(F_{\rm abs}^*E=E\omega\) and twist by \(\omega^{-1}\),
gives the genuine subbundle
\(\omega^{-1}\oplus\omega^{-6}\subset E\) with columns
\(\sigma^{[5]},\sigma^{[25]}\). Checking on the smooth actual atlas
shows it is an everywhere subbundle; no coarse invariant exactness
is used. It lies in \(R_3\) and its rank-one quotient is
\(\omega^2\) by determinants.
The original \(\sigma\)-column maps to this quotient with zero
divisor exactly \(D_5\), since this quotient coefficient measures
the already proved three-minor determinant divisor.
This establishes the second exact sequence and its canonical section.

Everything identifies a conditional actual subbundle.
Neither full curve existence nor an original source, Cartier
comparison, normalized-row identity or endpoint descent is inferred.
Both original finite étale maps stay on their SAME \(T\).
