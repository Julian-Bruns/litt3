# Proof: quotient fiber products and torsion of uniform fibers

[Statement](../Theorems/Thm_cored_quotient_torsion_sieves.md).
The input `two_primary_w3` already contains the independent trigonal
pencil bound; it is cited, not reproved or claimed new here.

## 1. A fiber product with disjoint stabilizers is a curve

Let F=T_1 x_S T_2. At a geometric point its stabilizer is the
intersection of conjugates of the two injectively embedded source
stabilizers in the target stabilizer. Coprimality makes this intersection
trivial. Thus F is a smooth proper algebraic curve, possibly disconnected.
It is finite etale of degree ab over S, so

    sum_components(g(F_j)-1) = ab*kappa/2.              (5)

Let C,D be the coarse curves of T_1,T_2. The map F->C x D is finite
onto its image and generically identifies F with the entire reduced
coarse fiber product over the coarse curve of S. This uses effectiveness:
away from finitely many points all three orbifolds are their coarse
curves. Hence F is the normalization of a reduced curve Gamma in C x D.
The two total projection degrees of Gamma are b,a.

For the fiber classes, Hodge index gives Gamma^2<=2ab. Adjunction and
the normalization genus formula, including intersections of different
components, give

    sum_j(g(F_j)-1)
      = p_a(Gamma)-1-delta(Gamma)
      <= ab + b(c-1) + a(d-1).                        (6)

Combining (5)-(6) proves (1). No connectedness assumption or omitted
cross-component singularities enter this estimate.

Here is the descent point used in applications. If X->S is an actual
atlas and a finite group A acts on X preserving its coarse map, the
two maps obtained by each group element agree on a dense open where S
is a scheme. Since the diagonal of S is finite, their generic
isomorphism extends uniquely over the normal curve X: the finite
closure of its section has normalization X. The cocycle identities
hold by uniqueness. Thus the map descends to [X/A]->S. A stabilizer
element mapping to the identity in S would induce an automorphism of
an etale local chart over itself with identity germ, hence would be
the identity on X. The descended map is representable; finite etaleness
then descends from the atlas X->[X/A].

## 2. Multiply the tame canonical-divisor identity by its denominator

For C->S write H for the pullback of a point divisor on the coarse P1.
The tame Riemann--Hurwitz identity in Pic(C) is

    K_C = -2H + sum_i (e_i-1)D_i,
    e_i D_i = H.

Multiplying by E=lcm(e_i) gives

    E K_C = A H,
    A = -2E + sum_i(E-E/e_i) = E*h/N.

This proves integrality of A. Positivity follows from h,N>0.
Using K_C=hO and AN=Eh yields A[H-NO]=0. Substituting e_iD_i=H gives
the second assertion in (3). If the indicated W_r torsion intersection
is zero, the divisor D_i is linearly equivalent to its size times O.
Below gonality the latter line bundle has only its constant section.
For size>1 its unique effective divisor is nonreduced, contrary to D_i.

## 3. The fixed pair: the coarse common curve is rational

For a common S, its coarse curve B receives maps from X and Y.
If g(B)>0, its Jacobian injects up to isogeny into both endpoint
Jacobians. Their absolute simplicity and different dimensions9,25
make this impossible. Thus B=P1. Put N=deg(X/S). Etale Riemann--Hurwitz
gives deg(Y/S)=3N and kappa=16/N.

The audited splitting of the degree-three map x:X->P1 is (-4,-7),
so every function on X outside k(x) has degree>=7. Likewise every
function on the hyperelliptic Y outside k(t) has degree>=26: an
independent map of degree d gives a birational curve of bidegree(2,d)
in P1 x P1, of arithmetic genus d-1, at least25.

If N<7, the coarse map X->P1 factors through x, forcing3|N. Also
3N<26, so the coarse map of Y factors through t, forcing2|3N.
Only N=6 remains. The maps descend to

    T_X=P1(3,3,...,3), with eleven3's,
    T_Y=P1(2,2,...,2), with fifty-two2's.

Their degrees over S are a=2 and b=9. Their stabilizers have coprime
orders. Inequality (2) would require16/6<=2-1-2/9=7/9, a contradiction.
For N=7, the degree21 coarse map on Y still factors through its degree2
map, an immediate contradiction. All N<=7 are excluded.

## 4. Degree eight: use two-primary torsion, then the other endpoint

Suppose N=8. Every stabilizer order divides N, so S is tame in
characteristic5, with orders2,4,8. If a,b,c count these three orders,
Riemann--Hurwitz is exactly

    4a+6b+7c=32.

Its complete list of nonnegative solutions is

    (8,0,0), (5,2,0), (2,4,0),
    (3,1,2), (0,3,2), (1,0,4).                       (7)

This tiny list follows by c=0,2,4 and direct substitution; it has also
been checked with exact integer arithmetic. Here E and A=2E are
powers of two. Since K_X=16O and the audited

    W_3(X,O) intersect J(X)[2^infinity] = {0},

formula (3) forces every reduced order-four fiber D, of degree2,
to satisfy D~2O. But X has gonality3, so |2O| consists only of2O.
All signatures containing an order-four point are impossible.

The only additional row of (7) is (1,0,4). Its four order-eight
fibers have degree1; (3) makes each linearly equivalent to O.
On a positive-genus curve they would all equal O, whereas fibers at
different target points are disjoint. This is impossible too.

It remains that S=P1(2^8). The coarse map Y->P1 has degree24<26,
so is phi(t) for a rational function phi of degree12. Let D->P1 be
the double cover branched at those eight stacky values; D has genus3
and D->S is finite etale of degree2.

We verify that Y actually maps to D, rather than only sharing numerical
ramification data. Choose R(s) with odd valuations at precisely the
eight values defining S, and write Y:z^2=B(t), retaining the branch
at infinity. At a point of the t-line above a stacky value, the coarse
index of phi is1 at a hyperelliptic branch point and2 otherwise:
the composite map on Y has index2 everywhere in such a fiber.
Consequently R(phi(t)) and B(t) have exactly the same odd valuations
at ALL points of P1, including infinity. Over an algebraically closed
field a rational function with everywhere even valuation is a square.
Thus

    R(phi(t))=B(t)q(t)^2

for a rational q. The assignment s=phi(t), w=q(t)z gives an actual
separable map Y->D of degree12. Its composite with D->S is the given
atlas; alternatively Riemann--Hurwitz with genera25,3 shows directly
that this degree12 map is etale. Its pullback injects J(D) up to
isogeny into J(Y), contradicting the latter's absolute simplicity.
This excludes N=8.

## 5. Exact scope for an actual jointly minimal span

The cored-orbifold bridge supplies a common S and identifies a jointly
minimal Z with ONE component of X x_S Y. The present result therefore
excludes common-orbifold atlas degrees N<=8. It does NOT give a lower
bound on the component degree deg(Z/Y). In the group description,
G=<A,B> does not imply G=AB; these indices cannot be identified.

No assertion in this proof creates S for a coreless span. The repeated
use of Y, in Sections3--4, is essential; the argument does not replace
the second actual etale leg by only a Jacobian factor.

Dependencies: `cored_orbifold_bridge`, `fixed_pair_arithmetic`,
`two_primary_w3`. Author proof2026-09-07; no independent audit claimed.
