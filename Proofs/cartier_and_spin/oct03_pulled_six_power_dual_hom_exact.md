# Proof: the higher native boundary survives actual degree-one pullback

Version1,3 October2026. [Fresh independent whole audit](../../Research/audits/OCT03_PULLED_SIX_POWER_DUAL_HOM_EXACT_AUDIT.md): mathematical PASS allEIGHT tasks, no repair; the eight exact review tasks are retained below. Inputs are the [native two-power self-extension theorem](canonical_ten_native_two_power_self_extension_classes.md), [adjacent actual power tails](canonical_ten_adjacent_native_power_tail_classes.md), [actual pulled scalar torsor and Hom](canonical_ten_pulled_native_scalar_torsor_and_hom.md), [power flag](canonical_ten_power_filtration_and_four_row.md), and the [native first-jet obstruction](canonical_ten_zero_gram_zero_top_native_shear_nonsplitting.md). The actual marking is the [retained wild-fiber marking](canonical_ten_power_quotient_wild_marking.md). Retain BOTH actual endpoint maps ontheir SAME original source. Every cohomology comparison uses actual𝒫, not a replacement bundle with matching degree.

Write𝒮=[Γ/G],ω=ω_Γ, D=F₂/O. The accepted normalized invariant weak frame is
\[
P(u)=\begin{pmatrix}u^2&-u^3\\0&1\end{pmatrix},\quad
U=u\operatorname{Id},\quad
\Xi=\begin{pmatrix}2u&3u^4\\u^{-2}&-2u\end{pmatrix},
\]
witht=u⁻¹, f a fixed nonzero multiple ofu⁵−u. Setx=(u⁵−u)⁻¹, R=k[[t]], O=k[[x]]. Regular-to-invariant row conversion forD* is(a,b)P=(au²,−au³+b). All retained constants may be normalized as in the accepted native class theorem; the cohomology arguments preserve the specified end terms.

## Exact native cohomology of D* andω

An invariant row(a,b), with coefficients ink((x)), is regular exactly whena∈xO andb∈O. At the finite tame or ordinary points both are regular. Thus the coarse invariant sheaf ofD* isO_P¹(−∞)⊕O_P¹. Its H¹ iszero andH⁰ is the single quotient row(0,1).

For completeness the local higher dimension can be read from the exact norm lattice. The completedR is free overO with basis1,t,…,t⁴. Regular row generators in invariant coordinates are
\[
(t^{j+2},t^{j-1}),\quad(0,t^j),\qquad j=0,\ldots,4.
\]
Their norms are entrywise traces. Use the accepted exact identitiesTr(t^i)=(−1)^i x^i fori=1,…,4, Tr(t⁵)=−x⁵, Tr(t⁶)=−x²+x⁶, andTr(u)=Tr(1)=0. In invariant coordinates(a/x,b), all norms belong toxO⊕xO. The firstj=0 row yields(x,0), and the secondj=1 row yields(0,−x); thus the norm lattice is exactlyxO². CompletedH² has lengthTWO.

The normal-basis lattice argument in the accepted native proof makes H¹ andH² lengths equal: generically the semilinear space isTWO copies of the regular representation, a freeO[C₅] lattice has zero Tate cohomology, and finite-index lattice comparison preserves the difference of the two periodic cohomology lengths. Hence completedH¹ has dimensionTWO. Since the tame stabilizer has no higher cohomology and coarseH¹ vanishes, degree-one Leray gives
\[
H^0(\mathcal S,D^*)=k,\qquad \dim H^1(\mathcal S,D^*)=2.
\]

Likewise the invariant cotangent frame is a fixed multiple ofdf=u²dt. Its regular coefficient lattice is t²Rdf, with fixed lattice xOdf. The norm of t²R isx²O, by tracingt²,…,t⁶. CompletedH² andH¹ consequently have lengthONE. The coarse invariant canonical sheaf isO(−∞): finite tame regularity permits no pole of a coefficient ofdf, and wild regularity requires one zero inx. It has noH⁰ orH¹. Therefore
\[
H^0(\mathcal S,\omega)=0,\qquad \dim H^1(\mathcal S,\omega)=1.
\]
The native principal-parts class0→ω²→P¹ω→ω→0 is nonzero by the accepted weak-wild connection obstruction, hence generates this latter space. AlsoH¹(𝒮,O)=k with generatoru, from the accepted scalar cohomology theorem.

The sequence0→O→D*→ω→0 now gives an injective scalar lineH¹O→H¹D*, with image represented by(0,u), and a surjectionH¹D*→H¹ω. IndeedH⁰ω=0, H¹D* has dimension2 andH¹ω dimension1. Exactness and dimension force the asserted surjection. Its kernel is precisely the scalar line.

## The actual first pushout vanishes already natively

PushU andΞ alongD→O, the row(0,1). The resulting row cochains are(0,u) and(u⁻²,−2u). But(u⁻²,u) is a REGULAR row because its product withP is(1,0). Thus
\[
[\Xi]_{D\to O}=2[U]_{D\to O},\qquad
[U+2\Xi]_{D\to O}=0
\]
in characteristicFIVE. The coarseH¹ ofD* iszero, so this local equality is the global native equality, using the accepted exact original first-tail normalization. In particular the pushout ofF₄/O to anO-kernel is split natively. This does not splitF₄/O itself.

LetZ₂ be the native scalar unipotent extension. PutA₄=D⊗Z₂=F₆/F₂ and let
\[
\gamma\in\operatorname{Ext}^1_{\mathcal S}(A_4,O)
=H^1(\mathcal S,D^*\otimes Z_2^*)
\]
be the pushout of0→D→F₆/O→A₄→0 alongD→O. Its middle bundle is EXACTLY F₆/F₁, sinceker(D→O)=F₁/O. Restrictingγ to the firstD⊂A₄ gives the preceding actual first-tail pushout, hence iszero.

