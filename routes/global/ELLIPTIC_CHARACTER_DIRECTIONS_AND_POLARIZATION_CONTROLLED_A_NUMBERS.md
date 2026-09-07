# Elliptic character directions: polarization-controlled a-numbers

Author /root,2026-09-05; consolidated2026-09-07.
The ordinary-complement specialization received focused PASS from
/root/gluing_cohomology_rigidity2026-09-05. The general supersingular
subgroup argument remains AUTHOR-only; no audit body was opened.
Version2 adds the direct one-unit refinement when that subgroup is
proper, without extending the earlier audit's scope.

## 1. Exact statement

Over algebraically closed k of characteristic p>0, let C be smooth
projective connected hyperbolic, i:E↪J(C) an elliptic subvariety, and

    e=deg i*O(Θ_principal),        ASSUME E^(1)⊄Θ_C.       (1)

For every finite prime-to-p subgroup Λ⊂E^(1)(k), form its actual
connected abelian etale character cover W_Λ/C. There is a finite Λ₀
such that all W_Λ/W_Λ₀ with Λ⊃Λ₀ have ordinary Prym. All these
covers and their actual etale intermediate curves have only finitely
many hyperbolic etale targets with NO ordinary simple Jacobian factor.
This permits ALL prime supports at once, not just one fixed finite set.

Uniformly in Λ and its degree,

    a(W_Λ)≤(p−1)(e−1)                    if E is ordinary,
    a(W_Λ)≤(p−1)(e−1)+a(C)               if E is supersingular. (2)

For supersingular E and H=ker V_E PROPER in K=(ker V_J(C))^0,
the second bound improves to

    a(W_Λ)≤(p−1)(e−1)+a(C)−1.                             (3)

Every ACTUAL etale target of W_Λ or an etale intermediate satisfies
the same numerical bound, WITHOUT a restriction on its Jacobian factors.
Neither a-number bound is asserted to bound Δ=g−f or |Λ₀|.

If J(C)/E is ordinary, hypothesis(1) is automatic and a(C)=0 or1
according as E is ordinary or supersingular. The previously focused
checked bound is therefore (p−1)(e−1)+a(C); it is retained in full.

## 2. One determinant calculation gives finiteness and multiplicity bounds

Set D=Θ_C|E^(1), an effective divisor by(1). Its degree is(p−1)e,
by Raynaud's divisor class. Over a local DVR of E^(1), a two-term
free complex computes B_C⊗L; Euler characteristic0 makes its matrix
square and(1) makes it generically invertible. Smith normal form gives

    h⁰(C^(1),B_C⊗L)≤mult_L D,
    a(W_Λ)=Σ_(L∈Λ)h⁰(C^(1),B_C⊗L), B_C=F_*O_C/O_C^(1).  (4)

The second identity is etale Frobenius base change and character
decomposition. The prime-to-p torsion points of D form a finite set.
Their generated Λ₀ is finite, so the [finite-character descent theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
proves the ordinary-Prym and actual-target assertions, controlling
all Frobenius iterates rather than only the first kernel.

If E is ORDINARY, ker V_E contains p−1 nonidentity geometric points,
each of order p. Functoriality embeds them in ker V_J(C); for the
corresponding nontrivial line bundle L, F_C*L=O_C. Thus the
Frobenius exact sequence gives k↪H⁰(B_C⊗L). Each consumes at
least one unit of deg D and none belongs to Λ. Subtract these p−1
units in(4) to obtain the first bound in(2), without requiring C ordinary.

## 3. Supersingular subgroups: keep the scheme structure

For supersingular E, H=ker V_E has algebra k[t]/(t^p) and lies
in K=(ker V_J(C))^0. Tong's Dirac property says that a local theta
equation restricts to a NONZERO socle element of the Artin local
Gorenstein algebra O_K.

If H=K, its image on H is a unit times t^(p−1), so mult_0 D=p−1.
If H is proper, its image is ZERO: the one-dimensional socle of
O_K lies in every nonzero ideal. Indeed, the last nonzero term of
the maximal-ideal filtration of an ideal lies in, hence spans, the
socle; apply this to ker(O_K→O_H). Therefore the local equation
on E vanishes modulo t^p and mult_0 D≥p. It is not identically
zero by(1). In all cases mult_0 D≥p−1; in the proper case it is
at least one larger. Separate the zero character in(4):

    a(W_Λ)≤a(C)+(p−1)e−mult_0 D.

This proves both the old supersingular bound and refinement(3).
No claim about a(C)'s invariance under a p-divisible isogeny is used.
Sources read directly: [Tong, Definitions1.2.7.1/1.2.7.4 and
Theorem1.2.7.7; divisor class Corollary1.2.3.2](https://arxiv.org/pdf/0712.2046).
The proper-subgroup refinement is this note's elementary author inference.

If J(C)/E is ordinary, K maps trivially to its etale Verschiebung
kernel, hence lies in E^(1). Nonzero restriction of the theta equation
to K prevents identically zero restriction to E^(1), proving(1).
Poincare reducibility and p-rank additivity give Δ(C)=1−f(E).
Since a(C)=0 exactly when ordinary and a(C)≤Δ(C), the stated
values0/1 follow. In particular H=K in the supersingular-complement
case, consistent with keeping its old bound separate from(3).

Finally an actual finite etale W_Λ→T pulls B_T back to B_W_Λ.
Faithfully flat pullback injects global sections, so a(T)≤a(W_Λ).
For an intermediate source, compose its TWO actual maps first.
For the elliptic Prym of a double cover of an ordinary genus-two
base, e=2; the old four/five bound in characteristic5 is retained in
the [genus-two inversion theorem](GENUS_TWO_INVERSION_TOWERS_AND_FINITE_TARGETS.md),
whose additional monodromy and nonsplit-family conclusions are distinct.
