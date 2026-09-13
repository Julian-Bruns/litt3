# Proof: the resultant matrix, its inverse block and selected columns

[Statement](../../Theorems/atlases/cohomological_bezout.md).

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

## 3. The inverse block and primitive representative for every r

For admissible u solve D(u)(xi,v0)=(m,0). The lower equation makes
`v=h_V a_u i_T xi+v0` a Čech primitive of a_u i_T xi. Its image b_u v
is closed, so P_M acts as the identity; the upper equation says b_u v=m.
The fixed connecting-map convention therefore gives

    (D^-1)_11=K(eta_u).

The long exact sequence is

    0 -> H0(V) --q--> H0(M) --K--> H1(T) --a--> H1(V) ->0,

which proves all ranks, kernels and images. Fixed splittings extend by
scalars, so these are regular identities on the entire admissible open,
not merely pointwise statements.

Assume K injective. Then r<n: otherwise K(eta_u)=0 implies eta_u=0,
giving V=T⊕M. But VT^-1=O⊕MT^-1 cannot have sections surject onto
its restriction to two distinct points in the O component. This
contradicts length-two separation. Thus `(adj D)_11` is nonzero at
every admissible u. Every entry has degree2n−2: its cofactor uses r
entries from q, r from a, and n−r−1 quadratic entries from B.
Polynomial continuation puts this whole block in im K everywhere.
A fixed left inverse yields e_D=det(D)eta_u on the admissible open.

If e_D had a nonconstant common factor, its zero hypersurface would lie
inside the irreducible resultant. That factor would therefore contain
the degree2n resultant, impossible for entries of degree2n−2. This
proves primitivity uniformly in r without inspecting generic cofactors.

When r=0, every a_u i_T xi has a primitive unique modulo the absent
H0(V), and changing its representative by d_T t changes the primitive
by a_u t. Applying b_u kills that change. Hence B is independent of all
splittings and equals K(eta_u)^-1. If det V=omega, the cup pairing is
`(s,t)-><eta,st>`, symmetric in every characteristic. Its inverse is
symmetric on the dense admissible open, hence polynomially everywhere.

## 4. Why selected columns suffice

Suppose (C) holds at a geometric point. Each selected column gives a
pair of regular local sections

    h_V a_u i_T xi+z

whose differential is a_u i_T xi. Applying b_u makes the pair closed,
and the upper equation identifies its image with the selected global
section of S. If u has zero divisor E, every such image belongs to
H0(M(-E)). Since S generates M, E is empty. The case u=0 contradicts
Q_S!=0. Thus det D belongs to no maximal ideal in the finite-type
coordinate ring of (C), so it is a unit in that ring itself.

Now `[Gamma Q_S;Z]=D^-1[Q_S;0]`. Both top blocks belong to the fixed
space im K. Restriction to Q_S is an injective map of finite-dimensional
vector spaces and therefore split; it stays injective over every
coefficient algebra. Consequently Gamma=(D^-1)_11, including all
nilpotents, and Z is unique. The converse is immediate. If variables
eta are used to parameterize Gamma=K(eta), this equivalence still holds;
only recovering eta uniquely additionally requires K injective.

Serre duality identifies restriction of K to S with the dual of
`S⊗H0(omega T^-1)->H0(omega M T^-1)`. Surjectivity gives the stronger
injectivity on E itself. This proves the stated sufficient condition
and explains why M² belongs only to the self-dual special case.

## 5. Minor patches and self-duality

The long exact sequence shows that q and a have rank r on the admissible
open, so their maximal-minor opens cover it. On any such patch, P identifies
k^m with ker a and L identifies H0(M)/im q with k^m. Elementary block
elimination gives

    det D=±det(q0)det(a0)det(LBP),
    (D^-1)_11=P(LBP)^-1 L.

