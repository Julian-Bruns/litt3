import Solutions.Deformations.PrimeWeightedPolynomialFunction
import Mathlib.FieldTheory.Perfect
import Mathlib.LinearAlgebra.Projectivization.Basic

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization

/-- Original projective detector with the actual inverse coefficient
Frobenius applied after the full signed sum. -/
noncomputable def elementaryPrimeCriticalTheta (p : ℕ) [Fact p.Prime]
    (k : Type*) [Field k] [CharP k p] [PerfectRing k p] (r : ℕ)
    [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] (q : MvPolynomial (Fin r) k)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r) (i : Fin r) : k :=
  (_root_.frobeniusEquiv k p).symm ((-1 : k) ^ (r + 1) *
    ∑ P : ℙ (ZMod p) (Fin r → ZMod p), ZMod.castHom (dvd_refl p) k (P.rep i) *
      primeWeightedPolynomialFunction p k (ZMod.castHom (dvd_refl p) k) r Z P.rep /
        q.eval (fun j => ZMod.castHom (dvd_refl p) k (P.rep j)))

end Litt3.Deformations
