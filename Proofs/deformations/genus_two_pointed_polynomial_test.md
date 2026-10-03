# Proof: hyperelliptic cohomology replaces the Laurent calculation

[Statement](../../Theorems/deformations/genus_two_pointed_polynomial_test.md) ·
[Independent audit](../../Research/audits/POINTED_POLYNOMIAL_RECURRENCE_AUDIT_2026_09_15.md).
Work in odd characteristic; the matrix-shape assertion assumes P>=5.

## 1. Two line bundles on the rational quotient

Write pi:C->P1 for u and omega_C=O_C(2O)=pi*O(1).
The sixteen two-torsion classes are represented by the monic divisors
R of F of degrees0,1,2. On the possibly split double torsor kappa²=R,
the anti-invariant affine module has free k[u]-basis kappa,v/kappa.
For nontrivial R the companion equation (v/kappa)²=F/R has disjoint
branch locus; normalization gives exactly this module. In the split
case use1,v on a component with the sign character retained.

These basis elements have pole orders d and5−d at infinity. Their
parities differ. Consequently no cancellation between them changes
their pole bounds, and for any integer D

    pi_*(O_C(DO) tensor tau_R)
      = O(floor((D−d)/2)) direct-sum O(floor((D−5+d)/2)).    (3)

One may verify this directly on the two standard affine charts of P1:
the infinity generators are the corresponding basis elements times
u raised to their displayed exponents. They are precisely the regular
generators there. This proves(3) with its bases, not just its degrees.

In particular, pi_*omega^-1=O(-1) direct-sum O(-4).
Its H1 therefore has basis v/u,v/u²,v/u³, using the standard Cech
representatives u^-1,...,u^(-l+1) for H1(O(-l)). Pullback by absolute
Frobenius raises each representative to P. Since

    v^P=v F^((P−1)/2),

the class takes the polynomial form in the statement. Over a perfect
field these projective coordinates range over all P²; equivalently
one may retain the relative scalar twists throughout.

## 2. Multiplication gives every matrix entry

Set N=omega^((P+1)/2) tensor tau_R. The connecting map is

    H0(O((P−1)O) tensor tau_R)
        -> H1(O(−(P+1)O) tensor tau_R).                    (4)

Formula(3) supplies exactly the source polynomials of degrees<=a
and target representatives beta/u^j for1<=j<=−b−1 in the table.
Multiplication by v swaps the two components, with

    v*kappa=R*(v/kappa),    v*(v/kappa)=S*kappa.

The lambda_s term contributes u^((2−s)P−3P+i)G to a source u^i.
Its u^-j coefficient is (1), including its sign and ordering.
All other powers are Cech boundaries in O(b). This is the whole
map(4); the two components exhaust it. A direct floor calculation,
using P odd and P>=5, gives n+2 rows in each block, including the
possible empty-column block at P5.

Since H0(N^-1)=0, the kernel of(4) is Hom(N,F^h*E). A nonzero map
destabilizes because deg N=P+1 exceeds slope P. Conversely E is
initially semistable: a destabilizing line would have degree>=2,
project isomorphically to omega, and split the extension. At its first
unstable height s, the maximal line is not horizontal for the canonical
connection, since otherwise Cartier descent destabilizes the previous
iterate. Its second fundamental map and genus two give

    p^s < deg N_s <= p^s+1.

Equality on the right makes that map an isomorphism and
N_s²=omega^(p^s+1). Thus N_s=omega^((p^s+1)/2) tensor tau.
At height h>=s its pullback differs from an appropriate tested N
by omega^((p^(h−s)−1)/2), an effective power. This supplies a map
from N and proves the exact semistability criterion, also for earlier
instability. Finally apply the characteristic-free Eagon--Northcott
coefficient criterion: specialize
[Busé, Propositions5.2 and5.4](https://arxiv.org/pdf/math/0209404)
to O(-1)^(n+2)->O^n on P² and rank threshold n−1. Its resultant
is the determinant of the square degree-n maximal-minor coefficient
map. The characteristic-free case follows from the Eagon--Northcott
resolution as in that paper's Section3.3. This is the same published
input already audited for the finite-height test. For a zero-column
block there is nothing to test.

## 3. A three-state coefficient recurrence

The identity

    A_(h+1)=F^((p−1)/2)*A_h^p

immediately gives

    c_(h+1)(pm+r−j)
       = sum_t [u^(r−j+pt)]F^((p−1)/2) * c_h(m−t)^p.

Only t0,1,2 occur when0<=r<p and0<=j<=2. For t<=−1 the polynomial
index is negative. For t>=3 it is at least3p−2, greater than
5(p−1)/2 for every odd p. This proves(2), including zero coefficients
outside the support and negative m. Iterating it along the base-p
digits requires three entries at every step and begins with the stated
delta vector. This proof needs neither squarefreeness nor monicity;
degree at most5 and odd characteristic suffice for the recurrence
alone. The curve/cohomology application retains its stronger hypotheses.

Over F_(p^f), the entrywise coefficient powers cycle with period
dividing f. Unrolling the recurrence retains these powers; they
must not be dropped or applied to a free extension parameter as a
finite-field shortcut. The constant state size describes scalar
coefficient production. Nothing in this argument condenses the
projective rank or resultant calculation to a finite list of states.

## 4. Direct implementation

The [polynomial builder](../../scripts/deformations/pointed_frobenius_polynomial.py)
implements(1) directly from scalar coefficients with generic matrices.
The later [fourth-height test](pointed_extensions_frobenius.md#3-one-fourth-height-certificate-replaces-the-earlier-computations)
uses these matrices, independently of any Laurent calculation.
Its semistability conclusion supplies all earlier-height nonvanishing.
The original height-two/three basis-comparison receipts remain external
historical evidence; their algorithms are superseded.
