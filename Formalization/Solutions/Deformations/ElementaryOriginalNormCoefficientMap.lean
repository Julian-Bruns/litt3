import Solutions.Deformations.ElementaryOriginalIntegralNorm

namespace Litt3.Deformations

variable (p : ℕ) [Fact p.Prime]
variable {R S : Type*} [CommRing R] [CommRing S] [Nontrivial R] [Nontrivial S]

/-- Every genuine coefficient ring map sends the literal original norm
to the literal norm on the same original abstract deck group. -/
theorem group_coefficient_original_scaled_norm (r : ℕ) (phi : R →+* S) (c : R) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) phi
      (c • elementaryOriginalNorm (R := R) p r) =
      phi c • elementaryOriginalNorm (R := S) p r := by
  classical
  ext g
  rw [AddMonoidAlgebra.mapRangeRingHom_apply]
  simp only [AddMonoidAlgebra.coeff_smul, smul_eq_mul, elementary_original_norm_coefficient,
    mul_one]

end Litt3.Deformations
