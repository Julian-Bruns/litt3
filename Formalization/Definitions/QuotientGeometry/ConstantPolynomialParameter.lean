import Definitions.QuotientGeometry.ConstantPolePolynomial

namespace Litt3.QuotientGeometry

noncomputable def constantPolynomialUnit {k : Type*} [Field k] (g : Polynomial k) : PowerSeries k :=
  g.reverse.eval₂ PowerSeries.C PowerSeries.X

noncomputable def constantPolynomialParameter {k : Type*} [Field k] (g : Polynomial k) : PowerSeries k :=
  PowerSeries.X ^ g.natDegree * (constantPolynomialUnit g)⁻¹

end Litt3.QuotientGeometry
