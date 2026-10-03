import Theorems.Jacobians.JetElimination
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Tactic

namespace Litt3.Jacobians

/-- The polynomial columns have no independent kernel and cancel exactly
the low jet rows. This is valid over every ring, not merely over fields. -/
theorem block_jet_nonzero_kernel_iff
    {K P Q R : Type*} [Ring K]
    [AddCommGroup P] [AddCommGroup Q] [AddCommGroup R]
    [Module K P] [Module K Q] [Module K R]
    (T : Q →ₗ[K] P) (B : Q →ₗ[K] R) :
    (∃ v : P × Q, v ≠ 0 ∧ blockJetMap T B v = 0) ↔
      ∃ q : Q, q ≠ 0 ∧ B q = 0 := by
  constructor
  · rintro ⟨⟨p, q⟩, hnonzero, hzero⟩
    have hfirst : p + T q = 0 := congrArg Prod.fst hzero
    have hsecond : B q = 0 := congrArg Prod.snd hzero
    refine ⟨q, ?_, hsecond⟩
    intro hq
    subst q
    simp only [map_zero, add_zero] at hfirst
    subst p
    exact hnonzero rfl
  · rintro ⟨q, hnonzero, hzero⟩
    refine ⟨(-T q, q), ?_, ?_⟩
    · intro hv
      exact hnonzero (congrArg Prod.snd hv)
    · simp [blockJetMap, hzero]

theorem block_jet_kernel_target : Targets.BlockJetKernelCriterion := by
  intro K P Q R instK instP instQ instR instKP instKQ instKR T B
  exact block_jet_nonzero_kernel_iff T B

/-- A polynomial Bézout identity proves that at least one selected maximal
minor is nonzero at every nonbranch point. No enumeration is required. -/
theorem bezout_power_certificate_detects_nonzero_minor
    {K ι : Type*} [Field K] (indices : Finset ι)
    (coefficient minor : ι → Polynomial K) (branch : Polynomial K)
    (exponent : ℕ)
    (hcertificate : ∑ i ∈ indices, coefficient i * minor i = branch ^ exponent)
    (point : K) (hbranch : branch.eval point ≠ 0) :
    ∃ i ∈ indices, (minor i).eval point ≠ 0 := by
  by_contra hno
  have hzero : ∀ i ∈ indices, (minor i).eval point = 0 := by
    simpa only [not_exists, not_and, not_not] using hno
  have heval := congrArg (Polynomial.eval point) hcertificate
  have hleft : (∑ i ∈ indices, coefficient i * minor i).eval point = 0 := by
    simp only [Polynomial.eval_finset_sum, Polynomial.eval_mul]
    exact Finset.sum_eq_zero fun i hi => by rw [hzero i hi, mul_zero]
  rw [hleft, Polynomial.eval_pow] at heval
  exact (pow_ne_zero exponent hbranch) heval.symm

/-- A two-coefficient remainder certificate eliminates common roots over
every field. It abstracts the short degree-seven/degree-two certificate
used for the fixed three-point Cartier test. -/
theorem linear_remainder_no_common_root
    {K : Type*} [Field K] (u v quotient : Polynomial K) (scalar root : K)
    (hscalar : scalar ≠ 0)
    (hremainder : u = quotient * v + Polynomial.C scalar *
      (Polynomial.X - Polynomial.C root))
    (hroot : v.eval root ≠ 0) :
    ¬ ∃ point : K, u.eval point = 0 ∧ v.eval point = 0 := by
  rintro ⟨point, hu, hv⟩
  have heval := congrArg (Polynomial.eval point) hremainder
  simp only [Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_sub,
    Polynomial.eval_X, Polynomial.eval_C] at heval
  rw [hu, hv, mul_zero, zero_add] at heval
  have hpoint : point = root := by
    have hdiff := (mul_eq_zero.mp heval.symm).resolve_left hscalar
    exact sub_eq_zero.mp hdiff
  exact hroot (hpoint ▸ hv)

end Litt3.Jacobians
