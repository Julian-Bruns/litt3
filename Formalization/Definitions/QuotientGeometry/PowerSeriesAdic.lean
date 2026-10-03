import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.AdicCompletion.Basic

namespace Litt3.QuotientGeometry

def powerSeriesParameterIdeal (R : Type*) [CommRing R] : Ideal (PowerSeries R) :=
  Ideal.span {PowerSeries.X}

end Litt3.QuotientGeometry
