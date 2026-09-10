# From initial cyclic25 descent to a genuine uniform-level target

2026-09-10. Author research/prompt-selection record; no new later-level
descent theorem. Initial theorem cyclic_twentyfive_initial_descent v1
has geometric and general-scope audits PASS. Main pair unchanged.

## 1. The larger target and why it is useful

For every n>=2, start with a GIVEN compatible lower C_n and its
original cyclic25 cover T_n, including the full tuple through W_(n-1).
Does a GIVEN compatible T_(n+3) force its GIVEN T_(n+1) truncation to
descend compatibly along the original map? The initial n2 case is now
proved with the compatible initial reference. Uniformity would descend
every given full tower, enabling the existing actual bounded-genus
carrier argument at order25. This asks for a reusable mechanism, not
another parameter calculation. It is a larger task than the last one.

Do not assume C_n extends compatibly to C_(n+1); this is part of the
target. A reference C5^0 for the original initial marking is available,
but an arbitrary later C_n need not be its truncation.

## 2. Local reduction to the relative and lower-error issues

Choose an arbitrary SMOOTH next lower curve and normalize its Hodge
obstruction to eta0 in the simple zero line. Its lifted curve cover
is a valid origin of the curve-deformation torsor even if its Hodge
line does not glue. First compatibility upstairs yields

    xi=c e22+d e23+b e24, c^5=eta0.

The original deck generator acts on marked upper lifts. Thus
sigma(T_(n+1))-T_(n+1)=e xi=c e23+d e24. Both are compatible objects;
no action on either higher lift is presumed. A relative SECOND-carry
formula between such objects would be the correct analogue of the
cyclic5 proof, avoiding a nongluing lower reference in the functor.

One must first construct a secondary class on compatible T_(n+1)
that admit one further compatible digit, and prove independence of
that digit. Then a relative formula a^5e would let deck naturality
detect eta0 as the constant coordinate. It is also necessary to prove
that after eta0=0 the e23 direction cannot be hidden by the later
obstruction of the now-compatible lower next lift. The initial theorem
with a fully compatible reference does not settle that latter step.

This is not merely rewriting o=0 as membership in an equivalent
stable image: it proposes a new relative finite-difference identity
and a norm filtration that can be calculated independently, with a
previously checked exact algebraic answer.

## 3. What improves at later precision (tested)

Put m=n-1. In the three-digit comparison the first Hodge changes have
order5^m and the final normal digit has order5^(m+2). Therefore:

- n2: the first square occurs one digit early, so its divided integral
  carry is needed. This is exactly the newly proved product lemma.
- n3: the first square is already at the final digit; no further
  division of that product is needed. A first*second product vanishes.
- n>=4: all products of first changes vanish at the required precision.

Actual special-fiber cyclic25 function products satisfy

    e22A*e22A⊂e20A, e22A*e23A⊂e21A,
    e23A*e23A⊂e22A, e23A*e3A⊂e2A.

These support claims were checked on every relevant binomial-basis
pair by verify_cyclic25_later_level_budget.py. They control n3 ordinary
quadratics IF the actual first coefficients have the predicted support.

There is a concrete reference issue, not resolved just by valuations.
For n>=4 the common descended tuple includes W3, so coefficients of a
three-digit relative comparison can be deck-equivariant at the needed
precision. At n3 it includes only W2. A compatible upper H3 can have
a non-descended25-digit. The explicit oper normalization helps: its
underlying filtered jet transition is prescribed by the descended
curve, while the preceding scalar correction gains two powers of5.
The candidate remaining reference terms are ordinary products of an
e22 first repair with an e23 relative repair, hence lie in e21. This
needs proof from the ACTUAL corrected construction, including its
reduction identifications; it is not yet a certified cochain bound.

## 4. Norm errors and the last genuinely mixed step

The pure algebra already allows arbitrary mixed additive corrections:
for L mod5=e²Phi on R3, coker(L Phi^-1)=O⊕W2(k)e, and
[N eta]=(25eta,0). Thus extra errors multiplied by5N disappear at
this precision, while the leading lower eta0 is detected. The exact
diagnostic verify_cyclic_power_additive_carry.py already varied higher
norm digits independently; its C25 samples pass.

But identifying the actual geometric lower-reference errors with that
norm channel is additional work. The first norm correction of c e22
can require an e2 next repair, unlike the e3 repair in the kernel-only
case. The products e23A*e2A and e22A*e3A need not lie in e2A (the
diagnostic exhibits nonzero e-coordinate witnesses). At n3 these
first*second products should vanish by precision, not by an invalid
filtration assertion. Keeping this distinction is essential.

The proposed prompt will supply the initial theorem and full mixed
algebra, and ask for uniform ORIGINAL-map descent, including these
reference/normalization checks and the consequent full-tower induction.
It will not ask for the entire common-cover conjecture or a repeat
proof of the initial coefficient.

## 5. Why not jump immediately to every cyclic power

There is a real new initial-level channel at125. After the first repair,
the next curve/Hodge repairs can be in e23 of a125-point function
algebra. That image is F101, and its square need not lie even in eA:
B100 and B24 both belong to it, but B100*B24=B124 modulo5. A square
of second Hodge repairs has order5^4, precisely the third-carry digit
of the initial125 problem. This is an explicit failure of a proposed
filtration shortcut, NOT a nonzero geometric obstruction. It supports
finishing uniform25 before asking a much less controlled all-power task.
