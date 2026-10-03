import Solutions.Deformations.ElementaryPrimeWittInitialCoordinates

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The literal actual prime-multiple submodule of the original group
algebra, with no coefficient-reduction substitute. -/
noncomputable def elementaryPrimeWittPrimeSpace (r : ℕ) :
    Submodule (TruncatedWittVector p N k)
      (AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :=
  LinearMap.range ((p : TruncatedWittVector p N k) • LinearMap.id)

/-- The actual canonical permitted repair space p Lambda + W((p-1)r). -/
noncomputable def elementaryPrimeWittRepairSpace (r : ℕ) :
    Submodule (TruncatedWittVector p N k)
      (AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :=
  elementaryPrimeWittPrimeSpace p N k r ⊔
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (by have := (Fact.out : p.Prime).two_le; omega) r ((p - 1) * r)

end Litt3.Deformations
