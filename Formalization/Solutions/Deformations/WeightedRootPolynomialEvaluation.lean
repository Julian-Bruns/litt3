import Solutions.Deformations.WeightedRootIntegralKernel
import Solutions.Deformations.HomogeneousPolynomialScaling

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [Nontrivial R] [Field K]

/-- The actual original-variable polynomial map into the literal
graded quotient. -/
noncomputable def weightedRootPolynomialEvaluation (q : ℕ) (tau : R) (r : ℕ) :
    MvPolynomial (Fin r) R →+* weightedRootProduct R q tau r :=
  MvPolynomial.eval₂Hom (algebraMap R (weightedRootProduct R q tau r))
    (weightedRootProductParameter R q tau r)

/-- Original-variable evaluation, actual coefficient extension and
actual scaled finite-field evaluation commute literally. -/
theorem weighted_root_polynomial_direction_evaluation
    (F : Type*) [Field F] [Fintype F] [DecidableEq F]
    (φ : R →+* K) (ψ : F →+* K) (tau : R) (c : K)
    (root : c ^ (Fintype.card F - 1) = -(φ tau)) (r : ℕ)
    (p : MvPolynomial (Fin r) R) (a : Fin r → F) :
    weightedRootEvaluationAtTau F K ψ (φ tau) c root r
      (weightedRootProductBaseMap φ (Fintype.card F) tau r
        (weightedRootPolynomialEvaluation (Fintype.card F) tau r p)) a =
      p.eval₂ φ (fun i => c * ψ (a i)) := by
  let evaluate : weightedRootProduct K (Fintype.card F) (φ tau) r →+* K :=
    (Pi.evalRingHom (fun _ : Fin r → F => K) a).comp
      (weightedRootEvaluationAtTau F K ψ (φ tau) c root r).toRingHom
  change evaluate (weightedRootProductBaseMap φ (Fintype.card F) tau r
    (MvPolynomial.eval₂Hom _ _ p)) = _
  rw [MvPolynomial.map_eval₂Hom, MvPolynomial.map_eval₂Hom]
  change MvPolynomial.eval₂Hom _ _ p = MvPolynomial.eval₂Hom φ (fun i => c * ψ (a i)) p
  apply congrArg (fun f : MvPolynomial (Fin r) R →+* K => f p)
  apply congrArg₂ MvPolynomial.eval₂Hom
  · ext b
    change weightedRootEvaluationAtTau F K ψ (φ tau) c root r
      (weightedRootProductBaseMap φ (Fintype.card F) tau r
        (algebraMap R (weightedRootProduct R (Fintype.card F) tau r) b)) a = φ b
    rw [weighted_root_base_map_coefficient, AlgHom.commutes]
    rfl
  · funext i
    change weightedRootEvaluationAtTau F K ψ (φ tau) c root r
      (weightedRootProductBaseMap φ (Fintype.card F) tau r
        (weightedRootProductParameter R (Fintype.card F) tau r i)) a = _
    rw [weighted_root_base_map_parameter, weighted_root_evaluation_at_tau_parameter]

end Litt3.Deformations
