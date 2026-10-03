import Solutions.CartierAndSpin.SourceTraceDescent
import Solutions.CartierAndSpin.UnsplitSourceEnergy
import Solutions.CartierAndSpin.SourceTensorConsequences
import Solutions.CartierAndSpin.SourceTensorCenteredFormula
import Solutions.CartierAndSpin.SourceTensorAffineWeights
import Solutions.CartierAndSpin.SourceQuotientMomentTranslation
import Solutions.CartierAndSpin.CharacteristicFiveMomentInvariant
import Solutions.CartierAndSpin.SourceQuotientFiveInvariant
import Solutions.CartierAndSpin.DegreeTwoPSource
import Solutions.CartierAndSpin.AffineSourceRemainder
import Solutions.CartierAndSpin.SourceTensorAffineCorrections
import Solutions.CartierAndSpin.CharacteristicFiveTensorCorrections
import Solutions.CartierAndSpin.SourceTensorInvariance
import Solutions.CartierAndSpin.LaurentQuotientEndpoint
import Solutions.CartierAndSpin.LaurentEndpointJets
import Solutions.CartierAndSpin.ConstantSourceTranslation
import Solutions.CartierAndSpin.ActualSourceSubringIntegrality
import Solutions.CartierAndSpin.SourceBoundaryQuotientIntegrality
import Solutions.CartierAndSpin.ActualSourceUnitMomentIntegrality
import Solutions.CartierAndSpin.SourceTensorFrameIndependence
import Solutions.CartierAndSpin.SourceSeparatingFunctionTensors
import Solutions.CartierAndSpin.OneVariableSourceTensors

namespace Litt3.CartierAndSpin.Specifications

universe u v w

open Polynomial Finset Lagrange Litt3.SharedTensors

/-- Literal quantified clause: `source_coefficient_moments`. -/
def SourceCoefficientMomentsClause : Prop :=
  ∀ {K : Type u} [Field K]
    (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau : K) (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hseparable : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ j < p,
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F)) = 0 ∧
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j *
          (↑unit⁻¹ : AdjoinRoot F) ^ 2) =
            (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau

/-- Literal quantified clause: `sourceQuotientDifferentialCalculus`. -/
def SourceDifferentialMomentsAndSquaresClause : Prop :=
  ∀ {R : Type u} {K : Type v} [CommRing R] [Field K] [Algebra R K]
    (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K),
    Specifications.SourceQuotientDifferentialCalculus D F H p q tau

/-- Literal quantified clause: `source_universal_tensor_calculus`. -/
def SourceUniversalMomentsAndSquaresClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (hs : F.Separable),
    Specifications.SourceUniversalTensorCalculus F H p q tau e hs

/-- Literal quantified clause: `source_universal_centered_formula`. -/
def SourceCenteredFormulaClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0),
    let s := (H %ₘ (X ^ p + C q)).coeff (p - 1)
    let c := (H %ₘ (X ^ p + C q)).coeff (p - 2)
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      sourceUniversalCenteredEnergy F hsep e unit (c / s) =
        sourceUniversalSymmetricEnergy F hsep e unit - (2 / tau : K) •
          rationalSymmetricProduct K (KaehlerDifferential k K) (KaehlerDifferential.D k K q)
            (KaehlerDifferential.D k K c - (c / s) • KaehlerDifferential.D k K s) ∧
      sourceUniversalClearedEnergy F hsep e unit q tau s c =
        s • sourceUniversalCenteredEnergy F hsep e unit (c / s)

/-- Literal quantified clause: `source_universal_centered_affine_weight`. -/
def SourceCenteredAffineWeightClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let S' := H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalCenteredEnergy F' (affine_source_frame_separable F hsep a b N ha)
          e unit' (S'.coeff (p - 2) / S'.coeff (p - 1)) =
          a ^ ((2 : ℤ) - (p : ℤ)) • sourceUniversalCenteredEnergy F hsep e unit
            ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
              (H %ₘ (X ^ p + C q)).coeff (p - 1))

