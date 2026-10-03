# Proof: monic correspondence, local derivative, and the residual-ten overlap ledger

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_RESIDUAL_TEN_POSITIVE_OVERLAP_MONIC_LOCAL_WHOLE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_residual_twenty_bridge_positive_overlap_exclusion.md).

## Accepted actual-source reduction

Use the [overlap ledger](../../Research/notes/oct03_ten_hour/residual_ten_overlap_extension.md), which passed its [independent audit](../../Research/audits/OCT03_RESIDUAL_TEN_OVERLAP_EXTENSION_AUDIT_2026_10_03.md). It retains the original SAME-source finite étale X- and Y-legs and gives an ACTUAL hyperelliptic field Q⊂C0, with
\[
\pi:C_0\longrightarrow Q,\quad\deg\pi=10,\quad
\operatorname{Mon}(\pi)=S_{10},\quad g(Q)\le\frac25d+1<9.
\]
Write h=h1:C0→X for the first actual finite étale X-leg, O for the unique infinity point of X, and I1=h*O. The reduced infinity divisors satisfy
\[
I_1=\pi^*A_0+J,
\]
where π over A0 is unramified and all ten points of that fiber map to O. Every point of J belongs to a ramified uniform π-fiber, and every ramified uniform fiber contains at least one point of J. This includes the actual individual-section avoidance of simple folds and the common-infinity first-two-jet argument; no arbitrary coefficient combination is substituted for an original infinity section.

The uniform degree e, its common-point count k, and its total different contribution are exactly:

| e | k | Different contribution |
|---|---:|---:|
| 2 | 2 or5 | 5 |
| 5 | 2 | 8(j+1), j≥1 |
| 10 | 1 | 9+4j, j≥1 |

For e5 or e10, EVERY source point in the fiber is infinity for h: there are respectively two or one source points, and the indicated k is exactly that number. The local fields are Galois and uniform by the actual whole-base-change lemma, rather than by an assumed normal closure of the endpoint pair. Their individual different exponents are respectively4(j+1)≥8 and9+4j≥13.

The common-point counts over all uniform fibers sum EXACTLY to c. The audited exact ledger gives their total different
\[
U=8d+20-20g(Q)=100+8c-20g(Q).
\]
In particular U is divisible by four. These are reused inputs; their proofs and the fixed-X mixed-norm certificates are not replayed.

## A genuine monic normal form for the actual correspondence

We give this step for any actual h:C→X and degree-ten S10 map π:C→Q satisfying g(Q)<9 and the calibrating unramified infinity fiber above A0. The fixed J(X) is absolutely simple of dimension nine, so
\[
\operatorname{Hom}(J(Q),J(X))=\operatorname{Hom}(J(X),J(Q))=0.
\]
The fixed X has equation y³=P(x), where P is monic degree ten and its degree-nine coefficient P9=[22] is nonzero. Its semigroup at O is <3,10>, hence
\[
H^0(X,O_X(10O))=\langle1,x,x^2,x^3,y\rangle.
\]

First Q(x1)=k(C). Primitivity of the S10 action allows no proper intermediate field. If x1∈Q, then adjoining y1 with y1³=P(x1) has degree one or three over Q. It divides [C:Q]=10, so y1∈Q. Then k(X)⊂Q. The intermediate map Q→X is separable because C→X is étale, and Hurwitz contradicts g(Q)<g(X)=9. Thus x1∉Q and Q(x1)=k(C).

The actual map (h,π):C→X×Q is therefore birational onto an integral Cartier divisor Z. Let L=O(Z). Restrictions L|X×{A} have degree ten and define a map Q→Pic^10(X). Its pointed difference factors through a homomorphism J(Q)→J(X), so that map is constant. At A0 the actual intersection divisor is10O. Therefore every such restriction is O_X(10O).

For completeness, this see-saw step has a direct line-bundle proof. Twist L by pX*O_X(−10O). Its restrictions to all X-fibers are trivial. Cohomology and base change supplies a rank-one pushforward to Q, and the evaluation map is an isomorphism on each fiber and hence globally. The twisted line bundle is pulled back from Q. Restricting to {O}×Q gives its factor. The exact intersection divisor is
\[
D=\pi_*h^*O.
\]
The multiplicity at each base point is the sum of the orders of an X-uniformizer along its source branches; each is one because h is étale. This remains true when several branches have the same point in X×Q. Consequently
\[
L=p_X^*O_X(10O)\otimes p_Q^*O_Q(D).
\]

The defining section of Z can thus be written
\[
s_0+s_1x+s_2x^2+s_3x^3+s_4y=0,
\qquad s_i\in H^0(Q,O_Q(D)).
\]
In the local trivialization of O_X(10O) at O, only the y section has a nonzero value. Restriction to {O}×Q therefore identifies s4, up to a nonzero constant, with the actual intersection section. It is not identically zero, because Z has no such horizontal component. Thus its zero divisor is EXACTLY D. Dividing by this actual coefficient gives rational functions gi=si/s4, with poles bounded by D, and
\[
y_1=-g_0-g_1x_1-g_2x_1^2-g_3x_1^3.
\]
At a chosen uniform infinity fiber with k points, the coefficient of D is k, so all gi have pole order at most k there. Since x1 has degree ten over Q, its monic norm polynomial is exactly
\[
N(U)=\operatorname{Norm}_{C/Q}(U-x_1)
=P(U)+(g_0+g_1U+g_2U^2+g_3U^3)^3.
\]
The right side vanishes at x1 and is monic of degree ten: its cubic summand has degree at most nine. Thus no scalar or denominator is left in this identity.

