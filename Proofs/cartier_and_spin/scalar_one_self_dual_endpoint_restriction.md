# Proof: scalar-one endpoint shape and the actual degree36 obstruction

Version1,2 October2026. [Focused independent review](../../Research/audits/SCALAR_ONE_SELF_DUAL_ENDPOINT_AUDIT_2026_10_02.md) PASS.
[Statement](../../Theorems/cartier_and_spin/scalar_one_self_dual_endpoint_restriction.md).

## The uniform small-endpoint implication

Put beta^2=beta+3 and [a+5b]=a+b beta. The polynomial rows in the statement are evaluated at alpha_i; they are NOT the four root evaluations. For example c(alpha)=[22]+[7]alpha+[9]alpha^2+[23]alpha^3. Use the accepted root Fourier projections a_l=(1/4)sum_i2^(-li)a(alpha_i). Their exact inputs are
\[
c_1,c_2,c_3,u_1,u_2,u_3\ne0,\quad e_1=c_1,\ e_2=[12]c_2,\ e_3=0,
\quad v_1=-[10]u_1,\ v_2=-[18]u_2,\ v_3=0.
\]
The e1=c1 equality is explicitly retained in the accepted quadratic-scalar certificate: both eigenvalue2 projections are(5,17,12,5). The certificate is [the exact constants](../../../litt3-computation-data/quadratic_scalar_reply_20260926/extracted/quadratic_trace/evidence/constants.json), with [its existing source](../../scripts/arithmetic/pro_quadratic_scalar_20260926/verify_constants.py). The other projections and phase facts are the settled inputs of [the quartic scalar theorem](sextic_quartic_scalar_exclusion.md). No certificate is replayed here.

Define d_l,j=sum_i2^(li)m_i,j in F5 and S_l(r)=sum_jd_l,j xi^(rj). Since E and K are linearly disjoint over B, the two membership hypotheses give
\[
S_3(5)=S_3(17)=0,\quad S_1(8)=S_1(5),\quad
S_1(17)=[10]S_1(4),\quad S_2(17)=[18]S_2(4).
\]
The5-Frobenius orbits of xi^5 and xi^17 are disjoint and exhaust the28 nontrivial29th roots. Thus sum_jd_3,j Z^j is a scalar multiple of Phi29. Mass<=12 leaves a phase absent, so that scalar is zero. Hence d3,j=0 phasewise. Every occupied phase has at least two labels, so at most6 phases occur.

Raising the S1 fourth-trace relation to125 and using17*125=8,4*125=7,7*125=5 modulo29 gives T^125=[10]^5 T for T=S1(7). After14 iterations, T returns to itself, while the coefficient is ([10]^5)^42=2. Indeed Norm_(B/F5)([10])=3 and3^7=2. Therefore T=0. The settled independence of any at most six phases over F5 gives d1,j=0 phasewise.

The equations d1=d3=0 force opposite root counts to agree modulo5. Write their least residues as r_even,j on roots0,2 and r_odd,j on roots1,3. Then d2,j/2=r_even,j-r_odd,j has Lee weight at most sum_j(r_even,j+r_odd,j)<=6. The settled complete Lee-kernel theorem for mu xi^(17j)-xi^(4j), with mu=[18]^-1=[11]!=1, makes this vector zero. Thus all four counts agree modulo5. No independence of twelve phases, deletion of actual fifth blocks, or extension of the Lee bound is assumed.

The total is4a+5b with nonnegative integers a,b. At mass10 only(a,b)=(0,2) occurs; at mass12 only(3,0) occurs. This proves the abstract endpoint assertion.

## The actual source and its exact scalar

Retain the ORIGINAL n10 source h:T->X,q:T->Y and its degree-five primitive quotient pi:T->S through which q factors, with S->Y of degree16. Both the positive plane P and canonical line lambda descend. Put H_S=det(P_S)lambda_S^3. Its pullback is h^*O_X(O). In this residual degree the etale-trivialized M=omega_S lambda_S^8 is killed by5, so M=O and H_S^16=omega_S. The original branch partition also descends, giving the common reduced R_S. The line H_S^13(-R_S) has trivial pullback by pi; an etale-trivialized line has prime-to-five torsion, so it too is trivial.

For the ORIGINAL point section a of pi^*H_S, the ratios theta/a^16 and A a^13 are consequently common descended sections, after compatible choices. On the actual off-diagonal source C their factors are
\[
t=a_2/a_1,\quad A_2=t^{-13}A_1,\quad theta_2=t^{16}theta_1.
\]
If the Cartier bundles are written on first Frobenius targets, transport the actual comparison to the simultaneously BASE-twisted curves and maps. This conjugates constants semilinearly and preserves these reduced divisor and contact orders; it is not pullback by relative Frobenius. The endpoint arithmetic below may equivalently be transported back to the original constants.