/-- Literal quantified clause: `source_universal_cleared_affine_weight`. -/
def SourceClearedAffineWeightClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let S' := H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalClearedEnergy F' (affine_source_frame_separable F hsep a b N ha)
          e unit' (a ^ p * q - b ^ p) (a ^ N * tau) (S'.coeff (p - 1)) (S'.coeff (p - 2)) =
          a ^ ((N : ℤ) - 3 * (p : ℤ) + 3) • sourceUniversalClearedEnergy F hsep e unit
            q tau ((H %ₘ (X ^ p + C q)).coeff (p - 1))
              ((H %ₘ (X ^ p + C q)).coeff (p - 2))

/-- Literal quantified clause: `source_universal_cleared_zero`. -/
def SourceClearedBoundaryZeroClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K),
    sourceUniversalClearedEnergy F hs e unit q tau 0 c = 0

/-- Literal quantified clause: `source_quotient_moment_translation`. -/
def SourceAllBoundaryMomentTranslationsClause : Prop :=
  ∀ {R : Type u} {K : Type v} [CommRing R] [Field K] [Algebra R K]
    (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 2 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0),
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 0 = 0 ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 1 = 0 ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (quotientEquiv.symm.restrictScalars R) E
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (q - b ^ p)) ∧
        (∀ a : K, E' (algebraMap K (AdjoinRoot F') a) = algebraMap K (AdjoinRoot F') (D a)) ∧
        (∀ n : ℕ,
          functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
            (E' (AdjoinRoot.root F')) n =
            ∑ j ∈ range (n + 1), (n.choose j : K) * D b ^ (n - j) *
              functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
                (E (AdjoinRoot.root F)) j) ∧
        functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) 2 =
          functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F)) 2 ∧
        functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) =
          functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F))

/-- Literal quantified clause: `functional_discriminant_eq_three_five_invariant`. -/
def SourceFiveDiscriminantIdentityClause : Prop :=
  ∀ {K : Type u} {A : Type v} [Field K] [CharP K 5] [CommRing A] [Algebra K A]
    (linear : A →ₗ[K] K)
    (weight value : A),
    functionalMomentDiscriminant linear weight value =
      3 * functionalMomentFiveInvariant linear weight value

/-- Literal quantified clause: `source_quotient_five_invariant_translation`. -/
def SourceFiveInvariantTranslationClause : Prop :=
  ∀ {R : Type u} {K : Type v} [CommRing R] [Field K] [Algebra R K] [CharP K 5]
    (D : Derivation R K K)
    (F H : K[X]) (q tau : K) (hdegree : 5 ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hs : (H %ₘ (X ^ 5 + C q)).coeff 4 = 0),
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (quotientEquiv.symm.restrictScalars R) E
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) =
          functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F))

/-- Literal quantified clause: `degree_two_p_source_degree`. -/
def SourceDegreeTwoPPresentationDegreeClause : Prop :=
  ∀ {K : Type u} [Field K]
    (F S : K[X]) (p : ℕ) (hp : 2 ≤ p)
    (q tau kappa : K) (hkappa : kappa ≠ 0) (hS : S.natDegree ≤ p - 2)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau),
    F.natDegree = 2 * p

/-- Literal quantified clause: `degree_two_p_source_remainder`. -/
def SourceDegreeTwoPActualRemainderClause : Prop :=
  ∀ {K : Type u} [Field K]
    (S : K[X]) (p : ℕ) (hp : 2 ≤ p)
    (q kappa : K) (hS : S.natDegree ≤ p - 2),
    (C kappa * (X ^ p + C q) + S) %ₘ (X ^ p + C q) = S

/-- Literal quantified clause: `affine_source_remainder_center`. -/
def SourceAffineCenterCoefficientClause : Prop :=
  ∀ {K : Type u} [Field K]
    (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (H : K[X]) (a b q scale : K) (ha : a ≠ 0) (hscale : scale ≠ 0)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0),
    ((C scale * H.comp (C a⁻¹ * (X - C b))) %ₘ
      (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 2) /
    ((C scale * H.comp (C a⁻¹ * (X - C b))) %ₘ
      (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 1) =
      a * ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
        (H %ₘ (X ^ p + C q)).coeff (p - 1)) + b

/-- Literal quantified clause: `source_universal_affine_correction_weight`. -/
def SourceDegreeTwoPAffineTensorWeightClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F S : K[X]) (p : ℕ) [CharP K p] (q tau kappa : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (htau : tau ≠ 0) (hkappa : kappa ≠ 0) (hsep : F.Separable)
    (hS : S.natDegree ≤ p - 2)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b (2 * p) ha
        let F' := affineSourceFramePolynomial F a b (2 * p)
        let S' := C (a ^ p) * S.comp (C a⁻¹ * (X - C b))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalAffineEnergy F' (affine_source_frame_separable F hsep a b (2 * p) ha)
          e unit' (a ^ p * q - b ^ p) (a ^ (2 * p) * tau) (S'.coeff (p - 2)) =
          a ^ ((2 : ℤ) - (p : ℤ)) •
            sourceUniversalAffineEnergy F hsep e unit q tau (S.coeff (p - 2))

