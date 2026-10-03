import Mathlib.RingTheory.AdicCompletion.Algebra
import Mathlib.RingTheory.Ideal.Quotient.Operations

namespace Litt3.QuotientGeometry

variable {R S T : Type*} [CommRing R] [CommRing S] [CommRing T]

theorem ideal_power_le_comap_of_map_le
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J) (n : ℕ) :
    I ^ n ≤ (J ^ n).comap φ := by
  apply Ideal.map_le_iff_le_comap.mp
  rw [Ideal.map_pow]
  exact pow_le_pow_left' hφ n

private theorem ideal_power_smul_top_le_comap
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J) (n : ℕ) :
    (I ^ n • ⊤ : Ideal R) ≤ (J ^ n • ⊤ : Ideal S).comap φ := by
  simpa only [Ideal.smul_eq_mul, Ideal.mul_top] using
    ideal_power_le_comap_of_map_le I J φ hφ n

/-- The actual map on adic completions induced by a ring map carrying the
source ideal into the target ideal. No completion chart is supplied. -/
def adicRingMap (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J) :
    AdicCompletion I R →+* AdicCompletion J S where
  toFun x := ⟨fun n => Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
    (ideal_power_smul_top_le_comap I J φ hφ n) (x.val n), by
      intro m n hmn
      have hc : ∀ a : R ⧸ (I ^ n • ⊤ : Ideal R),
          AdicCompletion.transitionMap J S hmn
            (Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
              (ideal_power_smul_top_le_comap I J φ hφ n) a) =
          Ideal.quotientMap (J ^ m • ⊤ : Ideal S) φ
            (ideal_power_smul_top_le_comap I J φ hφ m)
              (AdicCompletion.transitionMap I R hmn a) := by
        intro a
        exact Quotient.inductionOn' a (fun _ => rfl)
      rw [hc, x.property hmn]⟩
  map_one' := by apply AdicCompletion.ext; intro n; exact map_one _
  map_mul' x y := by apply AdicCompletion.ext; intro n; exact map_mul _ _ _
  map_zero' := by apply AdicCompletion.ext; intro n; exact map_zero _
  map_add' x y := by apply AdicCompletion.ext; intro n; exact map_add _ _ _

@[simp] theorem adicRingMap_of
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J) (x : R) :
    adicRingMap I J φ hφ (AdicCompletion.of I R x) =
      AdicCompletion.of J S (φ x) := by
  apply AdicCompletion.ext
  intro n
  rfl

@[simp] theorem adicRingMap_eval
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J)
    (n : ℕ) (x : AdicCompletion I R) :
    AdicCompletion.evalₐ J n (adicRingMap I J φ hφ x) =
      Ideal.quotientMap (J ^ n) φ
        (ideal_power_le_comap_of_map_le I J φ hφ n)
          (AdicCompletion.evalₐ I n x) := by
  simp only [AdicCompletion.evalₐ, AlgHom.comp_apply, AlgHom.ofLinearMap_apply]
  dsimp only [AdicCompletion.eval, adicRingMap]
  change (Ideal.quotientEquivAlgOfEq S _)
      (Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
        (ideal_power_smul_top_le_comap I J φ hφ n) (x.val n)) =
    Ideal.quotientMap (J ^ n) φ
      (ideal_power_le_comap_of_map_le I J φ hφ n)
        ((Ideal.quotientEquivAlgOfEq R _) (x.val n))
  exact Quotient.inductionOn' (x.val n) (fun _ => rfl)

theorem adicRingMap_id (I : Ideal R) :
    adicRingMap I I (RingHom.id R) (by simp) = RingHom.id _ := by
  ext x n
  change Ideal.quotientMap (I ^ n • ⊤ : Ideal R) (RingHom.id R) _ (x.val n) = x.val n
  exact Quotient.inductionOn' (x.val n) (fun _ => rfl)

