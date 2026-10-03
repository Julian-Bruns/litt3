# Proof: the exact scalar connection equation and the fixed quotient plane

Version1, 3 October2026. [Independent focused audit](../../Research/audits/OCT03_RANK_FOUR_FACTOR_FOUR_TORSION_CLASSES_AUDIT.md): PASS allNINE checks; the separately audited prerequisite also passed. Input is the factor-branch refinement F_Y^*N=O with original adjoint proportional tozη. This proof makes no uniqueness assumption onHom(N,B_Y).

## The connection equation forces the logarithmic eigenline

Represent N=O_{Y₁}(D₁), and letD be the corresponding divisor onY under the relative coefficient identification. A global trivialization ofF_Y^*N=O is multiplication by a rational g with divg=FIVE D. Its canonical Cartier connection in this global frame is d−σ, where σ=dlogg. This form is regular: all orders ofg are multiples ofFIVE, so the pole residues in its logarithmic derivative vanish. Thus σ=(A+Bz)η for constantsA,B.

The rational source frameONE maps, under the original inclusion N→B_Y⊂F_{Y*}ω_Y and its adjoint, to g zη up to a nonzero constant. It is therefore CartierZERO. Since z is separating, CartierZERO of p(z,w)dz is equivalent to (d/dz)⁴p=ZERO. Conjugating this fourth derivative by g gives
\[
\left(\partial_z+\frac{A+Bz}{w}\right)^4\frac z w=ZERO.
\]
This is an exact rational identity, not a local truncated test.

Here is a short universal recurrence verifying its consequences. Put H=(c−ONE)z⁵+cz⁴−ONE and H′=FOUR cz³. Starting P₁=ZERO,Q₁=z, represent (P_r+Q_rw)/H^r. One application of the operator gives
\[
P_{r+1}=H P_r'-rH'P_r+(A+Bz)Q_rH,
\quad
Q_{r+1}=H Q_r'+(THREE-r)H'Q_r+(A+Bz)P_r.
\]
After FOUR applications, the constant z-coefficient ofP₅ is A³. Since ONE,w are independent overk(z), vanishing forces A=ZERO. With A=ZERO the exact identities simplify to
\[
P_5=ZERO,\qquad Q_5=z^5H^2(B^4-c^2).
\]
Thus B⁴=c², with B≠ZERO. The recurrence can be checked directly with the displayed formulas; the [standard-library verifier](../../Research/experiments/oct03_rank_four_factor/check_connection_operator.py) executes these THREE exact assertions in the universal ringF₅[A,B,c,z]. Its [small certificate](../../../litt3-computation-data/oct03_rank_four_factor/connection_operator.json) records PASS onPython3.14.7. No search is used. The same formulas prove sufficiency for the operator identity.

## The four classes are explicit

Choose a²=c and put g₀=w−az². Differentiating w²=H gives w′=TWO cz³/w, and hence
\[
\frac{dg_0}{g_0}=THREE a\,z\eta.
\]
The product (w−az²)(w+az²)=hz⁵−ONE=h(z−r)⁵, where r⁵=h⁻¹. At R=(r,ar²), the second factor is a unit and the first vanishes to orderFIVE. At the conjugate point the first factor is a unit. AtP₀, w has poleFIVE andaz² has poleFOUR, so g₀ has poleFIVE. Thus divg₀=FIVE(R−P₀). The pointR is not Weierstrass, since ar²≠ZERO. Its classR−P₀ is nontrivial: a principal degreeONE divisor would give a degreeONE mapY→P¹, impossible for genusTWO. Therefore N₀ has exact orderFIVE.

The coefficient THREE a has fourth powerc². All FOUR solutions toB⁴=c² are its nonzero F₅ multiples. The logarithmic map on geometric Frobenius-kernel line classes is injective: if two rational representatives with divg=FIVE D give the same logarithmic derivative, their quotient has zero derivative and is a FIFTH power in k(Y); dividing its divisor byFIVE shows that their divisor classes coincide. Hence the four possibleN are exactly N₀^m, ONE≤m≤FOUR. This deduction uses the connection equation, not an unproved assertion that every N→B inclusion is canonical.

