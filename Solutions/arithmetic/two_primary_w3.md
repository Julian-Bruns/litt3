# Proof: two-primary W3 and three-point tensors

[Statement](../../Theorems/arithmetic/two_primary_w3.md).

## 1. Odd pencils separate two-torsion translates

The [pencil and prime-torsion separation theorem](low_pencil_torsion_rigidity.md#1-the-quotient-by-constants-controls-independent-pencils)
gives both assertions: the splitting (−a,−b) bounds every independent
function's degree below by b, and odd local indices with 2r<b make
W_r disjoint from its nonzero J[2]-translates.

For the curve y^3=F_10(x) in file76 the trace-zero splitting is (-4,-7).
On the affine x-line it is spanned by y,y²; at infinity its integral
basis is y/x^4,y²/x^7, with distinct valuation residues2,1 modulo3.
This proves the splitting. All ramification indices are1 or3. Thus
the disjointness statement applies to r=3, since6<7.

## 2. Frobenius separates high two-power torsion

Let A be an abelian variety over a finite field of odd characteristic,
W a closed Frobenius-stable subvariety containing zero, and suppose W
is disjoint from all its nonzero A[2]-translates. Suppose a Frobenius
power M satisfies

    M-I=2U on T_2A, with both U and I+U invertible.

Then W intersect A[2^infinity]={0}.

Use the [power formula](low_pencil_torsion_rigidity.md#3-congruent-automorphisms-one-power-formula).
If M−I=2^sU with s≥2 and U invertible, a point of order 2^t with
t>s has a power-conjugate differing by nonzero two-torsion: take
M^(2^(t−s−1))−I=2^(t−1) times a unit. Thus W-torsion lies in A[2^s].

In the first case M²−I=4U(I+U) puts it in A[4]. An order-four point
has difference (M−I)a=2Ua of order two, again forbidden. An order-two
point gives the forbidden translation between itself and zero.
Hence W has no nonzero two-primary torsion.

For the fixed J(X), take M=pi^171, where pi is F25-Frobenius. In the
quotient by its actual Weil polynomial P, the remainder modulo4 is

    T^171-1 = 2(T17+T16+T14+T10+T8+T7+T6+T2+T) mod(P,4).

P mod2 is irreducible of degree18. The displayed degree17 polynomial
and its sum with one are both nonzero modulo P, hence units.
Cayley–Hamilton and Bézout give the asserted integral endomorphism
property on T₂J(X). Therefore

    W_3(X,O) intersect J(X)[2^infinity]={0}.           (1)

## 3. Three-point tensors have nonzero Cartier image

Suppose s is a weight d=3g0 regular tensor on X, where g0 is a power
of two, and

    div(s)=16g0 E,  E reduced of degree3.

Since div(theta)=16O for theta=dx/y², the relation implies
16g0[E-3O]=0. By (1), E is linearly equivalent to3O. The pencil
L(3O)=span(1,x) shows E=x^*(c) for some finite c with F_10(c)!=0;
the infinity and cubic branch fibers are not reduced of degree3.
Consequently, up to a nonzero scalar,

    s=s0^g0,  s0=(x-c)^16 theta³
               =(x-c)^16/F_10(x)^2 (dx)³.           (2)

For weight3, the eligible generalized-Cartier-zero condition is
C_1(s0²)=0. The fifth-power rule shows it is equivalent to

    C(F_10(x)(x-c)^32 dx)=0.                          (3)

Let a in F25 satisfy a²+4a+2=0 as in file76. The coefficients of x^34
and x^39 in the polynomial in (3) are respectively

    u(c)=(a+3)c7+(2a+3)c6+(2a+4)c5
                    +(3a+4)c²+3ac+3a+3,
    v(c)=(4a+2)c²+(3a+2)c+3a+1.

They cannot vanish together: exact division gives

    u mod v=(2a+1)(c+1),   v(-1)=4a+1!=0.

Thus (3) is impossible over the algebraic closure.
For general g0, choose r in {1,2,3,4} with dr=1 mod5 and write
g0 r=2+5j, j>=0. The generalized Cartier fifth-power rule identifies
the image of s^r with s0^j times the nonzero image of s0².
Hence its Cartier image is nonzero as well.

Both the Frobenius remainder and coefficient identities are checked by
the [short exact certificate](../../routes/global/GENUS9_W3_CARTIER_CERTIFICATE.sage).

## 4. Application and boundary

Every two-branch atlas produces a uniform Cartier-zero tensor

    s=F^*((dz)^d/z^(d-1)), d=other tame inertia order.

To check Cartier zero directly, choose rd=1 mod5. The coefficient of
((dz)^d/z^(d-1))^r has exponent r(1-d)=r-1 mod5, never4; ordinary
Cartier therefore kills it. The claim follows by pullback.

The single-wild-jump signature family (q,j,t0,m,D)=(5,2,1,3,16)
has d=3g0 and div(s)=16g0 E with E reduced degree3. Section3 therefore
eliminates the family for all its possible tame factors g0.
For the two-point family D8,m1, Sections1–2 give the same torsion
vanishing on W₂; its divisor would satisfy P+Q~2O, impossible
for distinct P,Q on the trigonal curve.

The same three-point obstruction applies to any coreless primitive
invariant of this specified shape: its degree3g0 does not divide4, so
the retained coreless Cartier theorem would require the impossible
vanishing. Other supports and weights are not excluded here.

Original pencil, Frobenius and Cartier calculations:
[audit and certificate scope](../../routes/global/audits/ENDPOINT_TWO_PRIMARY_LOW_DEGREE_TORSION_AUDIT_2026_09_06.md).
