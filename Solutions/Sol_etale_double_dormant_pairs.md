# Proof: deck orbits, length saturation, and simple modules

[Statement](../Theorems/Thm_etale_double_dormant_pairs.md).
Author /root,2026-09-08. No independent whole-theorem audit claimed.

## 1. Canonical square-root torsor and two actual dormant connections

By `nilpotent_scalar_model`, s=E(r)/3 is a normalized regular quartic
with div(s)=2D and D reduced. The canonical section of O(D), squared
and compared with s, supplies an isomorphism L_s²=O, where
L_s=O(D) tensor omega^(-2). Thus Spec(O plus L_s) is an actual etale
double torsor; it is connected precisely when L_s is nontrivial.
Its tautological trivialization makes the section of omega² tensor L_s
into q, with q²=pi^*s and reduced divisor pi^*D. Changing sheet changes
q to−q. This description is independent of rational coordinates.

The Cartier product rule gives

    C_3(q^8)=q C_1(q^3).

The left side is q². Since q is nonzero, C_1(q³)=q. Write q=b(dt)².
The scalar inverse in `nilpotent_scalar_model` gives

    pi^*r=3(b²)''/b²+((b²)'/b²)²=b''/b.

`cartier_dormant_secants` therefore makes pi^*r±q dormant and regular.
They are distinct because q is nonzero and2 is invertible.

Conversely, let r' and tau^*r' be distinct dormant connections on a
connected etale double. Their midpoint r0 is invariant, hence descends
as a regular connection on C by etale descent. Their half-difference q
is anti-invariant. The secant identity says

    r0=b''/b,  E(r0)=3q²,  C_1(q³)=q.

Consequently q² descends and recovers an active regular nilpotent r.
When div(q) is reduced, r is admissible and its root torsor is exactly
the given double: its root is anti-invariant and cannot descend to C.
The formulas recover the original unordered pair, proving bijectivity.
For a split torsor the same argument is precisely the secant bijection
on C, with no deck-orbit quotient ambiguities.

For an actual compatible span X←Z→Y, the two pulled-back quartics and
their half-divisors agree. Hence their L_s torsors are isomorphic over
Z, including the quadratic trivializations. Their common pullback
torsor is etale over Z. Choose any connected component and the endpoint
components it maps onto. This supplies BOTH actual finite etale legs
and a common q; its two dormant connections agree along these maps.
The component may split over Z; no statement that its new span remains
coreless is needed or inferred.

## 2. Factorization of the linearized curvature, on the SAME curve

First suppose q=a(dt)² is global, s=q² and r=a''/a. For a rational
quadratic v define B(v)=(v''−r v)/a. Linearization of the determinant
curvature at this active nilpotent gives

    dDelta_r(v)=D^4(a²v)=a^4(B²(v)−v).              (5)

This identity includes its coefficient, not just its kernel. One exact
derivation starts from

    D^4(a³)+a^5=3a³ E(r+a)=3a³ E(r−a).

Differentiate in direction v, using E(r±a)=0, to obtain the second
equality of(5). Differentiating
Delta=−E'^2−3E(E''+3rE), substituting E=3a², gives the first.
The [jet checker](../scripts/check_cartier_dormant_secants.sage) verifies
both with their exact error terms before imposing E(r±a)=0:

    D^4(a²v)−a^4(B²v−v)=3a²v E(r±a),
    dDelta_substituted(v)−D^4(a²v)=2a²v E(r±a).

The kernel of dDelta is exactly the tangent space to the nilpotent fiber
from `nilpotent_scalar_model`. Although B is initially rational, it
preserves regularity on that kernel. Indeed, Bv has at most simple
poles at the simple zeros of a. If w=Bv had leading term c/t at one
of them, then Bw would have leading term 2c/(a_1 t^4), where
a=a_1 t+O(t²). It could not equal the regular v. Since(5) gives B²v=v,
no such pole is possible. Away from those zeros regularity is automatic.
Now B preserves this kernel and is an involution. Because2 is invertible,
it splits into its two eigenspaces. The equation Bv=±v is precisely

    v''−(r±a)v=0,

the dormant tangent equation. This proves the direct-sum assertion.

For nontrivial L_s, apply this on the connected etale double. Its deck
involution fixes r and sends a to−a, so it anticommutes with B. Hence
it exchanges the two eigenspaces, which have equal dimension. The deck
invariants of the nilpotent tangent space descend exactly to T_nil(C,r),
by etale descent and naturality of determinant curvature. Invariants of
two exchanged summands are isomorphic to either summand. This proves
both assertions in(2), including the exact doubling of any nonzero defect.

Zero nilpotent tangent is the ordinary nilpotent condition: the finite
flat determinant map has source and target of the same dimension, and
is etale precisely when its tangent kernel is zero. Thus the resulting
ordinary-status equivalence concerns THIS canonical cover, not arbitrary
etale covers. No simultaneous deformation or lifting is used.

## 3. Exhausting deck orbits in genus two

Fix nontrivial L and pi:C_L→C. Riemann–Hurwitz gives genus(C_L)=3.
Invariant regular projective connections descend through the etale
double. A descended connection is dormant iff its pullback is dormant,
since differential pullback is injective. Thus fixed points of the
involution on Dorm(C_L) are exactly the n pulled-back points of Dorm(C).

Every other involution orbit is a pair. Its midpoint descends as an
active regular nilpotent on C. Every such object on genus two is
admissible, by the degree/parity result in `nilpotent_scalar_model`.
Thus its q has simple zeros, and Section1 applies without an additional
restriction. Nonfixed orbits are exactly the A_L objects. This proves
#Dorm(C_L)=n+2A_L. For L=O, all unordered pairs downstairs give active
nilpotents, automatically admissible again. Uniqueness of the square
root of E(r)/3 up to sign proves A_O=binomial(n,2), not just an inequality.

Here is the precise length input. Wakabayashi,
[*An explicit formula for the generic number of dormant indigenous bundles*](https://arxiv.org/pdf/1411.1191),
Theorem3.3 gives a finite flat dormant scheme over curve moduli.
Corollary5.4 applies when p>2(g−1); its genus-two and genus-three degrees
are (p³−p)/24 and (p⁶+10p⁴−11p²)/1440 (Section6.2, p24).
Both hypotheses hold at p=5. Thus EVERY fiber has length5 or15,
not merely a generic point count. The statements and proof of3.3,
Corollary5.4 and the displayed evaluations were read directly.

When n=5, each A_L≤5. There are fifteen nontrivial2-torsion classes,
and A_O=10. Therefore at most85 distinct active nilpotents occur.
If there are85, every inequality is equality: A_L=5. Then C_L has
15 distinct points in a scheme of length15. Every local length is one,
so the whole dormant scheme is reduced. This is exact length saturation;
no Jacobian ordinarity or genericity of C_L was assumed.

## 4. All order-two twisted tangents, without another enumeration

At a dormant potential r the linearization of r''−3r² is q''−r q.
For a flat torsion line L, this equation is intrinsic in flat local
frames; equivalently pull it to its etale trivialization.
The quadratic spaces on C_L split as

    H^0(C_L,omega²)=H^0(C,omega²) plus H^0(C,omega² tensor L).

Deck eigenvalues are±1. The tangent equation commutes with deck action,
so its two kernels are precisely the untwisted and L-twisted tangent
spaces at r. Reducedness of Dorm(C_L) kills both. The trivial L case
already follows from the five distinct points in length5 on C.
This proves (4) of the statement simultaneously for every r and every L.
Section2 also makes all85 active base objects ordinary: use the two
reduced base dormant points for trivial L_s, and either reduced dormant
point of C_L for nontrivial L_s. No extra Jacobian calculation is needed.

## 5. Normal5 kernels: the non-Galois, unbounded extension

Let W→C be the ACTUAL finite etale Galois closure, with group G. Set

    T_W={q in H^0(W,omega_W²): q''−r_W q=0}.

It is a finite-dimensional k[G]-module. If it is nonzero, choose a
simple submodule S. Any finite5-group acting in characteristic5 has
nonzero invariants. Since P is normal, S^P is a nonzero G-submodule;
simplicity forces S^P=S. Hence S factors through B. All simple modules
of the abelian prime-to5 group B are one-dimensional characters with
orders dividing N. Their associated lines on C belong to Pic(C)[N].
Use their canonical flat local frames, supplied by the corresponding
etale Kummer torsors; their character values need not lie in F5.

Etale descent identifies the chi-isotypic part of T_W with the twisted
tangent space for that line bundle: equivariant regular quadratics
descend, and the local differential equation commutes with pullback.
The stated twisted vanishing says this space is zero, a contradiction.
Thus T_W=0.
Pullback from every intermediate T is injective on regular quadratics
and preserves the equation, proving the assertion for T→C, whether
or not this original leg is Galois. No averaging by|G| is used.

This is a preservation theorem for the tangent space of a SPECIFIED
dormant oper. It neither preserves ordinary nilpotent indigenous data
nor guarantees that a second endpoint oper pulls back to the same one.
The count alone tests N=2. Order-four characters need the separate N=4
test; nonlinear simple2-group representations are not covered by either.
An arbitrary tower of good doubles is not asserted good.

## 6. Exact backup evidence and remaining scope

For C_alpha:v²=u(u−1)(u−2)(u−3)(u−alpha), alpha³+alpha+1=0 over F125,
the [saved nilpotent replay](../Research/computations/backup_genus_two_nilpotents_verification.json)
verifies5 dormant points,85 active points, all original equations and
four double zeros for every active quartic. Its75 nonsquare quartics
are already partitioned five per nontrivial Hasse root class.
The [separate twisted tangent certificate](../Research/computations/backup_genus_two_twisted_tangents.json)
checks all80 pairs independently using exact full-rank minors and
Bezout inverses, without enumerating their extension-field points.
This corroborates Section4 but is not an independent audit of this proof.
The geometric hypotheses remain visible; no common-cover exclusion or
replacement of the active fixed X/Y pair follows just from this packet.
