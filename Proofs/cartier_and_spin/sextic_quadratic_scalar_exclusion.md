# Proof: prime-field phase weights exclude both quadratic scalar ends

27 September2026. Put B=F25 with beta^2=beta+3 and coding
[a+5b]=a+b beta. Let E=F_(5^8), K0=F_(5^14); their intersection is B
and they are linearly disjoint over B. Choose xi of order29 and roots
alpha_i=alpha_0^(25^i), where
\[
\alpha_0^4+[7]\alpha_0^3+[6]\alpha_0^2+[2]\alpha_0+[5]=0.
\]
For a multiset L of labels (i,j), with i modulo4 and j modulo29, use
\[
U_L=\sum f_0(\alpha_i)\xi^{17j},\qquad
V_L=\sum f_1(\alpha_i)\xi^{4j},
\]
where f0=(20,12,13,8) and f1=(21,21,20,2), in ascending B codes.
The actual fourth traces supplied by the cubic-descent calculation are
\[
\epsilon U_{L_0}+V_{L_0}
 =[22](\epsilon X^{625}-\overline Y^5),\qquad
U_{L_\infty}+\epsilon V_{L_\infty}
 =[22](\overline X^{625}-\epsilon Y^5),
\]
with X,Y in K0. The equations are additive in all branches; no trace
is divided by six and no endpoint label is discarded.

Assume epsilon belongs to B*. Both right-hand sides then belong to K0.
We will prove that for any six- or seven-label L,
\[
\lambda U_L+V_L\in K_0,\quad\lambda\in B^*
\quad\Longrightarrow\quad\lambda\in\{[10],[18]\}.
\tag{1}
\]
Applying this at zero and, after division by epsilon, at infinity
would require epsilon and epsilon^-1 both to lie in that set. But
[10]^-1=[9] and [18]^-1=[11], disjoint from it. This is the desired
contradiction.

## Exact phase facts

Two finite facts are used.

1. Any six distinct powers of xi are linearly independent over F5.
   This differs from independence over B, which fails for some six-sets.
   Normalize one exponent to zero. The complete98,280 six-set enumeration
   over B has98,154 rank-six sets and126 rank-five sets. Independent Sage
   arithmetic splits the seven B coordinates into fourteen F5 coordinates
   and checks rank six for ALL126 exceptional sets. Thus all sets have
   rank six over F5, and every subset of at most six is independent too.

2. Let c_j belong to F5, not all zero, with support of size at most three.
   Then
   \[
   \frac{\sum c_j\xi^{4j}}{\sum c_j\xi^{17j}}\in B
   \quad\Longrightarrow\quad
   \operatorname{supp}(c)=\{0\},\quad\text{quotient}=1.
   \tag{2}
   \]
   The denominator is nonzero by fact1. Normalize the first nonzero
   coefficient to one. The exact exhaustive counts for support sizes
   one,two,three are29,1624,58464; only the support{0} is accepted.
   One implementation uses relative seven-coordinate B arithmetic
   and direct proportionality. An independent implementation uses
   absolute F_(5^14) arithmetic and tests Y^25 X=Y X^25.
   Both cover every geometric B quotient, not just a supplied list.

The prime-field distinction is essential. Some six-set B relations have
coefficients lying in only two F5 projective directions; a blanket
assertion excluding such relations would be false. Fact2 tests the
specific exponent coupling17 versus4, not arbitrary six-set relations.

## Root Fourier components

Define
\[
a_l=\frac14\sum_{i=0}^3 2^{-li}f_0(\alpha_i),\qquad
b_l=\frac14\sum_{i=0}^3 2^{-li}f_1(\alpha_i).
\]
Here1/4=4 in F5. These are actual root projections, with a_l^(25)=2^l a_l.
The three a_l for l=1,2,3 are nonzero, so1,a1,a2,a3 form a B-basis
of E. Direct exact polynomial arithmetic gives
\[
b_1=-[10]a_1,\qquad b_2=-[18]a_2,\qquad b_3=0.
\tag{3}
\]
For each phase j let m_ij be the INTEGER multiplicity of (i,j), and put
\[
c_{l,j}=\sum_{i=0}^3 2^{li}m_{ij}\in\mathbf F_5,
\qquad S_l(k)=\sum_j c_{l,j}\xi^{kj}.
\]
Using the E-basis over K0, condition(1) and(3) give
\[
S_3(17)=0,\quad
\lambda S_1(17)=[10]S_1(4),\quad
\lambda S_2(17)=[18]S_2(4).
\tag{4}
\]

## Integer cardinalities reduce the number of phases

For cardinality six, fact1 separates the coefficients in S3(17), so
c_(3,j)=0 at every phase. The same holds for cardinality seven: if all
seven phases occurred, each would carry one nonzero coefficient.
For that case one may either use the independently enumerated prime-field
seven-set rank, or the general prime-field rank check described below.
Thus each occupied phase has at least two labels, since a singleton
would contribute the nonzero weight2^(3i). There are at most three
occupied phases in either cardinality.

If the coefficients c_(l,j) for l=1 or2 are not all zero, fact2 applied
to(4) forces their support to be{0}, and respectively lambda=[10] or[18].
It remains to show that one of those coefficient families is nonzero.
Otherwise all three nonconstant root Fourier components vanish at
EVERY phase. Fourier inversion makes the four root multiplicities at
each phase equal modulo five. Their integer sum is therefore4r+5b,
with0<=r<=4 and b>=0. Summing over phases gives4a+5b with a,b>=0.
Neither six nor seven has that form. This contradiction proves(1).

## Verification and scope

[The normalized B-set driver](../../scripts/arithmetic/verify_six_phase_rank_complement.cpp)
supplies the complete exceptional-six-set list. The independent
[direction and prime-rank check](../../scripts/arithmetic/check_phase_dependency_directions.py)
checks each exception using Sage arithmetic. The standalone
[prime-field rank driver](../../scripts/arithmetic/verify_prime_field_phase_independence.cpp)
also checked every normalized set directly:98,280 six-sets and376,740
seven-sets all have full prime-field rank. Its larger checks through ten
are supplementary and not needed for the sextic conclusion.

[The quotient enumerator](../../scripts/arithmetic/short_phase_quotients.py)
and its [independent absolute-field verifier](../../scripts/arithmetic/verify_short_phase_quotients.py)
agree on all60,117 cases. The latter also reconstructs(3) and the
inverse scalar codes directly over F_(5^8).

Exact data and execution outputs are in
[the external phase directory](../../../litt3-computation-data/prime_field_phases_20260927/).
The files short_phase_quotients.json, short_phase_quotients_independent.json,
six_dependency_directions.json and rank6.log/rank7.log contain the
essential finite conclusions. The codes define their arithmetic
without external tables. C++17 with assertions and Sage10.9 were used.

This proof uses only necessary conditions satisfied by the actual sextic
maps, hence excludes that scalar sector. It neither realizes nor excludes
the remaining scalars in E minus B. The seven-label extension is an
abstract trace lemma; deriving its hypotheses for an actual higher-degree
comparison remains a separate step.
