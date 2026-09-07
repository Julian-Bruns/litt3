# Proof: Cech elimination produces a small resultant matrix

[Statement](../Theorems/Thm_cohomological_bezout.md).

## 1. The actual polynomial matrix

Choose a two-affine-open cover of C with affine intersection. Its Cech
complex for a vector bundle F is C0(F)--d_F-->C1(F). Fix linear sections
i_T:H1(T)->C1(T), i_V:H1(V)->C1(V) of the cohomology projections.
Choose h_V:C1(V)->C0(V) with

    d_V h_V = 1-i_V p_V,

where p_V projects onto H1(V). This is possible by splitting vector
spaces over k. Choose a linear projection P_M:C0(M)->H0(M) which is the
identity on ker d_M. Define

    a(u)=p_V a_u i_T,
    q(u)=b_u|H0(V),
    B(u)=P_M b_u h_V a_u i_T.                            (1)

All these choices are fixed before u varies. Formula(1) is polynomial
of the asserted degrees. Only finitely many values of the chosen linear
splittings are needed, since A,H1(T),H0(V) are finite-dimensional.
No rational choice depending on u or generic pivot is involved.

We verify its kernel on EVERY nonzero u; this also avoids any hidden
assumption that a spectral sequence degenerates. Put the sheaf complex

    T --a_u--> V --b_u--> M

in degrees-2,-1,0. A degree-1 Cech cocycle is represented by
(xi_tilde,v) in C1(T)+C0(V), satisfying

    d_V v=a_u xi_tilde,       b_u v=0.                   (2)

Boundaries have the form(d_T t,a_u t). Since H0(T)=0, every class can
be represented uniquely as far as its C1(T) component is concerned by
xi_tilde=i_T xi. Equation(2)'s first part is soluble exactly when
a(u)xi=0. When it is soluble all solutions are

    v=h_V a_u i_T xi+v0,       v0 in H0(V).

For these xi, b_u h_V a_u i_T xi is closed, since b_u a_u=0.
Therefore P_M does not change it, and the second equation in(2) is
precisely B(u)xi+q(u)v0=0. No boundary remains after fixing xi_tilde:
a remaining t would satisfy d_T t=0, hence t=0. We have proved

    ker D(u) = hypercohomology^-1(T->V->M).              (3)

## 2. All zero strata and the reduced determinant

For nonzero u with zero divisor D, the sheaf kernel of b_u is T(D),
the image of a_u is T, and the image of b_u is M(-D). Thus the only
sheaf homology consists of

    T(D)/T in degree-1,       M/M(-D) in degree0.

Both are supported on D and have length deg D. They have no higher
cohomology. Consequently(3) has dimension deg D. The matrix is square:
Riemann--Roch gives h1(T)=h0(M)=n and h0(V)=h1(V)=r. This proves the
exact corank formula, including nonsimple zeros and every projective point.

The incidence of sections vanishing at a point is a projective bundle
over C because evaluation is onto. It is irreducible and has image a
hypersurface in P(A): a generic such section has just one simple zero.
Indeed length-two evaluation separates two distinct zeros and also first
jets at a repeated zero. Their incidences have codimension at least2
in P(A), whereas the one-zero incidence has codimension1. At a simple
zero the derivative of the section is nonzero, so the incidence-to-image
map is generically an isomorphism, not an inseparable multiple cover.
This defines the reduced irreducible resultant Delta.

Its degree is deg(V tensor T^-1)=2n. For example take a generic pencil
and count zeros of its universal section on C x P1. The second Chern
class of (V tensor T^-1) tensor O_P1(1) has degree deg(V tensor T^-1).
The preceding generic-simple-zero calculation identifies this with the
degree of the reduced resultant, in arbitrary characteristic.

There are admissible sections (the incidence is a proper hypersurface),
so det D is nonzero. The lower r rows force r entries from a, and the
last r columns force r entries from q. Every nonzero determinant term
therefore uses n-r entries from B and has degree

    r+r+2(n-r)=2n.

The corank formula says that its zero set is exactly the resultant.
Since both have degree2n, det D is a nonzero constant times Delta, with
no extra power or additional factor. In particular the assumptions imply
r<=n. The matrix construction itself does not impose a characteristic
restriction through this degree computation.

