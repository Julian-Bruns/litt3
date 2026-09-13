# An explicit maximal two-cover and an unbounded common-cover exclusion

Version1,2026-09-09. Author proof, not independently audited.
Let k=bar(F5), t not in {0,1,2,3}, and

    Y_t: v²=F_t(u)=u(u-1)(u-2)(u-3)(u-t).

Let T_t be the smooth projective model of

    k(u)(sqrt(u),sqrt(u-1),sqrt(u-2),sqrt(u-3),sqrt(u-t)).

The product of the five roots identifies Y_t as a quotient. The map
T_t→Y_t is everywhere finite etale, connected, of degree16, with group
(C2)^4. It is the maximal elementary abelian two-cover of Y_t, and
g(T_t)=17. Its Cartier kernel has dimension exactly

    a(T_t)=0  if t is not in F25;
           1  if t is in F25 minus F5;
           2  if t=4.

Thus T_t is ordinary EXACTLY when t is not in F25. This is Jacobian
ordinariness, not indigenous ordinariness of a projective connection.

## Consequence retaining both actual maps

Suppose t is not in F25 and X is ANY nonordinary smooth projective curve.
There is no common finite etale span X←Z→Y_t for which the Galois
closure of the actual Y_t-leg has group G fitting into

    1→P→G→A→1,   P a5-group, A an elementary abelian2-group.

There is no bound on |P| or on either leg degree. The original legs need
not be Galois and the span need not have a core. In particular this
exclusion applies to the already selected high-degree Y_t and fixed
genus-nine X. More generally it applies to every smooth curve
x-cover y³=F(x) with F squarefree of degree10 in characteristic5:
such an X has Cartier kernel dimension at least3.

The explicit family assertion strengthens prior GENERIC bounded-abelian
ordinarity inputs by determining the condition on this prescribed family.
It does not assert ordinary pullback for arbitrary solvable groups,
arbitrary2-groups, or cyclic degree3 covers. In particular, it does not
exclude all common covers and does not solve the original problem.

[Proof](../../Solutions/genus_two/genus_two_maximal_two_cover.md) ·
[Small polynomial certificate](../../scripts/genus_two/verify_genus_two_maximal_two_cover.py).
