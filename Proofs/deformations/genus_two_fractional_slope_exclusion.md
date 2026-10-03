# Proof: every active source is an oper, and a full oper cycle is ordinary

[Statement](../../Theorems/deformations/genus_two_fractional_slope_exclusion.md).
Use absolute Frobenius notation; the relative formulation carries all
coefficient twists. The dormant two-torsion vanishing is invariant
under those twists.

## Two different opers and a complete oper cycle

The obstruction extends to a Frobenius step between two oper
reductions $H_-$ and $H_+$, not necessarily equal. Let their
determinants be $D_-,D_+$, and normalize the integral step to be
nonzero modulo $\pi$. Its determinant divided by its uniformizer
valuation identifies $D_+$, with connection, with the canonical
Frobenius pullback of $D_-$. Write their Hodge lines as
$\vartheta N_-$ and $\vartheta N_+$.

Suppose $H_+$ were dormant. The square root of its determinant
connection descends to a line $N'_+$ with $(N'_+)^2=D_-$ and
$F_C^*N'_+=N_+$. One can obtain it explicitly by comparing
$N_+$ with $F_C^*N_-$: their ratio is two-torsion, whose
Frobenius pullback is itself. Thus $N'_+/N_-$ is two-torsion.
The target's Cartier descent is
$\mathcal V\vartheta^{-1}N'_+$. A nonzero horizontal map
$F_C^*H_-\to H_+$ descends to a nonzero map
$H_-\to\mathcal V\vartheta^{-1}N'_+$.
The target is stable of degree zero, so this map kills the
degree-one line of $H_-$. Factoring through its quotient gives
\[
H^0(\mathcal V\otimes N'_+N_-^{-1})\ne0,
\]
again contradicting (1). Therefore the target cannot be dormant.

For completeness, the normalized integral Frobenius step has
elementary divisors $(1,\pi^b)$ everywhere for some $b>0$.
Its reduction cannot have generic rank two: it would identify
$F_C^*H_-$ with $H_+$, whose maximal line degrees are respectively
five and one. Its rank-one image is horizontal; its saturation
$I$ is therefore different from the oper line in $H_+$ and
has degree at most minus one. The map kills $F_C^*L_-$ and
factors through the degree-minus-five Cartier line
$F_C^*(H_-/L_-)$. Its defect divisor has degree at most four
and is five-divisible, since it is a horizontal map between
Cartier lines. The defect vanishes. This proves the everywhere
elementary-divisor assertion.

For the stated cyclic conclusion use the additional Dieudonné
hypothesis. Dividing an integral Frobenius matrix by its common
uniformizer factor preserves integrality of both $F$ and
$pF^{-1}$, so its primitive normalization still has $b\le e$.
The actual Hodge filtration supplies the source line modulo $\pi^b$,
by the [whole-kernel construction](ramified_rapoport_oper.md#the-whole-outgoing-kernel-at-every-positive-height).
A source
basis adapted to that line gives the target basis
$F(e)/\pi^b,F(v)$. If $b<e$, its connection coefficients have
factors $p/\pi^b$ or $p$ and vanish modulo $\pi$. This would make
the target dormant, just excluded. Hence $b=e$.

Apply this to every normalized step of a complete oper cycle.
Each has elementary divisors $(1,p)$. Its reduced image is a
negative line, while the kernel of the following step is the
Frobenius pullback of a positive line. The cycle is consequently
nonzero on its generic rank-one image modulo $\pi$. It has a
unit-root direction and determinant slope one per step, proving
the ordinary conclusion. No assertion that the required complete
oper cycle exists has entered the argument.

## Every residue degree has an endpoint gap bound

The [general lattice theorem](ramified_rapoport_oper.md) supplies a
primitive Dieudonné cycle whose EVERY positive-height source is an
oper. Write m for its number of positive edges, d_i for the heights,
and b=\(\sum d_i\). If m=f, the complete-cycle criterion above forces
every d_i=e, so the normalized generic gap is one.

For a fractional gap, therefore,
\[
m\le f-1,\qquad b\le em\le e(f-1),\qquad
\delta=\frac b{ef}\le1-\frac1f.
\]
No determinant triviality entered this argument. For f=1 it recovers
the original exclusion of every gap strictly between zero and one.

## The residue-one determinant witness remains explicit

In a would-be fractional f=1 lattice, the general residue-one
construction makes H dormant. The normalized determinant map gives
\(F_C^*D\cong D\),
so D^4 is trivial. In the two-oper argument take H_-=H_+=H and
write its Hodge line as \(\vartheta N\), N²=D. Thus N^8 is trivial.
Its canonical dormant connection descends to N^5, since25=1 mod8.
The exact forbidden twist there is \(N^5N^{-1}=N^4=D^2\).
Hence the original witness \(H^0(\mathcal V\otimes D^2)\ne0\)
and its two-torsion determinant remain useful special data.

## The actual two-component normal form

For f=2 and a fractional gap, the endpoint bound gives b<=e.
The terminal lattice has one positive edge: zero is impossible,
while two would be a full oper cycle and ordinary. Up to cyclic
labeling its heights are (0,b). The unique active source is an
oper over the WHOLE precision pi^b. The ordinary case b=2e instead
has heights (e,e) and whole precision pi^e. The formerly unexcluded
rows e<b<2e are now impossible; these are conditional lattice
normal forms, not existence assertions.

## An actual coreless comparison gives a uniform half-gap bound

If the coefficient is common across an ACTUAL coreless span with
every Frobenius arrow compatible on the SAME source, the general
common-divisor theorem additionally gives m divides f.
A fractional gap forces m<f, so m<=f/2 and
\[
\delta\le m/f\le1/2.
\]
This uses both original finite étale maps. It is stronger than the
endpoint bound for large f and gives no endpoint-only half-gap claim.

## Applying the established family vanishing

The [active critical-quartic theorem](../projective_connections/genus_two_active_critical_quartics.md)
proves the stated two-torsion dormant Bol vanishing on the
parameter-degree-greater-than-six family and the cubic backup,
including the trivial character. Both selected endpoints therefore
satisfy the hypothesis. The ordinary gap-one case remains allowed.
No common coefficient is constructed by these exclusions.
