import Solutions.CartierAndSpin.OneVariablePairCoordinates
import Solutions.CartierAndSpin.FirstHasseContactType

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

theorem independent_pair_not_affine
    (u v : L) (hli : LinearIndependent k ![1, u, v]) :
    (¬ ∃ m n : k, v = algebraMap k L n + u * algebraMap k L m) ∧
    (¬ ∃ m n : k, u = algebraMap k L n + v * algebraMap k L m) := by
  classical
  constructor
  · rintro ⟨m, n, hv⟩
    have hsum : ∑ i ∈ (Finset.univ : Finset (Fin 3)),
        (![-n, -m, 1] : Fin 3 → k) i • (![1, u, v] : Fin 3 → L) i = 0 := by
      simp [Fin.sum_univ_three, Algebra.smul_def]
      linear_combination hv
    have h := (linearIndependent_iff'.mp hli) Finset.univ ![-n, -m, 1] hsum 2 (by simp)
    exact (one_ne_zero : (1 : k) ≠ 0) (by simpa using h)
  · rintro ⟨m, n, hu⟩
    have hsum : ∑ i ∈ (Finset.univ : Finset (Fin 3)),
        (![-n, 1, -m] : Fin 3 → k) i • (![1, u, v] : Fin 3 → L) i = 0 := by
      simp [Fin.sum_univ_three, Algebra.smul_def]
      linear_combination hu
    have h := (linearIndependent_iff'.mp hli) Finset.univ ![-n, 1, -m] hsum 1 (by simp)
    exact (one_ne_zero : (1 : k) ≠ 0) (by simpa using h)

variable [IsAlgClosed k] {p : ℕ} [Fact p.Prime] [CharP k p] [CharP L p]

/-- The entire algebraic plane-coordinate contact classification has
no coordinate, derivation, p-basis, finite-generation or separability
premise: these are constructed from actual generation by u,v and
actual transcendence degree one. -/
theorem generating_plane_pair_first_contact_exists
    (hpodd : Odd p) (htrdeg : Algebra.trdeg k L = 1) (u v : L)
    (hgen : IntermediateField.adjoin k {u, v} = ⊤)
    (hli : LinearIndependent k ![1, u, v]) :
    ∃ (b : PowerPBasis L p) (D : Derivation k L L) (w : L),
      ((b.parameter = u ∧ w = v) ∨ (b.parameter = v ∧ w = u)) ∧
      D b.parameter = 1 ∧ FirstHasseContactType b w ∧
      FiniteDimensional (IntermediateField.adjoin k {b.parameter}) L ∧
      Algebra.IsSeparable (IntermediateField.adjoin k {b.parameter}) L := by
  have hfg : IntermediateField.FG (F := k) (E := L) ⊤ := by
    rw [← hgen]
    exact IntermediateField.fg_adjoin_of_finite ((Set.finite_singleton v).insert u)
  obtain ⟨b, D, hcoord, ht, hfinite, hsep⟩ :=
    one_variable_generating_pair_coordinate_exists (p := p) htrdeg u v hgen
  have hnonline := independent_pair_not_affine u v hli
  rcases hcoord with hu | hv
  · refine ⟨b, D, v, Or.inl ⟨hu, rfl⟩, ht, ?_, hfinite, hsep⟩
    exact first_hasse_contact_type hpodd hfg htrdeg b D ht v (by simpa only [hu] using hnonline.1)
  · refine ⟨b, D, u, Or.inr ⟨hv, rfl⟩, ht, ?_, hfinite, hsep⟩
    exact first_hasse_contact_type hpodd hfg htrdeg b D ht u (by simpa only [hv] using hnonline.2)

end Litt3.CartierAndSpin
