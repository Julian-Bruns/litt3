import Solutions.Deformations.ElementaryPrimeWittCorrection

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual arbitrary-prime additive deck operator has exactly its
original homogeneous principal action. All higher coefficient operators
remain merely additive; the strict degree restriction is explicit. -/
theorem elementary_prime_witt_principal_leading (r a : ℕ) (degreeBound : a + 1 ≤ p - 1)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (deck : ElementaryDeckEquivariant p r L)
    (q h : MvPolynomial (Fin r) k) (homogeneous : q.IsHomogeneous a)
    (higher : ∀ alpha, h.coeff alpha ≠ 0 → a + 1 ≤ ∑ i, alpha i)
    (reduction : ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N (Fact.out : 0 < N) k) (L x) =
      (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod p)))
        (elementaryAugmentationParameter (R := k) p r) *
        groupCoefficientEquiv (G := Fin r → ZMod p) (_root_.frobeniusEquiv k p)
          (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
            (truncatedWittResidue p N (Fact.out : 0 < N) k) x))
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r d) :
    L x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r (d + a) ∧
    L x - elementaryPrimeWittPolynomialLift p N k r q * elementaryWittFrobenius p N r k x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
        (Fact.out : p.Prime).pos r (d + a + 1) := by
  let R := TruncatedWittVector p N k
  let Q := elementaryPrimeWittPolynomialLift p N k r q
  let H := elementaryPrimeWittPolynomialLift p N k r h
  let D := elementaryPrimeWittOperatorCorrection p N k r L (Q + H)
  have liftReduction : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p N (Fact.out : 0 < N) k) (Q + H) =
      (q + h).eval₂ (algebraMap k (AddMonoidAlgebra k (Fin r → ZMod p)))
        (elementaryAugmentationParameter (R := k) p r) := by
    rw [map_add, elementary_prime_witt_polynomial_reduction,
      elementary_prime_witt_polynomial_reduction, MvPolynomial.eval₂_add]
  have correction := elementary_prime_witt_correction_raises p N k r L deck _ (Q + H)
    liftReduction reduction d x member
  have correctionHigher := elementary_normal_weight_antitone (R := R) p (Fact.out : p.Prime).pos r
    (show d + a + 1 ≤ d + (p - 1) by omega) correction
  have frobeniusMember := elementary_prime_witt_frobenius_weight p N k r d x member
  have qMember := elementary_prime_witt_homogeneous_weight p N k r a q homogeneous
  have hMember := elementary_prime_witt_polynomial_weight p N k r (a + 1) h higher
  have qProduct := elementary_prime_normal_weight_mul (R := R) p (Fact.out : p.Prime) r a d Q
    (elementaryWittFrobenius p N r k x) qMember frobeniusMember
  have hProduct := elementary_prime_normal_weight_mul (R := R) p (Fact.out : p.Prime) r (a + 1) d H
    (elementaryWittFrobenius p N r k x) hMember frobeniusMember
  have identity : L x - Q * elementaryWittFrobenius p N r k x =
      H * elementaryWittFrobenius p N r k x + D x := by
    change L x - Q * elementaryWittFrobenius p N r k x =
      H * elementaryWittFrobenius p N r k x +
        (L x - (Q + H) * elementaryWittFrobenius p N r k x)
    ring
  have tail : L x - Q * elementaryWittFrobenius p N r k x ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r (d + a + 1) := by
    rw [identity]
    exact Submodule.add_mem _ (by simpa only [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm]
      using hProduct) correctionHigher
  refine ⟨?_, tail⟩
  have tailLower := elementary_normal_weight_antitone (R := R) p (Fact.out : p.Prime).pos r
    (show d + a ≤ d + a + 1 by omega) tail
  have reconstruct : L x = Q * elementaryWittFrobenius p N r k x +
      (L x - Q * elementaryWittFrobenius p N r k x) := by abel
  rw [reconstruct]
  exact Submodule.add_mem _ (by simpa only [Nat.add_comm] using qProduct) tailLower

end Litt3.Deformations
