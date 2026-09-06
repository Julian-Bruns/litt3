# Double-zero p-closed quotient: discrepancy and an explicit klt model

Date: 2026-09-06. Author: `/root/pclosed_surface_leaf_literature`.
Status: derived structural theorem; not independently audited. No degree
bound, existence theorem, or core assertion is claimed.
**Subsequent checked boundary:** the [genus-seventeen partial Igusa example](UNBOUNDED_DOUBLE_ZERO_HECKE_LEAVES_ON_A_FIXED_GENUS17_CURVE.md)
has unbounded jointly minimal coreless etale leaves with double zeros
on one fixed endpoint pair. Thus these quotient-surface properties alone
cannot imply a universal degree bound. Additional endpoint data are needed.

## Setting and result

Let k be algebraically closed of characteristic 5. Let X,Y be smooth
projective curves of genus at least two, with nonzero regular forms
alpha_X,alpha_Y having divisors 2D_X,2D_Y, where D_X,D_Y are reduced.
On S=X times Y assume the saturated rank-one foliation

    F = ker(pr_X^*alpha_X - pr_Y^*alpha_Y)

is p-closed. This includes the common exact and common Cartier-fixed
cases. Put s_X=g(X)-1, s_Y=g(Y)-1 and N=s_X*s_Y.
Write q:S -> Q=S/F for the height-one quotient.

1. At EVERY point of D_X times D_Y, the quotient Q has an exceptional
   divisorial valuation with discrepancy -3. In particular Q is not
   log canonical at any of these points.
2. Blow up these N points once, obtaining pi:S' -> S. The saturated
   transformed foliation F' is log canonical. Its quotient q':S' -> Q'
   is klt, with exactly 3N singularities, all formally toric of type
   1/5(1,2). There is a proper birational map mu:Q' -> Q.
3. If E_i are the exceptional curves on S' and B_i=q'(E_i), then

       K_Q' = mu^*K_Q - 3 sum B_i,
       q'^*K_Q' = 5 pi^*K_S - 3 sum E_i.

   K_Q' is ample and K_Q'^2 = (191/5)N.
