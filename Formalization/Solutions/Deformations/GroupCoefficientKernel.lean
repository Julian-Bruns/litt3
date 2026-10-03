import Solutions.Deformations.TruncatedWittResidue
import Mathlib.Algebra.MonoidAlgebra.Basic
import Mathlib.Data.Finsupp.Fintype

namespace Litt3.Deformations

variable {R S G : Type*} [CommRing R] [CommRing S] [AddCommMonoid G] [Fintype G]

/-- Literal coefficient reduction of a finite group algebra has exactly
the same principal scalar kernel as its actual coefficient map. -/
theorem group_coefficient_principal_kernel (φ : R →+* S) (a : R)
    (kernel : ∀ c, φ c = 0 ↔ ∃ z : R, a * z = c)
    (x : AddMonoidAlgebra R G) :
    AddMonoidAlgebra.mapRangeRingHom G φ x = 0 ↔
      ∃ z : AddMonoidAlgebra R G, a • z = x := by
  classical
  constructor
  · intro zero
    have coefficients : ∀ g, ∃ z : R, a * z = x g := by
      intro g
      apply (kernel (x g)).mp
      have coordinate := congrArg (fun y : AddMonoidAlgebra S G => y g) zero
      simpa only [AddMonoidAlgebra.mapRangeRingHom_apply, Finsupp.zero_apply] using coordinate
    choose z relation using coefficients
    refine ⟨(Finsupp.equivFunOnFinite : (G →₀ R) ≃ (G → R)).symm z, ?_⟩
    ext g
    change a * ((Finsupp.equivFunOnFinite : (G →₀ R) ≃ (G → R)).symm z) g = x g
    simpa using relation g
  · rintro ⟨z, rfl⟩
    have scalarZero : φ a = 0 := (kernel a).mpr ⟨1, mul_one a⟩
    ext g
    rw [AddMonoidAlgebra.mapRangeRingHom_apply]
    change φ (a * z g) = 0
    rw [map_mul, scalarZero, zero_mul]

/-- Actual positive-precision Witt residue on the full finite group
algebra has precisely the literal original prime-multiple kernel. -/
theorem truncated_witt_group_residue_kernel (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] [CharP k p] [PerfectRing k p]
    (G : Type*) [AddCommMonoid G] [Fintype G]
    (x : AddMonoidAlgebra (TruncatedWittVector p N k) G) :
    AddMonoidAlgebra.mapRangeRingHom G (truncatedWittResidue p N positive k) x = 0 ↔
      ∃ z : AddMonoidAlgebra (TruncatedWittVector p N k) G,
        (p : AddMonoidAlgebra (TruncatedWittVector p N k) G) * z = x := by
  have kernel : ∀ c : TruncatedWittVector p N k,
      truncatedWittResidue p N positive k c = 0 ↔
        ∃ z : TruncatedWittVector p N k, (p : TruncatedWittVector p N k) * z = c := by
    intro c
    rw [truncated_witt_residue_kernel]
    constructor
    · rintro ⟨z, relation⟩
      refine ⟨z, ?_⟩
      have scalar := truncated_witt_scalar_power_smul p N 1 k z
      simp only [pow_one] at scalar
      exact scalar.symm.trans relation
    · rintro ⟨z, relation⟩
      refine ⟨z, ?_⟩
      have scalar := truncated_witt_scalar_power_smul p N 1 k z
      simp only [pow_one] at scalar
      exact scalar.trans relation
  have group := group_coefficient_principal_kernel (G := G)
    (truncatedWittResidue p N positive k) (p : TruncatedWittVector p N k) kernel x
  simpa only [Algebra.smul_def, map_natCast] using group

end Litt3.Deformations
