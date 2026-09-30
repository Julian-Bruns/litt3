# Proof: two fourth traces exclude balanced endpoints

[Statement](../../Theorems/cartier_and_spin/klein_four_balanced_endpoint_exclusion.md).
This is a local extension of the received
[fourth endpoint lemma](klein_four_fourth_endpoint_trace.md).
It uses no bound on the degree or on unknown curve coefficients.

## Four necessary equations

Put K=F_(5^14), q=5^7, bar(z)=z^q, and normalize the first balanced
phase to1. The other phase is phi in mu29. Put
\[
x=M_2,\quad y=M_6,\quad\kappa=[17],\quad b=[8],
\quad\bar b=[24],\quad a=[12]=b^2,
\quad b\bar b=4.
\]
The old moments and the two new trace coefficients give
\[
\epsilon(1-\bar x)=\kappa\phi^5-\bar y,
\qquad\epsilon(\kappa-y)=\phi^8-x,
\tag{1}
\]
\[
\epsilon x^{625}-\bar y^5=b\epsilon+\bar b,
\qquad\bar x^{625}-\epsilon y^5=b\phi^{17}+\bar b\epsilon\phi^4.
\tag{2}
\]
Here M3=x625, M_-3=bar(x)625, M1=y5, M_-1=bar(y)5,
because the integer pole weights lie in F5 after reduction.

At least one coefficient of epsilon in(1) is nonzero. If both
vanished, x=1,y=kappa; the second right side would force phi=1,
and the first would be kappa-bar(kappa)!=0. Hence every balanced
solution of(1) already has epsilon in K. No geometric scale has
been discarded by working in this finite coefficient field.

Write N=epsilon bar(epsilon) in K+=F_(5^7). At N=1,(1) requires
\[
\kappa\phi^5-\epsilon(1-\phi^{-8})-\bar\kappa=0.
\tag{3}
\]
For phi=1 this is impossible. Otherwise it specifies one epsilon;
the exact field test below verifies its norm is never1.

For N!=1,(1) uniquely gives
\[
\bar y=\frac{\kappa\phi^5-\epsilon(1-\phi^{-8})-N\bar\kappa}{1-N},
\qquad x=\phi^8-\epsilon\kappa+\epsilon y.
\tag{4}
\]

## A small norm eliminant covers the whole field

Conjugate the second equation of(2), multiply by epsilon and
subtract the first. Then
\[
(1-N)\bar y^5=\epsilon(\bar b\phi^{12}-b)+bN\phi^{25}-\bar b.
\]
Substitute(4) and use1-N5=(1-N)^5. Define polynomials in N
\[
\alpha=1-\phi^{18},\quad
B=(1-N)^4(\bar b\phi^{12}-b),
\]
\[
C=(1-N)^4(bN\phi^{25}-\bar b)+N^5\kappa-\bar\kappa\phi^{25}.
\]
Every solution satisfies
\[
\alpha\epsilon^5+B\epsilon+C=0.\tag{5}
\]
Bar acts on coefficients of K[N] and fixes N. If phi=1, B is
nonzero for N!=1; norm compatibility requires
C bar(C)-N B bar(B)=0, a polynomial of degree ten.

Otherwise alpha!=0. Conjugate(5), substitute bar(epsilon)=N/epsilon,
and eliminate epsilon5 by(5). The resulting quadratic is
\[
Q=q_2\epsilon^2+q_1\epsilon+q_0=0,
\]
\[
q_2=\bar C B,\quad
q_1=\bar BNB+\bar CC-\alpha\bar\alpha N^5,
\quad q_0=\bar BNC.
\]
Its fifth power, reduced with(5), gives the second quadratic
\[
T=q_2^5(B\epsilon+C)^2-\alpha q_1^5(B\epsilon+C)+\alpha^2q_0^5=0.
\]
Thus Res_epsilon(Q,T)=0. Fixed quadratic degrees are retained,
including vanishing leading coefficients; this is a necessary
condition even at every degree drop. No leading q_i is divided out.
The resultant has degree123 in N in the four nontrivial phase cases.

Coefficient25-Frobenius fixes all F25 constants and permutes the
29 phases in five orbits, represented by exponents0,1,2,4,8.
Intersect each necessary eliminant with N^q-N by exact gcd.
The complete result is:

