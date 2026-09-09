# Does the ramified seventh-root symmetry obstruct a coreless span?

Work over k = the algebraic closure of F_5. Decide the following precise
statement, by a proof or an actual counterexample. This is a bounded
structural subproblem motivated by Litt's common finite-etale cover
problem, not a request to solve that entire problem.

Fix a primitive seventh root of unity zeta. Suppose A, B, W are smooth
projective connected curves, with finite etale surjections

    f: W -> A,     g: W -> B.

Suppose A, B, W have order-seven automorphisms sigma_A, sigma_B, sigma_W,
and BOTH maps are equivariant for these specified generators. Assume:

1. A and B carry nonzero exact regular differentials alpha_A=dH_A and
   alpha_B=dH_B, with f*alpha_A=g*alpha_B and
   sigma_A*alpha_A=zeta alpha_A, sigma_B*alpha_B=zeta alpha_B.
2. On each endpoint, the fixed-point divisor D_i of sigma_i is nonempty
   and reduced, and div(alpha_i)=8D_i. Thus every zero is fixed and every
   fixed point is a zero; the cyclic quotient is unramified elsewhere.
3. The quotient B_0=B/<sigma_B> is ORDINARY of genus TWO. The quotient
   A_0=A/<sigma_A> has genus at least two; impose no ordinarity condition
   on A_0.
4. The fixed-point divisor on W is exactly f^{-1}D_A=g^{-1}D_B.
   In particular, the induced maps W_0=W/<sigma_W> -> A_0,B_0 are also
   everywhere etale, not just maps of coarse curves with unspecified
   ramification.

QUESTION: Must f*k(A) intersect g*k(B) contain a nonconstant function
inside k(W)? Equivalently, can a CORELESS span satisfy all four conditions?
Here coreless means precisely that this embedded field intersection is k;
it does not merely mean the absence of one common invariant function under
a self-map. Neither original leg is assumed Galois.

## Why this exact statement matters

Riemann-Hurwitz forces g(B)=29 and deg D_B=7. If g(A_0)=h, then
g(A)=28(h-1)+1 and deg D_A=7(h-1). Our application has h=9, hence g(A)=225.
Do not replace the actual cyclic actions by these numerical consequences.

These data arise canonically from a possible shared weight-seven tensor
s_i in H^0(A_0 or B_0,omega^7) with div(s_i)=2E_i and zero eligible
Cartier image. Normalize its seventh-root cover, with tautological
one-form alpha_i satisfying alpha_i^7=pi_i*s_i. The roots are connected,
totally ramified above E_i, and have the exact differential and cyclic
character above. A shared tensor in an actual coreless bi-etale span
produces such a span upstairs, still coreless. Thus an affirmative answer
would eliminate this entire surviving tensor profile, independently of
the degrees of f and g. It would NOT eliminate other profiles or spans
with no shared tensor.

The one-endpoint conditions are genuinely possible even with ordinary B_0.
For any ordinary genus-two curve v^2=F(u), deg F=5, and F(b)!=0, use the
smooth model

    z^7=(u-b)v,
    alpha=z^2 du/v=(u-b)du/z^5
         =d((u-b)^2/(2z^5)),
    sigma(z)=zeta^4 z, sigma(u)=u, sigma(v)=v.

It has genus29 and seven zeros of order8, at the points above the five
finite Weierstrass points and the two points over b. Its quotient is B_0.
This is an example of endpoint data, NOT an asserted common span, and
need not exhaust all allowed B.

## A proved linear normal form — use without rederiving

The entire weight-seven/divisor2D case, not just the displayed example,
has the following description. On a genus-c curve C, choose a spin line
L with L^2=omega_C. There are 2^(2c) such line-bundle classes. Put L_1
for its Frobenius twist. The twisted Cartier map

    H0(C,L^7) -> H0(C^(1),L_1^3)

is SURJECTIVE for every C, ordinary or not; its kernel K(C,L) has
dimension4(c-1). Choose h in this kernel with reduced nonempty divisor.
In a frame l of L, the root cover and exact differential are

    w^7=h_l,     alpha=w^2 pi^*(l^2).

Conversely every tensor s of the specified profile is h^2 for
L=O(D)omega_C^(-3), and its Cartier condition is precisely h in K(C,L).
Both spin lines and their sections pull back compatibly in the original
etale span. Taking the root covers preserves corelessness in both
directions: reduced zeros ensure full degree7 over the common source,
giving the two linear-disjointness statements needed for the
minimal-polynomial argument.

Thus all possible B are retained by the16 spin lines and four-dimensional
kernels on its ordinary genus-two quotient. This does NOT give a shared
section on an unknown source. Eigenspace dimensions alone also do not
exclude one: the root has a-number >=a(C)+7(c-1) and5-rank
f_5(C)+6b, 0<=b<=2(c-1); these bounds scale with etale base change.

## Known counterexamples and pitfalls — take these as established inputs

Deleting the cyclic-action/quotient hypotheses makes the statement FALSE.
There is an actual coreless bi-etale genus33 span constructed from

    S=k(z,w), w^2=z^8+3,
    x=(z^5+zw)/2, y=(zw-z^5)/2,
    u^5-u=2x^2, v=xy-u,
    r^9=ux^2, s^9=vy^2,
    k(A)=k(x,u,r), k(B)=k(y,v,s), k(W)=S(u,r,s).

Here dx=dy on W, and each differential has eight zeros, all of order8.
Its construction matches exact Artin-Schreier and tame completed fields
locally; globally an A_5 seed closure and solvable endpoint closures give
the needed linear disjointness and corelessness. Independent cyclic etale
degree-seven endpoint refinements even give genus225 and56 order-eight
zeros. They do NOT supply the ramified order-seven actions or ordinary
genus-two quotient required above. Therefore multiplicity, exactness,
genus225, and point counts alone are not obstructions.

One natural symmetry-preserving variant has already failed. The seed
w^2=z^8+4z with x=(zw+z^5)/2, y=(zw-z^5)/2 satisfies
x-y=z^5, xy=z^3 and has a compatible C7 scaling. But
div(dx)=2R+A+B, where A,B are the infinities. A zero of order1 cannot
become order8 under ANY finite separable refinement: its new order is
e+delta; if e<=4 this is2e-1, and if e>=5 it is at least9. Therefore
this seed cannot produce the required span by local ramification absorption.

Likewise the local differential equation is not rigid: after alpha=t^8dt,
its formal stabilizer contains

    t -> lambda t (1+t B(t)^5)^(1/9),
    lambda^9=1, B(t) arbitrary in k[[t]].

Formal branches, matching ramification indices alone, and separate
endpoint examples do not constitute a global counterexample. Conversely,
do not assume a simultaneous Galois closure, that a mod-5 differential
determines a compatible characteristic-zero lift, or that ordinarity of
B_0 makes the ramified cover B ordinary.

Return a rigorous decision if possible. For a negative answer, verify BOTH
projective etale legs, equivariance, the actual ordinary genus-two quotient,
and corelessness. If undecided, give the strongest proved necessary
condition that uses the cyclic action AND both maps; clearly identify the
remaining implication. Do not reprove the supplied counterexample or
spend the response proposing unspecified future strategies.
