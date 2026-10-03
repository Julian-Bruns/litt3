import Solutions.Deformations.GroupCoefficientFrobenius
import Solutions.Deformations.TruncatedWittResidue

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p]

/-- The actual original coefficient-reduction/Frobenius square
commutes on the full genuine elementary group algebra. -/
theorem elementary_witt_frobenius_residue (r : ℕ)
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) (truncatedWittResidue p N positive k)
      (elementaryWittFrobenius p N r k x) =
    groupCoefficientEquiv (G := Fin r → ZMod p) (_root_.frobeniusEquiv k p)
      (AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p) (truncatedWittResidue p N positive k) x) := by
  ext g
  simp only [AddMonoidAlgebra.mapRangeRingHom_apply, group_coefficient_equiv_apply,
    truncated_witt_residue_coeff, elementary_witt_frobenius_coefficient,
    _root_.frobeniusEquiv_apply, _root_.frobenius_def]

end Litt3.Deformations
