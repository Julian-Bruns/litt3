import Solutions.Deformations.BalancedPreparedSocleAlgebras
import Solutions.Deformations.TruncatedMonomialFrobenius
import Solutions.Deformations.TruncatedMonomialCompleteLocalRing
import Solutions.Deformations.TruncatedMonomialResidue

set_option maxHeartbeats 800000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.Deformations

variable (K : Type*) [Field K]

/-- An element killed by every original truncated parameter has scalar
action of the ENTIRE actual coefficient algebra. -/
theorem balanced_prepared_truncated_scalar_action {I : Type*} (q : I → ℕ)
    (v : TruncatedMonomialAlgebra K I q)
    (annihilate : ∀ i, truncatedMonomialParameter K I q i * v = 0) :
    ∀ a : TruncatedMonomialAlgebra K I q, ∃ c : K, a * v = c • v := by
  intro a
  obtain ⟨P, rfl⟩ := Ideal.Quotient.mk_surjective a
  induction P using MvPolynomial.induction_on with
  | C c => exact ⟨c, (Algebra.smul_def c v).symm⟩
  | add P Q hP hQ =>
    obtain ⟨a, ha⟩ := hP
    obtain ⟨b, hb⟩ := hQ
    exact ⟨a + b, by rw [map_add, add_mul, ha, hb, add_smul]⟩
  | mul_X P i hP =>
    exact ⟨0, by rw [map_mul, mul_assoc]; change _ *
      (truncatedMonomialParameter K I q i * v) = _; rw [annihilate, mul_zero, zero_smul]⟩

/-- The single original lower parameter generates the actual entire
augmentation ideal, including cutoff one. -/
theorem balanced_prepared_one_parameter_augmentation (Q : ℕ) :
    truncatedMonomialAugmentationIdeal K (Fin 1) (fun _ => Q) =
      Ideal.span ({truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0} : Set _) := by
  unfold truncatedMonomialAugmentationIdeal
  congr 1
  ext a
  constructor
  · rintro ⟨i, rfl⟩
    rw [Subsingleton.elim i 0]
    exact Set.mem_singleton _
  · rintro rfl
    exact Set.mem_range_self 0

/-- Every original surviving power of the single lower parameter is
nonzero in the literal coefficient quotient. -/
theorem balanced_prepared_parameter_power_nonzero (Q r : ℕ) (survives : r < Q) :
    truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ r ≠ 0 := by
  intro hz
  have same : Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) (fun _ => Q))
      (MvPolynomial.X 0 ^ r) = Ideal.Quotient.mk _ (0 : MvPolynomial (Fin 1) K) := by
    simpa only [map_pow, map_zero, truncatedMonomialParameter] using hz
  have coefficient := (truncated_monomial_quotient_eq_iff K (Fin 1) (fun _ => Q) _ _).mp same
    (Finsupp.single 0 r) (by intro i; rw [Subsingleton.elim i 0]; simpa using survives)
  exact (one_ne_zero : (1 : K) ≠ 0) (by simpa [MvPolynomial.X_pow_eq_monomial] using coefficient)

