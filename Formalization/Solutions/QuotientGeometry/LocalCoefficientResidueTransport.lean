import Mathlib.RingTheory.LocalRing.ResidueField.Basic

namespace Litt3.QuotientGeometry

variable {k R S : Type*} [Field k] [CommRing R] [CommRing S]
  [IsLocalRing R] [IsLocalRing S] [Algebra k R] [Algebra k S]

/-- A genuine coefficient-algebra equivalence of the original local
rings transports coefficient surjectivity on their actual residue
fields; the coefficient compatibility is derived. -/
theorem actual_local_algEquiv_residue_coefficients_surjective
    (e : R ≃ₐ[k] S)
    (hS : Function.Surjective (algebraMap k (IsLocalRing.ResidueField S))) :
    Function.Surjective (algebraMap k (IsLocalRing.ResidueField R)) := by
  letI : IsLocalHom e.toRingHom := ⟨fun r hr => (MulEquiv.isUnit_map e).mp hr⟩
  let eκ := IsLocalRing.ResidueField.mapEquiv e.toRingEquiv
  have hec (c : k) : eκ (algebraMap k (IsLocalRing.ResidueField R) c) =
      algebraMap k (IsLocalRing.ResidueField S) c := by
    rw [IsScalarTower.algebraMap_apply k R (IsLocalRing.ResidueField R),
      IsScalarTower.algebraMap_apply k S (IsLocalRing.ResidueField S)]
    change IsLocalRing.ResidueField.map e.toRingHom
      (IsLocalRing.residue R (algebraMap k R c)) =
        IsLocalRing.residue S (algebraMap k S c)
    rw [IsLocalRing.ResidueField.map_residue]
    change IsLocalRing.residue S (e (algebraMap k R c)) =
      IsLocalRing.residue S (algebraMap k S c)
    rw [e.commutes]
  intro a
  obtain ⟨c, hc⟩ := hS (eκ a)
  exact ⟨c, eκ.injective ((hec c).trans hc)⟩

end Litt3.QuotientGeometry
