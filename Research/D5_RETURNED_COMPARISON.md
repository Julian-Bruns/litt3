# Returned Pro proof of cyclic-five delayed descent

Received2026-09-10, about13:45CEST. Target and full initial data:
[the submitted request](PRO_CYCLIC_FIVE_DELAYED_DESCENT_REQUEST.md).
Pro asserts D5 for every n>=2 under the supplied cohomological inputs.
This record retains the complete mathematical comparison for review;
the uniform assertion is NOT a proved theorem or common-cover exclusion.
No executable certificate accompanied this answer.

Review outcome,2026-09-10: focused medium audit GAPS for full D5;
PASS for n=2 with canonical reference and at every n with an existing
compatible lower reference. Root's explicit oper normalization repair
is included in those positive cases. See the canonical scoped theorem
[cyclic_five_compatible_reference_descent](../Theorems/Thm_cyclic_five_compatible_reference_descent.md).
The obstruction in the unrestricted argument is the lower-left overlap
entry of an incompatible previous Hodge reference: 5^(n-1)*r becomes
5^(n-2)*r under weight rescaling. Its combination with the upper repair
has not been computed in equation(4) below.

## Target and first normalization

T=C×_Y Y1→C is the ORIGINAL cyclic degree-five cover, with defect2;
C→Y is the explicit bad double of the ordinary active genus-two pair.
Use the full previous projective filtered tuple and its actual flat
square-trivial twist. Given compatible C_n and its lifted T_n→C_n,
suppose the GIVEN T_n extends to compatible T_(n+2). D5 asks that its
GIVEN T_(n+1) descend along this map to compatible C_(n+1). No lift of
C→Y is required, and T_(n+2) itself is not asserted to descend.

Choose a smooth C^0_(n+1). For n=2 use the canonical reference; for
n>=3 change its bijective tangent component so the obstruction has
only scalar zero-line component eta_0. Lift the cover to T^0_(n+1).
Then xi=[T_(n+1)]−[T^0_(n+1)] in V_T, after absorbing the unit u(e), is

    xi=a e²+d e³+b e^4,  a^5=eta_0.                        (1)

Its bijective component vanishes. Here R=k[e]/(e^5), e=sigma−1,
coefficient Frobenius FIXES e, and Psi_nil=e² Frob. The nilpotent
cokernel is R/e² and lower-kernel pullback is k e^4.

## Integral lattices and the new cochain point

Extend C^0_(n+1) smoothly to C^0_(n+2) and lift the original cover to
T^0_(n+2). Since (5^nW_(n+2))²=0 for n>=2, the difference of the
two upper curves, marked over W_n, belongs to

    M2=H1(T2,T_(T2/W2)).

The integral group ring is R2=W2(k)[sigma]/(sigma^5−1). For n>=3 use
the given actual Hodge data through W2 on C_n and its pullback to T2;
for n=2 use the canonical reference tuple through W2. Put

    P2=H1(T2,Q2), Q2=Hom(Fil2,H2/Fil2).

The maximal Higgs isomorphism gives Q2≅T_(T2/W2), equivariantly.
Both M2,P2 are free R2-modules of rank6: lift a basis of their R-free
reductions, apply Nakayama and compare W2-ranks. Pullback identifies
the lower lattices with their invariant submodules NM2,NP2, where

    N=1+sigma+...+sigma^4=5+10e+10e²+5e³+e^4.

Take a two-affine cover pulled back from C. For tangent or normal
obstruction coefficients, H0=0 gives the exact Cech sequence

    0→Cech0 →partial Cech1 →cl H1→0.

Because H1 is free over the deck algebra, choose a deck-linear section
s of cl. Then Q=partial^-1(1−s cl) is a deck-linear primitive operator.
In particular an EXACT cochain in e² Cech1 has its UNIQUE normal
Hodge-generator primitive in e² Cech0. This holds over R2 as well as R.
At n=2 average these choices under tau; tau commutes with sigma and
2 is invertible. Refining to local frames/coordinates imposes no global
splitting of the oper bundle.

## Actual two-digit Taylor/Hodge comparison

