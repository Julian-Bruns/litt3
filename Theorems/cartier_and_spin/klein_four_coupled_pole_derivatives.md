# Coupled derivatives at the actual triple-pole fibers

Version1,26September2026. Retain all actual same-source hypotheses and
the notation of [Hermite pole matching](klein_four_hermite_genus_bound.md).
Assume e>=13. Write
\[
F_i=2t^{22}T_i+f_i,\qquad \deg f_i\le15+d_i,\qquad
B_i=(1-t^{29})T_i+t^7F_i.
\]
Here B_i is a polynomial, not the endpoint leading-value notation.
Let J_i^(1) be the product of the single-triple-pole values with
inertia kernel i, and J the product of ALL triple-pole values, of
degree j. At every root c of J_i^(1), with {i,j0,k}={1,2,3},
\[
T_{j0}(c)T_k(c)\ne0,\qquad
\frac{F_{j0}'(c)}{T_{j0}(c)}+rac{F_k'(c)}{T_k(c)}=3c^{21}.
\]
Equivalently (J_i^(1))^2 divides
2(1-t^29)T_j0 T_k+t^7(F_j0 T_k+F_k T_j0).
At a double-triple-pole value c, every B_i is divisible by (t-c)^2.

Put D=sum d_i=27+2j-g, T=T_1T_2T_3,
L=sum_i f_i T_j0 T_k and Q=sum_(i<j0) f_i f_j0 T_k. The actual
polynomial
\[
G=t^7Q+2(t^{29}+1)L+2t^{22}T
\]
satisfies
\[
J^2\mid G,\qquad\deg G\le44+D.
\]
Either G is nonzero and g<=71, or G is identically zero and D>=8,
so g<=19+2j. In the current actual V4 problem the already proved
degree cutoff gives n<=87, hence j<=25; in either case g<=71.
For e<=12, the earlier bound g<=27+2j<=51 is stronger. Thus
g<=71 holds for every actual V4 comparison. This does not close
any further covering degree by itself.

The new derivative identities couple the three characters. They
retain the actual pole cancellations and are stronger data than
separate degree bounds. They neither construct the two maps nor
decide the original unmarked common-cover problem.

[Proof and evidence](../../Proofs/cartier_and_spin/klein_four_coupled_pole_derivatives.md).
