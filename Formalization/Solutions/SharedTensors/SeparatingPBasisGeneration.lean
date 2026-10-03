import Solutions.SharedTensors.PBasisPerfectConstants
import Mathlib.FieldTheory.PurelyInseparable.PerfectClosure
import Mathlib.Algebra.CharP.IntermediateField

namespace Litt3.SharedTensors

open IntermediateField

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectRing k p]

/-- The literal p-th-power subfield as an actual intermediate field over
the perfect constants. -/
def frobeniusConstantField : IntermediateField k K :=
  { frobeniusSubfield K p with
    algebraMap_mem' := fun c => by
      obtain ⟨r, hr⟩ := perfect_base_constant_is_pth_power (K := K) (p := p) c
      exact ⟨r, hr⟩ }

/-- An actual separating function, together with the actual p-th powers,
generates the whole field. This follows from separability of the literal
function subfield, not from a presumed p-basis decomposition. -/
theorem separating_function_and_pth_powers_generate
    (t : K) [Algebra.IsSeparable (IntermediateField.adjoin k {t}) K] :
    IntermediateField.adjoin k {t} ⊔ frobeniusConstantField (k := k) (K := K) (p := p) = ⊤ := by
  let F := IntermediateField.adjoin k {t}
  have hwhole : IntermediateField.adjoin F (Set.univ : Set K) = ⊤ := by
    apply top_unique
    exact IntermediateField.subset_adjoin F Set.univ
  have hpth := IntermediateField.adjoin_eq_adjoin_pow_expChar_of_isSeparable'
    F K (Set.univ : Set K) p
  have himage : ((fun a : K => a ^ p) '' Set.univ) =
      (frobeniusConstantField (k := k) (K := K) (p := p) : Set K) := by
    ext a
    change (∃ r, r ∈ Set.univ ∧ r ^ p = a) ↔ ∃ r, r ^ p = a
    simp
  rw [himage, hwhole] at hpth
  have hreduced := congrArg (IntermediateField.restrictScalars k) hpth
  rw [IntermediateField.restrictScalars_top,
    IntermediateField.restrictScalars_adjoin_eq_sup,
    IntermediateField.adjoin_self] at hreduced
  exact hreduced.symm

end Litt3.SharedTensors
