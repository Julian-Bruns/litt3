# Proof: all-precision degree control on étale Artin–Schreier charts

Version2,2026-09-15. This proves the
[statement](../../../Theorems/deformations/elementary_covers/etale_artin_schreier_carry_bound.md).
All filtrations below use the actual W coordinates, not the nilpotent
logarithmic deck variables. No step divides by p. The argument works
with p-torsion in the base, including truncated Witt rings.
The [bounded independent audit](../../../Research/audits/ETALE_CARRY_AND_REPAIR_SIMPLIFICATION_AUDIT_2026_09_15.md)
checks all carries, including pure powers at and beyond carry p,
the full base-ring hypotheses, semilinear maps and derivations.
The [hypothesis-reduction audit](../../../Research/audits/ETALE_CHART_HYPOTHESIS_REDUCTION_AUDIT_2026_09_15.md)
passes Version2, including p-torsion and the separate unit assumptions.

## 1. The weighted modules

Reduction by W_i^p=a_i W_i+b_i never increases total degree. The
monic relations give a free A-basis over any A, so F_d F_e is contained in
F_(d+e). Multiplying their weighted sums proves

    G_d G_e subset G_(d+e).

More explicitly, the coefficient of W^e in G_d is divisible by

    p^max(0,ceil((|e|-d)/(p-1))).

There are only p^r monomials, and each ideal p^a A is open and
closed. Thus G_d is closed and complete in the p-adic topology.
For its digit interpretation, choose a factor for each coefficient
in its required p-power ideal and expand that factor successively
using the fixed section of A/p. This requires no division by a
nonzerodivisor and no uniqueness of the expansion. In particular, a coefficient which is
zero modulo p^j cannot introduce a lower-digit monomial when equal
terms are combined. Finite precision follows by reduction of these
complete modules.

The key extra property is G_1^p subset G_1, where the left side
means the set of p-th powers, not the product of p independent
elements. Write x in G_1 as a finite sum of terms

    p^j*c*W^e,  |e| <= 1+(p-1)j.

Expand x^p by the multinomial theorem. A mixed multinomial contains
at least two distinct terms, so its multinomial coefficient is
divisible by p. If its p factors have total weight h, their total
degree is at most

    p+(p-1)h = 1+(p-1)(h+1).

Their extra factor p therefore puts that entire term in G_1.
For a pure p-th power of one term use the actual equations:

    (p^j*c*W^e)^p
      =p^(pj)*c^p*product_i(a_i W_i+b_i)^(e_i).

Its degree is at most |e|, hence at most 1+(p-1)pj. This also lies
in G_1. This pure-power reduction is essential when the number of
carries reaches p; binomial divisibility alone is not an all-orders
argument. Every term has now been included. Neither the a_i nor
the b_i was inverted in this section.

## 2. Hensel lifting and substitutions

For F(x)=x^p-a*x-b, choose an affine-linear integral representative
x_1 of the prescribed residue root. Then x_1 belongs to G_1 and
F(x_1) belongs to pB. Iterate

    x_(n+1)=x_n+a^-1*F(x_n)=a^-1*(x_n^p-b).

Section1 shows inductively that each x_n belongs to G_1. If
F(x_n) is divisible by p^n, the increment is p^n-divisible. The
linear part of the new defect has the extra factor p. Each mixed
Taylor term has that factor as well, and the pure p-th power of
the increment is divisible by p^(pn), hence by p^(n+1) for n>=1.
Thus F(x_(n+1)) is divisible by p^(n+1). The complete sequence
converges to a root in the closed module G_1.

The derivative p*x^(p-1)-a is a unit, since its residue is -a.
For two roots x,y with the same residue,

    0=F(x)-F(y)=(x-y)*(sum_(k=0)^(p-1) x^(p-1-k)*y^k-a).

The second factor reduces to -a modulo p and is a unit. Thus x=y,
without cancelling a power of p. This also identifies the constructed root
with the actual étale lift, rather than an auxiliary approximation.

The ambient equations were used only in Section1. The present root
construction needs the coefficient a of its own equation to be a
unit; it does not require the ambient a_i to be units.
Apply this argument to each image coordinate of a chart map. Its
image lies in G_1; a product of at most d such images lies in G_d.
A general weighted term p^j F_(d+(p-1)j) is sent to G_d by the
same multiplication rule. Base coefficients have degree zero.
This proves filtration preservation, including semilinear base
transport and compositions. A residue Frobenius on these charts
is affine-linear because W_i^p=a_i W_i+b_i modulo p; the argument
therefore applies to its actual étale lift whenever its base lift
has been specified. It does not replace that base lift by an
ordinary p-th power on integral coefficients.

## 3. Derivations

Now assume every a_i is a unit. Differentiating the chart equations
forces the unique possible extension

    D(W_i)=((D a_i)W_i+D b_i)/(p W_i^(p-1)-a_i).

The inverse denominator is the convergent geometric series

    -a_i^-1 sum_(j>=0) p^j*a_i^-j*W_i^((p-1)j),

which belongs to G_0. The displayed assignment respects the defining
relations, so it indeed extends D. Its numerator belongs to F_1, so D(W_i)
belongs to G_1. Applying the Leibniz rule to a polynomial of degree
d puts its derivative in G_d. Since D(p)=0, the same argument
applies to each weighted term, and D preserves G_d. This proves
part3 and the stated bound under successive operations.

## 4. What the sixth stage changes

The fifth rank125 support proof needs only the j<=2 specialization
of this result: d,d+4,d+8. Its sixth comparison can use j=3 as well,
giving d+12, with no new chart-specific Hensel expansion. The
unchanged special-fibre functional E100 kills F_10. A degree-one
moving term with three carries is only bounded by F_13, which in
rank125 is already the whole F_12 algebra. Therefore this general
chart bound alone no longer eliminates such a sector. This is a
failure of that degree-only elimination, not evidence of a nonzero
sixth obstruction or a change to the earlier fifth proof.
