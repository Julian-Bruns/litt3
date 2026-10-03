import Definitions.CartierAndSpin.SquareClassTowers
import Solutions.CartierAndSpin.QuadraticSquareClasses
import Mathlib.LinearAlgebra.Dimension.Free

namespace Litt3.CartierAndSpin

universe u v

variable {K : Type u} {L : Type v} {ι : Type*}
  [Field K] [Field L] [Algebra K L]

theorem square_class_independent_mono (s t : Finset ι) (a : ι → K)
    (hst : s ⊆ t) (h : SquareClassIndependent t a) : SquareClassIndependent s a :=
  fun u hus hu => h u (hus.trans hst) hu

theorem square_class_independent_nonzero (s : Finset ι) (a : ι → K)
    (h : SquareClassIndependent s a) (i : ι) (hi : i ∈ s) : a i ≠ 0 := by
  classical
  intro hz
  apply h {i} (Finset.singleton_subset_iff.mpr hi) (Finset.singleton_nonempty i)
  simp only [Finset.prod_singleton, hz]
  exact ⟨0, by simp⟩

/-- Independent actual base square classes and actual roots in L
construct an embedded multiquadratic field with exact degree 2^|s|,
together with its full base square-class kernel. No extension degree or
simultaneous Galois closure is presumed. -/
theorem square_class_tower_exists (s : Finset ι) (a : ι → K) (root : ι → L)
    (htwo : (2 : K) ≠ 0) (hind : SquareClassIndependent s a)
    (hroots : ∀ i ∈ s, root i ^ 2 = algebraMap K L (a i)) :
    Nonempty (SquareClassTower K L s a) := by
  classical
  revert hind hroots
  induction s using Finset.induction_on with
  | empty =>
    intro hind hroots
    refine ⟨{
      carrier := K
      field := inferInstance
      algebra := inferInstance
      finite := inferInstance
      embedding := Algebra.ofId K L
      degree := ?_
      square_kernel := ?_ }⟩
    · simp
    · intro b hb
      refine ⟨∅, Finset.empty_subset _, ?_⟩
      simpa using hb
  | @insert i s hi ih =>
    intro hind hroots
    obtain ⟨tower⟩ := ih (square_class_independent_mono s (insert i s) a
      (Finset.subset_insert i s) hind) (fun j hj => hroots j (Finset.mem_insert_of_mem hj))
    let E := tower.carrier
    letI : Field E := tower.field
    letI : Algebra K E := tower.algebra
    letI : FiniteDimensional K E := tower.finite
    let alpha : E := algebraMap K E (a i)
    have hAi : a i ≠ 0 := square_class_independent_nonzero (insert i s) a hind i
      (Finset.mem_insert_self i s)
    have hAlpha : alpha ≠ 0 := by
      simpa only [alpha, map_zero] using (algebraMap K E).injective.ne hAi
    have htwoE : (2 : E) ≠ 0 := by
      intro hz
      have hh : algebraMap K E (2 : K) = algebraMap K E 0 := by
        simpa only [map_ofNat, map_zero] using hz
      exact htwo ((algebraMap K E).injective hh)
    have hnonsquare : ∀ x : E, x ^ 2 ≠ alpha := by
      intro x hx
      obtain ⟨t, ht, hsquare⟩ := tower.square_kernel (a i) ⟨x, by
        simpa only [pow_two] using hx.symm⟩
      have hit : i ∉ t := fun hit => hi (ht hit)
      apply hind (insert i t) (Finset.insert_subset_insert i ht) (Finset.insert_nonempty i t)
      rw [Finset.prod_insert hit]
      exact hsquare
    letI : Fact (∀ x : E, x ^ 2 ≠ alpha + 0 * x) := ⟨by simpa using hnonsquare⟩
    let Q := QuadraticAlgebra E alpha 0
    letI : Algebra E L := tower.embedding.toRingHom.toAlgebra
    letI : IsScalarTower K E L := IsScalarTower.of_algHom tower.embedding
    letI : FiniteDimensional K Q := Module.Finite.trans E Q
    let extension : Q →ₐ[E] L := QuadraticAlgebra.lift ⟨root i, by
      simp only [Algebra.smul_def, map_zero, zero_mul, add_zero, mul_one]
      change root i * root i = tower.embedding alpha
      rw [tower.embedding.commutes]
      simpa only [pow_two] using hroots i (Finset.mem_insert_self i s)⟩
    refine ⟨{
      carrier := Q
      field := inferInstance
      algebra := inferInstance
      finite := inferInstance
      embedding := extension.restrictScalars K
      degree := ?_
      square_kernel := ?_ }⟩
    · rw [← Module.finrank_mul_finrank K E Q, QuadraticAlgebra.finrank_eq_two,
        tower.degree, Finset.card_insert_of_notMem hi, pow_succ]
    · intro b hb
      change IsSquare (algebraMap E Q (algebraMap K E b)) at hb
      rcases (quadratic_algebra_base_square_iff alpha (algebraMap K E b) hAlpha htwoE).mp hb
        with hbase | hquotient
      · obtain ⟨t, ht, hsquare⟩ := tower.square_kernel b hbase
        exact ⟨t, ht.trans (Finset.subset_insert i s), hsquare⟩
      · have hquotient' : IsSquare (algebraMap K E (b / a i)) := by
          simpa only [map_div₀] using hquotient
        obtain ⟨t, ht, hsquare⟩ := tower.square_kernel (b / a i) hquotient'
        have hit : i ∉ t := fun hit => hi (ht hit)
        refine ⟨insert i t, Finset.insert_subset_insert i ht, ?_⟩
        rw [Finset.prod_insert hit]
        have hmul := (isSquare_mul_square_iff ((b / a i) * ∏ j ∈ t, a j) (a i) hAi).mpr hsquare
        convert hmul using 1 <;> field_simp <;> ring

/-- The actual independent square roots force the exact power-of-two
divisibility in a finite ambient extension. -/
theorem independent_square_roots_degree_divisibility [FiniteDimensional K L]
    (s : Finset ι) (a : ι → K) (root : ι → L)
    (htwo : (2 : K) ≠ 0) (hind : SquareClassIndependent s a)
    (hroots : ∀ i ∈ s, root i ^ 2 = algebraMap K L (a i)) :
    2 ^ s.card ∣ Module.finrank K L := by
  obtain ⟨tower⟩ := square_class_tower_exists s a root htwo hind hroots
  let E := tower.carrier
  letI : Field E := tower.field
  letI : Algebra K E := tower.algebra
  letI : FiniteDimensional K E := tower.finite
  letI : Algebra E L := tower.embedding.toRingHom.toAlgebra
  letI : IsScalarTower K E L := IsScalarTower.of_algHom tower.embedding
  refine ⟨Module.finrank E L, ?_⟩
  rw [← tower.degree]
  exact (Module.finrank_mul_finrank K E L).symm

end Litt3.CartierAndSpin
