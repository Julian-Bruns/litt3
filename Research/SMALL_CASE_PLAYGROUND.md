# Small examples are tests of mechanisms, not a new degree-by-degree campaign

2026-09-10. Latest user explicitly asks for understanding that transfers
from a playground to the actual common-cover problem. Main endpoints,
paused A18 and paused backup source comparisons are unchanged.

## 1. Tested first: a trace-zero pencil versus a plane

For an actual bi-etale X<-f-Z-g->Y with g(Y)=2 and g_*f^*=0 on
Jacobians, set n=deg f. The family D_x=g_*f^*(x) in Sym^n(Y) has
constant Abel class, hence lies in one complete system |L|, deg L=n.
It moves nontrivially and has no common base point: a fixed point of
Y would otherwise force the finite set g^-1(P) to meet EVERY f-fiber.

If the family lies in a pencil, its parameter map a:X->P1 is
surjective, that pencil is basepointfree, and its map b:Y->P1 satisfies
a f=b g on the ACTUAL source. Thus the span has a core. For n<=3,
Riemann--Roch on Y forces a pencil or impossibility. More generally a
coreless norm-zero span requires n at least d_2(Y), the least degree of
a line bundle with three independent sections. This is an elementary
extension of the existing norm-zero gonality argument, not a new norm
method: see routes/global/75_ORTHOGONAL_COMPLEMENT_DIVISOR_SIEVE.md,
Section1. The older44 norm/nonpencil theorem treats a different diamond.

Degree4 is the first plane case. A coreless span here is jointly minimal:
an inessential factor of the source would leave a degree1 or2 joint
leg, already cored. Its joint image is a divisor of A external-tensor L
in X times Y, with deg L=4, h0(L)=3, deg A=4(g(X)-1), given by an
incidence equation in three pairs of sections. Put m=g(X)-1. Then

    deg f=4, deg g=4m, g(Z)=4m+1, delta(joint image)=20m.

The degree-four map defined by L is either twice the canonical conic
(L=omega_Y^2) or a birational plane quartic. The latter may have a
node OR a cusp; neither boundary may be suppressed. Both maps from
the normalization are etale, but the joint image is necessarily very
singular. A smooth-incidence argument would discard the phenomenon.

This does not yet supply an invariant controlling those singularities
in higher degree. Therefore asking Pro merely to exclude n=4 would be
case elimination, not the transferable breakthrough the user requested.
No such prompt was sent. Nothing here excludes a main common cover.

## 2. Selected laboratory: an actual one-direction Hodge obstruction

The first higher-Witt endpoint obstruction epsilon(C,r) is a class in
coker(Psi_C), not the assertion that Psi_C is singular. The old unsent
prompt asked universal vanishing on arbitrary nonordinary active pairs.
That is too broad without even one evaluated example.

The critical-quartic formulas supply a smaller test: collide two
legitimate critical points while keeping the genus-two curve smooth,
the Jacobian ordinary, the active divisor reduced and the double
nonsplit. With branch pair {t,infinity}, the critical discriminant is

    3(t^4+4t^3+t^2+4t+3),

while the critical/root-scale resultant is the constant4. Specializing
to a root of that irreducible quartic gives an ACTUAL active connection
with exactly ONE nilpotent tangent direction. Its full formulas and
proof are in genus_two_active_critical_quartics v2, Section5; do not
duplicate them here. The exact test takes0.096seconds after Sage startup.

This is the smallest nonzero obstruction DIMENSION, not a claim that
F625 is the smallest possible coefficient field for any such example.
The moving critical root explains the tangent, but NOT whether the
higher obstruction is zero. In particular naive lifting of J=0 or N=0
as integer polynomials modulo25 is not higher inverse Cartier.

New Pro target in PRO_SINGLE_OPER_W3_REQUEST.md: compute the single
Serre pairing <rho(C3),phi> for this fixed canonical C2, retaining the
full previous flow and the nonsplit twist. Require a reusable Cech/
residue recipe identifying the term which survives or cancels. Positive
answer for this test would NOT prove universal one-leg lifting, and
neither answer constructs or excludes an actual common span by itself.

