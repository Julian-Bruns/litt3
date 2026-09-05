# A quadratic-twist rank bridge for testing unrestricted Tango descent

**Status: author proof, 2026-09-05; not independently audited.**
Author: `/root`. This is a parameterized construction and a sufficient
criterion, not a verified counterexample: the ranks required in its
application have not yet been found.

The construction retains two actual finite etale maps from the same
smooth projective curve. Its purpose is to test whether the positive-rank-
preserving theorem in file 115 can extend to arbitrary rank growth.
It does not itself disprove Litt Problem 3.

Work over an algebraically closed field of odd characteristic p. Write
gamma(C) for the p-rank and Tan(C) for the embedded maximal Tango
structures of files 111 and 115. All curves mentioned below are smooth,
projective and connected.

## 1. The actual two-leg construction

Let pi:Y -> B be a ramified double cover, with involution tau, and let
e:B' -> B be a connected finite etale double cover, with involution
epsilon. Suppose g(B) >= 2. Form

\[
 W=Y\times_B B',\qquad
 X=W/\langle (\tau,\epsilon)\rangle.
\]

### Lemma 119.1

The curve W is connected and smooth. Both natural maps

\[
 q:W\longrightarrow Y,\qquad r:W\longrightarrow X
\]

are finite etale of degree two. The induced X -> B is the quadratic
twist of Y -> B by B' -> B; it has the same branch divisor as Y -> B.
In particular,

\[
 g(X)=g(Y),\qquad g(W)=2g(Y)-1.
\]

#### Proof

The two quadratic extensions of k(B) are different: one is ramified
and one is unramified. They are therefore linearly disjoint. The fiber
product is connected, and it is smooth because its projection to Y is
the base change of an etale morphism. This proves the assertion about q.

The involution (tau,epsilon) is fixed-point-free: a fixed point would
in particular give a fixed point of epsilon on B'. Its quotient is
therefore smooth and r is an etale double cover. The quadratic
characters of Y/B and B'/B multiply to the character of X/B. Since
the second is unramified, the first and the product have exactly the
same nontrivial inertia at every point. This proves the branch assertion.
Riemann--Hurwitz gives both genus identities. QED.

## 2. Exact p-rank identity

### Lemma 119.2

For this construction,

\[
 \boxed{\gamma(W)=\gamma(Y)+\gamma(X)+\gamma(B')-2\gamma(B).}
                                                               \tag{119.1}
\]

Each of gamma(Y), gamma(X), and gamma(B') is at least gamma(B).

#### Proof

The cover W/B is Galois with group (C_2)^2, and its three intermediate
double quotients are Y, X and B'. Since 2 is invertible in characteristic
p, the character idempotents decompose the Jacobian up to isogeny as

\[
 J(W)\times J(B)^2\ \sim\ J(Y)\times J(X)\times J(B').
                                                               \tag{119.2}
\]

For completeness, the trivial character factor is J(B). Each of the
three nontrivial character factors appears in exactly one intermediate
Jacobian, together with that same trivial factor. Adding these three
decompositions gives (119.2). The projector denominators are powers of
two, but p-rank is in any case invariant under isogeny and additive on
products. Taking p-ranks proves (119.1).

For any of the three double maps to B, norm composed with pullback on
Jacobians is multiplication by two. Thus J(B) is an isogeny factor of
the source Jacobian, proving the three monotonicity statements. QED.

## 3. A sufficient criterion for failure of unrestricted descent

### Theorem 119.3

Assume that:

1. gamma(B) = s > 0;
2. gamma(B') = gamma(X) = s;
3. Tan(Y) is nonempty and tau fixes no element of Tan(Y).

Then

\[
 \operatorname{Tan}(X)=\varnothing,
 \qquad \operatorname{Tan}(W)\ne\varnothing.
                                                               \tag{119.3}
\]

Consequently the actual etale double cover r:W -> X acquires a maximal
Tango structure that does not descend to X. The two original curves
X and Y nevertheless have the common finite etale cover W.

#### Proof

Put t=gamma(Y), which is positive by Lemma 119.2. Formula (119.1)
and hypotheses 1--2 give gamma(W)=t. Therefore the audited theorem in
file 115 applies to q:W -> Y and supplies a bijection

\[
 q^*:\operatorname{Tan}(Y)\xrightarrow{\sim}
                         \operatorname{Tan}(W).       \tag{119.4}
\]

Let sigma=(tau,epsilon), the deck involution of r. The identity
q sigma = tau q implies

\[
 \sigma^*q^*L=q^*\tau^*L
\]

as embedded Tango structures. Since (119.4) is a bijection, hypothesis
3 says that sigma fixes no Tango structure on W.

Any Tango structure on X would pull back along r to a sigma-invariant
one on W. This is impossible. Thus Tan(X) is empty. On the other hand,
pulling back any Tango structure on Y shows that Tan(W) is nonempty.
This proves (119.3) and all remaining assertions. QED.

The hypothesis gamma(X)=gamma(B')=gamma(B) is equivalent here to
gamma(W)=gamma(Y), by (119.1) and the three monotonicity statements.
This is a concrete, checkable condition on two double covers, not an
assumption about an unspecified Galois closure.

## 4. The finite characteristic-five test now available

The auxiliary Hoshi curve and the reflection certificate give

\[
 g(Y)=6,\quad\gamma(Y)=4,\quad
 g(B)=2,\quad\gamma(B)=1.
\]

There are exactly ten Tango structures on Y, and its reflection tau
acts on them as five transpositions. Thus hypothesis 3 is verified
for this auxiliary Y; it is not asserted for the fixed pair in file 76.

The exact quotient is

\[
 B:\quad v^2=F(t)=2t^6+2t^4+3t^2+4,
\]

and Y/B has a quadratic presentation

\[
 h^2=A(t)+(t^2+4)v,\qquad A(t)=2t^8+4t^6+2.
\]

These equations were obtained and checked in the original function
field by `/root/canonical_trace_algebra`; see the accompanying Hoshi
reflection and quotient certificates when investigating the example.
The six roots of F are distinct and all lie in F_25, since

\[
 F=2(t^2+2)(t^2+2t+4)(t^2+3t+4).
\]

The fifteen nonzero geometric two-torsion classes of J(B) correspond
to unordered pairs of these roots. For a pair {a,b}, a representative
unramified double cover is obtained by adjoining

\[
 \sqrt{(t-a)(t-b)}.
\]

Its quadratic twist X is given by

\[
 h_X^2=(t-a)(t-b)\bigl(A(t)+(t^2+4)v\bigr)
\]

over B, followed by smooth normalization.

For each pair, the p-rank of B' is especially cheap to check: its
elliptic Prym is the double cover of P^1 branched at the other four
roots. Hence gamma(B')=1 exactly when this elliptic curve is
supersingular. Only pairs passing that test need the more expensive
genus-six calculation gamma(X)=1.

**Open test:** find such a pair, or certify that none of these fifteen
twists meets both rank conditions. Until then this section supplies
no example satisfying Theorem 119.3. No older theorem is contradicted.
