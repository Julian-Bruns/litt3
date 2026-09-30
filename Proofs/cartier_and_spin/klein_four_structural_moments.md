# Proof: Frobenius eigenspaces, linear moments and endpoint deficits

[Statement](../../Theorems/cartier_and_spin/klein_four_structural_moments.md).
Part II of the
[incoming report](../../../litt3-computation-data/finite_loci_v4_replies_20260926/extracted/v4/klein_four_structural_v5/REPORT.md)
gives the complete direct proofs. The reductions below retain their
normalizations and the full geometric scope.

## Subfield scales

There is no nonzero F5 relation on at most five distinct29th roots.
The Frobenius exponents contain the blocks4,5,6,7 and22,23,24,25.
For five nodes the first block has a one-dimensional kernel; the
second block says multiplication by each node's eighteenth power
preserves the same kernel. All entries of that kernel are nonzero.
Thus all eighteenth powers coincide, contradicting gcd(18,29)=1.
For at most four nodes use the ordinary Vandermonde determinant.

Let sigma=5^42-Frobenius on F_(5^56), fixing K and cycling the four
root types. The canonical c-label has nonzero projections in all
four sigma-eigenspaces1,2,3,4. The second-jet label has zero
3-projection, with its4-projection equal to lambda=[12] times that
of c. Here lambda^2=omega=[11] has order3.

If epsilon is in K, the3-projections of both moment equations force
the3-projections of both endpoint c-sums to vanish. The short-relation
lemma implies each phase group has an even number of labels; it is
either one group of four or two groups of opposite types. For an
unbalanced endpoint define q_r=sum(-1)^i xi^r over its labels,
r=5,8. Both are nonzero, and R=q5/q8 satisfies R/bar(R) in mu29.
The4-projections give R_Q R_H=lambda^2 if neither endpoint is
balanced; if one is balanced so is the other. The unbalanced case
would put omega/bar(omega), of order3, in mu29, a contradiction.
This proves assertion1 with no pole-profile enumeration.

## Linear/quadric reduction

Set a=E(Q)/eta,b=C(Q)/eta,c=C(H)/eta,d=E(H)/eta. The determinant
of the two scalar equations is
\[
ad-bc-a x-d\bar x+b\bar y+c y+N(x)-N(y)=0.
\]
Write x=x0+beta x1,y=y0+beta y1 over K+. The norm is
x0^2+x0x1+2x1^2. All other terms are affine linear. Since F_(5^56)
has dimension8 over K+, the seven nonconstant coordinates form
the asserted linear system; the scalar coordinate is one quadric.
After solving, recover epsilon from two nonzero proportional vectors.
One zero and one nonzero vector is rejected; two zero vectors must
initially be retained, even though the actual-input trace theorem
separately excludes that case.

The two Frobenius orbits of exponents2 and6 cover all28 nonzero
residues modulo29. Thus x,y supply all nonconstant Fourier coordinates.
Adding the prescribed M0=m modulo5 and inverting the29-term Fourier
matrix gives every weight residue. Only a residue1 has two allowed
integer lifts,1 and6. This proves assertion3 without a profile search.

## Actual character deficits

Suppose the known endpoint jets give bounds A_i,B_i at0 on u_i,t^3v_i,
and C_i,D_i at infinity on t^-3u_i,v_i. For each pair put
z_ij=min(A_i+B_j,A_j+B_i),
p_ij=min(C_i+D_j,C_j+D_i). The nonzero polynomial minor
U_iV_j-U_jV_i is divisible by t^z_ij E J_k^(1), and its degree is at
most6+2e+c_i+c_j-h_i-h_j-p_ij. Summing gives
\[
2g+j_1\le12+3e+4j-\sum_{i<j}(z_{ij}+p_{ij}).
\]
At a fully collided0 endpoint the actual supplied jets give A_i=3,
B_i=2; at a fully collided infinity endpoint C_i=2,D_i=3.
Both together subtract30, giving assertion4. Since the pole mass
m=n-12 is at least e+2j, the right side is negative for m<=5.
No unspecified later jets are inferred; their resonance is retained.

## Specified repeated-label sector

The sector consists of two copies of each of two opposite root types
with one common phase at0, and two copies of each of the complementary
opposite types with one common phase at infinity. Cyclic type shifts,
endpoint interchange and all relative phases are included. Normalize
the0 phase to1 by the allowed mu29 coordinate change. Coefficient
Frobenius reduces the29 infinity phases to five small systems.
Their seven-by-four matrices have rank3. The remaining scalar
quadratics have either no K+-root or two, with six moment points
in total. Inverse Fourier transform for each of five mass residues
gives30 exact weight vectors; the minimum of their integer masses
is37. This proves assertion5, including arbitrary geometric epsilon.

The incoming six-point datum at mass37 meets the moments and has
epsilon outside K, so the subfield premise in assertion1 cannot
be inferred from the two moments alone. It specifies no variable
branch curve, no nontrivial character functions and no etale maps.

The independent local replay of all five matrices, row operations,
quadratics, six points and30 Fourier inversions passed using the older
polynomial field model. Pure short-relation and jet arguments require
no finite-search certificate. See
[the integration audit](../../Research/audits/FINITE_LOCI_V4_REPLIES_2026_09_26.md).
