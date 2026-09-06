# Recovering an effective orbifold from its completed branch extensions

Author: /root, 2026-09-06; not independently audited.
[Statement](../Theorems/Thm_completed_local_orbifold_rigidity.md).

## 1. The local extension belongs to the stack, not to its atlas

For an actual finite etale atlas X -> S take its Galois closure in the
finite-etale covering category, W -> S. Then W -> X is etale and W is
a smooth projective scheme curve; S=[W/G]. Completion at a point w gives
the local quotient by its inertia group, with fixed field the completion
of the coarse curve. Residue fields are k. The completion of W -> X is
trivial, so the completed extension of X over the coarse curve is Galois.
Its isomorphism class is the same at every point of the given coarse fiber.
This is the same actual-atlas argument as in
[the local-normality criterion](Sol_unimodular_atlas_normality.md), Section 3;
it does not require the atlas itself to be Galois.

For two atlases of the SAME S, their fiber product is finite etale and
surjective over each. At any point over b its completed field agrees
with the completed fields of both atlases, over the same coarse field.
This proves independence of the chosen atlas.

## 2. The normalized fiber product is etale over both atlases

Suppose S_1,S_2 have the same completed extension at every coarse point.
Let D be any connected component of the normalization of X_1 x_B X_2.
It is finite and surjective over both X_i: at the generic points each
factor is a compositum of finite separable extensions of k(B), so dominates
both factors. At b the completed local tensor products are products of

    L_b tensor_(k((t_b))) L_b.

Since L_b is Galois, this tensor product splits into copies of L_b. After
normalization, the complete local rings of each branch are therefore the
same as those of X_1 and X_2. Each projection D -> X_i is finite etale.
Unramified coarse points give the same assertion with L_b=k((t_b)).
Thus D is a common actual finite etale scheme atlas of S_1 and S_2.

## 3. The two presenting groupoids coincide

Set R_i=D x_(S_i) D. These are schemes finite etale over D, hence normal.
They map to D x_B D. At the generic point of B the stacks are B itself,
because they are effective orbifold curves. Consequently both R_i are
generically the full relation D x_B D, with identical generic maps.

The maps R_i -> D x_B D are finite: both source and target are finite
over D, and an algebra finite over the base remains finite over an
intermediate finite base algebra. They identify R_i with the normalization
of the reduction of D x_B D. No extra component is missing: generically
the full separable fiber product occurs. Hence R_1 and R_2 are canonically
isomorphic over D x_B D.

Under this isomorphism the identity, inverse and composition maps agree.
They agree generically; their sources are reduced finite-etale covers of D
and their targets are separated, so they agree everywhere. Thus the two
groupoids coincide, and S_1=[D/R_1] is isomorphic to [D/R_2]=S_2 over B.
The reverse implication follows already from Part 1.

This proof needs effectiveness and a finite etale scheme atlas. It is not
a classification of arbitrary gerbes or an assertion that every proposed
branch datum is realized by a developable orbifold.

## 4. One wild scalar and two marked coarse points

For the stated Hermitian filtration, the
[local rigidity theorem](Sol_hermitian_local_normality.md) gives, over a
fixed local target parameter, the model a F_t for some a in k^*. This
description is valid after source changes, with all higher target terms
absorbed; the scalar has not been discarded. Its residual ambiguity is
mu_((p^2-1)/t).

Identify the two coarse P^1 curves so that their wild points are zero
and their tame points infinity. A further GLOBAL target scaling aligns
the two scalars a, and hence aligns their wild completed extensions.
The tame extensions at infinity are uniquely determined by their order m,
since k is algebraically closed and p does not divide m. All other
completed extensions are trivial. Parts 1–3 now identify the two stacks.

For the fixed test cases this leaves at most one quotient for (t,m)=(8,7)
and at most one for (24,21). We next identify actual models of both.

## 5. The actual Hermitian quotients have these signatures

