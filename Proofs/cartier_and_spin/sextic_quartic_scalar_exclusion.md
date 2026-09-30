# Proof: odd root characters force paired intermediate-field endpoints

27 September2026. Keep the fields, coding, roots alpha_i, phase xi and
fourth traces of [the F25-sector proof](sextic_quadratic_scalar_exclusion.md).
Put B=F25, E4=F625, E=F_(5^8), K0=F_(5^14), eta=[22], and
bar(z)=z^(5^7) for z in K0. In addition to the fourth traces, use
\[
\epsilon(E_0-\eta\bar X)=C_\infty-\eta\bar Y,\qquad
\epsilon(C_0-\eta Y)=E_\infty-\eta X,
\tag{1}
\]
where C_L=sum c(alpha_i)xi^(5j), E_L=sum e(alpha_i)xi^(8j), and
c=(22,7,9,23), e=(1,3,8,15). These are necessary identities on the
actual common source, with X,Y in K0 shared by ALL equations.

Write a_l for the Fourier components of f0 and b_l for those of f1,
normalized as in the F25-sector proof. Independent field arithmetic gives
\[
a_2^2=[9],\quad a_2a_1/a_3=d=[19],\quad
a_2a_3/a_1=e=[14],\quad de=[9],\quad
b_1=-[10]a_1,\quad b_3=0.
\tag{2}
\]
The first and third Fourier components of c are nonzero. The symbol e
in(2) denotes a scalar; e(x) in(1) remains the specified polynomial.

The F25 case is already excluded. Write epsilon=a+b a2, with a,b in B
and b nonzero. At one endpoint put
c_(l,j)=sum_i 2^(li)m_ij in F5 and S_l(k)=sum_j c_(l,j)xi^(kj).
Membership epsilon U+V in K0+epsilon K0 implies its two odd root
components vanish, so
\[
a S_3(17)+bd S_1(17)=0,\qquad
a S_1(17)+be S_3(17)=[10]S_1(4).
\tag{3}
\]

## The first relation separates phase by phase

Any five distinct phases are B-independent. Every deficient six-set
has rank five and a one-dimensional relation space. Among the126
normalized deficient sets,84 relations have five distinct F5-projective
coefficient directions. The other42 have two groups of three directions,
but at least one group does not have coefficients all equal up to sign.
These assertions include all six-sets: the full98,280-set enumeration
and independent kernel reconstruction are retained.

If an endpoint has at most five phases, B-independence separates(3).
If it has six phases, each has exactly one label. Its relation coefficient
at root index i is
\[
2^i\bigl(a(-1)^i+bd\bigr).
\]
The nonzero coefficients have at most two F5-projective directions,
and within each root-parity group they differ only by sign. This cannot
be any of the126 deficient relations. If a coefficient vanishes, the
remaining at most five are independent. Hence in every case
\[
a c_{3,j}+bd c_{1,j}=0\quad\text{for every phase }j.
\tag{4}
\]

## Only four unpaired scalar possibilities

If a=0, equations(3)--(4) and prime-field six-phase independence force
c1,j=c3,j=0. If a is nonzero put tau=-bd/a. When tau is outside F5,
(4) has the same consequence. Otherwise tau belongs to F5*, and
\[
c_{3,j}=\tau c_{1,j},\qquad
\lambda S_1(17)=[10]S_1(4),\quad
\lambda=a+be\tau=\operatorname{Nm}_{E4/B}(\epsilon)/a\ne0.
\tag{5}
\]
There are two exact phase facts. A nonzero F5 coefficient vector supported
on at most three phases has quotient S(4)/S(17) in B only when its support
is{0} and the quotient is1. This was independently checked earlier.
The same assertion holds for every F5 vector of Lee weight at most six,
where the Lee weights of1,2,3,4 are1,2,2,1. For the latter, every such
vector is a difference of two radius-three Lee-ball vectors. The complete
ball has34,221 elements. For the map c->sum c_j(mu xi^(17j)-xi^(4j)),
each mu in B* other than1 is injective on that ball. For mu=1, two ball
vectors can have the same image only when they differ at phase0.
Both relative native arithmetic and independent absolute F_(5^14)
arithmetic check all24 maps; the latter uses no native field tables.

