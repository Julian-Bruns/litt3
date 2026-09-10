# Compute the secondary norm transfer at the first obstructed lower reference

Compute the one-dimensional obstruction component defined below for an
actual cyclic-five etale cover. This is the next step in a delayed-descent
argument: the initial descent case is proved, and so is descent whenever
the lower reference is compatible. The opportunity now is to identify
what a NON-gluing lower Hodge line contributes at the next step. An
exact integral norm calculation predicts a nonzero transfer, but a
specific quadratic overlap term also survives at this precision.

The requested calculation is one scalar at W5. Its value would settle
the first still-open step of delayed descent; the established cases
are supplied as inputs below.

## 1. Actual curves and conventions

Work over k=bar(F5), W_j=W(k)/(5^j), and t^5-t!=0. Put

    G=u(u-1)(u-2)(u-3), F=G(u-t), Y:v²=F, eta=du/v,
    A=(t+1)²G, a=A/F², r=3a''/a+(a'/a)².

Derivatives are in u. The scalar oper convention is U''=rU with its
Schwarzian transformation law. This r is regular, admissible, active
nilpotent and indigenous-ordinary on Y. Its normalized quartic is
s=A*eta^4. Jacobian ordinariness is a different property; J(Y) is
ordinary as well.

Let C→Y be the connected etale double

    k(C)=k(u,kappa,gamma),
    kappa²=u(u-3), gamma²=(u-1)(u-2)(u-t), v=kappa*gamma.

It has genus3. Its deck involution tau negates kappa and gamma.
Let Y1→Y be a connected cyclic-five etale cover and let
T=C×_Y Y1, h:T→C. The ORIGINAL h has degree5 and g(T)=11. Assume
the pulled connection has nilpotent tangent defect TWO on T. This
occurs for actual covers; it is not a formal module model.

Use the canonical initial marked W2 curves. A compatible W_j curve
means that the full previous projective Higgs--de Rham tuple extends
through W_(j-1): Hodge line, prescribed graded identification and the
actual flat square-trivial periodicity twist. The twist on Y is
O(W_t-O), and its actual pullback is retained on C and T. Compatible
Hodge lifts, when they exist, are unique since H0(T_C)=H0(T_T)=0.

The canonical ordinary lift of Y and its etale covers supply one full
reference tower. The C3 below may be a DIFFERENT compatible lift, so
its original map to Y and the involution tau need not extend.

## 2. Established inputs

Let V_S=H1(S,T_S), and let Psi_S be the coefficient-Frobenius-semilinear
Hodge-obstruction variation map, retaining its relative twists. For
an already compatible previous tuple, the next obstruction satisfies

    rho(S_(j+1)+xi)=rho(S_(j+1))-Psi_S(xi).

It is natural for actual lifted etale maps. The operator on V_C has
a five-dimensional bijective part and a one-dimensional zero part.
Write R=k[e]/e^5, e=sigma-1 for the original deck generator of h.
V_T is free of rank six over R. Its semilinear Fitting parts have
ranks five and one over R; the nilpotent operator is e²u(e)Frob,
with u a unit. Normalize its source and target bases so that

    Psi_nil=e² Frob,
    ker Psi_T=e³R, D_T:=coker Psi_T=R/e²,
    h*(ker Psi_C)=k e^4, h*:coker Psi_C→D_T is ZERO.

Coefficient Frobenius FIXES e. The projection

    pi0:D_T→D_T/eD_T ≅ k

means the constant coefficient in these fixed normalized bases.
The involution tau acts as -1 on the two defect directions and D_T;
its use at the canonical initial comparison is legitimate, but it
is not assumed to act on the arbitrary compatible C3 below.

The following two geometric statements are already established.

1. If the canonical T2 has a compatible W4 extension, its GIVEN T3
   descends along the ORIGINAL h to a compatible C3.
2. At any level, if a compatible C^0_(j+1) extending the specified
   C_j already exists, compatibility of the given T_(j+2) forces its
   GIVEN T_(j+1) to descend along h. In the above nilpotent bases,
   the only first differences are d e³+b e^4 and the actual next
   divided comparison has residual -d^5 e, forcing d=0.

These statements retain the full previous tuple, not only curves or
special-fiber connections. The remaining case has nonzero lower
obstruction, not an unexamined extra upper-kernel direction.

Here is a further established cochain tool. Put

    R2=W2(k)[sigma]/(sigma^5-1),
    M2=H1(T2,T_(T2/W2)),
    P2=H1(T2,Hom(Fil2,H2/Fil2)).

The maximal second fundamental isomorphism identifies the coefficient
line of P2 with the tangent line, equivariantly; both lattices are
free of rank six over R2. Pullback identifies the lower lattices with
the norm submodules NM2,NP2. On a two-affine cover pulled from C,

    0→Cech0→partial Cech1→cl H1→0

is exact, and freeness of H1 gives a deck-linear section s of cl.
The primitive Q=partial^-1(1-s cl) is deck-linear, integrally as well
as modulo5. Thus an exact e² cochain has its normal primitive in e²
AT COCHAIN LEVEL. An additive deck-equivariant operator on such
cochains has zero image in D_T. This does not justify dividing an
arbitrary integral norm cochain by5 and keeping it in e².

## 3. The single quantity to compute

Fix ANY compatible marked C3 extending the canonical C2, with its
full tuple through W2, and lift h to T3→C3. Choose a smooth reference
C4^0 extending C3. Normalize its Hodge obstruction by changing its
bijective tangent component so that

    rho_C(C4^0)=eta0

lies in the one-dimensional zero part of V_C. The scalar eta0 is
the actual lower obstruction; it may be nonzero. Lift h as a CURVE
cover to T4^0→C4^0. No compatible global Hodge line on C4^0 is assumed.

Every compatible T4 extending T3 has, relative to this reference,

    xi=[T4]-[T4^0]=c e²+d e³+b e^4,  c^5=eta0.           (1)

The ordinary component is zero. Conversely the first variation
equation produces such compatible upper lifts; the vanishing of
the cokernel pullback is precisely why a nonzero eta0 is not already
excluded at W4.

For each such T4, choose any smooth T5^0 extending it and form its
ACTUAL next Hodge obstruction, using the full previous tuple on T4:

    epsilon_T(T4)=[rho_T(T5^0)] in D_T.

It is independent of the choice of smooth T5^0. Define

    kappa_(C3)(c,d,b)=pi0(epsilon_T(T4)),  c^5=eta0.       (2)

COMPUTE (2) from higher inverse-Cartier gluing. Give its dependence
on eta0, the given lower tuple and the two free kernel parameters
d,b, with the Frobenius transports specified. In particular determine
whether it is a nonzero scalar/Frobenius-transport multiple of eta0,
as the integral norm carry suggests, or identify the additional terms
that change that prediction. The requested output is an evaluated
transfer formula, not the definition of another obstruction space.

## 4. The tested calculation and the term that must be combined with it

Over the integral deck algebra,

    N=1+sigma+...+sigma^4=5+10e+10e²+5e³+e^4,
    e^5=-5e-10e²-10e³-5e^4.

For any semilinear matrix lift (e²+5B(e))varphi of Psi_nil, the divided
norm calculation on(1), modulo5 and e², is

    (e² varphi(tilde xi)-N tilde eta)/5
          = -eta0(1+2e)-d^5 e.                          (3)

Here tilde eta reduces to eta0; unknown next-digit changes contribute
Psi images. Every 5B(e) term vanishes in R/e² since xi is divisible
by e². Thus the CONSTANT coordinate predicted by(3) is -eta0.
These are exact integer identities. What is still needed is the
actual geometric correction to(3) when the lower reference does not
have a global Hodge line.

Locally a preceding reference Hodge overlap can have lower-left entry
25r_ij. The weight rescaling uses S=diag(1,5); that entry becomes
5r_ij under S^-1 M S. Consequently a triangular-reference argument
cannot simply be reused. Local lower errors and the actual upper
Hodge repair have to be combined before rescaling.

More explicitly, suppress indices and write the relevant previous
overlap and graph generators as

    G=[[A+epsilon*K11, B+epsilon*K12],
       [epsilon*(r+K21), D+epsilon*K22]],
    v_i=(1,epsilon*q_i), epsilon=25.

The EXACT normal graph error (Gv_i)_2-epsilon*q_j*(Gv_i)_1 is

    epsilon*L + epsilon²*Q - epsilon³*K12*q_i*q_j,
    L=r+K21+D*q_i-A*q_j,
    Q=K22*q_i-K11*q_j-B*q_i*q_j.

After dividing the lower entry by5 it is

                       5L+125Q modulo625.              (4)

The quadratic term in(4) can therefore survive at precisely this
first later level. A formal polynomial verifier and an independent
matrix expansion agree on this bookkeeping. It is not a claim that
Q has a nonzero final obstruction class: the full corrected gluing
and normal projection could cancel it. This cancellation, if present,
must be derived; tau is not available on arbitrary C3.

When both preceding filtered objects genuinely glue, one can restore
the lower connection coefficient after a graph change. For
connection matrix [[alpha,beta],[gamma,-alpha]], gamma a unit,
B=I+epsilon*q*E21 changes that coefficient to

    gamma'=gamma+epsilon*(q'-2alpha*q)-epsilon²*beta*q².