Let H:y^5+y=x^6, of genus ten. Put G_1=PSU_3(5) and G_2=PGU_3(5), of
orders 126000 and 378000. Their stabilizers at a rational point of H are
respectively P semidirect C_8 and P semidirect C_24. These stabilizer
facts, including the index-three intersection with PSU, are recorded in
[Montanucci–Zini, Section 2(I) and the paragraph after (IV)](https://arxiv.org/pdf/1804.03398),
printed pp.2–3. The full automorphism group PGU and its standard action
are described there as well. The relevant source passages were read.

Each orbit has 126 points and exhausts H(F_25): for each of the 25 values
of x there are five y, together with infinity. Every nontrivial member
of the explicit Sylow-five group P fixes only infinity. Conjugacy of
Sylow groups consequently shows that any point with wild stabilizer
belongs to this same orbit. There are no further wild orbits.

Since H/P has rational invariant u=x^25-x, the quotient H/G_i is rational
by Luroth. At the wild orbit the different is E+143, where E=1000 or3000,
by the already verified local action. If m_j are the orders of the
remaining tame short orbits, Riemann-Hurwitz gives

    sum_j (1-1/m_j)=2+18/|G_i|-(E+143)/E.

This is 6/7 or20/21. Each positive summand is at least 1/2, so exactly
one such orbit occurs, of inertia seven or21. Thus [H/G_1] and [H/G_2]
realize the two signatures. Part 4 identifies any actual orbifold of
the corresponding signature with this model. The map [H/G_1] -> [H/G_2]
is finite etale of degree three, by subgroup inclusion.

## 6. An explicit common genus-two atlas

Use the projectively equivalent Fermat model H:X^6+Y^6+Z^6=0, and choose
a primitive cube root zeta. The projective transformations

    D=diag(1,zeta,zeta^2),      S:(X,Y,Z)->(Y,Z,X)

generate a group A of order nine: they commute projectively, are
independent of order three, and both lie in PSU. On XYZ nonzero set

    r_1=X^3/(XYZ), r_2=Y^3/(XYZ), r_3=Z^3/(XYZ),
    a=r_1+r_2+r_3, b=(r_1-r_2)(r_2-r_3)(r_3-r_1).

These functions are A-invariant. They satisfy r_1 r_2 r_3=1 and
sum_(i<j) r_i r_j=a^2/2, the latter because sum r_i^2=0 on H. The cubic
with roots r_i has discriminant

    b^2=-a^6/4+5a^3-27=a^6+3                 in characteristic five.

This defines a smooth genus-two curve Q'. The function a has exactly
18 simple poles on H: the intersections with the three coordinate
lines. Its numerator is nonzero there, since a sixth root of -1 has
cube not equal to -1. Hence deg(a)=18, and H -> Q' has degree nine.
It is separable, and Riemann-Hurwitz reads 18=9*2, so it is etale.
The invariant subfield is exactly k(Q'), since |A|=9. Thus Q'=H/A is
also an actual etale atlas of both quotient stacks.

Q' is isomorphic over k to Q:y^2=x^5-x. To see this without a genus-two
classification, the branch set a^6=2 is a norm circle in F_25. Choose
xi in F_25 minus F_5, and beta with beta^6=2. The Mobius map

    x -> beta (x-xi)/(x-xi^5)

sends P^1(F_5) onto that circle (including the value at infinity).
It therefore identifies the two hyperelliptic branch sets, and over
algebraically closed k identifies their double covers.

For any other curve atlas C of either stack, normalize a component of
C x_S Q. Both projections are finite etale, so C and Q have a common
finite etale cover. This is a consequence of actual maps to S, not a
claim that arbitrary curves have maps to S.

## 7. This common-cover class also contains an ordinary Fermat quartic

Let T have function field

    k(t)(u_1,u_2,u_3),
    u_1^2=t, u_2^2=t^2-1, u_3^2=t^2+1.

The square classes are independent by their distinct simple roots. The
(C_2)^3-cover of P^1 has six branch points, including infinity, and each
inertia group is generated by one individual sign change. Thus g(T)=5.
The subgroup of even sign changes, order four, meets all inertia trivially.
Its quotient is Q, via y=u_1u_2u_3, y^2=t^5-t; hence T -> Q is etale.

The simultaneous sign change tau also meets no inertia group and acts
freely. Its quotient has genus three. The projective coordinates
[u_1:u_2:u_3] are tau-invariant and satisfy

    u_3^4-u_2^4=4u_1^4.

They identify the quotient with this smooth plane quartic: the ratios
determine the three u_i up to simultaneous sign, using u_3^2-u_2^2=2.
Over k it is a Fermat quartic F. Thus T -> F is etale of degree two.

For explicit ordinarity checks, the even nontrivial characters of
(C_2)^3 give a prime-to-five isogeny from J(F) to the product of

    E_12:v^2=t^3-t, E_13:v^2=t^3+t, E_23:v^2=t^4-1.

The coefficients of t^4 in the squares of these polynomials are 3,2,3,
respectively, so all elliptic factors and F are ordinary. For Q the
Cartier-Manin entries in (t^5-t)^2 at indices4,3,9,8 are all zero,
so Q is superspecial. This actual bi-etale example prevents using
ordinary versus superspecial as an unrestricted common-cover obstruction.

It remains open whether the fixed genus-nine curve is an atlas of either
Hermitian quotient. We do not claim a converse from membership in the
common-cover class of Q to being such an atlas, and no part of the
coreless branch has been removed by this quotient classification.
