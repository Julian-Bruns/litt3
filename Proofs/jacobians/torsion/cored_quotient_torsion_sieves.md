# Proof: quotient fiber products and torsion of uniform fibers

[Statement](../../../Theorems/jacobians/torsion/cored_quotient_torsion_sieves.md).

## 1. A fiber product with disjoint stabilizers is a curve

Let F=T_1 x_S T_2. At a geometric point its stabilizer is the
intersection of conjugates of the two injectively embedded source
stabilizers in the target stabilizer. Coprimality makes this intersection
trivial. Thus F is a smooth proper algebraic curve, possibly disconnected.
It is finite étale of degree \(ab\) over \(S\), so
\[
\sum_j(g(F_j)-1)=ab\kappa/2. \tag{3}
\]

Let C,D be the coarse curves of T_1,T_2. The map F->C x D is finite
onto its image and generically identifies F with the entire reduced
coarse fiber product over the coarse curve of S. This uses effectiveness:
away from finitely many points all three orbifolds are their coarse
curves. Hence F is the normalization of a reduced curve Gamma in C x D.
The two total projection degrees of Gamma are b,a.

For the fiber classes, Hodge index gives \(\Gamma^2\le2ab\). Adjunction and
the normalization genus formula, including intersections of different
components, give
\[
\sum_j(g(F_j)-1)
=p_a(\Gamma)-1-\delta(\Gamma)
\le ab+b(c-1)+a(d-1). \tag{4}
\]
Combining (3) and (4) proves (1). No connectedness assumption or omitted
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

For \(C\to S\) write \(H\) for the pullback of a point divisor on the
coarse \(\mathbf P^1\).
The tame Riemann--Hurwitz identity in Pic(C) is
\[
K_C=-2H+\sum_i(e_i-1)D_i,\qquad e_iD_i=H.
\]

Multiplying by \(E=\operatorname{lcm}(e_i)\) gives
\[
EK_C=AH,\qquad
A=-2E+\sum_i(E-E/e_i)=Eh/N.
\]

This proves integrality of A. Positivity follows from h,N>0.
Using \(K_C\sim hO\) and \(AN=Eh\) yields \(A[H-NO]=0\).
Substituting \(e_iD_i=H\) gives the second assertion in (2). If the
indicated \(W_r\) torsion intersection
is zero, the divisor D_i is linearly equivalent to its size times O.
Below gonality the latter line bundle has only its constant section.
For size>1 its unique effective divisor is nonreduced, contrary to D_i.
