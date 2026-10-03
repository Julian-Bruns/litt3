# Proof: torsion-coordinate saturation and the original finite cubic source count

Version1, 3 October2026. [Independent focused audit](../../Research/audits/OCT03_RANK_FOUR_WHOLE_FACTOR_EXCLUSION_AUDIT.md): PASS allTWELVE checks; its two optional wording clarifications are applied. Inputs are the canonical [four-class factor refinement](../../Theorems/cartier_and_spin/canonical_ten_zero_gram_rank_four_factor_four_torsion_classes.md), the [saturated factor exclusion](../../Theorems/cartier_and_spin/canonical_ten_zero_gram_rank_four_saturated_factor_exclusion.md), and the original source contact data used in the accepted [zero-quotient source count](../../Theorems/cartier_and_spin/canonical_ten_rank_three_ramified_zero_quotient_exclusion.md). Only the latter's stated contact, fiber and degree inputs are used below; row ramification is not presumed. Neither original actual map is replaced.

Write Y:w²=hz⁵+cz⁴−ONE, η=dz/w, a²=c, g=w−az², ĝ=w+az², r⁵=h⁻¹, R=(r,ar²), R̄=(r,−ar²), and P=P₀. OnY₁ write N_j=O(R^(1)−P^(1))^j. Subscripts are moduloFIVE. Original N=ker(K→Q_Y) isN_m for ONE≤m≤FOUR, and its inclusion intoB is the canonical primitive g^m up to scalar. We know Hom(N_j,Q_Y)=ZERO for each nontrivialj.

## A one-defect saturation has only two possible annihilators

The saturated factor case is excluded already. B is stable of slopeONE, so the remaining saturation E₀=Sat_B K has rankTHREE degreeTWO and E₀/K has precisely ONE defect at a pointS onY₁. Its saturated alternating annihilator A=E₀^⊥ has degreeZERO, with
\[
A=N_m\otimes O(S-P^{(1)}),\qquad
A(-S)=N_m\otimes O(-P^{(1)}).
\]
The map A(−S)→B is orthogonal to the original N_m⊂K. The exact pairing calculations in the saturated-factor proof apply to EVERY such degreeMINUS-ONE map, whether or not its image is saturated. They therefore put its generic image in the torsion plane T₁₂ whenm=ONE,TWO and inT₃₄ whenm=THREE,FOUR.

These planes are actual SATURATED direct sums N₁⊕N₂ andN₃⊕N₄ inB. Here is the integral check. At any point normalizeg by its fifth-power zero/pole factor to a local unitu. The canonical local primitive frames ofN_i are u^i modulo fifth-power functions, after an invertible fifth-power scalar change. Away from the wild pair, du/u is a unit differential, so the two primitive vectors have successive leading orders ONE,TWO after eliminating their common leading coefficient. At a wild point, du/u has a simple zero, so the corresponding eliminated orders are TWO,FOUR. The determinant of the first two coefficients for distinct powersi,j is a nonzero multiple of ij(j−i)/TWO, and all these orders are belowFIVE. Thus the pair is fiberwise independent everywhere. Its direct sum is saturated. The same argument treats zeros/poles ofg after the stated local normalization.

Since A has degreeZERO and lies in one of these saturated direct sums, it must be one of the summands. Indeed a nonzero map from a degreeZERO lineA toN_i is an isomorphism, and distinct N_i cannot both be isomorphic toA. Putj for the other summand paired withm. The possibilities and forced defect points are
\[
\begin{array}{c|c|c}
m&A&S\\
ONE,TWO,THREE,FOUR&N_m&P^{(1)}\\
ONE,THREE&N_j&R^{(1)}\\
TWO,FOUR&N_j&\bar R^{(1)}.
\end{array}
\]
This follows from O(S)=O(P)A N_m⁻¹, using O(P)N₁=O(R), O(P)N₄=O(R̄). There is no other pointS because a degreeONE line has at mostONE section.

The paired lineN_j lies in E₀=A^⊥, regardless of which summandA is. Its intersection withK must be N_j(−S): if it were allN_j, the quotientK→Q would already contradict Hom(N_j,Q)=ZERO. Because N_m⊕N_j is saturated inB and K is an elementary modification containingN_m, the induced map
\[
N_j(-S)\longrightarrow K/N_m=Q_Y
\]
is SATURATED. Away fromS its two line directions remain fiberwise independent. AtS, in an elementary-modification basis containingN_m, the vector tN_j is primitive inK and hence primitive moduloN_m. This proves the claim without discarding the one integral defect.

## Mixed annihilators cannot contain the required global top section

Suppose A≠N_m. Put F=A^⊥/N_m; the original Q=K/N_m embeds generically injectively intoF. We show H⁰F=ZERO, contradicting the actual nonzero O subline ofQ.

