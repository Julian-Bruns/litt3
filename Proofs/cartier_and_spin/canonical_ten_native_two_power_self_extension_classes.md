# Proof: invariant lattices, traces and the actual two-power self-extension

Version1, 3 October2026. Independently audited direct theoretical argument; all ten focused checks passed in [the review](../../Research/audits/OCT03_NATIVE_TWO_POWER_SELF_EXTENSION_AUDIT.md). No computational certificate is needed. A small independent bounded quotient experiment is preserved in Research/experiments/oct03_native_local_end_cohom.py and ../litt3-computation-data/oct03_native_local_end_cohom/truncations.json. It checks only finite truncations, not the completed or global statements proved below. Both actual endpoint maps remain onT whenever this native result is applied to an original source.

Use the accepted actual quotient π:Γ→P¹, with one weak cyclic-FIVE point abovef=∞ and one tame involution point abovef=ZERO. Write S=[Γ/G] andω=ω_Γ. The accepted unique native extensionD fits0→ω⁻¹→D→O→0. We may normalize its nonzero endpoint scalar once, without changing its native isomorphism class.

## The exact native local frame

At the weak point put u=ONE/t and chooseσu=u+ONE. The invariant base coordinate is a nonzero constant multiple off=u⁵−u. Take an invariant rational framee₁ forω⁻¹ proportional todu⁻¹, and a rational invariant lift e₂ ofD's unit quotient. The local regular basis may be chosen as the columns of
\[
P(u)=\begin{pmatrix}u^2&-u^3\\ZERO&ONE\end{pmatrix}.
\]
Indeed the first column is the regulardt⁻¹ frame, up to a constant. The second differs frome₂ byu³e₁, the accepted nonzero weak extension cochain. Terms of degree at mostTWO in this cochain can be absorbed by a regular local basis change. Our sign fixes a representative of the nonzero native extension; reversing it gives an isomorphicD.

The action in the regular frame is
\[
P(u)^{-1}P(u+z)=
\begin{pmatrix}
(ONE+zt)^2&-(THREE z+THREE z^2t+z^3t^2)\\
ZERO&ONE
\end{pmatrix},\qquad z\in F_5.
\]
This is also the exact frame convention in the bounded quotient experiment.

For an invariant-frame matrixA=(a,b;c,d) the regular-frame expression is
\[
P^{-1}AP=
\begin{pmatrix}
a+c u^3&(d-a)u-cu^4+bu^{-2}\\
cu^2&d-cu^3
\end{pmatrix}.
\tag{1}
\]
This formula is the basis of all subsequent integral and cohomological claims.

## The coarse endomorphism bundle has no H¹

Outside the wild point, theD extension splits over the affine coarse line: there are only tame stabilizers, whose higher coherent cohomology vanishes, and the coarse line is affine. Thus e₂ can be chosen as a regular lift there, whilee₁ is the invariantdf⁻¹ frame. The accepted local class permits the exact transitionP after a compatible frame normalization. An invariant local correction has a finite polar part polynomial inf; each positive f-power timesdf⁻¹ is regular on this finite coarse line, including the tame origin, so that polar part can be removed from the finite lift. Its remaining invariant regular part and the regular local coboundary can be absorbed in the wild regular basis. Thus this normalization does not presume a global Artin–Schreier coordinateu onΓ.

At tamef=ZERO the regular frame is diag(t,ONE) times this invariant frame, up to units. Hence an invariant endomorphism must have a,d,c regular and b divisible byf. At all ordinary finite points all four entries are regular.

At the weak point write x=(u⁵−u)⁻¹. The invariant coefficients belong tok((x)). Equation(1), and the fact that their valuations in t are multiples ofFIVE, give exactly
\[
a,d,b\in k[[x]],\qquad
c\in xk[[x]],\qquad a-d\in xk[[x]].
\tag{2}
\]
For clarity, cu² regular first forcesc to vanish once inx. Thena,d are regular. A pole ofb would makebu⁻² have leading degree at leastTHREE, uncancelable by the other terms; so b is regular. Finally(d−a)u forcesa−d to vanish once. These conditions are also sufficient.

Consequently the coarse invariant sheaf is literally, in the invariant matrix coordinates,
\[
\pi_*\operatorname{End}(D)
=O\operatorname{Id}
\oplus O(-\infty)\operatorname{diag}(ONE,-ONE)
\oplus O(-ZERO)E_{12}
\oplus O(-\infty)E_{21}.
\tag{3}
\]
Thus H⁰ is the scalar line andH¹ isZERO. The trace-free part has coarse bundleO(−ONE)^THREE. All statements use the actual native extension frame; no ordinary splitting or wild averaging is assumed.

## The completed cyclic cohomology has dimensionTWO

Let R=k[[t]], O=k[[x]], and M=End_R(D). The invariant lattice(2) has coordinates
\[
z=(a+d)/TWO,\quad h=(a-d)/x,\quad b,\quad v=c/x.
\]
It is free of rankFOUR overO. The local higher cohomology is cyclic-group cohomology for this exact lattice.

