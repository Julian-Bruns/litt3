import Solutions.CartierAndSpin.SeparatingDerivationParameters
import Solutions.CartierAndSpin.GaussFieldRecovery

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [PerfectField k]

/-- Actual one-variable Gauss-field recovery without an assumed
intercept-separability hypothesis. The actual nonzero slope derivative
constructs a separating slope field. -/
theorem one_variable_gauss_field_recovers_coordinates
    (p : ℕ) [Fact p.Prime] [CharP k p] [CharP L p]
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (D : Derivation k L L) (u v : L)
    (hDu : D u = 1) (hsecond : D (D v) ≠ 0) :
    Specifications.GaussFieldRecoversCoordinates D u v := by
  obtain ⟨hfinite, hsep⟩ :=
    one_variable_separable_of_derivation_ne_zero p hfg htrdeg D (D v) hsecond
  letI := hsep
  exact gauss_field_recovers_coordinates D u v hDu hsecond
    (Algebra.IsSeparable.isSeparable _ _)

/-- If the original plane coordinates generate the actual field, the
classical Gauss field equals that field, including singular plane models. -/
theorem one_variable_gauss_field_eq_top
    (p : ℕ) [Fact p.Prime] [CharP k p] [CharP L p]
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (D : Derivation k L L) (u v : L)
    (hDu : D u = 1) (hsecond : D (D v) ≠ 0)
    (hgenerates : IntermediateField.adjoin k ({u, v} : Set L) = ⊤) :
    IntermediateField.adjoin k ({D v, v - u * D v} : Set L) = ⊤ := by
  obtain ⟨hfinite, hsep⟩ :=
    one_variable_separable_of_derivation_ne_zero p hfg htrdeg D (D v) hsecond
  letI := hsep
  exact gauss_field_eq_top D u v hDu hsecond
    (Algebra.IsSeparable.isSeparable _ _) hgenerates

end Litt3.CartierAndSpin
