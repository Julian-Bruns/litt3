import Solutions.Deformations.PrimeWeightedPolynomialFunction
import Solutions.Deformations.WeightedRootPolynomialEvaluation

namespace Litt3.Deformations

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

/-- The actual quotient polynomial and actual original direction
evaluation agree, including the unchanged coefficient-field inclusion. -/
theorem prime_weighted_polynomial_function_polynomial (ψ : ZMod p →+* k) (r : ℕ)
    (f : MvPolynomial (Fin r) k) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (weightedRootPolynomialEvaluation p Polynomial.X r
        (MvPolynomial.map Polynomial.C f)) a = f.eval (fun i => ψ (a i)) := by
  let χ : weightedRootProduct (Polynomial k) p Polynomial.X r →+* k :=
    (Pi.evalRingHom (fun _ : Fin r → ZMod p => k) a).comp
      (primeWeightedPolynomialFunction p k ψ r)
  change χ (MvPolynomial.eval₂Hom _ _ (MvPolynomial.map Polynomial.C f)) = _
  rw [MvPolynomial.map_eval₂Hom, MvPolynomial.eval₂Hom_map_hom]
  change MvPolynomial.eval₂Hom _ _ f = MvPolynomial.eval₂Hom (RingHom.id k)
    (fun i => ψ (a i)) f
  apply congrArg (fun phi : MvPolynomial (Fin r) k →+* k => phi f)
  apply congrArg₂ MvPolynomial.eval₂Hom
  · ext b
    change primeWeightedPolynomialFunction p k ψ r
      (algebraMap (Polynomial k) _ (Polynomial.C b)) a = b
    rw [prime_weighted_polynomial_function_coefficient, Polynomial.eval_C]
  · funext i
    exact prime_weighted_polynomial_function_parameter p k ψ r i a

end Litt3.Deformations