There are only TWO cases up to the sign change a↦−a. First take A=N₁,m=TWO. The generic F coordinates are N₁,N₃, represented by g,ĝ² moduloN₂. Their sum has defect exactly the reduced wild pair W_Y inF. To check this, away fromW_Y the three distinct primitive powers of the local unitu have leading orders ONE,TWO,THREE and are independent. AtW_Y they have orders TWO,FOUR,SIX before saturation; dividing the last by the Frobenius-target parameter gains exactly ONE determinant unit. The quotient by the primitiveN₂ preserves this single loss. Both coordinate lines remain individually primitive.

It follows that a global F-section is a combination of the unique sections of N₁(W_Y),N₃(W_Y). These degreeTWO lines are O(R+P),O(TWO R̄), respectively, each with ONE section. In rational primitive coordinates the possible section is
\[
u_1g/Z+u_3\hat g^2/Z\pmod{N_2},\qquad Z=z^5,
\]
with constantsu₁,u₃. At a wild pointw₀=±TWO,
\[
w=w_0+\frac c{TWO w_0}z^4+O(z^5).
\]
After subtracting a fifth-power coefficient times theN₂ primitiveg², the polar z⁻¹ coefficients of these TWO coordinates are respectively −c/(TWO w₀) andFOUR c. Regularity demands −u₁/(TWO w₀)+FOUR u₃=ZERO at BOTH opposite valuesw₀, forcing u₁=u₃=ZERO.

Second take A=N₂,m=ONE. The generic coordinates are N₂,N₄, represented by g²,ĝ moduloN₁. The same determinant check gives precisely the wild-pair enlargement. The two possible global coordinates are g²/Z,ĝ/Z; their polar coefficients moduloN₁ are c andc/w₀. Again regularity at BOTH wild points forces both constant coefficients toZERO. The sign change handles (A,m)=(N₄,THREE),(N₃,FOUR). This excludes every mixed-annihilator sector. All pole calculations are full leading Laurent terms. After removing the constant fifth-power primitive term, the remaining terms are integral; an O(z⁵) remainder divided byZ is O(ONE), whose constant term can be removed as well.

## The marked quotient extension excludes m=TWO,THREE atP

We are left with A=N_m andS=P. We need an exact small property of the fixed Q. Its extension O→Q→O(P) has class e∈H¹O(−P) whose Serre-dual functional onH⁰ω(P)=⟨η₁,z₁η₁⟩ kills z₁η₁ and is nonzero onη₁.

For completeness this property follows from the same embedded plane, without an abstract choice of extension. Use rational source vectors α,β′ with adjoints zη,zwη. The wedge has divisorW_Y−P: atwild points β′−w₀α starts in orderFIVE and dividing byz₁ makes a primitive independent vector; atP the wedge has a single pole, because zwη=z dz has orderMINUS-FIVE and zη has a nonzero orderTWO correction. Away from these points the ratiow has simple contact. Thus β″=β′/z₁ has wedge divisorP and is a lift of the canonical O(P) rational section. It is regular away fromW_Y, includingP; near a wild point β″−(w₀/z₁)α is a regular lift. The extension is represented by the TWO principal partsw₀/z₁. Pairing withη₁ by residues gives ONE at each point and henceTWO; pairing withz₁η₁ givesZERO. This proves the functional claim in the literal relative coefficient frame; fixed nonzero common scalar choices do not change its kernel.

Consequently Hom(O(−R^(1)),Q) and Hom(O(−R̄^(1)),Q) are each one-dimensional and consist of maps factoring through its O subline. Indeed the quotient-section obstruction for O(−S₀)→O(P), S₀=R orR̄, is the value ofe on the canonical differential (z₁−z₁(S₀))η₁. It is NONZERO because z₁(S₀)=r⁵=h⁻¹≠ZERO. Thus every such map toQ comes from the O subline, and vanishes atS₀; none is a saturated line embedding.

Whenm=TWO, the forced paired line is N₁(−P)=O(−R̄). Whenm=THREE it is N₄(−P)=O(−R). Their saturated embeddings intoQ from the first section are impossible by this property. This excludes both sectors.

## The last two modifications omit the highest intrinsic exact direction

Only m=ONE,FOUR remain, with E₀=N_m^⊥ and defectP. Treatm=ONE; the other is the sign change. Put F=N₁^⊥/N₁. Its generic coordinates are N₂,N₃, represented by g²,ĝ² moduloN₁. Their sum again gains exactly the reduced wild pair. Both N₂(W_Y)=O(TWO R) andN₃(W_Y)=O(TWO R̄) have ONE section, so possible global sections are constant combinations ofg²/Z andĝ²/Z.

Atw₀=±TWO their polar coefficients moduloN₁ are c andTHREE c, respectively. Thus regularity at the two wild points requires u₂+THREE u₃=ZERO. This condition is the same at both points, giving
\[
H^0(F)=k\,T,\qquad
T=(TWO g^2+\hat g^2)/Z\pmod{N_1}.
\]
The displayed combination is integral; elsewhere the coordinate sections were already regular. In particular this computes all global sections, not merely a candidate one.

