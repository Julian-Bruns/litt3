# All-etale p-rank gradients: verified endpoint and unresolved opposite endpoint

Date: 2026-09-05. Bounded literature audit by `/root/etale_p_rank_gradient_literature`.
No solution to Litt3 is claimed. All curves below are smooth proper connected,
of genus at least two, over an algebraically closed field of characteristic p.

## 1. Primary theorem, with proof mechanism checked

[Tamagawa, *Tame Fundamental Groups of Curves*](https://library.slmath.org/books/Book41/files/tamagawa.pdf),
Remark 4.8 and Theorems 4.9(i), 4.11 (also Theorem 0.5), apply directly to proper curves.
Put N=p^m-1 and let C_N correspond to the kernel of
pi_1(C) -> pi_1(C)^ab/N. Then

\[
 [C_N:C]=N^{2g},\qquad
 g-1-\frac{3^{g-1}g!(g-1)}N
 \le \frac{f(C_N)}{N^{2g}}
 \le g-1+N^{-2g}.
\]

Thus f(C_N)/[C_N:C] tends to g-1. This is an unconditional theorem,
not an assumed version of a p-average consequence. Remark 4.8 identifies
the average of character Hasse-Witt invariants with the actual p-rank of
this connected abelian cover. The proof of 4.9(i) sums character bounds;
Theorem 3.12 bounds exceptional torsion line bundles using the theta divisor.
No genericity or ordinariness assumption is imposed on C.

## 2. Consequences derived here, with explicit quantifiers

Write R(W)=(f(W)-1)/(g(W)-1) and D(W)=1-R(W).
Every V/C finite etale admits refinements W/V with R(W) arbitrarily
close to 1, by applying the theorem to V and using Riemann-Hurwitz.
Consequently the directed-tail invariants are

\[
 \inf_{V/C}\sup_{W/V}R(W)=1,
 \qquad
 \sup_{V/C}\inf_{W/V}D(W)=0.                 \tag{1}
\]

All displayed cover quantifiers mean connected finite etale covers,
and allow the identity. These constants cannot distinguish
commensurability classes, even without the one-sided universality assumption.

The opposite endpoint

\[
 L_p(C):=\sup_{V/C}\inf_{W/V}
             \frac{f(W)-1}{g(W)-1}                         \tag{2}
\]

is invariant under finite etale commensurability: replacing C by a
finite etale cover restricts to a tail, and any two cover objects have
a common refinement. Its bounds are 0<=L_p(C)<=1. For the lower bound,
choose V with f(V)>=1 using Section 1; every W/V has f(W)>=f(V),
since J(V) is an isogeny factor of J(W).

This search found no primary theorem computing (2) for the fixed curves
in the project, no proof that it is universal, and no example separating
two commensurability classes. This is a search outcome, not a claim that
the question is formally known to be open in the literature.

An unqualified infimum over all W/C is different from (2), and need not
be invariant under base change. Likewise a cofinal nested sequence need
not preserve a net's limsup or liminf for a nonmonotone function R.
Equation (1) DOES permit construction of a nested cofinal sequence with
R tending to 1: enumerate covers, take a common refinement at each step,
then apply Section 1. It does NOT show that every prescribed cofinal
sequence has limsup 1. Over Fbar_p the covers are countable.

For an etale Galois p-cover W/V, Deuring-Shafarevich and
Riemann-Hurwitz give R(W)=R(V). A p-tower therefore retains this
constant; it is not a calculation of (2), since a pro-p tower is not
cofinal among all etale covers.

## 3. Normalized Newton measure adds no obstruction at the ordinary endpoint

Define mu_W=(2g(W))^{-1} sum_lambda multiplicity(lambda) delta_lambda,
the probability measure on the Newton slopes of J(W).
Slopes 0 and 1 each have multiplicity f(W). Hence along the covers in
Section 1,

\[
 \mu_W\longrightarrow \tfrac12(\delta_0+\delta_1).
\]

Indeed the interior mass is (g(W)-f(W))/g(W), tending to zero.
The total-variation distance (supremum-over-events convention) from
the displayed ordinary measure equals that interior mass. Thus every
tail has measures arbitrarily close to the same ordinary limit.
Any invariant defined as the lower-tail distance from ordinariness,
including any bounded continuous slope statistic vanishing at 0 and 1,
vanishes universally. Opposite extremal statistics are not computed here.

## 4. Generalized Deuring-Shafarevich does not compute arbitrary-cover gradients

[Stalder, *On p-rank representations*](https://arxiv.org/pdf/math/0402340),
Theorem 4.8, Remark 4.9, and Theorem 5.4, were inspected including the
proof of 5.4. For free G-actions the Cartier-stable differential module
has nonprojective core Omega_G^2(k); projective multiplicities remain
additional Borne invariants. For N normal in G and H=G/N, the formula is

\[
 b_G(T)+d(G,X,T)=b_H(T)+d(H,X/N,T),\quad T\in\operatorname{Irr}(H),
\]

where d is the dimension of locally trivial H^1; for free actions it
is dim H^1(G,T). The proof compares invariants of sufficiently enlarged
differential modules, then subtracts residue contributions. Crucially,
only representations factoring through H occur in this formula.
When N is a p-group all irreducibles factor through H (Remark 5.5),
recovering the complete p-group formula. For arbitrary N, this leaves
uncontrolled projective multiplicities; it is not a genus-and-p-rank
formula for arbitrary Galois covers. The free-action congruence
f(X)=1 mod |G|_p also follows (Corollary 4.11), but supplies no value
for (2).

Practical result: close the ordinary-endpoint gradient route using the
explicit primary theorem. Keep the opposite endpoint (2) only as an
uncomputed candidate, not as a claimed separating invariant.
