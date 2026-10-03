import Solutions.Deformations.WeightedRootPolynomialFunctionEvaluation
import Solutions.Deformations.WeightedRootPolynomialEvaluation

namespace Litt3.Deformations

variable (F k : Type*) [Field F] [Fintype F] [DecidableEq F] [Field k]

/-- The actual quotient polynomial and actual original direction
evaluation agree, including the unchanged coefficient-field inclusion. -/
theorem weighted_root_polynomial_function_polynomial (ψ : F →+* k) (r : ℕ)
    (p : MvPolynomial (Fin r) k) (a : Fin r → F) :
    weightedRootPolynomialFunctionEvaluation F k ψ r
      (weightedRootPolynomialEvaluation (Fintype.card F) Polynomial.X r
        (MvPolynomial.map Polynomial.C p)) a = p.eval (fun i => ψ (a i)) := by
  let χ : weightedRootProduct (Polynomial k) (Fintype.card F) Polynomial.X r →+* k :=
    (Pi.evalRingHom (fun _ : Fin r → F => k) a).comp
      (weightedRootPolynomialFunctionEvaluation F k ψ r)
  change χ (MvPolynomial.eval₂Hom _ _ (MvPolynomial.map Polynomial.C p)) = _
  rw [MvPolynomial.map_eval₂Hom, MvPolynomial.eval₂Hom_map_hom]
  change MvPolynomial.eval₂Hom _ _ p = MvPolynomial.eval₂Hom (RingHom.id k)
    (fun i => ψ (a i)) p
  apply congrArg (fun f : MvPolynomial (Fin r) k →+* k => f p)
  apply congrArg₂ MvPolynomial.eval₂Hom
  · ext b
    change weightedRootPolynomialFunctionEvaluation F k ψ r
      (algebraMap (Polynomial k) _ (Polynomial.C b)) a = b
    rw [weighted_root_polynomial_function_coefficient, Polynomial.eval_C]
  · funext i
    exact weighted_root_polynomial_function_parameter F k ψ r i a

end Litt3.Deformations
