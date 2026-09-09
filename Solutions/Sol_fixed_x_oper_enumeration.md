# Proof: complete candidate algebra and its symmetry classes

Canonical [statement](../Theorems/Thm_fixed_x_oper_enumeration.md).

## Independent certificate, without trusting the large candidate basis

### Short verification by exhausting the global length

The standalone `scripts/verify_oper_census.sage --out DIRECTORY` replays
the entire census certificate in13.08s on one core (2026-09-08 receipt:
external `oper-census-fast-verification-20260908/verification.json`). It
does not read the large Groebner basis, calculate the exceptional slice,
or redo formal elimination. Its mathematical input is the global length
29375 from `fixed_x_dormant_equations`.

Direct substitution of the recorded coordinate polynomials modulo the
squarefree degree19290 polynomial P constructs an F25 algebra of9645
distinct normalized points. The separator a9=z distinguishes them;
the specified coefficient-field embedding halves the F5 degree. The
original differential identities and gcd(lambda,P)=1 imply that adjoining
t with t^3=lambda constructs28935 DISTINCT original solutions, all with
c4=t nonzero. This direction requires no prior completeness of the
normalized scheme or the c4=0 slice.

At each of the six invariant closed points, the verifier substitutes the
SAVED24 local-coordinate expressions into all96 freshly generated original
quadrics, modulo (t0,t1,t2)^4. The three designated free coordinates are
exactly t0,t1,t2, so these substitutions give a SURJECTIVE map from the
original local algebra to the truncated three-variable quotient. All
monomial multiples of the residual equations have rank12 in the20
monomials of degree<4. Thus this quotient has dimension8, proving a
local length LOWER bound8, without needing formal implicit elimination
or a stabilization test. Irreducible, pairwise coprime b7 factors of
degrees1,1,2,9,19,23 distinguish55 geometric invariant points.

The disjoint contributions have total lower length

    28935 + 55*8 =29375.

They exhaust the independent global length. Hence there are no additional
points, every non-invariant point has length1, and every invariant point
has length8. This also proves that the constructed normalized algebra
is the whole normalized scheme. Multiplication and irreducibility of
the12 saved factors are checked directly, not rediscovered by a search.

The separate `tests/check_oper_original_input.sage` previously substituted
in all43 retained input polynomials directly, independently of the
rewritten differential identities. That audited cross-check remains
available; the large candidate basis was used to FIND the certificate,
not to validate its completeness.

## Exact algebraic specification and symmetry classes

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
