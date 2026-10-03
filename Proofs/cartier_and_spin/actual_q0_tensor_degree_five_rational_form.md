# Proof: the complete degree-five rational factor partition

Version1,3 October2026. Independently accepted in the [whole rational degree-five audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_RATIONAL_AUDIT_2026_10_03.md). No whole exclusion follows from this statement alone.

Use the accepted [actual coarse cube-map reduction](actual_q0_tensor_cubic_coarse_curve_reduction.md). Degree FIVE gives common infinity count u=TWO or FIVE and g(B)≤TWO. The common reduced q-zero set cancels in q2/q1=z³. Every simple infinity pole for one map is also a simple infinity pole for the other: its q-valuation is−TWO modulo THREE and cannot match a triple pole or the common q-zero set. If u=FIVE, all poles cancel too, so z is constant. Then x2²+D is a constant multiple of x1²+D, giving joint-x projection degree at most TWO, contrary to the actual degree FIVE. Thus u=TWO.

Let R_i be the unique triple infinity pole of xi, and Q_a,Q_b their TWO common simple infinity poles. The points R1,R2 are distinct, since equality would again make z constant. The exact divisor is div(z)=2R1−2R2. When B is rational, choose v with z=v², R1=ZERO,R2=∞,Q_a=a,Q_b=b. Thus a,b are distinct and nonzero. The exact pole divisors give
\[
x_1=A/(v^3J),\quad x_2=B/J,\quad J=(v-a)(v-b),\qquad \deg A,\deg B\le5.
\]
The triple poles force A(0)≠0 and deg B=FIVE. Both A,B are nonzero at a,b. The q-cube identity becomes
\[
B^2-A^2=D(v^6-1)J^2.
\]
Consequently F+=B+A,F−=B−A both have degree FIVE. They have no common root: at a,b a common root would cancel a required simple pole; at a sixth root away from these points the right side has simple order. At either pole, its entire multiplicity therefore belongs to just one factor. If that pole is itself a sixth root, the extra simple factor is on that SAME side. This explicitly retains the coincidence boundary.

If both squared pole factors are in F+, it contains exactly ONE sixth root ρ. Rescale v by ρ and write, up to nonzero constants,
\[
F=J^2(v-1),\qquad G=(v^6-1)/(v-1).
\]
Require G(a)G(b)≠0. This condition retains a=ONE or b=ONE and excludes only a canceled actual pole. If the squared factors are on opposite sides, write
\[
F=(v-a)^2U(v),\qquad G=(v-b)^2V(v),\qquad UV=v^6-1,
\]
with U,V monic cubics and V(a)U(b)≠0. The cyclic order of the sixth roots is 1,−ω,ω²,−1,ω,−ω², where ω²+ω+1=0. Up to rotation and complement there are THREE partitions of six cyclic positions into triples: {0,2,4}, {0,1,2}, {0,1,3}. The two mixed rotation classes are complements, so no extra orientation is discarded. Complement exchanges the two maps/pole labels and a centered sign, all of which preserve the necessary local condition.

Absorb the common scalar into xi for this necessary local test only. Put N1=F−hG,N2=F+hG with h≠0. This does not assert that the fixed polynomial P is unchanged. The exact derivative numerators are
\[
Q_1=vJ N_1'-(3J+vJ')N_1,\qquad Q_2=J N_2'-J'N_2.
\]
Both have degree at most SIX in characteristic FIVE: the v² coefficient of 3J+vJ′ is FIVE, and the derivative of a degree-five term vanishes. Q2 has nonzero degree-six leading coefficient−2(1+h), since x2 really has its triple infinity pole. Also Q1(0)=−3J(0)N1(0)≠0. At the infinity point R2, x1 may have local index ONE or THREE, so Q1 may have degree SIX or FOUR. Reversing it to v6Q1(1/v) retains both cases and has nonzero leading coefficient.

All finite differential zeros have order TWO, since the actual only indices are ONE/THREE. Their rational pole denominators are squares. Hence both reversed Q1 and Q2 are scalar multiples of cubic squares. For a sextic with coefficients L,B,C,D1,E,H,I in descending order and L≠0, set
\[
C_n=4LC-B^2,\qquad D_n=8L^2D_1-BC_n.
\]
The exact square criterion, obtained by substituting a monic cubic square, is
\[
64L^3E-C_n^2-4BD_n=0,\quad
64L^4H-C_nD_n=0,\quad
256L^5I-D_n^2=0.
\]
Thus each complete factor type has six necessary equations in only a,b,h, with the explicit actual opens a b(a−b)h lead(Q1_reverse)lead(Q2) times the opposite-factor values. There is no assumption that a,b avoid all sixth roots and no extra leading-coefficient condition on the unreversed Q1.

This is a complete necessary reduction for rational B. It does not assert that satisfying these equations gives the fixed-P cube identity, the exact differential ratio, or any Y-map.
