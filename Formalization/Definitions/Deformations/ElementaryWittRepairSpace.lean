import Solutions.Deformations.ElementaryWittInitialCoordinates

namespace Litt3.Deformations

variable (N : ℕ) [Fact (0 < N)]
variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- The literal actual prime-multiple submodule of the original group
algebra, with no coefficient-reduction substitute. -/
noncomputable def elementaryWittPrimeSpace (r : ℕ) :
    Submodule (TruncatedWittVector 5 N k)
      (AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :=
  LinearMap.range ((5 : TruncatedWittVector 5 N k) • LinearMap.id)

/-- The actual canonical permitted repair space 5Lambda+W4r. -/
noncomputable def elementaryWittRepairSpace (r : ℕ) :
    Submodule (TruncatedWittVector 5 N k)
      (AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) :=
  elementaryWittPrimeSpace N k r ⊔
    elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * r)

end Litt3.Deformations
