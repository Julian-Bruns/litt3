# Proof: the complete scalar dormant-oper system

Canonical [statement](../Theorems/Thm_fixed_x_dormant_equations.md).

## Global regularity

The [arithmetic theorem](../Theorems/Thm_fixed_pair_arithmetic.md) gives
div(theta)=16O for theta=dx/y^2 and pole semigroup <3,10>. For a one-form
a dt the potential
r_a=-(a'/a)'/2+(a'/a)^2/4 transforms as a projective connection, as follows
by differentiating its local half-density solution a^-1/2. It is regular
where the one-form is nonzero. In the x-frame it is
y''/y=2F''/F+2(F'/F)^2.

At O, z=x^3/y is a uniformizer. If F=x^10+f_9x^9+..., then

    z^-3=F(x)/x^9=x+f_9+O(x^-1),
    x=z^-3-f_9+O(z^3),       theta=2z^16(1+O(z^3))dz.

The local potential is 2z^-2+O(z), with no simple pole. The quadratic
differential 2x^8 y theta^2 has expansion 3z^-2+O(z), cancelling that pole.
Its coefficient in the x-frame is 2x^8/F. Thus R is globally regular.

Differences of regular projective connections are H^0(omega^2).
Its basis consists of x^i y^j theta^2 with 3i+10j<=32 and 0<=j<=2:
the pole orders are distinct and the count is 3g-3=24. Rewriting their
coefficients using y^3=F gives precisely the three polynomial bounds
in the statement. This is the entire affine oper chart.

## Scheme-theoretic curvature

Since k(X)/k(x) is separable, D^5=0. For the companion matrix
M=[[0,1],[r,0]], horizontal derivatives satisfy
M_0=I and M_(n+1)=D(M_n)+M_n M. With E=D^2r-3r^2, direct iteration gives

    M_5=[[D E,3E],[D^2 E+3rE,-D E]].

Consequently E=0 and zero p-curvature define the SAME ideal over any
parameter algebra, not just the same reduced points. Two is invertible,
so trace-free rank-two and projective dormancy agree. The fixed-theta
oper/projective-connection chart applies because p>2 and p does not
divide g-1. See the [rank-two proof](Sol_dormant_rank_two_candidates.md)
for the exact literature and length 29375.

## Polynomial equations

Write r=(n_0+n_1 y+n_2 y^2)/F^2, with

    n_0=2F''F+2(F')^2+2x^8F+B F,       n_1=C F,       n_2=A.

For j=0,1,2 put

    L_j(n)=F^2 n''+(4j-4)FF'n'
             +(2j-2)FF''n+(2j-2)(2j-3)(F')^2 n.

The identity y'=2(F'/F)y gives D^2(n y^j/F^2)=L_j(n)y^j/F^4.
Using the basis 1,y,y^2, the complete curvature equation is

    L_0(n_0)=3(n_0^2+2F n_1 n_2),
    L_1(n_1)=3(2n_0 n_1+F n_2^2),
    L_2(n_2)=3(2n_0 n_2+n_1^2).

Coefficient extraction, omitting zero and repeated expressions, gives
the 96 saved quadrics. Independence of 1,y,y^2 over k(x) proves
equivalence. The global regularity argument, not denominator clearing,
handles branch points and infinity.

## Exact slice computations

The action y->zeta_3 y fixes precisely A=C=0. Singular computes a
zero-dimensional length55 quotient. Lexicographic conversion gives
seven linear leading variables and one polynomial in b_7, whose distinct
irreducible factors have degrees 1,1,2,9,19,23. This proves reducedness
and the stated residue fields of the slice.

To check the full tangent space there, linearize the scalar equation:
delta E=(delta r)''-r delta r. The B block has full rank eight by
reducedness of the slice. In the other blocks, the numerator maps are

    n |-> L_j(n)-n_0 n,
    j=1: n=x^i F, 0<=i<=4;
    j=2: n=x^i,   0<=i<=10.

Over each of the six residue fields, the exact matrix ranks are five
and eight. All Galois conjugates have the same ranks. Thus every slice
point has full tangent dimension3. A zero-dimensional reduced scheme
over the perfect field k has zero tangent space, proving nonreducedness
of the full scheme at these points. Tangent dimension alone does not
give a local length.

For the length, scripts/invariant_oper_multiplicities.sage translates the
full96 equations to each of the six closed points. A nonsingular21x21
Jacobian minor permits formal elimination, leaving three variables t.
The script solves those21 equations modulo (t)^N, substitutes in all96,
and takes the exact rank of all surviving monomial multiples. The full
local quotient has lengths4,7,8,8 modulo (t)^2,(t)^3,(t)^4,(t)^5.
Consequently its fourth and fifth maximal-ideal powers agree. Nakayama
forces the fourth power to vanish, proving length8 and Hilbert function
(1,3,3,1). All conjugate geometric points have this same length.
The [certificates](../Research/computations/invariant_oper_multiplicities.json)
retain pivot indices, eliminated coordinates, residual equations, and ranks.
The55 exported tuples are checked individually in the original equations;
Frobenius orbit closure and coprime b_7 factors prove no duplicate was listed.
