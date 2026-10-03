import Definitions.QuotientGeometry.LiftedCompletedEmbedding
import Solutions.QuotientGeometry.ParameterOrders
import Mathlib.RingTheory.PowerBasis

namespace Litt3.QuotientGeometry

theorem finite_parameter_weight_injective
    (n : ℕ) (d : Fin n → ℕ) :
    Function.Injective (fun i : Fin n => i.val + n * d i) := by
  intro i j hij
  apply Fin.ext
  have hmod := congrArg (fun m : ℕ => m % n) hij
  simpa [Nat.add_mod, Nat.mod_eq_of_lt i.is_lt, Nat.mod_eq_of_lt j.is_lt] using hmod

theorem finite_parameter_basis_linear_independent
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0) :
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    LinearIndependent (CompletedPowerSeriesBase k)
      (fun i : Fin n => (PowerSeries.X : PowerSeries k) ^ i.val) := by
  classical
  let A := CompletedPowerSeriesBase k
  letI : Algebra A (PowerSeries k) := (liftedCompletedEmbedding b hb0).toAlgebra
  letI : SMul A (PowerSeries k) := (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
  letI : Module A (PowerSeries k) := Algebra.toModule
  apply Fintype.linearIndependent_iff.mpr
  intro a hsum i
  by_contra hi
  let s : Finset (Fin n) := Finset.univ.filter (fun j => a j ≠ 0)
  let w : Fin n → ℕ := fun j => j.val + n * (PowerSeries.order (a j).down).toNat
  obtain ⟨r, hr, hmin⟩ := s.exists_min_image w ⟨i, by simp [s, hi]⟩
  have hr0 : (a r).down ≠ 0 := by
    have har : a r ≠ 0 := (Finset.mem_filter.mp hr).2
    intro hz
    apply har
    exact ULift.down_injective hz
  have hterm (j : Fin n) (hj : (a j).down ≠ 0) :
      PowerSeries.order (PowerSeries.subst b (a j).down * PowerSeries.X ^ j.val) = w j := by
    rw [PowerSeries.order_mul,
      finite_parameter_substitution_order n hn b c (a j).down hb hc hj,
      PowerSeries.order_X_pow]
    simp [w, add_comm]
  have hcoeff : PowerSeries.coeff (w r)
      (PowerSeries.subst b (a r).down * PowerSeries.X ^ r.val) ≠ 0 :=
    (PowerSeries.order_eq_nat.mp (hterm r hr0)).1
  have hother (j : Fin n) (hj : j ≠ r) :
      PowerSeries.coeff (w r) (PowerSeries.subst b (a j).down * PowerSeries.X ^ j.val) = 0 := by
    by_cases haj : a j = 0
    · simp [haj, ← PowerSeries.coe_substAlgHom
        (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)]
    · have hj0 : (a j).down ≠ 0 := by
        intro hz
        exact haj (ULift.down_injective hz)
      have hjmem : j ∈ s := by simp [s, haj]
      have hlt : w r < w j := lt_of_le_of_ne (hmin j hjmem) (by
        intro heq
        exact hj ((finite_parameter_weight_injective n
          (fun l => (PowerSeries.order (a l).down).toNat)) heq.symm))
      exact (PowerSeries.order_eq_nat.mp (hterm j hj0)).2 _ hlt
  have hz : (∑ j : Fin n,
      PowerSeries.subst b (a j).down * PowerSeries.X ^ j.val) = 0 := by
    simpa only [Algebra.smul_def, liftedCompletedEmbedding, RingHom.algebraMap_toAlgebra,
      RingHom.comp_apply, AlgHom.toRingHom_eq_coe, AlgHom.coe_toRingHom,
      PowerSeries.coe_substAlgHom] using hsum
  have hzcoeff := congrArg (PowerSeries.coeff (w r)) hz
  rw [map_sum, map_zero, Finset.sum_eq_single r] at hzcoeff
  · exact hcoeff hzcoeff
  · intro j _ hj
    exact hother j hj
  · simp

/-- The literal entire power-series ring is finite free over any actual
positive parameter, with powers of its uniformizer as its power basis. -/
theorem finite_parameter_completed_power_basis
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0) :
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    ∃ pb : PowerBasis (CompletedPowerSeriesBase k) (PowerSeries k),
      pb.gen = PowerSeries.X ∧ pb.dim = n := by
  classical
  let A := CompletedPowerSeriesBase k
  letI : Algebra A (PowerSeries k) := (liftedCompletedEmbedding b hb0).toAlgebra
  letI : SMul A (PowerSeries k) := (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
  letI : Module A (PowerSeries k) := Algebra.toModule
  have hli := finite_parameter_basis_linear_independent n hn b c hb hc hb0
  have hspan : ⊤ ≤ Submodule.span A
      (Set.range (fun i : Fin n => (PowerSeries.X : PowerSeries k) ^ i.val)) := by
    intro f _
    rw [finite_parameter_power_series_decomposition n hn b c f hb hc]
    apply Submodule.sum_mem
    intro i _
    have hsmul : (ULift.up (finiteParameterComponents n b c f i) : A) •
        PowerSeries.X ^ i.val ∈ Submodule.span A
          (Set.range (fun j : Fin n => (PowerSeries.X : PowerSeries k) ^ j.val)) :=
      Submodule.smul_mem _ _ (Submodule.subset_span (Set.mem_range_self i))
    simpa only [Algebra.smul_def, liftedCompletedEmbedding, RingHom.algebraMap_toAlgebra,
      RingHom.comp_apply, AlgHom.toRingHom_eq_coe, AlgHom.coe_toRingHom,
      PowerSeries.coe_substAlgHom, mul_comm] using hsmul
  refine ⟨⟨PowerSeries.X, n, Module.Basis.mk hli hspan, ?_⟩, rfl, rfl⟩
  intro i
  exact Module.Basis.mk_apply hli hspan i

end Litt3.QuotientGeometry
