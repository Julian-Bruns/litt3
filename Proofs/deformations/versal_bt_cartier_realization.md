# Proof: the actual Cartier classification at every BT level

[Statement](../../Theorems/deformations/versal_bt_cartier_realization.md).
The logarithmic bridge and necessary condition are the earlier local
pole/comparison deductions. Sections4–7 integrate the returned
[Cartier-image result](../../Research/requests/bt_cartier_effectivity_2026_09_20/01_realize_cartier_classes.md).
The last-digit and two-leg conclusions are the established continuation.

## 1. The logarithmic character cover

On the ordinary open, the two constituents of $H$ have characters
$\chi$ and $\delta\chi^{-1}$, with values in $\mathbf F_5^*$;
$\delta$ is the determinant character and extends across $C$.
Kummer changes of constituent basis multiply $d\log q_H$ by
$\chi^2\delta^{-1}$. Use the connected cover corresponding to this
character. Its degree divides four. At a simple supersingular point,
the level-one Igusa character $\chi$ has inertia of order four;
the logarithmic character has inertia of order two.

Here is the local differential calculation, retaining the actual
crystal. In a paired frame, write
$F_0=(\begin{smallmatrix}t&0\\1&0\end{smallmatrix})$, and let
$b=C_{12}$ be the unit Kodaira--Spencer coefficient. On the Igusa
cover take $\beta^4=t^{-1}$; the ordinary frame has vectors
$\beta(1,t^{-1})$ and $\beta^{-1}(0,1)$. Its logarithmic form is
$\beta^{-2}b\,dt$. On the character double at this point, put
$t=s^2$. The form becomes a unit times $s^2ds$. It has zero order
exactly two. Away from $S$ it has no zeros by versality. Thus the
projective normalization $P$ has $\operatorname{div}\Omega=2R$.
Nontrivial determinant characters are retained in the possibly
degree-four cover; they are not silently trivialized on $C$.

The form is Cartier-fixed because it is locally logarithmic on an
ordinary constituent-splitting cover. Cartier commutes with separable
pullback, so this identity descends to $P$.

## 2. The Cartier equation for an actual difference

Over a further separable extension, write $q_B=q_A r^{5^N}$ and
$c=d\log r/d\log q_A$. Both $\Omega$ and $c\Omega$ are logarithmic.
The projection rule for Cartier gives
\[
C_P\bigl((c^5-c)\Omega\bigr)
=cC_P(\Omega)-C_P(c\Omega)=c\Omega-c\Omega=0.
\]
This is an equality of rational forms, verified after a faithfully
separable pullback and hence before it. The intrinsic function is
$\Delta=c^5-c$. Its pole orders on $C$ are at most one. At a
ramification point of $P$, multiplying by $\Omega$ cancels the
possible order-two pullback pole. Consequently $\pi^*\Delta\Omega$
is a REGULAR Cartier-killed form on the proper curve $P$.

Conversely, a rational form in the same character block is uniquely
$\pi^*r\Omega$. At ramification, its regularity is equivalent to
$v_s(r)\ge-1$; elsewhere it is equivalent to regularity of $r$.
Thus multiplication identifies $H^0(\mathcal O_C(S))$ with the whole
character block. The bound and valuative theorem make(2) injective.
Sections4–7 prove surjectivity by effective local windows and
Hopf-algebra patching.

## 3. Identification with indigenous ordinariness

The actual Dieudonne connection, its Hodge line, and the
Kodaira--Spencer isomorphism form a projective oper. Its p-curvature
is nilpotent: Frobenius and Verschiebung identify its two generic
graded lines with Cartier-flat lines. It is nonzero generically,
since the ordinary Kummer logarithmic differential is nonzero and
Cartier-fixed. The local calculation above identifies its square
Hasse tensor, up to the fixed nonzero normalization, with
$-\Omega^4$. This descends to $\omega_C^4$ and has divisor $2S$.
In computing that divisor, remember the ramification contribution
in $\pi^*\omega_C\to\omega_P$: $\Omega^4$ has divisor $8R$,
whereas pulled-back base tensors contribute $4R$. Thus it gives
$2S$, not $4S$, on $C$. The oper is admissible.

The established
[Hasse--Cartier criterion](../projective_connections/hasse_cartier_criterion.md)
identifies indigenous ordinariness with injectivity on the inverse
character block. Its polarized de Rham argument proves equality of
the two inverse-character Cartier kernel dimensions. Therefore the
kernel in (1) has precisely the indigenous tangent dimension.
This handles degree two and degree four together.

If the connection is ordinary, the Cartier equation forces $\Delta=0$. Valuative
comparison then gives the actual marked normalized isomorphism on
the whole curve. No cover-degree averaging, new endpoint cover, or
connection-to-group effectivity assertion is used at this step.

For higher levels, a difference between two extensions of a fixed
BT$_N$ is measured by $q_B=q_A r^{5^N}$. Dividing the last connection
digit still gives $d\log r$. The last-digit pole bound, equation (3),
and all-level valuative comparison are unchanged. The comparison on
the ordinary locus is an actual Kummer-group comparison; scalar
determinant correction preserves the specified BT$_N$ marking.

