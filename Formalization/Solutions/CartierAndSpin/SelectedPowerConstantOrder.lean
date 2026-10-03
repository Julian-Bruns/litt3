import Solutions.CartierAndSpin.CriticalDerivativeWeights

namespace Litt3.CartierAndSpin

open Polynomial

variable {k : Type*} [Field k]

/-- A selected root whose power has strictly higher order than the
actual factor value determines the factor's constant order exactly. -/
theorem selected_power_factor_constant_order (q node : LaurentSeries k)
    (p : ℕ) (c contact : ℤ)
    (hnode : (contact : WithTop ℤ) ≤ node.orderTop)
    (hstrict : c < (p : ℤ) * contact)
    (hvalue : (node ^ p + q).orderTop = (c : WithTop ℤ)) :
    q.orderTop = (c : WithTop ℤ) := by
  have hpower := laurent_orderTop_power_bound node contact p hnode
  have hlt : (node ^ p + q).orderTop < (node ^ p).orderTop := by
    rw [hvalue]
    exact lt_of_lt_of_le (WithTop.coe_lt_coe.mpr hstrict) hpower
  have h := HahnSeries.orderTop_sub hlt
  have heq : node ^ p + q - node ^ p = q := by ring
  rwa [heq, hvalue] at h

/-- The canonical order-three constant is derived from the actual
selected factor value, with arbitrary contact at least one. -/
theorem selected_fifth_power_factor_constant_order (q node : LaurentSeries k)
    (contact : ℤ) (hcontact : 1 ≤ contact)
    (hnode : (contact : WithTop ℤ) ≤ node.orderTop)
    (hvalue : (node ^ 5 + q).orderTop = (3 : WithTop ℤ)) :
    q.orderTop = (3 : WithTop ℤ) :=
  selected_power_factor_constant_order q node 5 3 contact hnode (by norm_num; omega) hvalue

end Litt3.CartierAndSpin
