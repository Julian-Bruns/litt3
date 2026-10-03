# Proof: exact quintic contact and the conductor-trace obstruction

Version2,2 October2026. [Focused independent review](../../Research/audits/ETALE_QUINTIC_IDENTICAL_PHASE_AUDIT_2026_10_02.md) PASS. Version1's conductor proof is retained unchanged; the last section gives the new mixed-profile consequence.
[Statement](../../Theorems/cartier_and_spin/etale_quintic_identical_phase_contact_exclusion.md).

## Exact global contact, without a Galois hypothesis

Write the primitive section polynomial
\[
F_a(Z)=Z^5+c_1Z^4+c_2Z^3+c_3Z^2+c_4Z+c_5,
\qquad c_j\in H^0(S,H^j).
\]
The image order O_S[a] has local basis1,a,...,a^4 and determinant H^-10 of degree-10m. Its normalization is pi_*O_T, of determinant degree0 since pi is etale. The quotient length is therefore EXACTLY10m. Over a strict henselian local base the normalization splits into five formal roots a_i and its discriminant is the squared Vandermonde. Hence
\[
\sum_Q\sum_{i<j}\operatorname{ord}_Q(a_i-a_j)=10m.
\]
Distinct roots are never identical formal series, since a is primitive. This equality is the complete contact budget, not a lower bound from selected fibers.

The5m/2 zero pairs cost at least15m/2. At most5m/2 remains. If a fiber's nonzero triple fails to contain each member of its C3 orbit once, some pair repeats and costs at least2. Thus at most floor(5m/4) fibers are unbalanced. At least ceil(5m/4)>m fibers are balanced. There F_a specializes to Z^2(Z^3-v^3), so c1 vanishes. Since deg H=m, c1=0 globally.

At every selected fiber the sum of its three nonzero values is now zero. A primitive cubic root has minimal polynomial Z^2+Z+1 over F5. Three nonnegative counts summing to3 therefore must be(1,1,1). All5m/2 fibers are balanced; c2 vanishes at more than deg H^2=2m points, so c2=0.

## A regular section from the conductor

The polynomial derivative is F_a'(a)=2c3a+c4, a section of pi^*H^4. In the etale local splitting it equals product_(j!=i)(a_i-a_j) at root i. At every zero a_i its zero partner contributes order at least3 and the other roots are units. Thus
\[
b=F_a'(a)/a^3=(2c_3a+c_4)/a^3
\in H^0(T,pi^*H)
\]
is globally regular. Its etale trace is a section of H, with no division by degree5.

Newton sums of reciprocal roots give
\[
\operatorname{Tr}_\pi b
=2c_3(c_4^2/c_5^2-2c_3/c_5)
+c_4(-c_4^3/c_5^3+3c_4c_3/c_5^2)
=\frac{c_3^2c_5^2-c_4^4}{c_5^3}.
\]
Regularity of this rational expression follows from the already proved global section b.

At a selected fiber, the zero sections have the same nonzero first coefficient (their difference has order at least3); the other three roots form a complete nonzero cubic orbit. Consequently c3 is a unit, ord(c4)=1 and ord(c5)=2. The linear derivative resultant gives the discriminant, up to a harmless global sign,
\[
\Delta=-c_4^5+2c_3^4(c_4^2+c_3c_5).
\]
All terms are sections of H^20. The squared Vandermonde has order at least6 at this fiber. Its first displayed term has order5, so d=c4^2+c3c5 has EXACT order5, cancelling that leading term. Thus c3c5 has opposite leading coefficient to c4^2; the factor c3c5-c4^2 has order2. The trace has order at least(5+2)-3*2=1.

The trace section of H vanishes at all5m/2>m selected fibers, so it is zero. Thus (c3c5)^2=c4^4. In the function field c3c5 equals c4^2 or -c4^2; the selected local leading term forces the negative choice globally. The discriminant becomes -c4^5, up to sign, and has ODD order5 at each selected fiber. This contradicts its squared-Vandermonde valuation in an ETale local normalization. The abstract uniform theorem follows.

## The actual X phase and the three local hypotheses

For the actual source retain h:T->X and q:T->Y, with pi:T->S factoring q; no new generic second map is substituted. Use the descended H_S with pi^*H_S=h^*O_X(O) and the ORIGINAL point section a. A nonconstant residual degree-five comparison makes a primitive: otherwise a descends, its original infinity divisor is a complete pi pullback and the exact theta recognition identifies the embedded X fields.

On each actual comparison the source-calibrated normalizations are A2=t^-13 A1,theta2=t^16theta1,t=a2/a1. All Cartier line bundles may be written on first Frobenius targets. Then transport these identities by simultaneous BASE Frobenius twist, conjugating constants and preserving valuations; do not pull them by relative Frobenius, which would multiply orders. The contact argument is invariant under this coefficient conjugation.