/-- Literal quantified clause: `source_universal_characteristic_five_twisted_formula`. -/
def SourceFiveTwistedTensorFormulaClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K] [CharP K 5]
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K),
    sourceUniversalTwistedEnergy F hs e unit q tau c =
      sourceUniversalSymmetricEnergy F hs e unit +
        rationalSymmetricProduct K (KaehlerDifferential k K)
          (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K (c / tau))

/-- Literal quantified clause: `source_universal_characteristic_five_corrected_identity`. -/
def SourceFiveCorrectedTensorIdentityClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K] [CharP K 5]
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) (htau : tau ≠ 0),
    sourceUniversalCorrectedEnergy F hs e unit q tau c =
      sourceUniversalTwistedEnergy F hs e unit q tau c - (2 / tau : K) •
        rationalSymmetricProduct K (KaehlerDifferential k K)
          (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K c)

/-- Literal quantified clause: `source_universal_twisted_normalization_invariant`. -/
def SourceTwistedNormalizationClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (t : K) (ht : t ≠ 0),
        let quotientEquiv := sourceNormalizationQuotientEquiv F t ht
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        sourceUniversalTwistedEnergy (C t * F)
          (Polynomial.Separable.unit_mul ((isUnit_iff_ne_zero.mpr ht).map C) hsep)
          e unit' q (t * tau) (((C t * H) %ₘ (X ^ p + C q)).coeff (p - 2)) =
          sourceUniversalTwistedEnergy F hsep e unit q tau
            ((H %ₘ (X ^ p + C q)).coeff (p - 2))

/-- Literal quantified clause: `source_universal_twisted_translation_invariant`. -/
def SourceTwistedBoundaryTranslationClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let H' := H.comp (X - C b)
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        sourceUniversalTwistedEnergy F'
          (affine_source_frame_separable F hsep 1 b F.natDegree one_ne_zero)
          e unit' (q - b ^ p) tau ((H' %ₘ (X ^ p + C (q - b ^ p))).coeff (p - 2)) =
          sourceUniversalTwistedEnergy F hsep e unit q tau
            ((H %ₘ (X ^ p + C q)).coeff (p - 2))

/-- Literal quantified clause: `actual_source_laurent_endpoint_objects_exist`. -/
def SourceActualLaurentPoleBoundClause : Prop :=
  ∀ {k : Type u} {ι : Type v} [Field k] [Fintype ι]
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (p r : ℕ) [CharP k p] (q tau leading : LaurentSeries k)
    (hp : p = 2 * r + 1) (hr : 1 ≤ r) (hdegree : p ≤ F.natDegree)
    (htau : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (((r : ℤ) + 1 : ℤ) : WithTop ℤ)),
    ∃ (E : Derivation k (AdjoinRoot F) (AdjoinRoot F)) (unit : (AdjoinRoot F)ˣ),
      (∀ c : LaurentSeries k,
        E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
          algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c)) ∧
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ((1 - (r : ℤ) : ℤ) : WithTop ℤ) ≤
        (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
          ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
          4 * laurentDerivation k q *
            laurentDerivation k ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau)).orderTop

