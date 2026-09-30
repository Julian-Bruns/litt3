# A small norm eliminant excludes every double balanced pair

27 September2026. Put K=F_(5^14), q=5^7, bar(a)=a^q. Use the
standard coding and kappa=[17],b=[8],bar(b)=[24]. A complete root block
at phase a contributes, after division by eta=[22],
(C,E,U,V)=(kappa*a^5,a^8,b*a^17,bar(b)*a^4).

For the two phases a1,a2 at zero and c1,c2 at infinity put
P_r=a1^r+a2^r and Q_r=c1^r+c2^r. Define
u=P8,v=kappa*P5,U=b*P17,V=bar(b)*P4, and
w=kappa*Q5,z=Q8,W=b*Q17,Z=bar(b)*Q4. All belong to K.
The four traces are exactly
\[
\epsilon(u-\bar X)=w-\bar Y,\quad
\epsilon(v-Y)=z-X,
\]
\[
\epsilon X^{625}-\bar Y^5=\epsilon U+V,\quad
\bar X^{625}-\epsilon Y^5=W+\epsilon Z.
\tag{1}
\]

## The scalar is in K

If epsilon is outside K, independence of1,epsilon over K in the
first two equations forces X=z=bar(u),Y=v=bar(w). Equality
Q8=P_-8 makes the two unordered infinity phases the inverses of
the two zero phases. Indeed phase sums of length two are injective,
including repetitions. The remaining equality then gives
(kappa-bar(kappa))*P_-5=0. Neither factor is zero: kappa is outside
F5, and a sum of two elements of the odd-order group mu29 cannot
vanish in characteristic five. Thus epsilon belongs to K.

## Uniform elimination, retaining every boundary

Set N=epsilon*bar(epsilon) in F_(5^7), D=u-bar(z). For N!=1 the
old traces uniquely give
\[
\bar Y=(w-\epsilon D-N\bar v)/(1-N),\qquad X=z-\epsilon v+\epsilon Y.
\tag{2}
\]
Conjugating the fourth trace, multiplying by epsilon and subtracting
the third yields a necessary equation
\[
\alpha\epsilon^5+B\epsilon+C=0,
\]
\[
\alpha=D^5,\quad B=(1-N)^4(\bar W-U),\quad
C=(1-N)^4(N\bar Z-V)-w^5+N^5\bar v^5.
\tag{3}
\]
When alpha=0, B is a nonzero polynomial on N!=1; use the necessary
norm polynomial C*bar(C)-N*B*bar(B). Otherwise, conjugation and
norm compatibility give the quadratic coefficients
\[
q_2=\bar C B,\quad q_1=\bar BNB+\bar CC-\alpha\bar\alpha N^5,
\quad q_0=\bar BNC.
\]
The quadratic Q=q2*epsilon^2+q1*epsilon+q0 and the quadratic
\[
T=q_2^5(B\epsilon+C)^2-\alpha q_1^5(B\epsilon+C)+\alpha^2q_0^5
\]
must have a common root. Their fixed-degree resultant, including
leading-coefficient drops, is a necessary polynomial in N of degree
at most123. No leading q_i is inverted. Intersect it with N^q-N.
For each resulting N!=0,1, intersect(3) with epsilon^(q+1)-N and
substitute every root into ALL four original equations.

At N=1 the old equations require w-bar(v)=epsilon*D. If D=0 the
left side is nonzero by the preceding inverse-pair argument. Otherwise
this gives one explicit candidate, whose norm is checked. In all
executed cases it has norm different from one. Thus no free moment
line on the norm-one boundary is discarded.

## Complete phase coverage and independent verification

The permitted mu29 coordinate rescaling sets a1=1. Coefficient25-
Frobenius fixes every F25 constant; the second zero phase has the five
orbit representatives xi^a,a=0,1,2,4,8. For EACH, all435 unordered
infinity phase pairs are retained, giving2,175 cases. This is geometric
coverage of the phase group, not a restriction on the source curve.

The [producer](../../scripts/arithmetic/eight_balanced_phase_pair_traces.py)
uses the absolute degree14 field, resultants and exact root finding.
There is no zero eliminant, omitted norm-one solution or surviving
trace point. The complete candidate counts for the five representatives
are490,444,370,444,370, respectively:2,118 in all.

The [independent verifier](../../scripts/arithmetic/verify_eight_balanced_phase_pair_traces.py)
uses a different degree14 polynomial basis, the literal quadratic
resultant identity, explicit Euclidean division and modular powers.
It calls no resultant, factorization or root finder. It verifies that
the products of the retained linear factors equal EACH norm gcd and
EACH scale gcd, so the roots and all degree-drop boundaries are complete.
All2,175 cases and2,118 candidates passed; every candidate fails at
least one fourth trace. The earlier relative-field verifier attempt
was stopped for speed and is not credited as a completed check.

The [evidence directory](../../../litt3-computation-data/eight_balanced_phase_pairs_20260927/)
contains phase0.json,...,phase8.json for the five representatives and
independent.json. Run the producer with an output path and --phase a;
run the verifier with an output path and the five case files. Sage10.9
was used. Both allow repeated phases and arbitrary common moments.
