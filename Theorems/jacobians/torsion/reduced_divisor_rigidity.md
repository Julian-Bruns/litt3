# Pencil separation and low-degree Abel torsion

Let C be a smooth projective connected curve over an algebraically
closed field k, x:C→P¹ a finite map of degree n>1, and

    x_*O_C/O_P¹ = ⊕ O_P¹(−b_i).

Every function f with k(x,f)=k(C) has degree at least max b_i.
Thus, if n is prime, every f outside k(x) has this lower bound,
including when n=char(k). When n is invertible in k the displayed
quotient is the trace-zero bundle. For a hyperelliptic curve of genus g
in odd characteristic it is O(−g−1).

For O∈C(k), write W_r={ [D−rO]: D effective of degree r }⊂J(C).
If ℓ is prime, all local indices of x are prime to ℓ, and
every function of degree at most ℓr belongs to k(x), then

    W_r ∩ (W_r+τ) = ∅   for every nonzero geometric τ∈J(C)[ℓ].

Now suppose C, x and its deck group G are defined over F_q, x is
Galois, x^*(∞)=nO with O rational, r≥1, and every function of
degree at most 2r belongs to k(x).

1. Every class in W_r has a unique effective degree-r representative
   containing no full scheme fiber x^*(b) for b≠∞. Call it x-reduced.
   If r≤n, every nonzero class has a unique ordinary representative;
   the only moving zero-class representatives then occur at r=n
   and are full fibers.
2. Let γ permute geometric points compatibly with divisor classes,
   commute with G, fix O, and have finite orbits on divisors. If the
   x-reduced representative D of α has γ-invariant ramification part,
   then

       α∈W_r, (γ−1)²α=0  implies  (γ−1)α=0.

   This includes γ fixing every ramification point, or D avoiding all
   ramification. On any stratum with D's ramification part fixed, the
   map α↦((1−h)α)_h, for generators h of G, is injective on geometric
   points. In particular1−ρ is injective there when G=⟨ρ⟩.

3. Fix a finite set S of primes different from char(k). Choose N so
   that q^N-Frobenius fixes the ramification points, J[ℓ] for every
   odd ℓ∈S, and J[4] if 2∈S. Every S-primary class in W_r belongs
   to J(C)(F_(q^N)); hence these classes form a finite set of bounded
   order. Each class's x-reduced divisor is rational over that field,
   although its individual support points need not be.

The mixed-primary conclusion concerns the original effective class;
its primary projections need not lie in W_r. No bound uniform in S
or existence of a small clump is asserted.

For an odd-degree hyperelliptic curve of genus g≥2 in odd characteristic,
with all Weierstrass points F_q-rational and basepoint O at infinity,
put σ=Frob_q. If 2r≤g, its two-primary W_r points are F_(q²)-rational.
If ker(σ+I) on two-primary torsion has exponent dividing 2^e and
2^e r≤g, these points are already F_q-rational. If both determinants
of σ−I and σ+I on T₂J have valuation 2g, then W_r∩J[2^∞]⊂J[2]
whenever 2r≤g.

Version5,2026-09-13. [Proof](../../../Proofs/jacobians/torsion/reduced_divisor_rigidity.md).
