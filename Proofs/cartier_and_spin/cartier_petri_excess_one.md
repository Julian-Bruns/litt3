# Proof: the first complementary Cartier direction

[Statement](../../Theorems/cartier_and_spin/cartier_petri_excess_one.md).
The proof first isolates the general two-map linear algebra, then
checks its hypothesis on the fixed X by a small exact calculation.
The [independent audit](../../Research/audits/CARTIER_PETRI_EXCESS_ONE_AUDIT_2026_09_15.md)
passes both the argument and a separate reconstruction of the arithmetic.

## 1. Pairing, trace, and a first-order rank test

Use relative Frobenius and scalar twists throughout. Sections of B_C
can be represented by locally exact differentials on C. If alpha=da
and beta=db locally, the canonical pairing is

    mu_C(alpha,beta)=Cartier_C(a db).

It is well-defined, alternating and nondegenerate on the rank p-1
bundle B_C, and identifies B_C with B_C^dual tensor omega_(C^(1)).
Changing a by a p-th power does not affect the expression because
Cartier(beta)=0. Alternation follows from Cartier(d(ab))=0.
This is the usual Cartier--Petri pairing; nondegeneracy is
[Tong, Proposition1.2.1.1](https://arxiv.org/pdf/0712.2046).
See also the
[earlier audited two-trace proof](../../routes/global/GENERIC_TWO_LEG_THETA_FAILURE_FORCES_CARTIER_PETRI_TRACE_ORTHOGONALITY.md).

For an actual finite etale f:Z->X, the trace on locally exact forms
and the pairing satisfy

    Tr_(f^(1)) mu_Z(f^*alpha,beta)
        = mu_X(alpha,Tr_f beta).                         (1)

Indeed etale base change identifies B_Z=f^(1)*B_X; the pairing is
the pullback pairing, so (1) is the projection formula for the
finite locally free trace. Equivalently, trace commutes with
Cartier and Tr_f(f^*a beta)=a Tr_f(beta). This argument includes
all twists and does not require division by the degree.

For a family of degree-zero twists N_t on a curve, of Euler
characteristic zero, the first-order deformation in a direction
v induces the cup map on H0(B tensor N_t) to H1(B tensor N_t).
If its rank is r at t, the generic h0 is at most h0_t-r. To see
this, split the invertible block from a local equal-rank two-term
cohomology matrix. On a smooth formal arc with tangent v the
remaining h0_t-square block has the form zM+O(z^2), where M is
the cup map. A nonzero r-minor stays nonzero over k((z)), hence
the same generic rank lower bound holds in the original family.
Serre duality identifies M at N=O with the alternating form

    (s,t) |-> <v,mu_Z(s,t)>.                            (2)

## 2. The four-dimensional matrix at the trivial parameters

Write n=deg f. Since n is prime to p, the first trace satisfies

    Tr_f f^*=n.

Thus, when a(X)=3 and a(Z)=4,

    K_Z=f^*K_X direct_sum k*eta,    Tr_f eta=0.            (3)

Choose a basis alpha_1,alpha_2,alpha_3 of K_X. For tangent
parameters xi in H1(X^(1),O) and zeta in H1(Y^(1),O), set

    q_ij=<xi,mu_X(alpha_i,alpha_j)>,
    v_i=<zeta,Tr_(g^(1))mu_Z(f^*alpha_i,eta)>.

The cross Jacobian homomorphism is zero by Hom(JX,JY)=0; its
cotangent map gives Tr_(g^(1))f^(1)*=0 on regular forms.
Equation (1) gives Tr_(f^(1))mu_Z(f^*alpha_i,eta)=0.
Consequently (2), in the basis from (3), is exactly

        [  0      n q12   n q13   v1 ]
        [ -n q12   0      n q23   v2 ]
    M = [ -n q13 -n q23    0      v3 ].                 (4)
        [ -v1     -v2     -v3     0  ]

Its Pfaffian is

    n(q12 v3-q13 v2+q23 v1).                            (5)

Injectivity of mu_X on wedge^2 K_X means that its three products
are independent. By Serre duality, xi can therefore prescribe
q12,q13,q23 arbitrarily. If one of the second-trace forms defining
the v_i is nonzero, choose zeta with (v1,v2,v3)!=0 and then choose
xi so that (5) is nonzero. Thus M is invertible, and Section1
gives generic defect zero. Conversely if all three second traces
vanish then the last row and column of every M vanish, so no
first-order cup matrix at the origin is invertible.

There is a shorter direct bound in this excess-one case. The trace
splits f^(1)_*O=O direct_sum E_f. The first summand B_X tensor L
is generically acyclic by Raynaud's theorem; the trace-free summand
has h0=1 at O, hence generic h0 at most1. Thus the generic defect
on the slice M=O, and then on the whole parameter space, is at most1.
The [later bounded audit](../../Research/audits/RAYNAUD_JUMP_DIVISOR_AUDIT_2026_09_15.md)
also checks this direct trace-splitting simplification. The more general quotient-rank theorem
remains available but is not needed for this particular bound.
Thus positive mixed generic defect means exactly1 and forces the three
trace identities at the ORIGIN, although the origin's h0 is4.
This does not extend the generic-minimum trace theorem to arbitrary
special parameters; it is a consequence of the specific full-rank
test (4). Neither ordinariness of Y nor division by deg(g) enters.

When Y is ordinary, K_Y=0 makes eta doubly trace-zero. If Y is
nonordinary, etale pullback embeds K_Y in ker Tr_f, since the
cross trace-pullback map is zero. Therefore a(Y)=1 and eta=g^*beta
up to a scalar. The projection formula in the other direction
then makes every mixed second trace zero, because Tr_g f^*alpha_i=0.
This explains precisely the role of ordinariness in the intended
application. No claim of nonzero second trace has been made.

## 3. Explicit fixed-X Cartier kernel and stable rank

Work over F25=F5[a]/(a^2+4a+2), so a^2=a+3. A code c0+5c1 denotes
c0+c1*a. Coefficient lists below are in ascending powers of x.
For the fixed X:y^3=F(x),

    F=(11,22,18,5,19,20,15,16,9,22,1).

Every regular form is uniquely

    (A(x)y+B(x)) dx/y^2,     deg A<=2, deg B<=5.

Under the absolute Cartier convention the two blocks are

    N_ij=F_(5i+4-j),        0<=i<3, 0<=j<6,
    M_ij=(F^3)_(5i+4-j),    0<=i<6, 0<=j<3,

and Cartier sends (A,B) to ((NB)^[1/5],(MA)^[1/5]). The same
formulas were used in the
[eigenform proof](fixed_x_cartier_eigenforms.md); only their small
matrices, not its degree1302 finite algebra, are needed here.

Direct exact calculation gives rank N=rank M=3 and

    H=N M^[5] invertible.

Thus the Cartier kernel consists of A=0 and B in ker N. One basis is

    B1=(24,2,1,0,0,0),
    B2=(5,16,0,1,0,0),
    B3=(5,20,0,0,8,1).                                 (6)

The image of Cartier is the direct sum of the full A-space and
im(M^[5]) in the B-space. Invertibility of H makes Cartier an
isomorphism on this six-dimensional image. Consequently every
positive Cartier iterate has rank6. The usual stable-Cartier
description of p-rank gives p-rank(X)=6, and

    dim ker Cartier_X^e=3 for every e>=1.                (7)

In particular a(X)=3. No isogeny invariance of a-number is used.

## 4. Three independent Petri products

Let alpha_i=B_i dx/y^2. Cartier-zero means that B_i F has zero
coefficients in degrees4,9,14. Hence it has the unique polynomial
primitive P_i with P_i'=B_i F and zero coefficients in every
degree divisible by5. Its degree is at most16, and

    h_i=P_i/y^5,       d h_i=alpha_i.

These are rational primitives. They compute the same local pairing
as regular local primitives: their difference is a fifth power,
and Cartier(alpha_j)=0 removes that difference from the product.
If C_pol extracts coefficients at degrees5r+4 and takes their
inverse fifth powers, then y^3=F gives the exact formula

    mu_X(alpha_i,alpha_j)
        = C_pol(P_i B_j F) dx/y^2.                      (8)

Over F25 inverse fifth power equals fifth power. This display uses
absolute Cartier and its semilinear identification of the twists;
linearizing on X^(1) does not change independence or any rank claim.

For the ordered pairs12,13,23 the output polynomials in (8) are

    (4,16,3,18,21,0),
    (10,13,0,10,6,0),
    (15,3,3,18,18,4).                                  (9)

Multiplying their coefficient columns by N gives

        [21  5 19]
    T = [24 22 20],     rank T=3.                       (10)
        [21  6 21]

Thus (9) are independent, and their span is mapped injectively by
Cartier to the A-space. In particular these Cartier--Petri products
are not themselves Cartier-killed. That is a useful boundary of
the trace obstruction; such a kernel assertion cannot be assumed.

## 5. Reproducible small evidence and scope

The standalone [source](../../scripts/arithmetic/fixed_x_cartier_petri.py)
uses exact arithmetic in F25. It checks the whole kernel, every
primitive derivative, alternation for all nine products, and the
matrix ranks above. Its
[receipt](../../../litt3-computation-data/primitive_mixed_theta_20260915/fixed_x_cartier_petri.json)
contains complete small matrices and coefficients. No large
eigenform replay, parameter-point search or new cover enumeration
was performed. The audit separately reconstructed the field arithmetic,
kernel, primitives, all nine products and every needed rank, without
reading or running the source script. Its
[small receipt](../../../litt3-computation-data/primitive_mixed_theta_20260915/fixed_x_cartier_petri_independent_audit.json)
agrees exactly. The trace identities, hypothesis removals, Pfaffian
criterion and stable-rank interpretation also pass.

The criterion leaves one explicit geometric obligation: show that
the extra trace-zero Cartier form has a nonzero mixed second trace,
or find higher-order escape when all three vanish. Joint minimality
has not settled that obligation. Even success would prove this
restricted generic-vanishing case, not the whole common-cover problem.
