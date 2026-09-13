# No fifth lift of the original marked rank25 laboratory tuple

Version2,2026-09-13. The original geometric theorem is independently
audited. The revised proof uses an audited transverse normal form and
direct reconstruction of only the two separating components.

Retain EXACTLY the original genus26 elementary-abelian25 cover, marked
T2, full periodic tuple, nonsplit square-trivial flat twist, and actual
third-displacement coordinates of
[rank25_fourth_locus](rank25_fourth_locus.md). Work over the algebraic
closure of k0=F5[t]/(t^4+4t^3+t^2+4t+3). Digits abcd mean
a+b*t+c*t^2+d*t^3.

For EVERY compatible third lift of this marked T2 and EVERY compatible
fourth extension of it, there is NO compatible fifth extension.
Equivalently, the entire marked fifth-lift locus is empty. Since actual
compatible fourth lifts exist, this fixed marked T2 has exact maximum
compatible Witt length4. It gives no upper bound after further étale
pullback, or for other markings, and no unmarked common-cover verdict.

Here is an explicit separating certificate. The universal trace already
excludes all four boundary families. On its remaining trace-zero chart,

    q!=0, U=-Theta(0,A,B,q)/(2110*q^2),
    A=x3-3003, B=x4-0314, q=x6,

let r_A,r_B be the two Frobenius-root cotangent rows specified in the
proof. For any actual fifth obstruction C5 in the original nine target
coordinates, put omega_A=r_A^[5]*C5, omega_B=r_B^[5]*C5. These rows
annihilate the entire relative fourth-choice image. Their exact values are

    omega_A=q^2*(4442+0220*q^4+4003*q^8),
    omega_B=q^2*(0141+1313*q^4+1014*q^8).

Writing a(v)=4442+0220*v+4003*v^2 and
b(v)=0141+1313*v+1014*v^2, the exact identity is

    (2013+3340*v)*a(v)+(1413+4410*v)*b(v)=1.

Since q is invertible, these two actual fifth components cannot vanish
together. The third nontrace component is unnecessary for exclusion.

The homogeneous differences in the proved bounded covariant space have
an explicit eleven-dimensional image in these two root cotangent
components. Restriction to A=B=0 is injective on that image; any SIX
distinct nonzero geometric q-values determine a member. This supplies
the uniqueness behind reconstruction from the existing actual curve
data. The complete support, matched ordinary repairs and finite-deck
covariance remain prerequisites; no gradient property of C5 is assumed.

[Proof and exact evidence](../../../Proofs/deformations/elementary_covers/rank25_whole_fifth_exclusion.md) ·
[Transverse reconstruction audit](../../../Research/audits/RANK25_TRANSVERSE_NORMAL_FORM_AUDIT_2026_09_13.md).
