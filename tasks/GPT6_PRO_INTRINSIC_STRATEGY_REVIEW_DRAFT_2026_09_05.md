# Draft for one fresh-perspective Pro request

Prepared 2026-09-05. Not sent. WITHDRAWN at the user's clarification:
fresh strategies must come from attempting a specific useful lemma,
not a broad strategy review. Do not submit this draft.

This is an exploratory strategy-review request, not a claim that a
specific Pro-solvable lemma now closes a known reduction. The recent
screen did not identify such a lemma. Use this only if fresh route
selection is itself the intended use of the request.

The draft keeps the goal and necessary context explicit, following
the [official GPT-6 prompting guidance](https://developers.openai.com/api/docs/guides/latest-model#prompting-best-practices).
That guidance is general prompting advice, not evidence of success on
this mathematical problem or a guarantee about Pro.

## Copy-paste prompt

We are investigating Litt Problem 3: do any two smooth projective curves
of genus at least two over k=Fbar_5 have a common finite étale cover?
We seek a counterexample, but your task is narrower: give a fresh,
critically tested structural approach to the compatibility of TWO
étale maps on the SAME curve. Do not try to finish Litt3.

The configuration is an actual span f:Z→X, g:Z→Y, with all curves
smooth, projective and connected and both maps finite étale.
Degrees are unbounded; neither leg need be Galois. We may require
k(Z)=k(X)k(Y) and k(X)∩k(Y)=k inside k(Z), i.e. minimal source and
no common function-field core. Our current proposed endpoints have
g(X)=9, g(Y)=25, nonhyperelliptic X, hyperelliptic Y, absolutely simple
Jacobians, Hom(JX,JY)=0, and p-ranks 6 and 25 respectively. These
invariants are optional test hypotheses, not an invitation to assert
they characterize the endpoints. Prefer a method using fewer of them.

Treat the following as established inputs; do not spend the response
reproving them.

1. Étale pullback embeds the canonical rings R(C)=⊕H⁰(C,ω_C^m)
as finite graded subrings of R(Z), preserving

   {a(dt)^m,b(dt)^n}=(n b a'−m a b')(dt)^(m+n+1).

Conversely finite graded Poisson embeddings recover étale maps.
Thus this algebraic formulation retains the full étale condition.

2. In the coreless case R(X)∩R(Y) is k or k[s]. The existence of
s is NOT known. If it exists, its primitive weight d is prime to 5.
For r∈{1,2,3,4} with rd≡1 mod5 and n=(rd−1)/5, twisted Cartier
C_n(s^r) is zero unless d divides 4; for d=1,2,4 it is c s.
Every further eligible power gives the same test. When c≠0,
normalization reduces the endpoint possibilities to finite lists.
The c=0 branch still allows unbounded d.

3. For β,γ∈g*H⁰(Y,ω_Y) with {β,γ}≠0 and 5 not dividing m,
the simultaneous conditions

   {α,β},{α,γ} ∈ g*H⁰(Y,ω_Y^(m+2))

force α∈g*H⁰(Y,ω_Y^m). This is an exact factorization test, NOT
a theorem that the conditions hold. Indeed, when Hom(JX,JY)=0
and either leg has degree prime to five, the corresponding
two-probe defect on f*H⁰(X,ω_X) is injective.

4. A one-leg decomposition is available for any fixed quartic A:
on a Galois closure W→C with group G, the functor

   M ↦ (H⁰(C,ω_C²⊗E(M)), q↦C_1(Aq))

on finite F₅[G]-modules is exact. For W/H→C use M=F₅[G/H].
Invertibility is tested on its simple composition factors.
The missing information is how TWO legs constrain each other.

Known failure tests:

- Lifting is excluded as a proposed strategy. In characteristic five
one finite étale cover can destroy ordinariness of every ordinary
nilpotent indigenous datum on a fixed genus-two endpoint.
- Goodness of the quartic operator is not tensor-closed: two good
double covers can have a bad fiber product. Conversely all fifteen
doubles of a genus-two curve can be good while a D8 cover is bad
through its nonlinear simple representation.
- Infinite incidence-graph growth can cancel completely modulo five
in abstract graphs. A graph argument must use actual curve geometry.
- Exact regular one-forms can generate basepoint-free birational
canonical subsystems in unbounded genus.
- Actual coreless étale spans with Hom(JX,JY)=0 exist in
characteristic five. Those hypotheses alone cannot be contradicted.

Your deliverable: select ONE new intrinsic mechanism, state the precise
compatibility question it would address, and establish its first
nontrivial lemma or give an explicit decisive test of it. Explain how
the conclusion restricts actual two-leg configurations in an
unbounded-degree class, and what further implication would still be
missing. A relevant theorem from another setting is welcome only if
you inspect which step of its proof survives here.

Do not respond with a broad list of theories, a renamed form of
Litt3, or a lemma whose usefulness depends on an unstated implication.
Check your proposal against the failure tests above. If no route
survives, give the strongest concrete reason rather than manufacturing
an optimistic conjecture.
