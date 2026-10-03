# Proof: eliminating the six source parameters from the Hermitian jet test

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_hermitian_finite_jet_recognition.md). Passed [root's independent review](../../Research/audits/LARGE_WILD_HERMITIAN_FINITE_JET_RECOGNITION_AUDIT_2026_10_03.md). Reuse the accepted [Hermitian local normality and determinacy theorem](../quotient_geometry/local_actions/hermitian_local_normality.md), with determinacy degree1149 and exact SAME-base scalar. The following elimination is symbolic and uses no computation.

Write f=∑cjt^j and put a=c1000,b=c1120,d=c1144. The unit gap and the differential identity imply that the only possibly nonzero coefficients through1149 are at
\[
1000,1120,1125,1130,1135,1140,1144,1145,1146,1147,1148,1149.
\]
Indeed every Gj of non-FIVE-divisible degree below144 vanishes by dG=ct143σ, and the first nonlinear term in G⁻⁷ begins at increment240. For all120≤j≤149,
\[
c_{1000+j}=3G_0^{-8}G_j,
\qquad a=G_0^{-7}.
\]

The Hermitian quotient series is z¹⁰⁰⁰+3z¹¹²⁰+3z¹¹⁴⁴ modulo z¹¹⁵⁰, as derived in [the remainder jet proof](large_wild_hermitian_remainder_jet_constraints.md). A right transform has z=μt u(t),u(0)=1, and an arbitrary nonzero target multiplier A. Set S=u⁻¹=1+s1t+⋯+s5t⁵+O(t⁶). Its leading coefficients obey
\[
a=A\mu^{1000},\quad b=3A\mu^{1120},\quad d=3A\mu^{1144}.
\]
These admit A,μ≠0 if and only if b⁶+2ad⁵=0: choose μ²⁴=d/b and A=aμ⁻¹⁰⁰⁰, then the relation gives the b formula and hence the d formula.

For k=2,3,4, the coefficient equations are
\[
c_{1120+5k}=b s_k^5,\qquad c_{1144+k}=d s_k.
\]
They are consistent exactly when the three displayed ratio identities hold. Only the first and fifth inverse-unit coefficients remain. The leading1000-term contributes2as1¹²⁵ to1125; the1120-term contributes bs1⁵. At1145 the1120-term contributes bs5⁵ and the1144-term contributes ds1. At1149, u¹¹⁴⁴=u⁻¹u¹¹⁴⁵ has coefficient s5+s1⁵, since u¹¹⁴⁵=(u²²⁹)⁵ and4(−s1)⁵=s1⁵. Therefore
\[
c_{1125}=b s_1^5+2a s_1^{125},\quad
c_{1145}=b s_5^5+d s_1,\quad
c_{1149}=d(s_5+s_1^5).
\]
Set E=c1145−b(c1149/d)⁵. Eliminating s5 gives E=ds1−bs1²⁵. Its fifth power is d⁵s1⁵−b⁵s1¹²⁵, which equals(d⁵/b)c1125 because b⁶+2ad⁵=0. Thus consistency is equivalent to
\[
c_{1145}=b(c_{1149}/d)^5+d(c_{1125}/b)^{1/5}.
\]
For sufficiency, the additive polynomial bX⁵+2aX¹²⁵−c1125 has a root in k. Choose this as s1, and put s5=c1149/d−s1⁵. The consistency equation then gives the1145 equation, since fifth powers are injective. Choose s2,s3,s4 from c1146/d,c1147/d,c1148/d. This produces a source automorphism matching every coefficient through1149. The accepted determinacy theorem corrects it to an exact right equivalence with A times the Hermitian quotient series. That quotient is Galois with the stated inertia and filtration; conversely its every right transform satisfies these equations.

Finally substitute c1000+j=3G0⁻⁸Gj. The leading relation becomes G120⁶=G0G144⁵, and the remaining equations become precisely the statement's three ratios and one overlap equation. The accepted SAME-base invariant a³(b/d)¹²⁵ becomes G0⁻²¹(G120/G144)¹²⁵. Equality of that invariant recognizes fixed-base isomorphism among the locally normal extensions just characterized. It is not a global gluing theorem.
