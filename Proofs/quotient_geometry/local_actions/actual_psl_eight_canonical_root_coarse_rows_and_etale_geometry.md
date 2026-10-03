# Proof: exact weak-cyclic lattices, section multiplicities and étale rows

Version1. See the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_canonical_root_coarse_rows_and_etale_geometry.md).
The separately audited self-contained notes retain the
[two-block lattice calculation](../../../Research/notes/oct03_ten_hour/eight_module_actual_coarse_lattices_and_sections.md),
[étale row argument](../../../Research/notes/oct03_ten_hour/eight_module_actual_root_row_etale_normalizations.md),
and [third-block extension](../../../Research/notes/oct03_ten_hour/eight_module_actual_third_wild_picard_rows.md).

## Actual atlas, stability and local root frames

Matched completed-local
[Humbert uniformization](../../../Theorems/cartier_and_spin/canonical_degree_ten_humbert_target_uniformization.md)
supplies the fixed ordinary genus-five actual atlas \(H\to\mathcal S\),
with group \(R=C_2^4\rtimes C_5\) of order EIGHTY.
The actual \(Q\)- and \(R\)-coarse covers have no common Galois
quotient, because \(Q\) is nonabelian simple and \(R\) is solvable.
Their compositum is a connected actual étale \(Q\)-torsor over \(H\).
The scalar-cover/irreducibility lemma of the
[finite-source stability proof](../../../Proofs/cartier_and_spin/actual_finite_source_strong_semistability_and_cartier_surjectivity.md)
therefore makes \(E_H,E'_H\) strongly stable.
Only their ordinary stability is used; no original Cartier,
source-kernel or endpoint assertion is imported.
Their degrees are SIXTEEN and FORTY-EIGHT, slopes TWO and SIX.

At the weak cyclic-five point use
\[
t\longmapsto\frac{t}{1+t},\qquad
y=1/t,\qquad u=\frac{t^5}{1-t^4}.
\]
Then \(y\mapsto y+1\), and \(u\) is a coarse uniformizer.
The derivative \(du/dt\) has valuation EIGHT.
For a regular frame \(e\) of \(P\), its specified canonical fourth
power has an invariant rational root frame \(r=(du)^{1/4}\)
with \(v_t(r/e)=2\).
The unit fourth root exists in \(k[[t]]\).
Invariance follows because its fourth power is invariant and
\(C_5\) has no nonidentity \(k^\times\)-character.
The corresponding \(P^3\) frame \(r^3\) has valuation SIX.
This is a section in the actual line, not an additional field extension.

At the tame point the paired \(E\)-fiber has four positive and four
negative characters: inverse \(P\)-scalar cancels the natural
\(\pm\lambda\) scalars.
The same is true for \(E'\).
With coarse coordinate \(z=t^2\), determinant evaluation has valuation
FOUR for each. Contraction pairs a positive with a negative
character, and \(t\,dt\) is a unit multiple of \(dz\);
coarse duality is perfect there.

## Exact invariant basis and determinant table

For each \(J_s\), \(1\le s\le5\), choose its nilpotent logarithm \(N\)
and chain \(Ne_j=e_{j-1}\).
Factorials through FOUR are invertible.
For the generator \(\exp N\), the vectors
\[
v_j=\exp(-yN)e_j,\qquad 0\le j<s,
\]
are invariant and have leading pole \(t^{-j}\) in the \(e_0\) coordinate.
If the scalar rational frame has valuation \(m\), the EXACT
\(k[[u]]\)-basis of invariant regular vectors is
\[
u^{n_j}r_m v_j,\qquad
n_j=\left\lceil\frac{j-m}{5}\right\rceil.
\]
Indeed an invariant rational vector is uniquely \(\sum f_j(u)r_m v_j\).
Its leading \(e_0\)-valuations \(5v_u(f_j)+m-j\) are distinct modulo FIVE,
so the smallest cannot cancel.
Integrality forces all \(v_u(f_j)\ge n_j\), and those inequalities
also make every chain coordinate integral.
No exactness of the wild invariant functor is assumed.

The determinant valuation is
\[
d_s(m)=sm+5\sum_{j=0}^{s-1}
                \left\lceil\frac{j-m}{5}\right\rceil.
\]
For the two bundles \(m=2,6\), respectively:

| Block | \(d_s(2)\) | \(d_s(6)\) |
|---|---:|---:|
| \(J_5\) |20|20|
| \(J_4\) |13|14|
| \(J_3\) |6|8|
| \(J_2\) |4|2|
| \(J_1\) |2|1|

Thus \(E\)'s total is TWENTY-SIX in all three partitions.
\(E'\)'s total is TWENTY-EIGHT in the two-block partitions and
TWENTY-THREE in the third partition.
The actual \(H\)-atlas has sixteen wild points and forty tame points.
Determinant evaluation gives
\[
16=80\deg F+16\cdot26+40\cdot4,
\]
\[
48=80\deg F'+16\cdot d_{\rm wild}(E')+40\cdot4.
\]
These are precisely the coarse degrees in the statement.
The invariants are coherent and torsion-free over the smooth coarse
curve, so the coarse bundles really have rank EIGHT.

## The rational coarse duality defect

Pair \(v_j\) with its rational dual \(w_j\); the dual chain pole index
is \(s-1-j\). Since \(r r^3=du\), the local contraction exponent is
\[
\left\lceil\frac{j-2}{5}\right\rceil+
\left\lceil\frac{s-1-j-6}{5}\right\rceil.
\]
For \(J_5\) all exponents are ZERO.
For \(J_4\) they are \(0,0,-1,0\).
For \(J_3\) they are \(0,-1,-1\).
For \(J_2\) they are \(-1,-1\), and for \(J_1\) it is \(-1\).
Thus the rational lattice \(F^*\omega_{\mathbf P^1}\) extends regularly
as a sublattice of \(F'\), with cokernel
\(k[[u]]/(u)\) for each minus-one exponent.
The respective defects are TWO, TWO and THREE.
Contraction is perfect elsewhere, including the tame point.
This proves the exact sequence in the statement.

Canonical invariants on the wild quotient itself have basis
\(u^{-1}du\): its upstairs valuation is \(8-5=3\), still regular.
Therefore \(\pi_*\omega_{\mathcal S}\) allows a simple wild pole.
The sequence just proved is a RATIONAL dual-lattice extension with
base differential \(du\), not an assertion of uncorrected duality
or of exact coarse wild invariants.

## Splitting interval and injective wild evaluation

A positive summand \(\mathcal O(a)\subset F\), \(a\ge1\), pulls to
a generically injective line of degree at least EIGHTY in \(E_H\).
Its saturation contradicts stability at slope TWO.
All splitting degrees of \(F\) are therefore at most ZERO.
The same holds for \(F'\), using slope SIX.
The displayed dual-lattice inclusion then rules out a summand of
degree at most minus THREE in \(F\): its coarse dual would be a
positive line in \(F'\).
Dualizing the lattice inclusion gives
\(F'^*\omega_{\mathbf P^1}\subset F\), and yields the same lower bound
for \(F'\). All splitting degrees lie in \(\{0,-1,-2\}\).

The genuine natural actions identify global sections with the Hom
spaces in the statement: a section of \(E\) is an equivariant
intertwiner \(W^*\to H^0(D,P)\), and a section of \(E'\) is an
intertwiner \(W\to H^0(D,P^3)\).
Each nonzero intertwiner is injective by irreducibility.
Its common base divisor is \(Q\)-invariant.
Every nonempty invariant effective divisor on the ACTUAL \(D\)
has degree at least \(|Q|/5\), since the only stabilizer orders are
FIVE, TWO and ONE. But
\[
\deg P=|Q|/40,\qquad\deg P^3=3|Q|/40.
\]
Thus every such natural copy is base-point-free.

Evaluation of the entire global-section space at a wild point is
injective: a nonzero combination vanishing there would be a nonzero
intertwiner with that forbidden base point.
In either two-block case the invariant fiber has dimension TWO.
Rank EIGHT, degree minus SEVEN and the splitting interval give at
least ONE zero summand; injective evaluation permits at most TWO.
This proves the two possible splittings and \(h^0\) ranges.

In the third partition the \(m=2\) valuation image is sharper.
Only \(r v_2\) in the long \(J_5\) block has nonzero value;
the \(J_2\) leading orders are TWO, ONE and the \(J_1\) order is TWO.
Evaluation image dimension is only ONE. Consequently \(h^0(F)=1\),
and \(F=\mathcal O\oplus\mathcal O(-1)^7\).
For \(m=6\), only \(u^{-1}r^3v_1\) in \(J_5,J_2\) has nonzero value.
The \(J_1\) term has order ONE.
Thus \(h^0(F')\le2\), while rank EIGHT and degree minus SIX imply
at least TWO. It follows that \(F'=\mathcal O^2\oplus\mathcal O(-1)^6\).

## Nonzero projective derivative at the actual wild point

For a \(P\)-row, in a regular scalar frame the only nonzero-value
terms are \(r v_2\), with
\[
r v_2=\tfrac12e_0-t e_1+O(t^2)
\]
up to an invertible common unit.
The value is nonzero by base-point-freeness.
Its chain \(e_1\) derivative is transverse to the socle value.
Other basis terms contribute only socle first derivatives or start
at order at least TWO, and coarse coefficients have first possible
nonconstant term at order FIVE.
They cannot cancel the surviving \(e_1\) derivative.
This includes the third partition, where the value comes only from
the long \(J_5\).

For a \(P^3\)-row, the nonzero-value terms are
\[
u^{-1}r^3v_1=-e_0+t e_1+O(t^2)
\]
in the contributing blocks.
Their \(e_1\) directions are independent, and terms with \(j=0\)
add only socle derivatives.
The extra \(J_1\) term in the third partition likewise adds only
its own socle derivative.
Thus the projective derivative is again nonzero.
A unit frame change adds a multiple of the value, so does not change
the conclusion. The dual chain gives the same calculation.
The map to normalization is therefore separating, and is
unramified at these particular points.

## Faithful normalized image and the orbit bound force étaleness

Each row is nonconstant and nondegenerate, hence has an actual finite
map \(f:D\to D_{\rm row}\) to its normalized image.
The simple \(Q\) acts faithfully on that normalization:
if all \(Q\) fixed the image, an image point would be an invariant
projective line of the irreducible natural module or its dual.
Such a line does not exist.

The group \(Q\) cannot act faithfully on a rational curve.
To see this directly, it contains
\[
U=\left\{\begin{pmatrix}I_4&X\\0&I_4\end{pmatrix}:
                      X\in M_4(\mathbf F_5)\right\}
\]
and its normalizer contains the block-diagonal image of
\(SL_4(\mathbf F_5)\times SL_4(\mathbf F_5)\).
In \(PGL_2(k)\), a nonidentity order-five element has a UNIQUE fixed
point. Since \(U\) is abelian, all of \(U\), and then its normalizer,
fixes that point. A point stabilizer is affine and solvable.
The displayed Levi subgroup remains nontrivial perfect after its
scalar quotient, by elementary-root commutator identities.
It is nonsolvable, a contradiction.
Thus \(g(D_{\rm row})\ge1\).

For the actual separating map \(f\), its different is effective
and \(Q\)-invariant. Hurwitz gives
\[
\deg\operatorname{Diff}(f)
=|Q|/10-\deg(f)\bigl(2g(D_{\rm row})-2\bigr)\le |Q|/10.
\]
A nonempty invariant divisor on \(D\) has degree at least \(|Q|/5\).
Therefore the different is ZERO and \(f\) is finite ÉTALE.
Hurwitz then excludes row genus ONE, giving genus at least TWO.

No hypothesis on the normalized row's inertia was inserted.
The map may have degree greater than ONE and its quotient orbifold
may have larger inertia. No row identity, original source field,
Cartier map or endpoint descent follows.
BOTH original finite étale maps remain on their SAME original \(T\).
