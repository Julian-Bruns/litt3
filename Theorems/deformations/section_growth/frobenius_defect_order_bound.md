# Short Frobenius strings bound a two-dimensional deck image

## General representation theorem

Let k be algebraically closed of characteristic p>0, let G have order
prime to p, and let V be a finite-dimensional k[G]-module restricting
to a multiple of the regular representation on every cyclic subgroup.
Let Psi be an equivariant Frobenius-semilinear endomorphism of V, with
self-dual cokernel D of dimension two. If its nilpotent part has a
Jordan string of length at most d>=1, the faithful image Gamma of G
on D satisfies

    ord(gamma)<=2 or ord(gamma) divides p^ell-1 or p^ell+1
        for some 1<=ell<=d,
    |Gamma|<=max(120,4(p^d+1)).

For p=5, the constant 120 improves to 48.

## Application to actual common covers in characteristic five

Let X←f−Z−g→Y be actual finite etale maps of smooth projective connected
hyperbolic curves over k=bar(F5). Suppose:

- g is Galois of degree prime to5, and 5 does not divide deg f;
- admissible active nilpotent connections match on Z;
- r_Y is ordinary, the source defect is TWO, and r_X is nonordinary.

Let Gamma be the FAITHFUL image of the actual Y-deck group on the
two-dimensional defect space, and put d=3g(X)-3. Every element of
Gamma has order at most2 or an order dividing

                  5^ell-1 or 5^ell+1,  1<=ell<=d.

In particular |Gamma|<=max(48,4(5^d+1)). The kernel of the defect
action, and therefore deg(Z/Y), is not asserted to be bounded.

Normalized f-trace supplies the short nilpotent string from H1(X,T_X);
etale character decomposition supplies regularity, and Serre--Cartier
duality identifies the defect representation with D^dual.

## Consequence for the unchanged main pair

For main genus-nine X and genus-two Y_t, the prime-to5 condition on f
follows from deg g=8 deg f. The actual intermediate

    T=Z/ker(Gal(Z/Y_t)→Gamma)

has genus at most4(5^24+1)+1<2^59. A nonzero X defect quadratic
descends to T, so phi_X²/s_X supplies an ACTUAL core for X←Z→T.
The atlas degree of X to its common orbifold is at most64. This does
not infer that the original X,Y_t span is cored.

Let R be the smooth joint normalization of the two original endpoint
fields. More directly, its defect orbit and
[the joint-degree bound](two_leg_defect_orbit_bound.md) give
\[
\deg(R/X)\le8|\Gamma|\le32(5^{24}+1)<2^{62}.
\]
The later [quotient-descent theorem](../../curve_arithmetic/genus_two_quotient_descent.md)
requires $\deg(R/X)>(335999!)^2$. These bounds contradict each
other, excluding the ENTIRE stated prime-to5-Galois-Y/source-defect2/
nonordinary-X branch for the SAME main pair.

Combined with [the orbit bound](two_leg_defect_orbit_bound.md),
any remaining Galois-Y, source-defect2 match with nonordinary X must
have a NONTRIVIAL cyclic five-part acting TRIVIALLY on the defects.
Its prime-to5 projective image must still be a large cyclic or
dihedral group of order greater than $(335999!)^2/8$. No upper bound
for that residual case is proved: deg f is divisible by5 and normalized
trace fails.

Ordinary-X, higher-defect, non-Galois, dormant and absent-connection
branches remain. The full common-cover problem is UNSOLVED.

Version3,3 October2026. The all-characteristic representation theorem
and actual cored intermediate are unchanged. Later quotient descent
replaces the large partner count and sharpens the residual lower bound.
The original audits retain their scopes; the replacement has author review.
[Proof](../../../Proofs/deformations/section_growth/frobenius_defect_order_bound.md).