## 3. The acyclic case and inverse cup products

Suppose r=0. For every xi, a_u i_T xi has a unique Cech primitive modulo
the nonexistent H0(V). Applying b_u gives a closed Cech0-cochain. Changing
the representative of xi by d_T t changes its primitive by a_u t and
does not change b_u of it. Hence B is independent of all splitting choices.

For admissible u, the long exact sequence of 0->T->V->M->0 gives an
isomorphism K(eta_u):H0(M)->H1(T). The definition of the connecting map
and the convention d(h_U,h_O)=h_O-h_U show directly that

    K(eta_u) B(u)=I.

If det V=omega, then M=omega T^-1 and Serre duality identifies H1(T)
with H0(M)^vee. The pairing for K(eta) is (s,t)-><eta,st>, symmetric in
s and t in every characteristic. Its inverse B is symmetric on the
nonempty admissible open set, therefore as a polynomial matrix everywhere.

If K is injective, apply a fixed linear left inverse to adj B. On the
admissible open set this equals det B times eta_u; adj B takes values
in im K everywhere by polynomial continuation. This gives an extension
representative of degree2n-2. It has no common divisor: away from Delta,
B is invertible, and at a generic point of Delta it has corank exactly1,
so adj B is nonzero. This is polynomial reconstruction, not a determinant
expansion or a choice of one maximal-minor chart.

## 4. Fixed-curve realization and evidence

Here omega=O(16O), V=W(8O) is stable with determinant omega, and T=O(-16O).
Then M=O(32O), n=24, and V T^-1=W(24O). Length-two separation follows
from Serre duality and stability: the dual obstruction bundle has slope
-24+16+2=-6. The tangent identification in
`dormant_horizontal_tensor_tower`, with the scheme-theoretic equations
and `fixed_x_oper_enumeration`, gives r=0 at all28935 simple points and
r=3 at the55 remaining points. The cup map is injective: in this fixed
monomial model the products of monomials of pole at most32 span L64,
so the dual of multiplication is injective. This also follows from
normal generation of the line bundle omega^2 of degree32.

For r=0 there is a fully bounded scalar implementation. For a basis U_i
of the32-dimensional horizontal space and a Cech basis xi of P16=H1(T),
split U_i xi^5=p+v, with p=aff(U_i xi^5). Its L-image, L=delta^2-P,
is cancelled by a unique b in L32. Then

    h_U=-p+b,       h_O=v+b,       h_O-h_U=U_i xi^5

are horizontal Cech primitives. The polynomial Wh(U,h_U) is the fifth
power of the desired L32 section. Polarization gives B's528 quadratic
coefficient matrices. Change the xi coordinates by the Serre pairing to
make B symmetric. This is the coefficient Frobenius twist of(1), giving

    B(U) K(eta_u)^[5]=I,

not a degree-ten matrix obtained by substituting independent variables U^5.

`scripts/wronskian_quadratic_bezout.sage` checks, for the first new oper,
all768 horizontal splittings, all12672 polarized Wronskian/fifth-power
identities, and all528 matrix symmetries. Five saved admissible directions
give inverse cup product with scalar1. The full saved projective line has
det B=(4a+1)Delta, both degree48. These corroborate the construction but
are not substituted for the all-section proof above. The exceptional27x27
matrices are proved to exist here; their coefficients are not yet computed.

## Literature and limitation

This is a concrete adaptation of the established Koszul/Chow-complex
resultant method, not a claim that determinant-of-cohomology is new.
[Eisenbud--Schreyer](https://arxiv.org/pdf/math/0111040), Theorems1.2--1.4,
construct Chow complexes and recover the resultant from their determinant;
Section4 relates acyclic sheaves on curves to Bezout formulas. Their proof
was checked at the relevant pushforward and determinant steps. Our Cech
kernel calculation supplies the particular mixed blocks and exact corank
needed here, without importing a characteristic-zero resolution.

Small matrices do not prove emptiness of the atlas system. They retain
every quotient and its boundary and give a structured way to continue
the exact nonlinear computation. Other common-cover branches remain open.
