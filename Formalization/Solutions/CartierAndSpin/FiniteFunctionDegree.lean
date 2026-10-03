import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.RingTheory.AlgebraicIndependent.TranscendenceBasis
import Mathlib.RingTheory.AlgebraicIndependent.Transcendental

namespace Litt3.CartierAndSpin

open IntermediateField

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- A finitely generated algebraic field extension is genuinely finite.
This is proved from its actual finite generator family and integrality. -/
theorem finite_dimensional_of_field_fg_algebraic
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    [Algebra.IsAlgebraic k L] : FiniteDimensional k L := by
  obtain ⟨s, hs⟩ := hfg
  letI : FiniteDimensional k (IntermediateField.adjoin k (s : Set L)) :=
    IntermediateField.finiteDimensional_adjoin (fun x _ =>
      (Algebra.IsAlgebraic.isAlgebraic x).isIntegral)
  haveI : FiniteDimensional k (⊤ : IntermediateField k L) := by
    rw [← hs]
    infer_instance
  exact IntermediateField.topEquiv.toLinearEquiv.finiteDimensional

/-- Every actual transcendental function in a finitely generated field
of transcendence degree one has finite actual function degree. No
separability, perfectness or finiteness over constants is required. -/
theorem one_variable_finite_function_degree
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (r : L) (hr : Transcendental k r) :
    FiniteDimensional (IntermediateField.adjoin k {r}) L := by
  let x : Unit → L := fun _ => r
  have hind : AlgebraicIndependent k x :=
    algebraicIndependent_unique_type_iff.mpr hr
  have hbasis : IsTranscendenceBasis k x :=
    hind.isTranscendenceBasis_of_lift_trdeg_le_of_finite (by
      simp only [htrdeg, Cardinal.lift_one, Cardinal.mk_fintype,
        Fintype.card_unique, Nat.cast_one]
      exact le_rfl)
  have hrange : Set.range x = {r} := by ext a; simp [x]
  haveI : Algebra.IsAlgebraic (IntermediateField.adjoin k {r}) L := by
    rw [← hrange]
    exact hbasis.isAlgebraic_field
  have hfg' : IntermediateField.FG
      (F := IntermediateField.adjoin k {r}) (E := L) ⊤ := by
    apply IntermediateField.FG.of_restrictScalars (K := k)
    simpa only [IntermediateField.restrictScalars_top] using hfg
  exact finite_dimensional_of_field_fg_algebraic hfg'

end Litt3.CartierAndSpin
