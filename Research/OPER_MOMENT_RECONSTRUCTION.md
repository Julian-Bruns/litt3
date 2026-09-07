# Conditional cyclic moment reconstruction

2026-09-07. Bounded implementation note; no assertion that the normalized
oper algebra is monogenic, that the candidate matrix is a certified
multiplication matrix, or that any original equations have been verified.

Let V have dimension D over F5, M an endomorphism, v a vector, and ell a
linear form. Put s_j=ell(M^j v). Suppose a monic degree-D polynomial P
annihilates the first 2D scalar moments and the associated numerator

    A(z) = polynomial_part(P(z) sum_{j>=0} s_j z^(-j-1))

is coprime to P. Only s_0 through s_(D-1) enter A. These hypotheses certify
that the D by D Hankel matrix (s_(i+j)) is invertible: the first 2D moments
agree with the unique recurrence extension defined by P, and for that
extension its Hankel pairing is nonsingular exactly when gcd(A,P)=1.
One proof writes the pairing on F5[z]/P as L(fg), where
L(f)=coefficient of z^-1 in f A/P at infinity. The coefficient pairing
with 1/P is perfect (its matrix in reversed degree order is triangular
with diagonal 1); multiplication by A is invertible exactly when gcd=1.

Consequently both the Krylov map f -> f(M)v and the observation map
w -> (ell(M^j w))_(0<=j<D) are isomorphisms. The first 2D moments also
give ell(M^j P(M)v)=0 for j<D, so P(M)v=0 and then P(M)=0 because v is
cyclic. Thus V, as an F5[z]-module, is exactly F5[z]/P.

For any coordinate vector v_i put t_(i,j)=ell(M^j v_i), and define B_i
by the same polynomial-part formula. There is a unique h_i of degree<D
with v_i=h_i(M)v. The resolvent identity, or multiplication of the formal
Laurent series, gives

    B_i = h_i A (mod P),     h_i = B_i A^-1 (mod P).

This identifies vectors and the action of M. It does NOT by itself give
an algebra structure on V for which these vectors are the original
coordinates, or certify a candidate Groebner basis.

## Independent original-algebra certificate

Let the actual original presentation be Q=F5[x_1,...,x_n]/I, with an
independently proved dimension D. Substitute every original generator
of I in the h_i, computing exactly modulo P. If all vanish, there is a
homomorphism Q -> F5[z]/P. If one coordinate is the chosen separator and
its reconstructed polynomial is z modulo P, this map is surjective.
Equal dimensions then imply an isomorphism. This final argument does not
require any unverified Groebner-basis provenance or candidate-matrix
claims. The moment construction is a means of proposing h_i; the final
substitution, surjectivity, and independent length prove the result.

No squarefree reduction of P is permitted here. For a factorization
P=product f^e with f irreducible, each factor gives one closed point of
degree deg(f) and geometric local length e. Coordinate values are h_i
modulo f; the powers f^e preserve all multiplicities. These conclusions
are conditional on the original-algebra isomorphism above.

## Failure is not a point census

If the observed recurrence has degree d<D, the cyclic certificate fails.
The cause may be a poor observation form, a poor starting vector, a
separator collision, or genuine failure of monogenicity. For example
F5[u,v]/(u,v)^2 has dimension3 but multiplication by u has minimal
polynomial z^2, regardless of how the scalar probe is improved. In
F5 x F5, the separator (1,1) has degree1 and merges two distinct points.
Even a truly cyclic ring can give degree0 with ell=0. There is no basis
for assigning all D dimensions to a smaller observed polynomial or
discarding invisible nilpotent directions. Changing ell may repair only
the observation failure; a block/module decomposition is needed for
intrinsic noncyclicity. No global monogenicity assumption is made.

## Implementation and checks

`scripts/oper_moment_bm.c` calls FLINT's batch Berlekamp--Massey interface;
`scripts/oper_moment_reconstruction.sage` uses compiled FLINT polynomial
multiplication, inversion and gcd. Recurrence checking uses polynomial
convolution, avoiding Python quadratic loops and any dense D by D matrix.
FLINT's [batch implementation](https://github.com/flintlib/flint/blob/master/src/nmod_poly/berlekamp_massey.c)
uses half-GCD for the large-degree reduction branch; all moments are
added before the single reduction call.
Input and output formats and build instructions are in the two scripts.
The [FLINT documentation](https://flintlib.org/doc/nmod_poly.html#berlekamp-massey-algorithm)
warns that its V polynomial need not annihilate every point of an arbitrary
finite sequence. The script therefore verifies every available recurrence
window explicitly and verifies gcd(A,P)=1, not just the returned degree.

The executable `/tmp/oper_moment_bm` was built with local Sage FLINT and
the command

    sage scripts/oper_moment_reconstruction.sage --bm /tmp/oper_moment_bm --self-test

passed: cyclic P=(z-1)^3(z^2+2)^2, exact reconstruction of a second
coordinate, direct small Hankel invertibility, and rejection of both
the noncyclic square-zero ring and the two-point separator collision.
This is a targeted implementation test, not a certificate for the
19290-dimensional algebra. The script deliberately labels its output
as original equations NOT verified.
