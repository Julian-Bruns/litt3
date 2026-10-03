import Definitions.CartierAndSpin.SharedDifferentialSubspaces
import Definitions.SharedTensors.ConstantIntersection
import Solutions.SharedTensors.OneVariableKaehler
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k F G E : Type*} [Field k] [Field F] [Field G] [Field E]
  [Algebra k F] [Algebra k G] [Algebra k E] [Algebra F E] [Algebra G E]
  [IsScalarTower k F E] [IsScalarTower k G E]

/-- A nonzero form in BOTH literal endpoint images generates their
whole shared k-space when the actual field images intersect in the
same constants. Separability, source dimension and characteristic
are unnecessary: only the two endpoint universal modules have rank one. -/
theorem actual_shared_form_is_constant_multiple
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (omega0 omega : KaehlerDifferential k E)
    (h0 : omega0 ∈ sharedRationalDifferentialSubspace k F G E)
    (h0ne : omega0 ≠ 0)
    (hw : omega ∈ sharedRationalDifferentialSubspace k F G E) :
    ∃ c : k, omega = c • omega0 := by
  obtain ⟨alpha0, hF0⟩ := h0.1
  obtain ⟨beta0, hG0⟩ := h0.2
  obtain ⟨alpha, hF⟩ := hw.1
  obtain ⟨beta, hG⟩ := hw.2
  change KaehlerDifferential.map k k F E alpha0 = omega0 at hF0
  change KaehlerDifferential.map k k G E beta0 = omega0 at hG0
  change KaehlerDifferential.map k k F E alpha = omega at hF
  change KaehlerDifferential.map k k G E beta = omega at hG
  have hF0ne : eF alpha0 ≠ 0 := by
    intro hz
    have ha : alpha0 = 0 := eF.injective (hz.trans (map_zero eF).symm)
    apply h0ne
    rw [← hF0, ha, map_zero]
  have hG0ne : eG beta0 ≠ 0 := by
    intro hz
    have hb : beta0 = 0 := eG.injective (hz.trans (map_zero eG).symm)
    apply h0ne
    rw [← hG0, hb, map_zero]
  let aF : F := eF alpha / eF alpha0
  let aG : G := eG beta / eG beta0
  have ha : alpha = aF • alpha0 := by
    apply eF.injective
    simp [aF, hF0ne, smul_eq_mul]
  have hb : beta = aG • beta0 := by
    apply eG.injective
    simp [aG, hG0ne, smul_eq_mul]
  have hwa : omega = algebraMap F E aF • omega0 := by
    rw [← hF, ha, map_smul, hF0, IsScalarTower.algebraMap_smul]
  have hwb : omega = algebraMap G E aG • omega0 := by
    rw [← hG, hb, map_smul, hG0, IsScalarTower.algebraMap_smul]
  have heq : algebraMap F E aF = algebraMap G E aG := by
    have hz : (algebraMap F E aF - algebraMap G E aG) • omega0 = 0 := by
      rw [sub_smul, ← hwa, ← hwb, sub_self]
    exact sub_eq_zero.mp ((smul_eq_zero.mp hz).resolve_right h0ne)
  obtain ⟨c, hcF, _⟩ := hinter aF aG heq
  refine ⟨c, ?_⟩
  rw [hwa, ← hcF, ← IsScalarTower.algebraMap_apply k F E,
    IsScalarTower.algebraMap_smul]

/-- Literal shared differential space is the k-span of any actual
nonzero shared form, without any geometric shared-rank premise. -/
theorem actual_shared_differential_subspace_eq_span
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eG : KaehlerDifferential k G ≃ₗ[G] G)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (omega0 : KaehlerDifferential k E)
    (h0 : omega0 ∈ sharedRationalDifferentialSubspace k F G E)
    (h0ne : omega0 ≠ 0) :
    sharedRationalDifferentialSubspace k F G E = Submodule.span k {omega0} := by
  apply le_antisymm
  · intro omega hw
    obtain ⟨c, hc⟩ := actual_shared_form_is_constant_multiple eF eG hinter
      omega0 omega h0 h0ne hw
    rw [hc]
    exact Submodule.smul_mem _ _ (Submodule.subset_span (Set.mem_singleton omega0))
  · exact Submodule.span_le.mpr (by simpa only [Set.singleton_subset_iff] using h0)

end Litt3.CartierAndSpin
