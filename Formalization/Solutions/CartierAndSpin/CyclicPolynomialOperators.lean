import Mathlib.Algebra.Module.PID
import Mathlib.LinearAlgebra.AnnihilatingPolynomial
import Mathlib.LinearAlgebra.Charpoly.Basic
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.CartierAndSpin

open Polynomial Module Submodule LinearMap

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
  [Module.Finite K V]

/-- Over ANY field, a genuine finite-dimensional endomorphism admits
an original vector whose first minpoly-degree iterates are independent.
The vector is constructed from the ACTUAL polynomial-module annihilator
over the PID K[X], not from a presumed Jordan or cyclic normal form. -/
theorem actual_endomorphism_exists_independent_minpoly_powers
    (T : Module.End K V) :
    ∃ v : V, LinearIndependent K
      (fun i : Fin (minpoly K T).natDegree => (T ^ (i : ℕ)) v) := by
  obtain ⟨x, hx⟩ := exists_ker_toSpanSingleton_eq_annihilator K[X] (AEval' T)
  obtain ⟨v, rfl⟩ := (AEval'.of T).surjective x
  use v
  rw [← span_minpoly_eq_annihilator, eq_comm] at hx
  convert (AdjoinRoot.powerBasis (minpoly.ne_zero (LinearMap.isIntegral T))).basis.linearIndependent
    |>.map' ((AEval'.of T).symm.toLinearMap ∘ₗ
      (liftQ _ _ hx.le).restrictScalars K) <| by
    exact congr($(ker_liftQ_eq_bot' _ _ hx).restrictScalars K)
  simp_rw [AdjoinRoot.powerBasis, AdjoinRoot.powerBasisAux, Basis.coe_mk,
    coe_comp, LinearEquiv.coe_coe, LinearMap.coe_restrictScalars]
  refine (LinearEquiv.eq_symm_apply _).mpr
    (.symm <| (liftQ_apply ..).trans ?_)
  rw [toSpanSingleton_apply, AEval'.X_pow_smul_of, End.smul_def, End.coe_pow]

/-- Equality of minpoly degree and actual ambient dimension turns that
constructed orbit into a genuine basis; no cyclic vector is supplied. -/
theorem actual_endomorphism_exists_cyclic_basis
    (T : Module.End K V)
    (hdegree : (minpoly K T).natDegree = Module.finrank K V) :
    ∃ v : V, ∃ b : Basis (Fin (minpoly K T).natDegree) K V,
      ∀ i, b i = (T ^ (i : ℕ)) v := by
  obtain ⟨v, hv⟩ := actual_endomorphism_exists_independent_minpoly_powers T
  have hcard : Fintype.card (Fin (minpoly K T).natDegree) = Module.finrank K V := by
    simpa only [Fintype.card_fin] using hdegree
  refine ⟨v, Basis.mk hv (hv.span_eq_top_of_card_eq_finrank' hcard).ge, ?_⟩
  intro i
  exact congrFun (Basis.coe_mk _ _) i

end Litt3.CartierAndSpin
