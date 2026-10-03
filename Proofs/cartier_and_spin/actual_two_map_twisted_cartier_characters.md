# Proof: the universal two-character restriction

Version1,2 October2026. The genuinely new implication received a
[bounded independent PASS](../../Research/experiments/oct02_global_extraction/TWISTED_CARTIER_FOCUSED_REVIEW.md).
It applies to the same-q sector of the
[actual reciprocal theorem](../../Theorems/cartier_and_spin/actual_two_map_reciprocal_trace.md).
The settled all-six non-eigenline input is in
[family specialization](../jacobians/torsion/family_small_torsion_specialization.md), including
the [backup arithmetic](../curve_arithmetic/backup_curve_arithmetic.md).

## Whole-space twisted Cartier vanishing

The Cartier-fixed/logarithmic dictionary supplies a rational $\ell$
with $d\log\ell=-\beta$. Since
$d\log(u\phi/q^*\ell)=0$, the p-basis kernel of d gives
$u\phi=q^*\ell\,z^5$ for a rational $z\ne0$ on the ORIGINAL source.
Consequently
\[
d(\phi^2/z^5)=2\phi h^*df/z^5=q^*(\ell\eta).
\]
Cartier commutes with separable pullback, and pullback of differentials
is injective. Hence $C(\ell\eta)=0$. Also
$\ell\beta=-d\ell$ is exact. The double-zero $\eta$ is not an
eigenform on any smooth member, whereas $C\beta=\beta\ne0$.
Thus $\eta,\beta$ span $H^0(Y_S,\omega)$ and twisted Cartier
annihilates that ENTIRE space. No descent through h was used or obtained.

## Two coefficients exhaust the universal possibilities

Put $F=(x^4-1)(x-S)$ and write $\beta=(c+dx)dx/V$, where c,d
are scalars. For $g=\ell/V$ one has
$g'/g=-(c+dx)/V-F'/(2F)$. With this logarithmic derivative tau,
set $N_0=1$, $N_{n+1}=N_n'+\tau N_n$. The p-basis formula in
characteristic five identifies $C(gdx)=0$ with $g^{(4)}=0$, so
$N_4=0$. Write $N_n=(X_n+Y_nV)/F^n$. Rational differentiation
gives the polynomial recurrence
\[
X_{n+1}=FX_n'+(-n-3)F'X_n-(c+dx)FY_n,
\]
\[
Y_{n+1}=FY_n'-nF'Y_n-(c+dx)X_n,
\]
with $X_0=1,Y_0=0$. Since the curve is smooth, F is not a square
in k(x), so $N_4=0$ forces BOTH fourth-step polynomials to vanish.
Two coefficients are
\[
[x^{15}]X_4=2S+3d^2,\qquad
[x^{11}]Y_4=3cd^2+3dS^2+2d^3S.
\]
The first implies $d^2=S$; the second then becomes $3cS=0$.
Smoothness gives $S\ne0$, hence $c=0$. This is exhaustive over k
and independent of source degree.

The [short exact source](../../scripts/oct02_reciprocal_twisted_cartier.sage)
checks the recurrence coefficients and reduction of the full X4,Y4
modulo $(c,d^2-S)$. Its
[exact certificate](../../../litt3-computation-data/oct02_reciprocal_twisted_cartier/certificate.json)
records Sage10.9 and 0.056 seconds of one-core algebra. It also checks
the universal functions next; no endpoint parameter is specialized.

## Universal realization of the two endpoint characters

For $s^2=-S$ the stated h_s and Q functions satisfy, by exact rational
differentiation and the curve equation,
\[
h_sh_{-s}=4(x^5-S)^2,\quad d\log h_s=sx\eta_0,\quad
dQ_{s,O}=h_s^2\eta_0,\quad dQ_{s,x}=xh_s^2\eta_0.
\]
These are the formulas of the
[backup census](backup_lagrangian_degree_one_census.md), now verified
universally rather than using the backup parameter relation.
With $\ell=h_s^2$, its logarithmic form is $\beta=-2sx\eta_0$;
the scalar squares to S. Both signs are regular Cartier-fixed, since
they are logarithmic differentials.

The unique $x_0^5=S$ is nonzero and not a branch value: $x_0^4=1$
would force $S^4=1$. At either point over x0, the nonzero coefficient
$sx_0^2$ implies h_s and h_(-s) cannot vanish together. Their norm
forces a zero of order ten at exactly one point; h_s has pole ten at
infinity. Thus its divisor is $10(P_s-O_Y)$. It is not a fifth power,
by its nonzero logarithmic derivative, giving a nontrivial character.
The norm shows the opposite characters are inverse modulo fifth powers.

## Normal form on the original source

For the fixed actual eta, the stated Q satisfies $dQ=h_s^2\eta$.
Repeating the exactness identity with $\ell=h_s^2$ gives
$u\phi=q^*\ell z^5$ and
$\phi^2/z^5=q^*Q+a_0^5$. Put $B=q^*Q+a_0^5$ and $A=\phi/z^2$.
Then $A^2=zB$, which yields the two normal-form expressions.
Conversely, differentiation of those expressions gives
$2d\phi/u=q^*\eta$ and
$-d\log(u\phi)=-d\log q^*\ell=q^*\beta$ exactly.

Writing $L=(A/B)^5$ and $C=a_0^5$ gives
$\phi=L((q^*Q)^3+3C(q^*Q)^2+3C^2q^*Q+C^3)$.
Since q is separable and $dQ\ne0$, qQ is a p-basis of k(T).
As $\phi-h^*f=b^5$, uniqueness of the p-basis expansion proves
the cubic coefficient constraint. Finally B=\ell\phi/u gives its
divisor; dividing $\phi B^2=A^5$ by five gives the divisor of A.
All functions and divisors remain on the original actual source.
