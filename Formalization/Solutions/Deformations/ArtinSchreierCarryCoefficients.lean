import Solutions.Deformations.ArtinSchreierCarryClosed
import Solutions.Deformations.SignedBasisPowers

namespace Litt3.Deformations

open scoped BigOperators ArtinSchreierAdic

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Literal original normal monomial carries equal the signed power
filtration of the actual unchanged free normal basis. -/
theorem artin_schreier_normal_eq_basis (p : ℕ) (large : 1 < p) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) :
    normalSignedFiltration R p (p : artinSchreierChart R p r a b) (p - 1)
      (artinSchreierChartCoordinate R p r a b) d =
    signedBasisPowerFiltration (artinSchreierChartBasis p large r a b) (p : R) (p - 1)
      (fun alpha => ∑ i, (alpha i).val) d := by
  classical
  apply congrArg (Submodule.span R)
  ext x
  constructor
  · rintro ⟨j, alpha, normal, bound, rfl⟩
    let beta : Fin r → Fin p := fun i => ⟨alpha i, normal i⟩
    refine ⟨j, beta, bound, ?_⟩
    simp only [Algebra.smul_def, artin_schreier_chart_basis_apply, map_pow, map_natCast]
    rfl
  · rintro ⟨j, alpha, bound, rfl⟩
    refine ⟨j, (fun i => (alpha i).val), (fun i => (alpha i).isLt), bound, ?_⟩
    simp only [Algebra.smul_def, artin_schreier_chart_basis_apply, map_pow, map_natCast]
    rfl

/-- Exact coefficient-ideal characterization in the unchanged original
normal basis, valid for negative degrees and arbitrary p-torsion. -/
theorem artin_schreier_carry_coefficient_iff (p : ℕ) (prime : p.Prime) (r : ℕ)
    (a b : Fin r → R) (d : ℤ) (x : artinSchreierChart R p r a b) :
    x ∈ artinSchreierCarry R p r a b d ↔
      ∀ alpha : Fin r → Fin p,
        (p : R) ^ signedBasisWeightExponent (p - 1) d (∑ i, (alpha i).val) ∣
          (artinSchreierChartBasis p prime.one_lt r a b).repr x alpha := by
  rw [artin_schreier_carry_eq_normal p prime r a b d,
    artin_schreier_normal_eq_basis p prime.one_lt r a b d]
  exact signed_basis_power_mem_iff _ _ _ (by have := prime.one_lt; omega) _ _ _

end Litt3.Deformations
