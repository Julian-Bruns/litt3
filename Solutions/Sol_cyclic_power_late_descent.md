# Late-stage descent for every cyclic power of five

Version2,2026-09-10. Contextual scope notes updated after B125;
the mathematical late-range statement and proof are unchanged.
Author extension, fresh bounded audit PASS by
/root/audit_cyclic_power_late_descent. The all-digit scalar recurrence
requested by the auditor is explicit in Section3. This is audited prose,
not Lean. The cyclic25 theorem is a proved input; no early-stage or
full-tower conclusion for higher powers is inferred here.

## Statement and exact boundary

Let a>=2, q=5^a, and h:T→C an ACTUAL connected finite etale cyclic-q
cover with the same active maximal-Higgs projective filtered data and
actual flat square-trivial periodicity line. Assume Psi_C is a bijective
part plus one zero line and dim ker Psi_T=2. Write compatibility W_j
for the full tuple through W_(j-1), with all graded/flat identifications.

LATE theorem: for every n>=a+1, given compatible C_n and its
ORIGINAL pulled-back T_n, a GIVEN compatible T_(n+a+1) forces its GIVEN
T_(n+1) truncation to descend compatibly along h to C_(n+1).

No initial reference is needed beyond the GIVEN compatible C_n. This
does not produce the low C_n for n<a+1. At q125 the separate
[B125 proof](Sol_cyclic125_bootstrap.md) now recovers GIVEN T4→C4
from GIVEN T7, completing that full-tower induction. Early stages
at q>=625 remain outside this late-range proof.

## 1. Actual modules and genuine reference

Put O=W_(a+1)(k), R_O=O[e]/((1+e)^q-1), R=k[e]/e^q, N=sum sigma^i.
The Cartan--Leray/Fitting proof in the initial25 theorem is independent
of q: V_T is free rankr=3g(C)-3 over R, with free nilpotent rank1 and
bijective rankr-1. FIRST identify the base operator on invariants;
then use the norm isomorphism from augmentation coinvariants. Source
defect2 implies Psi_nil=e²u(e)Phi, normalized to e²Phi by separate
source/target bases. Thus

    ker Psi_T=e^(q-2)R, D_T=R/e²,
    h*ker Psi_C=k e^(q-1), h*:coker Psi_C→D_T is zero.

For n>=a+1 put m=n-1. Normalize a smooth next lower curve so its
Hodge obstruction is only eta0 in the simple zero line. Extend its
underlying curve through W_(n+a+1), and lift the original cover. Extend
the preceding filtered oper genuinely on this curve, with its prescribed
grading and flat line, using H1(omega²)=0 exactly as in uniform25. Its
failure of inverse-Cartier compatibility is retained as a descended
error, rather than filled by a false Hodge line.

Normal and tangent lattices over O are free over R_O, and their pulled-
back two-affine complexes have integral deck-linear sections and the
unique normal primitive. The existing common tuple includes W_m with
m>=a, but a descended auxiliary W_(a+1) oper supplies the one missing
reference digit at n=a+1. The original cover has its actual deck action.

The difference of curves with their W_n marking is X in V over O:
5^n/5^(n+a+1) is square-zero because n>=a+1. Primary compatibility gives

    Xbar=c e^(q-3)+d e^(q-2)+b e^(q-1), c^5=eta0.       (1)

## 2. Precision makes the later problem linear

The first normal graph changes have order5^m. The complete comparison
is modulo5^(m+a+1). For m>=a+1 EVERY product of two variable first
changes vanishes. For m=a their square is at the last digit5^(2a),
and first-times-second changes vanish. Cubic first changes vanish for
a>=2. Curve displacement starts one power later, at5^(m+1).

In genuine oper frames the tilde transition has prescribed graded
diagonal, previous upper entry multiplied by5, and connection

    5partial+[[0,25r],[1,0]].

The first scalar normalization is the additive differential operator
from uniform25 equation(2). Higher scalar changes are linear in the
relative curve/connection/Hodge changes at this precision: a nonlinear
normalization has order at least2m, and its contribution gains25,
hence vanishes even at m=a. No scalar enters the filtered jet transition.
All coefficients of these linearizations are from genuine DESCENDED
auxiliary objects. The actual previous scalar is a variable, not an
unjustified descended coefficient.

For Taylor degree j with exactly l>=2 changed displacement factors,
valuation is >=lm+j-1-v5(l!)-v5((j-l)!)>=2m+1. It therefore vanishes
modulo5^(m+a+1). This includes factorials divisible by5. Linear Taylor
terms may now require j>3; keep every term with
j-1-v5((j-1)!)<=a. Only finitely many enter, all additive/deck-equivariant.
Scalar insertions preserve the gain25: the explicit diagonal-conjugation
formula K_j from uniform25 shows that the smallest scalar-response
valuation is2 (in j1--3); terms of higher j cannot reduce that gain.

## 3. Eliminate ALL linear preceding-tuple feedback integrally

Unlike uniform25, do not reduce the scalar feedback to only its first
digit. Write r_actual-r_aux=5^m R. The scalar needed by the final
transform is only required modulo5^(m+a-1), so solve for R modulo
5^(a-1). All nonlinear oper normalization terms have order at least
5^(2m) before this scalar is fed back; after its extra25 they vanish
at the precision in question. Its remaining scalar normalization is
the additive first-variation formula, now with all integral digits kept.

