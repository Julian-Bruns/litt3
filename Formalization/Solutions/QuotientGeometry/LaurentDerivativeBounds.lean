import Solutions.QuotientGeometry.WeakLaurentNormalForm

namespace Litt3.QuotientGeometry

theorem laurent_orderTop_lower_bound_of_coefficients
    {k : Type*} [Field k] (f : LaurentSeries k) (m : ℤ)
    (hcoeff : ∀ n : ℤ, n < m → f.coeff n = 0) :
    (m : WithTop ℤ) ≤ f.orderTop := by
  by_cases hf : f = 0
  · simp [hf]
  rw [← HahnSeries.order_eq_orderTop_of_ne_zero hf]
  apply WithTop.coe_le_coe.mpr
  by_contra h
  exact HahnSeries.coeff_order_ne_zero hf (hcoeff f.order (lt_of_not_ge h))

/-- The actual derivative loses at most one order. The orderTop statement
includes a zero derivative, whose order is infinity. -/
theorem laurent_derivative_orderTop_bound
    {k : Type*} [Field k] (f : LaurentSeries k) (m : ℤ)
    (hf : (m : WithTop ℤ) ≤ f.orderTop) :
    ((m - 1 : ℤ) : WithTop ℤ) ≤ (LaurentSeries.derivative k f).orderTop := by
  apply laurent_orderTop_lower_bound_of_coefficients
  intro n hn
  have hlt : ((n + 1 : ℤ) : WithTop ℤ) < f.orderTop :=
    lt_of_lt_of_le (WithTop.coe_lt_coe.mpr (by omega)) hf
  have hcoeff : f.coeff (n + 1) = 0 := HahnSeries.coeff_eq_zero_of_lt_orderTop hlt
  have he := laurent_derivative_coefficient f (n + 1)
  simpa [hcoeff] using he

theorem laurent_derivative_pole_bound
    {k : Type*} [Field k] (f : LaurentSeries k) (m : ℕ)
    (hf : ((-(m : ℤ)) : WithTop ℤ) ≤ f.orderTop) :
    ((-((m + 1 : ℕ) : ℤ)) : WithTop ℤ) ≤ (LaurentSeries.derivative k f).orderTop := by
  have he : -((m + 1 : ℕ) : ℤ) = -(m : ℤ) - 1 := by omega
  have heTop : -(((m + 1 : ℕ) : ℤ) : WithTop ℤ) = ((-(m : ℤ) - 1 : ℤ) : WithTop ℤ) := by
    exact_mod_cast he
  rw [heTop]
  exact laurent_derivative_orderTop_bound f (-(m : ℤ)) hf

end Litt3.QuotientGeometry
