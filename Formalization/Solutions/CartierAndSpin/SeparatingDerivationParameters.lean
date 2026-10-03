import Solutions.CartierAndSpin.FiniteFrobeniusSeparability
import Solutions.CartierAndSpin.FiniteFunctionDegree
import Solutions.SharedTensors.PBasisChangeParameter
import Solutions.SharedTensors.SeparatingPBasisExistence
import Solutions.SharedTensors.AffineMinimalPolynomials

namespace Litt3.CartierAndSpin

open Polynomial Module Submodule
open Litt3.SharedTensors

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- Every actual base derivation kills every separable algebraic element. -/
theorem derivation_zero_of_separable (D : Derivation k L L) (x : L)
    (hx : IsSeparable k x) : D x = 0 := by
  let P := minpoly k x
  have hroot : aeval x P = 0 := minpoly.aeval k x
  have hdenom : aeval x P.derivative ≠ 0 := hx.aeval_derivative_ne_zero hroot
  have hpoly : coefficientDifferential (0 : Derivation k k k).toLinearMap P = 0 := by
    ext i
    rw [coefficient_differential_coeff]
    rfl
  have h := derivation_polynomial_aeval (0 : Derivation k k k) D
    (by intro c; simp only [Derivation.zero_apply, map_zero, D.map_algebraMap]) x P
  rw [hroot, map_zero, hpoly, map_zero, zero_add] at h
  exact (mul_eq_zero.mp h.symm).resolve_left hdenom

/-- Over perfect constants, a nonzero derivative forces genuine
transcendence, even without algebraically closed constants. -/
theorem transcendental_of_derivation_ne_zero [PerfectField k]
    (D : Derivation k L L) (x : L) (hx : D x ≠ 0) : Transcendental k x := by
  intro halgebraic
  let E := IntermediateField.adjoin k {x}
  letI := IntermediateField.isAlgebraic_adjoin_simple halgebraic.isIntegral
  have hmem : x ∈ E := IntermediateField.subset_adjoin k {x} (Set.mem_singleton x)
  have hsep : IsSeparable k x :=
    IsSeparable.map (E.toSubalgebra.val : E →ₐ[k] L) Subtype.val_injective
      (Algebra.IsSeparable.isSeparable k (⟨x, hmem⟩ : E))
  exact hx (derivation_zero_of_separable D x hsep)

variable {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- If the actual p-basis parameter lies in the actual differential base,
the actual p-th powers span the field over that base. -/
theorem p_basis_parameter_in_base_frobenius_span_top
    {F : Type*} [Field F] [Algebra F L] (b : PowerPBasis L p)
    (t : F) (ht : algebraMap F L t = b.parameter) :
    Submodule.span F (Set.range (fun x : L => x ^ p)) = ⊤ := by
  apply Submodule.eq_top_iff'.mpr
  intro a
  rw [← p_basis_actual_expansion b a]
  apply Submodule.sum_mem
  intro i _
  have hcoeff : pRootCoefficient L p b a i ^ p ∈
      Submodule.span F (Set.range (fun x : L => x ^ p)) :=
    Submodule.subset_span ⟨pRootCoefficient L p b a i, rfl⟩
  have h := Submodule.smul_mem (Submodule.span F (Set.range (fun x : L => x ^ p)))
    (t ^ i.val) hcoeff
  simpa only [Algebra.smul_def, map_pow, ht, mul_comm] using h

/-- The converse separating-parameter criterion in an actual one-variable
function field. Finite degree, a full p-basis at x, Frobenius spanning and
separability are all conclusions. -/
theorem one_variable_separable_of_derivation_ne_zero
    (p : ℕ) [Fact p.Prime] [CharP k p] [CharP L p] [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1) (D : Derivation k L L)
    (x : L) (hx : D x ≠ 0) :
    FiniteDimensional (IntermediateField.adjoin k {x}) L ∧
      Algebra.IsSeparable (IntermediateField.adjoin k {x}) L := by
  have htrans := transcendental_of_derivation_ne_zero D x hx
  let F := IntermediateField.adjoin k {x}
  letI : FiniteDimensional F L := one_variable_finite_function_degree hfg htrdeg x htrans
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  have hnot : x ∉ frobeniusSubfield L p := by
    rintro ⟨r, hr⟩
    apply hx
    change r ^ p = x at hr
    rw [← hr, D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  obtain ⟨b', hb'⟩ := power_p_basis_change_parameter_exists b x hnot
  let t : F := ⟨x, IntermediateField.subset_adjoin k {x} (Set.mem_singleton x)⟩
  have hspan := p_basis_parameter_in_base_frobenius_span_top b' t hb'.symm
  exact ⟨inferInstance, finite_separable_of_frobenius_span_top hspan⟩

end Litt3.CartierAndSpin
