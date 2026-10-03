# Proof: native equality slopes and the oriented orthogonal reduction

Version1, 3 October2026. [Independent scoped review PASS](../../Research/audits/OCT03_ZERO_GRAM_POWER_CONFINEMENT_AUDIT_2026_10_03.md); the actual lifted-row and paired-action clarifications are incorporated. No computation.

Use the semistability, zero-defect and rank/determinant alternatives of [the saturation theorem](canonical_ten_zero_gram_source_saturation.md), with its nonzero-row and compatible paired-action hypotheses. Put ω=ω_Γ and d=degω=N/TEN. Every genuine native line is ω^a for an integer a. The native rank-two quotients D_j=F_(2j)/F_(2j−2) are semistable of slope−d/TWO. The genuine native Q₄=F₈/O has determinantω⁻⁴ and wild Jordan type J₅⊕J₃.

## All required tail extensions are nonsplit

At a wild fiber use the two orbit polynomial model from the native power theorem. Put λ=h₊/h₋. Both h-values are nonzero and λ≠ONE. For ZERO≤k<j≤FOUR the quotient F_(2j)/F_(2k) has rank TWO m, m=j−k. Its polynomial model contains a ONE-dimensional surviving bottom degree-k quotient, TWO full coefficient directions in each degree k+ONE,…,j−ONE, and ONE top direction of degree j. The bottom degree-k line killed by F_(2k) has coefficient pair(h₊^k,h₋^k); the top degree-j direction has pair(h₊^j,h₋^j).

The logarithm of inertia translation is the derivative on polynomials of degree at mostFOUR. The top direction has a nonzero m-th derivative in the bottom quotient exactly when λ^m≠ONE. Thus
\[
\operatorname{Jord}(F_{2j}/F_{2k})=
\begin{cases}
J_{m+1}\oplus J_{m-1},&\lambda^m\ne1,\\
J_m\oplus J_m,&\lambda^m=1.
\end{cases}
\]
The zero second block is omitted. Here is a direct chain check: if the m-th derivative is nonzero, the unique top direction gives a length-(m+ONE) chain. An independent coefficient direction in degree j−ONE gives the remaining length-(m−ONE) chain after its bottom contribution is eliminated against the first. If that derivative is zero, the top chain has length m, and the independent degree-(j−ONE) direction has a nonzero (m−ONE)-st derivative in the bottom quotient, so gives the other length-m chain. Factorials ONE,…,FOUR are units in characteristicFIVE. This checks all endpoints without characteristic-ZERO logarithms.

For k=ZERO,j=FOUR this is Q₄, whose given Jordan type J₅⊕J₃ forces λ⁴≠ONE. Hence λ²≠ONE as well. The rank-TWO tails have type J₂. For m=TWO the type is J₃⊕J₁; for m=THREE it is either J₄⊕J₂ orJ₃⊕J₃; for m=FOUR it is J₅⊕J₃. None, for m≥TWO, equals the preceding length-(m−ONE) tail direct-summed with J₂:

- m=TWO compares J₃⊕J₁ with J₂⊕J₂;
- m=THREE compares J₄⊕J₂ orJ₃⊕J₃ with J₃⊕J₁⊕J₂;
- m=FOUR compares J₅⊕J₃ with J₄⊕J₂⊕J₂ orJ₃⊕J₃⊕J₂.

Therefore every native tail extension
\[
0\longrightarrow F_{2j-2}/F_{2k}\longrightarrow
F_{2j}/F_{2k}\longrightarrow D_j\longrightarrow0,
\qquad j\ge k+2,
\]
is nonsplit, since a native splitting would split its wild fiber as a C₅-module.

## The equality-slope rank-two subbundle is unique

Fix k=ZERO orONE and consider a genuine native rank-TWO subbundle A⊂F₈/F_(2k) with degA=−d. Choose the smallest j such that A is contained in F_(2j)/F_(2k). The intersection A′ with the preceding tail is saturated in A, and its quotient is the actual torsion-free image B in D_j. Both are native. The preceding tail and D_j are semistable of slope−d/TWO, so
\[
\deg A'\le-\operatorname{rk}(A')d/2,\qquad
\deg B\le-\operatorname{rk}(B)d/2.
\]
Their sum is degA=−d, so both inequalities are equalities. The image B cannot have rankONE: that would give a genuine native line of degree−d/TWO, contradicting the integer native degree lattice. By minimality B≠ZERO, so B has rankTWO and is ALL of D_j, with no torsion defect. The intersection is ZERO. Thus A→D_j is an isomorphism and splits the tail extension unless j=k+ONE. Nonsplitting proves
\[
A=F_{2k+2}/F_{2k}.
\]
This establishes the unique native equality-slope rank-TWO subbundle in both tails used below. It does not require ordinary stability of D_j.

