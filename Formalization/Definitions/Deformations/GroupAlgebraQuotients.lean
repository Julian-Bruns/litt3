import Definitions.Deformations.LeftPrincipalWidth
import Definitions.Deformations.GroupAlgebraAugmentation
import Definitions.Deformations.FilteredQuotients

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G H : Type*} [CommRing k] [Group G] [Group H]

/-- The genuine group-algebra map induced by a specified group
homomorphism. A geometric intermediate cover is not supplied by this definition. -/
noncomputable def groupAlgebraQuotientMap (φ : G →* H) : k[G] →ₐ[k] k[H] :=
  MonoidAlgebra.mapDomainAlgHom k k φ

end Litt3.Deformations

namespace Litt3.Deformations

open scoped MonoidAlgebra

variable {k G : Type*} [Field k] [Group G]

/-- An actual radical Hilbert window in the genuine group algebra. -/
noncomputable def groupRadicalHilbertWindow (lag i : ℕ) : ℕ :=
  ∑ j ∈ Finset.range lag, Module.finrank k
    (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := k[G])) (i + j))

end Litt3.Deformations