Following with diag(v,v^-1), v=(gamma/gamma')^(1/2), restores gamma
and aligns the second-fundamental/graded data. This is part of the
proved compatible-reference comparison, not a way to globalize an
incompatible lower Hodge line.

Use the actual higher construction of
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/pdf/1404.0538):
its weight-rescaled previous filtered tuple, the divided Frobenius
discrepancy, Taylor gluing and the original flat periodicity twist.
One possible route is to compare the two-digit overlap complexes
using the equivariant Cech primitive above and compute the resulting
secondary norm transfer on the normal line. Track the identification
with the already fixed lower-level object as well as the graph term.

## 5. Why this particular formula is useful

If (2) is an invertible transport of eta0, a compatible T5 forces
eta0=0. The proved compatible-reference case then forces d=0 and
recovers the ORIGINAL T4→C4. This reaches the first step not covered
by initial delayed descent. If (2) has extra terms or vanishes, its
explicit formula instead determines the surviving upper deformations
and whether the proposed integral-norm mechanism needs replacement.

The broader application is to actual common etale spans: ordinary
endpoint data can supply a full compatible upper tower; descent to
this genus-three intermediate would allow an existing uniform partner
bound to exclude a new two-defect branch. Computing(2) tests the
missing mechanism without assuming the whole tower descends or that
the original genus-two map lifts.