Fix a fiber Q with zero sections a_j=d_j w+... and a nonzero section a_i=v_i+... . The finite endpoint parameter is r_j=a_j/a_i. The coefficient of its finite x_i-alpha in r_j is x_i'v_i/d_j. In the exact scalar-one normalization it is the fixed root constant times xi^(4*phase), independent of the zero representative. If all finite endpoint labels are identical, d_j agrees for all zero sheets. Thus every common-infinity t-value is1. The settled actual infinity normal form has ord(t-1)>=2; zero sections consequently differ to order at least3.

For the nonzero sheets let y_i be their cubic X coordinate and F=A_i a_i^13,sigma=theta_i/a_i^16 the common source sections. At a finite simple A-root alpha,
\[
A'(alpha)y_i^2v_i^{29}=F'(Q)/sigma(Q),
\]
while equality of phase makes y_i^2v_i^17/d_j independent of i. Ratios of nonzero values therefore have both twelfth and eighty-seventh power1, hence have cube1. They lie in ONE C3 orbit; no local cubic sheet balance is presumed.

If two of these values coincide, their y coordinates coincide as well. Put t=1+bw^r+... . Since A1 has a simple zero, A2=t^-13 A1 gives x2-x1 leading term -13b(x1-alpha)w^r. The first correction to theta2/theta1 is -13(r+1)bw^r; the y change only contributes order r+1. Equality to t^16 forces -13(r+1)=16 modulo5, so r=2 modulo5. Thus repeated nonzero sections differ to order at least2. These are precisely the local hypotheses of the uniform theorem, established on the actual source without discarding repeated sheet values.

## The other n10 pole30 profile

The [scalar-one endpoint theorem](scalar_one_self_dual_endpoint_restriction.md) leaves profiles(2^5) and(3,2^2,1^3), each with two fivefold singleton packets. Identical packets give all zero slopes equal as above. Profile(2^5) is excluded by the uniform theorem with m=2.

In profile(3,2^2,1^3), the triple-zero fiber has three zero pairs of contact at least3, costing9. The two double-zero fibers cost at least6. Each of the three single-zero fibers has FOUR nonzero values in ONE C3 orbit; some pair repeats, costing at least2 per fiber. Total contact is at least9+6+6=21, exceeding the exact20. This excludes identical packets in the second profile as well.

Distinct packets remain. In profile(2^5) root-count parity makes their quartic roots equal, but their phases differ; equal zero slopes would give even counts for every actual root/sheet/phase label and cannot realize the odd fivefold packet multiplicities. Thus its common distribution is the nonidentity reciprocal pair. In profile(3,2^2,1^3) the common distribution is l1=10, and its distinct packets can differ in root or phase. No exclusion of either remaining case, general character existence or the unmarked common-cover problem is asserted.

## Version2: complete fibers and mixed multiplicities

If all five zero sheets occur over Q, divide a by the pulled base divisor section and replace H by H(-Q). Repeat for all complete zero fibers. The section remains primitive and its comparison ratios are unchanged. Local differences and nonzero-value ratios at the remaining zero fibers change only by a common unit. The contact budget decreases by10 for each stripped fiber: every one of its ten root differences loses one order. Equivalently, the new section order has determinant degree-10 times the new degree of H.

If the resulting degree is0, its nowhere-zero section etale-trivializes H. A line killed by an etale cover has prime-to-five torsion, and norm kills it by5, so H is trivial. Its pulled section is constant; before stripping a was a base section times this constant. It therefore descends and is not primitive. Thus the reduced degree m is positive and there are no k5 fibers.

Let n_k count zero fibers of multiplicity k=1,2,3,4. The reduced zero divisor has degree5m, giving n1+2n2+3n3+4n4=5m. The minimum collision cost is
\[
2n_1+3n_2+9n_3+18n_4\le10m.
\]
For k1, four nonzero values in one C3 orbit force a repeated pair of contact at least2. For k2,k3,k4 there are respectively one, three and six zero pairs of contact at least3. This simplifies to n2>=3n3+10n4.

An unbalanced nonzero triple at a k2 fiber costs at least2 in addition. If b2 is the number of balanced k2 fibers, the budget gives
\[
10m\ge2n_1+3n_2+9n_3+18n_4+2(n_2-b_2),
\qquad b_2\ge(n_2+3n_3+10n_4)/2.
\]
If n2+9n3+42n4>2n1, the last bound exceeds m, using the zero-divisor degree identity. Thus c1 vanishes at more than its degree and is zero globally. At any k1,k3,k4 fiber, however, its nonzero values have total count4,2,1 in one C3 orbit. Such a sum cannot vanish in characteristic5: the multiplicities are at most4 and Z^2+Z+1 is the cubic root's minimal polynomial. Hence no mixed fiber remains. The resulting all-k2 case is excluded by the unchanged uniform conductor theorem above. This proves the second necessary inequality for every surviving profile.

If n1=0, either a baseline inequality already fails or n2+9n3+42n4>0, so the source is excluded. This yields the uniform no-singleton statement, including arbitrary complete fibers before stripping. The phase hypothesis and actual maps remain essential for the application; no arbitrary section or unmarked common span is claimed to provide them.
