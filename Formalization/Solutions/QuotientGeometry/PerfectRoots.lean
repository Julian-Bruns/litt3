import Theorems.QuotientGeometry.PerfectRoots
import Solutions.QuotientGeometry.RefinementAlgebra
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- A line over K preserved by a perfect group of K-automorphisms is
pointwise fixed. The multiplicative character is built from the actual
ratios of conjugates of its nonzero generator. -/
theorem perfect_group_stable_line_fixed
    {K L G : Type*} [Field K] [Field L] [Algebra K L] [Group G]
    (hperfect : commutator G = ⊤) (action : G →* (L ≃ₐ[K] L)) (x : L)
    (hline : ∀ g : G, ∃ c : K, action g x = algebraMap K L c * x) :
    ∀ g : G, action g x = x := by
  by_cases hx : x = 0
  · subst x
    simp
  let character : G →* Lˣ :=
    { toFun := fun g => Units.mk0 (action g x / x)
        (div_ne_zero (by simpa only [map_zero] using (action g).injective.ne hx) hx)
      map_one' := by
        apply Units.ext
        simp [hx]
      map_mul' := by
        intro g h
        apply Units.ext
        change action (g * h) x / x = (action g x / x) * (action h x / x)
        obtain ⟨c, hc⟩ := hline h
        rw [action.map_mul]
        change action g (action h x) / x = (action g x / x) * (action h x / x)
        rw [hc, map_mul, (action g).commutes]
        field_simp }
  intro g
  have htrivial := perfect_group_abelian_hom_trivial hperfect character g
  have hratio : action g x / x = 1 := congrArg Units.val htrivial
  exact (div_eq_one_iff_eq hx).mp hratio

/-- The roots-of-unity condition produces an actual stable K-line from
the equation x^m=a. It also covers m=0; no division by m occurs. -/
theorem perfect_group_power_root_fixed
    {K L G : Type*} [Field K] [Field L] [Algebra K L] [Group G]
    (hperfect : commutator G = ⊤) (action : G →* (L ≃ₐ[K] L))
    (m : ℕ) (x : L) (a : K) (hpower : x ^ m = algebraMap K L a)
    (hroots : ∀ ζ : L, ζ ^ m = 1 → ∃ k : K, algebraMap K L k = ζ) :
    ∀ g : G, action g x = x := by
  by_cases hx : x = 0
  · subst x
    simp
  apply perfect_group_stable_line_fixed hperfect action x
  intro g
  have hconjugate : action g x ^ m = x ^ m := by
    rw [← map_pow, hpower, (action g).commutes]
  have hratio : (action g x / x) ^ m = 1 := by
    rw [div_pow, hconjugate, div_self (pow_ne_zero m hx)]
  obtain ⟨c, hc⟩ := hroots _ hratio
  refine ⟨c, ?_⟩
  exact (div_eq_iff hx).mp hc.symm

theorem perfect_galois_root_descends
    {K L : Type*} [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [IsGalois K L]
    (hperfect : commutator (L ≃ₐ[K] L) = ⊤)
    (m : ℕ) (x : L) (a : K) (hpower : x ^ m = algebraMap K L a)
    (hroots : ∀ ζ : L, ζ ^ m = 1 → ∃ k : K, algebraMap K L k = ζ) :
    x ∈ (⊥ : IntermediateField K L) := by
  apply (IsGalois.mem_bot_iff_fixed x).mpr
  exact perfect_group_power_root_fixed hperfect (MonoidHom.id _) m x a hpower hroots

theorem perfect_galois_root_descent_target : Targets.PerfectGaloisRootDescent := by
  intro K L instK instL instAlgebra instFiniteDimensional instGalois hperfect m x a hpower hroots
  exact perfect_galois_root_descends hperfect m x a hpower hroots

/-- All roots of unity in an arbitrary extension of an algebraically
closed constant field are already constant. This includes wild orders. -/
theorem roots_of_unity_descend_from_algebraically_closed_constants
    {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]
    (m : ℕ) (hm : 0 < m) (ζ : L) (hroot : ζ ^ m = 1) :
    ∃ c : k, algebraMap k L c = ζ := by
  have hintegral : IsIntegral k ζ :=
    IsIntegral.of_pow hm (by rw [hroot]; exact isIntegral_one)
  letI := IntermediateField.isAlgebraic_adjoin_simple hintegral
  have hfield := IntermediateField.eq_bot_of_isAlgClosed_of_isAlgebraic
    (IntermediateField.adjoin k {ζ})
  have hζ := IntermediateField.subset_adjoin k {ζ} (Set.mem_singleton ζ)
  rw [hfield] at hζ
  exact hζ

/-- The explicit roots-of-unity hypothesis is discharged by actual
algebraically closed constants inside the field tower. -/
theorem perfect_galois_root_descends_over_algebraically_closed_constants
    {k K L : Type*} [Field k] [Field K] [Field L]
    [Algebra k K] [Algebra K L] [Algebra k L] [IsScalarTower k K L] [IsAlgClosed k]
    [FiniteDimensional K L] [IsGalois K L]
    (hperfect : commutator (L ≃ₐ[K] L) = ⊤)
    (m : ℕ) (hm : 0 < m) (x : L) (a : K) (hpower : x ^ m = algebraMap K L a) :
    x ∈ (⊥ : IntermediateField K L) := by
  apply perfect_galois_root_descends hperfect m x a hpower
  intro ζ hζ
  obtain ⟨c, hc⟩ := roots_of_unity_descend_from_algebraically_closed_constants
    (k := k) m hm ζ hζ
  exact ⟨algebraMap k K c, (IsScalarTower.algebraMap_apply k K L c).symm.trans hc⟩

/-- A root descending to the fraction field of a normal domain is
regular when its positive power is regular. This completes the algebraic
regularity step independently of a chosen affine curve presentation. -/
theorem perfect_galois_regular_root_descends
    {R K L : Type*} [CommRing R] [IsDomain R] [IsIntegrallyClosed R]
    [Field K] [Field L] [Algebra R K] [IsFractionRing R K]
    [Algebra K L] [Algebra R L] [IsScalarTower R K L]
    [FiniteDimensional K L] [IsGalois K L]
    (hperfect : commutator (L ≃ₐ[K] L) = ⊤)
    (m : ℕ) (hm : 0 < m) (x : L) (a : R)
    (hpower : x ^ m = algebraMap R L a)
    (hroots : ∀ ζ : L, ζ ^ m = 1 → ∃ k : K, algebraMap K L k = ζ) :
    ∃ r : R, algebraMap R L r = x := by
  have hpowerK : x ^ m = algebraMap K L (algebraMap R K a) := by
    exact hpower.trans (IsScalarTower.algebraMap_apply R K L a)
  obtain ⟨y, hy⟩ := perfect_galois_root_descends hperfect m x _ hpowerK hroots
  change algebraMap K L y = x at hy
  have hyPower : y ^ m = algebraMap R K a := by
    apply (algebraMap K L).injective
    rw [map_pow, hy]
    exact hpowerK
  obtain ⟨r, hr⟩ := IsIntegrallyClosed.exists_algebraMap_eq_of_isIntegral_pow hm
    (by rw [hyPower]; exact isIntegral_algebraMap)
  refine ⟨r, ?_⟩
  rw [IsScalarTower.algebraMap_apply R K L r, hr, hy]

end Litt3.QuotientGeometry