Put m=n−1. Work modulo5^(m+2)=5^(n+1) on the next de Rham term.
If the lower reference is incompatible, extend its full tuple only on
affine charts, keeping its overlap error. There is no assertion of a
global higher inverse-Cartier transform of that incompatible tuple.

In adapted frames retaining the graded identification, write the
preceding transition and connection as

    M_ij=[[ell,c],[0,ell^-1]],
    nabla=d+[[alpha,beta],[gamma,−alpha]]dx.

Their weight rescalings are

    tilde M_ij=[[ell,5c],[0,ell^-1]],
    tilde nabla=5d+[[5alpha,25beta],[gamma,−5alpha]]dx.      (2)

After aligning the prescribed graded data, a preceding-tuple change
of order5^m changes rescaled transitions and connections in order
5^(m+1); the upper-right connection entry gains two factors of5.
This includes Hodge-generator corrections. Their linear divided carry
is retained, not asserted zero at this stage. The original twist stays
in these matrices and connections.

For S=diag(1,5), tilde D=5S^-1 D S, hence

    v5(tilde D^j/j!) >= j−1−v5(j!).

The returned argument says Taylor denominators do not remove the extra
factor: the affected higher terms have order at least
5^(m+j−1−v5(j!)). The j=1 term is controlled directly by(2); for j>=2
this bound is at least5^(m+1). This explicit j=1 clarification is root's
reading of the preceding rescaling argument.

Choose local lower Frobenius lifts and pull them to T, commuting with
sigma. Represent tilde xi by the integral deck-linear Cech section.
An order5^n curve-gluing displacement by derivation tilde nu changes
the divided Frobenius discrepancy by

    Delta z_ij=5^(n−1)(−F2(tilde nu_ij)+5L_ij(nu_bar_ij))
               modulo5^(n+1).                             (3)

The non-Frobenius coordinate term gains the extra5 because dF* is
divisible by5. Insert(3) into the actual LSYZ Section5 Taylor gluing.
Taking its first Taylor coefficient, projecting normally to the Hodge
line, and using the deck-linear representatives/projections constructs
an ACTUAL coefficient-Frobenius-semilinear R2-equivariant map

    A2:M2→P2,  A2 mod5=Psi_T.

All remaining linear terms have an additional5 after division by5^m:
the non-Frobenius term in(3), curve-induced graded changes, and the
preceding filtered-tuple changes of(2). Their reductions are additive
and commute with sigma.

To retain the normal generators, write a reference transition as
G_ij=[[A,B],[C,D]], C=0 modulo5^m, and corrected generators
e_i+5^m tilde q_i f_i. If K_ij is the leading transition variation
divided by5^m, the normal graph equation divided by5^m has linear part

    C/5^m+(K_ij)_21+D tilde q_i−A tilde q_j.

Its quadratic part is

    5^m((K_ij)_22 q_i−(K_ij)_11 q_j−B q_i q_j).

Thus compatibility of the given T_(n+2) gives the necessary cohomology
equation

    A2(tilde xi)−h*tilde eta+5Lambda(w)
                +1_(n=2) 5Bcal(w)=0 in P2.               (4)

Here tilde eta is the two-digit LOCAL reference-error class downstairs,
reducing to eta_0; it is not a next global obstruction of an incompatible
tuple. The collection w consists of first curve, Hodge and filtered-frame
corrections. Lambda is additive and sigma-equivariant. Bcal is quadratic
in first corrections and equivariant for symmetries of the reference.
For n>=3 the quadratic term vanishes by its5-adic order.

## Why the extra terms vanish after projecting to coker Psi

By(1), the first curve cochain can be chosen in e². The first pulled-back
reference error also lies in e²: invariant coefficients on an affine
etale torsor are norms, and N mod5=e^4. The characteristic-five Taylor
term is additive and sigma-equivariant. Therefore the first EXACT
normal Hodge error lies in e² Cech1. The new equivariant primitive
construction puts q in e² Cech0.

The remaining first frame corrections are obtained linearly from these
cochains/generators and the pulled-back reference error. For example,
an adapted-frame change Q changes the connection by dQ+[Gamma,Q],
plus the first flat-bundle change. Thus every component of w lies in e².
An additive sigma-equivariant operator respects e². Consequently
Lambda(w) has zero class in coker Psi_T=R/e². This includes coefficient-
Frobenius-semilinear operators, since that Frobenius fixes e.