/-- Literal quantified clause: `actual_source_laurent_corrected_endpoint_bound`. -/
def SourceFiveLaurentCorrectedPoleBoundClause : Prop :=
  ∀ {k : Type u} {ι : Type v} [Field k] [Fintype ι]
    [CharP k 5]
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (q tau leading : LaurentSeries k) (hdegree : 5 ≤ F.natDegree)
    (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : LaurentSeries k,
      E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
        algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c))
    (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q))
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop),
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    (-1 : WithTop ℤ) ≤
      (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
        laurentDerivation k q * laurentDerivation k c / tau -
        c * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop

/-- Literal quantified clause: `actual_source_laurent_coefficient_corrected_endpoint_bound`. -/
def SourceFiveLaurentCoefficientPoleBoundClause : Prop :=
  ∀ {k : Type u} {ι : Type v} [Field k] [Fintype ι]
    [CharP k 5]
    (F H : (LaurentSeries k)[X]) (hsep : F.Separable)
    (node : ι → LaurentSeries k) (hinj : Function.Injective node)
    (q tau leading : LaurentSeries k) (hdegree : 5 ≤ F.natDegree)
    (htauzero : tau ≠ 0) (hleading : leading ≠ 0)
    (hFsplit : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : LaurentSeries k,
      E (algebraMap (LaurentSeries k) (AdjoinRoot F) c) =
        algebraMap (LaurentSeries k) (AdjoinRoot F) (laurentDerivation k c))
    (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q))
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hq : q.orderTop = (3 : WithTop ℤ)) (htau : tau.orderTop = (3 : WithTop ℤ))
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop),
    (-1 : WithTop ℤ) ≤
      (Algebra.trace (LaurentSeries k) (AdjoinRoot F)
        ((E (AdjoinRoot.root F)) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) -
        laurentDerivation k q * laurentDerivation k (H.coeff 3) / tau -
        H.coeff 3 * laurentDerivation k q * laurentDerivation k tau / tau ^ 2).orderTop

/-- Literal quantified clause: `source_universal_degree_ten_corrected_weight`. -/
def SourceDegreeTenCorrectedTensorWeightClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    [CharP K 5]
    (F S : K[X]) (q tau kappa : K) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (htau : tau ≠ 0) (hkappa : kappa ≠ 0) (hsep : F.Separable)
    (hS : S.natDegree ≤ 3)
    (hsource : F = C kappa * (X ^ 5 + C q) ^ 2 + (X ^ 5 + C q) * S + C tau),
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b 10 ha
        let F' := affineSourceFramePolynomial F a b 10
        let S' := C (a ^ 5) * S.comp (C a⁻¹ * (X - C b))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ 5) (pow_ne_zero _ ha) unit)
        sourceUniversalCorrectedEnergy F' (affine_source_frame_separable F hsep a b 10 ha)
          e unit' (a ^ 5 * q - b ^ 5) (a ^ 10 * tau) (S'.coeff 3) =
          a ^ (-3 : ℤ) • sourceUniversalCorrectedEnergy F hsep e unit q tau (S.coeff 3)

/-- Literal quantified clause: `laurent_characteristic_five_endpoint_jets`. -/
def SourceActualLaurentEndpointJetsClause : Prop :=
  ∀ {k : Type u} {ι : Type v} [Field k] [CharP k 5] [Fintype ι]
    [DecidableEq k]
    (F H : (LaurentSeries k)[X]) (q tau leading : LaurentSeries k)
    (node : ι → LaurentSeries k)
    (hH : ∀ n, (0 : WithTop ℤ) ≤ (H.coeff n).orderTop)
    (hHleading : H.leadingCoeff.orderTop = 0)
    (hq : q.orderTop = 3) (htau : tau.orderTop = 3)
    (hnodes : ∀ i, (0 : WithTop ℤ) ≤ (node i).orderTop)
    (hfactor : F = C leading * nodal Finset.univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau),
    let small := Finset.univ.filter (fun i => (node i).coeff 0 = 0)
    let e0 := (H.coeff 0).coeff 0
    let c := (H %ₘ (X ^ 5 + C q)).coeff 3
    e0 ≠ 0 ∧ small.card = 5 ∧
    e0 * q.coeff 3 + tau.coeff 3 = 0 ∧
    (∑ i ∈ small, (node i).coeff 1 ^ 2) = 0 ∧
    (∑ i ∈ small, (node i).coeff 1 * (node i).coeff 2) =
      -(q.coeff 3 * c.coeff 0) / e0

/-- Literal quantified clause: `power_series_constant_translation`. -/
def SourceConstantPowerSeriesTranslationClause : Prop :=
  ∀ {k : Type u} [Field k] [IsAlgClosed k]
    (q : PowerSeries k) (p : ℕ) (hp : 0 < p),
    ∃ b : k,
      q - (PowerSeries.C b) ^ p = q - PowerSeries.C (PowerSeries.constantCoeff q) ∧
      PowerSeries.constantCoeff (q - (PowerSeries.C b) ^ p) = 0

