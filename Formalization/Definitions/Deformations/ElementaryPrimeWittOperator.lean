import Definitions.Deformations.ElementaryNormalWeights
import Definitions.Deformations.PolynomialCoefficientLift
import Definitions.Deformations.ElementaryWittOperatorLift
import Mathlib.RingTheory.WittVector.Teichmuller

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- Actual Teichmuller polynomial lift in unchanged original prime
generators, uniformly over primes and homogeneous principal degrees. -/
noncomputable def elementaryPrimeWittPolynomialLift (r : ℕ) (f : MvPolynomial (Fin r) k) :
    AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) :=
  polynomialCoefficientLift (fun c => WittVector.truncate N (WittVector.teichmuller p c))
    (elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r) f

/-- The literal additive correction relative to the original actual
coefficient Frobenius; no Witt linearity is imposed. -/
noncomputable def elementaryPrimeWittOperatorCorrection (r : ℕ)
    (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p))
    (lift : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :
    AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) :=
  L - (AddMonoidHom.mulLeft lift).comp (elementaryWittFrobenius p N r k).toAddMonoidHom

end Litt3.Deformations
