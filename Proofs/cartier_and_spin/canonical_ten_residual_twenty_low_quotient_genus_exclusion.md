# Proof: three critical z-values, self-calibration, and the genus-nine boundary

Version2, 3 October 2026. The low-genus, self-calibration and degree20–21 claims passed [independent review](../../Research/audits/OCT03_RESIDUAL_TWENTY_LOW_GENUS_DEGREE_TWENTY_TWENTY_ONE_EXTENSION_AUDIT_2026_10_03.md); the new degree22–23 boundary passed its [focused scope audit](../../Research/audits/OCT03_RESIDUAL_TWENTY_DEGREE_TWENTY_TWO_TWENTY_THREE_BOUNDARY_AUDIT_2026_10_03.md). No required corrections. The [Version1 source and provenance](../../../litt3-computation-data/oct03_residual_twenty_low_genus_extension/version1/provenance.json) are retained. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_residual_twenty_low_quotient_genus_exclusion.md).

## The actual quadratic field and the range of its established local ledger

The actual nonsplit residual bridge has [B′:k(t)]=20 for every d, not just d10. With E=k(B′), A=k(Γ), F=k(t), and K=k(T), its normalized genera are
\[
u_E=\frac{2g(E)-2}{20}=\frac85d,\qquad
u_A=\frac{2g(A)-2}{[A:F]}=\frac45d=\frac12u_E.
\]
Since d≥11, uE≥16. The twenty-sheet primitive and large binary pair-kernel reductions have conductor factors η=1−252/184756 and η=15/16. Their actual resolvent/étale-normal-closure constructions depend only on K=AE, T/E étale and T/A10S10. The half-genus conductor gap ηuE−2(1−η)−uE/2 is positive. Thus the same actual quadratic-block reduction applies for every d≥11, without a numerical replay. The [overlap ledger proof](canonical_ten_residual_twenty_bridge_overlap_ledger.md) already supplies this unchanged group step; its stated d≤19 bound is needed only for the later Jacobian vanishing.

The unique R⊂A∩E has [R:F]=2, [E:R]=10 and whole connected base change E⊗R A=K. The free σ:t→−t involution preserves R, with
\[
Q=R^\sigma\subset C_0,\quad[Q:k(z)]=2,\quad[C_0:Q]=10,
\quad[R:Q]=2.
\]
The actual π:C0→Q has S10 monodromy. The whole-bridge local ledger holds over R independently of g(Q): each ramified fiber is either a single simple fold or a uniform Galois local field of degree e2,5or10. The individual actual source infinity sections avoid the simple folds.

Assume first g(Q)<9. Absolute simplicity of J(X) gives both Jacobian Hom groups zero. The opposite-leg special-fiber norm argument in the accepted [overlap ledger](canonical_ten_residual_twenty_bridge_overlap_ledger.md) then excludes a σ-fixed R-point above t0 or t∞: it would give a uniform quadratic π-fiber with a finite degree-five norm divisor EX and2EX∼10O. The fixed two-torsion/gap obstruction forbids this. These are the only possible σ-fixed points, so R/Q is étale.

All accepted local and norm conclusions consequently remain valid for ANY d under g(Q)<9: every common infinity lies in a ramified uniform π-fiber, every such fiber contains common infinity, and the types are e2 with k2or5; e5 with both source points infinity; e10 with its unique source point infinity. Their total different is
\[
U=8d+20-20g(Q)\equiv0\pmod4.
\]
The actual canonical source identity gives exactly8d single-fold branch values. Neither this count nor the support classification uses an upper bound on d once Hom vanishing is available.

## The monic obstruction self-calibrates at its chosen uniform infinity fiber

The accepted [positive-overlap proof](canonical_ten_residual_twenty_bridge_positive_overlap_exclusion.md) establishes a monic correspondence normalization and derivative obstruction for degree-five and degree-ten uniform infinity fibers. Its separate unramified calibrating fiber can be omitted in the standalone statement.

Indeed for the ACTUAL image Z⊂X×Q of (h,π), Hom(J(Q),J(X))=0 makes the degree-ten fiber line-bundle class constant. At the chosen uniform infinity fiber A, the actual scheme-theoretic intersection with X×{A} is
\[
\sum_{P\in\pi^{-1}(A)}e_P O=10O.
\]
This calibrates the constant Pic^10(X) class even though π is ramified. The usual normalization intersection formula sums eP, with no change from coincident branches. The horizontal intersection with {O}×Q remains D=π_*h*O, whose coefficient at A is the number of source infinity branches: two for e5 and one for e10, since h is étale. These two different intersection directions must not be interchanged.

Thus the same see-saw and actual y-coefficient division give y=−g0−g1x−g2x²−g3x³, with the identical pole-two or pole-one bounds at A, and
\[
\operatorname{Norm}(U-x)=P(U)+g(U)^3.
\]
The already audited local norm estimates and exact dy order−8 contradiction are unchanged. All uniform e5 and e10 fibers are impossible. No extra numerical or local coefficient check is needed for this weakening.

## Each remaining uniform quadratic fiber is over one of three z-values

Let A be a uniform quadratic π-branch value and choose one of its common infinity points P. The actual first-two-jet calculation gives ordP(z−z(P))≥3. Since π has local index two and Q/z has degree two, the z-index is either two or four. It must be four; hence Q/z is ramified at A.