## 3. A transferable consequence of a nonzero endpoint class

Author lemma, not separately audited. Let h:T->C be ANY actual finite
etale cover, and r_T=h*r_C an admissible active connection. The first
Hodge obstruction classes satisfy

    epsilon(T,r_T)=h*epsilon(C,r_C)

in the induced Frobenius cokernels. Indeed lift h to an arbitrary C3
over the canonical C2. The canonical first-lift dictionary and higher
inverse-Cartier naturality identify the source object and pull back its
Hodge obstruction. Passing to the cokernel removes the reference lift.

Trace commutes with Psi. To check this without assuming a prime-to-five
Galois closure, pass to the one-leg closure U. Pullback of Tr_h is the
sum over all embeddings of T over C; Psi commutes with each pullback
and is additive. Injectivity of H1(T_C) pullback then proves the trace
identity downstairs. Integers in F5 are Frobenius-fixed.

If 5 does not divide deg h, trace divided by deg h is a left inverse
on the Psi complexes and on their cokernels. Thus a nonzero endpoint
epsilon cannot be killed by a prime-to-five etale cover.

In particular suppose C<-h-T-j->B is an ACTUAL matched active span and
r_B is indigenous-ordinary. Lift j to the canonical third lift of B;
its pulled-back Hodge line lifts, so epsilon(T,r_T)=0. Consequently

    epsilon(C,r_C)!=0 ==> 5 divides deg h.

This is an all-degree constraint with both actual maps retained. It
does not assert that epsilon(C,r_C) is nonzero for the test pair or for
the fixed main X. When epsilon vanishes there remains the independent
two-leg source-kernel mismatch; do not claim a W3 span lift.

## Next independent work

The Serre functional is now EXPLICIT, not left to Pro. With z=u^2/v
at infinity and tangent frame eta^-1, H1(T_C) is the quotient
k((z))/(k[u,v]+z²k[[z]]), with basis z^-3,z^-1,z. The gaps of the
semigroup<2,5> give the first two terms; the positive z term survives
the z² lattice. Put a4=F_4,a3=F_3 and phi=(u²+c1u+c0)eta².
For ANY such quintic and covector the Serre coefficients in that order
are

    (-2a3-2a4 c1-2c0, -2c1, -2).

Indeed w=1/u=z²+a4z^4+(a4²+a3)z^6+..., hence
u=z^-2-a4-a3z²+..., eta=-z dw, u²eta=z du and u eta=-z dw/w.
Taking the three required residues
gives the formula, without a guessed truncation. In this playground
it is (3t²+t+1,3t+4,3), checked by exact Laurent-series arithmetic.

Thus rho represented by a_-3 z^-3+a_-1 z^-1+a_1 z is tested by
(3t²+t+1)a_-3+(3t+4)a_-1+3a_1. A raw cocycle must be reduced first; these
are not simply three arbitrarily truncated coefficients before
subtracting affine coboundaries.

The first handwritten formula retained a spurious a4² term after
inverting w. The exact series assertion caught it; the corrected
u expansion above and an independent generic-coefficient check are
both in the final verifier. No higher lifting result depended on it.

The obvious symmetry does not evaluate this scalar. Every automorphism
of the pair preserves its half-divisor, hence preserves {W_t,O} and
the nonbranch h-fiber. The induced PGL2 map fixes t,infinity,h, and
is identity, unless it exchanges t and infinity. The latter map is
necessarily (tu+b)/(u-t), b=h²-2th=3t²+3t+4. Its value at0 would
have to lie in {0,1,2,3}, giving a nonzero quadratic equation for t,
impossible since deg(t)=4. Thus the pair has only the hyperelliptic
involution, which acts trivially on all regular quadratic forms.
It supplies no nontrivial weight forcing the obstruction to vanish.

Next construct the canonical FL C2 and the higher Hodge cocycle,
separating that first lift from an arbitrary coefficientwise curve
lift. The unresolved calculation is rho itself, not its dimension
or the now-evaluated Serre functional. Do not restart
A18, a blind height3 Frobenius enumeration, or a degree4 cover search.