Choose local module identifications compatibly under reduction.
Higher inverse-Cartier reduction compatibility and the GIVEN upper
tuple identify the preceding Hodge graph with the reduction of the
SAME graph u in the final comparison. In these identifications the
scaled local scalar recurrence is

    R=V_aux+A(X)+D(u)+K_r(R) modulo5^(a-1).              (R)

V_aux is descended, and A,D,K_r are additive operators with descended
coefficients and the specified coefficient Frobenius. The scalar
response of the tilde connection shows K_r raises valuation by at
least2. Thus I-K_r has a finite geometric inverse. If the specified
twist-periodic tuple is written with both of its members, retain those
members in the recurrence; their scalar-feedback cycles still gain25.
Consequently R is an additive expression in X,u and
descended errors at ALL required digits, not merely the first one.
Its contribution to the final normal equation gains the same25.

After this elimination, choose the auxiliary normal-line Cech boundary
delta as the fixed linear graph differential. The ACTUAL normal equation
has the form

    delta u+E-BX+H(u)+1_(m=a)*5^a Q(Xbar,ubar)=0,        (2)

where B is additive/deck-equivariant with pi Bbar=Psi_T, E is descended,
and H is additive/deck-equivariant with values divisible by5. The
scalar-feedback part of H is in fact divisible by25; allowing a factor5
also incorporates any linear graded/frame restoration. Q is only the
ordinary final graph quadratic in first variable cochains. Fixed first
auxiliary errors times a variable are linear and belong to H or B.

For m=a the leading graph equation gives
ubar=Pbar(Bbar Xbar-Ebar). Invariants of the torsor function algebra are
e^(q-1)A, so all variable first cochains are in e^(q-3). Hence

    Q∈e^(q-5)Cech1, pi Q∈e^(q-5)Mbar⊂e²Mbar.          (3)

The last inclusion uses q>=25, not just the linear norm theorem.
There is no division of Q by another5 at this stage.

To eliminate H, apply the integral primitive P to (2). Since PH takes
values in5 Cech0, I+PH is invertible as an ADDITIVE operator, without
assuming one coefficient semilinearity. Put J=(I+PH)^-1. Then

    u=J P(BX-E)-1_(m=a)*5^a P Q,

where the last term is unchanged modulo the extra5; H applied to it
vanishes. Applying pi to (2) therefore yields

    Lscript X=E'+1_(m=a)*5^a q0,
    Lscript=pi B-pi H J P B,
    E'=pi E-pi H J P E,
    q0∈e^(q-5)Mbar.                                    (4)

Every operator is additive/deck-equivariant, and Lscript mod5=Psi_T.
E' is invariant, hence a norm N boldeta in the free integral target.
This is done BEFORE taking any obstruction quotient or dividing5.

Eliminate the bijective block by additive Schur complement. Its inverse
exists digit by digit and preserves norm/augmentation images. The
remaining equation is

    L Xnil=N eta+1_(m=a)*5^a qnil, L mod5=e²Phi,
    qnil∈e^(q-5)R⊂im(e²Phi), eta mod5=eta0.

A terminal algebraic correction5^a z removes qnil without changing
the GIVEN leading curve digit. Thus L Xnil'=N eta.

## 4. Apply the existing all-power norm theorem

The proved additive norm theorem over W_(a+1) now forces eta∈5O and
the reduction of every solution into k e^(q-1). Hence eta0=c=d=0.
The normalized auxiliary lower next curve is compatible. Change it by
b e_C in ker Psi_C; its lifted ORIGINAL cover is exactly the GIVEN
T_(n+1). Negative normal H0, graded projective rigidity and the unique
flat two-torsion lift match all specified data. This proves the late
theorem. The full linear feedback elimination of Section3, including
recurrence(R), is part of the focused audit, not a new assumed input.

## Diagnostic and new bottleneck

[verify_cyclic_power_late_budget.py](../scripts/verify_cyclic_power_late_budget.py)
tests all stated valuation budgets
for a2..8, n=a+1..a+5, Taylor degree through250, and the actual boundary
function products for q25,125,625. It is not a proof of (2).

For q125 at n2, the first repair can lead to a second repair in e23 A.
Both B100 and B24 belong to this image, but their pointwise product is
B124, outside even eA. A square of second Hodge repairs has order5^4,
the third-carry digit. Thus the early bootstrap is NOT obtained by
reusing the late linearization or claiming all quadratic products vanish.

At125 a finite bootstrap recovering GIVEN T4 from GIVEN T7, with the
initial marking and full tuple, would suffice to start this induction
and hence descend every GIVEN full tower. That bootstrap is open.

## Sources and audited scope

The auxiliary construction, local scalar variation and corrected jets
are proved in [uniform cyclic25 descent](Sol_cyclic_twentyfive_delayed_descent.md).
The feedback recurrence uses reduction compatibility of
[LSZ Section4, input category and filtered/graded gluing](https://arxiv.org/html/1311.6424v4),
not an assumption that the actual higher oper descends. The one-digit
normal projection is [LSYZ Section6](https://arxiv.org/html/1404.0538v2).
The integral equation uses the independently proved
[all-power mixed-additive norm theorem](Sol_cyclic_power_additive_norm.md).

[Statement](../Theorems/Thm_cyclic_power_late_descent.md) ·
[Focused audit](../Research/audits/CYCLIC_POWER_LATE_DESCENT_AUDIT_2026_09_10.md).
