# The actual BT2 obstruction equals twice the higher-Hodge class

Version1,21 September2026. Let $H/C$ be an actual everywhere-versal
height-two, dimension-one BT1 on a smooth projective hyperbolic curve
over $k=\overline{\mathbf F}_5$. Retain its finite determinant character,
all markings, its canonical first $W_2$ curve lift, and COMPATIBLE FIRST
PERIODIC FILTERED DATA realizing its actual Frobenius and Verschiebung.
These predecessor data are supplied, not inferred from numerical ranks.

Let $e(H)\in H^1(C,\mathcal B_H)$ be the actual normalized extension
torsor class from [the absolute torsor](versal_bt_extension_torsor.md).
Let $\epsilon(C,r)\in\operatorname{coker}\Psi_r$ be the
[higher-Hodge obstruction](../../Definitions/witt_hodge_obstruction.md)
for the specified predecessor. Write $\mathcal N_r$ for the actual
nilpotent tangent bundle, and $\mathscr D_H$ for
[the logarithmic Hessian](bt_cartier_tangent_identification.md).

The coordinate-invariant third-order operator is
\[
\mathfrak b_r(f\partial_u)
 =\left(2rf'+r'f-\tfrac12 f'''\right)(du)^2.
\]
With absolute Frobenius and its scalar action retained, there is an exact
sequence
\[
0\longrightarrow T_C\xrightarrow{\mu}F_{{\rm abs}*}T_C
 \xrightarrow{\mathfrak b_r}\mathcal N_r\longrightarrow0,
\qquad \mu(f\partial_u)=s_u f^5\partial_u,
\]
where $s=s_u(du)^4$ is the normalized Hasse quartic. Its cohomology gives
$\overline{\mathfrak b}_{r*}:\operatorname{coker}\Psi_r
\simeq H^1(C,\mathcal N_r)$, and the ACTUAL classes satisfy
\[
\mathscr D_{H*}e(H)=2\overline{\mathfrak b}_{r*}\epsilon(C,r).
\tag{1}
\]
The Cech convention is reference $j$ minus reference $i$.
For the summed-Wronskian pairing $W(v,w)=vw'-v'w$, the resulting
Serre-duality identification $J$ satisfies $J(e(H))=2\epsilon(C,r)$.
Changing the scale of that pairing changes the scale of $J$; (1) does not.

In particular, an ACTUAL normalized marked BT2 exists on the ORIGINAL
curve exactly when $\epsilon(C,r)=0$. The equivalence includes effective
local groups, their actual overlap isomorphisms, and finite-flat descent.
There is no index shift: a $W_3$ curve is used to compute a divided
Frobenius/Taylor construction modulo25, hence a BT2.

The comparison is etale-functorial with the specified predecessor data.
It compares existence classes; it does not identify two arbitrary chosen
upper objects or prove prescribed two-leg descent. No common oper on a
bare span and no general higher-level vanishing are asserted.

[Proof](../../Proofs/deformations/bt_hodge_obstruction_comparison.md).
