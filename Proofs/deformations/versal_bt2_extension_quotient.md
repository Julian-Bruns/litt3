# Proof: the Baer quotient and the entire Cartier sheaf

[Statement](../../Theorems/deformations/versal_bt2_extension_quotient.md).
Version3,3 October2026. The returned Baer-extension construction and
local-to-global sequence are retained. The later exact Cartier torsor
identifies their sheaf directly and removes the duplicate Kummer proof.

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

The [generic scalar theorem](versal_bt_display_descent.md) and
torsion-free finite Hopf algebras give
$\underline{\operatorname{End}}_{\rm et}(H)=\mathbf F_5$.

Apply the local-to-global spectral sequence for fppf derived Hom,
viewed on the etale site. Its degree-one exact sequence is
\[
0\to H^1_{\rm et}(C,\mathbf F_5)\xrightarrow{j}E_C
\to H^0(C,\mathscr E_C)\to H^2_{\rm et}(C,\mathbf F_5).
\]
The last group is zero: Artin--Schreier identifies it with
$\operatorname{coker}(F-1)$ on $H^1(\mathcal O_C)$, and this additive
map is etale with differential $-1$, hence onto its connected vector
group. This proves the middle identification in (1) and injectivity.

## The local Ext sheaf is exactly the Cartier kernel

The preceding Baer and determinant construction works on every
smooth etale curve over $C$. After etale sheafification, scalar
twists disappear: their classes are locally trivial. Thus
$\mathscr E_C$ is the sheaf of additive differences of normalized
marked next extensions, regardless of the chosen local origin.

The later [actual affine-torsor theorem](versal_bt_extension_torsor.md)
identifies that difference sheaf with the additive vector bundle
$\mathcal B_H$: it proves both local nonemptiness and the ENTIRE
Cartier image on open etale curves, with no residual normalized
automorphism. Its action is precisely the ordinary invariant (3).
Changing a local origin cancels by the difference cocycle, so this
identification is canonical and etale-functorial. Taking global
sections and the exact sequence above gives (1), including the
canonical identification with (2).

This is an additive identification. The scalar action on the
Cartier domain is $a\cdot h=a^5h$, as required by absolute
Frobenius; it is not an extra linear structure on arbitrary Ext
data. The [Cartier classification](versal_bt_cartier_realization.md)
identifies its dimension with indigenous defect.

The [basic Kummer comparison](versal_bt_display_descent.md)
makes a globally regular difference zero. Exact Cartier realization
and the sharp pole bound now say every nonzero class is detected
by a simple pole at $S$; no punctual kernel or unproved image
remains. These conclusions reuse complete later results, rather
than the original provisional ordinary-open criterion.

## The original two endpoint choices

Choose normalized endpoint references and let $\xi\in K_{H_Z}$
be their actual pulled-back difference. Changing them by
$a\in K_{H_X}$ and $b\in K_{H_Y}$ changes $\xi$ by $g^*b-f^*a$.
Exact realization permits EVERY such endpoint correction. Thus
its coset (4) is choice-independent and zero exactly for compatible
choices on the ORIGINAL $Z$. No ambient section is substituted
for an endpoint group, and no quotient vanishing is assumed.
