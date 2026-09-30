# Proof: pencil separation and almost rational Abel classes

[Statement](../../../Theorems/jacobians/torsion/reduced_divisor_rigidity.md).

## 1. The quotient by constants controls independent pencils

Suppose k(x,f)=k(C) and deg f=e. The map (x,f) is birational onto
an integral curve Γ⊂P¹×P¹ of bidegree (e,n), finite flat over the
first factor. Pushing forward its divisor sequence gives

    0 → O_P¹ → x_*O_Γ → O_P¹(−e)^(n−1) → 0.

Normalization induces a generically full-rank injection

    O(−e)^(n−1) → x_*O_C/O = ⊕ O(−b_i).

The quotient by constants is locally free: the unit submodule is
saturated, since a scalar in k(P¹) integral over a base local ring
belongs to that normal ring. The induced injection follows because
the constant submodules agree. If e<b_i its i-th row vanishes,
contradicting full rank. This proves the bound in every characteristic,
without a separability assumption. Prime extension degree supplies
k(x,f)=k(C) for every f outside k(x).

For the ℓ-torsion separation criterion, let [E−D]∈J[ℓ], with E,D
effective of degree r. A function with divisor ℓ(E−D) has degree
at most ℓr, so is R(x). All local indices are prime to ℓ; hence
every valuation of R is divisible by ℓ. On P¹ this makes R a scalar
times an ℓ-th power. Cancelling ℓ in the free divisor group shows
E−D principal. Thus the only possible translation is zero.

## 2. Almost fixed classes

We use almost fixed and almost rational in the sense of
[Baker–Ribet, Definition1 and Remark2.2](https://math.berkeley.edu/~ribet/Articles/ja.pdf#page=4).
The implication (γ−1)²α=0⇒γα=α is their Lemma2.4(2).

Normalize an effective degree-r divisor by replacing each full scheme
fiber x^*(b), b≠∞, by nO. This decreases the degree away from O by n,
so terminates at an x-reduced divisor. Two such divisors D,E in the
same class have a ratio function of degree at most r, hence in k(x).
Every nonzero valuation downstairs away from ∞ would force D or E
to contain a full fiber. Thus the ratio is constant and D=E.

When r≤n, a representative containing a full fiber away from O must
have r=n and be that fiber, representing zero. This recovers ordinary uniqueness for
nonzero classes in the original small-degree range.

The Γ-action preserves stabilizers, hence scheme fibers and reducedness.
For (σ+τ−2)α=0, the principal divisor (σ+τ−2)D has a function of
degree at most2r, hence in k(x). It is G-invariant. Thus for h∈G,
the divisor v=(h−1)D satisfies 2v=σv+τv. In the real vector space
on its finite Γ-stable support, σ and τ are orthogonal permutations:

    ‖σv−v‖²+‖τv−v‖²=0.

So σv=τv=v. Consequently σD−D and τD−D are G-invariant and
vanish on ramification. Every other orbit is a full unramified fiber.
A positive or negative coefficient would place that fiber inside a
translate of D or D itself, contradicting reducedness. Thus σD=τD=D.
This works with wild or partial inertia and with no restriction r≤n.

For the injectivity assertion let D,E have the same ramification part
and (1−h)([D−rO]−[E−rO])=0. The principal divisor(1−h)(D−E)
has positive degree at most2r, so its function is in k(x) and the divisor
is G-invariant. Summing its translates under ⟨h⟩ gives both zero
and ord(h) times that divisor. The free divisor group has no torsion,
so(1−h)(D−E)=0. Applying this to generators makes D−E G-invariant.
It vanishes on ramification; x-reducedness then forces D=E as above.

## 3. Published torsion order law and rationality

[Boxall–Grant, Singular torsion points on elliptic curves,
Proposition2.3(ii)](https://boxall.pages.math.cnrs.fr/pages-web-mathematiques-de-john-boxall/wwwMaths/SingularFinal.pdf#page=9)
applies to any commutative algebraic group over a field. With their
δ(ℓ)=1 for odd ℓ and δ(2)=2, a Galois element τ fixing J[ℓ^δ(ℓ)]
satisfies, for P∈J[ℓ^∞], Q=(τ−1)P and b≥1,

    ord((τ^b−1)P)=ord([b]Q).                         (1)

Use (1) on each primary component of α∈W_r∩J_Ω. If τ∈Gal(k/K₁)
moves α, choose b so that 0≠[b](τ−1)α∈J[L]. Equation(1) makes
0≠(τ^b−1)α∈J[L], which τ^b fixes. This contradicts Section2.
Thus α∈J(K₁); uniqueness descends its reduced divisor. This is the
argument in Boxall–Grant's proof of PropositionC, with rationality
retained before the order bound. Over a finite field J(K₁) is finite.

## 4. Hyperelliptic two-primary descent

The hyperelliptic pencil has independent-function bound g+1, so
Section2 applies whenever 2r≤g. Rational Weierstrass points generate
J[2]; hence σ=I+2U and σ²=I+4(U+U²). Section3 with Ω={2}
places all two-primary W_r points in J(F_(q²)).

For further descent, b=(σ−I)a satisfies (σ+I)b=0. If b has order
2^t>1, then t≤e and a'=2^(t−1)a lies in W_(2^(t−1)r).
Its Frobenius difference is nonzero two-torsion, fixed by σ, so
(σ−I)²a'=0. Since 2^t r≤2^e r≤g, Section2 gives a contradiction.
Thus b=0. This includes t=1.

Finally σ±I are divisible by2 on the rank-2g Tate module. If their
determinants both have valuation2g, the two quotients by2 are units.
The preceding argument with e=1 gives F_q-rationality, and ker(σ−I)
on two-primary torsion is J[2]. This proves the final corollary.

The [bounded audit](../../../Research/audits/PENCIL_TORSION_FOUNDATION_AUDIT_2026_09_13.md)
checks the general pencil, reduced-divisor and mixed-primary arguments.
The hyperelliptic specialization also retains its
[original audit](../../../routes/global/audits/ENDPOINT_TWO_PRIMARY_LOW_DEGREE_TORSION_AUDIT_2026_09_06.md).
