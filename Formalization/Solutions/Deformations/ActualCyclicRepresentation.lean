import Theorems.Deformations.ActualCyclicRepresentation

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [Invertible (2 : k)] [AddCommGroup V] [Module k V]

/-- The pulled actual truncated action agrees with the
original coefficient-field action, so scalar restrictions
retain its specified section-module vector structure. -/
theorem cyclic_representation_scalar_tower (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V) :
    letI := cyclicRepresentationTruncatedModule p a ρ
    IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) V := by
  letI := cyclicRepresentationTruncatedModule p a ρ
  apply IsScalarTower.of_algebraMap_smul
  intro c x
  change (cyclicRepresentationTruncatedAction p a ρ
    (algebraMap k (TruncatedCoefficientRing k (p ^ a)) c)) x = c • x
  rw [(cyclicRepresentationTruncatedAction p a ρ).commutes]
  rfl

/-- The original specified cyclic deck representation is
recovered exactly from its actual truncated module; no
new or weakened deck action replaces the original one. -/
theorem actual_cyclic_representation_restored (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V) :
    Specifications.ActualCyclicRepresentationRestored p a ρ := by
  letI := cyclicRepresentationTruncatedModule p a ρ
  intro g x
  change (cyclicRepresentationTruncatedAction p a ρ
    ((cyclicSkewAlgebraEquiv (k := k) p a).symm
      (AddMonoidAlgebra.single g.toAdd 1))) x = ρ g x
  unfold cyclicRepresentationTruncatedAction
  change ρ.asAlgebraHom
    (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := k) k (ZMod (p ^ a))
      (cyclicSkewAlgebraEquiv (k := k) p a
        ((cyclicSkewAlgebraEquiv (k := k) p a).symm
          (AddMonoidAlgebra.single g.toAdd 1)))) x = _
  rw [AlgEquiv.apply_symm_apply]
  have single : AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := k) k (ZMod (p ^ a))
      (AddMonoidAlgebra.single g.toAdd 1) = MonoidAlgebra.single g 1 := by
    change Finsupp.equivMapDomain Multiplicative.ofAdd
      (Finsupp.single g.toAdd (1 : k)) = Finsupp.single g 1
    rw [Finsupp.equivMapDomain_single]
    rfl
  rw [single]
  rw [Representation.asAlgebraHom_single_one]

end Litt3.Deformations