We use the accepted third-jet computation from the [audited degree-twelve conic argument](oct03_degree_twelve_residual_ten_conic_reduction.md), whose LOCAL calculation requires only two actual étale X-legs, triple x-poles and proportional original tensors. It has no cubic-root-index-three hypothesis or degree-twelve dependence. To make its implication explicit, put Xi=xi+1 and q0(xi)=Xi²+d0. The fixed tensor has expansion
\[
\mathcal T(X)(dX)^3,
\qquad\mathcal T(X)=X^{-4}(1+A/X+O(X^{-2})),
\quad A=-2P_9\ne0.
\]
Write the source Laurent leading terms Xi=li u⁻³+mi u⁻²+ni u⁻¹+ki+O(u). Tensor proportionality gives ρ=l2/l1, m2=ρm1, n2=ρn1, and the third coefficient gives
\[
X_2-\rho X_1\text{ regular},\qquad
(X_2-\rho X_1)(P)=(\rho-1)A.
\]
If ρ≠1, then
\[
q_0(x_2)-\rho^2q_0(x_1)
=2\rho X_1(X_2-\rho X_1)
+(X_2-\rho X_1)^2+d_0(1-\rho^2)
\]
has exact pole order three, because A≠0. Dividing by q0(x1), of pole order six, gives EXACT order three for z³−ρ², and hence z−z(P). This contradicts its index four. Therefore ρ=1 and z(P)³=1.

The separable quadratic Q→P1_z has at most one ramification point over any fixed z-value: an index-two point already exhausts its degree-two fiber. The equation z³=1 has exactly three distinct roots in characteristic five. Thus the number b of uniform quadratic π-branch values satisfies
\[
b\le3.
\]
Every common infinity is in one such fiber, so c>0 gives b>0. Since all remaining uniform fibers are quadratic, their total different is5b. The exact ledger makes5b divisible by four, and therefore4 divides b. This contradicts1≤b≤3. All positive residual-twenty overlaps with g(Q)<9 are excluded, for every d.

## The extra boundary d20 or21 has no genus-nine exception

Without using Jacobian Hom vanishing, the actual Γ→R has degree m, so
\[
g(R)\le\frac45d+1.
\]
For d20 or21 this integer genus is at most17. Let a be the ramification count of the tame involution R→Q. Tame Hurwitz gives
\[
g(R)=2g(Q)-1+a/2.
\]
Consequently g(Q)≤9. The g(Q)<9 case was just excluded. If g(Q)=9, then g(R)≤17 forces g(R)=17 and a=0; hence R/Q is étale without a norm argument.

The whole-bridge local ledger now descends unchanged to π:C0→Q. Its single-fold count is8d, and its total different leaves uniform contribution
\[
U=8d+20-20\cdot9=8d-160,
\]
which is zero at d20 and eight at d21. This conclusion requires no norm-support classification. The uniform local contributions themselves are always: five for e2; at least sixteen for e5; and at least thirteen for e10. No sum of positive contributions is eight. Zero permits no uniform ramification at all.

On the other hand c=d−10 is positive. The actual individual infinity sections avoid folds, and the first-two-jet lower bound≥3 for the z-index forces every common infinity to lie in a ramified uniform π-fiber: an unramified π-point would have z-index at most two. This contradicts U0 or8. Thus the genus-nine exception is impossible at d20 and21.

## Degrees twenty-two and twenty-three require only the nonspecial local ledger

For these two degrees, the g(Q)<9 case is already excluded. We treat g(Q)≥9 without any norm classification or Jacobian Hom assertion. The tame σ_R ramification count a is0,2or4: the two R-points over either t0 or t∞ are either both fixed or exchanged. We have
\[
g(R)=2g(Q)-1+a/2\le\left\lfloor\frac45d+1\right\rfloor.
\]
The E/R cover is unramified above t0 and t∞, since both E/F and R/F are unramified there by the simple zeros and poles of t. Its uniform ramification is consequently entirely away from those special fibers. The involution σ_R pairs every such R-value freely, preserving its local profile and different. Its total uniform different over R is
\[
U_R=(32d-10(2g(R)-2))-16d
=16d+20-20g(R).
\]
Over Q, the sum of uniform different contributions AWAY from z0 and z∞ is therefore exactly half this number:
\[
W=\frac12U_R
=8d+20-20g(Q)-5a.
\]
This remains true when R/Q ramifies at the special fibers. Those extra special quadratic π-fibers have no common infinity and do not enter W. All common infinity has unit z, avoids simple folds, and has z-index at least three. Thus every one of the c=d−10 common source points lies in a ramified uniform π-fiber contributing to W. This statement needs no Hom vanishing.

The possible exceptional pairs and values are the complete list:

| d | g(Q) | a | W |
|---|---:|---:|---:|
| 22 | 9 | 0 | 16 |
| 22 | 9 | 2 | 6 |
| 23 | 9 | 0 | 24 |
| 23 | 9 | 2 | 14 |
| 23 | 9 | 4 | 4 |
| 23 | 10 | 0 | 4 |

The uniform contributions are5 for e2, 8(j+1) for e5, and9+4j for e10, with j≥1. The values4,6and14 are not sums of these positive contributions: below16, only multiples of five or the single value13 are available. The value16 can only be one degree-five fiber of lower break one. The value24 can only be one degree-five fiber of lower break two: sums of quadratic contributions are multiples of five; adding a degree-ten contribution13,17or21 cannot leave a nonnegative multiple of five; two degree-ten contributions already exceed24; and a degree-five contribution16 cannot be supplemented to24.

Hence the W16 or24 cases have precisely ONE nonspecial uniform fiber, of degree five. Such a fiber has exactly two source points, regardless of whether they are infinity. At most two common source points can lie there. But c is twelve or thirteen, and every common source point must be in a uniform fiber counted by W. This is impossible.

Degrees twenty-two and twenty-three are excluded with every exceptional quotient genus allowed by the actual bound. Thus the residual-twenty positive-overlap theorem extends through joint degree twenty-three. The whole original common-cover problem and every comparison sector not covered by the stated actual hypotheses remain open.
