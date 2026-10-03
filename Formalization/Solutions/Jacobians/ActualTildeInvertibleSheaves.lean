import Solutions.Jacobians.ActualTildeLocalIsomorphisms

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R] (M : ModuleCat.{u} R) [Module.Invertible R M]

/-- Genuine original pairing maps trivialize the ACTUAL associated SHEAF over
the actual open site where their pairing is invertible. -/
noncomputable def actualTildePairingTrivialization (m : M) (g : Module.Dual R M) :
    M.tilde.over (PrimeSpectrum.basicOpen (g m)) ≅
      (SheafOfModules.unit (Spec (.of R)).ringCatSheaf).over
        (PrimeSpectrum.basicOpen (g m)) := by
  let f : M ⟶ ModuleCat.of R R := ModuleCat.ofHom g
  let h : ModuleCat.of R R ⟶ M :=
    ModuleCat.ofHom (LinearMap.toSpanSingleton R M m)
  have hfh : f ≫ h = ModuleCat.ofHom (g m • (LinearMap.id : M →ₗ[R] M)) := by
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro a
    exact original_invertible_functional_interchange g a m
  have hhf : h ≫ f = ModuleCat.ofHom
      (g m • (LinearMap.id : R →ₗ[R] R)) := by
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro a
    change g (a • m) = g m * a
    rw [g.map_smul, smul_eq_mul, mul_comm]
  exact actualTildeBasicOpenIso f h (g m) hfh hhf ≪≫
    (actualSheafOverFunctor (R := R) (PrimeSpectrum.basicOpen (g m))).mapIso
      (actualTildeUnitIso R)

/-- Every original prime has a true basic-open neighborhood on whose ENTIRE
actual restricted open site the associated sheaf is the actual rank-one unit
sheaf. No localized module frame, sheaf frame or pairing is supplied. -/
theorem actual_invertible_module_sheaf_locally_trivial (x : PrimeSpectrum R) :
    ∃ r : R, x ∈ PrimeSpectrum.basicOpen r ∧ Nonempty
      (M.tilde.over (PrimeSpectrum.basicOpen r) ≅
        (SheafOfModules.unit (Spec (.of R)).ringCatSheaf).over
          (PrimeSpectrum.basicOpen r)) := by
  obtain ⟨m, g, hg⟩ := original_invertible_pairing_outside_prime (M := M) x.asIdeal
  exact ⟨g m, hg, ⟨actualTildePairingTrivialization M m g⟩⟩

end Litt3.Jacobians
