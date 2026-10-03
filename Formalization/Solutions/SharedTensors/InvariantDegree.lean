import Theorems.SharedTensors.InvariantDegree
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Abel

open scoped BigOperators

namespace Litt3.SharedTensors

variable {G A B : Type*} [Group G] [Fintype G]
variable [AddCommGroup A] [AddCommGroup B]

/-- Translation permutes the complete orbit sum. -/
theorem automorphism_orbit_sum_invariant (rho : G →* AddAut A) (a : A) (g : G) :
    rho g (∑ h : G, rho h a) = ∑ h : G, rho h a := by
  rw [map_sum]
  simp only [← AddAut.mul_apply, ← map_mul]
  exact Fintype.sum_equiv (Equiv.mulLeft g)
    (fun h => rho (g * h) a) (fun h => rho h a) (fun _ => rfl)

/-- The correction sum transforms by the exact integral cocycle formula. -/
theorem integral_degree_correction_formula (rho : G →* AddAut A) (a : A) (g : G) :
    rho g (∑ h : G, (rho h a - a)) =
      (∑ h : G, (rho h a - a)) - Fintype.card G • (rho g a - a) := by
  rw [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ,
    map_sub, map_nsmul, automorphism_orbit_sum_invariant, nsmul_sub]
  abel

/-- Every actual degree fiber contains a fixed point if the group order
acts bijectively on the actual degree kernel. This needs no field or
chosen splitting of the degree extension. -/
theorem fixed_point_of_degree_kernel_bijective
    (d : A →+ B) (rho : G →* AddAut A)
    (hd : ∀ g a, d (rho g a) = d a)
    (hk : Function.Bijective (fun t : d.ker => Fintype.card G • t)) (a : A) :
    ∃ b : degreeFixedSubgroup rho, d b = d a := by
  classical
  let s : d.ker := ∑ g : G, actionDegreeDifference d rho hd g a
  obtain ⟨b, hb⟩ := hk.surjective s
  have hb' : Fintype.card G • b.val = ∑ g : G, (rho g a - a) := by
    simpa [s, actionDegreeDifference] using congrArg Subtype.val hb
  refine ⟨⟨a + b.val, ?_⟩, ?_⟩
  · intro g
    let t : d.ker := ⟨rho g b.val - b.val + (rho g a - a), by
      change d (rho g b.val - b.val + (rho g a - a)) = 0
      rw [map_add, map_sub, map_sub, hd, hd, sub_self, sub_self, add_zero]⟩
    have hnt : Fintype.card G • t = 0 := by
      apply Subtype.ext
      change Fintype.card G • (rho g b.val - b.val + (rho g a - a)) = 0
      rw [nsmul_add, nsmul_sub, ← map_nsmul, hb',
        integral_degree_correction_formula]
      abel
    have ht : t = 0 := hk.injective (by simpa using hnt)
    have ht' : rho g b.val - b.val + (rho g a - a) = 0 :=
      congrArg Subtype.val ht
    apply sub_eq_zero.mp
    rw [map_add]
    calc
      rho g a + rho g b.val - (a + b.val) =
          rho g b.val - b.val + (rho g a - a) := by abel
      _ = 0 := ht'
  · change d (a + b.val) = d a
    rw [map_add, b.property, add_zero]

/-- The degree image of the actual fixed subgroup is the full degree
image; the correction is entirely integral. -/
theorem fixed_degree_range_eq_of_kernel_bijective
    (d : A →+ B) (rho : G →* AddAut A)
    (hd : ∀ g a, d (rho g a) = d a)
    (hk : Function.Bijective (fun t : d.ker => Fintype.card G • t)) :
    (fixedDegreeMap d rho).range = d.range := by
  ext z
  constructor
  · rintro ⟨b, hb⟩
    exact ⟨b.val, hb⟩
  · rintro ⟨a, rfl⟩
    obtain ⟨b, hb⟩ := fixed_point_of_degree_kernel_bijective d rho hd hk a
    exact ⟨b, hb⟩

/-- The finite prime-to-group-order degree kernel case, valid for every
finite group and arbitrary additive degree codomain. -/
theorem fixed_degree_range_eq_of_coprime_kernel
    (d : A →+ B) (rho : G →* AddAut A)
    (hd : ∀ g a, d (rho g a) = d a)
    (hcoprime : (Nat.card d.ker).Coprime (Fintype.card G)) :
    (fixedDegreeMap d rho).range = d.range :=
  fixed_degree_range_eq_of_kernel_bijective d rho hd hcoprime.nsmul_right_bijective

/-- The statement is independent of any enumeration of the finite group. -/
theorem finite_group_fixed_degree_image
    {H : Type*} [Group H] [Finite H]
    (d : A →+ B) (rho : H →* AddAut A)
    (hd : ∀ g a, d (rho g a) = d a)
    (hcoprime : (Nat.card d.ker).Coprime (Nat.card H)) :
    FixedDegreeImage d rho := by
  letI := Fintype.ofFinite H
  exact fixed_degree_range_eq_of_coprime_kernel d rho hd
    (by simpa only [Nat.card_eq_fintype_card] using hcoprime)

end Litt3.SharedTensors