At n=2, the reference is canonical and tau-equivariant; eta_0=0 and
the first correction xi is anti-tau. The averaged Cech choices make
ALL first corrections anti-tau. Their quadratic term is tau-invariant,
so its projection to the anti-tau obstruction cokernel vanishes.
For n>=3 no tau lift is used because that quadratic term is absent.

Divide(4) by5 and project to get

    [(A2(tilde xi)−h*tilde eta)/5]=0 in coker Psi_T.        (5)

## Evaluate the carry and descend the GIVEN truncation

Lift the supplied Fitting bases to the two integral lattices. The
nil-to-nil entry of A2 is (e²+5B(e))varphi, varphi Witt-Frobenius on
coefficients. Off-diagonal entries reduce to zero. Since xi has zero
ordinary component modulo5, off-diagonal terms do not affect the
nilpotent divided residual. The 5B perturbation also projects to zero
because xi mod5 is divisible by e².

Write

    tilde xi_nil=tilde a e²+tilde d e³+tilde b e^4+5zeta,
    tilde eta_nil mod5=eta_0=a^5.

The remaining class is the projection of

    (e² varphi(tilde xi_nil)−N tilde eta_nil)/5.

The unknown5zeta gives an image of Psi; changing the lift of a^5 gives
an e^4 multiple. Both vanish in R/e². The integral deck relation yields
EXACTLY

    −eta_0(1+2e)−d^5e.

Its two coefficients force eta_0=d=0. Thus xi=b e^4=h*beta for some
beta in ker Psi_C. The normalized C^0_(n+1) is now compatible. Set
C_(n+1)=C^0_(n+1)+beta and lift the ORIGINAL cover. Its upper curve
has exactly the class of the given T_(n+1), so a marked isomorphism
identifies them, preserving T_n. Transport gives the requested map.

Naturality and uniqueness of Hodge lifts identify the full pulled-back
tuple. The original projective graded identification and flat two-torsion
twist were retained at every step. This is the asserted proof of D5.

## Review focus and independent work checkpoint

Root has checked the elementary deck-linear splitting, the square-zero
two-digit curve torsor and the carry calculation. The main review issue
is the completeness and actual geometric meaning of(4), including the
incompatible reference and induced graded/frame changes. A statement
about an arbitrary matrix lift would not suffice. Integral invariants,
the normal-Hodge identification over W2 and all level indices also need
checking. The scoped audit now confirms the cochain argument and the
compatible-reference comparison after root's normalization repair.
The incompatible-reference term specified above remains unresolved.

Further exact check,14:10CEST: write a preceding overlap as
G=[[A+epsilon*K11,B+epsilon*K12],
   [epsilon*(r+K21),D+epsilon*K22]], epsilon=5^(n-1).
For graph generators (1,epsilon*q_i), its normal error is

    epsilon*L + epsilon²*Q - epsilon³*K12*q_i*q_j,
    L=r+K21+D*q_i-A*q_j,
    Q=K22*q_i-K11*q_j-B*q_i*q_j.

Rescaling the lower entry divides this by5. At n=3 it becomes
5L+125Q modulo625; the quadratic term CAN SURVIVE. At n>=4 that
quadratic term vanishes at the stated precision. Exact formal
polynomial check: scripts/verify_incompatible_hodge_graph.py.
The same focused auditor independently confirmed this expansion and
scope. It is an additional specific problem with the unrestricted
comparison, NOT an actual nonzero obstruction or counterexample.
The compatible-reference theorem uses globally gluing normalized
filtrations, so this raw nontriangular calculation does not refute it.

Independent orbit-degree work reached an audited new stratum exclusion:
two_leg_defect_orbit_bound. Before this answer arrived, the next idea
was: ker of the defect representation fixes phi_X²/s_X, so X and the
actual quotient Z/ker have a CORED common span via Z. The quotient of
Z/ker to the original Y remains Galois; its degree can be large. Test
whether the existing cored atlas bound for X constrains this new situation,
without falsely inferring a core between X and Y or discarding either leg.
This is the checkpoint to resume after integrating the present Pro proof.
