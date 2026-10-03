import Solutions.Deformations.GroupNormalFiltration
import Solutions.Deformations.GroupCoefficientFrobenius
import Solutions.Deformations.ElementaryWittInitialCoordinates

namespace Litt3.Deformations

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

theorem elementary_witt_frobenius_normal_weight (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    elementaryWittFrobenius 5 N r k x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d :=
  group_coefficient_map_normal_weight
    (truncatedWittEquiv 5 N (_root_.frobeniusEquiv k 5)).toRingHom 5 (by omega) r d x member

theorem elementary_witt_inverse_frobenius_normal_weight (r d : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (member : x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d) :
    (elementaryWittFrobenius 5 N r k).symm x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d :=
  group_coefficient_map_normal_weight
    (truncatedWittEquiv 5 N (_root_.frobeniusEquiv k 5)).symm.toRingHom 5 (by omega) r d x member

/-- Actual coefficient Frobenius is an additive automorphism of each
actual source weight, including its distinct coefficient twist. -/
noncomputable def elementaryWittFrobeniusWeight (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d ≃+
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d where
  toFun x := ⟨elementaryWittFrobenius 5 N r k x.val,
    elementary_witt_frobenius_normal_weight N k r d x.val x.property⟩
  invFun x := ⟨(elementaryWittFrobenius 5 N r k).symm x.val,
    elementary_witt_inverse_frobenius_normal_weight N k r d x.val x.property⟩
  left_inv x := Subtype.ext ((elementaryWittFrobenius 5 N r k).symm_apply_apply x.val)
  right_inv x := Subtype.ext ((elementaryWittFrobenius 5 N r k).apply_symm_apply x.val)
  map_add' x y := Subtype.ext ((elementaryWittFrobenius 5 N r k).map_add x.val y.val)

end Litt3.Deformations