## Local norm obstruction for a uniform degree-five fiber

Let A be such a fiber. It contains two source points, both h-infinity, and the pole bounds for gi at A are at most two. Complete at A with K=k((r)). Each local field L/K has degree five and different exponent δ≥8. The actual étale X-leg gives vL(x1)=−3. The trace-ideal estimate
\[
\operatorname{Tr}_{L/K}(\mathfrak m_L^n)
\subset\mathfrak m_K^{\lfloor(n+\delta)/5\rfloor}
\]
gives the lower bounds1,0,−1,−1 for Tr(x1^i), i1…4. Newton's identities in degrees1…4, all invertible in characteristic five, give these same lower bounds for the first four elementary coefficients of the local degree-five monic norm. Its constant coefficient has exact valuation−3.

Multiplying the two local norm polynomials shows that every U-dependent coefficient of N has valuation at least−4, while its constant coefficient has exact valuation−6. Write
\[
g_0+g_1U+g_2U^2+g_3U^3
=r^{-2}B_2(U)+r^{-1}B_1(U)+O(1),
\]
where B1,B2 have degree at most three. The pole-six coefficient B2³ and pole-five coefficient3B2²B1 of its cube must be CONSTANT polynomials in U. The first is nonzero, by the constant norm valuation. Hence B2 is a nonzero constant, and B1 is also constant. Thus
\[
g_1,g_2,g_3\text{ are regular at }A,\qquad v_A(g_0)=-2.
\]
This argument specifically uses that BOTH local source points are infinity. It does not assert regularity of the higher gi in a quadratic fiber with additional finite source points.

## Local norm obstruction for a uniform degree-ten fiber

Now A has one source point, at h-infinity. The pole bounds for all gi at A are at most one. Its completed field has degree ten, different exponent δ≥13, and vL(x1)=−3. Every conjugate of x1 has valuation−3/10 with respect to the extended base valuation. The coefficient which is elementary of degree i therefore has integral base valuation at least
\[
\left\lceil-\frac{3i}{10}\right\rceil\ge-2
\qquad(1\le i\le9).
\]
The constant coefficient of N has exact valuation−3. In the expansion
\[
g_0+g_1U+g_2U^2+g_3U^3=r^{-1}B_1(U)+O(1),
\]
the pole-three coefficient B1³ must be a nonzero CONSTANT polynomial in U. Thus B1 is a nonzero constant and
\[
g_1,g_2,g_3\text{ are regular at }A,\qquad v_A(g_0)=-1.
\]
This coefficient bound uses the actual single completed field and does not require a presumed common Galois closure of the original endpoints.

## Differentiation excludes both wild uniform types

Choose a source point over A, with differential orders measured in its uniformizer. Actual étaleness over X gives
\[
\operatorname{ord}(x_1)=-3,\quad
\operatorname{ord}(y_1)=-10,\quad
\operatorname{ord}(dx_1)=-4.
\]
Because P is monic degree ten in characteristic five and P9≠0, P′ has EXACT degree eight. Differentiating y1³=P(x1) gives
\[
3y_1^2dy_1=P'(x_1)dx_1,
\qquad\operatorname{ord}(dy_1)=-8.
\]
For a degree-e local extension with different exponent δ, pulling back a base differential of order a gives order ea+δ. In the degree-five case, the pole-two g0 has base differential order at least−3, so
\[
\operatorname{ord}(dg_0)\ge-15+\delta\ge-7,
\qquad\operatorname{ord}(dg_i)\ge\delta\ge8\quad(i=1,2,3).
\]
In the degree-ten case the pole-one g0 has base differential order at least−2, so the same useful bounds hold:
\[
\operatorname{ord}(dg_0)\ge-20+\delta\ge-7,
\qquad\operatorname{ord}(dg_i)\ge\delta\ge13.
\]

Differentiate the actual monic relation. If g3(A)≠0, the term3g3x1²dx1 has exact order−10 and is the UNIQUE term of that order. Every other term has order at least−7: dg0 has this bound, dgi x1^i has order at least8−3i≥−1, 2g2x1dx1 at least−7, and g1dx1 at least−4. Their sum would make dy1 have order−10, a contradiction.

If g3(A)=0, its pullback has valuation at least e≥5, so the same cubic derivative term has order at least−5. Every term then has order at least−7. Their sum cannot have the exact order−8. This is again a contradiction. Both uniform e5 and e10 fibers are therefore impossible for every permitted wild break.

## The exact ledger excludes every positive overlap in the stated range

Only uniform quadratic fibers remain. Let b be their number. Every common infinity belongs to such a fiber, and their counts are k=2 or5; hence
\[
c>0\Longrightarrow b>0,\qquad c\ge2b.
\]
Each contributes five to the different, so the exact ledger becomes
\[
5b=100+8c-20g(Q).
\]
Modulo five this gives c≡0 mod5; modulo four it gives b≡0 mod4. With1≤c≤9, the first congruence forces c=5. The second and b>0 force b≥4, hence c≥8, a contradiction.

All positive overlaps with11≤d≤19 and residual degree ten are excluded. The proof has used the actual two-leg source packet to construct Q and its exact ledger, and an actual étale X-leg throughout the correspondence and local analysis. It has not supplied a comparison tensor for an arbitrary common source or a descended endpoint map on Q.
