import Theorems.Deformations.LeftPrincipalWidth
import Solutions.Deformations.MatrixMaximumWidth

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

theorem right_multiplication_range_left_span (f : A) :
    LinearMap.range (LinearMap.mulRight k f) = (Submodule.span A {f}).restrictScalars k := by
  ext x
  change x ∈ LinearMap.range (LinearMap.mulRight k f) ↔ x ∈ Submodule.span A {f}
  simp only [LinearMap.mem_range, Submodule.mem_span_singleton,
    LinearMap.mulRight_apply, smul_eq_mul]

/-- Actual coefficient cokernel and actual full left regular
one-relation quotient agree. A ring quotient is not assumed. -/
noncomputable def leftPrincipalCokernelEquiv (f : A) :
    EndomorphismCokernel (LinearMap.mulRight k f) ≃ₗ[k] LeftPrincipalQuotient f :=
  (Submodule.quotEquivOfEq _ _ (right_multiplication_range_left_span (k := k) f)).trans
    (Submodule.Quotient.restrictScalarsEquiv k (Submodule.span A {f}))

variable [FiniteDimensional k A]

/-- Every actual noncentral left relation of radical order nu
has dimension at least the actual attained nu-window maximum. -/
theorem left_principal_radical_maximum_width (lag : ℕ) (f : A)
    (order : f ∈ jacobsonRadicalFiltration (k := k) (A := A) lag) :
    Specifications.LeftPrincipalRadicalMaximumWidth (k := k) lag f := by
  let F := jacobsonRadicalFiltration (k := k) (A := A)
  let window := fun i => ∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))
  have lowers : ∀ i x, x ∈ F i → LinearMap.mulRight k f x ∈ F (i + lag) := by
    intro i x hx
    exact jacobson_radical_filtration_multiplicative i lag x f hx order
  have each := window_filtration_width (LinearMap.mulRight k f) F lag
    jacobson_radical_filtration_descending lowers
  have bounded : ∃ n, ∀ i, window i ≤ n :=
    ⟨Module.finrank k (EndomorphismCokernel (LinearMap.mulRight k f)), each⟩
  obtain ⟨upper, i, hi⟩ := bounded_natural_maximum_attained window bounded
  refine ⟨boundedNaturalMaximum window bounded, upper, ⟨i, hi⟩, ?_⟩
  have h := bounded_natural_maximum_le window bounded _ each
  rwa [(leftPrincipalCokernelEquiv (k := k) f).finrank_eq] at h

end Litt3.Deformations
