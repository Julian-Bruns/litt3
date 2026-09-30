# Proof: actual fibre products restrict the scalar, then the traces contradict

[Statement](../../Theorems/cartier_and_spin/pole_fifteen_complete_exclusion.md).
The complete received proof is
[REPORT Sections28--33](../../../litt3-computation-data/mixed_phase_quintic_reply_20260927/extracted/mixed_phase_quintic/REPORT.md),
with necessary scalar-sector proofs in Sections11 and18. The following
records its logical chain and the exact finite coverage.

## The actual scalar group

The proved [cubic descent](pole_fifteen_cubic_descent.md) gives a curve S
with k(S)=k(u,t)=k(v,t), degree5 over k(t), and both original maps recovered
on k(T)=k(S)(y1). Put E8=F_(5^8), B=F25, K0=F_(5^14), and
H=E8^* mu29. Write alpha_i for the four A-roots and b_i for their specified
29th roots in E8. Choose gamma^3=epsilon and lambda=gamma^-1.

The actual monic equation F(U,t), of degree n in t, gives
G(U,z)=gamma^-n F(U,gamma z), monic in z. The map u is etale above each
alpha_i. Its entire fibre, not a selected divisor, therefore gives the
specialization R_i(z)=G(alpha_i,z) as a product of n values with integer
multiplicities. All nonzero z-values belong to H: the two actual
identities give
\[
t(p)^{87}=\epsilon^{29}c_{\alpha_i}/c_{\alpha_j},
\qquad(c_{\alpha_i}/c_{\alpha_j})^{1/87}\in E8.
\]
The latter root is explicitly beta_i/beta_j, with
beta_i=b_0^((25^i-1)/3).

Let m_i count the five endpoint labels above alpha_i. At z=0,
G(U,0)=C product_i(U-alpha_i)^m_i. The endpoint slopes are in H.
Comparing the lowest local products yields
\[
\rho_i\lambda^{m_i}=B_i C,\qquad \rho_i,B_i\in H.
\tag{1}
\]
For an absent root use rho_i=R_i(0), B_i=product_h(alpha_i-alpha_h)^m_h.
If a root is absent, C belongs to H. Positive multiplicities summing to
five have gcd1 unless only one is positive; in that exception its value
is5 and fifth roots are unique, with H stable under them. If all four
roots occur the multiplicities are2,1,1,1, and a ratio of(1) gives
lambda in H directly. Thus epsilon belongs to H^3.

Rescaling t by a29th root preserves actual comparisons and normalizes
epsilon into(E8^*)^3. The retained complete scalar-sector exclusions give
\[
\epsilon\notin F_{5^4},\qquad\epsilon^4\notin B.
\]
Exactly129984 normalized scalars remain. These are a proved exhaustive
geometric restriction, not a finite-field search assumption.

## Complete endpoint classification

For a five-label multiset L, let
S_l(k)=sum_(i,j in L)2^(li) zeta^(kj). The first fourth-trace equation
requires epsilon U_L+V_L in K0+epsilon K0. Project E8 to the two-dimensional
quotient E8/(B+B epsilon). The nontrivial character components of f0 span
E8/B, so the five phase vectors
\[
S_1(17),\ S_2(17),\ S_3(17),\ S_1(4),\ S_2(4)
\]
have B-rank at most3. Every nonpure L has U_L outside K0, by the verified
independence of any five distinct29th roots over B. At a nonconstant
coordinate U_k, every possible scalar is
\[
\epsilon=(b-V_k)/(U_k-a),\qquad a,b\in B.
\]
All625 proposals are tested in all seven coordinates. No trace is divided
by five and no endpoint repetition is removed.

Rotating only root indices normalizes the first sorted label to4h.
There is NO phase translation after scalar normalization. The full domain
is(4h,b,c,d,e), 4h<=b<=c<=d<=e<116, 0<=h<29: exactly50706761 tuples.
The two complete algorithms give the same rank counts:

| Rank | Number |
| --- | ---: |
| 0 | 29, all pure |
| 1 | 62 |
| 2 | 260155 |
| 3 | 229121 |
| at least4 | 50217394 |

Every rank2/3 scalar proposal fails. The rank1 entries have exactly the
following shapes before root normalization: all five phases zero, or a
phase-zero singleton plus all four roots at one common nonzero phase.
There are52 and112 such shapes, respectively. The classification is a
necessary condition only, not a realization of any shape.

## The same moments exclude the mixed shape

Normalize the exact root traces by eta0=[22]. Their values are
sum c(alpha_i)/eta0=a=[17], sum e(alpha_i)/eta0=1, with bar(a)=[10]!=a.
Move a balanced four-root block at phase j to phase zero. It changes
normalized C by a(zeta^(5j)-1) and E by zeta^(8j)-1.

In the SAME two trace equations put
\[
Y_*=Y-a(\zeta^{5j_0}-1),\qquad
X_*=X-(\zeta^{8j_\infty}-1).
\]
The second equation forces X_*,Y_* in B: expand K0 over B, and use
epsilon in E8\B and the linear disjointness of E8 and K0 over B. The
first then forces both
\[
\zeta^{8j_0}-\zeta^{-8j_\infty},\qquad
a(\zeta^{5j_\infty}-1)-a^5(\zeta^{-5j_0}-1)
\]
to be in B. Independence of three phases forces j_infinity=-j0. Since
a-a^5 is nonzero, the second expression then forces both phases to vanish.
Both endpoints are single-phase, contrary to the established complete
single-phase-pair exclusion. This closes every remaining quintic case.

## Executed checks and scope

The39-entry archive manifest, exact field generators, all20475 normalized
five-phase independence sets, all841 final phase pairs, all7940751
quadratic-scalar tuples, and BOTH full50706761 endpoint algorithms passed
locally. The direct and reciprocal algorithms tested101448701 and101431599
allowed proposals, respectively, accepting none. They share field data
but use different rank and membership algorithms; they are not claimed
to be independent arithmetic implementations.

All essential mathematical JSON and final logs match the received evidence.
Only recorded Python-version fields differ in two retained JSON files.
The substantial geometric and completeness argument passed an independent
focused audit. The additional archived first-jet reconstruction and
fourth-order-contact calculations are not needed for this proof and were
not replayed in this integration.

See [the audit](../../Research/audits/MIXED_QUINTIC_COMPLETE_2026_09_27.md),
[source copies](../../scripts/arithmetic/pro_mixed_quintic_20260927/src/mixed_phase_check.cpp)
and [replayed results](../../../litt3-computation-data/mixed_phase_quintic_reply_20260927/replay/).
The conclusion excludes pole15 in every possible n. It is not an
unmarked common-cover decision, nor a classification of all higher poles.
