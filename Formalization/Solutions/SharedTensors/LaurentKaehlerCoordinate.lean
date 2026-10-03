import Solutions.SharedTensors.LaurentPBasisGeneration
import Solutions.SharedTensors.PBasisKaehler
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.SharedTensors

open scoped LaurentSeries

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

include p

/-- In positive characteristic over perfect coefficients, the full
algebraic differential module of k((t)) has the normalized Laurent
derivative as its coordinate. No assertion about characteristic zero
or a replacement by continuous differentials is made. -/
theorem laurent_kaehler_coordinate_exists :
    ∃ e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k,
      (∀ f, e (KaehlerDifferential.D k (LaurentSeries k) f) =
        Litt3.CartierAndSpin.laurentDerivation k f) ∧
      e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1 := by
  obtain ⟨b, hb⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  let D := Litt3.CartierAndSpin.laurentDerivation k
  have ht : D b.parameter = 1 := by rw [hb, laurent_derivation_parameter]
  obtain ⟨e, he⟩ := normalized_p_basis_kaehler_coordinate_exists b D ht
  refine ⟨e, ?_, ?_⟩
  · intro f
    have h1 := derivation_p_basis_module_expansion b (universalCoordinateDerivation e) f
    have h2 := derivation_p_basis_module_expansion b D f
    change e (KaehlerDifferential.D k (LaurentSeries k) f) =
      (∑ i : Fin p, pRootCoefficient (LaurentSeries k) p b f i ^ p *
        (i.val : LaurentSeries k) * b.parameter ^ (i.val - 1)) •
      e (KaehlerDifferential.D k (LaurentSeries k) b.parameter) at h1
    rw [he, smul_eq_mul, mul_one] at h1
    rw [ht, smul_eq_mul, mul_one] at h2
    exact h1.trans h2.symm
  · rwa [hb] at he

end Litt3.SharedTensors