## The equality-slope rank-four subbundle is unique

Let A⊂Q₄ be genuine native of rankFOUR and degA=−TWO d. Choose its smallest containing Q_j=F_(2j)/O. The same intersection-and-image argument gives a full rank-TWO D_j image and a rank-TWO equality-slope intersection with Q_(j−ONE): image rankONE is again impossible by the native degree lattice. The intersection must be Q₁ by the preceding uniqueness result. In particular Q₁⊂A. The quotient A/Q₁ is a native equality-slope rank-TWO subbundle of Q₄/Q₁=F₈/F₂. Applying the shifted uniqueness result gives A/Q₁=F₄/F₂. Thus A=Q₂=F₄/O.

The rankTWO and rankFOUR actual row cases from the saturation draft have exactly these slopes, so their untwisted images are Q₁ andQ₂.

## Rank three lies in the same native maximal isotropic

Let A=I M⁻⁶ have rankTHREE and determinantω⁻². It is a saturated isotropic native subbundle of Q₄. The perfect ω⁻¹-valued form gives the rank-TWO orthogonal reduction
\[
C=A^\perp/A,
\qquad\det C=\omega^{-1}.
\]
Indeed det(A^⊥)=detQ₄/(det(A*)ω⁻³)=ω⁻⁴/ω⁻¹=ω⁻³, and dividing by detA=ω⁻² gives ω⁻¹.

A rank-TWO perfect symmetric S-valued bundle with a genuine native orientation detC≅S splits into its two native isotropic lines in this setting. To see this directly, the wedge orientation and symmetric pairing define a skew adjoint endomorphism J of C whose square is a nonzero scalar multiple of the identity. That scalar is a global unit on the connected projective Γ, hence belongs to k×. CharacteristicFIVE is odd and k is algebraically closed, so J has two distinct constant eigenvalues. Their eigenlines are native, complementary and isotropic. Here S=ω⁻¹. The determinant identity is a genuine native identity, so the orientation and J commute with the native action. Thus C=ω^a⊕ω^(−1−a) for an integer a.

The inverse images of these two isotropic lines in A^⊥ are saturated rank-FOUR isotropic native subbundles of Q₄. Their determinants are ω^(a−2) andω^(−3−a). Semistability of Q₄ bounds each rank-FOUR degree by−TWO d, giving a≤ZERO and a≥−ONE. Hence a is ZERO or−ONE. The inverse image of the O_Γ isotropic line has determinantω⁻² and slope equality. By the rank-FOUR uniqueness theorem it is Q₂. Therefore A⊂Q₂.

Since detA=detQ₂=ω⁻², the rank-ONE quotient Q₂/A is the genuine native O_Γ. Saturation in Q₄ ensures that this quotient is locally free. This gives precisely the displayed integral kernel description.

## The original lifted row and rank-four generation

The preimage of Q₂=F₄/O in E°=F₈ is literally F₄. Therefore every lifted adjoint section of this actual W lies in M⁶F₄. These are its actual columns or linear combinations; individual orbit columns from a larger complete module need not satisfy this confinement. This uses the actual projection and its retained compatible lift.

In the rankFOUR case put J=M⁶F₄ and let H be the ACTUAL image of the lifted source in J. The retained compatible action preserves this actual image. Both J and H are paired-projective; after tensoring by M⁻⁶ their actions are genuine native. Its projection onto I=M⁶Q₂ is surjective as sheaves because I is the actual projected image. If H had rankFOUR, that projection would be an isomorphism and would give a genuine native splitting of 0→O→F₄→Q₂→0 after untwisting. At a wild fiber F₄ is J₃⊕J₂, whereas Q₂ is J₃⊕J₁ by the tail formula and λ²≠ONE. A splitting would produce J₃⊕J₁⊕J₁, impossible. Hence H has rankFIVE.

The quotient J/H is torsion with a G-invariant length divisor, and degJ=FIVE·THREE N/FORTY−TWO N/TEN=SEVEN N/FORTY. Genuine nativity of J is neither needed nor asserted: its determinant degree is outside the native lattice. Since H is globally generated, degH≥ZERO. Its determinant defect therefore has degree at mostSEVEN N/FORTY<N/FIVE, the smallest orbit size. The invariant-orbit budget makes this defectZERO. Thus H=J and the original lifted W row globally generates M⁶F₄.

For a specified dimensionEIGHT source, its actual surjection onto this rankFIVE row has a rankTHREE locally free kernel. The original horizontal map is still rankTHREE on T; relating that horizontal source to this relation bundle remains the next task.
