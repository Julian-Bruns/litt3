# Proof: two invariant generators and an impossible quartic cube

Version1. [Statement](../../Theorems/cartier_and_spin/degree_twelve_334_ordinary_spin_exclusion.md). [Independent whole-implication review: PASS](../../Research/audits/DEGREE_TWELVE_334_ORDINARY_SPIN_AUDIT_2026_10_03.md). This is a computation-free joint deduction with the root researcher. All groups, norm polynomials, source functions and endpoint maps are ACTUAL.

Let B=Γ/G=P¹, N=M¹⁶ωΓ^-1 with its genuine canonical G linearization, and s the canonical different section. Its orbifold degree is1/12. The distinguished point β=0 is ordinary for Γ→B, so the mixed fiber has ONE ramified sheet and ten unit companions. Hence e10 is a UNIT at that Γ point. The coefficient e11 vanishes there because every elevenfold product includes one zero value.

## The unit coefficient gives exactly two symmetric weight assignments

Write weights(w3a,w3b,w4). Integrality of the coarse N degree gives4(w3a+w3b)+3w4≡1(mod12). Thus w4=3 and w3a+w3b≡1(mod3). The only possibilities are(0,1,3),(1,0,3),(2,2,3). The last has invariant N10 coarse degree
\[
10/12-2/3-2/3-1/2=-1,
\]
so it cannot supply the nonzero e10. Exchange the two order-three cones and assume weights(0,1,3).

For j<12 the invariant Nj coarse degrees are
\[
d_j=j/12-\{j/3\}-\{3j/4\}.
\]
They are−1 for j=1,2,5, and zero for j=3,4,6,7,8,9,10,11. A nonzero section in any zero-degree space has exactly its forced cone zeros and cannot vanish at the ordinary distinguished point. Consequently e11=0 as well.

Choose nonzero invariant generators t3 of N3 and t4 of N4. Forced zero divisors show that the remaining invariant generators below degree twelve are precisely t3,t4,t3²,t3t4,t4²,t3³,t3²t4,t3t4². The coefficient e10 is a NONZERO constant multiple of t3²t4.

## The two generators reconstruct the actual Y field

Put f=t3/s³,g=t4/s⁴,h=e12/s¹². OnY their degrees are three and four: t3 has simple forced zeros over the order-four cone, and t4 over the weighted order-three cone; both are units at the distinguished point. Hence k(f,g)=k(Y), by the coprime degree indices three and four.

The quotient β=e12/t3⁴ is an actual coarse coordinate. Its zero is the distinguished ordinary value and its pole is the order-four cone; its degree onY is twelve. The section ratio t4³/t3⁴ has simple zero at the weighted order-three cone and simple pole at the order-four cone. Thus for nonzero c and a finite nonzero cone position b,
\[
g^3/f^4=c(\beta-b),\qquad h=\beta f^4.
\]
The OTHER order-three cone has a distinct finite nonzero position a.

Set z=g/f and D=c(β−b). The displayed identity gives
\[
f=z^3/D,\qquad g=z^4/D.
\]
Therefore k(Y)=k(β,z): this is an ACTUAL primitive degree-twelve source field over k(B), not a presumed abstract model.

## The specialized norm polynomial is a cube

Evaluate the characteristic polynomial of s at s itself and divide by s¹². The monomials supplied by the allowed invariant generators have weighted exponents0,3,4,6,7,8,9,10,12 in z after substituting the preceding formulas. Multiplying by D⁴ gives a degree-twelve polynomial Pβ(z), whose leading coefficient is β, constant coefficient D⁴, and coefficient of z10 a nonzero constant multiple of D, because e10 is a unit. Its exponents1,2,5,11 are missing. Since z is primitive of degree twelve, Pβ is its actual minimal polynomial up to its leading coefficient.

At β=a, the actual Y fiber consists of FOUR points each of index THREE. All z values are finite, since its only poles lie over the distinguished value or the order-four cone. The finite-flat norm polynomial specializes as a product of( Z−z(R))³; even if two z values coincide, this remains a cube. Its leading coefficient a and constant coefficient c⁴(a−b)⁴ are nonzero. Over the algebraically closed field absorb a scalar and write
\[
P_a(Z)=V(Z)^3,\qquad\deg V=4,\quad V(0)\ne0.
\]
Write V=v0+v1Z+v2Z²+v3Z³+v4Z⁴. The missing coefficients of Z and Z² imply v1=v2=0, since three and v0 are nonzero. The missing coefficient of Z11 then equals3v3v4² and forces v3=0. Hence V=v0+v4Z⁴, whose cube has only exponents0,4,8,12. Its coefficient of Z10 is ZERO, contradicting the nonzero coefficient supplied by e10.

This excludes the ordinary distinguished branch on both endpoints, without an arithmetic computation or a new endpoint simplicity assumption. The statement deliberately retains the other degree-twelve cases.
