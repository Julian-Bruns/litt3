import Definitions.Deformations.GroupAlgebraInvariants

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k G M : Type*} [CommRing k] [Group G] [AddCommGroup M] [Module k[G] M]

def SimplePGroupModuleTrivial : Prop := ∀ g (m : M), MonoidAlgebra.of k G g • m = m

end Litt3.Deformations.Specifications