The trace on the weak degreeFIVE local field has
\[
\operatorname{Tr}(u^j)=ZERO\ (ZERO\le j\le THREE),\quad
\operatorname{Tr}(u^4)=-ONE,
\]
and
\[
\operatorname{Tr}(t^j)=(-ONE)^j x^j\quad(ONE\le j\le FOUR),\qquad
\operatorname{Tr}(t^6)=-x^2+x^6.
\tag{4}
\]
These follow from the polynomialu⁵−u and its logarithmic derivative. For the last identity use t⁵=x−xt⁴ andmultiply byt. The completedR is free overO with basisONE,t,t²,t³,t⁴, by the Eisenstein equationt⁵+xt⁴−x=ZERO.

Regular matrix generators in the invariant frame areP E_ij t^j P⁻¹. Their norms are entrywise local traces, because that frame is invariant. In particular the following four norms have coordinates(z,h,b,v):
\[
\begin{array}{c|rrrr}
\text{regular generator}&z&h&b&v\\
E_{11}t&-x/TWO&-ONE&ZERO&ZERO\\
E_{21}t^2&ZERO&TWO&ZERO&x^3\\
E_{21}&ZERO&ZERO&ONE&x\\
E_{21}t^4&ZERO&TWO x^2&ZERO&-x+x^5.
\end{array}
\tag{5}
\]
The notation names the regular-frame matrix before itsP conjugation.

Subtract x² times the second row from the fourth to obtain purev=−x. Then eliminatev from the second and third rows, yielding a unit in each ofh andb. Eliminateh from the first to obtain purez=−x/TWO. Conversely all regular generators have normz divisible byx and normv divisible byx: z is a trace of a regular coefficient, and v is a multiple ofTr(t^(j+TWO))/x forZERO≤j≤FOUR, each divisible byx. Norms automatically satisfy(2). Thus the norm lattice is exactly
\[
xO\oplus O\oplus O\oplus xO
\]
in the four invariant coordinates. Therefore completedH² has lengthTWO.

CompletedH¹ has the same length. Here is the lattice justification rather than an extrapolation from truncations. Generically the semilinear endomorphism space is FOUR copies of the regular cyclic representation, by the normal-basis theorem. Choose a freeO[C₅] lattice in that generic space and compare it withM via their common finite-index intersection. For any finite-length cyclic module the two Tate cohomology groups have equal length, directly from the ranks of difference and norm on its finite-dimensionalk-space. Their length difference is additive along the periodic exact Tate sequence. The free group-algebra lattice has zero Tate cohomology, so M's H²-minus-H¹ length isZERO. All these groups are finite because generic cohomology vanishes. Hence H¹ has lengthTWO.

The same argument forO_Γ gives completedH¹ of dimensionONE: its fixed lattice isO and its trace ideal isxO. Globally its coarse sheaf isO_P¹ withH¹=ZERO. ThusH¹(S,O)=k.

## Explicit independent completed classes

The scalar cochainU=uId has regular differenceId and is nonzero: u cannot be made regular by subtracting an invariant rational function ofu⁵−u. It has nonzero trace class inH¹(S,O).

For the trace-free matrixΞ in the statement, putδA=A(u+ONE)−A(u). Its lower-left entry has expansion
\[
\delta(u^{-2})=-TWO u^{-3}+THREE u^{-4}+O(u^{-5}).
\]
SubstituteδΞ into(1). The diagonal constant terms cancel; its lower-left term is regular and vanishes at t=ZERO. In the upper-right term the coefficients ofu andONE cancel because
\[
\delta(THREE u^4)=TWO u^3+THREE u^2+TWO u+THREE.
\]
ThereforeδΞ is regular and its ENTIRE closed-fiber matrix isZERO.

This class is nevertheless nonzero. IfΞ became regular after subtracting an invariant matrix, the c-entry regularity forces the invariant correctionc to vanish once inx. Corrections to the diagonal cannot then cancel the nonzero orderu term in a+cu³: invariant diagonal poles have degrees divisible byFIVE, while an invariantc correction contributes degree congruentTHREE moduloFIVE. The remaining2u+u=THREE u pole cannot disappear. ThusΞ is a nonzero completed class.

Trace splitsEnd(D)=O·Id⊕End₀(D), sinceTWO is a unit. U andΞ are independent. The computed dimensionTWO makes them a basis; the trace-free summand is one-dimensional. The tame higher cohomology isZERO, and the coarseH¹ vanishes by(3). DegreeONE Leray therefore identifies the global nativeH¹(EndD) with this completed two-dimensional space. This proves the first theorem assertions.

## The exact class of the actual power extension

Use the original wild saturation model. Put A(t)=a₊(t)+a₋(t), B(t)=a₊(t)a₋(t), with nonzero constantsA₀,B₀ andA₀²=THREE B₀. Write
\[
t_2=(df)^2/f=\beta(t)t(dt)^2,\qquad
\beta(t)=\lambda/(ONE-t^4),\quad \beta_0=\lambda\ne ZERO
\]
in the exact fixed-f Artin–Schreier parameter. Units and these constants are retained throughout.

