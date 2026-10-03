import Solutions.CartierAndSpin.PowerSeriesEndpointRootCount
import Solutions.CartierAndSpin.PowerSeriesNodalBounds

namespace Litt3.CartierAndSpin

open Polynomial Lagrange

variable {k ι : Type*} [Field k]

theorem nodal_filter_factorization (s : Finset ι) (node : ι → PowerSeries k)
    (small : ι → Prop) [DecidablePred small] :
    nodal (s.filter small) node * nodal (s.filter (fun i => ¬ small i)) node = nodal s node := by
  classical
  exact Finset.prod_filter_mul_prod_filter_not s small (fun i => X - C (node i))

theorem power_series_small_nodal_residue (s : Finset ι) (node : ι → PowerSeries k)
    (hnode : ∀ i ∈ s, PowerSeries.constantCoeff (node i) = 0) :
    (nodal s node).map PowerSeries.constantCoeff = X ^ s.card := by
  classical
  rw [polynomial_map_nodal]
  simp only [nodal]
  have hprod : (∏ i ∈ s, (X - C (PowerSeries.constantCoeff (node i)))) =
      ∏ _i ∈ s, (X : k[X]) := by
    apply Finset.prod_congr rfl
    intro i hi
    rw [hnode i hi, map_zero, sub_zero]
  rw [hprod, Finset.prod_const]

/-- The complementary factor has exactly the original residual H, not
merely the same constant coefficient. -/
theorem power_series_small_factor_residue [DecidableEq k]
    (s : Finset ι) (node : ι → PowerSeries k)
    (F H : (PowerSeries k)[X]) (q tau leading : PowerSeries k) (p : ℕ)
    (hq : PowerSeries.constantCoeff q = 0) (htau : PowerSeries.constantCoeff tau = 0)
    (hfactor : F = C leading * nodal s node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hcard : (s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)).card = p) :
    let small := s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)
    let big := s.filter (fun i => PowerSeries.constantCoeff (node i) ≠ 0)
    let B := nodal small node
    let G := C leading * nodal big node
    F = B * G ∧ B.map PowerSeries.constantCoeff = X ^ p ∧
      G.map PowerSeries.constantCoeff = H.map PowerSeries.constantCoeff := by
  classical
  dsimp only
  have hprod := nodal_filter_factorization s node
    (fun i => PowerSeries.constantCoeff (node i) = 0)
  have hFG : F = nodal (s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)) node *
      (C leading * nodal (s.filter (fun i => PowerSeries.constantCoeff (node i) ≠ 0)) node) := by
    rw [mul_left_comm, hprod, ← hfactor]
  have hB : (nodal (s.filter (fun i => PowerSeries.constantCoeff (node i) = 0)) node).map
      PowerSeries.constantCoeff = X ^ p := by
    rw [power_series_small_nodal_residue _ node (by intro i hi; exact (Finset.mem_filter.mp hi).2), hcard]
  refine ⟨hFG, hB, ?_⟩
  have h := congrArg (Polynomial.map PowerSeries.constantCoeff) (hFG.symm.trans hsource)
  simp only [Polynomial.map_mul, Polynomial.map_add, Polynomial.map_pow, Polynomial.map_X,
    Polynomial.map_C, hq, htau, map_zero, add_zero, hB] at h
  simpa only [Polynomial.map_mul, Polynomial.map_C] using
    mul_left_cancel₀ (pow_ne_zero p X_ne_zero) h

end Litt3.CartierAndSpin
