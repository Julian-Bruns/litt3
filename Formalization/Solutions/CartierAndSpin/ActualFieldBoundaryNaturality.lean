import Definitions.CartierAndSpin.TwoEndpointFieldDiagrams
import Solutions.CartierAndSpin.ActualAlgebraDifferentialNaturality
import Solutions.CartierAndSpin.LogarithmicBoundaryNaturality
import Solutions.CartierAndSpin.ActualUnitTorsionLogarithms

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians

variable {k F G E F' G' E' : Type*}
  [Field k] [Field F] [Field G] [Field E] [Field F'] [Field G'] [Field E']
  [Algebra k F] [Algebra k G] [Algebra k E]
  [Algebra k F'] [Algebra k G'] [Algebra k E']
  [Algebra F E] [Algebra G E] [Algebra F' E'] [Algebra G' E']
  [IsScalarTower k F E] [IsScalarTower k G E]
  [IsScalarTower k F' E'] [IsScalarTower k G' E']

noncomputable def actualFieldDiagramPowerQuotientMap
    (d : TwoEndpointFieldDiagram k F G E F' G' E') (p : ℕ) :
    powerTorsionSubgroup (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p →+
      powerTorsionSubgroup (UnitRelationQuotient (algebraMap F' E') (algebraMap G' E')) p :=
  twoLegRelationPowerTorsionMap
    (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E))
    (rationalUnitPullback (algebraMap F' E')) (rationalUnitPullback (algebraMap G' E'))
    (rationalUnitPullback d.ambient.toRingHom)
    (rationalUnitPullback d.left.toRingHom) (rationalUnitPullback d.right.toRingHom)
    (actual_unit_pullback_diagram _ _ _ _ d.left_commutes)
    (actual_unit_pullback_diagram _ _ _ _ d.right_commutes) p

noncomputable def actualFieldDiagramSharedLogarithmicMap
    (d : TwoEndpointFieldDiagram k F G E F' G' E') :
    sharedLogarithmicImage (rationalLogarithmicDifferential k E)
      (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E)) →+
    sharedLogarithmicImage (rationalLogarithmicDifferential k E')
      (rationalUnitPullback (algebraMap F' E')) (rationalUnitPullback (algebraMap G' E')) :=
  sharedLogarithmicImageMap
    (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E))
    (rationalUnitPullback (algebraMap F' E')) (rationalUnitPullback (algebraMap G' E'))
    (rationalLogarithmicDifferential k E) (rationalLogarithmicDifferential k E')
    (rationalUnitPullback d.ambient.toRingHom)
    (rationalUnitPullback d.left.toRingHom) (rationalUnitPullback d.right.toRingHom)
    (actualAlgebraDifferentialMap d.ambient).toAddMonoidHom
    (actual_unit_pullback_diagram _ _ _ _ d.left_commutes)
    (actual_unit_pullback_diagram _ _ _ _ d.right_commutes)
    (actual_algebra_differential_map_logarithm d.ambient)

variable {p : ℕ} [Fact p.Prime] [CharP k p] [PerfectField k]

/-- The canonical actual field boundary needs only actual one-variable
ambient logarithmic-kernel exactness and literal endpoint constant
intersection. Endpoint separability/finite generation are unnecessary
for this WELL-DEFINED map, as opposed to its bijectivity. -/
noncomputable def actualUnitLogarithmicBoundary
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E)) :
    powerTorsionSubgroup (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p →+
    sharedLogarithmicImage (rationalLogarithmicDifferential k E)
      (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E)) := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  exact logarithmicBoundaryHom
    (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E))
    p (rationalLogarithmicDifferential k E)
    (fun u => one_variable_rational_logarithmic_kernel hfgE htrdegE u)
    (actual_common_endpoint_units_logarithmic_zero hinter)

/-- Naturality of the actual canonical field p-torsion boundary under
a literal diagram of BOTH endpoint fields and their COMMON ambient
field. Universal-differential and unit compatibility are proved from
the actual algebra homomorphisms, not supplied as extra hypotheses. -/
theorem actual_field_logarithmic_boundary_naturality
    (d : TwoEndpointFieldDiagram k F G E F' G' E')
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hfgE' : IntermediateField.FG (F := k) (E := E') ⊤)
    (htrdegE' : Algebra.trdeg k E' = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E))
    (hinter' : EndpointFieldIntersectionConstants (algebraMap k F') (algebraMap k G')
      (algebraMap F' E') (algebraMap G' E'))
    (q : powerTorsionSubgroup (UnitRelationQuotient (algebraMap F E) (algebraMap G E)) p) :
    actualFieldDiagramSharedLogarithmicMap d
        (actualUnitLogarithmicBoundary hfgE htrdegE hinter q) =
      actualUnitLogarithmicBoundary hfgE' htrdegE' hinter'
        (actualFieldDiagramPowerQuotientMap d p q) := by
  letI : CharP E p := charP_of_injective_algebraMap (algebraMap k E).injective p
  letI : CharP E' p := charP_of_injective_algebraMap (algebraMap k E').injective p
  exact actual_logarithmic_boundary_naturality
    (rationalUnitPullback (algebraMap F E)) (rationalUnitPullback (algebraMap G E))
    (rationalUnitPullback (algebraMap F' E')) (rationalUnitPullback (algebraMap G' E'))
    (rationalLogarithmicDifferential k E) (rationalLogarithmicDifferential k E')
    (rationalUnitPullback d.ambient.toRingHom)
    (rationalUnitPullback d.left.toRingHom) (rationalUnitPullback d.right.toRingHom)
    (actualAlgebraDifferentialMap d.ambient).toAddMonoidHom
    (actual_unit_pullback_diagram _ _ _ _ d.left_commutes)
    (actual_unit_pullback_diagram _ _ _ _ d.right_commutes)
    (actual_algebra_differential_map_logarithm d.ambient) p
    (fun u => one_variable_rational_logarithmic_kernel hfgE htrdegE u)
    (actual_common_endpoint_units_logarithmic_zero hinter)
    (fun u => one_variable_rational_logarithmic_kernel hfgE' htrdegE' u)
    (actual_common_endpoint_units_logarithmic_zero hinter') q

/-- With the additional endpoint hypotheses for bijectivity, the map
just constructed is literally the already proved canonical actual
unit-quotient/logarithmic-image equivalence. -/
theorem actual_unit_logarithmic_boundary_eq_equiv
    [Algebra.IsSeparable F E] [Algebra.IsSeparable G E]
    (hfgF : IntermediateField.FG (F := k) (E := F) ⊤)
    (htrdegF : Algebra.trdeg k F = 1)
    (hfgG : IntermediateField.FG (F := k) (E := G) ⊤)
    (htrdegG : Algebra.trdeg k G = 1)
    (hfgE : IntermediateField.FG (F := k) (E := E) ⊤)
    (htrdegE : Algebra.trdeg k E = 1)
    (hinter : EndpointFieldIntersectionConstants (algebraMap k F) (algebraMap k G)
      (algebraMap F E) (algebraMap G E)) :
    actualUnitLogarithmicBoundary (p := p) hfgE htrdegE hinter =
      (actual_unit_quotient_p_torsion_logarithmic_equiv
        hfgF htrdegF hfgG htrdegG hfgE htrdegE hinter).toAddMonoidHom := rfl

end Litt3.CartierAndSpin
