import Solutions.SharedTensors.SaturatedKernels
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Data.Int.Cast.Lemmas

namespace Litt3.SharedTensors

variable {A : Type*} [AddCommGroup A]

/-- In an actual extension of the infinite cyclic group, divisibility
is exactly degree divisibility whenever multiplication is surjective
on the actual degree kernel. No chosen splitting is needed. -/
theorem roots_iff_degree_divisibility
    (d : A →+ ℤ) (hd : Function.Surjective d) (n : ℕ)
    (hk : Function.Surjective (fun t : d.ker => n • t)) (a : A) :
    (∃ b : A, n • b = a) ↔ (n : ℤ) ∣ d a := by
  constructor
  · rintro ⟨b, rfl⟩
    exact ⟨d b, by rw [map_nsmul, nsmul_eq_mul]⟩
  · rintro ⟨z, hz⟩
    obtain ⟨b, hb⟩ := hd z
    let t : d.ker := ⟨a - n • b, by
      change d (a - n • b) = 0
      rw [map_sub, map_nsmul, hb, nsmul_eq_mul, hz, sub_self]⟩
    obtain ⟨u, hu⟩ := hk t
    refine ⟨b + u.val, ?_⟩
    have hu' : n • u.val = a - n • b := congrArg Subtype.val hu
    rw [nsmul_add, hu']
    rw [add_comm, sub_add_cancel]

/-- The actual finite-kernel case uses its order alone, without
enumerating its elements or choosing a group decomposition. -/
theorem roots_iff_degree_divisibility_of_coprime_kernel
    (d : A →+ ℤ) (hd : Function.Surjective d) (n : ℕ)
    (hn : (Nat.card d.ker).Coprime n) (a : A) :
    (∃ b : A, n • b = a) ↔ (n : ℤ) ∣ d a :=
  roots_iff_degree_divisibility d hd n hn.nsmul_right_bijective.surjective a

/-- Saturation transports the exact root test from the actual relation
kernel back to the original ambient multiplicative quotient. -/
theorem saturated_roots_iff_degree_divisibility
    {B : Type*} [AddCommGroup B] [IsAddTorsionFree B]
    (f : A →+ B) (d : f.ker →+ ℤ) (hd : Function.Surjective d)
    (n : ℕ) (hn : n ≠ 0) (hk : (Nat.card d.ker).Coprime n) (a : f.ker) :
    (∃ b : A, n • b = a.val) ↔ (n : ℤ) ∣ d a := by
  have hs := kernel_integral_roots_saturated f n hn a.val
  have hr : (∃ b : A, n • b = a.val) ↔ (∃ b : f.ker, n • b = a) := by
    constructor
    · intro h
      obtain ⟨b, hb⟩ := hs.mp ⟨h, a.property⟩
      exact ⟨b, Subtype.ext hb⟩
    · rintro ⟨b, hb⟩
      exact ⟨b.val, congrArg Subtype.val hb⟩
  exact hr.trans (roots_iff_degree_divisibility_of_coprime_kernel d hd n hk a)

/-- Every characteristic-primary height is decided by the actual degree
when the actual degree kernel has order prime to that characteristic. -/
theorem saturated_prime_power_roots_iff_degree_divisibility
    {B : Type*} [AddCommGroup B] [IsAddTorsionFree B]
    (f : A →+ B) (d : f.ker →+ ℤ) (hd : Function.Surjective d)
    (p : ℕ) (hp : p ≠ 0) (hk : (Nat.card d.ker).Coprime p)
    (height : ℕ) (a : f.ker) :
    (∃ b : A, p ^ height • b = a.val) ↔ ((p ^ height : ℕ) : ℤ) ∣ d a := by
  exact saturated_roots_iff_degree_divisibility f d hd (p ^ height)
    (pow_ne_zero _ hp) (hk.pow_right _) a

end Litt3.SharedTensors
