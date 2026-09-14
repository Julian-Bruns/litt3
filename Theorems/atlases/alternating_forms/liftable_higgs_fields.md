# Liftable Higgs fields and osculating modifications

Let C be a smooth projective connected curve of genus g≥2 over an
algebraically closed field of characteristic different from2. Put
ω=ω_C, n=g−1. Let V be stable of rank2, det V=ω and H⁰(V)=0.
Choose a nowhere-zero u∈A=H⁰(Vω), and an extension

    0 → O --e--> E3 --π--> V → 0

whose Serre functional λ_α:A→k satisfies λ_α(u)=1. Set
K=π⁻¹(ω⁻¹u); thus K/O=ω⁻¹ and E3/K=ω².
Use the [canonical-divisor forms](canonical_divisor_evaluation.md)
A_s and the scalar Higgs quotient M_s from that theorem.

## Liftable representatives and Higgs fields

The hyperplane H_α=ker λ_α=image H⁰(E3ω) has dimension4n−1.
For B_s=A_s|H_α,

    A=ku⊕H_α,   rad A_s=ku⊕rad B_s,
    ker M_s ≅ rad B_s.

Every trace-free Higgs field φ on V lifts uniquely to a trace-free
Z:E3→E3ω killing e. Under this identification, ker M_s consists of
the Z that preserve K over the full divisor D_s=div(s), and whose
eigenvalue on (K/O)|D_s is the restriction of a global r∈H⁰(ω).

The signed maximal Pfaffians of the odd alternating B_s define its
radical section in H_α⊗det(H_α)⁻¹, of degree2n−1 in s.
Equivalently it is PfaffAdj(A_s)λ_α in the even presentation.
It is nonzero exactly when dim ker M_s=1, and then spans that kernel.
Thus generic nullity1 is equivalent to this polynomial not vanishing
identically; the construction alone does not establish it.

## The osculating modification

Put G_s=ker(V→ω²|D_s), with its inclusion i_s:G_s→V. Then
det G_s=O, H⁰(G_s)=0, and

    0 → k i_s → Hom(G_s,V) → ker M_s → 0.

Consequently Hom(G_s,V) has even dimension. For any saturated line
N⊂G_s,

    h⁰(VN) ≤ h⁰(G_s^∨V) ≤ h⁰(VN)+h⁰(VN⁻¹),
    h⁰(VN)−h⁰(VN⁻¹)=2deg N.

In particular:

- deg N=d>0 implies dim ker M_s≥2d+1;
- N=O(−D), D effective of degree e>0, implies dim ker M_s≤2e−1;
- deg N=0 and h⁰(VN)=1 imply dim ker M_s=1.

Thus a saturated O(−x)⊂G_s forces nullity1. A sufficient certificate
is a surjection E3→ω(x) killing e and K|D_s. For each x, requiring
regularity of its restriction to ω⁻¹ leaves only one candidate line;
divisibility by s and global surjectivity must still be checked.

## Dual lifts and the actual Frobenius specialization

Each s∈H⁰(ω) has a unique σ_s∈H⁰(E3^∨ω) with σ_s(e)=s.
For a basepoint-free canonical pencil, σ_s0∧σ_s1 maps to a nonzero
section of H_α. It is outside the common radical ku.
A general σ_s is nowhere zero, with rank2 kernel F_s satisfying
det F_s=O and H⁰(F_s)=0. This is a different bundle from G_s.

An actual normalized untwisted Hermitian atlas in characteristic5,
with5∤2g−2, supplies these data and an isomorphism
F^*E3≅E3^∨ω², where F is absolute Frobenius.
Hence F^(2*)E3≅E3ω⁸ and E3 is strongly
semistable; at genus9 it is stable. The preceding constructions
require only the stated extension data. Generic Pfaffian nonvanishing
for every actual atlas remains open.

Version3,2026-09-14. The abstract extension hypotheses are separated
from the Frobenius specialization; conclusions and evidence are
retained from the author proof. No independent audit is claimed.
[Proof](../../../Proofs/atlases/alternating_forms/liftable_higgs_fields.md).