theorem adicRingMap_comp
    (I : Ideal R) (J : Ideal S) (K : Ideal T)
    (φ : R →+* S) (ψ : S →+* T) (hφ : I.map φ ≤ J) (hψ : J.map ψ ≤ K) :
    (adicRingMap J K ψ hψ).comp (adicRingMap I J φ hφ) =
      adicRingMap I K (ψ.comp φ)
        (by rw [← Ideal.map_map]; exact (Ideal.map_mono hφ).trans hψ) := by
  ext x n
  change Ideal.quotientMap (K ^ n • ⊤ : Ideal T) ψ _
      (Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ _ (x.val n)) =
    Ideal.quotientMap (K ^ n • ⊤ : Ideal T) (ψ.comp φ) _ (x.val n)
  exact Quotient.inductionOn' (x.val n) (fun _ => rfl)

/-- An isomorphism at every actual finite quotient induces an isomorphism
on the completions; the compatible inverse is constructed level by level. -/
theorem adicRingMap_bijective
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J)
    (hquot : ∀ n, Function.Bijective (Ideal.quotientMap (J ^ n) φ
      (ideal_power_le_comap_of_map_le I J φ hφ n))) :
    Function.Bijective (adicRingMap I J φ hφ) := by
  have hraw : ∀ n, Function.Bijective (Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
      (ideal_power_smul_top_le_comap I J φ hφ n)) := by
    intro n
    have hI : (I ^ n • ⊤ : Ideal R) = I ^ n := by ext x; simp
    have hJ : (J ^ n • ⊤ : Ideal S) = J ^ n := by ext x; simp
    let eI := (Ideal.quotientEquivAlgOfEq R hI).toRingEquiv
    let eJ := (Ideal.quotientEquivAlgOfEq S hJ).toRingEquiv
    have he : Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
        (ideal_power_smul_top_le_comap I J φ hφ n) =
        eJ.symm.toRingHom.comp ((Ideal.quotientMap (J ^ n) φ
          (ideal_power_le_comap_of_map_le I J φ hφ n)).comp eI.toRingHom) := by
      ext a
      rfl
    rw [he]
    exact eJ.symm.bijective.comp ((hquot n).comp eI.bijective)
  refine ⟨?_, ?_⟩
  · intro x y hxy
    apply AdicCompletion.ext
    intro n
    apply (hraw n).1
    exact congrArg (fun z : AdicCompletion J S => z.val n) hxy
  · intro x
    choose y hy using fun n => (hraw n).2 (x.val n)
    have hcompatible : ∀ {m n : ℕ}, (hmn : m ≤ n) →
        AdicCompletion.transitionMap I R hmn (y n) = y m := by
      intro m n hmn
      apply (hraw m).1
      have hc : ∀ a : R ⧸ (I ^ n • ⊤ : Ideal R),
          Ideal.quotientMap (J ^ m • ⊤ : Ideal S) φ
            (ideal_power_smul_top_le_comap I J φ hφ m)
              (AdicCompletion.transitionMap I R hmn a) =
          AdicCompletion.transitionMap J S hmn
            (Ideal.quotientMap (J ^ n • ⊤ : Ideal S) φ
              (ideal_power_smul_top_le_comap I J φ hφ n) a) := by
        intro a
        exact Quotient.inductionOn' a (fun _ => rfl)
      rw [hc, hy n, hy m, x.property hmn]
    refine ⟨⟨y, hcompatible⟩, ?_⟩
    apply AdicCompletion.ext
    intro n
    exact hy n

noncomputable def adicRingEquiv
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J)
    (hquot : ∀ n, Function.Bijective (Ideal.quotientMap (J ^ n) φ
      (ideal_power_le_comap_of_map_le I J φ hφ n))) :
    AdicCompletion I R ≃+* AdicCompletion J S :=
  RingEquiv.ofBijective (adicRingMap I J φ hφ)
    (adicRingMap_bijective I J φ hφ hquot)

@[simp] theorem adicRingEquiv_of
    (I : Ideal R) (J : Ideal S) (φ : R →+* S) (hφ : I.map φ ≤ J)
    (hquot : ∀ n, Function.Bijective (Ideal.quotientMap (J ^ n) φ
      (ideal_power_le_comap_of_map_le I J φ hφ n))) (x : R) :
    adicRingEquiv I J φ hφ hquot (AdicCompletion.of I R x) =
      AdicCompletion.of J S (φ x) := adicRingMap_of I J φ hφ x

end Litt3.QuotientGeometry
