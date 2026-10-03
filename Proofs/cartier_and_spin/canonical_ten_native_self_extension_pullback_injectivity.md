# Proof: a global traceless Higgs field detects the pulled invisible class

Version1, 3 October2026. Independently audited direct argument; all eight focused checks passed in [the review](../../Research/audits/OCT03_NATIVE_SELF_EXTENSION_PULLBACK_INJECTIVITY_AUDIT.md). Use the audited native classesU,Ξ in [the self-extension proof](canonical_ten_native_two_power_self_extension_classes.md), the actual [wild-fiber marking](canonical_ten_power_quotient_wild_marking.md), and the scalar pullback argument in [the torsor/Hom proof](canonical_ten_pulled_native_scalar_torsor_and_hom.md). No numerical computation is used.

Write P for the retained Weierstrass point andσ_P for a nonzero canonical section ofO(P). The actual pulled bundle has
\[
ZERO\longrightarrow O(-P)\longrightarrow V\longrightarrow O\longrightarrow ZERO.
\]
Use the global rational negative-line frameσ_P⁻¹ and the pull of the compatible native quotient lift. Away from the actual wild pair this lift is regular, as in the native construction. At each R_j the regular quotient lift is e₂−e_jσ_P⁻¹ with
\[
e_j=g_j(t)/t,\qquad g_j(0)=\gamma a_j,\quad\gamma\ne ZERO
\]
for ONE common constantγ. Here a_j is the original different coefficient in the common dt frame. This follows by transporting the SAME native negative-line frame toσ_P⁻¹: its ratio is g_j(t)t², and the native quotient correction u³ becomesg_j(t)/t. All higher unit coefficients remain in g_j(t).

In this SAME global rational frame the pull ofΞ has local matrix
\[
\Xi_Y=
\begin{pmatrix}
TWO/t&THREE g_j(t)/t^2\\
ONE/g_j(t)&-TWO/t
\end{pmatrix}.
\tag{1}
\]
It is obtained by conjugating the native invariant-frameΞ by diag(g_j(t)t²,ONE). Thus it is the actual pulled cochain, not an arbitrary ordinary representative with the same fiber.

Retain the actual endpoint coordinates w²=h z⁵+c z⁴−ONE, η=dz/w, η₀=zη. At z=ZERO we may label the wild points by w₊=TWO andw₋=−TWO. Their common differential transport is
\[
\eta=c_*a_jdt+O(t)dt,\qquad
z'(R_j)=c_*w_ja_j.
\tag{2}
\]
The same nonzero constantc_* occurs at both points. The accepted ratio r=a₊/a₋ satisfiesr²−r+ONE=ZERO. In particular r³=−ONE, r⁴=−r, andr+r⁻¹=ONE.

## Construct a global regular traceless Higgs field

In the rational V frame seek
\[
\Psi=
\begin{pmatrix}
k\eta&b\\
\eta_0&-k\eta
\end{pmatrix}.
\tag{3}
\]
The lower entry is interpreted as the sectionη₀σ_P ofωO(P), while the upper entry is a section ofωO(−P)=O(P), expressed in the rational frameσ_P⁻¹. The diagonal entries are global holomorphic differentials.

Changing to the regular local basis [[ONE,−e_j],[ZERO,ONE]] gives diagonal entries kη+e_jη₀ and−kη−e_jη₀, which are regular sinceη₀ vanishes atR_j. The upper entry is
\[
b-TWO k\eta e_j-\eta_0e_j^2.
\]
It is regular precisely when b has the corresponding simple principal part there. By(2) this required residue coefficient, in the σ_P⁻¹ frame, is
\[
TWO k c_*\gamma a_j^2+c_*^2\gamma^2w_ja_j^4.
\tag{4}
\]
There is no higher-order pole:η₀ has a simple zero ande_j has a simple pole.

The obstruction to a global section b ofO(P) with these TWO prescribed simple principal parts lies inH¹O(P), which is one-dimensional. Its Serre-dual section isσ_P ofωO(−P)=O(P). Multiplying the upper section byσ_P removes the rational negative-line frame, so the obstruction is exactly the sum of the residues(4). Choose
\[
k=-\frac{c_*\gamma\sum_jw_ja_j^4}
{TWO\sum_ja_j^2}.
\tag{5}
\]
The denominator is nonzero becausea₊²+a₋²=a₊a₋. The principal-parts exact sequence for O(P)⊂O(P+R₊+R₋) and Serre duality then supplies b with precisely those principal parts and no other poles as a line-bundle section. Thus(3) is a global regular traceless Higgs field. Its possible nonuniqueness byH⁰O(P) does not affect the calculation below: adding such a global upper section changes the trace pairing withΞ by a globally regular differential.

## Compute the ordinary Serre pairing

The ordinary self-extension/Higgs pairing is the sum of residues ofTr(Ξ_YΨ). From(1), (3) and the prescribed principal part ofb, its residue at R_j is
\[
k c_*a_j-c_*^2\gamma w_ja_j^3.
\tag{6}
\]
Indeed the two diagonal terms contributeFOUR kη/t. The lower-left Ξ entry multiplied byb contributesTWO k c_*a_j+c_*²γ w_ja_j³. The upper-right Ξ entry multiplied byη₀ contributesTHREE c_*²γ w_ja_j³. In characteristicFIVE their sums reduce exactly to(6). Only the displayed constant terms enter these residues; no derivative ofg_j or a_j has been set toZERO.

Put a=a₋. The accepted ratio gives
\[
\sum_ja_j=(r+ONE)a,\quad
\sum_ja_j^2=ra^2,\quad
\sum_jw_ja_j^3=a^3,
\]
\[
\sum_jw_ja_j^4=-TWO(r+ONE)a^4.
\]
Formula(5) becomesk=c_*γ(r+ONE)a²/r. Summing(6), and using(r+ONE)²/r=THREE, gives
\[
\boxed{\langle f_{\rm st}^*\Xi,\Psi\rangle
=TWO c_*^2\gamma a^3\ne ZERO.}
\]
A common opposite Cech sign changes this nonzero value by a sign. Thus the pulled trace-free class is nonzero in ORDINARY self-Ext.

The pulled scalarU has nonzero trace by the actual scalar principal-parts calculation. SinceΞ is trace-free, these two pulled classes are independent. The native space has basisU,Ξ, so its pullback is injective.

## Ordinary bundle distinctions

The marked V is stable. Any subline of degree at leastZERO would project nontrivially to its quotientO, since its map toO(−P) isZERO. A line of positive degree cannot map toO; a degree-ZERO line mapping toO must beO itself, with no divisor loss, and would split the nonzero extension. Both are impossible. Hence every subline has degree at most−ONE, proving stability of rankTWO, degree−ONE V. ThereforeEnd(V)=k. Riemann–Roch forEnd(V), rankFOUR degreeZERO on genusTWO, givesdimExt¹(V,V)=FIVE.

Each of the three pulled adjacent extensions is nonzero and is semistable of slope−ONE/TWO. Its equality-slope rank-two V subbundle is unique. A second such subbundle has rankONE orTWO image in the quotient. RankONE forces equality slope−ONE/TWO for an integer-degree line, impossible. RankTWO has no loss and splits the extension, also impossible. Thus an ordinary isomorphism of middle bundles would preserveV, and its endpoint automorphisms are scalar. The three distinct projective classes remain distinct under the injective pullback, so their ordinary middle bundles are pairwise nonisomorphic.

The conclusion does not identify a source connection or Cartier root, and both original endpoint maps remain on their originalT.
