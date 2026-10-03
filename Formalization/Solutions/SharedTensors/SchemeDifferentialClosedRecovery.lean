import Solutions.SharedTensors.SchemeDifferentialGlobalRecovery
import Solutions.SharedTensors.ClosedPointSurjectivity
import Solutions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]

/-- Regularity of a literal rational differential is an OPEN condition.
An actual original stalk lift supplies an actual presheaf section on an
original open neighborhood, whose germs witness regularity throughout it.
No smoothness or finite generation is required. -/
theorem schemeDifferential_regular_locus_isOpen
    (sX : X ⟶ Spec (.of k)) :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      IsOpen {x : X | omega ∈ schemeLocalRegularDifferentials sX x} := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  rw [isOpen_iff_mem_nhds]
  intro x hx
  obtain ⟨U, hxU, a, ha⟩ :=
    schemeLocalRegularDifferential_open_lift sX x omega hx
  letI : Nonempty U := ⟨⟨x, hxU⟩⟩
  apply Filter.mem_of_superset (U.isOpen.mem_nhds hxU)
  intro y hy
  rw [← ha]
  exact schemeDifferentialOpenToFunctionField_mem_local sX U ⟨y, hy⟩ a

/-- On any original integral Jacobson scheme, checking EVERY original
closed-point differential image checks EVERY point. The proof uses the
actual open regularity locus, not a supplied closed-support assertion. -/
theorem schemeDifferential_closed_regular_iff_all_stalks
    (sX : X ⟶ Spec (.of k)) [JacobsonSpace X] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ∈ schemeGlobalRegularDifferentials sX ↔
        ∀ x : X, omega ∈ schemeLocalRegularDifferentials sX x := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega
  rw [mem_schemeGlobalRegularDifferentials_iff]
  constructor
  · intro hclosed x
    by_contra hx
    have hopen := schemeDifferential_regular_locus_isOpen sX omega
    obtain ⟨y, hy, hyclosed⟩ := nonempty_inter_closedPoints
      (show ({z : X | omega ∈ schemeLocalRegularDifferentials sX z}ᶜ).Nonempty
        from ⟨x, hx⟩) hopen.isClosed_compl.isLocallyClosed
    exact hy (hclosed ⟨y, hyclosed⟩)
  · intro hall x
    exact hall x.val

noncomputable local instance closedRecoveryTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

/-- The literal original closed-stalk intersection is the exact rational
image of ACTUAL global differential SHEAF sections on any integral smooth
scheme over a field, of ANY relative dimension. No properness, genus,
algebraic closure, characteristic or H0 identification is assumed. -/
theorem schemeDifferential_closed_regular_iff_global_section
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ omega : KaehlerDifferential k X.functionField,
      omega ∈ schemeGlobalRegularDifferentials sX ↔
      ∃ a : schemeDifferentialGlobalSections sX,
        schemeDifferentialSheafOpenToFunctionField sX ⊤ a = omega := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth n sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  intro omega
  exact (schemeDifferential_closed_regular_iff_all_stalks sX omega).trans
    (schemeDifferential_regular_everywhere_iff_global_section sX n omega)

theorem schemeDifferentialGlobalSections_range_closed_stalks
    (sX : X ⟶ Spec (.of k)) (n : ℕ) [IsSmoothOfRelativeDimension n sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    Set.range (schemeDifferentialSheafOpenToFunctionField sX ⊤) =
      (schemeGlobalRegularDifferentials sX : Set (KaehlerDifferential k X.functionField)) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  ext omega
  exact (schemeDifferential_closed_regular_iff_global_section sX n omega).symm

end Litt3.SharedTensors
