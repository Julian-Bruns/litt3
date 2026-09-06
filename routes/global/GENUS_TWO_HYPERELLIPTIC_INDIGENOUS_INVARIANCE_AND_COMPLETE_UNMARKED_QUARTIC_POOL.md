# Hyperelliptic invariance and the complete unmarked quartic pool

Date: 2026-09-05. Author: `/root/genus_two_hyperelliptic_indigenous_invariance`.
Status: structural proof using a primary-source torsor theorem and the existing
exact Cartier certificates. No new finite-field enumeration is used.

Let k be algebraically closed of characteristic 5. The unmarked condition
below means that the indigenous bundle is regular on the whole proper curve,
with no logarithmic markings.

**Theorem.** On any smooth projective genus-two curve C/k, the hyperelliptic
involution fixes the isomorphism class of every unmarked indigenous PGL2
bundle. Its square Hasse invariant in H^0(C,omega_C^4) is consequently
hyperelliptic-invariant. In particular, if

    0 != s in H^0(C,omega_C^4),
    C_3(s^4) = s,             div(s) = 2D,   D reduced,

then the hyperelliptic involution fixes s.

For X: y^2=x^5-x, this proves that the complete pool of these normalized
quartics consists of exactly 70 tensors over k: ten quadratic squares and
sixty nonsquares. Every associated indigenous projective bundle is ordinary.

## 1. The natural affine torsor, including characteristic and spin conventions

