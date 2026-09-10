# Audit: uniform cyclic25 auxiliary-oper comparison

Date: 2026-09-10. Auditor: /root/audit_d25_auxiliary_comparison.
Verdict: **PASS**, with the reduction-compatible frame convention made
explicit below. This is a focused prose audit of the new auxiliary-oper
construction and equations (12)--(30) in the returned D25 answer. It
accepts the established initial cyclic25 theorem and mixed-additive norm
theorem. It is not Lean verification or an audit of any main-case
application. No counterexample or remaining mathematical blocker was
found in this comparison.

## Scope and the point checked

The target is the exact request
`Research/PRO_CYCLIC25_UNIFORM_DESCENT_REQUEST.md`: given compatible
C_n and the original marked cyclic25 cover, compatibility of the given
T_(n+3) must descend its particular T_(n+1). The lower next compatible
curve is a conclusion, not an input. The normal coefficient line, full
preceding filtered object, graded map and flat two-torsion twist remain
the specified ones.

The difficult new stage is n=3. The actual preceding H_3 may have a
non-descended 25-digit. It is not legitimate to treat its coefficients
as coefficients of a deck-equivariant fixed reference. The returned
argument instead supplies a genuine descended auxiliary oper and keeps
the difference from its inverse Cartier transform. That replacement
works for the reasons below.

## 1. The auxiliary object is legitimate

On a chosen smooth next curve, local lifts of an SL2/projective oper
with fixed spin realization differ by quadratic differentials. The
obstruction to patching those lifts at a square-zero step is therefore
in H1(omega^2), which is zero for genus at least two. Repetition extends
the already given oper; it does not extend its periodicity equation.
The prescribed maximal Higgs grading can be retained. The flat
square-trivial line extends with its horizontal square trivialization:
two is a unit, so there is no infinitesimal two-torsion ambiguity.

This is enough input for the higher inverse Cartier construction.
LSZ's category consists of the new graded Higgs object, an actual
preceding filtered flat object, and their graded identification. It
does not require that the preceding object already satisfy the next
inverse-Cartier periodicity equation. In particular, the auxiliary
system is a permissible input even though its output need not have
the auxiliary Hodge line as a global subline.

The distinction remains essential: the auxiliary Hodge line is a real
line in the auxiliary oper. Its attempted placement in the auxiliary
inverse Cartier output is made only locally and has an error cochain
E. There is no assertion of a nonexistent global Hodge line in that
output. Since all auxiliary objects, chart choices and local module
identifications come from C, that error is descended.

