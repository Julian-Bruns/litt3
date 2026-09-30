# Proof: the Frobenius image supplies a forbidden dormant section

[Statement](../../Theorems/deformations/genus_two_fractional_slope_exclusion.md).
Use absolute Frobenius in the intrinsic argument. Equivalently one
may use relative Frobenius and carry the indicated bundles to its
twisted target throughout. In particular no $k$-linear identification
of $C$ with $C^{(1)}$ is assumed. The vanishing hypothesis is preserved
by the coefficient Frobenius twists that implement this convention.

## The actual lattice and its reduced Frobenius map

Suppose an isocrystal as in (2) exists. The residue-degree1 construction
in [the ramified coefficient proof](ramified_rapoport_oper.md)
gives a coefficient lattice $\mathcal H$, an actual oper line over
$A/\pi^a$, and Frobenius elementary divisors $(1,\pi^a)$ everywhere.
Let $H=\mathcal H/\pi$ and let $L\subset H$ be its reduced line.
Then
\[
\deg H=0,\quad \deg L=1,\quad
L\xrightarrow{\sim}(H/L)\otimes\omega_C.
\tag{4}
\]
Since $a<e$, the same construction proves that $H$ is dormant.
Locally, a basis adapted to the actual line modulo $\pi^a$ gives
the basis $F(e_0)/\pi^a,F(b_0)$ of $\mathcal H$. The connection
coefficients in this basis have factors $p/\pi^a$ or $p$, hence
vanish modulo $\pi$. This proves dormancy, rather than assuming
it from the Newton polygon.

The reduced Frobenius is a nonzero horizontal rank-one map
\[
\overline F:F_C^*H\longrightarrow H,
\qquad \ker\overline F=F_C^*L.
\tag{5}
\]
It has no torsion defect in its image. In fact the argument below
only needs its nonzero factor through $F_C^*(H/L)$.
Writing $D=\det H$, the integral determinant divided by $\pi^a$
is a unit isomorphism of rank-one crystals. Its reduction gives
\[
F_C^*D\simeq D,
\qquad D^4\simeq\mathcal O_C.
\tag{6}
\]
This also identifies the Cartier descent of the determinant connection
with the bundle $D$ itself. It is stronger than its degree being zero.

## Normalize the determinant without losing its twist

Choose a theta characteristic $\vartheta$ on $C$ and put
$N=L\vartheta^{-1}$. Equation(4) implies
\[
N^2=D,\qquad N^8=\mathcal O_C.
\tag{7}
\]
Since this torsion is prime to five, give $N$ its canonical dormant
connection. Its Cartier descent is $N^5$: indeed $(N^5)^5=N$ and
$(N^5)^2=D$. By (6), the square of this connection is exactly the
determinant connection of $H$.

Thus $H\otimes N^{-1}$ is a normalized determinant-trivial dormant
oper with Hodge line $\vartheta$. Let $B$ be its Cartier descent.
By the definition of the associated canonical-determinant bundle,
\[
B=\mathcal V\otimes\vartheta^{-1},
\qquad \det\mathcal V=\omega_C.
\tag{8}
\]
Here (8) is read on the Cartier target, with the absolute-Frobenius
convention specified above. The Cartier descent of $H$ is therefore
$\mathcal V\vartheta^{-1}N^5$.

Apply Cartier descent to the nonzero horizontal map in (5), after
factoring through $F_C^*(H/L)$. Its source descends to
$H/L=\vartheta^{-1}N$. It gives an actual nonzero morphism
\[
\vartheta^{-1}N\longrightarrow
\mathcal V\vartheta^{-1}N^5.
\tag{9}
\]
Equivalently,
\[
H^0(C,\mathcal V\otimes N^4)\ne0.
\tag{10}
\]
But $N^4=D^2$ is two-torsion. This contradicts (1).
The argument permits nontrivial determinant throughout; replacing
it by a trivial line prematurely would lose this essential twist.

## Applying the established endpoint calculation

The [active critical-quartic theorem](../projective_connections/genus_two_active_critical_quartics.md)
proves, for the parameter-degree-greater-than-six family and the
cubic backup, that every dormant connection remains reduced on
every connected étale double. Splitting its tangent space into
the two character summands gives precisely (1), including the
trivial character. The identification with the rank-two Bol
Cartier-descent bundles is the fixed dormant convention used in
those proofs. Hence both selected endpoints satisfy the hypothesis.

This argument does not handle a cycle of distinct coefficient
components by pretending it has residue degree one. In a longer
cycle, a Frobenius step may start from a different bundle, and
zero-Hodge steps may carry higher Frobenius pullbacks of an oper.
The source line in (9) is then not automatically the degree-minus-one
line used here. No exclusion for all higher-residue-degree gaps,
or existence of any common coefficient, follows from this proof.

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
The actual Hodge filtration then supplies the source line modulo
$\pi^b$, as in the partial Hodge construction above. A source
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

## The ordered normal form for two components

The [arbitrary-cycle construction](ramified_rapoport_oper.md) first
produces an oper component, say $i$, without changing the rational
object. For $b<2e$ the other component cannot be an oper, by the
two-oper step result just proved. Whenever $d_i>0$ and $d_{i-1}<e$,
its positive kernel line is therefore horizontal. Enlarge that
component by the actual operation(G7) of that proof. Both $F,V$
remain integral, the oper component is fixed, and the heights
change by $(d_i,d_{i-1})\mapsto(d_i-1,d_{i-1}+1)$.
Iteration gives
\[
(d_i,d_{i-1})=(\max(b-e,0),\min(b,e)).
\]
Its outgoing edge is now the maximum. The zero-defect and actual
Hodge-kernel construction in the cited proof gives the full line
to precision $n=\min(b,e)$. For $b=2e$ the ordinary construction
gives $(e,e)$ and $n=e$. The returned Pro half-slope theorem is
the case $b=e$.
