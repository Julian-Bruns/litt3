# A noncommutative augmentation-width bound for actual defect

[Statement](../../../Theorems/deformations/section_growth/augmentation_width_defect.md).

## 1. Actual one-relation presentation and quotients

Use etale_p_witt_obstruction: the linearized actual Hodge operator is
an R-linear map between free modules of equal rank3(g(C)-1), reducing
under augmentation to the actual base operator. Its constant matrix
has corank one. Noncommutative block elimination of its invertible
(r-1)-block gives a scalar Schur entry f in J and cokernel R/(R f).
For left free modules the scalar map is right multiplication by f.

This presentation specializes to every ACTUAL group quotient. If
K is normal in P, the norm N_K identifies the coinvariants of a free
R-module with its K-invariants. On negative curve cohomology the latter
are exactly H1(T/K,T_(T/K)) by Cartan--Leray. Naturality intertwines
the linearized Hodge maps. Therefore tensoring the presentation by
k[P/K] gives the actual defect presentation on T/K. In particular its
scalar entry is the image of f. Frobenius linearization fixes the group
basis and retains the source/target coefficient twist.

## 2. The linear term vanishes geometrically

The actual active tangent bundle has a perfect omega-valued alternating
pairing and one section. The later [symplectic section-growth theorem](cyclic_symplectic_blocks.md),
Part1, therefore gives at least two sections on every nontrivial
cyclic-five intermediate. A nonzero linear term of $f$ on such a
quotient would give a length-one cokernel, a contradiction.

Characters $P\to C_5$ separate $J/J^2\simeq
k\otimes_{\mathbf F_5}P/\Phi(P)$. Testing their coordinate
characters therefore forces $f\in J^2$.

## 3. One bound for every augmentation order

Let $A:R^s\to R^s$ have entries in $J^\nu$. Since $J$ is
two-sided, $A((J^i)^s)\subset(J^{i+\nu})^s$, even for right
multiplication in the left-module convention of Section1. Hence
\[
\operatorname{rank}_k A
\le s\dim(R/J^i)+s\dim J^{i+\nu},
\qquad
\dim_k\operatorname{coker}A\ge
s(\dim J^i-\dim J^{i+\nu}).
\]
Maximize over $i$. The scalar geometric case is $s=1,\nu=2$.
Further etale pullback is injective on the actual defect sections.

## 4. Use Jennings's radical layers

The ordered radical basis of
[Jennings, Theorem3.2](https://doi.org/10.2307/1989916),
also stated in [Sakurai, Theorem3.5](https://arxiv.org/pdf/1701.03799),
gives the displayed Hilbert polynomial. This replaces a separate
group-algebra basis and radical-power computation.

For the exponent-$p$ Heisenberg group, $p$ odd, the dimension
subgroups are $P,D_2=Z(P),D_3=1$; see Sakurai, Section6.1.
Thus its polynomial is $A_p(t)^2A_p(t^2)$, where
$A_n(t)=1+\cdots+t^{n-1}$. Multiplication by $1+t$ gives
$A_p(t)^2A_{2p}(t)$. Each coefficient is a window sum of the
nonnegative coefficients of $A_p^2$; a central window includes
all of them. Its maximum is $p^2$, proving the bound25 at five.

For $(C_q)^r$ the polynomial is $A_q(t)^r$. In ranks one and two
the adjacent maxima are $2$ and $2q-1$. In rank three, for odd $q$,
the central coefficient and its neighbor are
$(3q^2+1)/4$ and $(3q^2-3)/4$, giving $(3q^2-1)/2$.
These follow directly from the coefficients of
$(1-t^q)^3/(1-t)^3$; no bounded parameter check is needed.

## 5. The Frattini quotient and strict growth

A noncyclic $P$ has an actual $C_5^2$ quotient, so its intermediate
has defect at least nine. If $d(P)\ge3$, use a $C_5^3$ quotient
instead to obtain37. If $d(P)=2$ and $P\ne C_5^2$, its Frattini
subgroup is nontrivial. The cover of the $C_5^2$ intermediate by
$T$ is an actual nontrivial five-group cover. If that intermediate
has defect nine, the [odd-defect growth theorem](cyclic_symplectic_blocks.md),
Part2, makes the upstairs defect strictly larger; if it already
has at least ten, injective pullback suffices. This proves ten.

## Evidence and scope

The [original independent audit](../../../Research/audits/AUGMENTATION_WIDTH_DEFECT_AUDIT_2026_09_11.md)
retains its geometric presentation and quotient-specialization scope.
Its [producer receipt](../../../../litt3-computation-data/legacy_workspace_computations/augmentation_width_checks.json)
and [independent receipt](../../../../litt3-computation-data/legacy_workspace_computations/augmentation_width_audit.json)
remain historical evidence. Jennings's formula replaces their finite
radical computations; both obsolete source checkers are deleted.
The new matrix inequality and Frattini argument use exact filtration
and actual intermediate covers, not new computation.
