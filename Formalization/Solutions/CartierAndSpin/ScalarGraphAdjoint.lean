import Solutions.CartierAndSpin.SkewKernel
import Mathlib.LinearAlgebra.BilinearForm.Properties
import Mathlib.LinearAlgebra.Dual.Lemmas

namespace Litt3.CartierAndSpin

open Module LinearMap
open LinearMap (BilinForm)

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
    [FiniteDimensional K V]

theorem self_adjoint_scalar_graph_adjoint (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (A : V →ₗ[K] V) (hA : B.IsSelfAdjoint A)
    (e : V) (a : V →ₗ[K] K) :
    B.leftAdjointOfNondegenerate hB (A + a.smulRight e) =
      A + (B e).smulRight ((B.toDual hB).symm a) := by
  symm
  apply (B.isAdjointPair_iff_eq_of_nondegenerate hB _ _).mp
  intro x y
  simp only [LinearMap.add_apply, LinearMap.smulRight_apply,
    map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply,
    smul_eq_mul]
  rw [hA x y, BilinForm.apply_toDual_symm_apply, hsym.eq e x]
  ring

theorem self_adjoint_scalar_graph_skew (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (A : V →ₗ[K] V) (hA : B.IsSelfAdjoint A)
    (e : V) (a : V →ₗ[K] K) :
    (A + a.smulRight e) - B.leftAdjointOfNondegenerate hB (A + a.smulRight e) =
      rankTwoSkew e ((B.toDual hB).symm a) a (B e) := by
  rw [self_adjoint_scalar_graph_adjoint B hB hsym A hA e a]
  dsimp only [rankTwoSkew]
  abel

omit [FiniteDimensional K V] in
theorem pairing_skew_nonzero_independent (B : BilinForm K V) (e u : V)
    (hne : rankTwoSkew e u (B u) (B e) ≠ 0) : LinearIndependent K ![e, u] := by
  have he : e ≠ 0 := by
    intro he
    apply hne
    ext x
    simp [rankTwoSkew, he]
  rw [LinearIndependent.pair_iff' he]
  intro c hc
  apply hne
  ext x
  rw [← hc]
  simp [rankTwoSkew, map_smul, smul_smul, mul_comm]

theorem pairing_functionals_surjective (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (e u : V) (hli : LinearIndependent K ![e, u]) :
    Function.Surjective (fun x : V => (B u x, B e x)) := by
  let f : K × K →ₗ[K] V := (LinearMap.fst K K K).smulRight e +
    (LinearMap.snd K K K).smulRight u
  have hf : Function.Injective f := by
    rw [← LinearMap.ker_eq_bot]
    apply LinearMap.ker_eq_bot'.mpr
    intro x hx
    have hcoeff : x.1 = 0 ∧ x.2 = 0 := hli.eq_zero_of_pair hx
    exact Prod.ext hcoeff.1 hcoeff.2
  rintro ⟨r, s⟩
  let g : K × K →ₗ[K] K := s • LinearMap.fst K K K + r • LinearMap.snd K K K
  obtain ⟨a, ha⟩ := LinearMap.dualMap_surjective_of_injective hf g
  refine ⟨(B.toDual hB).symm a, ?_⟩
  have heval := congrArg (fun t : (K × K →ₗ[K] K) => t (1, 0)) ha
  have ueval := congrArg (fun t : (K × K →ₗ[K] K) => t (0, 1)) ha
  have hea : a e = s := by simpa [f, g, LinearMap.dualMap_apply] using heval
  have hua : a u = r := by simpa [f, g, LinearMap.dualMap_apply] using ueval
  apply Prod.ext
  · change B u ((B.toDual hB).symm a) = r
    rw [hsym.eq, BilinForm.apply_toDual_symm_apply, hua]
  · change B e ((B.toDual hB).symm a) = s
    rw [hsym.eq, BilinForm.apply_toDual_symm_apply, hea]

theorem scalar_graph_nonzero_skew_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (A : V →ₗ[K] V) (hA : B.IsSelfAdjoint A)
    (e : V) (a : V →ₗ[K] K)
    (hne : (A + a.smulRight e) - B.leftAdjointOfNondegenerate hB (A + a.smulRight e) ≠ 0)
    (x : V) :
    ((A + a.smulRight e) - B.leftAdjointOfNondegenerate hB (A + a.smulRight e)) x = 0 ↔
      a x = 0 ∧ B e x = 0 := by
  rw [self_adjoint_scalar_graph_skew B hB hsym A hA e a] at hne ⊢
  have ha : B ((B.toDual hB).symm a) = a := by
    ext v
    exact BilinForm.apply_toDual_symm_apply a v
  have hli := pairing_skew_nonzero_independent B e ((B.toDual hB).symm a) (ha.symm ▸ hne)
  exact rankTwoSkewKernelCriterion e ((B.toDual hB).symm a) a (B e) hli x

theorem scalar_graph_nonzero_skew_finrank_kernel (B : BilinForm K V) (hB : B.Nondegenerate)
    (hsym : B.IsSymm) (A : V →ₗ[K] V) (hA : B.IsSelfAdjoint A)
    (e : V) (a : V →ₗ[K] K)
    (hne : (A + a.smulRight e) - B.leftAdjointOfNondegenerate hB (A + a.smulRight e) ≠ 0) :
    finrank K (LinearMap.ker ((A + a.smulRight e) -
      B.leftAdjointOfNondegenerate hB (A + a.smulRight e))) + 2 = finrank K V := by
  rw [self_adjoint_scalar_graph_skew B hB hsym A hA e a] at hne ⊢
  have ha : B ((B.toDual hB).symm a) = a := by
    ext v
    exact BilinForm.apply_toDual_symm_apply a v
  have hli := pairing_skew_nonzero_independent B e ((B.toDual hB).symm a) (ha.symm ▸ hne)
  have hsurj := pairing_functionals_surjective B hB hsym e ((B.toDual hB).symm a) hli
  rw [ha] at hsurj
  exact rankTwoSkew_finrank_kernel e ((B.toDual hB).symm a) a (B e) hli hsurj

omit [FiniteDimensional K V] in
theorem pairing_skew_zero_iff_proportional (B : BilinForm K V) (hB : B.Nondegenerate)
    (e u : V) (he : e ≠ 0) :
    rankTwoSkew e u (B u) (B e) = 0 ↔ ∃ c : K, u = c • e := by
  constructor
  · intro hzero
    have hvexists : ∃ v, B e v ≠ 0 := by
      by_contra h
      push_neg at h
      exact he (hB e h)
    obtain ⟨v, hv⟩ := hvexists
    have hrel : (B u v) • e = (B e v) • u := by
      have := LinearMap.congr_fun hzero v
      exact sub_eq_zero.mp this
    refine ⟨B u v / B e v, ?_⟩
    calc
      u = (B e v)⁻¹ • ((B e v) • u) := by simp [smul_smul, hv]
      _ = (B e v)⁻¹ • ((B u v) • e) := by rw [← hrel]
      _ = (B u v / B e v) • e := by rw [smul_smul, div_eq_mul_inv, mul_comm]
  · rintro ⟨c, rfl⟩
    ext x
    simp [rankTwoSkew, map_smul, smul_smul, mul_comm]

theorem self_adjoint_scalar_graph_zero_skew_iff (B : BilinForm K V)
    (hB : B.Nondegenerate) (hsym : B.IsSymm) (A : V →ₗ[K] V)
    (hA : B.IsSelfAdjoint A) (e : V) (he : e ≠ 0) (a : V →ₗ[K] K) :
    (A + a.smulRight e) - B.leftAdjointOfNondegenerate hB (A + a.smulRight e) = 0 ↔
      ∃ c : K, a = c • B e := by
  rw [self_adjoint_scalar_graph_skew B hB hsym A hA e a]
  have ha : B ((B.toDual hB).symm a) = a := by
    ext v
    exact BilinForm.apply_toDual_symm_apply a v
  have hzero : rankTwoSkew e ((B.toDual hB).symm a) a (B e) = 0 ↔
      ∃ c : K, (B.toDual hB).symm a = c • e := by
    have h := pairing_skew_zero_iff_proportional B hB e ((B.toDual hB).symm a) he
    rwa [ha] at h
  rw [hzero]
  constructor
  · rintro ⟨c, hc⟩
    refine ⟨c, ?_⟩
    rw [← ha, hc, map_smul]
  · rintro ⟨c, hc⟩
    refine ⟨c, ?_⟩
    apply (B.toDual hB).injective
    change B ((B.toDual hB).symm a) = B (c • e)
    rw [ha, map_smul, hc]

end Litt3.CartierAndSpin