/-- Literal quantified clause: `laurent_constant_translation`. -/
def SourceConstantLaurentTranslationClause : Prop :=
  ∀ {k : Type u} [Field k] [IsAlgClosed k]
    (q : LaurentSeries k) (p : ℕ) (hp : 0 < p),
    ∃ b : k,
      q - (algebraMap k (LaurentSeries k) b) ^ p =
        q - algebraMap k (LaurentSeries k) (q.coeff 0) ∧
      laurentDerivation k (algebraMap k (LaurentSeries k) b) = 0

/-- Literal quantified clause: `actual_source_subring_integrality`. -/
def SourceActualSubringRegularityClause : Prop :=
  ∀ {R : Type u} {K : Type v} {ι : Type w} [CommRing R] [Field K] [Algebra R K] [Fintype ι]
    (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) (q tau leading : K) (node : ι → K)
    (hp : 0 < p) (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal univ node)
    (hsource : F = (X ^ p + C q) * H + C tau)
    (hD : ∀ x ∈ S, D x ∈ S) (hH : ∀ j, H.coeff j ∈ S)
    (hq : q ∈ S) (htauInv : tau⁻¹ ∈ S) (hnodes : ∀ i, node i ∈ S),
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      sourceQuotientDifferentialEnergy F E unit ∈ S ∧
      clearedDifferentialExpression D (sourceQuotientDifferentialEnergy F E unit) q tau
        ((H %ₘ (X ^ p + C q)).coeff (p - 1))
        ((H %ₘ (X ^ p + C q)).coeff (p - 2)) ∈ S ∧
      sourceQuotientDifferentialEnergy F E unit -
        D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2)) / tau ∈ S

/-- Literal quantified clause: `source_boundary_quotient_integrality`. -/
def SourceActualTranslatedBoundaryRegularityClause : Prop :=
  ∀ {R : Type u} {K : Type v} {ι : Type w} [CommRing R] [Field K] [Algebra R K] [CharP K 5] [Fintype ι]
    (S : Subring K) (D : Derivation R K K)
    (F H : K[X]) (q tau leading : K) (node : ι → K)
    (hdegree : 5 ≤ F.natDegree) (hsep : F.Separable) (hinj : Function.Injective node)
    (hleading : leading ≠ 0) (htau : tau ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal Finset.univ node)
    (hsource : F = (X ^ 5 + C q) * H + C tau)
    (hs : (H %ₘ (X ^ 5 + C q)).coeff 4 = 0)
    (hD : ∀ x ∈ S, D x ∈ S) (hnodes : ∀ i, node i ∈ S)
    (hInv : ∀ i, (node i ^ 5 + q)⁻¹ ∈ S),
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      ∀ b : K,
        let e := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom unit
        F' = (X ^ 5 + C (q - b ^ 5)) * H.comp (X - C b) + C tau ∧
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ 5 + C (q - b ^ 5)) ∧
        (∀ a : K, E' (algebraMap K (AdjoinRoot F') a) = algebraMap K (AdjoinRoot F') (D a)) ∧
        functionalMoment (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) 2 ∈ S ∧
        functionalMomentFiveInvariant (Algebra.trace K (AdjoinRoot F')) (↑unit'⁻¹ : AdjoinRoot F')
          (E' (AdjoinRoot.root F')) ∈ S

/-- Literal quantified clause: `actual_source_unit_derivative_moment_mem_subring`. -/
def SourceAllUnitMomentsIntegralClause : Prop :=
  ∀ {R : Type u} {K : Type v} {ι : Type w} [CommRing R] [Field K] [Algebra R K] [Fintype ι]
    (S : Subring K) (D : Derivation R K K)
    (F : K[X]) (node : ι → K) (leading : K) (phi : K[X])
    (hsep : F.Separable) (hinj : Function.Injective node) (hleading : leading ≠ 0)
    (hfactor : F = C leading * Lagrange.nodal Finset.univ node)
    (hD : ∀ x ∈ S, D x ∈ S) (hnodes : ∀ i, node i ∈ S)
    (hInv : ∀ i, (phi.eval (node i))⁻¹ ∈ S)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F phi)
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (D a)) (n : ℕ),
    functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
      (E (AdjoinRoot.root F)) n ∈ S

