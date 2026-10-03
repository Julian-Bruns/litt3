import Definitions.QuotientGeometry.WeakLaurentInvariant
import Solutions.QuotientGeometry.WeakLaurentMapNormalization
import Solutions.QuotientGeometry.LinearizedArtinSchreierModel

namespace Litt3.QuotientGeometry

/-- The supplied completed-field embedding itself is a pole-one
Artin–Schreier extension, and the class is read directly from its
original negative coefficients. -/
theorem weak_laurent_completed_map_artin_schreier_model
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (horder : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2) :
    ∃ a : k, a ≠ 0 ∧ a ^ (p - 1) = weakLaurentInvariant p Ψ ∧
      ∃ e : ArtinSchreierAlgebra (LaurentSeries k) p (HahnSeries.single (-1) a) ≃+* LaurentSeries k,
        ∀ r : LaurentSeries k,
          e (AdjoinRoot.of (artinSchreierPolynomial p (HahnSeries.single (-1) a)) r) = Ψ r := by
  have hp : 1 < p := (Fact.out : p.Prime).one_lt
  obtain ⟨α, γ, hα, hγ, hαcoeff, hγcoeff, E, hE⟩ :=
    weak_laurent_completed_map_normalization p hp φ Ψ hΨ hzero horder hderiv
  obtain ⟨a, ha, hscalar, e, he⟩ := linearized_laurent_artin_schreier_model p α γ hα hγ
  refine ⟨a, ha, ?_, e.trans E.toRingEquiv, ?_⟩
  · simpa only [weakLaurentInvariant, ← hαcoeff, ← hγcoeff] using hscalar
  · intro r
    change E (e (AdjoinRoot.of _ r)) = Ψ r
    rw [he, hE]

theorem weak_laurent_invariant_nonzero
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [Fact p.Prime] [CharP k p]
    (φ : PowerSeries k →ₐ[k] PowerSeries k)
    (Ψ : LaurentSeries k →+* LaurentSeries k)
    (hΨ : ∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k))
    (hzero : PowerSeries.constantCoeff (φ PowerSeries.X) = 0)
    (horder : (Ψ (HahnSeries.single (-1) 1)).order = -(p : ℤ))
    (hderiv : (LaurentSeries.derivative k (Ψ (HahnSeries.single (-1) 1))).order = -2) :
    weakLaurentInvariant p Ψ ≠ 0 := by
  obtain ⟨a, ha, hscalar, _, _⟩ :=
    weak_laurent_completed_map_artin_schreier_model p φ Ψ hΨ hzero horder hderiv
  rw [← hscalar]
  exact pow_ne_zero _ ha

end Litt3.QuotientGeometry
