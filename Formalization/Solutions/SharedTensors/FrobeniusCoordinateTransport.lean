import Solutions.SharedTensors.FrobeniusCoordinates

namespace Litt3.SharedTensors

variable {K L : Type*} [Field K] [Field L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Full unique p-basis coefficients commute with a literal field
inclusion when its actual parameter is used on both sides. -/
theorem pRootCoefficient_map (f : K →+* L)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = f bK.parameter) (a : K) (i : Fin p) :
    pRootCoefficient L p bL (f a) i = f (pRootCoefficient K p bK a i) := by
  have hexp : ∑ j : Fin p,
      f (pRootCoefficient K p bK a j) ^ p * bL.parameter ^ j.val = f a := by
    simpa only [map_sum, map_mul, map_pow, hparameter]
      using congrArg f (p_basis_actual_expansion bK a)
  exact (p_basis_actual_expansion_unique bL (f a) _ hexp i).symm

/-- Rational Cartier coordinate extraction commutes with the full field
inclusion, not merely with polynomial inputs or a bounded jet. -/
theorem rationalCartierCoefficient_map (f : K →+* L)
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = f bK.parameter) (a : K) :
    rationalCartierCoefficient L p bL (f a) =
      f (rationalCartierCoefficient K p bK a) :=
  pRootCoefficient_map f bK bL hparameter a _

/-- A literal field automorphism has the same full-coefficient transport
law. No finiteness or normal closure is required. -/
theorem rationalCartierCoefficient_automorphism
    (sigma : K ≃+* K) (b : PowerPBasis K p) (b' : PowerPBasis K p)
    (hparameter : b'.parameter = sigma b.parameter) (a : K) :
    rationalCartierCoefficient K p b' (sigma a) =
      sigma (rationalCartierCoefficient K p b a) :=
  rationalCartierCoefficient_map sigma.toRingHom b b' hparameter a

end Litt3.SharedTensors