The classγ itself is NONZERO natively. The actual wild fiberF₆ has Jordan typeJ₄⊕J₃ by the accepted seven-vector power saturation. F₁ is its full two-dimensional socle, soF₆/F₁ has typeJ₃⊕J₂. A native split middleO⊕A₄ would have typeJ₁⊕J₃⊕J₁, because the acceptedA₄=D⊗Z₂ has typeJ₃⊕J₁. These types differ, so the native extension cannot split.

Dualizing the scalar extension gives0→D*→D*⊗Z₂*→D*→0. Its H⁰ boundary takes the quotient generator to the nonzero scalar class(0,u); nonzeroness follows also from the injectiveH¹O→H¹D* above. Thus its H¹ map has kernel that scalar line. Sinceγ restrictszero and isnonzero, it comes from a class
\[
\eta\in H^1(\mathcal S,D^*)
\]
whose projection toH¹(𝒮,ω) isnonzero. Different liftsη differ by the scalar line. This identifies the remaining higher native boundary exactly as the nonzero quotient ofH¹D* by its scalar line.

## Native first jets remain nonzero under the ACTUAL marked pullback

The actual carrier and freeq define𝒫 from native bundles toordinary bundles onY. The retained genuine identityφ*ω=q*O(P) identifies𝒫ω=O(P), and𝒫ω²=ω_Y. Pulling the native principal-parts extension gives
\[
0\to\omega_Y\to Q\to O(P)\to0,
\qquad e_Y\in H^1(O(P)).
\]
Push its kernel through the ACTUAL natural cotangent mapO(P)→ω_Y, whose zero divisor isP. The pushed sequence is the ordinary principal-parts extension ofO(P), by functoriality of first jets under the actualφ and étale descentq. Its kernel isO(P)⊗ω_Y=O(3P). This is a pushout byω_Y→O(3P), not a claim that the pulled extension was alreadyP¹O(P).

The class of P¹O(P) is nonzero inH¹(ω_Y). If it split, O(P) would admit a regular connection. In the meromorphic canonical section ofO(P), the resulting connection form has its sole residueONE atP (up to the fixed sign convention); the residue theorem giveszero total residue, a contradiction in characteristicFIVE. This is the elementary degreeONE connection obstruction.

The kernel pushout inducesH¹O(P)→H¹ω_Y, multiplication by the section ofO(P). It is an isomorphism: Serre-dually it is the nonzero mapH⁰O→H⁰O(P), both one-dimensional. Thus e_Y isnonzero. SinceH¹(𝒮,ω) isone-dimensional and its generator is the native first-jet class, the ACTUAL pullback map
\[
H^1(\mathcal S,\omega)\longrightarrow H^1(Y,O(P))
\]
is injective. No regular native or ordinary connection has been selected; no connectedness of a further scalar-torsor pullback is used.

## The higher ordinary boundary is nonzero and gives the exact Hom space

LetV=𝒫D andZ=𝒫Z₂. The accepted scalar-pullback theorem givesh⁰V*=1 andh⁰(V*⊗Z*)=Hom(V,Z*)=2. In the ordinary scalar-extension cohomology sequence, its H⁰ boundary isthereforezero and
\[
H^1(V^*)\longrightarrow H^1(V^*\otimes Z^*)
\]
is injective. The pullbackη_Y has nonzero projection toH¹O(P) by the preceding injectivity and functoriality. Henceη_Y≠0, and its imageγ_Y isnonzero. Scalar ambiguity causes no problem: its actual pullback iszero inH¹V*, since the accepted pulled scalarU is the boundary ofH⁰O(P) in0→O→V*→O(P)→0.

Finally applyHom(−,O) to the ACTUAL pulled sequence0→V→B→V⊗Z→0. The boundary of its one-dimensionalHom(V,O) sends the quotient generator toγ_Y≠0. Thus every mapB→O killsV and
\[
\operatorname{Hom}(B,O)\simeq\operatorname{Hom}(V\otimes Z,O)
=\operatorname{Hom}(V,Z^*)
\]
has dimensionTWO. The original unit/counit splitting𝒫F₆=O⊕B makes the final total dimensionTHREE and identifies the unit-killing subspace precisely. Neither the actual original evaluation nor a finite coefficient module is identified by this ordinary Hom calculation.

## Eight independent focused audit tasks

1. Check the exact coarse invariantD* andω sheaves, norm lattices, completedH¹/H² dimensions and native Leray conclusions; retain exact weak parameter and no averaging.
2. Check the trace-FREE Ξ matrix, regular-row pushout relationΞ↦2U, and actual first-tail pushoutZERO globally.
3. Check exact identification of the new native middleF₆/F₁ and its wildJ₃⊕J₂ type, versus splitO⊕(D⊗Z₂).
4. Check the native scalar-extension H⁰ boundary, exact kernel restriction and nonzero projection of the higher classη toH¹_nativeω.
5. Check ACTUAL line pullback𝒫ω=O(P), the natural cotangent pushout, étaleq descent and functoriality of principal parts without replacing the source or line.
6. Check nonzero degree-one Atiyah class by residues and isomorphismH¹O(P)→H¹ω_Y; verify it proves injectivity of actual nativeH¹ω pullback.
7. Check ordinary scalar-extension cohomology using the acceptedHom(V,Z*)=2, the nonzero pulledγ, and all scalar ambiguities.
8. Check the final ordinary Hom dimensionTWO/totalTHREE and precise first-stage annihilation, with BOTH original maps/action retained. This is not a finite-source realization or a GramFOUR/common-cover exclusion. No computation or foundation replay is needed.
