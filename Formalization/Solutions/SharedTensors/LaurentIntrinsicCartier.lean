import Solutions.SharedTensors.LaurentKaehlerCoordinate
import Solutions.SharedTensors.LaurentCartierCoefficients
import Solutions.SharedTensors.RationalCartierLogarithmic

namespace Litt3.SharedTensors

open scoped LaurentSeries

variable {k : Type*} [Field k] [PerfectField k]
  {p : ℕ} [Fact p.Prime] [CharP k p]

noncomputable local instance : Module k (LaurentSeries k) := Algebra.toModule

/-- The classical Laurent coefficient formula is proved for every
intrinsic Cartier operator on the full actual differential module. -/
theorem intrinsic_cartier_laurent_coefficient
    (C : RationalCartierOperator k (LaurentSeries k) p)
    (e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k)
    (he : e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1)
    (omega : KaehlerDifferential k (LaurentSeries k)) (n : ℤ) :
    (e (C.toAddHom omega)).coeff n =
      (frobeniusEquiv k p).symm
        ((e omega).coeff ((p : ℤ) * n + (p - 1 : ℕ))) := by
  obtain ⟨b, hb⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  have hbn : e (KaehlerDifferential.D k (LaurentSeries k) b.parameter) = 1 := by
    rwa [hb]
  rw [C.coordinate_formula b e hbn]
  exact laurent_rational_cartier_coefficient b hb _ n

/-- The normalized algebraic differential coordinate and its intrinsic
Cartier operator are both constructed on the whole Laurent field. -/
theorem laurent_intrinsic_cartier_exists :
    ∃ (e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k)
      (C : RationalCartierOperator k (LaurentSeries k) p),
      (∀ f, e (KaehlerDifferential.D k (LaurentSeries k) f) =
        Litt3.CartierAndSpin.laurentDerivation k f) ∧
      (∀ omega n, (e (C.toAddHom omega)).coeff n =
        (frobeniusEquiv k p).symm
          ((e omega).coeff ((p : ℤ) * n + (p - 1 : ℕ)))) := by
  obtain ⟨e, heD, he⟩ := laurent_kaehler_coordinate_exists (k := k) (p := p)
  obtain ⟨b, hb⟩ := laurent_power_p_basis_exists (k := k) (p := p)
  have hbn : e (KaehlerDifferential.D k (LaurentSeries k) b.parameter) = 1 := by
    rwa [hb]
  let C := intrinsicRationalCartier b e hbn
  exact ⟨e, C, heD, intrinsic_cartier_laurent_coefficient C e he⟩

/-- Cartier takes the p-th root of the actual residue. -/
theorem intrinsic_cartier_laurent_residue
    (C : RationalCartierOperator k (LaurentSeries k) p)
    (e : KaehlerDifferential k (LaurentSeries k) ≃ₗ[LaurentSeries k] LaurentSeries k)
    (he : e (KaehlerDifferential.D k (LaurentSeries k) (laurentParameter k)) = 1)
    (omega : KaehlerDifferential k (LaurentSeries k)) :
    (e (C.toAddHom omega)).coeff (-1) =
      (frobeniusEquiv k p).symm ((e omega).coeff (-1)) := by
  rw [intrinsic_cartier_laurent_coefficient C e he]
  have hp : 1 ≤ p := (Fact.out : p.Prime).pos
  have hindex : (p : ℤ) * (-1) + ((p - 1 : ℕ) : ℤ) = -1 := by
    rw [Int.natCast_sub hp]
    ring
  rw [hindex]

end Litt3.SharedTensors
