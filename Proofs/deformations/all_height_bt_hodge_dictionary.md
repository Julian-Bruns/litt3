# Proof: repeat the last-digit comparison with the full predecessor fixed

[Statement](../../Theorems/deformations/all_height_bt_hodge_dictionary.md).
Author continuation,21 September2026. The accepted first comparison,
actual local windows and all-height Cartier realization are inputs.
The new point is the predecessor-sensitive calculation at general $N$.
A focused independent
[audit passed](../../Research/audits/ALL_HEIGHT_BT_HODGE_DICTIONARY_AUDIT_2026_09_21.md);
no old certificate is replayed. The audit supplied the explicit
first-nonzero-digit argument below.

## Paired objects and local references

Write $W_m=W(k)/5^m$. The first periodic datum is fixed, including
the actual first Frobenius and Verschiebung arrows and the normalized
finite determinant. For $N=1$ it determines the marked $W_2$ curve.
The [accepted torsor comparison](bt_hodge_obstruction_comparison.md)
constructs the correspondence between its compatible $W_3$ Hodge
solutions and actual marked BT2 groups. It is an object-level map,
not merely an equality of obstruction dimensions or vanishing loci.

Suppose inductively that a compatible periodic Hodge solution through
$W_{N+1}$ is paired with an actual BT$_N$, denoted $A_N$. Work on
affine etale opens. A smooth next curve lift exists, and the Hodge
line lifts locally because its obstruction is a coherent $H^1$ on
an affine. Its maximal graded Higgs identification is restored using
the determinant and a square root congruent to the preceding scalar.
The specified prime-to-five flat twist has its unique compatible lift.
Iterating on these affine opens supplies local full periodic
completions, with their strongly divisible windows and actual local
full groups. Their first $N$ truncations identify with $A_N$ by the
inductively constructed correspondence. No global full completion is
assumed.

Two local next-Hodge references differ by the last normal line
variation in $F_*T_C$, modulo the change $\mu(T_C)$ made by the last
marked curve identification. This is the same sheaf as at the first
step: all last-digit coefficients are in the square-zero ideal
$5^N/5^{N+1}$ and their formulas use the fixed mod-five reduction.
The given predecessor is retained throughout; no preceding line or
graded identification is changed. Local full completion maps these
references to actual BT$_{N+1}$ references above $A_N$.

## The divided predecessor comparison

On an ordinary splitting cover choose the SAME absolute Frobenius
lift $\sigma$ for two paired references. In the normalized ordinary
frame write
\[
\nabla e_0=0,\qquad \nabla e_1=e_0\,d\log Q,\qquad
\Phi_1(e_1)=e_1+\ell_Qe_0,
\quad \ell_Q=\frac15\log\frac{\sigma(Q)}{Q^5}.
\tag{2}
\]
The marked equality through BT$_N$ gives characteristic-five Kummer
parameters $q_j=q_i a^{5^N}$. The potentially different mixed lifts
initially give only
\[
R_{ij}:=Q_j/(Q_i\widetilde a^{\,5^N})\in1+5\mathcal O
\pmod{5^{N+1}}.
\tag{3}
\]
The same matched-ordinary-frame construction as in the accepted first
comparison is used. The ENTIRE paired predecessor identifies the
normalized ordinary frames and their divided maps modulo $5^N$.
This is a condition on the preceding Fontaine datum, not a consequence
of an abstract BT$_N$ marking alone. We now remove the lower mixed
digits explicitly rather than assuming that they have vanished.

If $R_{ij}\ne1$ at the required precision, let $1\le r\le N$
be its first nonzero digit, and write
$R_{ij}=1+5^r\widetilde B\pmod{5^{r+1}}$, with $B\ne0$ modulo five.
Its contribution to the divided logarithm in (2) is
\[
\ell_{Q_j}-\ell_{Q_i}
\equiv5^{r-1}B^5\pmod{5^r}.
\tag{4}
\]
Indeed the other factor $\widetilde a^{5^N}$ contributes
$5^{N-1}\log(\sigma(\widetilde a)/\widetilde a^5)$,
which is divisible by $5^N$ and hence invisible modulo $5^r$.
The numerator involving $R_{ij}$ contributes
$5^{r-1}\sigma(\widetilde B)$, while its denominator contributes
$-5^r\widetilde B$. Every further logarithmic term vanishes modulo
$5^r$, also for $r=1$. The preceding divided maps agree modulo
$5^N$, so (4) forces $B^5=0$ on the reduced overlap. This contradicts
the choice of the first nonzero digit. Equivalently one can eliminate
the digits successively for $r=1,\ldots,N$. Thus
\[
Q_j=Q_i\widetilde a^{\,5^N}\pmod{5^{N+1}}.
\tag{5}
\]
This argument retains the Witt automorphism on coefficients and the
relative Frobenius twists. It does not use fifth powering as a
substitute for $\sigma$ over a mixed-characteristic ring.

