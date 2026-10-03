import Definitions.Deformations.ReciprocalCharacterSections

namespace Litt3.Deformations.Specifications

variable {k G : Type*} [Field k] [Group G]

def QuadraticCharacter (χ : G →* kˣ) : Prop := ∀ g, (χ g) ^ 2 = 1

end Litt3.Deformations.Specifications
