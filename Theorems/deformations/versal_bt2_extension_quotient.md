# The BT2 Ext quotient is the coherent Cartier kernel

Version3,3 October2026. Let $C/\overline{\mathbf F}_5$ be smooth,
projective and connected, $g(C)\ge2$. Let $H/C$ be an actual
everywhere-versal height-two, dimension-one BT1, generically ordinary,
with reduced supersingular divisor $S$. ASSUME a global marked BT2
extension exists. Normalize determinants to the Teichmuller lift of
the possibly nontrivial determinant character of $H$, retaining the
entire BT1 marking.

Put
\[
E_C=\operatorname{Ext}^1_{\mathbf F_5,C_{\rm fppf}}(H,H),\qquad
Q_C=E_C/jH^1_{\rm et}(C,\mathbf F_5).
\]
Here $j$ tensors a constant-sheaf self-extension with $H$.
Let $\mathscr E_C$ be the etale sheafification of the corresponding
local Ext presheaf, and let $\mathcal B_H$ be the absolute
Frobenius Cartier kernel from
[the affine-torsor theorem](versal_bt_extension_torsor.md).

Then $j$ is injective and there are canonical additive identifications
\[
\mathscr E_C\simeq\mathcal B_H,\qquad
Q_C\simeq H^0(C_{\rm et},\mathscr E_C)
\simeq H^0(C,\mathcal B_H)=K_H.
\tag{1}
\]
The scalar convention on $\mathcal B_H$ uses ABSOLUTE Frobenius.
No natural untwisted $k$-action on the Ext presheaf is asserted.
After choosing a reference, normalized marked BT2 classes form
the torsor under (1).

Writing $\pi:P\to C$ for the logarithmic character cover and
$\Omega$ for its Cartier-fixed differential,
\[
K_H=\{h\in H^0(C,\mathcal O_C(S)):
C_P(\pi^*h\,\Omega)=0\}.
\tag{2}
\]
The identification is the actual difference
\[
\Delta_C([B]-[A])=c^5-c,\qquad
c=\frac{d\log r}{d\log q_A},\qquad q_B=q_A r^5.
\tag{3}
\]
There is no punctual kernel or missing part of the image.
Every nonzero difference has an actual simple pole at $S$.
The quotient has dimension the indigenous defect, with the
Frobenius scalar convention in (1); it is zero when the induced
connection is indigenous-ordinary.

For actual finite etale maps $X\xleftarrow fZ\xrightarrow gY$
with specified compatible versal BT1 groups, ASSUME separate
normalized endpoint BT2 extensions exist. Their difference has
a choice-independent exact obstruction
\[
o_{f,g}\in K_{H_Z}/(f^*K_{H_X}+g^*K_{H_Y}).
\tag{4}
\]
Compatible endpoint choices exist on the ORIGINAL $Z$ if and only
if (4) is zero. Every denominator vector is an ACTUAL permitted
endpoint correction. Neither a reference nor compatibility is
produced by writing this quotient.

The Baer-extension construction remains the initial input.
Later exact Cartier realization identifies its entire quotient
and sheaf, replacing the former partial-image discussion.
[Proof](../../Proofs/deformations/versal_bt2_extension_quotient.md).
