# Proof: complete candidate algebra and its symmetry classes

Canonical [statement](../Theorems/Thm_fixed_x_oper_enumeration.md).

## Independent certificate, without trusting the large candidate basis

Let I be the retained43-generator F5 input ideal, including
zeta^2+4zeta+2. The cubic-quotient theorem independently gives
dim_F5(F5[c0,...,a9,zeta]/I)=19290. The computer-produced data give a
monic P of degree19290 and polynomials h_i modulo P. Exact substitution
of every original generator in the h_i gives zero. Moreover h_a9=z.
Thus substitution gives a surjection

    F5[c0,...,a9,zeta]/I -> F5[z]/P.

Both sides have the same finite dimension, so it is an isomorphism.
This argument does not require the original msolve output, its reported
leading terms, or the proposed multiplication matrix to be correct.
They were used to FIND the certificate, not as assumptions in verifying it.

The main check in `scripts/certify_oper_parametrization.sage` reconstructs
B and lambda by monic polynomial division, valid over nonreduced algebras,
and verifies all normalized differential identities. A fresh independent
check in `tests/check_oper_original_input.sage` directly substitutes in
all43 retained input polynomials, without using the rewritten identities
or any candidate basis. Both tests passed; their source hashes and
scope are preserved in the linked audit and machine evidence.

Exact gcd(P,P')=1 proves that the normalized algebra is reduced.
The coefficient-field relation makes the displayed map a specified
F25 algebra of dimension9645. This is NOT a Weil restriction.

## Counts and exact algebraic specification of every solution

The cubic-quotient theorem reconstructs the original c4-invertible
scheme by adjoining t with t^3=lambda. The certificate also checks
gcd(P,lambda)=1. Since3 is invertible, this is an etale cubic algebra.
It therefore gives3*9645=28935 distinct simple geometric points.
The complementary support consists of the55 previously certified
invariant points, of full local length8, not their slice length6.
The distinct count is28935+55=28990 and the full length is29375.

The exact factorization of P is checked by multiplication and irreducibility
in `scripts/factor_oper_parametrization.sage`. Each irreducible F5 factor
has even degree2d, since its residue field contains the specifiedF25.
As an F25 algebra with a=h_zeta(z), it gives ONE closed point of degree d.
The12 degrees d are those in the statement. Summing them gives9645.
Do not instead list all2d roots in a fixed algebraic closure: only the
d roots satisfying h_zeta(z)=the fixed a give points of this fixed curve.

An exact compact specification for a closed factor f is: choose a root
alpha with h_zeta(alpha)=a, choose beta^3=lambda(alpha), and put rho=2a+1.
Then rho^2+rho+1=0, so the complete original tuples above this factor are

    alpha_j=alpha^(25^j),     t_(j,b)=rho^b beta^(25^j),
    B=B(alpha_j),
    C=t_(j,b)*Chat(alpha_j),
    A=t_(j,b)^2*Ahat(alpha_j),

for0<=j<d and0<=b<3, all with multiplicity1. Distinct j give distinct
normalized tuples because a9=alpha_j; distinct b give distinct c4=t.
Factors are coprime. Hence there are no duplicates. Choosing a different
initial root or cubic root merely permutes this exact list. It works
whether or not the cubic already splits over the residue field.

## Why18 representatives suffice for the untwisted atlas test

In general, any existence property of geometric objects and maps defined
over a fixed finite field is invariant under that field's Frobenius.
For an atlas on a fixed curve, it is also invariant under precomposition
by an automorphism of that curve. These operations preserve actual maps,
including finite etaleness; they are not replacements by arbitrary maps.

Here X and the untwisted Hermitian-atlas problem are defined overF25.
The automorphism y->rho*y fixes x and takes (B,C,A) to(B,rho C,rho^2 A).
It permutes the three cubic branches while fixing the normalized tuple.
Frobenius connects all d normalized conjugates in each of the12 factors.
Thus one representative from each factor tests every one of its3d opers.
The invariant slice has6 Frobenius orbits, giving18 representatives total.
Existence still quantifies over ALL quotient choices on each representative.

If a torsion line tau is included as data, the same operations transform
tau as well. No unsupported assertion that every tau is fixed is made.
The smaller cored cases and the coreless branch remain completely outside
the scope of this enumeration and symmetry reduction.
