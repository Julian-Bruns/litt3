# Proof: the rational cubic quotient is impossible in degree four

Version1,3 October2026. Pending independent review. The only arithmetic input is a fresh necessary two-variable square gate, executed once on THREE types with a three-second mathematical cap.

In the [exact coarse cube-map system](actual_q0_tensor_cubic_coarse_curve_reduction.md), degree FOUR has a common infinity count u=1 or4. Write q0=x²+D after centering, with D≠0. The common q-zero divisor makes all its finite zeros cancel in q2/q1=z³. An unramified infinity point for one xi must be an unramified infinity point for the other: its q-valuation−2 must match modulo THREE, and it cannot match a q-zero because that divisor is common. If u=4, all poles cancel as well, so z is constant. Then x2²+D is a constant multiple of x1²+D, and the actual joint x-curve has projection degree at most TWO, contradicting FOUR.

Hence u=1. Each xi has one triple infinity point R_i and the SAME simple infinity point Q. If R1=R2, z is again constant. Otherwise div(z)=2R1−2R2. On rational B choose v with z=v², R1=0,R2=∞,Q=a∈k×. The poles of xi are exactly3R_i+Q. Consequently
\[
x_1=N_1(v)/(v^3(v-a)),\qquad x_2=N_2(v)/(v-a),\qquad\deg N_i\le4.
\]
The pole hypotheses give N1(0)≠0, leading(N2)≠0,N1(a)N2(a)≠0. The q-cube identity becomes
\[
(N_2-N_1)(N_2+N_1)=D(v^6-1)(v-a)^2.
\]
Each factor on the left has degree exactly FOUR, because their product has degree EIGHT. No factor (v-a) can divide both, as that would cancel the actual simple pole Q. Therefore all its multiplicity belongs to one side. After possibly replacing N1 by−N1, choose TWO roots r,s of v6=1 and put
\[
F=(v-a)^2(v-r)(v-s),\quad G=(v^6-1)/((v-r)(v-s)),
\]
so N2=(κF+(D/κ)G)/2,N1=(κF−(D/κ)G)/2 with κ≠0. This includes the case where a is one of r,s; it excludes a root of G, precisely because Q is a real pole. Scaling v by μ6 and exchanging r,s gives THREE ratio types s/r:−1,ω,−ω, where ω²+ω+1=0. Sign changes of the centered xi preserve the necessary ramification condition, so this normalization loses no actual candidate.

Set h=D/κ². Multiplying both Ni by the common nonzero factor2/κ does not affect their derivative-square conditions. Thus use N1=F−hG,N2=F+hG. Their derivative numerators are
\[
Q_1=v(v-a)N_1'-(4v-3a)N_1,\qquad
Q_2=(v-a)N_2'-N_2.
\]
Both have degree at most FOUR in characteristic FIVE. Because the only allowed local ramification indices are ONE and THREE, every differential zero has even order TWO. Therefore Q2 is a scalar times a quartic square. Q1 has the same square property, possibly degree TWO if the infinity point R2 is a finite triple ramification point of x1. Reversing it to v4Q1(1/v) retains this case while making its leading coefficient Q1(0) nonzero. The latter follows from aN1(0)≠0. Q2's leading coefficient is3(1+h), nonzero because x2 has its actual triple pole at infinity.

For a quartic Lv4+Bv3+Cv2+D1v+E with L≠0, being a scalar times a square is equivalent to
\[
8L^2D_1-B(4LC-B^2)=0,\qquad
64L^3E-(4LC-B^2)^2=0.
\]
These come directly from the monic quadratic square, not a discriminant proxy. Apply them to the reversed Q1 and Q2. Saturate by a,h,the two necessary leading coefficients,and G(a). Every factor is required by the actual pole data above; no candidate with a lower degree or canceled pole represents the target degree-four maps.

The [fresh source](../../scripts/genus_two/oct03_q0_degree_four_rational_square_gate.py) derives these four equations separately for the THREE types, reduces coefficients modulo FIVE and ω²+ω+1, and computes the saturated ideal by adjoining one inverse variable. Each resulting Groebner basis is exactly[1]. The [external exact receipt](../../../litt3-computation-data/oct03_q0_degree_four_rational_square_gate/square_gate.json) records the three polynomial pairs, four square equations, exact open polynomials, completed bases and0.64133 CPU seconds. The mathematical phase had a three-second alarm and completed without expiration. The first system-Python attempt failed before importing the algebra package; the SAME bounded job then ran under Sage's Python runtime. No prior mathematical calculation was replayed.

Thus none of the complete rational factorization types can satisfy even the necessary local pure-three ramification condition. No global P-cube test is needed. The rational cubic coarse quotient is excluded. The elliptic and genus-two quotient cases remain open, and no map to the original Y has been constructed or discarded.
