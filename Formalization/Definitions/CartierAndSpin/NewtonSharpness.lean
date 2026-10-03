import Definitions.CartierAndSpin.CohortPowerSums

namespace Litt3.CartierAndSpin

variable {K : Type*} [Field K]

/-- The actual p equal poles, p equal reciprocal zeros and r unit entries.
This tuple will prove that the characteristic carry cannot be omitted. -/
def carryOmissionTuple (p r : ℕ) (t : K) : Fin p ⊕ (Fin p ⊕ Fin r) → K :=
  Sum.elim (fun _ => t) (Sum.elim (fun _ => t⁻¹) (fun _ => 1))

/-- A q-root orbit of poles, p equal zeros and m extra unit entries. For
q=p+i and m=r-i this isolates the single higher trace P_q. -/
def traceOmissionTuple (p q m : ℕ) (zeta t : K) : Fin q ⊕ (Fin p ⊕ Fin m) → K :=
  Sum.elim (fun j => zeta ^ (j : ℕ) * t ^ p)
    (Sum.elim (fun _ => (t⁻¹) ^ q) (fun _ => 1))

end Litt3.CartierAndSpin
