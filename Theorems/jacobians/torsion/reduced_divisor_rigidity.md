# Pencil separation and almost rational Abel classes

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

Now suppose x is Galois with deck group G, x^*(∞)=nO, r≥1, and
every function of degree at most 2r belongs to k(x).

1. Every class in W_r has a unique effective degree-r representative
   containing no full scheme fiber x^*(b) for b≠∞. Call it x-reduced.
   If r≤n, every nonzero class has a unique ordinary representative;
   the only moving zero-class representatives then occur at r=n
   and are full fibers.
2. Let Γ act on geometric points compatibly with divisor classes,
   commute with G, fix O, and have finite orbits on divisors. If the
   ramification part of the x-reduced representative D of α is
   Γ-invariant, then α is almost fixed by Γ:

       (σ+τ−2)α=0  implies  σα=τα=α,   σ,τ∈Γ.

   In particular (γ−1)²α=0 implies γα=α. This includes Γ fixing
   every ramification point, or D avoiding ramification.
   On any stratum with D's ramification part fixed, the
   map α↦((1−h)α)_h, for generators h of G, is injective on geometric
   points. In particular1−ρ is injective there when G=⟨ρ⟩.

3. Suppose k is an algebraic closure of a perfect field K over which
   C,x,G and O are defined.
   Let K₀=K(Ram(x)), let Ω be a finite set of primes, and put

       δ(ℓ)=1 for odd ℓ,   δ(2)=2,   L=∏_(ℓ∈Ω) ℓ^δ(ℓ),
       K₁=K₀(J[L]).

   Here J[L] means geometric torsion and J_Ω denotes torsion whose
   order is supported on Ω. Every W_r class is almost rational over
   K₀ (almost fixed by its absolute Galois group), and

       W_r ∩ J_Ω ⊂ J(K₁).

   Its x-reduced divisor is K₁-rational. For K=F_q, any N for which
   q^N-Frobenius fixes Ram(x) and J[L] therefore gives rationality
   over F_(q^N) and a finite set of bounded order.

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

Version6,2026-09-14. [Proof](../../../Proofs/jacobians/torsion/reduced_divisor_rigidity.md).