4. For an actual jointly minimal etale span X <- Z -> Y tangent to F,
   let C' be its strict image on S' and Gamma=q'(C'). Put
   t=deg(Z/X)s_X=deg(Z/Y)s_Y. Then the normalization of Gamma is the
   Frobenius twist of Z, and

       K_Q' . Gamma = 17t/5,
       2g(Gamma^nu)-2 = 2t = (10/17)(K_Q' . Gamma).

These assertions allow arbitrary branch counts and contacts in the
joint image. Blowing up once does not assert that C' is smooth.

## Primary-source inputs and their exact scope

The quotient canonical identity, the invariant-divisor pullback rule,
and the comparison of discrepancies are given with proofs in Hiroi,
[*Quotients by (p-1)/p-klt Foliations on Surfaces*](https://arxiv.org/html/2602.20703v1),
Lemmas 3.2.1--3.2.2 and Proposition 3.2.4. In particular, for an invariant
exceptional divisor E upstairs, its quotient valuation B satisfies

    q'^*B=E,   a(B;Q)=a(E;S)+4a(E;F).

The same comparison appears in Posva,
[*Pathological MMP singularities as alpha_p-quotients*](https://www.cambridge.org/core/journals/forum-of-mathematics-sigma/article/pathological-mmp-singularities-as-pquotients/6492B90E42EE6B6B1990968C00ABD2AC),
Theorem 2.10. The proof compares the canonical identities before and
after birational modification, with coefficient one at invariant E.

Posva, [*On the singularities of quotients by 1-foliations*](https://arxiv.org/html/2311.16694v4),
Proposition 3.0.6 and Corollary 3.0.7, identifies a nonnilpotent linear
part of a local saturated generator with a log canonical,
multiplicative singularity on a regular surface. Theorem 4.2.5 gives
the klt quotient. Formal diagonalization and the monomial invariant
ring are described in Proposition 4.1.1. These statements hold in
characteristic 5; no use is made of the converse between klt and
F-regularity, which in that paper requires p>5.

## Local computation

At a grid point choose parameters with

    alpha_X=x^2 A(x)dx, alpha_Y=y^2 B(y)dy, A(0)B(0) != 0.

A saturated generator is

    delta=y^2 B(y) partial_x + x^2 A(x) partial_y.

Its coefficients have no common divisorial factor. In the blowup chart
y=xu its rational pullback is x times

    delta'=x u^2 B(xu) partial_x
              + (A(x)-u^3 B(xu)) partial_u.

At the generic point of E=(x=0), the second coefficient is nonzero,
so delta' is saturated there, E is invariant, and

    K_F'=pi^*K_F-E,   a(E;F)=-1.

Since a(E;S)=1, the quotient discrepancy is 1+4(-1)=-3.
This calculation does not replace the units by constants.

On E, the singularities are exactly the three distinct nonzero roots
lambda of A(0)-lambda^3 B(0). The linear part at such a root is
triangular, with eigenvalues

    lambda^2 B(0),   -3lambda^2 B(0).

Their ratio is 2 in characteristic 5. Both are nonzero and distinct;
the p-closed multiplicative normal form therefore has weights (1,2).
The other chart gives no additional singularity at u=infinity.
Outside the exceptional curves the original foliation was regular.
This proves the local claims and the asserted singularity count.

In particular a rational normalized toral derivation D^5=D must not
be confused with a multiplicative REGULAR local saturated generator
at the original double zero. The original generator has zero linear
part and fails the log canonical condition.

## Global canonical class and positivity

The defining one-form on S vanishes only on the grid, so its saturated
conormal has trivial determinant. Thus K_F=K_S and q^*K_Q=5K_S.
Combining K_S'=pi^*K_S+sum E_i with the preceding local computation
gives the displayed formula for q'^*K_Q'. Its square is

    (25 K_S^2 - 9N)/5 = (200N-9N)/5.

Here K_S^2=8N. To verify ampleness, write
V=pr_X^*D_X and H=pr_Y^*D_Y, so K_S is linearly equivalent to 2V+2H.
For an irreducible curve A on S that is not a component of V or H,
put m=sum_grid mult_P(A). Local intersection gives

    m <= V.A,   m <= H.A.

Consequently (5pi^*K_S-3sum E_i).A' = 10(V+H).A-3m > 0.
For a vertical component of V this intersection is 7s_Y; for a
horizontal component of H it is 7s_X. On each E_i it is 3.
The positive square and these inequalities prove ampleness by
Nakai--Moishezon, and finite descent proves ampleness on Q'.

## Actual etale leaves and the remaining obstruction

Etaleness makes every branch of the joint image a smooth graph over
each factor. Equality of the forms gives exactly t source points
over the grid. Hence

    sum E_i.C'=t,   K_S.C=4t.

The restricted quotient on the generic point of C' has degree 5:
the foliation acts nontrivially on its function field, whose constants
are k(Z)^5. Thus q'_*C'=5Gamma. Projection formula gives

    5 K_Q'.Gamma = (5pi^*K_S-3sum E_i).C'=17t.

This is a relation between genus and degree, not a bound on either.
The birational replacement repairs the ambient quotient singularities
but retains the unbounded branch/contact problem in Gamma. An argument
using a smooth or generically chosen member of a quotient linear system
would need to prove that its normalized pullback has BOTH projection
ramification divisors identically zero. The cited quotient and
singularity theorems do not supply that global condition.

The familiar p-divisor bound is also unavailable here: its defining
p-curvature is identically zero. Mendson's
[*Foliations on smooth algebraic surfaces in positive characteristic*](https://www.sciencedirect.com/science/article/pii/S0022404923000622)
places invariant curves in a fixed p-divisor only for non-p-closed
foliations. Thus neither that bound nor the quotient results prove a
uniform degree bound in the present double-zero case.
