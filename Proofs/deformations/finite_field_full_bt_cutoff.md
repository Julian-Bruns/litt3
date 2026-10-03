# Proof: effective arithmetic separation of full BT groups

[Statement](../../Theorems/deformations/finite_field_full_bt_cutoff.md).
21 September2026. A focused independent
[audit passed](../../Research/audits/FINITE_FIELD_FULL_BT_CUTOFF_AUDIT_2026_09_21.md).
The new ingredients
are an elementary bound for an unramified cusp-form lattice and an
algebraic-integer separation argument. Established BT effectivity and
truncation comparisons are not re-proved.

## 1. Rational coefficients and the Hecke normalization

Put $D_i=\mathbf D(G_i)[1/5]$. These rank-two convergent $F$-isocrystals
are overconvergent because the curve is proper. They are absolutely
irreducible: a rank-one subobject and its rank-one quotient would have
constant slopes on the connected curve, whereas the actual groups have
ordinary and supersingular fibers. This remains true after any finite
extension of the coefficient field. The normalized determinant is the
Tate determinant times the finite order-four character $[\delta]$.

For the Langlands argument, regard $D_i$ as a $q$-Frobenius object
over $K=W(\mathbf F_q)[1/5]$ by composing its specified one-step
$5$-Frobenius arrows $f$ times. Absolute irreducibility holds for this
object too, by the same rank-one slope argument. We recover the
one-step arrows after applying Langlands in Section4.

