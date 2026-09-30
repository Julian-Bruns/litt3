# Proof: small logarithmic zero orders exclude wild stabilizers

[Statement](../../Theorems/deformations/versal_bt_tame_automorphisms.md).
21 September2026. This is an author proof. The finite-group restriction
uses only the already established logarithmic character cover of an
actual BT1; it does not use effectivity at a higher level.

## 1. A local Cartier and different calculation

Let $P$ be a smooth curve in characteristic $p$, with perfect algebraically
closed constant field, and let $0\ne\Omega$ be a Cartier-fixed regular
differential. Suppose an automorphism $\gamma$ of order $p$ fixes a point
$z$ and satisfies $\gamma^*\Omega=\Omega$. The invariant differential
descends through the separable function-field extension to a rational
differential $\eta$ on $P/\langle\gamma\rangle$. Cartier commutes with
separable pullback, whose map on differentials is injective. Therefore
$C\eta=\eta$.

A Cartier-fixed rational differential has no pole of order greater
than one. Indeed the Laurent formula
\[
C\left(\sum_n a_n x^n\,dx\right)
=\sum_j a_{pj+p-1}^{1/p}x^j\,dx
\]
strictly increases the valuation of a differential of valuation below
$-1$. Such a valuation is incompatible with being fixed.

At the fixed point the ramification index is $p$. Write $m\ge1$ for
the unique lower jump of the cyclic order-$p$ local extension. Its
different exponent is $(p-1)(m+1)\ge2p-2$. The differential valuation
formula consequently gives
\[
\operatorname{ord}_z\Omega
=p\operatorname{ord}_{\bar z}\eta+(p-1)(m+1)
\ge-p+2p-2=p-2.
\tag{1}
\]
The valuation formula is the local different formula underlying
[Riemann--Hurwitz](https://stacks.math.columbia.edu/tag/0C1B). The bound
on the different also follows directly from $G_0=G_1=C_p$ in Hilbert's
different sum. This proves the local fact stated in the theorem.

## 2. The actual character cover retains finite group actions

The [logarithmic character construction](versal_bt_cartier_rigidity.md)
uses the two ordinary constituents of $H$. Their ratio character takes
values in $\mathbf F_5^\times$. On a connected component $P$ of its
framing cover the tautological logarithmic differential is nonzero,
Cartier-fixed and regular, with
\[
\operatorname{div}_P\Omega=2R.
\tag{2}
\]
Here $R$ is the reduced ramification divisor; the index over each
supersingular point is two. Outside that divisor the differential has
no zero. This part of the construction depends on $H$ itself, not on
the existence of a next-level reference used elsewhere for differences.

For clarity, actions can be retained without choosing arbitrary
isomorphisms and assuming that their cocycle vanishes. Form the group
of pairs $(\alpha,u)$ with $\alpha\in G$ and $u:\alpha^*H\simeq H$.
Its kernel over $G$ is $\operatorname{Aut}_C(H)=\mathbf F_5^\times$:
on the ordinary generic field versality makes the Kummer extension
nontrivial even after separable constituent splitting, so the only
endomorphisms are scalars. Equality of group morphisms extends from
the generic point because their finite Hopf algebras are torsion-free.
Thus this group of pairs is finite, with prime-to-five kernel.

If a point stabilizer in $G$ had five-divisible order, it would contain
an order-five subgroup. Its inverse image in the group of pairs has a
Sylow-five subgroup of order five projecting isomorphically to it.
This is an ACTUAL action on $H$, hence on the full ordinary framing
cover, and it preserves the tautological differential exactly. There
are at most four connected components, so each is preserved. After
normalization each fiber of $P\to C$ has at most four geometric
points, so a fixed base point gives a fixed point of this order-five
action on $P$. The action on $P$ still has order five, since its base
action is nontrivial. Formula (2) gives zero order zero or two there,
contradicting (1), whose lower bound is three.

Every point stabilizer in $G$ therefore has order prime to five.
Tame inertia on a smooth curve is cyclic and acts faithfully on the
tangent line. This proves tameness, including when five divides the
total order of $G$. Such five-subgroups can only act freely.

## 3. The quartic tensor bounds each tame inertia order

The same intrinsic construction gives a regular quartic tensor
\[
s_H=-\Omega^4\in H^0(C,\omega_C^4),
\qquad \operatorname{div}(s_H)=2S.
\tag{3}
\]
In this notation equality means the descended tensor under the
differential pullback, so the ramification correction is included.
The formula and divisor are established in the cited character-cover
proof. Its scale is intrinsic: changing an ordinary constituent basis
multiplies $\Omega$ by an element of $\mathbf F_5^\times$, whose fourth
power is one. Every automorphism in $G$ therefore preserves $s_H$.

For a tame stabilizer of order $e$, choose a parameter in which a
generator acts by $t\mapsto\zeta t$, with $\zeta$ of order $e$.
If the leading term of (3) is $a t^m(dt)^4$, invariance gives
$\zeta^{m+4}=1$. At an ordinary point $m=0$, and at a supersingular
point $m=2$. Hence
\[
e\mid4\quad\text{outside }S,\qquad e\mid6\quad\text{on }S.
\tag{4}
\]

## 4. The numerical bound and its equality case

Let $B=C/G$, with branch indices $e_1,\ldots,e_r$. Tameness gives
\[
2g-2=|G|\left(2g(B)-2+\sum_i(1-e_i^{-1})\right).
\tag{5}
\]
Each nontrivial $e_i$ lies in $\{2,3,4,6\}$. The positive expression
in parentheses is at least $1/12$. For $g(B)\ge1$ this follows
immediately. For $g(B)=0$, four branch points give minimum positive
value at least $1/6$, and five or more give at least $1/2$. With three
branch points, the largest reciprocal sum strictly below one is
$11/12$, attained precisely by $(2,4,6)$ and $(3,3,4)$. This proves
$|G|\le24(g-1)$.

The second equality signature is excluded by the divisor of the
invariant tensor. On $B$, its rational descent has order
\[
n_i=(m_i-4(e_i-1))/e_i
\tag{6}
\]
at a branch point, with $m_i=0$ or $2$ according as the points above
are ordinary or supersingular. For $(3,3,4)$, (4) forces the first
two to be supersingular and the last ordinary, giving orders
$-2,-2,-3$. Their sum is $-7$, whereas a rational section of
$\omega_{\mathbf P^1}^4$ has total divisor degree $-8$. All other
points contribute nonnegatively, an impossibility.

For $(2,4,6)$ the latter two points are respectively ordinary and
supersingular, with orders $-3,-3$. The inertia-two point must be
ordinary, of order $-2$, to obtain total $-8$. No additional zero is
possible. Thus the entire supersingular locus is the inertia-six
orbit, as asserted. This calculation does not assert that such a pair
$(C,H)$ exists.

The proof only constrains FINITE automorphism groups. It cannot be
applied as a bound on the infinitely many actual formal path returns
of a coreless correspondence, and it supplies no common oper on a
bare span.
