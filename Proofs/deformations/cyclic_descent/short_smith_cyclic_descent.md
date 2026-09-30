# Proof: preserve the actual curve coordinate and equalize the short rows

[Statement](../../../Theorems/deformations/cyclic_descent/short_smith_cyclic_descent.md).
21 September2026. The new geometric combination and its applications
passed the [focused audit](../../../Research/audits/SHORT_SMITH_CYCLIC_DESCENT_AUDIT_2026_09_21.md).

## The actual comparison chart

Use the regular equivariant chart and weighted implicit elimination
of [cyclic power descent, Sections1--5](cyclic_power_descent.md),
together with the arbitrary-rank left-right Smith normalization in
[neutral descent, Sections1--2](../neutral_galois_witt_descent.md).
The former supplies the all-precision divided Taylor and scalar
feedback bounds; the latter explicitly keeps arbitrary nonunit
curve coordinates under separate source and target changes.

On the special fiber, put $R=k[e]/(e^{5^a})$. Separate $R$-linear
source and target matrices put the linearized map in the form
\[
P\Psi Q=\operatorname{diag}(I,e^{h_1},\ldots,e^{h_s})\Phi,
\qquad h_i\in\{1,2\}.
\]
These matrices lift invertibly to the integral group ring by
Nakayama. This is left-right equivalence, not semilinear conjugacy.
It changes the actual cohomology coordinates invertibly and does not
replace the given curve by a different repair. The one indicated
coefficient Frobenius is transported into the source.

The norm constant remains an actual lower class. Indeed, for every
integral group-ring matrix $P$ and coefficient vector $v$,
\[
P(Nv)=N\operatorname{aug}(P)v.
\]
If $P$ is invertible, its augmentation is invertible. Thus the changed
invariant source and target bases are precisely invertibly changed
LOWER bases. This does not identify a lower obstruction merely from
its potentially zero image in the upper cokernel.

Only the unit cohomology blocks and the invertible boundary and scalar
auxiliary blocks are eliminated. All nonunit curve coordinates of
the GIVEN combined displacement remain. The accepted integral
substitution bounds are vector-valued and permit cross terms, so no
componentwise assumption is needed. At zero nonunit coordinate the
unique auxiliary solution is invariant; the fixed-subfunctor
identification gives actual lower data and their actual normal error.

Set $m=n-1$, $O=W_{a+1}(k)$ and
$M=\operatorname{Fun}(C_{5^a},O^s)$. The surviving equation is
\[
Lx=N\eta+
\sum_{d=2}^{1+\lfloor a/m\rfloor}5^{m(d-1)}Q_d(x),
\qquad
L\bmod5=\operatorname{diag}(e^{h_1},\ldots,e^{h_s}).
\tag{1}
\]
Each $Q_d$ is deck-equivariant and has an integral $d$-additive
presentation. The norm constant is the actual lower normal error
after unit-block repair. At $n=2$, use frames through the supplied
compatible $C_3^0$; this gives $\eta\in5O^s$. For $n\ge3$ the
constant is arbitrary. These are exactly the geometric chart
conclusions established in the cited proofs before their respective
final algebraic arguments.

## A necessary equal-exponent equation

Multiply the target of (1) by
\[
D=\operatorname{diag}(e^{2-h_i}).
\]
This operator need not be invertible. We use only the necessary
equation satisfied by an actual solution. Since $eN=0$ in the
INTEGRAL group ring, that equation has norm constant $N\eta'$, where
$\eta'_i=\eta_i$ for a length-two row and $\eta'_i=0$ for a
length-one row. Its linear part has reduction $e^2I_s$; its higher
maps $DQ_d$ retain equivariance, additive presentations and weights.

The [coefficient-module absorption theorem](cyclic_power_nonlinear_absorption.md)
applies with $p=5,h=2$ and coefficient module $O^s$. For $n\ge3$,
$m\ge2$ permits arbitrary norm constant. For $n=2$, $m=1$ and
$\eta'\in5O^s$ give precisely its accepted exceptional clause.
Every actual solution therefore satisfies
\[
\overline x\in N k^s.
\tag{2}
\]
Return to ORIGINAL equation (1) modulo5. Every $e^{h_i}$ kills (2)
and the nonlinear terms vanish. Hence $N\overline\eta=0$ in the
free regular target, so $\overline\eta=0$ in every component.
Here $v\mapsto Nv$ from $k^s$ into $k[C_{5^a}]^s$ is injective;
the augmentation of $N$ is zero, but its invariant vector is not.
This recovers the short-row constants erased by multiplication by
$D$. No converse or equality of residual cokernels is asserted.

## Recovering the prescribed lower tuple

The leading unit coordinate relative to the auxiliary reference is
zero, since displacement-dependent corrections have positive
five-adic weight. The leading nonunit coordinates are invariant by
(2). Their lower preimages lie in the lower kernel: the nonunit
Smith entries have zero augmentation. The lower normal class is zero
by the original equation, so modifying the actual lower reference by
this kernel digit gives a compatible lower tuple.

Lift the ORIGINAL etale map over that tuple. Its marked source is
the GIVEN $T_{n+1}$. Negative tangent $H^0$, uniqueness of the
compatible Hodge line and marked projective grading, and the
prescribed flat periodicity line identify all the preceding data
with their pullbacks. These are the recovery steps in Sections6--7
of the accepted cyclic proof; they depend on invariant coordinates
and the actual lower error, not on nil rank one.

For a supplied full upper tower, first use the compatible $C_3^0$
and a long enough upper truncation to recover its given third digit.
Then apply the finite result successively. Marked uniqueness makes
the descents a compatible inverse system, to which the accepted
algebraization and [actual dictionary](../all_height_bt_hodge_dictionary.md)
apply. The supplied upper full group itself descends.

## Focused verification

The standard-library script
[verify_short_smith_descent.py](../../../scripts/deformations/cyclic/verify_short_smith_descent.py)
tests mixed blocks modulo25 with off-diagonal additive corrections
and equivariant quadratic terms. Its
[receipt](../../../../litt3-computation-data/bt_obstruction_transport_20260921/short_smith_algebra.json)
records80 random systems, seed20260921: all125 leading solutions
were tested in each case, and exactly the25 invariant leading vectors
lifted when the lower reference was compatible. The script also
finds a noninvariant lift when that hypothesis is removed. This
bounded algebra check supplements the audited actual-chart argument;
it is not the geometric proof.
