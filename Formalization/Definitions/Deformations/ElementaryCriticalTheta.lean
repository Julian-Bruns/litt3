import Solutions.Deformations.ElementaryActualCriticalObstruction

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization

/-- The literal original projective detector, including its exact
source sign and inverse coefficient Frobenius after the entire sum. -/
noncomputable def elementaryCriticalTheta (k : Type*) [Field k] [Fact (Nat.Prime 5)]
    [CharP k 5] [PerfectRing k 5] (r : ℕ)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))]
    (q : MvPolynomial (Fin r) k)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r) (i : Fin r) : k :=
  (_root_.frobeniusEquiv k 5).symm ((-1 : k) ^ (r + 1) *
    ∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ZMod.castHom (dvd_refl 5) k (P.rep i) *
      weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) r Z P.rep /
        q.eval (fun j => ZMod.castHom (dvd_refl 5) k (P.rep j)))

end Litt3.Deformations
