import Solutions.CartierAndSpin.ConnectionLeibniz

namespace Litt3.CartierAndSpin

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- Genuine multiplication by a unit intertwines the two actual
connections, when its literal derivative has the required value. -/
theorem scalar_connection_unit_gauge
    (D : Derivation R A A) (f g : A) (u : Aˣ)
    (hu : D (u : A) = (f - g) * (u : A)) (x : A) :
    scalarDerivationConnection D f ((u : A) * x) =
      (u : A) * scalarDerivationConnection D g x := by
  rw [scalar_connection_leibniz, hu]
  change (f - g) * (u : A) * x + (u : A) * (D x - f * x) =
    (u : A) * (D x - g * x)
  ring

theorem scalar_connection_unit_gauge_iterate
    (D : Derivation R A A) (f g : A) (u : Aˣ)
    (hu : D (u : A) = (f - g) * (u : A)) (x : A) (n : ℕ) :
    (scalarDerivationConnection D f)^[n] ((u : A) * x) =
      (u : A) * (scalarDerivationConnection D g)^[n] x := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih, scalar_connection_unit_gauge D f g u hu,
      Function.iterate_succ_apply']

end Litt3.CartierAndSpin