## 4. The actual local windows

First let $N=1$. On $\mathfrak S=W(k)[[t]]$, with
$\sigma(t)=t^5$, put $a_j=t+5\widetilde j$ and take
\[
P=\mathfrak S e_1\oplus\mathfrak S e_2,
\quad Q=5\mathfrak S e_1\oplus\mathfrak S e_2,
\quad F(e_1)=a_j e_1+e_2,
\quad F(e_2)=5e_1.
\tag{7}
\]
Set $F_1(5e_1)=a_j e_1+e_2$, $F_1(e_2)=e_1$. The normal
matrix is invertible, so these are effective full windows under
the established window equivalence. In the basis $(5e_1,e_2)$
their torsion Breuil maps are
\[
\varphi_j=\begin{pmatrix}0&1\\5&-a_j\end{pmatrix},\qquad
\psi_j=\begin{pmatrix}a_j&1\\5&0\end{pmatrix}.
\tag{8}
\]
Their reductions modulo five are independent of $j$. This supplies
the actual BT1 marking, beyond an equality of reduced vector bundles.
The determinant Frobenius is constantly $-5$; the same determinant
normalization is used for the whole family.

Write its crystalline connection matrix as
$\Gamma_j=(\begin{smallmatrix}X_j&Y_j\\Z_j&-X_j\end{smallmatrix})dt$.
Horizontality gives
\[
Z_j=t^4\sigma(Y_j),\qquad
X_j=t^4(a_j\sigma(Y_j)-5\sigma(X_j)),
\]
\[
Y_j=-a_j'-t^4a_j^2\sigma(Y_j)
+10t^4a_j\sigma(X_j)+25t^4\sigma(Z_j).
\tag{9}
\]
Iteration is $t$-adically contracting. These are the connections of
the effective groups. Trace vanishes by the same contraction applied
to $\operatorname{tr}\Gamma=5t^4\sigma(\operatorname{tr}\Gamma)$.

For $b=Y_0\bmod5$, $e_j=(Y_j-Y_0)/5\bmod5$, the reductions of
(9) give (5). In the paired-frame formula of
[the actual pole theorem](versal_bt_unitroot_ramification.md), the
Frobenius difference has $u=j$ and the divided upper-right connection
entry is $e_j$. Thus its invariant really is $T(j)$ from (5).
For $a\in k$ its leading terms are
\[
T(a)=2a t^{-1}+O(t^5),\quad
T(at)=a^5+a+O(t^6),
\]
\[
T(at^n)=(2-n)a t^{n-1}+O(t^n)\quad(n\ge2).
\tag{10}
\]
The derivative $j'$ in (5) is essential. Additivity is over
$\mathbf F_5$, and $T(t^NR)\subset t^{N-1}R$ for $N\ge2$.

