# Canonical Dirac divisor in a principal polarization class

Author argument2026-09-05; independently audited PASS by
/root/dirac_ppav_construction_independent_audit (GPT-6 Astra, medium).
[Audit metadata](audits/PPAV_VERSCHIEBUNG_DIRAC_EXISTENCE_AND_UNIQUENESS_AUDIT_2026_09_05.md)
covers BOTH existence and uniqueness; reference-only. The separate
existence transcription was consolidated here2026-09-07, without extending
that scope. Retain the relative dualizing line, inverse FIELD twist and
arbitrary-characteristic reducedness of principal theta divisors.

## Exact statement

Let k be algebraically closed of characteristic p>0 and (A,λ) a
positive-dimensional principally polarized abelian variety. Put
A_1=A^(p), v=V_A:A_1→A and K=ker(v).
There is exactly one effective divisor D on A_1 such that

- [D]=(p−1)λ^(p) numerically;
- its local equation on the FULL finite scheme K vanishes on every
  nonidentity local component and is a nonzero socle element at identity.

For ANY principal line M representing λ, write L_1=M^(p). Then

    O(D) ≅ T_M=L_1^(-1)⊗v^*M⊗ω_v.                          (1)

The divisor, hence this isomorphism class, is independent of M. No
ordinarity or Jacobian hypothesis occurs. The dualizing line ω_v is
trivial, but cannot be omitted from the duality calculation.

## 1. Fourier construction and the actual evaluation morphisms

Rigidify M and L_1 at0 and use normalized Poincare Fourier functors Φ.
Set E=v_*L_1 and Q=(Φ_A M)^(-1), a principal ample line on the dual
variety. Ample vanishing makes E IT_0. The fiber quotient
e_M:M→k(0) transforms to a NONZERO theta section
θ:Q^(-1)→O: full faithfulness, not nonvanishing of a global section
of M at0, gives this assertion.

Naturality under isogeny and base-field twist, with dual isogeny
v̂=F_(Â), identifies the specific maps

    Φ_A(E)=F_(Â)^*(Q^(p))^(-1)=Q^(-p),
    Φ_A(d)=F_(Â)^*(θ^(p))=θ^p,   d=v_*(e_M^(p)).

These are morphism identities, not numerical identifications. The inverse
Fourier image of multiplication θ^(p−1):Q^(-p)→Q^(-1) is the unique

    h:E→M with e_M h=d.                                    (2)

Uniqueness follows because multiplication by θ is injective. Finite
flat duality identifies h with a section s_M of (1). On K, equation(2)
makes its dualizing functional residue evaluation at identity.

Explicitly, O(K)=∏_x R_x and the dualizing module is
Hom_k(O(K),k), with (aφ)(b)=φ(ab). Identity residue is zero on all
other factors and annihilated by m_0 on R_0. The fiber rings are
Artinian Gorenstein, so a dualizing trivialization carries this nonzero
functional to the one-dimensional socle Ann(m_0). Changing generators
multiplies by a unit and preserves the condition. Thus s_M is Dirac,
including for nonreduced K, and is nonzero.

Since both abelian canonical lines are trivial,
ω_v=ω_A1⊗(v^*ω_A)^(-1) is trivial as a LINE BUNDLE, independently of
the differential map. For F:A→A_1, the identities vF=[p] and
F^*L_1=M^p give F^*v^*M≡M^(p²). Injectivity of finite-surjective
numerical pullback yields v^*M≡L_1^p, proving the class of D.

## 2. Every competitor gives theta divisibility

Let s∈H⁰(A_1,T) be Dirac with T≡L_1^(p−1). Its actual residual

    R=v^*M⊗ω_v⊗T^(-1) ≡ L_1

is principal ample. Inverse base-FIELD twist gives R≅M'^(p) for a
principal M'≡M on A. This is NOT a p-th tensor-root construction.

Duality sends s to h_s:v_*R→M. A socle element pairs with an arbitrary
local element by its residue scalar; after rigidifying R and rescaling s,

    e_M h_s=v_*(e_M'^(p)).

Put Q'=(Φ_A M')^(-1), with theta section θ' the transform of e_M'.
The same natural identities supply a morphism a_s:Q'^(-p)→Q^(-1) with

    θ a_s=θ'^p,   div(θ)≤p div(θ').                        (3)

M' is a translate of M, so Fourier translation compatibility makes Q'
and Q differ by a degree-zero twist. Their divisor classes agree.
Principal theta divisors are REDUCED in arbitrary characteristic:
Jordan–Keeton–Poonen, [Theorem3.1](https://arxiv.org/html/1602.06811v1#S3).
Consequently(3) implies div(θ)≤div(θ'). The difference is effective
and numerically trivial, hence zero by intersection with an ample
class to power dim(A)−1.

Thus Q'≅Q with theta sections agreeing up to scalar. Fourier equivalence
gives M'≅M, hence T≅T_M. Multiplication by θ being injective, (3)
forces a_s to be θ^(p−1) up to scalar. The sections and their divisors
therefore agree, proving uniqueness across the WHOLE numerical class.

## 3. Necessary distinctions and consequences

Existence is NOT in every specified representative of that class.
For an ordinary elliptic curve in characteristic2, K={0,a} and the
required degree-one divisor is[a]. The unique divisor of O([0]) is
not Dirac; (1) gives O([a]). For nonreduced identity components a
nonzero socle restriction has zero value at the reduced origin.

For a smooth proper connected curve, Tong's Dirac theorem for the
Raynaud determinant divisor, of class(p−1)Θ, identifies it with this
ppav divisor WITHOUT ordinarity. This addresses the formulation of
Tong's Question1.3.7; no historical novelty or claim about its present
literature status is made.

Exterior products of factor sections are Dirac on a product kernel;
uniqueness identifies the product divisor with the sum of pulled-back
factor divisors. This needs an ACTUAL product of ppavs, not just an
isogeny decomposition. No avoidance of abelian subvarieties/translates,
and no two finite etale maps of curves, follows.

Fourier inputs: Mukai, Theorem2.2, Example2.6, formula(3.4), Proposition3.11,
[primary paper](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BDBEBAC584BE15236C2D62C383A34245/S002776300001922Xa.pdf/duality-between-d-x-and-with-its-application-to-picard-sheaves.pdf).
Field-twist compatibility is normalized Poincare flat base change.
Finite duality commutes with base change:
[Stacks, Lemma49.2.10](https://stacks.math.columbia.edu/tag/0BVF).
[Tong, §1.2.7 and Question1.3.7](https://arxiv.org/pdf/0712.2046)
supplies the Jacobian Dirac theorem, not universal ppav existence.
