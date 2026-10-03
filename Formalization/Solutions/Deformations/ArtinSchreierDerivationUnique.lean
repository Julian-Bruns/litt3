import Solutions.Deformations.ArtinSchreierDerivationExistence

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Differentiating the actual original defining relation gives its
literal Jacobian equation for any integral derivation extending D. -/
theorem artin_schreier_derivation_linearized (p r : ℕ) (a b : Fin r → R)
    (D : Derivation ℤ R R)
    (E : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b))
    (extension : ∀ c, E (algebraMap R _ c) = algebraMap R _ (D c)) (i : Fin r) :
    ((p : artinSchreierChart R p r a b) *
        artinSchreierChartCoordinate R p r a b i ^ (p - 1) - algebraMap R _ (a i)) *
      E (artinSchreierChartCoordinate R p r a b i) =
        algebraMap R _ (D (a i)) * artinSchreierChartCoordinate R p r a b i +
          algebraMap R _ (D (b i)) := by
  have relation := artin_schreier_chart_relation p r a b i
  simp only [Algebra.smul_def, mul_one] at relation
  have differentiated := congrArg E relation
  simp only [Derivation.leibniz_pow, nsmul_eq_mul, smul_eq_mul, map_add,
    Derivation.leibniz, extension] at differentiated
  linear_combination differentiated

/-- Original coefficient values and coordinate values determine an
integral derivation on the literal whole chart. -/
theorem artin_schreier_derivation_ext (p : ℕ) (large : 1 < p) (r : ℕ)
    (a b : Fin r → R)
    (E F : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b))
    (coefficients : ∀ c, E (algebraMap R _ c) = F (algebraMap R _ c))
    (coordinates : ∀ i, E (artinSchreierChartCoordinate R p r a b i) =
      F (artinSchreierChartCoordinate R p r a b i)) : E = F := by
  have graphs : derivationGraphAlong E (RingHom.id _) =
      derivationGraphAlong F (RingHom.id _) := by
    apply artin_schreier_chart_ringHom_ext p large r a b
    · intro c
      ext
      · rfl
      · exact coefficients c
    · intro i
      ext
      · rfl
      · exact coordinates i
  apply Derivation.ext
  intro x
  exact congrArg TrivSqZeroExt.snd (DFunLike.congr_fun graphs x)

/-- Invertibility of each actual original Jacobian forces uniqueness
of the actual base derivation extension on the full chart. -/
theorem artin_schreier_derivation_unique (p : ℕ) (large : 1 < p) (r : ℕ)
    (a b : Fin r → R) (D : Derivation ℤ R R)
    (inverse : Fin r → artinSchreierChart R p r a b)
    (identities : ∀ i,
      ((p : artinSchreierChart R p r a b) *
          artinSchreierChartCoordinate R p r a b i ^ (p - 1) - algebraMap R _ (a i)) *
        inverse i = 1)
    (E F : Derivation ℤ (artinSchreierChart R p r a b) (artinSchreierChart R p r a b))
    (extensionE : ∀ c, E (algebraMap R _ c) = algebraMap R _ (D c))
    (extensionF : ∀ c, F (algebraMap R _ c) = algebraMap R _ (D c)) : E = F := by
  apply artin_schreier_derivation_ext p large r a b E F
  · intro c
    rw [extensionE, extensionF]
  · intro i
    have equationE := artin_schreier_derivation_linearized p r a b D E extensionE i
    have equationF := artin_schreier_derivation_linearized p r a b D F extensionF i
    linear_combination inverse i * equationE - inverse i * equationF -
      (E (artinSchreierChartCoordinate R p r a b i) -
        F (artinSchreierChartCoordinate R p r a b i)) * identities i

end Litt3.Deformations
