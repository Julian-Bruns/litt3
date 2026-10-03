import Solutions.Deformations.ToricHypersurfaceNormalization

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

theorem toric_hypersurface_axis_reduction (x y z : A) (s : ℕ) (relation : x * y = z ^ s)
    (a b c : ℕ) :
    x ^ a * y ^ b * z ^ c =
      x ^ (a-b) * y ^ (b-a) * z ^ (c + s * min a b) := by
  by_cases h : a ≤ b
  · have split : b = a + (b-a) := by omega
    rw [Nat.sub_eq_zero_of_le h, Nat.min_eq_left h, split, pow_add]
    simp only [Nat.add_sub_cancel_left]
    calc
      x ^ a * (y ^ a * y ^ (b-a)) * z ^ c = (x*y)^a * y^(b-a) * z^c := by
        rw [mul_pow]; ring
      _ = x^0 * y^(b-a) * z^(c+s*a) := by rw [relation, ← pow_mul, pow_add]; ring
  · have h' : b ≤ a := by omega
    have split : a = b + (a-b) := by omega
    rw [Nat.sub_eq_zero_of_le h', Nat.min_eq_right h', split, pow_add]
    simp only [Nat.add_sub_cancel_left]
    calc
      (x ^ b * x ^ (a-b)) * y ^ b * z ^ c = x^(a-b) * (x*y)^b * z^c := by
        rw [mul_pow]; ring
      _ = x^(a-b) * y^0 * z^(c+s*b) := by rw [relation, ← pow_mul, pow_add]; ring

theorem toric_hypersurface_axis_cutoff (x y z : A) (Q R s : ℕ)
    (a : ToricHypersurfaceData) (axis : a.x=0 ∨ a.y=0)
    (relation : x*y = z^s) (xCutoff : x^Q=0) (yCutoff : y^Q=0)
    (zCutoff : z^R=0) (killed : ¬ toricHypersurfaceSurvives Q R s a) :
    x^a.x * y^a.y * z^a.z = 0 := by
  by_cases hx : a.x < Q
  · by_cases hy : a.y < Q
    · by_cases hz : a.z < R
      · have bad : s*(Q-a.x) ≤ a.z ∨ s*(Q-a.y) ≤ a.z := by
          by_contra h
          push_neg at h
          exact killed ⟨axis,hx,hy,hz,h.1,h.2⟩
        have vanish (u v : A) (uv : u*v=z^s) (cutoff : u^Q=0)
            (b c : ℕ) (hb : b < Q) (hc : s*(Q-b) ≤ c) : u^b*z^c=0 := by
          have degree : b+(Q-b)=Q := by omega
          have core : u^b*z^(s*(Q-b))=0 := by
            rw [pow_mul, ← uv, mul_pow]
            calc
              u^b*(u^(Q-b)*v^(Q-b)) = u^(b+(Q-b))*v^(Q-b) := by rw [pow_add]; ring
              _ = 0 := by rw [degree,cutoff,zero_mul]
          rw [← Nat.add_sub_of_le hc, pow_add]
          calc
            u^b*(z^(s*(Q-b))*z^(c-s*(Q-b))) =
              (u^b*z^(s*(Q-b)))*z^(c-s*(Q-b)) := by ring
            _ = 0 := by rw [core,zero_mul]
        rcases bad with h | h
        · have h' := vanish x y relation xCutoff a.x a.z hx h
          calc
            x^a.x*y^a.y*z^a.z = (x^a.x*z^a.z)*y^a.y := by ring
            _ = 0 := by rw [h',zero_mul]
        · have h' := vanish y x (by simpa [mul_comm] using relation) yCutoff a.y a.z hy h
          rw [mul_assoc,h',mul_zero]
      · rw [pow_eq_zero_of_le (by omega : R ≤ a.z) zCutoff,mul_zero]
    · rw [pow_eq_zero_of_le (by omega : Q ≤ a.y) yCutoff,mul_zero,zero_mul]
  · rw [pow_eq_zero_of_le (by omega : Q ≤ a.x) xCutoff,zero_mul,zero_mul]

end Litt3.Deformations