The opposite choice ofa gives the conjugate R̄ with [R̄−P₀]=−[R−P₀], because R+R̄ is a hyperelliptic fiber linearly equivalent toTWO P₀. Thus it permutes the same four classes.

## Effectivity and primitive lifting

O(P₀)⊗N₀⁻¹ is effective atR̄, and O(P₀)⊗N₀⁻⁴ is effective atR. Suppose O(P₀)⊗N₀⁻² were effective at a pointS. Then THREE P₀−TWO R∼S, or equivalently TWO R̄∼P₀+S. A degreeTWO divisor TWO R̄ has onlyONE section: by Riemann–Roch it would have TWO only if it were canonical, which would make R̄ Weierstrass. Thus its complete linear system contains just the literal divisor TWO R̄, and cannot contain P₀+S. The same argument withR in place ofR̄ excludes the m=THREE case.

For m=TWO orTHREE, put A_N=N⊗O(−P₀) if needed for annihilator lifting; more generally the stated degreeONE effectivity distinction concerns O(P₀)N⁻¹. The exact sequence O→F_*O→B, after tensoring by a lineA⁻¹, gives unique lifting whenever H⁰(A⁻¹)=H¹(A⁻¹)=ZERO. Applied to the annihilator line A=N⊗O(−P₀), its dual has degreeONE and is ineffective in these TWO cases, so Riemann–Roch gives both vanishings. This yields unique lifting of a map A→B. It does NOT assert that an arbitrary degreeZERO map N→B lifts uniquely. The theorem's lifting clause is to be read for this annihilator A.

## None of the four torsion lines maps toQ_Y

The accepted quotient Q_Y has exact sequence O→Q_Y→O(P₀). For m=TWO,THREE, tensoring byN₀⁻m gives no global sections in either outer term, by nontriviality and the preceding ineffectivity. Thus Hom(N₀^m,Q_Y)=ZERO in those cases.

For m=ONE,FOUR, work at the function field and use Frobenius adjunction, retaining the rational source frame. A map N₀^m→F_{Y*}ω_Y corresponds, after the trivialization F_Y^*N₀^m=O, to a global regular differential (A+Bz)η. Its rational-frame adjoint is g₀^m(A+Bz)η. The fixed embedded Q_Y has generic differential space
\[
\langle z\eta,f^3z\eta\rangle_{k(Y)^5}
=\langle z\eta,zw\eta\rangle_{k(Y)^5},
\]
because f³=(w⁵+b⁵)(w+b)/z¹⁵. For m=FOUR, g₀⁴ is a nonzero fifth-power scalar times g₀⁻¹, and g₀⁻¹=(w+az²)/(hz⁵−ONE). It therefore suffices to show that (w−εaz²)(A+Bz) does not lie in ⟨z,zw⟩_{k(Y)⁵} unless A=B=ZERO, for ε=±ONE.

Put Z=z⁵,W=w⁵,J=hZ−ONE. These are fifth-power coefficients, and w²=J+cz⁴ implies
\[
w=\frac{J^3+THREE J^2cz^4+THREE Jc^2Zz^3+c^3Z^2z^2}{W}.
\]
Suppose (w−εaz²)(A+Bz)=Uz+Vzw with U,V in the fifth-power field. In the p-basis ONE,z,…,z⁴, the z² coefficient is A(c³Z²/W−εa). The latter factor is NONZERO: since c=a², it is −εa(w−εaz²)⁵/W. Thus A=ZERO. The z⁴ coefficient is then (B−V)THREE Jc²Z/W, so V=B. The z³ coefficient becomes −εaB, so B=ZERO. This proves the desired vanishing. All nonzero factors here are rational functions, and their zeros at individual points do not affect the generic argument. No integral saturation is changed by this necessary generic membership test.
