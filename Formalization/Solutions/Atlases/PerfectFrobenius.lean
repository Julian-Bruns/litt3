import Definitions.Atlases.PerfectFrobenius
import Solutions.Atlases.SemilinearFiniteDimensional
import Solutions.Atlases.NilpotentIdealBounds
import Solutions.Atlases.PerfectReducedAlgebras
import Solutions.Atlases.CanonicalReducedSubalgebra
import Mathlib.RingTheory.Nilpotent.Lemmas

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A]
  (p : ℕ) [ExpChar K p] [ExpChar A p] [PerfectRing K p]

theorem perfectFrobeniusImage_mem (n : ℕ) (x : A) :
    x ∈ perfectFrobeniusImage (K := K) p n ↔
      ∃ y : A, y ^ (p ^ n) = x := Iff.rfl

theorem perfectFrobeniusImage_decreases (r e : ℕ) :
    perfectFrobeniusImage (K := K) (A := A) p (r * (e + 1)) ≤
      perfectFrobeniusImage (K := K) (A := A) p (r * e) := by
  intro x hx
  obtain ⟨y, rfl⟩ := hx
  refine ⟨iterateFrobenius A p r y, ?_⟩
  change iterateFrobenius A p (r * e) (iterateFrobenius A p r y) =
    iterateFrobenius A p (r * (e + 1)) y
  rw [← iterateFrobenius_add_apply, Nat.mul_add, Nat.mul_one]

theorem perfectFrobeniusImage_mapsTo (r e : ℕ) :
    Set.MapsTo (iterateFrobenius A p r)
      (perfectFrobeniusImage (K := K) (A := A) p (r * e))
      (perfectFrobeniusImage (K := K) (A := A) p (r * e)) := by
  intro x hx
  obtain ⟨y, rfl⟩ := hx
  exact ⟨iterateFrobenius A p r y, by
    simp only [LinearMap.iterateFrobenius_def, iterateFrobenius_def, ← pow_mul,
      Nat.mul_comm]⟩

variable [FiniteDimensional K A]

theorem perfectFrobenius_plateau_range_eq (r e : ℕ)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e) :
    perfectFrobeniusImage (K := K) (A := A) p (r * (e + 1)) =
      perfectFrobeniusImage (K := K) (A := A) p (r * e) :=
  Submodule.eq_of_le_of_finrank_eq (perfectFrobeniusImage_decreases p r e) h.symm

theorem perfectFrobenius_plateau_surjOn (r e : ℕ)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e) :
    Set.SurjOn (iterateFrobenius A p r)
      (perfectFrobeniusImage (K := K) (A := A) p (r * e))
      (perfectFrobeniusImage (K := K) (A := A) p (r * e)) := by
  intro x hx
  have hx' := (perfectFrobenius_plateau_range_eq p r e h).symm ▸ hx
  obtain ⟨y, hy⟩ := hx'
  refine ⟨iterateFrobenius A p (r * e) y, ⟨y, rfl⟩, ?_⟩
  change iterateFrobenius A p r (iterateFrobenius A p (r * e) y) = x
  rw [← iterateFrobenius_add_apply,
    (Nat.add_comm r (r * e)).trans (Nat.mul_succ r e).symm]
  exact hy

theorem perfectFrobenius_plateau_injOn (r e : ℕ)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e) :
    Set.InjOn (iterateFrobenius A p r)
      (perfectFrobeniusImage (K := K) (A := A) p (r * e)) := by
  exact (semilinear_injOn_iff_surjOn (iterateFrobeniusEquiv K p r)
    (LinearMap.iterateFrobenius K A p r)
    (perfectFrobeniusImage (K := K) (A := A) p (r * e))
    (perfectFrobeniusImage_mapsTo p r e)).mpr
      (perfectFrobenius_plateau_surjOn p r e h)