/-- Literal quantified clause: `source_universal_energy_frame_independent`. -/
def SourceIntrinsicTensorFrameIndependenceClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K]
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ),
    sourceUniversalSymmetricEnergy F hs e unit = sourceUniversalSymmetricEnergy F hs e' unit

/-- Literal quantified clause: `separating_function_source_universal_calculus`. -/
def SourceActualSeparatingFieldTensorCalculusClause : Prop :=
  ∀ {k : Type u} {T : Type v} {K : Type w} [Field k] [Field T] [Field K] [Algebra k T] [Algebra k[X] T] [IsScalarTower k k[X] T] [IsFractionRing k[X] T] [Algebra k K] [Algebra T K] [IsScalarTower k T K] [Algebra.IsSeparable T K]
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) (hs : F.Separable),
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      e (KaehlerDifferential.D k K (algebraMap T K (algebraMap k[X] T X))) = 1 ∧
      Specifications.SourceUniversalTensorCalculus F H p q tau e hs

/-- The coordinate and calculus for every actual finitely generated
one-variable function field over a perfect base are constructed. -/
def SourceActualOneVariableFieldTensorCalculusClause : Prop :=
  ∀ {k : Type u} {K : Type v} [Field k] [Field K] [Algebra k K] [PerfectField k]
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) (hs : F.Separable),
    ∃ e : KaehlerDifferential k K ≃ₗ[K] K,
      Specifications.SourceUniversalTensorCalculus F H p q tau e hs

/-- Every canonical algebraic, differential, tensor, boundary and local
clause of source_quadratic_calculus, at its precise scope. Each component
is an explicit quantified proposition above, with actual quotient/tensor/
Laurent/subring objects. The separating-field clause constructs Ω. -/
def SourceQuadraticCalculus : Prop :=
  SourceCoefficientMomentsClause.{u} ∧
  SourceDifferentialMomentsAndSquaresClause.{u, v} ∧
  SourceUniversalMomentsAndSquaresClause.{u, v} ∧
  SourceCenteredFormulaClause.{u, v} ∧
  SourceCenteredAffineWeightClause.{u, v} ∧
  SourceClearedAffineWeightClause.{u, v} ∧
  SourceClearedBoundaryZeroClause.{u, v} ∧
  SourceAllBoundaryMomentTranslationsClause.{u, v} ∧
  SourceFiveDiscriminantIdentityClause.{u, v} ∧
  SourceFiveInvariantTranslationClause.{u, v} ∧
  SourceDegreeTwoPPresentationDegreeClause.{u} ∧
  SourceDegreeTwoPActualRemainderClause.{u} ∧
  SourceAffineCenterCoefficientClause.{u} ∧
  SourceDegreeTwoPAffineTensorWeightClause.{u, v} ∧
  SourceFiveTwistedTensorFormulaClause.{u, v} ∧
  SourceFiveCorrectedTensorIdentityClause.{u, v} ∧
  SourceTwistedNormalizationClause.{u, v} ∧
  SourceTwistedBoundaryTranslationClause.{u, v} ∧
  SourceActualLaurentPoleBoundClause.{u, v} ∧
  SourceFiveLaurentCorrectedPoleBoundClause.{u, v} ∧
  SourceFiveLaurentCoefficientPoleBoundClause.{u, v} ∧
  SourceDegreeTenCorrectedTensorWeightClause.{u, v} ∧
  SourceActualLaurentEndpointJetsClause.{u, v} ∧
  SourceConstantPowerSeriesTranslationClause.{u} ∧
  SourceConstantLaurentTranslationClause.{u} ∧
  SourceActualSubringRegularityClause.{u, v, w} ∧
  SourceActualTranslatedBoundaryRegularityClause.{u, v, w} ∧
  SourceAllUnitMomentsIntegralClause.{u, v, w} ∧
  SourceIntrinsicTensorFrameIndependenceClause.{u, v} ∧
  SourceActualSeparatingFieldTensorCalculusClause.{u, v, w} ∧
  SourceActualOneVariableFieldTensorCalculusClause.{u, v}

end Litt3.CartierAndSpin.Specifications