In [the direct source trace normalization](direct_common_source_trace.md) these factors give epsilon^4=1,eta_geo=1,epsilon^17=1, hence epsilon=1. The connected off-diagonal exists because the remaining residual groups F20,A5,S5 are two-transitive. Its two ORIGINAL X maps have degree40. No simultaneous Galois closure is assumed.

Let k_Q count the original infinity points in a five-point pi fiber. Then sum k_Q=10, and its common infinity count is sum k_Q(k_Q-1). Thus delta=40-sum k_Q(k_Q-1)=sum k_Q(5-k_Q) is even. The settled norm-invariance and integer-phase inputs make delta divisible by3; recognition excludes delta<=23. Hence delta is24,30 or36, with profiles respectively(4,2^2,1^2) or(3^2,2^2); (2^5) or(3,2^2,1^3); and(2^2,1^6). The [mass-eight whole-moment-field scalar theorem](eight_nine_momentfield_scalar_exclusion.md) excludes24 since epsilon=1.

The free swap sends t to1/t and gives the SAME canonically normalized label multiset at both endpoints. It also gives l_c=l_(c^-1), so X=M2,Y=M6 are fixed by z->z^(5^7). The four direct traces become
\[
E_L-C_L=[22](X-Y),\qquad U_L+V_L=[22](X^{625}-Y^5).
\]
The abstract endpoint lemma applies.

## Exact degree36 arithmetic, with all repetitions

For a complete four-root block at z, divide its contributions by eta=[22]. The accepted constant projections c0=[20],e0=[8],u0=[12],v0=[4] give
\[
(C,E,U,V)/eta=([17]z^5,z^8,[8]z^{17},[24]z^4),
\]
since a complete block contributes FOUR times each projection. These are also explicitly recorded in [the balanced eight-label proof](eight_label_balanced_trace_exclusion.md).

At degree36 there are three block phases and exactly two reciprocal common-infinity pairs. A block phase xi^j contributes the two-vector
\[
(xi^{8j}-[17]xi^{5j},\ [8]xi^{17j}+[24]xi^{4j}).
\]
A reciprocal pair(xi^r,xi^-r) contributes
\[
(xi^{2r}+xi^{-2r}-xi^{6r}-xi^{-6r},\
xi^{3r}+xi^{-3r}-xi^r-xi^{-r}).
\]
Here625=16 modulo29. The [new native matcher](../../Research/experiments/oct02_reciprocal_balanced_twelve_swap.cpp) compares every unordered repeated triple from29 phases with every unordered repeated two-pair multiset from r=0,...,14. It uses exact seven-coordinate F25 vectors, not a projected rejection or probabilistic key, and stores every representation of a key. There is no rescaling or Frobenius quotient. Its executed result is4495 triples,120 pair multisets,120 distinct pair keys, ZERO matches.

The reused [checked tables](../../../litt3-computation-data/prime_field_phases_20260927/sextic_paired_data.hpp) use basis1,xi,...,xi^6 and modulus(4,22,7,20,21,7,24,1). Their SHA256 is40899d2d049fb1678941f4a2cadc68d8beb50912eab5269bbdff2269012c9e8a. Source SHA256 isb89571d17d5b6c5f6ef5201b419e81126d18b7c8a26186f2b9ebe5d9faf2c6e7. [The output](../../../litt3-computation-data/oct02_reciprocal_balanced_twelve_swap.txt) SHA256 is312f1867377bad53e65117502e428e943f6e2f0da0c457bfd800f239f6d6cebb. Reproduce with clang++ -std=c++17 -O2, including the external table directory, then run; assertions remain enabled. One core was leased, compilation took0.68s and execution0.24s. Pole36 is excluded.

## The degree30 boundary is retained

Its field sums vanish, so X=Y and X^125=X, hence X in F5. Fourier inversion on mu29 with integer total10 shows X=0: otherwise all28 nonidentity counts would be nonzero modulo5, exceeding the total. All counts are therefore divisible by5. Swap and even l1 give precisely l1=10 or one reciprocal pair each of weight5. In profile(2^5), the raw endpoint ROOT counts are even, so the two fivefold labels have the same root. Their phases are not automatically equal; distinct zero-sheet slopes can shift them. This proof alone does not exclude degree30, general primitive character sources, or the unmarked common-cover problem.