/-- Every actual nilpotent is killed by an iterate of any specified
positive p-power Frobenius. -/
theorem perfectFrobenius_eventually_kills_nilpotent (hp : 1 < p)
    {r : ℕ} (hr : 0 < r) (x : A) (hx : IsNilpotent x) :
    ∃ n : ℕ, (iterateFrobenius A p r)^[n] x = 0 := by
  obtain ⟨n, hn⟩ := hx
  refine ⟨n, ?_⟩
  rw [← iterateFrobenius_mul_apply, iterateFrobenius_def, pow_mul]
  exact pow_eq_zero_of_le (Nat.lt_pow_self (Nat.one_lt_pow hr.ne' hp)).le hn

/-- One exact consecutive semilinear rank plateau proves the entire
image has no nonzero nilpotents, including a plateau at exponent zero. -/
theorem perfectFrobenius_plateau_image_reduced (hp : 1 < p)
    {r e : ℕ} (hr : 0 < r)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e)
    (x : A) (hx : x ∈ perfectFrobeniusImage (K := K) p (r * e))
    (hnil : IsNilpotent x) : x = 0 := by
  obtain ⟨n, hn⟩ := perfectFrobenius_eventually_kills_nilpotent p hp hr x hnil
  apply (perfectFrobenius_plateau_injOn p r e h).iterate
    (perfectFrobeniusImage_mapsTo p r e) n hx
    (perfectFrobeniusImage (K := K) (A := A) p (r * e)).zero_mem
  simpa only [iterate_map_zero] using hn

/-- The exact adaptive semilinear rank certificate determines the
nilradical of the original algebra, not an auxiliary linear model. -/
theorem perfectFrobenius_plateau_kernel_iff_nilpotent (hp : 1 < p)
    {r e : ℕ} (hr : 0 < r)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e) (x : A) :
    iterateFrobenius A p (r * e) x = 0 ↔ IsNilpotent x := by
  constructor
  · intro hx
    exact ⟨p ^ (r * e), hx⟩
  · intro hx
    exact perfectFrobenius_plateau_image_reduced p hp hr h
      (iterateFrobenius A p (r * e) x) ⟨x, rfl⟩
      (hx.pow_of_pos (pow_pos (by omega : 0 < p) (r * e)).ne')

omit [ExpChar K p] [PerfectRing K p] in
/-- The dimension bound supplies a nonadaptive kernel certificate,
without monogenicity or a bound from numerical root finding. -/
theorem perfectFrobenius_dimension_kernel_iff_nilpotent (n : ℕ)
    (hn : Module.finrank K A ≤ p ^ n) (x : A) :
    iterateFrobenius A p n x = 0 ↔ IsNilpotent x := by
  constructor
  · intro hx
    exact ⟨p ^ n, hx⟩
  · intro hx
    have hm := Ideal.pow_mem_pow (mem_nilradical.mpr hx) (Module.finrank K A)
    rw [nilradical_pow_finrank (k := K), Submodule.mem_bot] at hm
    exact pow_eq_zero_of_le hn hm

variable [PerfectField K]

/-- Every iterated Frobenius is bijective on the actual canonical
reduced subalgebra over an arbitrary perfect field. -/
theorem canonicalReducedSubalgebra_frobenius_surjective (n : ℕ) :
    Function.Surjective (fun x : canonicalReducedSubalgebra (K := K) (A := A) =>
      x ^ (p ^ n)) := by
  let B := canonicalReducedSubalgebra (K := K) (A := A)
  letI : ExpChar B p :=
    (B.val.toRingHom).expChar Subtype.val_injective p
  exact (semilinear_injective_iff_surjective (iterateFrobeniusEquiv K p n)
    (LinearMap.iterateFrobenius K B p n)).mp (iterateFrobenius_inj B p n)

/-- Any exact nilradical kernel certificate identifies the actual
Frobenius image with the unique canonical reduced subalgebra. -/
theorem perfectFrobenius_image_eq_canonical (n : ℕ)
    (kernel : ∀ x : A, iterateFrobenius A p n x = 0 ↔ IsNilpotent x) :
    perfectFrobeniusImage (K := K) (A := A) p n =
      (canonicalReducedSubalgebra (K := K) (A := A)).toSubmodule := by
  let B := canonicalReducedSubalgebra (K := K) (A := A)
  apply le_antisymm
  · intro x hx
    obtain ⟨y, rfl⟩ := hx
    let b := canonicalReducedSection (K := K) (Ideal.Quotient.mkₐ K (nilradical A) y)
    have hnil : IsNilpotent (y - b) :=
      mem_nilradical.mp (canonicalReducedSection_difference_mem_nilradical (K := K) y)
    have heq : iterateFrobenius A p n y = iterateFrobenius A p n b :=
      sub_eq_zero.mp (by simpa only [map_sub] using (kernel (y - b)).mpr hnil)
    change iterateFrobenius A p n y ∈ B
    rw [heq]
    exact B.pow_mem ⟨Ideal.Quotient.mkₐ K (nilradical A) y, rfl⟩ _
  · intro x hx
    obtain ⟨y, hy⟩ := canonicalReducedSubalgebra_frobenius_surjective
      (K := K) (A := A) p n ⟨x, hx⟩
    exact ⟨y, congrArg Subtype.val hy⟩

/-- The independent dimension bound recovers the actual canonical
reduced algebra and its quotient isomorphism. -/
theorem perfectFrobenius_dimension_image_eq_canonical (n : ℕ)
    (hn : Module.finrank K A ≤ p ^ n) :
    perfectFrobeniusImage (K := K) (A := A) p n =
      (canonicalReducedSubalgebra (K := K) (A := A)).toSubmodule :=
  perfectFrobenius_image_eq_canonical p n
    (perfectFrobenius_dimension_kernel_iff_nilpotent p n hn)

/-- One exact consecutive semilinear image-rank plateau is already
enough to recover the actual canonical reduced algebra, including e=0. -/
theorem perfectFrobenius_plateau_image_eq_canonical (hp : 1 < p)
    {r e : ℕ} (hr : 0 < r)
    (h : PerfectFrobeniusRankPlateau (K := K) (A := A) p r e) :
    perfectFrobeniusImage (K := K) (A := A) p (r * e) =
      (canonicalReducedSubalgebra (K := K) (A := A)).toSubmodule :=
  perfectFrobenius_image_eq_canonical p (r * e)
    (perfectFrobenius_plateau_kernel_iff_nilpotent p hp hr h)

end Litt3.Atlases
