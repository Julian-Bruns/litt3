# Proof: from an extension quotient to two local obstructions

[Statement](../../Theorems/deformations/versal_bt2_extension_quotient.md).
The extension-torsor reduction is the returned Pro argument. The
etale local-to-global calculation, ordinary comparison invariant and
two-endpoint quotient below are local continuations.

## The actual truncation fiber

An abelian fppf extension $0\to H\to A\to H\to0$ is representable
and finite locally free: its middle sheaf is an $H$-torsor over the
finite locally free scheme $H$, and finite flat affine descent applies.
Multiplication by five factors uniquely as $i m\pi$, with
$m\in\operatorname{End}(H)$. The map taking an extension class to
$m$ is additive. Its kernel consists exactly of extensions killed
by five, namely extensions in $\mathbf F_5$-module sheaves.

Fix the class of one marked BT2 group, for which $m=1$. The fiber
over $1$ is a torsor under $E_C$. Conversely $m=1$ makes kernel
and image of multiplication by five both equal to $H$. This is the
flatness condition over $\mathbf Z/25$ for a level-two BT group;
see [Illusie, Definition1.1](https://www.imo.universite-paris-saclay.fr/~luc.illusie/Illusie-Chicago-2023-1.pdf).
The given BT1 is retained. A map preserving its inclusion preserves
the quotient map too, since $[5]=i\pi$ is intrinsic.

A scalar twist with transition $1+5c_{ij}$ changes the extension by
the class $j(c_{ij})$: the added gluing is the upper triangular
matrix with off-diagonal entry $c_{ij}$. Determinant normalization
removes exactly these scalar orbits. Two normalized groups related
by such a twist have twist square one; the twist has exponent five,
so it is trivial. A change of normalized determinant identification
is corrected by a unique marked scalar square root. This proves the
returned identification with $Q_C$.

## The etale local-to-global exact sequence

On every connected etale $V\to C$, an endomorphism of $H_V$ is
determined generically, where the
[generic scalar theorem](versal_bt_display_descent.md) gives
$\operatorname{End}(H)=\mathbf F_5$. Thus the etale sheaf of fppf
endomorphisms is the constant sheaf $\mathbf F_5$.

Apply the local-to-global spectral sequence for fppf derived Hom,
viewed on the etale site. Its degree-one exact sequence is
\[
0\to H^1_{\rm et}(C,\mathbf F_5)\xrightarrow{j}E_C
\to H^0(C,\mathscr E_C)\to H^2_{\rm et}(C,\mathbf F_5).
\]
The last group vanishes. Indeed the Artin--Schreier sequence identifies
it with the cokernel of $F-1$ on $H^1(C,\mathcal O_C)$, since
$H^2(C,\mathcal O_C)=0$. On this finite-dimensional vector group,
$F-1$ is an additive etale morphism with differential $-1$; its
image is an open subgroup, hence the entire connected vector group.
This proves (1), including injectivity of $j$.

## The ordinary Kummer calculation

Work etale-locally on $U$, trivializing the multiplicative and etale
constituents of both level-two groups, with bases agreeing modulo
five via their markings. We may further localize so the relevant
Kummer torsor line bundles are trivial. A height-two ordinary BT2
extension with these constituents is described by a unit $q$ modulo
twenty-fifth powers. This follows by taking the torsor over the
section $1\in\mathbf Z/25$; the exponent condition supplies its
Kummer group law. The finite-level construction is also reviewed in
[Howe, Section3.2](https://www.math.utah.edu/~howe/papers/unipotent-circle-action.pdf).
No globally defined Serre--Tate coordinate is asserted.

Matching the BT1 markings makes the two parameters equal modulo fifth
powers, so representatives can be chosen with $q_B=q_A r^5$.
Versality says $d\log q_A$ generates the relative differentials in
these ordinary constituent frames. Hence $c=(d\log r)/(d\log q_A)$
is regular. Changing Kummer representatives by twenty-fifth powers
changes $r$ by a fifth power and leaves $c$ unchanged.

A change of constituent lifts congruent to the identity modulo five
changes $r$ by $q_A^a$ modulo fifth powers, for $a\in\mathbf F_5$.
It changes $c$ by $a$. Changing the common level-one constituent
bases scales both logarithmic differentials by the same nonzero
element of $\mathbf F_5$, and may add the same type of scalar shift.
Thus $c^5-c$ descends to $U$. Determinant-preserving changes still
permit every shift: take the two diagonal exponents to be opposite;
their difference is arbitrary because two is invertible.

For three objects choose compatible local constituent frames.
The ratios $r$ multiply, while $d\log q_A=d\log q_B$; hence their
$c$'s add. This proves the cocycle identity and additivity of $\Delta$.
Scalar twists are locally trivial and contribute zero. Etale pullback
preserves all the formulas, proving functoriality.

If $\Delta=0$, then locally $c\in\mathbf F_5$ and
$d\log(rq_A^{-c})=0$. On a smooth ring over the perfect field $k$,
the kernel of $d$ is its subring of fifth powers. Thus
$r=q_A^c s^5$ locally. A determinant-preserving change of constituent
lifts removes $q_A^c$, and the remaining twenty-fifth power changes
no extension. We obtain normalized marked local comparisons; they
glue by generic scalar uniqueness. The converse is immediate from
the formula. This proves the assertion about the kernel on $U$.

Suppose $\Delta$ extends to $C$. It is a constant $a\in k$.
Every local $c$ then solves $c^5-c=a$, whose five roots are constants
in the algebraically closed field. So $c$ is locally constant.
But $d\log r=c\,d\log q_A$ and Cartier fixes both logarithmic
differentials. Its inverse-Frobenius semilinearity gives
$c^{1/5}=c$. Consequently $c\in\mathbf F_5$ and $a=0$.
This proves the pole statement. The subsequent
[valuative comparison theorem](versal_bt_valuative_comparison.md)
extends the resulting comparison across $S$.

## The original two endpoint choices

The classification is functorial under etale pullback. Fix normalized
reference extensions on $X$ and $Y$, and write $\xi$ for their
difference after the ACTUAL specified BT1 comparison on $Z$.
Changing the references by $a\in Q_X$, $b\in Q_Y$ changes $\xi$
by $g^*b-f^*a$. Every such change is realized by an actual endpoint
extension, followed by its permitted normalization. Thus the coset
of $\xi$ in (4) is independent of reference choices and is zero
exactly when compatible choices exist. Functoriality of $\Delta$
gives the claimed rational-function obstruction. No vanishing of
that obstruction group is used. The later valuative theorem removes
the punctual kernel, and the sharp pole/Cartier theorem restricts
the image; neither changes this quotient by the two actual endpoints.