An arbitrary local reference reduces to this one after a parameter
change. A BT$_n$ over the complete local ring $k[[t]]$ prolongs to a
full group by
[Illusie, Theorem4.4(e)](https://www.numdam.org/item/AST_1985__127__151_0.pdf).
The height-two supersingular full group has a one-parameter universal
deformation, and its tangent map is Kodaira--Spencer, by Corollary4.8
of the same source. The window at $j=0$ has coefficient $b(0)=-1$,
so it is such a universal deformation. The reference's unit
Kodaira--Spencer map makes its classifying power series a uniformizer.
Transport its marking and determinant after this change. This invokes
no prolongation theorem on a proper global curve.

## 5. The local Cartier condition supplies precisely the missing digits

On a completed branch of the character cover write $t=s^2$ and
$\Omega=s^2\nu(t)ds$, with $\nu$ a unit. For $h\in t^{-1}k[[t]]$,
the differential is regular, and the ordinary Cartier coefficient
formula gives
\[
C(h\Omega)=0
\quad\Longleftrightarrow\quad
[t^{5r+1}](\nu h)=0\quad\text{for every }r\ge0.
\tag{11}
\]
Indeed its exponents in $s$ are $2m+2$ and Cartier selects those
congruent to four modulo five. If $h$ has no terms below $t^m$,
$m\equiv1\pmod5$, equation(11) forces its $t^m$ coefficient to vanish.

Every $T(j)$ satisfies (11) by the necessary Cartier theorem for
actual groups. Conversely, given $h$ satisfying (11), use a constant
$j$ to match its pole by (10). Use $at$ to match the constant term;
$a^5+a$ takes every value since $k$ is algebraically closed. At a
subsequent degree $m\ge1$, the residual still satisfies (11). If
$m\equiv1\pmod5$, its coefficient is already zero. Otherwise cancel
that coefficient $\rho_m$ by adding
\[
\frac{\rho_m}{1-m}\,t^{m+1}
\tag{12}
\]
to $j$. The resulting power series converges. Continuity of $T$
proves $T(j)=h$. This is an actual full window, hence gives the
required finite integral group. It proves the exact local criterion.

## 6. Ordinary realization and descent

On the ordinary open trivialize the constituents of the reference
etale-locally. Put $\eta=d\log q_A$. Adjoin a solution of
$c^5-c=h$ by a finite etale Artin--Schreier cover. Since
$C(\eta)=\eta$ and $C(h\eta)=0$, one has
\[
C(c\eta)=C(c^5\eta-h\eta)=c\eta.
\tag{13}
\]
The logarithmic Cartier criterion gives, locally, $c\eta=d\log r$
for a unit $r$. Set $q_B=q_A r^5$ and form the actual Kummer
BT2 extension. Its invariant is $h$ and its BT1 marking is the
specified one. This does not confuse an $F,V$-linear nonhorizontal
comparison with a group isomorphism.

Two choices with the same invariant differ in $c$ by
$a\in\mathbf F_5$. They have
$q_2\equiv q_1^{1+5a}$ modulo twenty-fifth powers. The constituent
exponents $1+5a/2$, $1-5a/2$ give a determinant-preserving marked
comparison. Such a comparison is unique on a reduced connected
ordinary base: its marked scalar exponents have sum zero by the
determinant and difference zero by the nonzero logarithmic form.
The residual group $\operatorname{Hom}(\mathbf Z/25,\mu_{25})$
has no nonidentity sections there. Therefore the comparisons satisfy
their cocycle. Etale descent gives an actual group $B_U$ on $U=C-S$.

## 7. Global effectivity

At each $x\in S$, use Section5 over $R_x=\widehat{\mathcal O}_{C,x}$
to obtain an actual integral group $B_x$ with the same invariant.
On $K_x=\operatorname{Frac}(R_x)$, the ordinary classification gives
a unique marked normalized isomorphism with $B_U$.

[Beauville--Laszlo patching](https://math.univ-cotedazur.fr/~beauvill/pubs/descente.pdf)
glues the finite locally free coordinate modules on $U$ and the
completed discs. Its tensor compatibility and full faithfulness glue
multiplication, comultiplication, unit, counit and antipode. Thus the
result is an actual finite locally free commutative group on $C$.
The BT2 condition, marking and normalized determinant hold after the
jointly faithfully flat base changes and hence on $C$. This proves
global surjectivity. Injectivity is the earlier valuative theorem.

## 8. The same construction at every last digit

Now fix $N\ge1$ and an actual reference $A$ at level $N+1$. In
(7)--(9) replace $5\widetilde j$ by $5^N\widetilde j$. The Breuil
maps (8) agree modulo $5^N$, so the entire actual BT$_N$ marking is
retained. Reduce (9) modulo $5^{N+1}$, subtract the reference and
divide by $5^N$. Terms quadratic in the difference vanish because
$2N\ge N+1$. Terms involving a further explicit factor five vanish
as well. Witt Frobenius preserves $5^N$, and its action on the
reduced difference is the fifth power. The result is exactly (5),
including $-j'$ and $-2t^5j b^5$.

The same paired-frame comparison is $I+5^N X$. Products of two last
digits vanish modulo $5^{N+1}$, so the ordinary comparison formula
is again $T(j)$. Equivalently on the ordinary locus,
$q_B=q_A r^{5^N}$ and the divided connection digit is $d\log r$.
The elementary reduction, Cartier recursion and continuity argument
are unchanged. Illusie's local prolongation and parameter change
apply to the reference at level $N+1$ as well.

In Section6 replace $q_A r^5$ by $q_A r^{5^N}$, and the two
constituent exponents by $1\pm5^Na/2$. They still preserve the whole
BT$_N$ marking and normalized determinant. Last-digit normalized
automorphisms are trivial by the established all-level scalar theorem.
Section7 patches groups of order $5^{2(N+1)}$. Consequently it proves
the theorem for every $N$, with the same $K_H$.

The source script
[verify_bt_cartier_realization.py](../../scripts/deformations/verify_bt_cartier_realization.py)
checks arbitrary-parameter examples, their derivatives, both horizontal
$F,V$ equations, and the common last-digit formula modulo25,125,625
through $t^{179}$. The
[bounded check](../../../litt3-computation-data/bt_cartier_realization_20260920/last_digit_checks.json)
passes. It checks changed matrix identities, not group effectivity,
convergence, arbitrary coefficient fields, or global patching.

## 9. Actual endpoint corrections

At each height, additive differences and etale pullback commute.
Surjectivity says every vector in $K_{H_X}$ or $K_{H_Y}$ is an
actual correction of the chosen endpoint extension, retaining the
previous entire level. This proves exactly the quotient (6).

If the span is coreless and a function belongs to both pulled-back
kernels, it lies in $k(X)\cap k(Y)=k$ inside $k(Z)$. A constant
$a$ in a Cartier kernel is zero since $C(a\Omega)=a^{1/5}\Omega$.
Thus the two images have zero intersection. None of these assertions
produces a reference on an endpoint which has no next extension.

On the two selected genus-two endpoints, the
[all-85 active classification](../projective_connections/genus_two_active_critical_quartics.md)
makes every induced oper ordinary, including all geometric root classes.
The Cartier criterion above therefore gives $K_H=0$ for every actual
$H$ in the statement's family range.