OnΓ away from the wild orbit, invariant rational bases for the firstD and its quotientD are given by raw powers
\[
(s,\ s^2/t_2),\qquad (s^3/t_2,\ s^4/t_2^2),
\]
where each negative-line basis is read in the invariant frameλdf⁻¹. The division by the indicatedt₂ powers is exactly the accepted wild zero divisor in each power grade. On the firstD the regular-to-invariant matrix isP₁=[[u²,−a(t)u³],[ZERO,ONE]], a(t)=A(t)/β(t). On the second it isP₂=[[u²,−TWO a(t)u³],[ZERO,ONE]]. These follow directly from t⁻¹Q(s) andt⁻²Q(s)² in the supplied saturation basis.

Multiply the secondD's negative-line basis byTWO. Its transition is nowidentical toP₁; this specifies the native isomorphism of both end terms. It is defined on the complement of the wild orbit and extends integrally there because their matrices agree, so it is a genuine global native identification.

The lower-to-upper cross block of the actual rankFOUR regular basis, after this normalization, is
\[
R=
\begin{pmatrix}
TWO B(t)\beta(t)^{-1}u^3&-TWO A(t)B(t)\beta(t)^{-2}u^4\\
-TWO A(t)&(A(t)^2+TWO B(t))\beta(t)^{-1}u
\end{pmatrix}.
\]
Indeed the actual saturated cubic is t⁻¹(s³−A s²+B s) and the quartic is t⁻²(s⁴−TWO A s³+(A²+TWO B)s²−TWO ABs+B²), modulo the primitive unit. Reexpressing them in the displayed raw invariant bases gives this block.

The extension cochain in the common invariantD frame isRP₁⁻¹, exactly
\[
C=
\begin{pmatrix}
TWO B(t)\beta(t)^{-1}u&ZERO\\
-TWO A(t)u^{-2}&(-A(t)^2+TWO B(t))\beta(t)^{-1}u
\end{pmatrix}.
\tag{6}
\]
Its sign depends on the chosen Cech convention and only changes the common scalar of the resulting projective class.

Only the constants ofA,B,β contribute to this cohomology class. To justify this assertion, the difference from constant coefficients has diagonal entries constant-plusO(t), and c-entryO(t³). Constant invariant matrices may be subtracted. DiagonalO(t) matrices are regular by(1). Terms of the c-entry of order at leastFOUR are regular. For a c-term proportional tot³, subtract the regular matrixP E₂₁tP⁻¹: it has the same c term, invariant constant diagonal terms, and a b term proportional tou³. The latter cochain is regular modulo an invariant constant trace-free diagonal matrix, again by(1). Thus the entire higher-series remainder is cohomologicallyZERO. The lattice itself is unchanged by replacinga(t) witha₀, since their transition matrices differ by a regular unipotent basis change. No derivative ofa₊ or a₋ has been assumed to vanish.

Finally simultaneously rescale the negative-line invariant bases of bothD terms bya₀=A₀/β₀. This normalizesP₁ toP(u) in the statement. UsingA₀²=THREE B₀, formula(6) becomes, up to the nonzero scalarv₀=B₀/β₀,
\[
v_0\begin{pmatrix}TWO u&ZERO\\-u^{-2}&-u\end{pmatrix}.
\]
The regular matrixL=P E₂₁P⁻¹ is
\[
L=\begin{pmatrix}-u&-u^4\\u^{-2}&u\end{pmatrix}.
\]
Direct entrywise subtraction gives
\[
v_0\begin{pmatrix}TWO u&ZERO\\-u^{-2}&-u\end{pmatrix}
=v_0(THREE U+\Xi-TWO L).
\]
SinceL is regular, the extension class isv₀(THREE[U]+[Ξ]), whose projective normalization is[U+TWOΞ]. This identifies the actual power extension, not just a fiber representation.

The scalar extensionU alone isD tensored with the nonzero nativeO-by-O unipotent extension. It has wild typeJ₃⊕J₁: its fiber is the tensor of twoJ₂ blocks, with nilpotent ranksTWO,ONE,ZERO. The actual power extension has the same fiber becauseΞ's fiber cocycle isZERO, but its native class has an additional nonzero trace-free component. An isomorphism preserving the self-extension cannot remove that component; the native endpoint automorphisms are scalar.

Even an abstract native isomorphism of these middle bundles would preserve the unique native equality-slope rankTWO subbundleD. Indeed a different such subbundle either projects onto the quotientD and splits the nonzero extension, or has rankONE image, forcing a genuine native line of forbidden degree−degω/TWO by slope equality. Hence it is the specifiedD. Thus the actual power bundle is not native-isomorphic to the pure scalar tensor extension. No actual finite-source exclusion follows from this distinction.
