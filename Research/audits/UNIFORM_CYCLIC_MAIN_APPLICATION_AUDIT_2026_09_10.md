# Audit: all actual cyclic five-powers in the unchanged main pair

Date: 2026-09-10.
Auditor: /root/audit_uniform_cyclic_main_application.
Verdict: **PASS for the stated application**. No additional parameter
exclusion, initial-reference hypothesis, or bound on the cyclic exponent
is needed in this branch.

This is a bounded application audit. It accepts the separately reviewed
[uniform early theorem](../../Theorems/Thm_cyclic_power_early_descent.md),
the late theorem, the earlier full-tower results, and the existing
genus-three counting theorem as inputs. Their geometric and arithmetic
proofs are not re-audited here. The verdict is audited prose, not Lean
verification and not a verdict on the original unmarked problem.

## 1. Exact stratum and the actual intermediate maps

Keep the already selected genus-nine X over F25 and its high-prime-degree
genus-two partner Y_t. Suppose an ACTUAL finite-etale span

    X <-f- Z -g-> Y_t

has matched admissible active connections, ordinary r_X, Galois g,
source defect two, and nontrivial action of the actual five-part on
that defect space. The audited
[deck reduction](../../Theorems/Thm_two_defect_deck_reduction.md) gives a
normal prime-to-five subgroup K in the actual G=Gal(Z/Y_t), contained
in the defect-action kernel. For the actual Sylow order q=5^a, a>=1,
it supplies the original quotient chain

    Z -> T=Z/K ->h Y' ->j C -> Y_t.

Here h is connected cyclic-q, the reduced carrier is C_(2q), D_(2q),
or C2 x D_(2q), and D_n denotes a group of ORDER n. The map Z->T
preserves the two defects. The curve Y' has genus three or five and
defect one. The curve C is an original bad double of Y_t, of genus
three, and j has degree one or two and preserves defect one.

Every displayed map is an intermediate map of the original Galois
cover, hence finite etale. There is no simultaneous Galois closure,
new endpoint embedding, or replacement of either original leg.

## 2. All cyclic-descent inputs hold for every a

