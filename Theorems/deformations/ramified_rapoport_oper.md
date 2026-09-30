# Ramified rank-two coefficients on genus-two curves

Version5,20 September2026. Let $k$ be algebraically closed of
characteristic $p>2$, let $C/k$ have genus two, and let
$K/\mathbf Q_p$ have ramification index $e$ and residue degree $f$.
Let $G/C$ be a full $\mathcal O_K$-linear $p$-divisible group of
height $2ef$ and rational coefficient rank two. Suppose its Newton
polygon is nonconstant, with generic coefficient slopes
\[
(0,b/(ef)),\qquad 1\le b\le ef.
\]
No Hodge-freeness condition, ordinariness of $C$, or dormant-vanishing
hypothesis is required.

## An actual oper with sufficient thickness

There is an $\mathcal O_K$-linear Dieudonné lattice in the same
isogeny class, an index $i$, and an integer $1\le s\le e$ such that:

- Its reduced component $H_i$ is an oper with line of degree one.
- The outgoing map $F_{i+1}:F^*\mathcal H_i\to\mathcal H_{i+1}$
  has elementary divisors $(1,\pi^s)$ at every point.
- Every Frobenius step of this SAME lattice has height at most $s$.
- The actual outgoing kernel gives an oper line $L_s$ on the WHOLE
  constant thickening $C\times\operatorname{Spec}(A_i/\pi^s)$.

Here $A_i$ is the coefficient DVR for the indicated unramified
embedding; relative Frobenius twists and the coefficient action
are retained. In particular
\[
L_s\xrightarrow{\sim}(\mathcal H_i/\pi^s\,/L_s)\otimes\omega_C.
\]
If $d_j$ are the determinant valuations of the final steps, one
can take $s=\max_j d_j=d_{i+1}$, so $\lceil b/f\rceil\le s\le e$.
The sufficient Frobenius Taylor inequality is automatic:
$(p-1)s>s$. This does not assume divided powers on $(\pi^s)$.

The new operation enlarges a nonoper component along its positive
horizontal kernel line. It transfers one unit of height from its
outgoing edge to its incoming edge while preserving both $F$ and
$V$. Protecting an oper makes the resulting process finite.

## Consequence for the two actual maps

Suppose an actual finite bi-étale span $X\leftarrow Z\to Y$, with
$g(Y)=2$, carries rationally compatible rank-two $K$-coefficient
$F$-isocrystals. If the one on $Y$ has nonconstant Newton polygon
and generic slopes $(0,\delta)$ with $0<\delta\le1$, the ORIGINAL
span lifts simultaneously over a complete mixed-characteristic DVR.

An integral model need not be supplied: the coefficient-preserving
Dieudonné lattice construction on the smooth curve supplies it.
Only the genus-two endpoint lattice is needed; oper rigidity
descends it through the other actual map. Compatibility on a
connected finite étale refinement of the source also suffices.

For the selected main pair such common coefficient data is therefore
impossible at EVERY coefficient place. For the backup it forces
the still-open fully liftable branch. A common coefficient is not
constructed from a bare span.

## Useful sharper cases

In the generically ordinary case, the isogeny class contains a model
whose Hodge modules are free rank one over every $A_i/p$, ALL reduced
Hodge lines have degree one, and ALL whole modulo-$p$ second
fundamental forms are isomorphisms.

At residue degree one, for gap $a/e$, one can take $s=a$ and
elementary divisors $(1,\pi^a)$ everywhere. If $a<e$, the resulting
oper reduction is dormant. This additional endpoint fact is used
by the separate fractional-slope exclusion.

The older free-Hodge construction remains useful when a whole
modulo-$p$ oper is wanted: intrinsic Frobenius untwisting supplies
one. Freeness is no longer a hypothesis of the lifting theorem.

## Degree fact used throughout

A positive line of degree $d$ in a degree-zero rank-two reduction
with nilpotent $p$-curvature is either horizontal, with $p\mid d$,
or has nonzero second fundamental form and $d\le g(C)-1$.
In genus two the latter is an oper of degree one. A nonzero form
over a constant coefficient thickening cannot be supported only
in its nilpotent directions when $0<g(C)-1<p$.

The two-component height transfer was returned by Pro. The
finite transfer argument for arbitrary component cycles, including
zero-height steps, is an author extension. It removes all remaining
residue-degree and ramification restrictions on the stated lifting
criterion. It does not settle the common-cover problem.
[Proof](../../Proofs/deformations/ramified_rapoport_oper.md).
