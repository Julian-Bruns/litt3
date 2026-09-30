# Proof: the fourth traces do not require Klein-four monodromy

[Statement](../../Theorems/cartier_and_spin/pole_twelve_complete_exclusion.md).
This is a local extension of the completed
[endpoint determinant exclusion](quartic_endpoint_moment_exclusion.md).
A focused independent audit checked the change of geometric scope;
see [the integration audit](../../Research/audits/QUARTIC_COMPLETE_PARTIALS_2026_09_27.md).
No new finite enumeration is needed for the extension.

## Actual cubic descent and universal trace data

First replace the source by its jointly minimal model. By
[cubic descent](pole_twelve_cubic_descent.md), a pole-twelve
counterexample has k(T)=k(S)(y), y^3=P(u), and
\[
k(S)=k(u,v)=k(u,t)=k(v,t),\quad \deg t=4,\quad
A(v)=\epsilon^4t^{-13}A(u),
\]
\[
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\tag{1}
\]
The two original etale maps and their actual cubic reconstruction
remain in force. The full index-one branch has already been excluded.
There is no assumption that t is Galois or that the endpoint covers
have a simultaneous etale Galois closure.

The comparison parameter on T has simple zeros and poles. Since
t pulls back from S, its endpoint valuations on S and the cubic
ramification indices over them must both be one. Each endpoint
fiber of t on S therefore consists of four unramified points.
At t=0, v has pole order three and u meets a simple root of A;
the roles reverse at infinity. Repeated endpoint labels are allowed.

The [universal quartic trace calculation](quartic_trace_obstruction.md)
uses only(1) and the actual local ramification data. At a common
pole, u and v have equal pole order e in{1,3}. Its parameter value
c satisfies c^29=1. Writing ell=epsilon c^4, the parameter indices are
\[
(e,\ell)=(1,\ne1):1;\quad(1,1):4;\quad
(3,\ne1):2\text{ or }3;\quad(3,1):2.
\]
If d_c is the sum of these pole orders over c, then0<=d_c<=6.
The traces have only simple poles at common-pole values, with residues
\[
R_u(c)=\eta d_c(\epsilon^{-1}c^{-3}-c),\qquad
R_v(c)=\eta d_c(c-\epsilon c^5),\qquad\eta=[22]=-[8].
\tag{2}
\]
This includes the index-two, order-three case; the trace kills the
remaining odd principal part. A weight-five fiber contributes zero
in characteristic five. It must not be excluded by a V4-only profile
rule. Traces of functions regular at any other point remain regular,
so additional branch values produce no additional trace poles.

Set S_j=sum d_c c^j, K=F_(5^14), bar(x)=x^(5^7), x=S2, y=S6.
All weights reduce to F5, hence
\[
S_{-2}=\bar x,\quad S_{-6}=\bar y,\quad
S_3=x^{625},\quad S_{-3}=\bar x^{625},\quad
S_1=y^5,\quad S_{-1}=\bar y^5.
\tag{3}
\]
These relations also hold for weight five and require no choice
of a lift of the moments back to integer weights.

The old universal traces give
\[
\epsilon(E_Q-\eta\bar x)=C_H-\eta\bar y,\qquad
\epsilon(C_Q-\eta y)=E_H-\eta x.\tag{4}
\]
Their already proved non-simultaneous-denominator argument bounds
epsilon in F=F_(5^56). It does not bound the field of the curve S.

## The fourth trace globalizes for any quartic map

The [fourth endpoint coefficient](klein_four_fourth_endpoint_trace.md)
is a universal local calculation from(1). At the canonical zero
endpoint, put e=epsilon^-1 and Z=e t^3v. In the triangular series
equations the linear multipliers at orders1,2,3,4 are3,0,2,4,
up to the same nonzero factor. The resonant coefficient z2 is free,
but z4 is always f(alpha)+e g(alpha), with
f=(20,12,13,8), g=(21,21,20,2). This is true for arbitrary
resonant coefficients, without comparing different branches.
Phase covariance gives z4=xi^17 f(alpha)+epsilon^-1 xi^4 g(alpha).
Thus summing the four endpoint germs gives
\[
[t]\operatorname{Tr}(v)=\epsilon U_Q+V_Q.\tag{5}
\]
Here U,V are the corresponding unaveraged four-label sums.

