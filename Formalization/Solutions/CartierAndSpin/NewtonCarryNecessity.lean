import Solutions.CartierAndSpin.ReciprocalElementary
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.CartierAndSpin

open Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K] [Fintype ι]

omit [Algebra R K] in
/-- Actual descent of a tuple preserves all elementary symmetric functions. -/
theorem finiteElementarySymmetric_map (f : R →+* K) (u : ι → R) (k : ℕ) :
    f (finiteElementarySymmetric u k) =
      finiteElementarySymmetric (fun i => f (u i)) k := by
  classical
  simp [finiteElementarySymmetric, MvPolynomial.esymm]

/-- Every power trace and every carry coefficient is regular for a tuple
that actually descends as units. This proves the necessity direction of
the arbitrary-degree criterion, without characteristic or degree bounds. -/
theorem descended_unit_tuple_all_newton_data_regular (u : ι → K)
    (hunits : ∀ i, ∃ b : R, IsUnit b ∧ algebraMap R K b = u i) :
    (∀ k, finitePowerSum u k ∈ (algebraMap R K).range) ∧
    (∀ k, finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range) ∧
    (∀ k, finiteElementarySymmetric u k ∈ (algebraMap R K).range) ∧
    (∃ b : R, IsUnit b ∧ algebraMap R K b = ∏ i, u i) := by
  classical
  choose b hunit hb using hunits
  have hforward : ∀ k, finitePowerSum u k ∈ (algebraMap R K).range := by
    intro k
    refine ⟨finitePowerSum b k, ?_⟩
    simp only [finitePowerSum, map_sum, map_pow, hb]
  have hreciprocal : ∀ k, finitePowerSum (fun i => (u i)⁻¹) k ∈ (algebraMap R K).range := by
    intro k
    refine ⟨finitePowerSum (fun i => ↑((hunit i).unit⁻¹)) k, ?_⟩
    simp only [finitePowerSum, map_sum, map_pow, map_units_inv, IsUnit.unit_spec, hb]
  have helementary : ∀ k, finiteElementarySymmetric u k ∈ (algebraMap R K).range := by
    intro k
    refine ⟨finiteElementarySymmetric b k, ?_⟩
    simpa only [finiteElementarySymmetric_map, hb]
  refine ⟨hforward, hreciprocal, helementary, ∏ i, b i, ?_, ?_⟩
  · exact IsUnit.prod_univ_iff.mpr hunit
  · simp only [map_prod, hb]

end Litt3.CartierAndSpin
