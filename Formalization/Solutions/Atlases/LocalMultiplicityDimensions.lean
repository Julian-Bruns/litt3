import Mathlib.RingTheory.Length
import Mathlib.RingTheory.LocalRing.ResidueField.Basic
import Mathlib.RingTheory.SimpleModule.Basic
import Mathlib.LinearAlgebra.Dimension.RankNullity
import Mathlib.RingTheory.Artinian.Module
import Mathlib.Tactic

namespace Litt3.Atlases

universe u v w

variable {k : Type u} {C : Type v} [Field k] [CommRing C] [IsLocalRing C]
  [Algebra k C]

/-- Every actual simple module over a commutative local ring has the
base-field dimension of its actual residue field. -/
theorem simple_local_module_residue_dimension (M : Type w)
    [AddCommGroup M] [Module C M] [Module k M] [IsScalarTower k C M]
    [IsSimpleModule C M] :
    Module.finrank k M = Module.finrank k (IsLocalRing.ResidueField C) := by
  obtain ⟨I, hI, ⟨e⟩⟩ := isSimpleModule_iff_quot_maximal.mp
    (inferInstance : IsSimpleModule C M)
  have hIeq := IsLocalRing.eq_maximalIdeal hI
  subst I
  exact (e.restrictScalars k).finrank_eq

/-- An actual local finite module has base-field dimension equal to
residue degree times its actual module length. The proof uses real
simple quotients, not supplied local multiplicities. -/
theorem finiteLength_local_module_dimension (M : Type w)
    [AddCommGroup M] [Module C M] (hl : IsFiniteLength C M) :
    ∀ [Module k M] [IsScalarTower k C M] [FiniteDimensional k M],
      (Module.finrank k M : ℕ∞) =
        (Module.finrank k (IsLocalRing.ResidueField C) : ℕ∞) * Module.length C M := by
  induction hl with
  | of_subsingleton =>
      intro _ _ _
      simp only [Module.finrank_zero_of_subsingleton, Nat.cast_zero,
        Module.length_eq_zero, mul_zero]
  | @of_simple_quotient M _ _ N _ _ ih =>
      intro _ _ _
      letI : FiniteDimensional k N :=
        Module.Finite.of_injective (N.subtype.restrictScalars k) N.injective_subtype
      have hn := ih
      have hq := simple_local_module_residue_dimension (k := k) (C := C) (M ⧸ N)
      have hdim := (N.restrictScalars k).finrank_quotient_add_finrank
      rw [(Submodule.Quotient.restrictScalarsEquiv k N).finrank_eq,
        ((N.restrictScalarsEquiv k).restrictScalars k).finrank_eq] at hdim
      have hlen := Module.length_eq_add_of_exact N.subtype N.mkQ
        N.injective_subtype N.mkQ_surjective (LinearMap.exact_subtype_mkQ N)
      rw [Module.length_eq_one (R := C) (M := M ⧸ N)] at hlen
      rw [← hdim, Nat.cast_add, hq, hn, hlen]
      ring

variable [FiniteDimensional k C]

/-- The actual local algebra multiplicity is recovered exactly from
its dimension and residue degree, in arbitrary characteristic. -/
theorem finite_local_algebra_dimension_length :
    (Module.finrank k C : ℕ∞) =
      (Module.finrank k (IsLocalRing.ResidueField C) : ℕ∞) * Module.length C C := by
  have hN : IsNoetherian C C := isNoetherian_of_tower k inferInstance
  have hA : IsArtinian C C := isArtinian_of_tower k inferInstance
  exact finiteLength_local_module_dimension C
    (isFiniteLength_iff_isNoetherian_isArtinian.mpr ⟨hN, hA⟩)

end Litt3.Atlases
