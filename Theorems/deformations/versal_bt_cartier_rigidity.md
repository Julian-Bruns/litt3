# Ordinary indigenous connections force normalized BT rigidity

Version2,20 September2026. Let $C/k$ be smooth projective connected,
$k=\overline{\mathbf F}_5$, $g(C)\ge2$. Let $H/C$ be an actual
everywhere-versal height-two, dimension-one BT1, generically ordinary
with reduced supersingular divisor $S$. Assume a marked BT2 reference
exists. Retain its possibly nontrivial order-dividing-four determinant
character and normalize level-two determinants to its Teichmuller lift.

On $C-S$, choose ordinary constituent bases and write
$\Omega=d\log q_H$. Its finite character has order two or four.
Let $\pi:P\to C$ be the smooth projective normalization of the cover
trivializing that character, and denote the resulting differential
on $P$ again by $\Omega$. It is regular, Cartier-fixed and satisfies
$\operatorname{div}_P\Omega=2R$, where $R$ is the reduced ramification
divisor. All ramification indices at $S$ are two.

For the actual extension quotient $Q_C$, the intrinsic difference
function defines an injective additive map
\[
Q_C\hookrightarrow\mathcal K_H
:=\{r\in H^0(C,\mathcal O_C(S)):C_P(\pi^*r\,\Omega)=0\},
\qquad [B]-[A]\longmapsto\Delta(A,B).
\tag{1}
\]
Multiplication by $\Omega$ identifies the ambient space with the
corresponding character block of $H^0(P,\omega_P)$. Its Cartier
kernel has dimension equal to the fixed-curve nilpotent tangent
space of the indigenous connection induced by $H$.

Consequently, if that indigenous connection is ordinary, $Q_C=0$:
there is exactly one normalized marked BT2 extension, up to the
specified isomorphism. Existence here is an explicit hypothesis.
The same uniqueness holds for BT$_{N+1}$ extensions of any fixed
BT$_N$ with this BT1 and with the prescribed normalized determinant.
It does not assert existence of the next level or a full tower.

For $C:y^2=x(x-1)(x-2)(x-3)(x-a)$, the conclusion holds for EVERY
such actual $H$ when either $[\mathbf F_5(a):\mathbf F_5]>6$ or
$a^3+a+1=0$. The established classification makes all85 active
indigenous connections ordinary in these cases, including every
determinant/root class. Thus it covers both candidate genus-two
endpoints, with all geometric field extensions allowed.

For an actual common BT1 on $X\xleftarrow fZ\xrightarrow gY$,
(1) holds on all three curves and commutes with the actual etale
maps. A difference between chosen endpoint extensions injects into
\[
\mathcal K_{H_Z}/\bigl(f^*\Delta(Q_X)+g^*\Delta(Q_Y)\bigr).
\tag{2}
\]
Its vanishing is equivalent to compatible endpoint choices. The
genus-two conclusion makes $Q_Y=0$, but the pulled-back indigenous
connection on $Z$ need not be ordinary. Neither (1) nor (2) supplies
compatibility on $Z$ or constructs a common BT1 from a bare span.
The subsequent [realization theorem](versal_bt_cartier_realization.md)
proves surjectivity in (1), and the analogous classification at every
nonempty next-level fiber. It does not remove the source compatibility
class or the existence hypothesis.

[Proof](../../Proofs/deformations/versal_bt_cartier_rigidity.md).