The constraints a Gamma=0 and Gamma q=0 give Gamma=P Z0 L uniquely,
where Z0 is the unselected-row/unselected-column submatrix. Because L
has a right inverse, L B Gamma=L is precisely Bbar Z0=I. A square
one-sided inverse over a commutative ring is its inverse. Logarithmic
differentiation of the determinant identity proves the trace formula,
including the derivatives of P and L inside Bbar.

When det V=omega, pairing H1(V) with H0(V) by the wedge and using
Serre duality gives a=q^T: `(u xi) wedge v=xi b_u(v)`. With the same
minor on both sides, L=P^T. On the admissible part of this patch Bbar^-1
is a principal submatrix of the symmetric cup matrix, hence Bbar is
symmetric. The patch's universal ring is a localization of the integral
polynomial ring k[u]; its admissible open is dense. Symmetry therefore
holds identically there and remains true after any base change, including
to nonreduced rings. Equal row/column permutations cancel their signs,
leaving `det D=(-1)^r det(q0)^2 det(Bbar)`. For symmetric Gamma the
equation Gamma q=0 also implies q^T Gamma=0, giving the shorter criterion.

## 6. Acyclic construction after a finite map to the projective line

Let pi:C->P1 be finite of degree d, det V=omega, and H0(V)=0. Since
chi(V)=0, H1(V)=0 too. Every summand of pi_*V has both cohomologies
zero, so pi_*V=O(-1)^(2d). The wedge pairing followed by dualizing trace
is perfect alternating into omega_P1; in this frame its matrix J is
constant. This is dualizing trace, not an assertion that the ordinary
trace of an inseparable function-field extension is nonzero.

Write pi_*M=⊕O(d_i). Since H1(M)=0, d_i>=-1. The row i of the matrix
P(z) of b_u has degree at most d_i+1. The self-dual section complex gives
`P(z)J^-1 P(z)^T=0`; hence P(z)J^-1 P(w)^T is divisible by z-w. Its
quotient is symmetric on exchanging the two arguments and has degree
at most d_i in row i's z variable and d_j in column j's w variable.
Rows with d_i=-1 contribute no sections. The two-affine-open Čech
calculation splits a principal part's image under the adjoint of P
into its positive and negative powers. Its unique primitive in O(-1)^(2d)
gives exactly this divided difference, with the fixed connecting sign.
Thus its coefficient matrix in the matching dual bases is B from Section3.

## 7. Fixed-curve realization and retained evidence

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

`scripts/atlases/wronskian_quadratic_bezout.sage` checks, for the first new oper,
all768 horizontal splittings, all12672 polarized Wronskian/fifth-power
identities, and all528 matrix symmetries. Five saved admissible directions
give inverse cup product with scalar1. The full saved projective line has
det B=(4a+1)Delta, both degree48. These corroborate the construction but
are not substituted for the all-section proof above. The exceptional27x27
matrices are proved to exist here; their coefficients are not yet computed.

For pi=x of degree3, pi_*M=O(10)+O(7)+O(4), and b_u is a3 by6
polynomial matrix with row degrees at most11,8,5. The first-oper
implementation uses six horizontal functions in L47 representing
H0(W(11O)),15 frame Wronskians and192 quotient/frame Wronskians. Each
is replayed as a fifth power in L22 or L35. The formula
`Tr_x(h theta)=3*[y²]h dx` gives J. In the saved conventions the kernel
`-P(z)J^-1 P(w)^T/(z-w)` multiplied by4 matches the old B tensor.
Every one of its304,128 coefficients agrees with all528 old quadratic
matrices, not merely sampled sections.

The same receipt checks a nonzero56-square minor in the56 by72 product
matrix for S=<y,x^10,x^4 y²>. Thus S·L32=L64 for every oper, since this
calculation uses only the curve and its fixed monomial basis. The source
is `scripts/atlases/check_pencil_bezout.sage`; the original receipt remains in
`../litt3-computation-data/pencil-bezout-first-20260908-v2/certificate.json`.
The two checks took1.56seconds together, which is not an atlas-solver
timing. The rational-pencil construction is not applied to r=3.

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
