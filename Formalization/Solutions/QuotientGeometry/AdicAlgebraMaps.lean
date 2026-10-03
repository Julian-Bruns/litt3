import Solutions.QuotientGeometry.AdicRingMaps

namespace Litt3.QuotientGeometry

variable {k R S T : Type*} [CommRing k] [CommRing R] [CommRing S] [CommRing T]
  [Algebra k R] [Algebra k S] [Algebra k T]

def adicAlgMap (I : Ideal R) (J : Ideal S) (φ : R →ₐ[k] S)
    (hφ : I.map φ.toRingHom ≤ J) :
    AdicCompletion I R →ₐ[k] AdicCompletion J S :=
  { adicRingMap I J φ.toRingHom hφ with
    commutes' := by
      intro c
      apply AdicCompletion.ext
      intro n
      change Ideal.Quotient.mk _ (φ (algebraMap k R c)) =
        Ideal.Quotient.mk _ (algebraMap k S c)
      rw [φ.commutes] }

@[simp] theorem adicAlgMap_of
    (I : Ideal R) (J : Ideal S) (φ : R →ₐ[k] S)
    (hφ : I.map φ.toRingHom ≤ J) (r : R) :
    adicAlgMap I J φ hφ (AdicCompletion.of I R r) = AdicCompletion.of J S (φ r) :=
  adicRingMap_of I J φ.toRingHom hφ r

theorem adicAlgMap_comp
    (I : Ideal R) (J : Ideal S) (K : Ideal T)
    (φ : R →ₐ[k] S) (ψ : S →ₐ[k] T)
    (hφ : I.map φ.toRingHom ≤ J) (hψ : J.map ψ.toRingHom ≤ K) :
    (adicAlgMap J K ψ hψ).comp (adicAlgMap I J φ hφ) =
      adicAlgMap I K (ψ.comp φ)
        (by change I.map (ψ.toRingHom.comp φ.toRingHom) ≤ K
            rw [← Ideal.map_map];
            exact (Ideal.map_mono hφ).trans hψ) := by
  apply AlgHom.ext
  intro x
  exact RingHom.congr_fun (adicRingMap_comp I J K φ.toRingHom ψ.toRingHom hφ hψ) x

end Litt3.QuotientGeometry
