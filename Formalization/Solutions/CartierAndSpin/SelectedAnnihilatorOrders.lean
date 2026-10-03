import Solutions.CartierAndSpin.SelectedPowerConstantOrder

namespace Litt3.CartierAndSpin

variable {k : Type*} [Field k]

/-- The selected annihilator and square-moment orders follow from the
actual order-two numerator and order-three factor. Zero numerators are
retained. -/
theorem selected_annihilator_and_square_orders (u phi : LaurentSeries k)
    (hu : (2 : WithTop ℤ) ≤ u.orderTop) (hphi : phi.orderTop = (3 : WithTop ℤ)) :
    (-1 : WithTop ℤ) ≤ (u / phi).orderTop ∧
    (1 : WithTop ℤ) ≤ (u ^ 2 / phi).orderTop := by
  constructor
  · have h := laurent_quotient_orderTop_bound u phi 2 3 hu hphi
    norm_num at h
    exact h
  · have h := laurent_square_quotient_orderTop_bound u phi 2 3 1 hu hphi
    simpa only [Nat.cast_one, mul_one, pow_one] using h

end Litt3.CartierAndSpin