/-- A quadratic coefficient with unchanged nonzero original y²
coefficient is y² times a genuine unit of the SAME truncated algebra. -/
theorem balanced_prepared_quadratic_unit_factor (Q : ℕ) (survives : 2 < Q)
    [IsLocalRing (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))]
    (P : MvPolynomial (Fin 1) K)
    (quadratic : Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) (fun _ => Q)) P ∈
      truncatedMonomialAugmentationIdeal K (Fin 1) (fun _ => Q) ^ 2)
    (original : P.coeff (Finsupp.single 0 2) ≠ 0) :
    ∃ u : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ,
      Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) (fun _ => Q)) P =
        truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0 ^ 2 * (u : _) := by
  let A := TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q)
  let y := truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0
  rw [balanced_prepared_one_parameter_augmentation K Q, Ideal.span_singleton_pow] at quadratic
  obtain ⟨v, hv⟩ := Ideal.mem_span_singleton'.mp quadratic
  obtain ⟨H, rfl⟩ := Ideal.Quotient.mk_surjective v
  have same : Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) (fun _ => Q))
      (MvPolynomial.X 0 ^ 2 * H) = Ideal.Quotient.mk _ P := by
    rw [map_mul, map_pow]
    simpa only [truncatedMonomialParameter, mul_comm] using hv
  have coefficient := (truncated_monomial_quotient_eq_iff K (Fin 1) (fun _ => Q) _ _).mp same
    (Finsupp.single 0 2) (by intro i; rw [Subsingleton.elim i 0]; simpa using survives)
  have leading : H.coeff 0 ≠ 0 := by
    rw [MvPolynomial.X_pow_eq_monomial, MvPolynomial.coeff_monomial_mul'] at coefficient
    simp only [if_pos (le_refl _), tsub_self, one_mul] at coefficient
    exact coefficient ▸ original
  have unit : IsUnit (Ideal.Quotient.mk (truncatedMonomialIdeal K (Fin 1) (fun _ => Q)) H) := by
    apply IsLocalRing.notMem_maximalIdeal.mp
    rw [← truncated_monomial_augmentation_eq_maximal K (Fin 1) (fun _ => Q)
        (fun _ => Nat.lt_trans (by decide : 0 < 2) survives),
      ← truncated_monomial_residue_kernel K (Fin 1) (fun _ => Q)
        (fun _ => Nat.lt_trans (by decide : 0 < 2) survives),
      RingHom.mem_ker]
    simpa only [truncatedMonomialResidue, Ideal.Quotient.lift_mk,
      MvPolynomial.constantCoeff_eq] using leading
  obtain ⟨u, hu⟩ := unit
  refine ⟨u, ?_⟩
  change _ = y ^ 2 * _
  rw [hu]
  exact (mul_comm _ _).trans hv |>.symm

/-- A unit times the quadratic lower parameter has exactly the
nonzero top socle power at every odd balanced cutoff. -/
theorem balanced_prepared_monomial_top_socle (Q m : ℕ) (exponent : Q = 2 * m + 1)
    (u : (TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))ˣ) :
    let y := truncatedMonomialParameter K (Fin 1) (fun _ => Q) 0
    let g := y ^ 2 * (u : TruncatedMonomialAlgebra K (Fin 1) (fun _ => Q))
    (-g) ^ m ≠ 0 ∧ g ^ (m + 1) = 0 ∧
      ∀ a, ∃ c : K, a * (-g) ^ m = c • ((-g) ^ m) := by
  intro y g
  have top : y ^ (2 * m) ≠ 0 := balanced_prepared_parameter_power_nonzero K Q (2 * m) (by omega)
  have nilpotent : y ^ Q = 0 := truncated_monomial_parameter_pow K (Fin 1) (fun _ => Q) 0
  have annihilate : y * (-g) ^ m = 0 := by
    dsimp only [g]
    rw [neg_pow, mul_pow, ← pow_mul]
    calc
      _ = (-1) ^ m * y ^ (2 * m + 1) * (u : _) ^ m := by rw [pow_succ]; ring
      _ = 0 := by rw [← exponent, nilpotent, mul_zero, zero_mul]
  constructor
  · intro hz
    have hz' : y ^ (2 * m) * (u : _) ^ m = 0 := by
      have h := (neg_pow g m) ▸ hz
      have hzero : g ^ m = 0 := by
        exact (((isUnit_one : IsUnit (1 : TruncatedMonomialAlgebra K (Fin 1)
          (fun _ => Q))).neg).pow m).mul_right_eq_zero.mp h
      simpa only [g, mul_pow, ← pow_mul] using hzero
    exact top ((u.isUnit.pow m).mul_left_eq_zero.mp hz')
  · constructor
    · dsimp only [g]
      rw [mul_pow, ← pow_mul,
        pow_eq_zero_of_le (by omega : Q ≤ 2 * (m + 1)) nilpotent, zero_mul]
    · apply balanced_prepared_truncated_scalar_action K (fun _ : Fin 1 => Q)
      intro i
      rw [Subsingleton.elim i 0]
      exact annihilate

end Litt3.Deformations