## The two last-digit variations

Put $d\log Q_i=w_i\,du$ and
$c=d\log a/d\log q_i$. Equation (5) gives
$w_j=w_i(1+5^N\widetilde c)\pmod{5^{N+1}}$.
For the projective potential
\[
R(w)=\frac34(w'/w)^2-\frac12w''/w,
\]
its last divided variation is
\[
\frac{R(w_j)-R(w_i)}{5^N}
=-\frac12\bigl(c''-(w'/w)c'\bigr)
=\frac12\mathscr D_H(c^5-c)
\pmod5.
\tag{6}
\]
Quadratic last-digit changes vanish modulo $5^{N+1}$ since
$2N\ge N+1$. All dependence on the earlier digits remains in the
references; reducing the linear response uses the same $w\bmod5$.
The [actual all-height difference classification](versal_bt_cartier_realization.md)
identifies $c^5-c$ with $\Delta_N(A_i,A_j)$.

A last Hodge change $f\partial_u$ has normalized generator
\[
e\longmapsto(1-5^Nf'/2)e+5^Nf e'
\pmod{5^{N+1}}.
\]
Using the preceding scalar equation and dividing its potential change
by $5^N$ gives the SAME mod-five third-order operator
\[
\mathfrak b_r(f\partial_u)
=(2rf'+r'f-\tfrac12f''')(du)^2.
\]
Combining with (6), the actual overlap cocycles satisfy
\[
\mathscr D_H\Delta_N(A_i,A_j)
=2\mathfrak b_r(f_{ij}\partial_u).
\tag{7}
\]
Both sides are regular sections of the same bundle over the entire
overlap. The higher references are already integral, and the actual
Cartier realization supplies the regular Hessian of the left side.
Equality on the dense ordinary locus therefore extends across the
supersingular points. No generic group isomorphism is being invented
or extended in this step.

## Torsors, effectivity and truncation

The accepted sheaf isomorphisms
$F_*T/\mu(T)\simeq\mathcal N_r$ and
$\mathcal B_H\simeq\mathcal N_r$ depend only on the first reduction.
Equation (7) identifies the next local torsors equivariantly by
$2\mathscr D_H^{-1}\overline{\mathfrak b}_r$.
Local choices of full completion produce the same next object up to
the unique normalized comparison: if their next Hodge difference is
zero, equation (7) makes the actual next group difference zero.

Exactly as at the accepted first step, a global Hodge solution then
glues actual local BT$_{N+1}$ groups by their unique marked normalized
isomorphisms. Finite locally free Hopf algebras descend, as do $F,V$
and the marking by $A_N$. Conversely, a global BT$_{N+1}$ translates
each paired local Hodge reference by
$\tfrac12\overline{\mathfrak b}_r^{-1}\mathscr D_H\Delta_N$.
These translated references glue modulo the last curve automorphisms
represented by $\mu(T)$. Neither translation changes the predecessor.

The construction is thus inductive and respects truncation. It is
etale-functorial because every ingredient, including the actual
group difference and the divided crystalline Taylor comparison, is.
Applying it to all truncations of a supplied full group gives a
compatible full Hodge tower. A supplied compatible full Hodge tower
gives compatible finite groups; their inclusions and multiplication
maps descend along with their Hopf algebras and define a full group.
This latter direction also follows from the already checked
[full periodic effectivity construction](explicit_full_bt_nonuniqueness.md).

For the full-group-to-tower direction independently, the full versal
group has its canonical marked mixed-characteristic pair lift by
[Xia, Theorem1.2](https://arxiv.org/pdf/1303.2954). Its Hodge filtration
and integral divided Frobenius give the strongly divisible periodic
object. That supplies every higher comparison while retaining the
special-fiber first marking. No such conclusion is drawn from Xia's
truncated existence theorem alone.

Finally BT$_N$ corresponds to length $N+1$ on the curve side. The
extra digit forms the divided inverse-Cartier comparison; it does
not change the group level. This proves the stated finite-height
translation and does not assert that any of those finite fibers
is nonempty.
