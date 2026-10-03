import Solutions.Jacobians.DedekindTransport
import Solutions.Jacobians.SchemeFiniteSupport
import Mathlib.AlgebraicGeometry.AffineScheme

open AlgebraicGeometry CategoryTheory CategoryTheory.Iso

namespace Litt3.Jacobians

theorem dedekind_spec_global_sections
    (R : Type*) [CommRing R] [IsDedekindDomain R] :
    IsDedekindDomain Γ(Spec (CommRingCat.of R), ⊤) :=
  dedekind_domain_of_ring_equiv
    (commRingCatIsoToRingEquiv (Scheme.ΓSpecIso (CommRingCat.of R))).symm

theorem dedekind_spec_global_sections_not_isField
    (R : Type*) [CommRing R] (hR : ¬IsField R) :
    ¬IsField Γ(Spec (CommRingCat.of R), ⊤) := by
  intro hfield
  exact hR (MulEquiv.isField hfield
    (commRingCatIsoToRingEquiv (Scheme.ΓSpecIso (CommRingCat.of R))).symm.toMulEquiv)

theorem dedekind_spec_dvr_stalks
    (R : Type*) [CommRing R] [IsDedekindDomain R] (hR : ¬IsField R) :
    ClosedPointDVRStalks (Spec (CommRingCat.of R)) := by
  let U : Unit → (Spec (CommRingCat.of R)).Opens := fun _ => ⊤
  exact @closed_point_dvr_stalks_of_dedekind_cover (Spec (CommRingCat.of R))
    inferInstance Unit U (fun _ => isAffineOpen_top _)
    (fun _ => dedekind_spec_global_sections R)
    (fun _ => dedekind_spec_global_sections_not_isField R hR)
    (fun _ => ⟨(), trivial⟩)

theorem dedekind_spec_finite_principal_support
    (R : Type*) [CommRing R] [IsDedekindDomain R] (hR : ¬IsField R)
    [ClosedPointDVRStalks (Spec (CommRingCat.of R))] :
    FinitePrincipalSupport (Spec (CommRingCat.of R)) := by
  let U : Unit → (Spec (CommRingCat.of R)).Opens := fun _ => ⊤
  exact @finite_principal_support_of_dedekind_cover (Spec (CommRingCat.of R))
    inferInstance inferInstance Unit inferInstance U (fun _ => isAffineOpen_top _)
    (fun _ => dedekind_spec_global_sections R) (fun _ => ⟨⟨genericPoint _, trivial⟩⟩)
    (fun _ => dedekind_spec_global_sections_not_isField R hR)
    (fun _ => ⟨(), trivial⟩)

end Litt3.Jacobians