| Phase exponent | Eliminant degree | Field-norm gcd degree | N!=0,1 roots | Scales satisfying(5) and their norm | Scales satisfying(1)–(2) |
| --- | ---: | ---: | ---: | ---: | ---: |
| 0 | 10 | 0 | 0 | 0 | 0 |
| 1 | 123 | 4 | 2 | 2 | 0 |
| 2 | 123 | 2 | 0 | 0 | 0 |
| 4 | 123 | 4 | 2 | 2 | 0 |
| 8 | 123 | 2 | 0 | 0 | 0 |

For each remaining N, intersect(5) with epsilon^(q+1)-N.
All its roots are in K, since N is in K+ and nonzero. The four
resulting scales reconstruct x,y by(4); each fails both equations(2).
The product of the retained linear factors equals every computed
gcd, so no algebraic root or multiplicity is missing. N=0 is
forbidden by nonzero epsilon and N=1 is separately handled by(3).
This proves the complete balanced exclusion.

## Even one balanced endpoint is impossible

By endpoint interchange assume Q is balanced, normalized to phase1.
If epsilon belongs to K, the established subfield-scale theorem makes
H balanced too, already excluded. Suppose epsilon is outside K.
The first new trace identity is still the first equation of(2), even
though H need not be balanced. Its two coefficients lie in K, so
linear independence of1,epsilon over K forces
\[
x=[8]=b,\qquad y=-\bar b.
\]
The old moments now give, without a hypothesis on H,
\[
C(H)=\eta\bigl(\epsilon(1-\bar b)-b\bigr),\qquad
E(H)=\eta\bigl(\epsilon(\kappa+\bar b)+b\bigr).
\]
Use sigma=5^42-Frobenius, fixing K and cycling the four root types.
The established canonical coefficient identities say that E(H) has
zero eigenvalue3 component for every H, whereas its eigenvalue4
component is lambda times the corresponding c-label sum, with
lambda=[12]. Since kappa+bar(b)=[11]!=0, the first fact forces
epsilon_3=0 and hence C(H)_3=0.

The short cyclotomic-relation lemma used in the subfield-scale proof
then applies to H: group its four labels by their phases. There is
one group of four, or two opposite-type pairs. If H were balanced,
the old moments with nonzero coefficients would already put epsilon
in K. Thus it is not balanced. Define
\[
h_r=\sum_{(i,\xi)\in H}(-1)^i\xi^r\quad(r=5,8).
\]
Both are nonzero and R=h5/h8 satisfies R/bar(R) in mu29. This
follows for one phase immediately; for two phases write
h_r=2s(xi^r+tau psi^r), giving
h_r/bar(h_r)=tau(xi psi)^r. Repeated labels are included.

On the other hand, the eigenvalue4 components of the two displayed
old moments give
\[
\frac{E(H)_4}{C(H)_4}
=\frac{\kappa+\bar b}{1-\bar b}=[9]
=\lambda\frac{h_8}{h_5}.
\]
Here C(H)_4 is nonzero by the same short-relation lemma, so the
division is legitimate. Thus R=lambda/[9] lies in F25*, and
its inverse [9]/lambda=[20] is not in F5. Consequently
R/bar(R) is a nontrivial member of mu6, contradicting its membership
in mu29. This excludes the one-balanced case without further
elimination or a pole-weight enumeration.

## Reproduction and independence

The [producer](../../scripts/arithmetic/klein_four_balanced_fourth_elimination.py)
uses Sage with an absolute F5 polynomial of degree14. It saves the
[complete small eliminant/root certificate](../../../litt3-computation-data/degree40_reply_20260926/balanced_fourth_elimination.json).
The [independent verifier](../../scripts/arithmetic/verify_klein_four_balanced_fourth.py)
instead uses F25[zeta]/(4,22,7,20,21,7,24,1), constructs the quadratic
resultant by
(a2b0-a0b2)^2-(a2b1-a1b2)(a1b0-a0b1), performs explicit Euclidean
division and modular powering, and checks all retained linear factors.
It calls no resultant, factorization or root finder. Both programs
reconstruct the necessary equations; their field models and elimination
implementations differ. The
[complete verification receipt](../../../litt3-computation-data/degree40_reply_20260926/verify_balanced_fourth.log)
passes all five phase orbits and all four final candidates.

Run sage -python on the producer with --output followed by a JSON
path; run sage -python on the verifier with that JSON path as argument.
No actual curve is inferred from any intermediate solution.
Earlier exhaustive small-group and prime-field-norm checks are retained
as useful special cases in the same external evidence directory.
