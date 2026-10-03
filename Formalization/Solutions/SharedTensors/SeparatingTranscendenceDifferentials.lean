import Mathlib.FieldTheory.SeparablyGenerated
import Mathlib.FieldTheory.IntermediateField.Adjoin.Algebra
import Mathlib.RingTheory.Etale.Kaehler
import Mathlib.RingTheory.Etale.Field
import Mathlib.RingTheory.Kaehler.Polynomial
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace Litt3.SharedTensors

open scoped TensorProduct IntermediateField.algebraAdjoinAdjoin

universe u

variable {k K : Type u} [Field k] [Field K] [Algebra k K]

/-- The full actual differential rank associated with any genuine
separating algebraically independent family. Both the polynomial ring
and fraction-field structure are constructed from the actual family. -/
theorem separating_family_actual_kaehler_rank {ι : Type u}
    (t : ι → K) (ht : AlgebraicIndependent k t)
    [Algebra.IsSeparable (IntermediateField.adjoin k (Set.range t)) K] :
    Module.rank K (KaehlerDifferential k K) = Cardinal.mk ι := by
  let P := MvPolynomial ι k
  let A := Algebra.adjoin k (Set.range t)
  let F := IntermediateField.adjoin k (Set.range t)
  let eA : P ≃ₐ[k] A := ht.aevalEquiv
  let f : P →ₐ[k] F := (IsScalarTower.toAlgHom k A F).comp eA.toAlgHom
  letI : Algebra P F := f.toRingHom.toAlgebra
  letI : IsScalarTower k P F :=
    IsScalarTower.of_algebraMap_eq (fun c => (f.commutes c).symm)
  letI : IsFractionRing P F :=
    (IsFractionRing.isFractionRing_iff_of_base_ringEquiv
      (S := F) eA.symm.toRingEquiv).mp inferInstance
  letI : Algebra.FormallyEtale P F :=
    Algebra.FormallyEtale.of_isLocalization (nonZeroDivisors P)
  let eF := KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k P F
  have hF : Module.rank F (KaehlerDifferential k F) = Cardinal.mk ι := by
    rw [← eF.rank_eq, Module.rank_baseChange,
      ← (KaehlerDifferential.mvPolynomialBasis k ι).mk_eq_rank'']
    simp
  letI : Algebra.FormallyEtale F K := Algebra.FormallyEtale.of_isSeparable F K
  let eK := KaehlerDifferential.tensorKaehlerEquivOfFormallyEtale k F K
  rw [← eK.rank_eq, Module.rank_baseChange, hF]
  simp

/-- Over perfect constants, the actual universal differential rank of
every finitely generated field extension equals its actual transcendence
degree. No rank, p-basis or separating-family hypothesis is supplied. -/
theorem actual_finitely_generated_kaehler_rank_eq_trdeg [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤) :
    Module.rank K (KaehlerDifferential k K) = Algebra.trdeg k K := by
  obtain ⟨s, hs, hsep⟩ :=
    exists_isTranscendenceBasis_and_isSeparable_of_perfectField hfg
  have hrange : Set.range ((↑) : s → K) = (↑s : Set K) := by
    ext x
    simp
  letI : Algebra.IsSeparable (IntermediateField.adjoin k
      (Set.range ((↑) : s → K))) K := by rw [hrange]; exact hsep
  exact (separating_family_actual_kaehler_rank ((↑) : s → K) hs.1).trans
    hs.cardinalMk_eq_trdeg

end Litt3.SharedTensors
