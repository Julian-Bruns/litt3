# Proof: averaging, triangular solves and compatible truncations

Version1, 2026-09-15. This proves the
[statement](../../Theorems/deformations/marked_obstruction_torsors.md).
The [bounded audit](../../Research/audits/MARKED_OBSTRUCTION_TORSORS_AUDIT_2026_09_15.md)
checks the full pointwise conclusions and their actual lifting uses.
All groups below consist of actual allowed points. In applications
they may involve Frobenius and inverse Frobenius, so replacing a
map by a field-linear matrix is not implicit.

## 1. Averaging the torsor and its obstruction

Multiplication by q is invertible, so define

    a_Gamma=a+(1/q)*sum_(gamma in Gamma)(gamma*a-a).

The differences are elements of K. Applying any group element
permutes the affine average, so a_Gamma is fixed. The affine
translation rule and equivariance give

    c(a_Gamma)=(1/q)*sum_gamma gamma*c(a)=average c(a).     (1)

An additive map commutes with division by q because that division
is unique in both groups. In particular any zero averages to an
invariant zero, and the converse is immediate.

For x in K, equivariance gives

    average R(x)=R(average x),   average x in K^Gamma.

Hence P(average c(a+x))=P(average c(a)) when
R(K^Gamma)=ker P. This proves independence of all torsor choices.
If the residual vanishes, (1) belongs to ker P and equals R(y)
for some y in K^Gamma. The invariant point a_Gamma-y is a zero.
The converse follows from (1). Nothing here constrains the kernel
outside K^Gamma. No averaging by a noninvertible group order occurs.

## 2. Triangular elimination without assumptions on the tails

Given a target (y_i), solve successively

    x_i=M_i^(-1)(y_i-T_i(x_1,...,x_(i-1))).

At each stage the earlier variables are known, so this defines a
unique solution. For a zero target and pointed M_i,T_i, induction
forces each x_i=0. An absent variable remains free. The proof uses
only the bijections on the chosen points and never differentiates
the tails. Unknown higher tails therefore cause no additional
point-kernel when these triangular hypotheses have been checked.

## 3. Delayed extension with varying groups and responses

A reached W_m prefix admitting W_(m+2) gives a nonempty A_m.
Choose any origin a. Surjectivity gives x with
S_m(x)=-psi_m(a). The point a+x then admits W_(m+3), by the
COMPLETE iff hypothesis, including all later primary solves and
whole regular repairs.

Starting with U_(m0+2), repeat this construction. It produces U_n
from U_(n-1) for n>=m0+3 and preserves their W_(n-3) truncation.
It need not preserve the two later digits of U_(n-1). For m>=m0 set

    V_m=U_(m+2)|W_m.

The construction of U_(m+3) preserves U_(m+2) through W_m, so
V_(m+1)|W_m=V_m. These stabilized truncations give a compatible
formal tower, not just unrelated objects of unbounded finite length.

Two formal towers agreeing through W_m determine points in the
SAME A_m. Both points have psi_m=0 since both admit W_(m+3).
If S_m is injective they are equal; the included or uniquely
associated lower structures identify the W_(m+1) tuples. Induction
from the fixed W_(m0), with unique compatible marked identifications,
gives the asserted formal uniqueness.

Only surjectivity and injectivity at each reached prefix have been
used. Constant groups, constant maps, a coefficient-field vector-space
structure and perfectness are unnecessary. In a geometric application
the full relative and primary equations must first identify A_m and
the iff obstruction. A scalar zero or a graded rank alone cannot
replace those inputs.
