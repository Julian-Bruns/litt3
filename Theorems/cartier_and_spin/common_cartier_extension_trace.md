# The canonical Cartier extension is the sole common trace obstruction

Version4,3 October2026. Work over $k=\overline{\mathbf F}_p$,
$p$ odd. Let $X\xleftarrow f Z\xrightarrow gY$ be an ACTUAL
coreless finite etale span of smooth projective connected hyperbolic
curves, with no clump and $p\nmid g(Y)-1$. All bundles, maps,
extensions and traces retain their specified common identifications
on the same source and all relative Frobenius twists.

On a fixed target twist put
$A_s=F_*^{[s]}\mathcal O$, $B_s=A_s/\mathcal O$,
using the inverse relative twists as sources, and set $B_0=0$.

## One universal ample-coefficient criterion

For every common AMPLE rank-$d$ bundle $E$, put
$h=\lfloor\log_p(d+1)\rfloor$. The canonical boundary is an isomorphism
\[
\boxed{\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\simeq\operatorname{Hom}_{\rm common}(E,B_h).}
\tag{1}
\]
Every nonzero class is the pullback of
$0\to\mathcal O\to A_j\to B_j\to0$
along an ACTUAL common surjection $E\twoheadrightarrow B_j$,
for some $1\le j\le h$. Hence $h$ Frobenius pullbacks kill every
class, independently of the covering degrees. For common-simple
ample $E$, the extension group is nonzero precisely for an actual
common isomorphism $E\simeq B_1$, and is then the canonical line.

Writing $m_{B_1}(E)$ for the common Jordan--Holder multiplicity,
\[
\dim\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\le m_{B_1}(E)\le\lfloor d/(p-1)\rfloor.
\tag{2}
\]
This is exactly the cokernel dimension of the ACTUAL joint trace
on $E\omega$. The rank bound is sharp for every $d$, attained by
$B_1^{\oplus\lfloor d/(p-1)\rfloor}$ together with canonical-line
summands for the remaining rank. If $(p-1)\mid d$, equality holds
precisely for $E\simeq B_1^{\oplus d/(p-1)}$ as a common bundle.

Put $t=\deg E_Y/(g(Y)-1)=\deg E_X/(g(X)-1)$. The joint trace has
target dimension $(g(X)+g(Y)-2)(t+d)$, so its rank is at least
\[
(g(X)+g(Y)-2)(t+d)-\lfloor d/(p-1)\rfloor.
\tag{3}
\]
For genera nine and two in characteristic five, this is the
previous $9(\deg E_Y+d)-\lfloor d/4\rfloor$.

## Canonical Cartier bundles give exactly one hyperplane

On the $r$th twists of the original span, for EVERY $r\ge1$,
the boundary specializes to
\[
k=\operatorname{End}_{\rm common}(B_r)
\xrightarrow{\sim}\operatorname{Ext}^1_{\rm common}(B_r,\mathcal O).
\tag{4}
\]
It sends $1$ to the ACTUAL nonsplit unit sequence
$0\to\mathcal O\to A_r\to B_r\to0$, of class $e_{r,C}$.
The endpoint pullbacks on $H^1(B_r^\vee)$ are injective, and
\[
f^{(r)*}H^1(X^{(r)},B_{r,X}^\vee)
\cap g^{(r)*}H^1(Y^{(r)},B_{r,Y}^\vee)
=k\,e_{r,Z}.
\tag{5}
\]
No covering degree is inverted.

Let $\lambda_{r,C}$ be Serre pairing with $e_{r,C}$.
Both endpoint functionals are nonzero. The joint trace has image
\[
\begin{split}
\operatorname{im}(\operatorname{Tr}_f,\operatorname{Tr}_g)
&=\{(s_X,s_Y):\lambda_{r,X}(s_X)=\lambda_{r,Y}(s_Y)\},\\
H^0(Z^{(r)},B_{r,Z}\omega_Z)&\longrightarrow
H^0(X^{(r)},B_{r,X}\omega_X)\oplus
H^0(Y^{(r)},B_{r,Y}\omega_Y).
\end{split}
\tag{6}
\]
Its cokernel has dimension one and its rank is
$2(p^r-1)(g(X)+g(Y)-2)-1$.
The fixed genera nine and two give $18(5^r-1)-1$.

## Vanishing corollaries and the retained small-rank classification

Every common strongly semistable coefficient $E$ with
$\deg E_Y>0$, of ANY rank, has
$\operatorname{Ext}^1_{\rm common}(E,\mathcal O)=0$.
Its joint trace on $E\omega$ is surjective. The later quotient
rigidity and common strong HN filtration force splitting after
Frobenius; the all-slope no-clump theorem supplies injectivity and
hence the original split. No refined-span hypothesis is needed.

For every $m\ge2$, every actual common quotient $E$ of
$B_1^{\otimes m}$ also has zero common extension group and surjective
joint trace. This includes symmetric powers, exterior powers in their
nonzero ranks and Schur constructions presented as such quotients.

Specialize to $p=5$, $g(Y)=2$, and assume additionally no common
regular projective connection. For every positive semistable common
coefficient $E$ of rank at most four,
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)=
\begin{cases}
k\,e_1,&E\simeq B_1\text{ as an ACTUAL common bundle},\\
0,&\text{otherwise}.
\end{cases}
\tag{7}
\]
This old small-rank classification is a corollary of (1) and the
established rank-four Frobenius classification. Its characteristic
and genus restrictions are retained; they are unnecessary for the
general ample and strongly semistable assertions above.

These results concern already supplied common coefficients and both
original trace maps. They construct no common coefficient from the
three exact forms on $X$ and exclude no original common-cover candidate.
[Proof](../../Proofs/cartier_and_spin/common_cartier_extension_trace.md).
