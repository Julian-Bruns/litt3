# Finite translation and the smaller m3 parity observable

1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m3_small_critical_parity.md).
Use the fixed gap rows already verified in
[the reduced-linear denominator proof](admissible_linear_critical_denominator.md),
the finite/short quadratic traces of
[critical incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md),
[m3 critical coprimality](../../Theorems/cartier_and_spin/admissible_degree_ten_m3_critical_coprimality.md),
and [the critical parity section](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
The new implication was independently derived and focused-reviewed
by the parent research agent. It uses no new source enumeration.

## The fixed leading critical line

Finite coefficients of $F_f$ and the monic $\phi_f$ are affine.
Monic division of $F_f'$ by $\phi_f$ gives an affine polynomial $D_f$.
Since $D_f(T)=D_s(T-a)$, its cubic coefficient is $\delta_3$ and
\[
\delta_{2,s}=\delta_{2,f}+3a\delta_3.
\]
On m3, $\delta_3\in L_3=\langle1,x\rangle$ has exact pole3,
while the short quadratic coefficient has pole at most14.
The non-affine part of $ap$, for a polynomial $p$, is
$y^2\operatorname{rem}(Zp,P)/P$. The gap17 and gap14 coefficients
are the fixed forms
\[
L_9=(16,5),\qquad L_8=(18,16)
\]
on $p=1,x$. They use $\beta^2=\beta+3$ and code
$[a+5b]=a+b\beta$. Their determinant is nonzero; specifically
\[
L_9([12],1)=0,\qquad L_8([12],1)=[5]\ne0.
\]
These identities are also direct two-term calculations in the
displayed field. The existing fixed-row verifier records their
coefficients and rank.

Separate the affine part of $a\delta_3$. Its sum with
$\delta_{2,f}$ can initially have pole at most17: a higher leading
pole cannot cancel a remainder of pole at most17 or the short
coefficient of bound14. Affine functions have nongap leading poles,
so this bound falls to16. The gap17 coefficient must therefore
vanish, giving $L_9(\delta_3)=0$. Thus
$\delta_3=c(x+[12])$ for $c\ne0$. Its gap14 remainder coefficient
is nonzero. The affine part now has pole at most14, hence at most13,
and cannot cancel it. Consequently $\delta_2$ has exact pole14.
Only leading poles are used; subleading Laurent terms of affine
functions at gaps are not discarded.

## Critical roots and quadratic values at infinity

The other short critical coefficient bounds are
$\operatorname{pole}\delta_1\le16$ and
$\operatorname{pole}\delta_0\le18$; the relaxed last bound suffices.
After division by $\delta_3$, the monic cubic has quadratic
coefficient of exact pole11, linear coefficient of pole at most13
and constant coefficient of pole at most15. Its Newton polygon
therefore has a unique first segment of length one and root pole11.
The remaining two root poles are at most2. This statement is local
over an algebraic closure of the completed field and allows
fractional valuations and repeated lower roots.

Write $\mu_j=\operatorname{Tr}(u^2W^j/\phi)$ in the short frame.
The exact trace theorem bounds their infinity poles by10,12,14
for $j=0,1,2$; it does not make them affine at cubic branch points.
Its polynomial is
\[
Q=v\rho^2-\delta_3\mu_2-\delta_2\mu_1-\delta_1\mu_0
-(\delta_3\mu_1+\delta_2\mu_0)T-\delta_3\mu_0T^2,
\quad\rho\in\langle1,x,x^2\rangle.
\]
Let $c_1$ be the critical root of pole11. The equation $D(c_1)=0$
gives
\[
\delta_2+\delta_3c_1=-\delta_1/c_1-\delta_0/c_1^2,
\quad
\delta_1+\delta_2c_1+\delta_3c_1^2=-\delta_0/c_1.
\]
Their pole bounds are5 and7 respectively. Evaluate $Q$ in this
grouped form. Its four contributions have pole bounds22,17,17,17,
so $Q(c_1)$ has pole at most22. For a critical root of pole at
most2, the coefficients $Q_0,Q_1,Q_2$ have bounds26,24,13.
Its value therefore has pole at most26. The formal resultant is
$\Lambda=\delta_3^2\prod_iQ(c_i)$, and hence
\[
\operatorname{pole}_O\Lambda\le6+22+26+26=80.
\]

## Affine regularity, parity and nonvanishing

Put $N_j=\operatorname{Tr}(u^2w^j/\phi)$ in the finite frame.
These are affine for $j\le2$: the divisor of $u^2/\phi$ is
$E+5G-10H$, while a finite pole of $w^j$ consumes at most $jG$.
No leading content coefficient is divided. Translation gives
\[
Q_f=-\delta_3N_0T^2-(\delta_3N_1+\delta_{2,f}N_0)T
+v\rho^2-\delta_3N_2-\delta_{2,f}N_1-\delta_{1,f}N_0.
\]
It expands exactly to $Q_s(T-a)$. Thus BOTH $D_f$ and $Q_f$
have affine coefficients, so their translation-invariant formal
resultant $\Lambda$ is affine even at branch points and content zeros.

At every selected finite endpoint the short coefficients satisfy
$D_0\in rR$ and $Q_0\in rR$, by the ordinary contact bounds in
the incidence theorem. Hence their reductions have the common root0.
The formal Sylvester determinant is zero modulo $r$, including
degree drops or a wholly vanishing critical reduction. Therefore
the simple finite zero divisor of $t$ divides $\Lambda$, so
$R_Q=\Lambda/t$ is affine. Its infinity pole is at most $80-9=71$.

Over the algebraic closure of $k(X)$, $U^2=FQ$ at each critical
root. Taking the product and retaining the formal resultant leading
coefficient powers gives
\[
\delta_3^2\operatorname{Res}_{3,5}(D,U)^2
=\operatorname{Res}_{10,3}(F,D)\operatorname{Res}_{3,2}(D,Q).
\]
This is a polynomial identity at degree drops; no distinct-root
formula or division by a finite leading coefficient is needed.
The actual irreducible source gives $\gcd(F,D)=1$, and the m3
coprimality theorem gives $\gcd(D,U)=1$ without assuming D
squarefree. Thus $\Delta,\Theta,\Lambda,R_Q$ are all nonzero.

The established critical section $C=\Delta/t^5$ has even divisor.
Rearranging the identity gives
\[
CR_Q=(\delta_3\Theta/t^3)^2.
\]
Therefore $R_Q$ also has even divisor. Its pole at the unique
infinity point is even, sharpening the bound71 to70. The half-divisor
classes of $C$ and $R_Q$ are inverse, hence equal as two-torsion
classes; neither section need be a function square. Finally its
norm to $\mathbf P^1_x$ is a polynomial with even divisor and
degree at most70, and is therefore a square up to scalar.

This yields a necessary small parity section on an already actual
source. It neither reconstructs the source nor supplies the second
étale map.
