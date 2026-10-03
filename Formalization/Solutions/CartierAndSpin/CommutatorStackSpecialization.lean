import Definitions.CartierAndSpin.PowerCommutatorStacks

namespace Litt3.CartierAndSpin

variable {R S n : Type*} [CommRing R] [CommRing S] [Fintype n] [DecidableEq n]

/-- The literal ordered stack commutes with every coefficient-ring
specialization, retaining all geometric fibers. -/
theorem ordered_commutator_stack_map (f : R →+* S) (U V : Matrix n n R) (d : ℕ) :
    (orderedCommutatorStack U V d).map f =
      orderedCommutatorStack (U.map f) (V.map f) d := by
  ext i j
  have h : f.mapMatrix ((U * V - V * U) * U ^ i.1.1.val * V ^ i.1.2.val) =
      (f.mapMatrix U * f.mapMatrix V - f.mapMatrix V * f.mapMatrix U) *
        (f.mapMatrix U) ^ i.1.1.val * (f.mapMatrix V) ^ i.1.2.val := by
    simp only [map_mul, map_sub, map_pow]
  exact congrFun (congrFun h i.2) j

theorem power_commutator_stack_map (f : R →+* S) (U V : Matrix n n R) :
    (powerCommutatorStack U V).map f = powerCommutatorStack (U.map f) (V.map f) := by
  ext i j
  have h : f.mapMatrix (U ^ (i.1.1.val + 1) * V ^ (i.1.2.val + 1) -
        V ^ (i.1.2.val + 1) * U ^ (i.1.1.val + 1)) =
      (f.mapMatrix U) ^ (i.1.1.val + 1) * (f.mapMatrix V) ^ (i.1.2.val + 1) -
        (f.mapMatrix V) ^ (i.1.2.val + 1) * (f.mapMatrix U) ^ (i.1.1.val + 1) := by
    simp only [map_mul, map_sub, map_pow]
  exact congrFun (congrFun h i.2) j

end Litt3.CartierAndSpin