The ten bad doubles in the main high-degree family have Psi equal to
a five-dimensional bijective part plus a single zero line. If j has
degree two, normalized trace splits its pullback inside V_(Y') and
commutes with Psi, with Frobenius twists retained. Its complement has
no kernel because both defects are one, so that complement is
bijective. Thus Psi_(Y') has exactly the simple-zero form: five
bijective dimensions in genus three or eleven in genus five.

The regular-module and integral-cochain inputs are independent of q.
Cartan--Leray with H0(T,T_T)=0 identifies V_(Y') with V_T^(C_q).
Writing r=3g(Y')-3, these invariant and total dimensions are r and qr.
Every indecomposable k[C_q]-module has length at most q and contributes
one invariant dimension, forcing V_T to be free of rank r. The normal
line is the tangent line by maximal Higgs, so the same argument applies
there. The existing integral base-change/Nakayama argument gives the
regular lattices at every required Witt precision, and their free
cohomology supplies the deck-linear sections and primitives. The
Fitting/invariants argument gives nil rank one; source defect two
then gives e^2 Phi after source/target normalization. Pullback of the
base zero line is k e^(q-1). These are exactly the inputs of the
cyclic theorems, not extra assumptions on a new class of witnesses.

Crucially, every active r_Y in this main parameter range is ordinary.
Its canonical full Witt tower and full periodic tuple therefore exist.
Lift the ORIGINAL finite-etale covers C->Y_t, Y'->C and T->Y'
over that tower. Etale naturality pulls back the complete tuple even
though the upper connections are nonordinary. Truncating it supplies
the required compatible reference on Y' through W_(a+3), for EVERY a.
No bound on a and no existence assertion about a newly chosen
nonordinary reference are used.

Independently lift the ORIGINAL f:Z->X over the canonical ordinary
(X,r_X) tower. Denote this given source tower by Z_X: it is not being
called the canonical lift of the nonordinary source connection.
The established canonical W2/FL dictionary identifies its marked W2
reduction with the one obtained from Y_t, because the two original
connections match on Z. The projective initial flow, graded data and
actual square-trivial flat twist match by the same naturality and the
existing uniqueness statements. Working projectively avoids a new
theta-refinement that could change the source-defect hypothesis.

Thus the initial reference and the GIVEN upper tower have precisely
the marking required by the descent theorem. This is the same check
as [degree25 Section7](../../Solutions/Sol_cyclic_twentyfive_delayed_descent.md)
and [degree125 Section6](../../Solutions/Sol_cyclic125_bootstrap.md),
with no exponent-dependent step.

## 3. Descent retains one source and the original maps

Apply prime-to-five defect-preserving descent to the given Z_X tower
along Z->T. It produces a full compatible T tower and a map from
that SAME Z_X. Apply cyclic full-tower descent along h:T->Y'.
For a<=3 use the existing results; for a>=4 the uniform theorem gives
successive stages n=2,...,a and the late theorem supplies n>=a+1.
A full given tower contains all look-ahead digits, and each recovered
lower lift extends the already recovered marking. There is no gap
between the early and late ranges.

Finally descend the resulting Y' tower along the original defect-neutral
degree-two j, when j is not the identity. This step is essential: it
returns to genus-three C rather than invoking a new genus-five count.
Uniqueness makes the maps into a compatible inverse system. The
established effectivity result algebraizes it and gives

    X^can <- Z_X -> C^lift

with both arrows finite etale from the SAME smooth projective source.
The right arrow is the composition of the recovered original maps.
Neither a lift of C->Y_t nor a full lift of the original two-endpoint
span is asserted or needed.

## 4. One degree-uniform count covers the union over all a

For each fixed ordinary r_X, X^can is fixed. Every C^lift just obtained,
for every a and every degree of either original leg, belongs to the
SAME genus-three common-etale-cover partner set of that X^can.
The established bound is less than 2^80000000. It already allows
unbounded witnessing degrees. Thus it is incorrect to sum a separate
bound over a; there is only one partner set to count.

Stable-model uniqueness bounds the geometric special-fiber C classes
by the same generic partner count. Each such genus-three bad-double
curve has at most 80640 parameters t among its degree-two family
quotients. Counting at most 5^24 nilpotent r_X, an enlargement of the
ordinary-active choices, gives the unchanged bound

    #parameters < 5^24 * 2^80000000 * 80640
                < 2^80000073 < K.

This is the count already proved in
[defect-preserving descent Section6](../../Solutions/Sol_defect_preserving_etale_descent.md),
not a new finiteness theorem. The entire stratum, including its union
over a, is preserved by coefficientwise F25-Frobenius: transport both
maps, their matched connections, the actual Galois action and the
defect together. The originally prescribed t has prime degree greater
than K over F25, so its orbit cannot lie in the counted set. The SAME
main pair therefore excludes this whole ordinary-X/nontrivial-five-action
stratum for every actual cyclic Sylow order.

No new degree-dependent exceptional polynomials, enlarged parameter
field, or fresh choice of t is required.

## 5. What remains outside this verdict

The trivial-five-action carrier has a defect-two base, not the
simple-zero base used here; it is not covered. In particular the
nonordinary-X trace-zero branch is unaffected. Higher source defects,
non-Galois Y-legs, and dormant or absent active matches also remain
outside the argument. Passing to a Galois closure cannot silently
preserve the assumed defect two.

The previously proved nonordinary-X/nontrivial-five-action exclusion
uses the separate two-leg orbit bound. Combining that existing result
with this application removes the nontrivial-five-action branch of
matched Galois-Y/source-defect-two spans regardless of X ordinariness.
It does not remove the remaining branches just listed and does not
solve the unmarked common-cover problem.
