# Cartier kernels classify every nonempty next-level BT extension space

Version1,20 September2026. Let $C/k$ be smooth proper connected,
$k=\overline{\mathbf F}_5$, $g(C)\ge2$. Let $H/C$ be an actual
everywhere-versal height-two, dimension-one BT1, generically ordinary
with reduced supersingular divisor $S$. Retain its finite determinant
character. Let $\pi:P\to C$ and $\Omega$ be its tame logarithmic
character cover and Cartier-fixed form, as in
[Cartier rigidity](versal_bt_cartier_rigidity.md). Put
\[
K_H=\{h\in H^0(C,\mathcal O_C(S)):
 C_P(\pi^*h\,\Omega)=0\}.
\tag{1}
\]
Fix a marked BT$_N$ group $H_N$, $N\ge1$, with first level $H$
and determinant the Teichmuller lift of its level-one character.
ASSUME one normalized marked BT$_{N+1}$ extension $A$ exists.
Then its next-level extension classes are in natural additive bijection
with $K_H$, with $A$ as origin:
\[
[B]\longmapsto\Delta_N(A,B),\qquad
\Delta_N(A,B)=c^5-c,\quad
c=\frac{d\log r}{d\log q_A},\quad q_B=q_A r^{5^N}.
\tag{2}
\]
This is a classification of actual finite flat groups with the given
BT$_N$ marking and normalized determinant. The additive space is
independent of $N$. Its dimension is the indigenous defect of $H$.
No assertion about a representing moduli scheme, existence of a
reference, or automatic prolongation of every lower level is included.

There is an exact local statement. After choosing a universal
supersingular parameter $t$ for the local reference over $k[[t]]$,
an invariant $h\in k((t))$ is realized by an integral marked next
extension if and only if
\[
h\in t^{-1}k[[t]],\qquad C(h\Omega)=0.
\tag{3}
\]
It is realized by a FULL effective companion window with Frobenius
matrix
\[
F_j=\begin{pmatrix}t+5^N\widetilde j&5\\1&0\end{pmatrix},
\qquad j\in k[[t]].
\tag{4}
\]
Here full effectivity is local; the global construction patches only
the requested finite truncation. The actual last connection digit
gives the SAME comparison map at every height:
\[
b+t^6b^5=-1,\quad
e_j+t^6e_j^5=-j'-2t^5j b^5,\quad
T(j)=(e_j/b)^5-e_j/b+2j/t.
\tag{5}
\]

The classification commutes with the actual etale pullbacks. Therefore
if compatible BT$_N$ groups are given on an actual span
$X\xleftarrow fZ\xrightarrow gY$, and each endpoint has a next
extension, the exact choice obstruction is
\[
o_N\in K_{H_Z}/(f^*K_{H_X}+g^*K_{H_Y}).
\tag{6}
\]
Every element of each endpoint kernel really can be used as a
correction. For a coreless span the two subspaces in the denominator
intersect trivially. Equation(6) still need not vanish.

The level-two realization is the returned Pro result; extension to
all last digits and (6) are the local continuation.
[Proof](../../Proofs/deformations/versal_bt_cartier_realization.md).
