import Solutions.CartierAndSpin.ConnectionLeibniz

namespace Litt3.CartierAndSpin

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-- The SAME actual normalized scalar connection and literal
multiplication by its parameter obey the Weyl relation, over arbitrary
commutative rings and in every characteristic. -/
theorem scalar_connection_weyl_relation
    (D : Derivation R A A) (t f : A) (hDt : D t = 1) :
    scalarDerivationConnection D f * LinearMap.mulLeft R t -
      LinearMap.mulLeft R t * scalarDerivationConnection D f = 1 := by
  ext a
  change scalarDerivationConnection D f (t * a) -
    t * scalarDerivationConnection D f a = a
  rw [scalar_connection_leibniz, hDt, one_mul, add_sub_cancel_right]

end Litt3.CartierAndSpin