After a constant half-Tate twist, the determinant is finite.
[Abe's Langlands theorem, Theorem4.2.2](https://arxiv.org/pdf/1310.0528)
and its companion consequence give an irreducible unramified rank-two
ell-adic companion, with the same Frobenius polynomials. Finite-determinant
purity, followed by undoing the half-Tate twist, says that both eigenvalues
of $D_i$ at a degree-$e$ point have complex absolute value $q^{e/2}$
under every embedding. This application uses full rational coefficients;
there is no companion assertion for a finite BT truncation.

Use the UNNORMALIZED Hecke operator which sums over the $q^e+1$ lower
modifications at such a point. Its eigenvalue is
\[
a_{i,x}=\operatorname{tr}(\operatorname{Frob}_x,D_i),
\qquad \det(\operatorname{Frob}_x,D_i)=q^e\delta_x.
\tag{3}
\]
Thus the central Hecke eigenvalue is $\delta_x$, a fourth root of unity.
This normalization is stated explicitly in
[Stacks, Theorems64.31.2--3](https://stacks.math.columbia.edu/tag/03VR).
In particular the Hecke eigenvalue is the WEIGHT-ONE trace in (3),
not its half-Tate normalized value.

## 2. A finite integral Hecke module of bounded rank

Fix the central character $\delta$ (or its inverse, according to the
central-action convention), with values in $\mathbf Z[i]^\times$.
Unramified cusp functions can be viewed as functions on rank-two
bundles over $C$, equivariant for tensoring with rational line bundles.
The cusp condition is the vanishing of the sum over each finite
extension space $\operatorname{Ext}^1(M,L)$. The lower-modification
Hecke operators preserve this condition. These descriptions, including
the literal finite-sum operator, are given in
[Thomas, Sections3--4](https://users.ox.ac.uk/~mert2060/webfiles/Topic.pdf).
We give the bound rather than invoke an unspecified finiteness theorem.

A cusp function vanishes on any bundle whose Harder--Narasimhan gap
is greater than $2g-2$. Indeed such a bundle is $L\oplus M$ with
$\deg L-\deg M>2g-2$. Serre duality makes
$\operatorname{Ext}^1(M,L)=0$, so the cusp sum consists of that single
value and forces it to vanish.

There is a line bundle of degree one defined over $\mathbf F_q$:
Lang's theorem gives a rational point of $\operatorname{Pic}^1(C)$,
and the Brauer group of the finite field is zero. Tensoring by its
powers reduces the degree of a rank-two bundle to $d_0=0$ or $1$.
Consider a bundle $E$ of one of these degrees and with the preceding
Harder--Narasimhan bound. Riemann--Roch gives a nonzero section of
$E\otimes L_1^g$, since its Euler characteristic is $d_0+2>0$.
Saturating that section yields an exact sequence over $\mathbf F_q$
\[
0\longrightarrow L\longrightarrow E\longrightarrow M\longrightarrow0,
\qquad -g\le\ell:=\deg L\le g-1,
\qquad \deg M=d_0-\ell.
\tag{4}
\]
The upper bound follows either from semistability or from
$2\ell-d_0\le2g-2$. Let $h=|\operatorname{Pic}^0(C)(\mathbf F_q)|$.
For fixed degrees there are $h$ choices for each line. Moreover
\[
h^1(LM^{-1})\le3g.
\tag{5}
\]
For a negative-degree line this follows directly from Riemann--Roch,
using $\deg(LM^{-1})=2\ell-d_0\ge-2g-1$; for a nonnegative-degree
line, Serre duality and $h^0(N)\le\deg N+1$ give the weaker but
sufficient bound $2g-1\le3g$. Thus (4), even counting many bundles
more than once, bounds the number of relevant degree-zero and
degree-one bundles by
\[
4g\,h^2q^{3g}
\le4g(1+\sqrt q)^{4g}q^{3g}
\le4g\,16^gq^{5g}=A.
\tag{6}
\]
Here the middle inequality is the Weil bound for the Jacobian.

Take all cusp functions with this central character and values in
$\mathbf Z[i]$. Restriction to the finite set just counted embeds
their module $\mathcal L$ into $\mathbf Z[i]^A$. Their defining
relations have coefficients in $\mathbf Z[i]$, including the finite
cusp sums. Consequently $\mathcal L$ spans the full characteristic-zero
cusp space: a rational solution is made integral by one common
denominator. The possibly infinite list of linear relations poses no
problem in a finite-dimensional ambient space. Each Hecke operator
preserves $\mathcal L$, since it is a finite sum and degree normalization
multiplies values only by fourth roots of unity. As $\mathbf Z[i]$ is a
PID, $\mathcal L$ is free of rank at most $A$.

Let $r\le A$ be the rank of this ONE integral Hecke lattice and
let $T_x$ act on it. Both $a_{1,x}$ and $a_{2,x}$ are eigenvalues
of the same $T_x$. On $\mathcal L\otimes_{\mathbf Z[i]}\mathcal L$,
the integral operator $T_x\otimes1-1\otimes T_x$ has eigenvalues
$\lambda_u-\lambda_v$, $1\le u,v\le r$. Its characteristic polynomial
is divisible by $t^r$. The quotient is monic over $\mathbf Z[i]$
of degree $r(r-1)$ and kills every NONZERO trace difference.
Thus any $b_x=a_{1,x}-a_{2,x}\ne0$ is an algebraic integer with
\[
[\mathbf Q(b_x):\mathbf Q]\le2r(r-1)\le
D:=2A(A-1).
\tag{7}
\]
This uses the common integral operator instead of taking a
compositum of two separately bounded trace fields.

## 3. A congruence sufficiently deep forces exact trace equality

At a degree-$e$ point, each embedding of $\mathbf Q(b_x)$ extends
to a field containing both traces. Purity therefore bounds every
complex conjugate of $b_x$ by $4q^{e/2}$.

Suppose $G_1[5^n]\simeq G_2[5^n]$ over $\mathbf F_q$. The actual
crystalline comparison at $x$ conjugates the $q^e$-Frobenius matrices
modulo $5^n$. Hence, in the fixed algebraic closure of $\mathbf Q_5$,
\[
v_5(b_x)\ge n.
\tag{8}
\]
If $b_x\ne0$, its algebraic-integral norm is a nonzero integer. The
prime corresponding to the chosen embedding contributes at least $n$
to its 5-adic valuation: with normalized valuation $v_5$, its contribution
is $e_{\mathfrak p}f_{\mathfrak p}v_5(b_x)\ge n$. All other finite
contributions are nonnegative. Therefore
\[
5^n\le\bigl|N_{\mathbf Q(b_x)/\mathbf Q}(b_x)\bigr|
\le(4q^{e/2})^D.
\tag{9}
\]
For $e\le d$ and $n=B=D(1+fd/2)$, this is impossible:
$\log_5 4<1$, so $D\log_5(4q^{e/2})<B$. We conclude $b_x=0$ at every
closed point of degree at most $d$.

## 4. Finite Frobenius determination gives a rational isomorphism

For an unramified rank-two sheaf on a smooth proper genus-$g$ curve,
the complexity in
[Esnault--Kerz, Definition3.4 and Theorem5.1](https://math.ac.vn/uploads/files/Bai3_Acta12-40-H.Esnault-M.Ke_531-562_13-Dec.pdf)
is $2g+1$. Their finite determination bound is
\[
16\left\lceil\log_q(8(2g+1))\right\rceil=d.
\tag{10}
\]
The determinants are already identical, so the trace equalities just
proved give equality of all the required Frobenius polynomials.
The ell-adic companions are isomorphic. The uniqueness in the
isocrystal Langlands correspondence, equivalently its semisimple
Chebotarev consequence, then gives $D_1\simeq D_2$ after algebraic
coefficient extension. The Hom space commutes with finite coefficient
extension. Since these $q$-Frobenius objects are absolutely irreducible,
their $q$-Frobenius Hom space $V$ is a one-dimensional $K$-vector space,
and each nonzero element is an isomorphism.

It remains to retain the ACTUAL one-step $5$-Frobenius. Write
$F_i:F_{\rm abs}^*D_i\to D_i$ for those arrows and let $\sigma$ be
Witt Frobenius on $K$. The operator
\[
\Theta(u)=F_2\circ F_{\rm abs}^*(u)\circ F_1^{-1}
\]
preserves $V$, is $\sigma$-semilinear, and satisfies $\Theta^f=1$:
the last identity is exactly compatibility with the composed
$q$-Frobenius arrows. Cyclic Galois descent, or Hilbert90 for the
one-dimensional $K$-space $V$, gives a nonzero $\Theta$-fixed element.
It is an isomorphism for the original one-step $F$-isocrystals over
the original coefficients. This argument retains the absolute
coefficient Frobenius and does not identify relative curve twists.
Full rational Dieudonne faithfulness now gives an isogeny of the
two full groups.

## 5. The stable first connection makes the isogeny integral

Over $\overline{\mathbf F}_q$, the common first crystalline
bundle is a degree-zero rank-two oper. By
[crystalline lattice rigidity](crystalline_oper_lifting.md#rigidity-of-the-integral-lattice),
the supplied rational comparison rescales by a power of five to
an integral isomorphism. Its $F,V$ identities are preserved, so full
faithfulness gives $G_1\simeq G_2$ geometrically.

[Normalized comparison rigidity](versal_bt_display_descent.md)
makes the induced automorphism of the common BT1 a scalar in
$\mathbf F_5^\times$. Its Teichmuller correction retains a full group
isomorphism and makes it respect the specified marking. The remaining
determinant scalar in $1+5\mathbf Z_5$ has an inverse square root,
which corrects the determinant without changing that marking.
Normalized marked isomorphisms at every positive finite level are
unique by the established ordinary generic automorphism calculation;
the full normalized marked isomorphism is consequently unique too.

If the original finite-level comparison was given geometrically, each
arithmetic Galois conjugate has the same marking and determinant.
Uniqueness makes it invariant, and effective descent gives it over
$\mathbf F_q$, as needed for (8). Likewise the final normalized full
comparison descends. The isomorphism at level $B$ is the one originally
specified, again by uniqueness.

## 6. Ordinary existence and fixed-field counts

The later [absolute torsor](versal_bt_extension_torsor.md) gives
$H^0(\mathcal B_H)=H^1(\mathcal B_H)=0$ when $\delta_H=0$.
It supplies the unique full marked normalized extension of the
actual $H$, without a next reference. Its field descent follows
from [the exact arithmetic counts](common_bt_tower_rigidity.md).
Thus the ordinary cutoff is $1$, independently of $q$ and $g$.

At every reached normalized level, that counting theorem gives
either no next extension or exactly $q^{\delta_H}$ classes.
Starting from the single marked $H$ therefore gives at most
$q^{\delta_H(N-1)}$ level-$N$ classes. The proved cutoff injects
full classes into level-$B_H$ classes, giving the stated finite bound.

If these finite sets are nonempty at arbitrarily high levels,
their truncation tree has finite branching and unbounded depth.
König's lemma gives an infinite path. Choose its actual marked
groups and the unique normalized truncation comparisons; these
form a full group over the SAME field. The converse is truncation.
This does not infer unbounded depth from any single BT$_N$.

In the actual source application, $K_{H_Z}=0$ also forces both
endpoint kernels to vanish by injective function pullback. Their
unique full towers then compare from the specified BT1, since
every successive actual source difference lies in this zero space.
The general cutoff retains its supplied full groups, source genus
and common finite field; it creates no missing source comparison.
