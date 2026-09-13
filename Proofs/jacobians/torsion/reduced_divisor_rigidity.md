# Proof: pencil separation, finite differences and Frobenius orbits

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

## 2. A second difference cannot move a low-degree class

Normalize an effective degree-r divisor by replacing each full scheme
fiber x^*(b), b≠∞, by nO. This decreases the degree away from O by n,
so terminates at an x-reduced divisor. Two such divisors D,E in the
same class have a ratio function of degree at most r, hence in k(x).
Every nonzero valuation downstairs away from ∞ would force D or E
to contain a full fiber. Thus the ratio is constant and D=E.

When r≤n, a representative containing a full fiber away from O must
have r=n and be that fiber, representing zero. This recovers ordinary uniqueness for
nonzero classes in the original small-degree range.

The action γ preserves stabilizers, hence G-orbits with their scheme
multiplicities. Since it fixes O, it preserves x-reducedness.
For α=[D−rO] with x-reduced D and (γ−1)²α=0, the divisor (γ−1)²D
is principal. A defining function has degree at most 2r and lies in
k(x), so for h∈G

    (γ−1)²(h−1)D=0

in the free abelian divisor group. On the rational span of its finite
γ-orbit, γ has finite order and is semisimple. Therefore
(γ−1)(h−1)D=0: the divisor γD−D is G-invariant.

Its coefficients vanish on the ramification locus by the assumed
invariance of D's ramification part. Every remaining orbit is free of size n, even in the
wild case or when some inertia is partial. A nonzero positive or
negative part would contain a full unramified fiber inside γD or D,
contradicting x-reducedness. Hence γD=D, with no restriction r≤n.

For the injectivity assertion let D,E have the same ramification part
and (1−h)([D−rO]−[E−rO])=0. The principal divisor(1−h)(D−E)
has positive degree at most2r, so its function is in k(x) and the divisor
is G-invariant. Summing its translates under ⟨h⟩ gives both zero
and ord(h) times that divisor. The free divisor group has no torsion,
so(1−h)(D−E)=0. Applying this to generators makes D−E G-invariant.
It vanishes on ramification; x-reducedness then forces D=E as above.

## 3. Congruent automorphisms: one power formula

Let T be a finite free Z_ℓ-module and γ an automorphism with γ−I
divisible by ℓ, or by 4 if ℓ=2. For every integer m≥1,

    γ^m−I = m(γ−I)E_m,
    E_m = I + ∑_(j=2)^m [binom(m,j)/m](γ−I)^(j−1) ≡ I mod ℓ.  (1)

Indeed binom(m,j)/m=binom(m−1,j−1)/j has valuation at least
−v_ℓ(j). Every term after I is divisible by ℓ: use
j−1−v_ℓ(j)≥1 for odd ℓ and 2(j−1)−v₂(j)≥1 at 2.
Thus E_m is integral, invertible and commutes with γ.

The γ-orbit of an ℓ-primary point has ℓ-power length. If it moves,
let Q=(γ−I)a have order ℓ^s. Taking m=ℓ^(s−1) in (1) gives a
nonzero difference of order ℓ, fixed by γ.

For a mixed-primary class α, select a moving ℓ-component and first
replace γ by the product of the other primary orbit lengths as a
power. This fixes all other components and still moves the selected
one, since that power is prime to ℓ. The preceding construction gives
a power σ with

    (σ−I)α≠0,    (σ−I)²α=0.

Applied to γ=π^N, Section2 contradicts this for α∈W_r: every power
still fixes the ramification and commutes with G. Therefore γ fixes
the whole class, and uniqueness descends its x-reduced representative.
The finite group J(F_(q^N)) supplies the order bound. An admissible N
exists because the ramification and indicated torsion are finite.

## 4. Hyperelliptic two-primary descent

The hyperelliptic pencil has independent-function bound g+1, so
Section2 applies whenever 2r≤g. Rational Weierstrass points generate
J[2]; hence σ=I+2U and σ²=I+4(U+U²). Section3 with S={2}
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
