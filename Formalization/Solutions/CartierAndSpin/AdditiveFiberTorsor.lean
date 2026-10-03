import Definitions.CartierAndSpin.EndpointDecompositionFibers

namespace Litt3.CartierAndSpin

variable {A W : Type*} [AddCommGroup A] [AddCommGroup W]

/-- A genuine nonempty additive-homomorphism fiber is a torsor under
its actual kernel, by literal addition and subtraction. Nonemptiness
is an actual point, not an assumed transitivity conclusion. -/
def actualAdditiveFiberTorsor (m : A →+ W) (omega : W)
    (a0 : A) (h0 : m a0 = omega) :
    AddTorsor m.ker {a : A // m a = omega} where
  vadd x a := ⟨x.val + a.val, by rw [map_add, x.property, a.property, zero_add]⟩
  zero_vadd a := by apply Subtype.ext; exact zero_add a.val
  add_vadd x y a := by apply Subtype.ext; exact add_assoc x.val y.val a.val
  vsub a b := ⟨a.val - b.val, by
    change m (a.val - b.val) = 0
    rw [map_sub, a.property, b.property, sub_self]⟩
  nonempty := ⟨⟨a0, h0⟩⟩
  vsub_vadd' a b := by apply Subtype.ext; exact sub_add_cancel a.val b.val
  vadd_vsub' x a := by apply Subtype.ext; exact add_sub_cancel_right x.val a.val

/-- Choosing one actual fiber point identifies its actual kernel with
the full fiber, retaining the literal translation formula. -/
def actualAdditiveFiberEquiv (m : A →+ W) (omega : W)
    (a0 : A) (h0 : m a0 = omega) :
    m.ker ≃ {a : A // m a = omega} where
  toFun x := ⟨x.val + a0, by rw [map_add, x.property, h0, zero_add]⟩
  invFun a := ⟨a.val - a0, by
    change m (a.val - a0) = 0
    rw [map_sub, a.property, h0, sub_self]⟩
  left_inv x := by apply Subtype.ext; exact add_sub_cancel_right x.val a0
  right_inv a := by apply Subtype.ext; exact sub_add_cancel a.val a0

end Litt3.CartierAndSpin