Primary construction checked: [LSZ, Section 4, especially the input
category, Lemmas 4.6/4.10 and Proposition 4.11](https://arxiv.org/html/1311.6424v4).

## 2. The frame convention completing the scalar argument

Choose the local module identifications between auxiliary oper and
auxiliary inverse Cartier output compatibly under reduction at all
precisions in the three-digit calculation. This is possible by lifting
local frames on the affine charts; it asks for module identifications,
not new horizontal or filtered isomorphisms. The given compatible upper
tuple and the higher functor's reduction compatibility then identify
the mod-five first graph coefficient of the preceding actual oper
with the same `bar u` used in the final normal graph equation.

This sentence should be included when recording the proof. Otherwise
the use of `s_0` in (14) and `bar u` in (21) is unnecessarily implicit.
It follows from the existing compatible tuple, not from an assumption
that H_3 descends.

Place the curve variation in the overlap maps and use identical local
affine lifts and Frobenius liftings. The actual and auxiliary previous
objects agree through W_m. Their first scalar difference has order
5^m. At the first digit, the local inverse Cartier connection has no
contribution from that scalar difference: the scalar enters its tilde
connection with two additional factors of five. Thus the first local
connection discrepancy relative to the auxiliary oper is descended.
All non-descended first scalar variation comes from the first Hodge
graph repair (or an additional linear curve-coordinate term if other
local identifications are used).

The oper normalization gives

    delta r = beta + alpha' + r gamma - gamma''/2
              + r' s + 2 r s' - s'''/2.

It uses determinant normalization by a unit square root, never division
by five. It is additive in the first changes. Consequently the variable
part preserves augmentation images under the descended reference
derivatives and coefficient maps.

The next scalar response is indeed delayed by two factors of five.
The first surviving variation in the Taylor matrix is

    5^(s+2) a [[z^2/2,z],[z^3/6,z^2/2]] mod 5^(s+3).

The j>=4 terms do not alter this coefficient, including j=5 after
its factorial denominator. The term transports coefficients by the
specified Frobenius, which commutes with the abstract deck generator.
This is precisely why the actual non-descended H_3 digit becomes an
additive final correction, not an uncontrolled reference coefficient.

## 3. The three-digit inventory is complete

Put m=n-1, so the curve displacement starts at 5^(m+1), the normal
graph at 5^m, and the comparison is modulo 5^(m+3). The returned
comparison has the form

    delta u + E - B X + 25 K(bar u)
        + 1_(n=3) 25 Q(bar X,bar u) = 0.

The following exhausts its possible terms at this precision.

- The curve/Frobenius-displacement and graded-jet variations are
  additive. Their full additive contribution belongs to B; its
  reduction is the usual Hodge-projection operator Psi.
- With exactly l changed Taylor-displacement factors, the denominator
  is l!(j-l)!, including the binomial numerator. For l>=2 the order is
  at least 2m+1, hence outside the comparison for m>=2. Thus no nonlinear
  displacement term has been silently placed inside B.
- The preceding scalar response just checked occurs at the final
  normal digit, additively in the first repair; it is K. Higher scalar
  digits and nonlinear scalar normalization occur too late.
- The first graph square has order 2m. It survives only at m=2, as an
  ordinary product at the final digit. First-times-second repairs have
  order 2m+1 and do not survive even at m=2. Fixed auxiliary discrepancy
  coefficients times a first repair are part of K; the remaining
  quadratic expression is Q.
- Interactions of a changed graded map, of order 5^(m+1), with a first
  graph repair, or of scalar feedback with a graph repair, likewise
  occur beyond this precision.

The actual filtered/graded transition has its prescribed triangular
form; one does not divide a raw lower graph entry by five. This keeps
the quadratic contribution ordinary, unlike the earlier initial
cyclic25 calculation. Local output frames need not be horizontal above
the common truncation, but they are used only for normal comparison,
not as morphisms in the tilde functor.

The one-digit normal projection and reduction compatibility used here
are the construction in [LSYZ, current Section 6, equation (6.0.1) and
Lemma 6.1](https://arxiv.org/html/1404.0538v2). The new three-digit
inventory is the returned argument, not a theorem quoted from LSYZ.

## 4. Why the retained error becomes a norm

The primary equation gives bar X in e22, while bar E is invariant,
hence in e24 on the torsor function algebra. The supplied integral
deck-linear Cech primitive therefore puts bar u in e22 at cochain
level. All variable first matrix coefficients are also in e22.
Consequently Q is in e20 by the actual function-product filtration.
No false rule about products of augmentation powers is used.

Applying normal cohomology and substituting the first repair into K
gives the additive deck-equivariant operator

    Lscript = pi B - 25 pi K Pbar Bbar,

and the error

    E' = pi E - 25 pi K Pbar Ebar.

Every operation preserves the deck action. Thus E' is invariant in a
free integral deck module and is an actual norm N eta. Its reduction
is the original normalized lower obstruction eta0. This retains the
error before taking the special-fiber obstruction quotient; it does
not infer a norm from the zero pullback map on that quotient.

The additive Schur complement of the bijective blocks is valid by
successive digit lifting of their additive inverse. It preserves both
invariants/norms and augmentation images. The e20 final error can be
removed by a terminal 25-digit whose reduction is a Psi preimage. This
changes neither the prescribed upper leading digit nor its marking.
The result is exactly L(X')=N eta with L mod 5=e^2 Phi. The supplied
integral norm theorem then forces eta0=0 and the leading solution in
k e24. Hence c=d=0.

The higher lower-reference errors are genuinely present in N eta.
Once eta0=0 their norm class is zero; they cannot cancel the e23
second divided residue. The orientation is consistent: the positive
divided linear residue is -d^5 e and the normal obstruction is +d^5 e.
There is one coefficient Frobenius, not d^25 and not e mapped to e^5.

## 5. Descent and full towers

After eta0=0 the normalized auxiliary next curve is compatible.
Changing its zero-line coordinate by b gives precisely the prescribed
upper b e24 class. Injectivity of pullback on tangent H1 and vanishing
of the normal H0 recover the original marked map and its unique Hodge
line. Maximal-Higgs graded identifications agree projectively; the
original flat two-torsion line remains the pulled-back one.

The initial theorem starts the induction. The new argument applies
at every n>=3 to descend the given next truncation, so it yields an
actual inverse system for any supplied full compatible upper tower.
Uniqueness of the marked curve/map descents makes the system compatible.
Canonical ample line bundles algebraize the formal curves; Grothendieck
existence algebraizes the finite rank-25 algebras and their deck action.
The resulting finite morphism is etale because its non-etale locus is
proper over the complete DVR and has empty special fiber.

These conclusions concern a GIVEN compatible upper tower and the
original cyclic25 cover. They create neither such a tower in general
nor a second endpoint map. The main unmarked common-cover problem is
not solved by this audit.

## Evidence boundary

The parent agent independently inspects and replays `d25_checks.py`.
Its local identities support the scalar/Taylor/sign calculations but
do not prove the global comparison. The PASS above rests on the genuine
auxiliary input, reduction-compatible graph identification, complete
precision inventory, and norm-error elimination just described. No
canonical theorem files were changed by this audit agent.

## Additional scoped application audit: actual five-part exactly25

Date: 2026-09-10. Same auditor. Verdict: **PASS** for replacing the
cyclic5 step in `Sol_cyclic_five_delayed_descent.md`, Section9, by the
new D25 theorem. This accepts the already audited deck reduction,
prime-to5 defect-neutral descent and genus-three counting inputs. It
does not assert a new exclusion for longer five-parts or trivial action.

Assume the unchanged main-pair span has ordinary r_X, source defect2,
an actual Galois Y-leg, nontrivial five-action on defects, and an ACTUAL
Sylow5 subgroup of order25. The established `two_defect_deck_reduction`
then gives original intermediate maps

    Z -> T -> Y' -> C -> Y,

with Z->T prime-to5 and defect-neutral, T->Y' cyclic25, Y'->C of
degree1 or2 and defect-neutral, and C a known bad etale double of Y.
The reduced group is respectively C50, D50 or C2 x D50. The factor25
is the order of the actual Sylow subgroup, not merely the order-five
faithful image on the two-dimensional defect space.

The hypotheses of D25 on T->Y' are present, without an additional
enumeration of cover directions. T has defect2 by the neutral quotient.
C has genus3 and its established Psi has five bijective dimensions and
one zero line. If Y'->C has degree2, normalized trace splits the pulled
back Psi subspace. Equal defects make the complementary summand
bijective. Thus Y' has genus3 or5 and the exact simple-zero hypothesis
required by D25. This use of the full Psi Fitting assertion is stronger
than merely knowing a one-dimensional kernel.

The ordinary Y connection supplies a full compatible reference by
lifting these actual etale covers to its canonical tower. In particular
it supplies the initial C5 reference required for D25 with base Y'.
The ordinary X connection independently supplies the GIVEN compatible
source tower by lifting the original X-leg. The established two-leg W2
identification matches its marking to that of the Y-reference. No
ordinary pullback or canonical-lift assertion for nonordinary T or Y'
is used.

Descend that given Z tower along Z->T using prime-to5 neutral descent,
then along the original T->Y' using D25, then along Y'->C using neutral
descent. Each operation recovers the specified upper tower, so after
algebraization the span is genuinely

    X^can <- Z^can -> C^lift.

Both maps have the SAME source and are finite etale. No lift of the
original C->Y is required or obtained.

The fixed genus-three partner count is consequently unchanged. For
each of at most 5^24 choices of r_X there are fewer than 2^80000000
possible genus-three generic partners; stable-model uniqueness gives
the same bound on their special fibers C. Every such hyperelliptic C
has at most672 automorphisms, hence at most672 etale degree-two quotient
classes, with at most120 family parameters per quotient. Thus the
parameter set has size less than

    80640 * 5^24 * 2^80000000 < 2^80000073 < K.

All properties defining this stratum, including actual Galoisness,
Sylow order25 and nontrivial defect action, are preserved under the
coefficient-field Frobenius. The existing parameter-degree argument
therefore excludes this entire stratum for the SAME selected main
parameter. The intermediate genus5 case still ends at genus3 C; it
does not require a new genus-five count.

Conclusion of this additional audit: all three reduced nontrivial-action
carrier shapes with actual five-part exactly25 are excluded in the
ordinary-X/source-defect2/Galois-Y main branch. The unmarked common-cover
problem, longer cyclic towers, trivial five-action, nonordinary-X
residuals, higher defects and non-Galois sources remain outside this
application.