Choose an exact local parameterζ atP with z=ζ⁻², and put U₀²=h. Then
\[
w\zeta^5=U_0+\frac c{TWO U_0}\zeta^2+O(\zeta^4),
\quad u=g\zeta^5=w\zeta^5-a\zeta,
\quad \hat u=\hat g\zeta^5=w\zeta^5+a\zeta.
\]
These are the actual local primitive frames ofN₁,N₂,N₃, up to the retained nonzero scalar comparisons: N₁ is represented byu, while the global sectionT is represented byTWO u²+û² modulo u. Subtracting a constant and theN₁ component gives
\[
TWO u^2+\hat u^2+THREE U_0u
=\text{constant}-\frac{ac}{U_0}\zeta^3+O(\zeta^4).
\]
The linear and quadratic coefficients cancel, and the cubic coefficient is NONZERO. Thus T(P) is primitive inF, with primitive orderTHREE modulo theN₁ direction of orderONE.

The original map Q=K/N₁→F has its single integral defect atP. Its O subline maps to a nonzero global section ofF: generic injectivity prohibits a zero restriction. Therefore it maps to a nonzero scalar multiple ofT and has nonzero fiber value atP. The fiber image ofQ→F atP is consequently exactly the lineT(P). Pulling back toB shows that the ORIGINAL K→B fiber image atP is the plane generated by the N₁ vector and thisT vector, with primitive ordersONE,THREE.

In particular this plane omits the intrinsic highest exact direction F₄=span[ζ⁴]: after eliminating the nonzero orderONE coordinate, its remaining nonzero coordinate starts in orderTHREE and cannot equal a pure orderFOUR vector. This fiber statement is invariant under étale pullback through the ORIGINAL q. It is the only local property needed in the final source argument.

## The original cubic branches determine the net defect and contradictN

The surviving unsaturated case necessarily has ℓ(q₁)=ZERO, since the accepted nonzero original quotient theorem would forceK saturated. Thus the original constant quotient kernel is W₀=span(q₀,q₁), with ℓ(q₂)≠ZERO. On the ORIGINAL X, this plane gains THREE saturation units at infinity and has total saturation degree at mostFOUR. It therefore has at mostONE exceptional finite cubic branch point where its raw B-fiber rank is at mostONE. If d=deg(T/X), the retained actual étale X-leg pulls these exceptions to at mostd points ofT. There are exactlyTEN d reduced finite cubic source branches in total.

At every nonexceptional finite cubic source branch, the original net image has rankTWO and contains the intrinsic F₄, while the original W₀ image also has rankTWO and is contained in q₁^*K. It equals that net image. Therefore no such point can lie aboveP, where K's rankTWO B-image omitsF₄.

Let D_J be the actual determinant defect divisor of the ORIGINAL rankFOUR J⊂B. It has degreeTHREE because degB=FOUR,degJ=ONE. It containsP: K has one lost direction there, and J/K=O adds at mostONE fiber direction, so the J fiber image has rank at mostTHREE. OutsideD_J, J=B, hence the raw original net kernel at a finite cubic branch is also the kernel inJ. Its nonzero constant quotient rowℓ kills that kernel, forcing it intoW₀; such a branch is exceptional. These are statements about the retained original q₀,q₁,q₂ net, not arbitrary columns of the chosen eight-dimensional source.

Consequently at leastNINE d distinct nonexceptional finite cubic source points lie over D_J away fromP. An ORIGINAL étale q-fiber has EIGHT d points. Since D_J has degreeTHREE and containsP, at least TWO distinct points Z₁,Z₂ outsideP are necessary, and
\[
D_J=P^{(1)}+Z_1^{(1)}+Z_2^{(1)}
\]
is reduced. At eachZ_i, K=E₀ is saturated, and the simple determinant loss ofJ makes its rankTHREE B-image equal the K fiber image. If the adjoint of the saturated annihilator A=N_m were nonzero there, that hyperplane would omitF₄. No nonexceptional finite cubic branch could then occur overZ_i. The other single q-fiber has at mostEIGHT d points and cannot containNINE d of them. Thus the adjoint ofA vanishes atBOTH Z_i.

Its total zero degree isTWO and its zeros were already identified as the reduced wild pairW_Y by the original factor refinement. Hence Z₁+Z₂=W_Y. Use ONLY the actual determinant sequence and actual determinant defect now:
\[
\det J=\det K=N_m\otimes O(P^{(1)}),
\qquad
\det J=\det B(-D_J)=\omega_{Y_1}^2(-P^{(1)}-Z_1^{(1)}-Z_2^{(1)}).
\]
Cancelling O(P^(1)) and using ω_Y₁=O(TWO P^(1)) gives
\[
N_m=\omega_{Y_1}(-Z_1^{(1)}-Z_2^{(1)})=O_{Y_1},
\]
because the wild pair is canonical. This contradicts the exact orderFIVE ofN_m. No determinant markO(P) was imported: it is the contradiction obtained from the computed original net defect and the actual quotientJ/K=O.

The whole factor branch is excluded. The separate nonfactor surjection C₅→Q_Y remains open.
