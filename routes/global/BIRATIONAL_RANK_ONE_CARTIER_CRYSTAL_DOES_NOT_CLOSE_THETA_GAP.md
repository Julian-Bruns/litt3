# Rank-one Cartier crystals and the restricted Raynaud-theta gap

Date: 2026-09-06. Bounded proof/literature test by
`/root/birational_rank_one_cartier_crystal_test`.
Status: precise failure of a proposed proof step; **not** a counterexample
to the generic restricted-theta assertion.

## Question and verdict

Let C be a smooth projective curve in characteristic 5, and let
a:C -> A be unramified and birational onto its image. Assume that its
translated tangent map is birational. Does

    H^0(C^(1), B_C tensor a^(1)*L) = 0

hold for general L in Pic^0(A^(1))?

This check does not decide that assertion. The proposed extra input that
a_*omega_C has a simple rank-one constant Cartier crystal on its image
does **not** close the existing Hacon--Patakfalvi/Baudin proof gap.
The problem persists for the canonical, minimal, rank-one representative;
it is not merely an artifact of higher-rank finite-cover representations.

The exact missing assertion is full generic rank g(C)-1 of a map of
twisted global sections. Rank one on the support is not rank one of
these global-section spaces.

## The coherent calculation that remains necessary

Put N=a^(1)*L. The Cartier sequence on C^(1) is

    0 -> B_C -> F_C*omega_C -> omega_C^(1) -> 0.

Here the first term identifies with the image of d:F_C*O_C -> F_C*omega_C,
and hence with the usual Raynaud bundle defined from F_C*O_C/O_C^(1).
Projection formula gives the twisted map

    c_N: H^0(C, omega_C tensor F_C^*N)
             -> H^0(C^(1), omega_C^(1) tensor N).

For general L both N and F_C^*N are nontrivial: the pullback homomorphism
has positive-dimensional image because a is nonconstant, and Frobenius
pullback on Pic^0 has finite kernel. Riemann--Roch gives dimension g(C)-1
on both sides. Consequently

    h^0(B_C tensor N) = (g(C)-1) - rank(c_N).

Thus the target statement is precisely det(c_N) != 0 generically on the
parameter variety. Neither simplicity nor coherent generic rank one
evaluates this determinant.

Suppress relative twists when discussing absolute Cartier modules, and
put M=a_*omega_C. The finite pushforward Cartier map is surjective:

    c: F_A*M -> M.

At the generic point of the image its source has coherent rank 5 and
its target rank 1. Its kernel K has rank 4. The Cartier structure on
F_A*M is F_A*c, and its restriction to F_A*K is zero because c(K)=0.
Thus K is a nonzero coherent sheaf with zero Cartier structure.
The map c is an isomorphism in Cartier crystals, regardless of the
twisted global rank deficit above.

This is also completely visible locally: for a separating parameter t,
Cartier kills dt,t dt,t^2 dt,t^3 dt and sends t^4 dt to dt. Passing from
the rank-five source to its rank-one crystal discards precisely these
four local coherent directions.

## Why minimality does not repair this argument

Blickle--Boeckle, *Cartier modules: finiteness results*, Definition 3.7,
Lemma 3.8 and Theorems 3.10--3.12, establish canonical minimal
representatives and identify their morphisms with crystal morphisms.
Minimal means having neither nilpotent submodules nor nilpotent
quotients. See [the primary paper](https://arxiv.org/pdf/0909.2531),
printed pp. 21--22.

This prevents an excessively strong claim that a crystal can never
recover its canonical coherent representative. It can. The actual
failure is that F_*omega_C is not minimal: its nonzero submodule B_C has
zero Cartier structure. Replacing it by its minimal representative
changes the coherent source used in c_N. The lemma upgrading a
nil-isomorphism between two minimal objects to an ordinary isomorphism
therefore does not apply to F_*omega_C -> omega_C. Nor does global
cohomology preserve minimality or simplicity.

Already on a smooth connected curve omega_C is simple as a coherent
Cartier module. Indeed a nonzero coherent submodule is omega_C(-D) for
an effective divisor D. At a point of multiplicity m its Cartier image
has multiplicity floor(m/5), so stability forces m=0. Nevertheless its
global cohomology can have entirely nilpotent Cartier action, as the
example below proves.

## What the cited generic-vanishing proof actually gives

For the perverse object P=a_*F_p[1], proper projection gives

    H^0(A_et, P tensor E) = H^1(C_et, a^*E).

This is precisely the degree left unrestricted by perverse generic
vanishing. Baudin's Theorem 6.3.2 controls the support of the other
degrees; equation (6.3.2.f) in its proof identifies the relevant groups
with inverse limits of Cartier cohomology. It supplies no equality
between the dimension of this degree-zero group and g(C)-1.
See [Baudin, v2, Section 6.3](https://arxiv.org/html/2306.05378v2#S6.SS3).

Hacon--Patakfalvi's Theorem 1.1 likewise concerns Frobenius-stable
cohomology support. Remark 1.3 explicitly separates ordinary cohomology
vanishing from vanishing of the inverse limit due to nilpotent action.
Its methods do not distinguish these in the stated way. See
[the primary paper](https://arxiv.org/pdf/2009.12041), printed p. 3.
Adding simplicity of P does not change which cohomological degree the
theorem controls.

## An explicit canonical example showing the precise danger

This example disproves a *pointwise* promotion from simplicity,
minimality and birational Gauss geometry to full Cartier rank. It does
not disprove the requested *generic* statement.

Over an algebraically closed field of characteristic 5, take the smooth
plane sextic

    C: x^6 + y^6 + z^6 = 0,

and its Abel--Jacobi embedding a:C -> J(C). Its genus is 10, and
omega_C=O_C(3); hence its canonical map is an embedding. The translated
tangent map of a is exactly this canonical map, so both birationality
hypotheses hold in their strongest form. Its canonical Cartier module
is simple and minimal as above (and stays so under this closed
immersion).

Here is an elementary verification that Frobenius on H^1(C,O_C) is
zero, without needing a superspecial-curve classification. The plane
equation identifies this cohomology with H^2(P^2,O(-6)), with Cech basis

    x^(-a)y^(-b)z^(-c),  a,b,c >= 1,  a+b+c=6.

Write f=x^6+y^6+z^6. Frobenius on this model is u |-> f^4 u^5.
A term of f^4 is x^(6i)y^(6j)z^(6k) with i+j+k=4. For its product with
u^5 to survive in H^2, all three exponents must be negative. Since
1<=a,b,c<=4, this requires

    i <= a-1,  j <= b-1,  k <= c-1,

and hence 4=i+j+k <= a+b+c-3=3, impossible. Thus Frobenius is zero.
By duality Cartier is zero on all ten global canonical forms, and the
Raynaud sequence yields h^0(C^(1),B_C)=10.

Therefore even this simple minimal canonical crystal with embedded
support and an embedded translated Gauss map can have maximally
nilpotent global Cartier cohomology. Any proof of the desired generic
assertion must use variation in L to exclude that deficit on an entire
parameter abelian subvariety. That is the remaining geometric statement;
the cited crystal simplicity and generic-vanishing results do not prove
it. The example deliberately uses the full Jacobian, where the known
Raynaud theta theorem gives generic vanishing, so it must not be
presented as a counterexample to the question.
