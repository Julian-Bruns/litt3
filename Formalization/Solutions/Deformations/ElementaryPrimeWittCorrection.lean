import Solutions.Deformations.ElementaryPrimeWittPolynomial
import Solutions.Deformations.ElementaryWittFrobeniusResidue
import Solutions.Deformations.GroupCoefficientKernel
import Solutions.Deformations.ElementaryDeckOperators
import Solutions.Deformations.ElementaryWeightStructure

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The genuine original mod-p reduction gives a full weight-(p-1)
additive correction. No coefficient linearity or commuting higher
coefficient operators are assumed. -/
theorem elementary_prime_witt_correction_raises (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (deck : ElementaryDeckEquivariant p r L)
    (f : AddMonoidAlgebra k (Fin r → ZMod p))
    (lift : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (liftReduction : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p N (Fact.out : 0 < N) k) lift = f)
    (reduction : ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N (Fact.out : 0 < N) k) (L x) =
      f * groupCoefficientEquiv (G := Fin r → ZMod p) (_root_.frobeniusEquiv k p)
        (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
          (truncatedWittResidue p N (Fact.out : 0 < N) k) x))
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
      (Fact.out : p.Prime).pos r d) :
    elementaryPrimeWittOperatorCorrection p N k r L lift x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p
        (Fact.out : p.Prime).pos r (d + (p - 1)) := by
  let R := TruncatedWittVector p N k
  let A := AddMonoidAlgebra R (Fin r → ZMod p)
  let e := elementaryAugmentationParameter (R := R) p r
  let D := elementaryPrimeWittOperatorCorrection p N k r L lift
  have commute : ∀ i y, D (e i * y) = e i * D y := by
    intro i y
    change L (e i * y) - lift * elementaryWittFrobenius p N r k (e i * y) =
      e i * (L y - lift * elementaryWittFrobenius p N r k y)
    rw [elementary_deck_augmentation_commute p r L deck, map_mul,
      elementary_witt_frobenius_parameter]
    ring
  have constantDivisible : ∀ c : R, ∃ z : A, D (algebraMap R A c) = (p : A) * z := by
    intro c
    have zero : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N (Fact.out : 0 < N) k) (D (algebraMap R A c)) = 0 := by
      change AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N (Fact.out : 0 < N) k)
          (L (algebraMap R A c) - lift * elementaryWittFrobenius p N r k (algebraMap R A c)) = 0
      rw [map_sub, map_mul, reduction, liftReduction,
        elementary_witt_frobenius_residue, sub_self]
    obtain ⟨z, relation⟩ := (truncated_witt_group_residue_kernel p N (Fact.out : 0 < N) k
      (Fin r → ZMod p) (D (algebraMap R A c))).mp zero
    exact ⟨z, relation.symm⟩
  have initial : weightedGeneratorFiltration R (p : A) (p - 1) e 0 = ⊤ := by
    rw [← elementary_prime_normal_weights_eq p (Fact.out : p.Prime)]
    exact elementary_normal_weight_initial p (Fact.out : p.Prime).pos r
  rw [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)] at member ⊢
  exact weighted_additive_correction_raises D p (p - 1) e commute constantDivisible initial d x member

end Litt3.Deformations