For tau=1, (4) makes the odd-root difference zero and c1 is the even-root
difference; its Lee weight is at most the six labels. For tau=-1, c1/2
is the odd-root difference with that bound. For tau=2 or-2, a singleton
phase cannot satisfy(4), so at most three phases occur. Thus either
c1=c3=0 everywhere or the corresponding phase lemma forces lambda=[10].
The four possibilities in the latter case are

| tau | a | b | lambda for epsilon inverse |
| ---: | ---: | ---: | ---: |
|1|[8]|[3]|[6]|
|2|[16]|[10]|[7]|
|3|[16]|[15]|[7]|
|4|[8]|[2]|[6]|

Indeed inversion changes tau to-tau, and its lambda is1/a, never[10].
Apply this at zero with epsilon and at infinity with epsilon inverse.
At least one endpoint therefore has c1=c3=0 at every phase.

Fourier inversion says its opposite-root counts agree modulo five.
Since the INTEGER cardinality is six, it is exactly three opposite-root
pairs: six=2A+5B forces B=0. Such an endpoint has C,E in E4 K0.
The first or second equation of(1) then puts C of the other endpoint
in E4 K0. Its two nonzero odd c-components and prime-field six-phase
independence force that endpoint to be paired as well.

## Complete paired-endpoint matching

A pair label is (p,j), p=0,1, j modulo29, representing roots(p,p+2).
In the basis(1,a2), its four root sums are

| family | p=0 | p=1 |
| --- | --- | --- |
|c|([15],[15])|([15],[10])|
|e|([11],[13])|([11],[17])|
|f0|([24],[2])|([24],[3])|
|f1|([3],[24])|([3],[6])|

Each endpoint is a multiset of three of the58 labels, exactly34,220
choices. For each of the600 scalars a+b a2, b!=0, the second equation
in(1) solves X,Y uniquely by comparing the coefficients of1,a2:
\[
W=(\epsilon C_0-E_\infty)/\eta=w_0+w_1a_2,\qquad
Y=w_1/b,\quad X=aY-w_0.
\]
Substitute in the other three traces. Their42 B coordinates are additive
in the two endpoint multisets. A fixed explicitly generated F5-linear
projection of these coordinates is used only to reject pairs: exact
equality necessarily gives projected equality. All34,220 triples on
each side are sorted and compared for EACH scalar. There are zero
projected matches in the entire600-scalar check, hence no exact match.
No division by a trace cardinality or averaging over a finite group occurs.

## Reproducibility and limits

The [native paired matcher](../../scripts/arithmetic/sextic_paired_endpoint_match.cpp)
and [small data generator](../../scripts/arithmetic/sextic_paired_endpoint_data.py)
specify every arithmetic operation and the rejection projection. The
[independent Sage reconstruction](../../scripts/arithmetic/verify_sextic_paired_syndromes.py)
starts with the four literal traces in a different field implementation.
It checks ALL600*116*42=2,923,200 syndrome coordinates against the native
implementation, including all coefficient Frobenius operations.

The [Lee-ball verifier](../../scripts/arithmetic/verify_phase_lee_kernel.py),
[six-set direction verifier](../../scripts/arithmetic/check_phase_dependency_directions.py)
and [Fourier/scalar verifier](../../scripts/arithmetic/verify_sextic_quartic_scalar_reduction.py)
provide the other independent checks. The exact logs and JSON summaries
are in [the phase evidence directory](../../../litt3-computation-data/prime_field_phases_20260927/).
Relevant files are phase_lee_independent.json, six_dependency_directions.json,
quartic_scalar_reduction.json, paired_syndromes_independent.json and
paired_match.log. The native field arithmetic had already been checked
against polynomial multiplication; the new paired-coordinate reconstruction
does not reuse it.

These finite tests cover all geometric possibilities in the specified
sector because the scalar field and endpoint label set were proved
finite beforehand. This proof alone leaves E minus E4 unresolved.
