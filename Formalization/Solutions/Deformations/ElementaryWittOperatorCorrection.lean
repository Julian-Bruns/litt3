import Definitions.Deformations.ElementaryWittOperatorLift
import Solutions.Deformations.ElementaryWittFrobeniusResidue
import Solutions.Deformations.GroupCoefficientKernel
import Solutions.Deformations.ElementaryDeckOperators
import Solutions.Deformations.ElementaryWeightStructure

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The canonical literal mod-five reduction supplies the full
coefficient correction bound for a merely additive original deck map. -/
theorem elementary_witt_operator_correction_raises (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (deck : ElementaryDeckEquivariant 5 r L)
    (f : AddMonoidAlgebra k (Fin r → ZMod 5))
    (lift : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (liftReduction : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
      (truncatedWittResidue 5 N (Fact.out : 0 < N) k) lift = f)
    (reduction : ∀ x, AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (L x) =
      f * groupCoefficientEquiv (G := Fin r → ZMod 5) (_root_.frobeniusEquiv k 5)
        (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
          (truncatedWittResidue 5 N (Fact.out : 0 < N) k) x))
    (d : ℕ) (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittOperatorCorrection N r k L lift x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (d + 4) := by
  let R := TruncatedWittVector 5 N k
  let A := AddMonoidAlgebra R (Fin r → ZMod 5)
  let e := elementaryAugmentationParameter (R := R) 5 r
  let D := elementaryWittOperatorCorrection N r k L lift
  have commute : ∀ i y, D (e i * y) = e i * D y := by
    intro i y
    change L (e i * y) - lift * elementaryWittFrobenius 5 N r k (e i * y) =
      e i * (L y - lift * elementaryWittFrobenius 5 N r k y)
    rw [elementary_deck_augmentation_commute 5 r L deck, map_mul,
      elementary_witt_frobenius_parameter]
    ring
  have constantDivisible : ∀ c : R, ∃ z : A, D (algebraMap R A c) = (5 : A) * z := by
    intro c
    have zero : AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N (Fact.out : 0 < N) k) (D (algebraMap R A c)) = 0 := by
      change AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N (Fact.out : 0 < N) k)
          (L (algebraMap R A c) - lift * elementaryWittFrobenius 5 N r k (algebraMap R A c)) = 0
      rw [map_sub, map_mul, reduction, liftReduction,
        elementary_witt_frobenius_residue, sub_self]
    obtain ⟨z, relation⟩ := (truncated_witt_group_residue_kernel 5 N (Fact.out : 0 < N) k
      (Fin r → ZMod 5) (D (algebraMap R A c))).mp zero
    exact ⟨z, by simpa using relation.symm⟩
  have initial : weightedGeneratorFiltration R (5 : A) 4 e 0 = ⊤ := by
    rw [← elementary_five_normal_weights_eq]
    exact elementary_normal_weight_initial 5 (by omega) r
  rw [elementary_five_normal_weights_eq] at member ⊢
  exact weighted_additive_correction_raises D 5 4 e commute constantDivisible initial d x member

end Litt3.Deformations
