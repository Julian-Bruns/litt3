# Proof: the Cartier filtration records common zero divisors

[Statement](../../Theorems/cartier_and_spin/common_cartier_subbundles.md).
[Independent bounded review](../../Research/audits/CARTIER_SYMMETRIC_POWER_RECONSTRUCTION_AUDIT_2026_10_03.md).
Version5,3 October2026.
All Frobenius morphisms below are relative, and all inclusions are
the actual compatible ones on the stated span.

## The canonical filtration and its horizontal subbundles

The canonical filtration on $F_C^*F_{C*}\mathcal O_C$ is the
diagonal-ideal filtration; its construction and connection maps
are given in [Sun, Lemma2.1](https://arxiv.org/pdf/math/0611360).
Quotient by the horizontal copy of $\mathcal O_C$. Locally, for
an étale parameter $z$, the resulting bundle $F_C^*B_C$ has basis
$t,t^2,\ldots,t^{p-1}$, where
$t=1\otimes z-z\otimes1$ and $t^p=0$. Its canonical connection
is
\[
\nabla(t) =0,\qquad
\nabla(t^i)=-i t^{i-1}dz\quad(2\le i\le p-1).
\]
The first identity holds in the quotient by constants. The
filtration $V_i$ is spanned by $t^i,\ldots,t^{p-1}$ and has
$V_i/V_{i+1}=\omega_C^i$. Its graded connection maps are
isomorphisms for $i\ge2$. These constructions commute with
étale pullback, including the given two maps.

Put $H=F_C^*U_C$ and intersect it with this filtration. Each
nonzero graded piece is a rank-one subsheaf of $\omega_C^i$.
Horizontality forces the occurring indices to be precisely
$1,\ldots,r$: if index $i>1$ occurs, its injective graded
connection map forces index $i-1$ to occur. On a smooth curve
write its actual image as $\omega_C^i(-D_{i,C})$. The resulting
filtration of $H$ has locally free quotients; these are the
displayed line images, before saturation in $\omega_C^i$.

The induced map to the preceding graded line is the restriction
of an isomorphism. Hence it exists as a regular map exactly with
the divisor inequality $D_{i,C}\ge D_{i-1,C}$, and its zero
divisor is their difference. Intersections, the canonical
filtration, and actual line images commute with the étale maps.
Thus every $D_i$ is an actual common effective divisor pair.
Summing the graded degrees proves the formula for $p\deg U_C$.

## Saturation bounds every local defect

At a closed point with parameter $z$, choose a horizontal local
frame of $H=F_C^*U_C$ and write its columns in the $t$-basis.
If $a_j(z)$ is the coefficient of $t$ in column $j$, horizontality
determines that entire column:
\[
a_j,\quad \frac{a_j'}{2!},\quad
\frac{a_j''}{3!},\quad\ldots,\quad
\frac{a_j^{(p-2)}}{(p-1)!}.
\]
It also gives $a_j^{(p-1)}=0$. Since $U$ is saturated, these
columns are independent modulo $z$. Their jets of orders
$0,\ldots,p-2$ therefore span a rank-$r$ subspace. Constant
row reduction of the frame gives distinct initial orders
$0\le e_1<\cdots<e_r\le p-2$ for the $a_j$.

For the first $i$ rows of this matrix, the least valuation of a
nonzero $i$-minor is
\[
\sum_{j=1}^i e_j-\frac{i(i-1)}2.
\]
The minor using the first $i$ initial orders attains this bound:
its leading coefficient is a nonzero Vandermonde in those
orders, divided by invertible factorials. No cancellation can
raise it, because the orders are distinct and less than $p$.
Every other minor has at least this valuation.

On the other hand this is the determinant defect of the actual
projection $H\to V_1/V_{i+1}$, hence is
$\sum_{j=1}^i\operatorname{ord}_xD_j$. Taking successive
differences gives
\[
\operatorname{ord}_xD_i=e_i-i+1\le p-1-r.
\]
The last inequality follows because $r-i$ further distinct
orders must fit between $e_i$ and $p-2$. This proves the sharp
bound without using the order sequence of any global series.

## Corelessness and the degree equation

A nonzero common effective divisor is supported on a clump.
In a coreless span there is at most one finite physical component;
its coefficients in any common divisor are constant. See
[matched section rings](../shared_tensors/matched_section_rings.md).
Consequently, in the presence of a clump, every $D_i$ is
$\lambda_i S$ with one integer on both endpoints. Without a
clump they are all zero.

In the latter case the degree equation on $Y$ implies
$p\mid r(r+1)(g(Y)-1)$. If $p\nmid g(Y)-1$ and
$1\le r\le p-2$, this is impossible. The full rank $p-1$
is not excluded: the Cartier bundle itself has zero graded
defects, as it must.

Now specialize to $p=5$, $g(Y)=2$, with no singleton clump.
The [clump-size theorem](../shared_tensors/genus_two_clump_connection_reduction.md)
gives $R=4,9,14,\ldots$. Put $s=\sum_i\lambda_i$.
For a proper subbundle $r\in\{1,2,3\}$, the local bound and
the degree equation give
\[
0\le s\le r(4-r)<5,\qquad
s\equiv-r(r+1)\equiv r(4-r)\pmod5.
\]
Consequently $s=r(4-r)$, and EVERY $\lambda_i=4-r$.
All adjacent connection maps are isomorphisms. The degree
table and the rank-$r$ dormant oper description follow.

## The rank-three degree-zero annihilator

The table leaves only $r=3,R=4$ if the proper subbundle has
nonnegative degree. In that case the
perfect alternating pairing $B_C\otimes B_C\to\omega_{C^{(1)}}$
gives a common annihilator line $A_C=U_C^\perp$ and
$\det U_C=\omega_{C^{(1)}}\otimes A_C$. Since the two pullback
degrees are proportional, $\deg U_X=\deg U_Y=0$. Hence
$\deg A_C=-2(g(C)-1)$.

Apply the rank-one part of the filtration to $F_C^*A_C$.
Its projection to $\omega_C$ is nonzero and has common zero
divisor of degree12 on $Y$. Since $R=4$, that divisor is $3S$.
Thus the actual line image is $\omega_C(-3S_C)$.

## Stability and absence of sections on étale covers

Put $h=g(C)$. The rank-$r$ oper's graded degrees, in ascending
index order, are $2i(h-1)-(4-r)\deg S_C$.
For any proper nonzero subbundle $W\subset U_C$, the canonical
connection preserves $F_C^*W$. The same injective graded-map
argument makes its generic indices the first $s=\operatorname{rk}W$
indices of this oper. Actual line images can only decrease degree.
Subtracting $s\mu(F_C^*U_C)$ from the first $s$ graded degrees
gives $s(s-r)(h-1)<0$. Thus $U_C$ is stable. The identical
argument applies after every finite étale pullback. For $r\ge2$
the last graded subline has degree strictly above the mean, so
the first Frobenius pullback is unstable.

The displayed degree table is negative except at $r=3,R=4$,
where it is zero. A stable bundle of negative degree has no
sections; a stable bundle of degree zero and rank greater than
one has no sections either. Applying this on every finite étale
cover proves the asserted vanishing in all three ranks.

The calculation proves restrictions on a subbundle that is already
common. In particular, irreducibility in the clumpless case does
not force a clump: a common irreducible Cartier bundle is entirely
consistent with the remaining unmarked problem.

## A clump constructs the unique possible Cartier line

Now assume either selected pair. There is no shared regular
one-form. By the [invariant Picard theorem](../shared_tensors/saturated_divisor_relations.md),
the group of common line bundles is an extension of $e\mathbf Z$,
where $e=1$ or2, by a finite group of order prime to five.
Frobenius pullback from the twisted span therefore has trivial
kernel on this group. Its image consists exactly of the classes
whose normalized degree is divisible by five. This statement
retains the relative twists; equivalently, after coefficient
Frobenius transport it is multiplication by five on the common
Picard group.

The common line $\omega(-3S)$ has degree $2-3R$ on $Y$.
Since $R\equiv4\pmod5$ and $e$ is prime to five, its normalized
degree is divisible by five. It consequently has the unique
common Frobenius root $A$ in the statement. The canonical
inclusion $F^*A=\omega(-3S)\hookrightarrow\omega$ is a specified
nonzero map. Adjunction and then Cartier give common maps
\[
A\xrightarrow{a}F_*\omega\xrightarrow{C}\omega^{(1)}.
\]
If $Ca$ is nonzero, its zero divisor is a common effective divisor
of degree
\[
2-\frac{2-3R}{5}=\frac{8+3R}{5}
\]
on $Y^{(1)}$. This positive integer must be a multiple of $R$.
Thus $R\mid8$. Among $4,9,14,\ldots$, only $R=4$ is possible;
the divisor is then exactly $S^{(1)}$. In that case
$A\simeq\omega^{(1)}(-S^{(1)})$. Pulling this isomorphism back
by Frobenius and comparing with the definition of $A$ gives
\[
\mathcal O(2S)\simeq\omega^4
\]
as COMMON line bundles, not just numerically or on one endpoint.
This is exactly $\tau^2\simeq\mathcal O$.

When $Ca=0$, the map $a$ factors through $B$. It is saturated:
off $S$ its Frobenius adjoint has a unit coefficient; at a point
of $S$ that scalar has order three. The same horizontal jet
calculation as above gives coefficient orders $(3,2,1,0)$ in
$F^*B$, so one coefficient is a unit. Faithful flatness of
relative Frobenius proves saturation already on $C^{(1)}$.

Any common saturated line in $B$ has adjoint divisor $cS$.
The local jet bound gives $0\le c\le3$, while the degree
equation and $R\equiv4\pmod5$ give $c\equiv3\pmod5$.
Thus $c=3$. Unique common roots and the specified zero
divisor identify the line and map with $A$, up to scalar.
If $Ca\ne0$, no such line can lie in $B$.

## The four-point two-torsion alternative has nonzero Cartier image

Suppose $R=4$, $\tau^2=\mathcal O$ and $Ca=0$.
Take the unique common root $F^*\lambda=\tau$; then
$\lambda^2=\mathcal O$ in the common Picard group.
The canonical reduced-zero section of
$\omega^2F^*\lambda=\mathcal O(S)$ satisfies $C(a^3dz)=0$.
The [intrinsic scalar reconstruction](../projective_connections/dormant_bol_complex.md#canonical-roots-from-scalar-products)
gives an actual normalized dormant Bol bundle $V$ and a
nonzero section of $V\lambda$. On the selected genus-two
endpoint this contradicts the established
[all-two-torsion vanishing](../../Theorems/projective_connections/family_dormant_theta_exclusions.md)
for all five actual normalized Bol bundles.
Hence $Ca\ne0$, completing the line dichotomy.

## Horizontal products construct the middle plane

Assume the common line $A$ exists. The unique common root
$F^*\lambda=\mathcal O(S)\omega^{-2}$ and the reduced
canonical section $a$ of $\omega^2F^*\lambda=\mathcal O(S)$
satisfy $C(a^3dz)=0$ by the first-line condition.
The [intrinsic dormant scalar reconstruction](../projective_connections/dormant_bol_complex.md#canonical-roots-from-scalar-products)
therefore gives an actual common pointed bundle $E$ and
\[
B=A\operatorname{Sym}^3E,\qquad
\det E=\omega^{(1)}\lambda^2.
\]
The subbundle $U_2=A\,s^2E$ is common and has Frobenius oper
grades $\omega(-2S),\omega^2(-2S)$. Its primitive determinant
line $K=\det U_2\,\omega^{(1),-1}$ consequently satisfies
$F^*K=\omega^{-2}(-4S)$.

## Plucker lines prove uniqueness of the common plane

The functorial [Cartier exterior-square identification](all_tensor_cartier_hn.md)
is
\[
\Lambda^2B_C\otimes\omega_{C^{(1)}}^{-1}
 =\mathcal O_{C^{(1)}}\oplus P_C,\qquad P_C=F_{C*}\omega_C^{-2}.
\]
Contraction splits off the first summand; wedge square is
a nondegenerate quadratic form $q$ on $P$.

Here uniqueness retains the actual maps. If a common rank-two
subbundle $U$ were not Lagrangian, its restricted alternating
pairing would give a nonzero map $\det U\to\omega^{(1)}$.
The degree formula already proved makes its zero divisor have
degree $4(R+1)/5$. Thus $R=4$ and that divisor is $S^{(1)}$.
Comparing its Frobenius pullback with
$F^*\det U=\omega^3(-4S)$ gives $\mathcal O(S)=\omega^2$,
again outside the case under consideration. Hence every common
rank-two subbundle here is Lagrangian.

Its primitive Plücker line $J=\det U\otimes\omega^{(1),-1}$
has degree $-4(R+1)/5$. The nonzero adjoint
$F^*J\to\omega^{-2}$ has common zero divisor of degree $4R$,
and hence divisor $4S$. Uniqueness of the common Frobenius root
gives $J=K$; maps with that same divisor differ only by a scalar.
Thus its Plücker line, and consequently $U$, is the constructed
$U_2$.

Every common rank-three subbundle has a common symplectic
annihilator line and must be $A^\perp$. The constructed $U_2$
contains $A$ and is Lagrangian, hence lies in $A^\perp$.
The degree table gives all four quotient degrees, completing
the full flag classification in this branch.

## The remaining primitive quadratic is nonzero

Suppose $R=4$ and $\tau^2=\mathcal O$, so $Ca\ne0$.
Construct $K$ independently of the line branch: it is the
unique common root $F^*K=\omega^{-2}(-4S)$. Adjunction of
the canonical inclusion gives $K\hookrightarrow P=F_*\omega^{-2}$.
This map is saturated: off $S$ its scalar coefficient is a unit;
at $S$ it has order four and a unit $z^4$ coefficient in the
Frobenius basis. Here $\omega^{-2}(-4S)=\omega^{-10}$,
so $K=\omega^{(1),-2}$. Its primitive wedge quadratic is NONZERO.

There is a second natural perfect symmetric pairing on $P$.
Finite Frobenius duality gives
\[
(F_*\omega^{-2})^\vee
 =F_*(\omega^2\otimes\omega^{1-5})
 =F_*\omega^{-2}.
\]
In an étale coordinate $z$, this pairing takes local coefficients
$h,k$ to the coefficient obtained by Cartier from $hk\,dz$,
divided by $dz^{(1)}$. It is the familiar nondegenerate
coefficient-of-$z^4$ pairing in the Frobenius basis
$1,z,\ldots,z^4$. This describes the dualizing trace, NOT the
ordinary algebra trace of an inseparable extension.
The stable bundle $P$ has only scalar endomorphisms. Its
primitive wedge pairing and this perfect symmetric pairing
are therefore nonzero scalar multiples on each endpoint.

Write the section of $\omega^2\tau$ with divisor $S$ locally
as $s=a(z)(dz)^2$ in flat two-torsion frames. Under adjunction,
$K\to P$ has coefficient a nonzero multiple of $a^4$;
the earlier line map into $F_*\omega$ has coefficient a
nonzero multiple of $a^3$. The nonvanishing of $Ca$ is exactly
the nonvanishing of $\operatorname{Cartier}(a^3dz)$.
The duality square of the primitive line is proportional to
\[
\operatorname{Cartier}(a^8dz)
 =a^{(1)}\operatorname{Cartier}(a^3dz)\ne0.
\]
Here $a^{(1)}$ denotes the function on the relative Frobenius
target whose pullback is $a^5$; this notation retains coefficient
Frobenius. Thus $q|_K\ne0$, as claimed. Its common zero divisor
has degree eight on $Y^{(1)}$, so it is exactly $2S^{(1)}$.

## Complete classification in the two-torsion case

Any common Lagrangian rank-two subbundle has primitive Plücker
line $K$, by the adjunction and common-divisor calculation above.
The nonzero quadratic just proved rules it out. Any non-Lagrangian
rank-two subbundle forces $\mathcal O(S)=\omega^2$ by the
restricted-pairing degree calculation, also already proved above.
Consequently there are no proper common subbundles when $\tau$
is nontrivial two-torsion: ranks one and three were excluded
by the Cartier line dichotomy.

It remains to take $\tau=\mathcal O$. Write $s$ for a common
quadratic differential with simple divisor $S$. After Frobenius
transport its target section is again denoted $s$. The common
line $K=\omega^{(1),-2}=\mathcal O(-S^{(1)})$ has, up to
scalar, exactly one common map to each summand of
\[
\Lambda^2B\otimes\omega^{(1),-1}=\mathcal O\oplus P.
\]
For the scalar summand this is the section $s$. For the primitive
summand it is the saturated map $k:K\hookrightarrow P$
already constructed. Uniqueness follows respectively from its
common divisor $S^{(1)}$ and from the adjoint common divisor
$4S$; two maps with the same divisor have constant ratio.
Every possible non-Lagrangian Plücker line has this source
$K$, since its restricted pairing has divisor $S^{(1)}$.

The scalar and primitive summands are orthogonal for the wedge
quadratic. Its value on a map $(a s,b k)$ is consequently
\[
(c_0a^2+c_1b^2)s^2,
\qquad c_0,c_1\in k^\times.
\]
The first constant is nonzero because the inverse symplectic
bivector has nonzero square in odd characteristic; the second
is nonzero by the preceding duality calculation. There are
exactly two projective solutions, both with $ab\ne0$.
Each resulting line is nowhere zero: its primitive component
is saturated, including along $S^{(1)}$. Its zero wedge square
therefore gives an actual common Grassmannian section and a
saturated two-plane $U_+$ or $U_-$ in $B$.

Symplectic orthogonal complementation reverses the primitive
component relative to the scalar one, so it exchanges these two
solutions. Away from $S^{(1)}$ their pairings are nondegenerate;
they are orthogonal transverse planes there. At each point of
$S^{(1)}$ their scalar components vanish, so their Plücker lines,
and hence their planes, coincide and are Lagrangian in that fiber.

The direct-sum map into $B$ is generically an isomorphism and
injective as a map of sheaves. Its torsion cokernel is supported
on $S^{(1)}$. The degree table gives its total length as
\[
4(g(C)-1)-2[-2(g(C)-1)]
 =8(g(C)-1)=2\deg S_C.
\]
At each point its fiber dimension is two, since the planes
coincide there. Every such point contributes length at least two,
so equality of the total lengths forces precisely two invariant
factors of valuation one at every point. The cokernel is thus a
rank-two vector bundle on the reduced divisor, as asserted.
Finally the primitive section-ring calculation identifies
$\operatorname{ord}(\tau)=e$ when $R=4$. This labels the two
cases by $e=2$ and $e=1$ without an extra field-of-definition
assumption. None of these conditional alternatives proves that
a common span or its clump actually exists.
