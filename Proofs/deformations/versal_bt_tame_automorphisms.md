# Proof: the canonical quartic root excludes wild stabilizers

[Statement](../../Theorems/deformations/versal_bt_tame_automorphisms.md).
Version2,3 October2026. The canonical root construction replaces the
chosen-BT1 action and its scalar-extension argument. Later finite-level
effectivity makes the same restriction intrinsic to every supplied
admissible active oper.

## 1. A local Cartier and different calculation

Let $P$ be a smooth curve in characteristic $p$, with perfect algebraically
closed constant field, and let $0\ne\Omega$ be a Cartier-fixed regular
differential. A nonzero constant Cartier eigenvalue gives the same
case after constant rescaling over the algebraically closed field.
Suppose an automorphism $\gamma$ of order $p$ fixes a point
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

## 2. The canonical fourth root retains the entire line stabilizer

Choose a nonzero rational differential $\nu$ on $C$, and write
$s=f\nu^4$. Normalize the full reduced Kummer algebra
\[
z^4=-f,\qquad \Omega=z\pi^*\nu.
\tag{2}
\]
This defines $D$ independently of the frame $\nu$. There are at most
four components and at most four geometric points in each fiber.
For $m=\operatorname{ord}_x(s)$ its local ramification index is
$e=4/\gcd(4,m)$, and the tame different formula gives
\[
\operatorname{ord}_y\Omega=em/4+e-1.
\tag{3}
\]
Thus $\Omega$ is regular: its zero order is two over $S$ and zero
elsewhere. The convention $\gcd(4,0)=4$ is used.

Let $\alpha^*s=\lambda s$, write $\alpha^*\nu=j\nu$, and choose
$\rho^4=\lambda$. The scalar-tautological lift
$z\mapsto\rho z/j$ extends to an automorphism of $D$ above $\alpha$,
with $\widetilde\alpha^*\Omega=\rho\Omega$. Cartier commutes with
this pullback. The common nonzero eigenvalue gives
\[
c\rho^{1/5}\Omega
=C_D(\rho\Omega)
=\widetilde\alpha^*C_D(\Omega)
=c\rho\Omega.
\]
Hence $\rho^{1/5}=\rho$, so $\rho\in\mathbf F_5^\times$ and
$\lambda=\rho^4=1$. Every element of the line stabilizer fixes $s$
exactly.

Now choose the canonical lift $\rho=1$. These lifts compose
functorially and give an ACTUAL action of the whole $G$ on $D$
preserving $\Omega$. This refers to scalar-tautological lifts:
a disconnected $D$ can have additional automorphisms, which are
not needed.

If a point stabilizer in $G$ had five-divisible order, Cauchy's
theorem would give an order-five subgroup. Its canonical action
preserves every component of $D$, since there are at most four,
and fixes every point of the fiber over the fixed base point,
since that fiber has at most four points. Its action on each
component still has order five, as its base action is nontrivial.
At any such fixed point, (3) gives zero order zero or two.
The local bound (1) gives at least three, a contradiction.

All point stabilizers are therefore tame. Tame inertia on a smooth
curve is cyclic and acts faithfully on the tangent line. This
also shows that every five-subgroup of $G$ acts freely.

### Why actual BT1 and admissible active opers satisfy the hypothesis

The established [logarithmic character construction](versal_bt_cartier_realization.md)
of an actual everywhere-versal BT1 gives a nonzero regular
Cartier-fixed differential $\Omega_H$ on a tame character cover,
with $\Omega_H^4=-\pi^*s_H$ and $\operatorname{div}(s_H)=2S$.
It maps to a component of the normalization (2) for $s_H$.
Cartier commutes with separable pullback, which is injective on
rational differentials, so $\Omega$ is Cartier-fixed on that
component. All other fourth roots differ by
$\mu_4=\mathbf F_5^\times$; consequently the same property holds
on every component.

The normalized oper curvature quartic is a fixed nonzero constant
multiple of $s_H$, as in the
[Cartier normalization comparison](bt_cartier_tangent_identification.md).
For $s=a s_H$, choose $b^4=a$: the new tautological differential
is $b\Omega_H$ and has the common nonzero Cartier eigenvalue
$b^{1/5}/b$. No assumption that this normalization constant is in
$\mathbf F_5^\times$ is needed.

For a supplied admissible active determinant-trivial oper, retain
its canonical first periodic datum, its flat two-torsion discrepancy
$\kappa$ and a fixed compatible correction $N^4=\kappa$,
$N^8=\mathcal O$. The later
[finite-level effectivity theorem](admissible_periodic_bt_effectivity.md)
realizes the corrected oper by an actual everywhere-versal BT1,
without ordinariness. A flat scalar twist preserves the projective
oper and its intrinsic quartic, so the preceding argument applies.
No higher realization or invariant choice of BT1 is required.

## 3. The quartic tensor bounds each tame inertia order

We have $\operatorname{div}(s)=2S$ and every element of $G$ fixes
$s$ exactly, by Section2.

For a tame stabilizer of order $e$, choose a parameter in which a
generator acts by $t\mapsto\zeta t$, with $\zeta$ of order $e$.
If the leading term of $s$ is $a t^m(dt)^4$, invariance gives
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
orbit, as asserted. This calculation does not assert that such a quartic or BT1 exists.

The proof only constrains FINITE automorphism groups. It cannot be
applied as a bound on the infinitely many actual formal path returns
of a coreless correspondence, and it supplies no common oper on a
bare span.