For the GLOBAL part do not invoke a V4 trace-descent theorem.
Use(2) instead. Tr(v) is regular at infinity; its only poles are
the order-at-most-three pole at zero and the simple common poles.
Its partial fraction decomposition consists of a constant, terms
t^-3,t^-2,t^-1, and sum R_v(c)/(t-c). Consequently
\[
[t]\operatorname{Tr}(v)
 =-\sum_cR_v(c)c^{-2}
 =\eta(\epsilon S_3-S_{-1}).\tag{6}
\]
Equating(5) and(6), then interchanging the actual data
(t,u,v,epsilon)->(t^-1,v,u,epsilon^-1), yields
\[
\epsilon U_Q+V_Q=\eta(\epsilon x^{625}-\bar y^5),
\qquad U_H+\epsilon V_H=\eta(\bar x^{625}-\epsilon y^5).
\tag{7}
\]
Interchange is a relabeling of the two maps, not an automorphism of S.
This derivation never averages by the group or assumes t is Galois.

## Coefficient-only exclusions exhaust all endpoints

Once(4),(7) hold, the following previously proved arguments are
statements solely about these equations and the four-label sums.
Their older V4 applications impose no extra premise here.

1. The subfield-scale argument in
   [structural moments](klein_four_structural_moments.md) says that
   epsilon in K forces both endpoints balanced: each type occurs
   once at one common phase. The
   [balanced exclusion](klein_four_balanced_endpoint_exclusion.md)
   rules this out and also excludes a single balanced endpoint.
2. The [quadratic-scalar exclusion](klein_four_quadratic_scalar_exclusion.md)
   eliminates epsilon in L=F_(5^28) minus K. Its necessary endpoint
   determinant uses only projections of(4),(7); its invariant-pair
   dependency in [mixed-phase exclusion](klein_four_mixed_phase_exclusions.md)
   was proved before any pole-weight test.
3. Thus epsilon is outside L. If Q is half-turn-invariant, U_Q,V_Q
   lie in L. The first equation(7) and independence of1,epsilon
   over L force U_Q,V_Q in K. The nonzero character-four coefficient
   of g and the phasewise vanishing lemma then make Q balanced,
   a contradiction. Interchange treats H. This is the first section
   of [nonzero quadratic trace](klein_four_nonzero_quadratic_trace.md);
   its later trace-zero scalar computation is not needed here.
4. The common-phase calculation in the first section of
   [the oriented chart proof](klein_four_oriented_scalar_chart.md)
   covers each non-invariant common-phase endpoint against every
   other multiset, with arbitrary x,y in K. Its only determinant
   survivors force epsilon=0. Thus both endpoints are multiphase.

Neither the V4 Fourier-lift restriction on integer weights, nor its
character/genus arguments, nor the orientation of epsilon is used.
The hypotheses now agree exactly with
[the complete endpoint determinant theorem](quartic_endpoint_moment_exclusion.md),
which contradicts(4). This excludes every quartic monodromy at once.

## Consequences for pole and covering degrees

Jointly minimal pole-twelve data have12<=n<=186 by the established
contact bound, and the contradiction uses no further restriction on n.
For a nonminimal source the parameter descends, and its pole degree
is multiplied by the degree of the source refinement. Proper positive
nongap divisors of12 are3 and6, already excluded. Hence the assertion
also holds on arbitrary actual common sources.

All smaller allowable poles have been excluded by
[small supported norms](small_supported_norm_functions.md) and their
dependencies. Pole thirteen is excluded in every degree by
[its exact norm theorem](pole_thirteen_norm_exclusion.md).
Fourteen is not in the pole semigroup<3,10>. Thus the first possible
nonconstant comparison pole is fifteen. Since its degree is at most
the degree of either actual etale leg, covering degrees at most14
satisfy conditional field recognition. Passing to a jointly minimal
source only decreases those degrees.

This does not prove that an arbitrary unmarked span has a shared
lambda line or tensor. The original two common-cover problems remain
open, as do higher comparison poles.
