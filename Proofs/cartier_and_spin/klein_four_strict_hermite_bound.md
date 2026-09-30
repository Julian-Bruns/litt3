# Proof of the strict character bound

Use the [statement](../../Theorems/cartier_and_spin/klein_four_strict_hermite_bound.md)
and the proved Hermite theorem. The latter gives c_i<=16+2d_i.
For e<=12 the proposed strict inequality is automatic, since c_i<=12
and d_i>=0. For d_i>=7 it is also automatic, since c_i<=29. It remains
to exclude c_i=16+2d_i for d_i=0,...,6, which in particular implies
e>=16 and permits the Hermite construction.

## The minimum word and its endpoint value

Suppress the character index and put d=d_i,c=16+2d. Let
\[
F=2t^{22}T-DN-BT=t^{22}T-\epsilon D U.
\]
It vanishes at the c roots of C=C_i and belongs to S_d. For0<=d<=5
the MDS result makes this vanishing space one-dimensional, defined over
M=F_(25^7). The pair (T,N) is recovered injectively, so its projective
class is defined over M. For d=6 the space is simply all polynomials
of degree<=28, and vanishing at28 roots also leaves one dimension.
The exact rational identity is
\[
\epsilon\frac{u_i}{t^3w_i}
=\frac{t^{22}T-F}{(t^{29}-1)T}. \tag{1}
\]
If T(0)!=0, its value and derivative at0 are in M. The coefficient-field
lemma in the Hermite proof therefore forces the value to be
[22]*zeta^a for some29th root. Consequently
\[
\left(\frac{F(0)}{2T(0)}\right)^{29}=[18]. \tag{2}
\]
Here [22]/2=[11], and [11]^29=[18]; [11] and[18] are the two primitive
cube roots in F25. The epsilon factor has been retained in (1), so no
field assumption on epsilon is made.

## Explicit word reconstruction from the complementary roots

Let J be the complement of the roots of C in mu29. Its size is
N=13-2d. For d<=5 set
\[
h_k=(-1)^k e_k(J),\qquad h_0=1,
\]
with h_k=0 for k<0 or k>N. These are the complete symmetric functions
of the C-roots in the range used here, because
\[
\prod_{c\in C}(1-cz)^{-1}
=\frac{\prod_{a\in J}(1-az)}{1-z^{29}}.
\]
Write T=sum_(r=0)^d t_r*t^r. Dividing t^22*T by C, the remainder
must have degree<=15+d. Vanishing of its next d coefficients gives
\[
\sum_{r=0}^d t_r h_{7-2d+l+r}=0\qquad(0\le l<d). \tag{3}
\]
The cofactor vector of this d by(d+1) matrix gives T, up to scalar.
For d=0 take T=1. If Q is the polynomial part of t^22*T/C, then
F=2C Q, and
\[
Q(0)=q_0:=\sum_{r=0}^d t_r h_{6-2d+r},\qquad
F(0)/(2T(0))=C(0)q_0/t_0.
\]
Since c is even, C(0) is a29th root. Thus (2) is exactly
\[
q_0^{29}=[18]t_0^{29}. \tag{4}
\]

For completeness, under t'=1/t and swapping the two endpoints, the
other normalized value is F_(15+d)/t_d. The same polynomial division
gives F_(15+d)=-2 sum_r t_r h_(7-d+r). The complete verifier checks
both endpoint identities, although the first already excludes every
case after its nonzero denominator has been verified.

## Complete finite certificate

Normalize J to contain1, then take orbits under multiplication by mu29
and Frobenius5 on its nodes. Translation multiplies the ratios in(4)
by29th roots. Frobenius5 exchanges[11] and[18]. Therefore it suffices
to test both target constants on one representative of each orbit.
This uses symmetries of the necessary word equations, not a presumed
Frobenius automorphism of the unknown curve.

For each representative the cofactor kernel and T(0) are nonzero,
and neither target in(4) occurs. The exact counts are
\[
\begin{array}{c|r|r}
d&\text{normalized subsets}&\text{orbit representatives}\\
0&30421755&167367\\
1&13123110&85358\\
2&3108105&24739\\
3&376740&3872\\
4&20475&299\\
5&378&10.
\end{array}
\]
In every row the sum of normalized orbit sizes equals the entire
binomial count binom(28,12-2d). The calculation uses exact arithmetic
in F25[zeta]/(4+6zeta+23zeta^2+9zeta^3+5zeta^4+23zeta^5+8zeta^6+zeta^7),
whose field and primitive-root properties were already certified.

Source:

- [d=0 exhaustive evaluator](../../scripts/arithmetic/klein_four_minimum_word_endpoints.cpp);
- [d=1,...,5 exhaustive cofactor evaluator](../../scripts/arithmetic/klein_four_minimum_word_all.cpp);
- [independent direct polynomial reconstruction](../../scripts/arithmetic/check_klein_four_minimum_words.py).

The first two programs compile with C++17. Run the second with arguments
1 5. They assert coverage, kernel rank and all claimed exclusions before
successful completion. The independent program, using --output, checks
24 direct quotient-polynomial reconstructions. It solves the opposite
coefficient system for Q, checks the exact29-node zero set and both
endpoint formulas, rather than using the cofactor routine. These24
checks validate implementation independently; they do not replace the
complete orbit enumeration.

Logs `minimum_word_endpoints.log`, `minimum_word_all.log` and
`minimum_word_independent.json` are under
[overnight_three_replies_20260926](../../../litt3-computation-data/overnight_three_replies_20260926/).
A development loop-advance bug was corrected before any completed
certificate was reported; the final orbit counts guard this failure mode.

For d=6 the complementary set has one root a. Directly
\[
C=(t^{29}-1)/(t-a),\qquad
T_r=\tfrac12 a^{6-r}\quad(0\le r\le6),
\qquad F(0)/T(0)=2a^{22}.
\]
This is incompatible with [22]*mu29 because[11] is not a29th root.
Thus every equality case is excluded, proving the strict bound.

## Genus and the remaining degree89 profile

Substitute d_i=10+c_i-h_i into c_i<=15+2d_i and sum, using
sum c_i=2j and sum h_i=g+3. The number of odd c_i is zero or two,
giving exactly the asserted genus inequalities.

For n=89, retaining the full root-grid inequality and companion bound,
the previously exhaustive integer-profile list and g<=49+j leave only
(g,s,a,j1,j2,e)=(73,5,5,24,0,29). Thus sum d_i=2 and sum q_i=24.
Enumerating these three small nonnegative integers with
c_i=24-q_i<=15+2d_i and h_i=10+c_i-d_i gives the four rows stated.
This final finite arithmetic is a necessary count check only. No
branch polynomials, endpoint maps or geometric realizations are inferred.
