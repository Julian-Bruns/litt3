import Solutions.CartierAndSpin.OneVariableSquarePencils

namespace Litt3.CartierAndSpin

variable {k L : Type*} [Field k] [Field L] [Algebra k L] [IsAlgClosed k]

/-- Every genuine affine parameter line has finite weighted square
support when H is outside the actual function subfield k(x). No plane
smoothness, Gauss geometry or odd function degree is needed for this
algebraic pencil component. -/
theorem affine_line_weighted_square_support_bound
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1)
    (x H g : L) (hx : x ∉ Set.range (algebraMap k L))
    (hH : H ∉ IntermediateField.adjoin k {x}) (hg : g ≠ 0)
    (htwo : (2 : k) ≠ 0) (s0 r0 a b : k) (hdir : a ≠ 0 ∨ b ≠ 0) :
    let support : Set k := {theta | IsSquare
      (g * (H + algebraMap k L (s0 + theta * a) +
        algebraMap k L (r0 + theta * b) * x))}
    support.Finite ∧ support.ncard ≤ 1 +
      (Module.finrank (IntermediateField.adjoin k
        {(H + algebraMap k L s0 + algebraMap k L r0 * x) /
          (algebraMap k L a + algebraMap k L b * x)}) L).factorization 2 := by
  let B := algebraMap k L a + algebraMap k L b * x
  have hB : B ≠ 0 := by
    intro hz
    by_cases hb : b = 0
    · have ha : a ≠ 0 := hdir.resolve_right (fun h => h hb)
      have haz : algebraMap k L a = 0 := by simpa [B, hb] using hz
      exact ha ((algebraMap k L).injective (by simpa only [map_zero] using haz))
    · apply hx
      refine ⟨-a / b, ?_⟩
      have hbL : algebraMap k L b ≠ 0 := by
        simpa only [map_zero] using (algebraMap k L).injective.ne hb
      rw [map_div₀, map_neg]
      apply (div_eq_iff hbL).mpr
      dsimp only [B] at hz
      linear_combination -hz
  let ratio := (H + algebraMap k L s0 + algebraMap k L r0 * x) / B
  have hratio : ratio ∉ Set.range (algebraMap k L) := by
    rintro ⟨c, hc⟩
    apply hH
    let F := IntermediateField.adjoin k {x}
    have hxmem : x ∈ F := IntermediateField.subset_adjoin k {x} (Set.mem_singleton x)
    have hBmem : B ∈ F := F.add_mem (F.algebraMap_mem a)
      (F.mul_mem (F.algebraMap_mem b) hxmem)
    have hidentity : H = algebraMap k L c * B - algebraMap k L s0 -
        algebraMap k L r0 * x := by
      have h := (div_eq_iff hB).mp hc.symm
      linear_combination h
    rw [hidentity]
    exact F.sub_mem (F.sub_mem (F.mul_mem (F.algebraMap_mem c) hBmem)
      (F.algebraMap_mem s0)) (F.mul_mem (F.algebraMap_mem r0) hxmem)
  let linear : Set k := {theta | IsSquare ((g * B) * (ratio - algebraMap k L theta))}
  have hbound : linear.Finite ∧ linear.ncard ≤
      1 + (Module.finrank (IntermediateField.adjoin k {ratio}) L).factorization 2 :=
    one_variable_weighted_square_pencil_finite hfg htrdeg ratio hratio
      (g * B) (mul_ne_zero hg hB) htwo
  have heq : {theta : k | IsSquare
      (g * (H + algebraMap k L (s0 + theta * a) +
        algebraMap k L (r0 + theta * b) * x))} = Neg.neg '' linear := by
    have hidentity : ∀ theta : k,
        g * (H + algebraMap k L (s0 + theta * a) +
          algebraMap k L (r0 + theta * b) * x) =
          (g * B) * (ratio - algebraMap k L (-theta)) := by
      intro theta
      dsimp only [ratio]
      rw [map_add, map_mul, map_add, map_mul, map_neg]
      field_simp [hB]
      dsimp only [B]
      ring
    ext theta
    constructor
    · intro htheta
      refine ⟨-theta, ?_, neg_neg theta⟩
      change IsSquare ((g * B) * (ratio - algebraMap k L (-theta)))
      rwa [← hidentity theta]
    · rintro ⟨lambda, hlambda, rfl⟩
      change IsSquare (g * (H + algebraMap k L (s0 + (-lambda) * a) +
        algebraMap k L (r0 + (-lambda) * b) * x))
      rw [hidentity (-lambda), neg_neg]
      exact hlambda
  dsimp only
  rw [heq]
  refine ⟨hbound.1.image Neg.neg, ?_⟩
  rw [Set.ncard_image_of_injOn neg_injective.injOn]
  exact hbound.2

theorem affine_line_weighted_square_support_finite
    (hfg : IntermediateField.FG (F := k) (E := L) ⊤)
    (htrdeg : Algebra.trdeg k L = 1)
    (x H g : L) (hx : x ∉ Set.range (algebraMap k L))
    (hH : H ∉ IntermediateField.adjoin k {x}) (hg : g ≠ 0)
    (htwo : (2 : k) ≠ 0) (s0 r0 a b : k) (hdir : a ≠ 0 ∨ b ≠ 0) :
    let support : Set k := {theta | IsSquare
      (g * (H + algebraMap k L (s0 + theta * a) +
        algebraMap k L (r0 + theta * b) * x))}
    support.Finite :=
  (affine_line_weighted_square_support_bound hfg htrdeg x H g hx hH hg htwo
    s0 r0 a b hdir).1

end Litt3.CartierAndSpin
