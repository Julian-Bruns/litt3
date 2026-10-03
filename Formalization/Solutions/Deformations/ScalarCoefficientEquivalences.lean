import Solutions.Deformations.LinearEndomorphismRanges
import Definitions.Deformations.FiniteCoefficientReduction

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

/-- The actual coefficient automorphism on the actual scalar quotient. -/
noncomputable def scalarCoefficientEquiv (r : R) (Phi : K ≃ₗ[R] K) :
    (K ⧸ coefficientScalarRange (K := K) r) ≃ₗ[R] (K ⧸ coefficientScalarRange (K := K) r) :=
  Submodule.Quotient.equiv _ _ Phi
    ((linear_equiv_map_range_conjugate Phi (r • (LinearMap.id : Module.End R K))).trans
      (congrArg LinearMap.range (by rw [map_smul, LinearEquiv.conj_id])))

theorem scalar_coefficient_equiv_mk (r : R) (Phi : K ≃ₗ[R] K) (v : K) :
    scalarCoefficientEquiv r Phi ((coefficientScalarRange (K := K) r).mkQ v) =
      (coefficientScalarRange (K := K) r).mkQ (Phi v) := rfl

/-- Literal coefficientwise equivalence on the entire finite coefficient module. -/
def finiteCoefficientEquiv (q : ℕ) (Phi : K ≃ₗ[R] K) : (Fin q → K) ≃ₗ[R] (Fin q → K) where
  toFun v j := Phi (v j)
  invFun v j := Phi.symm (v j)
  left_inv v := funext (fun j => Phi.symm_apply_apply (v j))
  right_inv v := funext (fun j => Phi.apply_symm_apply (v j))
  map_add' v w := funext (fun j => Phi.map_add (v j) (w j))
  map_smul' r v := funext (fun j => Phi.map_smul r (v j))

theorem finite_coefficient_equiv_socle (q : ℕ) (Phi : K ≃ₗ[R] K) (eta : K) :
    finiteCoefficientEquiv q Phi (finiteSocleCoefficient (R := R) q eta) =
      finiteSocleCoefficient (R := R) q (Phi eta) := by
  funext j
  change Phi (if j.val + 1 = q then eta else 0) = if j.val + 1 = q then Phi eta else 0
  by_cases last : j.val + 1 = q <;> simp [last]

theorem finite_coefficient_equiv_socle_iff (q : ℕ) (Phi : K ≃ₗ[R] K) (v : Fin q → K) :
    (∃ eta, finiteCoefficientEquiv q Phi v = finiteSocleCoefficient (R := R) q eta) ↔
      ∃ eta, v = finiteSocleCoefficient (R := R) q eta := by
  constructor
  · rintro ⟨eta, same⟩
    refine ⟨Phi.symm eta, (finiteCoefficientEquiv q Phi).injective ?_⟩
    rw [same, finite_coefficient_equiv_socle, LinearEquiv.apply_symm_apply]
  · rintro ⟨eta, rfl⟩
    exact ⟨Phi eta, finite_coefficient_equiv_socle q Phi eta⟩

end Litt3.Deformations
