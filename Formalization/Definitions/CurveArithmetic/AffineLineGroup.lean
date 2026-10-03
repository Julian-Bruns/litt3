import Definitions.CurveArithmetic.FiniteAffineInvariant
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic

namespace Litt3.CurveArithmetic

/-- Actual affine transformations of a field line. The representation
and its group law work for infinite fields as well as finite fields. -/
@[ext] structure AffineLineGroup (K : Type*) [Field K] where
  linear : Kˣ
  translation : K

instance {K : Type*} [Field K] : Group (AffineLineGroup K) where
  one := ⟨1, 0⟩
  mul a b := ⟨a.linear * b.linear, a.linear.val * b.translation + a.translation⟩
  inv a := ⟨a.linear⁻¹, -(a.linear⁻¹).val * a.translation⟩
  mul_assoc a b c := by
    apply AffineLineGroup.ext
    · exact mul_assoc _ _ _
    · change (a.linear.val * b.linear.val) * c.translation +
        (a.linear.val * b.translation + a.translation) =
        a.linear.val * (b.linear.val * c.translation + b.translation) + a.translation
      ring
  one_mul a := by
    apply AffineLineGroup.ext
    · exact one_mul _
    · change 1 * a.translation + 0 = _
      ring
  mul_one a := by
    apply AffineLineGroup.ext
    · exact mul_one _
    · change a.linear.val * 0 + a.translation = _
      ring
  inv_mul_cancel a := by
    apply AffineLineGroup.ext
    · exact inv_mul_cancel _
    · change (a.linear⁻¹).val * a.translation + (-(a.linear⁻¹).val * a.translation) = 0
      ring

@[simp] theorem affine_line_one_linear {K : Type*} [Field K] :
    (1 : AffineLineGroup K).linear = 1 := rfl
@[simp] theorem affine_line_one_translation {K : Type*} [Field K] :
    (1 : AffineLineGroup K).translation = 0 := rfl
@[simp] theorem affine_line_mul_linear {K : Type*} [Field K] (a b : AffineLineGroup K) :
    (a * b).linear = a.linear * b.linear := rfl
@[simp] theorem affine_line_mul_translation {K : Type*} [Field K] (a b : AffineLineGroup K) :
    (a * b).translation = a.linear.val * b.translation + a.translation := rfl

def affineLineDilation {K : Type*} [Field K] : Kˣ →* AffineLineGroup K where
  toFun u := ⟨u, 0⟩
  map_one' := rfl
  map_mul' u v := by ext <;> simp

def affineLineTranslation {K : Type*} [Field K] : Multiplicative K →* AffineLineGroup K where
  toFun v := ⟨1, v.toAdd⟩
  map_one' := rfl
  map_mul' v w := by ext <;> simp [add_comm]

def affineLineLinearHom {K : Type*} [Field K] : AffineLineGroup K →* Kˣ where
  toFun a := a.linear
  map_one' := rfl
  map_mul' a b := rfl

instance {K L : Type*} [Field K] [Field L] [Algebra K L] :
    MulAction (AffineLineGroup K) L where
  smul g a := finiteAffineTransform g.linear g.translation a
  one_smul a := by
    change algebraMap K L 1 * a + algebraMap K L 0 = a
    simp
  mul_smul g h a := by
    change algebraMap K L (g.linear * h.linear).val * a +
      algebraMap K L (g.linear.val * h.translation + g.translation) =
      algebraMap K L g.linear.val *
        (algebraMap K L h.linear.val * a + algebraMap K L h.translation) +
          algebraMap K L g.translation
    simp only [Units.val_mul, map_mul, map_add]
    ring

end Litt3.CurveArithmetic