Write I(C) for isomorphism classes of unmarked indigenous PGL2 bundles on
the fixed curve C. The required primary result is Wakabayashi,
[*The symplectic nature of the space of dormant indigenous bundles on
algebraic curves*](https://arxiv.org/pdf/1411.1197), version 3,
Proposition 2.8.1 (PDF p.17): I(C) is a torsor under H^0(C,omega_C^2).
The ground ring in Section 1.1 is any Z[1/2]-algebra, so this assertion
applies in characteristic five. The functorial addition is constructed in
Section 2.8. Sections 2.6–2.7 identify the objects with second-order
operators using a theta characteristic, then give the canonical projective
description. The proof of Proposition 2.7.1 handles changing the theta
characteristic by a line with trivial square. Proposition 2.1.2 states
that the indigenous objects have no nontrivial automorphisms.

Thus the torsor here is the projective moduli problem itself; choosing a
spin structure is an auxiliary presentation. In particular its naturality
gives, for every automorphism a of C and every q in H^0(C,omega_C^2),

    a^*(E + q) = a^*E + a^*q.                         (1)

No choice of a lift of a to a particular spin line is required.

## 2. The finite-order translation argument

More generally, let a be a finite-order automorphism of a proper smooth
curve of genus at least two in odd characteristic, assume its order n is
invertible in k, and suppose a^* is the identity on H^0(omega^2). Choose
E in I(C) and write a^*E=E+b. Equation (1) implies by induction that

    (a^*)^j E = E + j b.

Since a^n=id, we get nb=0, hence b=0. The same computation starting at
any E proves that a acts trivially on the entire torsor. This is an
argument on actual objects up to isomorphism, not just on tangent spaces
at a special object.

For genus two the multiplication map

    Sym^2 H^0(C,omega_C) --> H^0(C,omega_C^2)

is an isomorphism: in a hyperelliptic presentation the three products
are the independent tensors eta^2, x eta^2, x^2 eta^2, and both spaces
have dimension three. The hyperelliptic involution acts by -1 on
H^0(omega_C), hence by +1 on H^0(omega_C^2). Its order is two, which
is invertible in k. The preceding argument applies to every E.

## 3. Naturality of the square Hasse invariant

The square Hasse invariant is intrinsically the composite

    tau_C^tensor5 --Psi_E--> Ad(E) --Hodge projection--> tau_C.

The second arrow is restriction to the Hodge section followed by the
inverse Kodaira–Spencer isomorphism. The Hodge section, connection,
p-curvature, and Kodaira–Spencer map are preserved by isomorphisms of
indigenous objects and commute with pullback by curve automorphisms.
It follows directly that

    H_(a^*E) = a^*H_E.

The identification Hom(tau_C^tensor5,tau_C)=omega_C^4 is natural too.
Thus E isomorphic to iota^*E implies iota^*H_E=H_E; there is no
undetermined scalar or sign coming from a choice of vector-bundle lift.

For the normalized quartic s with div(s)=2D, the
[inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md),
Section 1, gives an unmarked active nilpotent admissible indigenous
projective bundle E_s and computes H_(E_s)=-s. Therefore

    iota^*s = s.                                      (2)

This invokes the Bouw–Wewers construction only with the reduced divisor
condition specified above. It does not assume that all seven-variable
quartic eigenforms give unmarked indigenous bundles.

## 4. Exhausting the equal-order-two pool on the superspecial curve

On X put eta=dx/y. Its quartic basis is eta^4 times

    1, x, x^2, x^3, x^4, y, xy.

The first five basis elements are invariant under iota:(x,y)->(x,-y);
the last two are anti-invariant. Equation (2) forces both y coefficients
to vanish. Thus the classification in the
[quartic certificate](SUPERSPECIAL_GENUS_TWO_QUARTIC_DEGREE_FOUR_CERTIFICATE.md),
previously restricted to this five-dimensional subspace, exhausts every
normalized quartic with divisor 2D, D reduced, over the algebraic closure.

Its ten quadratic squares have four distinct zeros, each of order two.
They come from the twenty normalized quadratic eigenforms with reduced
zero divisor, paired by q and -q. The other fifteen quadratic squares in
that certificate have positive zero orders (4,4), so are outside this
pool. Its sixty nonsquares have two simple branch zeros on the base
and one double nonbranch zero. After moving the branch pair to {0,infinity},
the normalized representative is

    s_t = 4t^3 x(x-t)^2 eta^4,          t^4 = -1.

There are four choices for t for each of the fifteen unordered branch
pairs. The quartic certificate proves that the normalized scalar is
unique and that the alternative of four simple branch zeros cannot
satisfy the eigenform equation. Consequently the count is precisely

    10 + 15*4 = 70.

This is a count of tensors on the fixed curve, not of automorphism orbits.

## 5. Ordinariness of all seventy associated objects

For the ten squares s=q^2, the ordinary test in the inverse-character
criterion is T_s(t)=C_1(q^2 t). It is the same test as for the quadratic
datum q. The
[quadratic certificate](SUPERSPECIAL_GENUS_TWO_QUADRATIC_CARTIER_EIGENFORMS_CERTIFICATE.md)
computes the corresponding three-dimensional nontrivial-character
Cartier blocks via the genus-three quotient and proves that all ten are
invertible. Equivalently, its nonzero quadratic eigenforms are reduced,
and the reduced-divisor instances satisfy the ordinary criterion.

The sixty nonsquares form one orbit under automorphisms of X over k.
Indeed PGL2(F5) acts transitively on unordered branch pairs. Once the
pair is {0,infinity}, the maps x->a x, a in F5^*, act transitively on
the four roots of t^4=-1. Each such base transformation lifts to X
over k. Pullback preserves the normalized Cartier equation, and the
uniqueness of its normalized scalar identifies the transformed tensor
with the designated representative. Choosing pullback rather than
pushforward replaces a by its inverse, which gives the same orbit.

For t^2=2, the quartic certificate computes both faithful-character
Cartier blocks of the degree-four root cover, with determinants t and
4t. In particular the inverse character block is invertible. The
inverse-character criterion proves ordinariness for this representative.
Naturality of Cartier, or equivalently of the ordinary indigenous
condition, proves it for all sixty.

The same criterion then implies that the finite equimultiple
intersection E_4(X) intersect S_2 is reduced at all seventy of its
geometric points. This conclusion is about that intersection, not the
whole seven-variable eigenform scheme.

## Scope

The structural invariance theorem works for every genus-two curve in
characteristic five. The explicit count and ordinary conclusion use
the certificates specific to y^2=x^5-x. Eigenforms outside div(s)=2D
remain outside the completeness statement, and this note proves no
claim about a second etale map or about common etale covers.
