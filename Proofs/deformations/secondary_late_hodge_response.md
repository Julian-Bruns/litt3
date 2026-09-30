# Proof: the secondary comparison uses three flat digits

Version5, 2026-09-15. This proves the
[statement](../../Theorems/deformations/secondary_late_hodge_response.md).
The [original comparison audit](../../Research/audits/SECONDARY_LATE_HODGE_RESPONSE_AUDIT_2026_09_15.md)
and [consolidation audit](../../Research/audits/MARKED_COMPARISON_CONSOLIDATION_AUDIT_2026_09_15.md)
check this complete local comparison. The global choice and extension
arguments are in [marked obstruction torsors](marked_obstruction_torsors.md).

## 1. Three digits and the preceding object

Apply [integral oper calculus](integral_oper_calculus.md) with b=3.
For r>=3, every product of two new primary increments vanishes
modulo p^(r+3). The common X modulo p^4 and current frames/connections
modulo p³ fix their complete linear response. The genuine preceding
potential has a two-power gain, so only its residue and the residue
of Delta P/p^r enter. The stated actual potential variation supplies
exactly this last input.

In particular the preceding change contributes at p^(r+2).
Reframing the same Hodge line in the resulting current connection
also contributes at that final weight and is retained by the exact
changed-connection formula. It is not legitimate to omit either term.
Higher preceding digits affect the absolute constant but not this
normalized relative comparison.

When r=2, the integral calculus leaves only a quadratic sector at
p^4. Its coefficients use residue background data. Under the
filtration hypotheses the entire sector lies in F_(2d), including
cross-products in both patch factors and inverses. This supplies
the stated sufficient cutoff after whole division.

## 2. Full delayed repairs and the quotient

The [two-digit theorem](late_relative_hodge_response.md) gives
the same whole next normal cochain for all r after the primary
repair and division by p^(r+1). Its full primary-cokernel class
is R(N)=0. Therefore choose the same complete primary preimage,
with the same inverse coefficient Frobenius, and the same whole
affine/formal primitive in the original charts. Matching choices
requires existence, not uniqueness. Normal H0=0, when used,
makes that primitive unique once the preimage is fixed.

These delayed source and graph changes have weights p^(r+2) and
p^(r+1). Their new contribution is a two-digit comparison with
common background modulo p². A delayed graph cannot multiply a
new primary increment, since 2r+1>=r+3. It cannot square either.
It may multiply old weight-p data, which are retained identically.
Thus the same full delayed repair contributes at every r, without
a degree bound on that repair.

Two delayed primary preimages differ by a primary-kernel element;
their next responses differ by R of that element. Higher sections
give terminal primary directions or boundaries. If whole primitive
ambiguity contributes only to this image, the result is intrinsic
modulo im R. In particular normal H0=0 guarantees that condition.
No such condition is needed to compare specified matched primitives.

The achieved compatibility now makes the WHOLE repaired numerator
divisible by p^(r+2). Divide it only at this point. Its common
linear part gives the secondary response, with precisely the r=2
quadratic exception in Section1. A projection killing that sector
proves the asserted stability.

## 3. Two divisions of one whole linearized equation

The [bounded audit](../../Research/audits/SECONDARY_LINEARIZED_RECIPE_AUDIT_2026_09_15.md)
checks the complete choice and solvability assertions and the input budget.
Let L,U,C have the stated meaning and write a bar for reduction
modulo p. For k in K0 and a lift u, L(u) is p-divisible. If the
lift changes to u+p*w, L(u)/p changes by L(w); its class in
O0 is unchanged. Addition of lifts proves that R is Fp-additive.
The condition R(k)=0 is exactly the existence of v satisfying

    L(u)+p*L(v)=0 modulo p².                            (1)

This is a solve in the whole cochain module, not in a selected
scalar coordinate. Put t=u+p*v and c=L(t)/p². Another choice
t' satisfying (1) has t'-t=p*w. Since L(t')-L(t) is p²-divisible
and C is p-torsion-free, L(w) is p-divisible. Thus bar w lies
in K0 and

    [L(t')/p²]-[L(t)/p²]=R(bar w) in O0.                (2)

Equation(2) proves that S is well-defined modulo im R. Choosing
the sums of admissible lifts proves additivity. It also explains
why arbitrary delayed choices must be quotiented out by their
complete relative image, rather than omitted.

If S(k)=0, choose bar w in K0 with R(bar w)=-[c]. For an integral
lift w, the residue of c+L(w)/p lies in im bar L. Choose z to
cancel it. Then

    L(t+p*w+p²*z)=0 modulo p³.

Conversely such a lift gives S(k)=0 by choice independence. This
proves the complete solvability criterion, without a field-linear
assumption on the original coefficient transports.

Only L modulo p³ is used: first solve the primary equation,
then solve (1), then divide the WHOLE sum by p² and take the
stated quotient. No separately divided carry or graph summand
appears in this procedure. Absence of p-torsion in C is needed for
the divisions and cancellation in (2), unlike the chart bound.
The abstract argument uses only addition and multiplication by p:
U may have torsion, and neither group needs completeness or a
Z_p-module structure.

To obtain this L from the actual comparison, use the integral
calculus with a central variable epsilon satisfying epsilon²=0,
D(epsilon)=0 and F0(epsilon)=epsilon. Take the coefficient of
epsilon in the WHOLE normalized comparison, including both patch
graphs, the prescribed variation of the preceding potential and
the actual current-connection changes. The source variation is
X->X-p*epsilon*N; a delayed source/graph direction corresponds
to multiplying its entire input by p. This is valid because the
actual coefficient map fixes p. It makes L Z_p-linear, without
making it linear over the residue coefficient field.

The finite-input bounds follow directly from the b=3 calculus.
For p>=5 and j>=4,

    j-v_p(j!)>=4,   j-1-v_p(j!)>=3.

At j=4 these follow directly; for j>=5 use
v_p(j!)<=(j-1)/(p-1). Thus source terms beyond j=3 vanish
modulo p^4, even after taking first variation, and their divided
discrepancy vanishes modulo p³. All Taylor terms beyond j=3
vanish modulo p³. The direct preceding contribution has a p²
factor, so only its residue and residue variation are used.
This proves the stated finite recipe. Weighting the extracted
coefficient by p^r and applying Sections1--2 recovers the actual
projected secondary comparison;
the r=2 quadratic exception must still be annihilated as stated.
