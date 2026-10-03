import Definitions.Jacobians.TorsionSeparation

namespace Litt3.Jacobians.Targets

/-- The order-four part of the Frobenius separation argument. It requires
no Tate module or characteristic assumption, and is not the all-orders
Boxall--Grant reduction. -/
def FourTorsionSeparation : Prop :=
  ∀ (A : Type) [AddCommGroup A] (W : Set A) (M U : A →+ A),
    TwoTorsionSeparated W → PreservesSubset M W → 0 ∈ W →
    Function.Injective U → (∀ a, M a - a = 2 • U a) →
    ∀ a ∈ W, 4 • a = 0 → a = 0

end Litt3.Jacobians.Targets
