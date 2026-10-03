# Cartier kernels classify every nonempty next-level BT extension space

Version2,3 October2026. Let $C/k$ be smooth proper connected,
$k=\overline{\mathbf F}_5$, $g(C)\ge2$. Let $H/C$ be an actual
everywhere-versal height-two, dimension-one BT1, generically ordinary
with reduced supersingular divisor $S$. Retain its finite determinant
character. On the ordinary open, write the constituent characters as $\chi$ and
$\delta\chi^{-1}$. Let $\pi:P\to C$ be the smooth normalization of
the connected cover killing $\chi^2\delta^{-1}$, of degree two or four.
Its logarithmic differential $\Omega=d\log q_H$ is regular and
Cartier-fixed, with $\operatorname{div}_P\Omega=2R$, where $R$ is
the reduced ramification divisor. All inertia indices along $S$ are
two. The induced connection is an active admissible projective oper,
with square Hasse divisor $2S$. Put
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
If the induced connection is indigenous-ordinary, every nonempty
extension space above is a singleton. For either selected genus-two
endpoint, all actual $H$ have this property: in the quintic family
it holds when the parameter degree exceeds six or $a^3+a+1=0$.
This reuses the entire geometric active-connection classification,
including every determinant/root class.

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
