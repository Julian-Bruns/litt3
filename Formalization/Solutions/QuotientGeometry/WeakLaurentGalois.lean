import Solutions.QuotientGeometry.WeakLaurentArtinSchreierModel
import Solutions.QuotientGeometry.ArtinSchreierFieldTransport

namespace Litt3.QuotientGeometry

theorem weak_laurent_completed_extension_cyclic_galois
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (horder : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) := Ψ.toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) = p ∧
      IsGalois (LaurentSeries k) (LaurentSeries k) ∧
      IsCyclic (LaurentSeries k ≃ₐ[LaurentSeries k] LaurentSeries k) := by
  obtain ⟨a, ha, _, e, he⟩ :=
    weak_laurent_completed_map_artin_schreier_model p φ Ψ hΨ hzero horder hderiv
  exact pole_one_artin_schreier_field_model_cyclic_galois p a ha Ψ e he

end Litt3.QuotientGeometry
