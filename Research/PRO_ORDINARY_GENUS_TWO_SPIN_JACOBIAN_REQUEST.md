# Can a reduced spin-Cartier match coexist with Jacobian orthogonality?

Please decide the precise implication (J7) below. It is a proposed
structural lemma, not a known theorem and not a request to solve the
whole common-cover problem. A proof would directly exclude the first
surviving Cartier-zero profile for our selected pair. A counterexample
must retain the actual two etale maps and every hypothesis.

## Target (J7)

Work over k=bar(F_5). Let X,Y be smooth projective connected curves,
g(X)>2, g(Y)=2, with Y ordinary. Suppose there are finite ETALE maps

    X <-f- Z -g-> Y

from the SAME smooth projective connected curve and with

    f*k(X) intersect g*k(Y)=k inside k(Z).

Let L_X,L_Y be spin lines, with specified squares L_i²=omega_i, and
fix an identification f*L_X=g*L_Y compatible with differential pullback.
Spins are allowed to be ineffective. Define

    K(C,L)=ker[H0(C,omega_C tensor L^5)
                     --relative Cartier-->
                 H0(C^(1),omega_(C^(1)) tensor L_1)].

Identify its source with H0(C,L^7). Suppose h_X in K(X,L_X) and
h_Y in K(Y,L_Y) have nonempty REDUCED zero divisors and equal pullbacks.

Is it necessarily true that

    Hom_k(J(X),J(Y)) != 0 ?                              (J7)

Equivalently, can a coreless span with these particular shared data
have geometrically isogeny-disjoint endpoint Jacobians?

Do not replace the desired nonzero abelian-variety homomorphism by a
nonzero tangent map or a common vector in a characteristic-five vector
space: those are not equivalent. Nor must a putative homomorphism be
the original push-pull f_*g^*, which might vanish even if Hom is nonzero.
In the orthogonal case BOTH rational crystalline and prime-to-five
cohomological push-pulls between these endpoint Jacobians vanish; all
identifications must concern these actual maps.

## Why this would help, and what it does not ask

Our current candidate X is a trigonal genus-nine curve whose Jacobian
is geometrically absolutely simple. Thus Hom(J(X),J(Y))=0 for EVERY
genus-two Y, without a simplicity assumption on J(Y). This arithmetic
input was not explicitly supplied in the preceding section-intersection
request. The proposed implication isolates a way to use it and remains
useful if we change the selected absolutely simple X.

The original common-cover problem also has other tensor weights and a
possible absence of shared positive tensors. Proving (J7) would settle
this weight-seven profile only. Do not claim more.

## Supplied results and boundaries; do not rederive them

1. The spaces K(C,L) have dimension4(g(C)-1). In particular the genus-two
   space has dimension4. This does NOT enumerate unknown common covers.

2. Put h=f*h_X=g*h_Y and s=h², a shared canonical tensor of weight7
   with divisor2D, D reduced. Corelessness implies that the full common
   RATIONAL canonical tensor algebra is k[s,s^(-1)]. Thus there are no
   nonzero shared rational tensors of weights1,...,6, or20; the weight7
   space is one-dimensional. For endpoint rational one-forms theta,eta,
   delta=g*eta/f*theta has exact order7 in
   (f*k(X)g*k(Y))*/(f*k(X)* g*k(Y)*).

3. The exact spin-primitive sequence is

       0 -> H0(L_1) -> H0(L^5) --nabla--> K(C,L)
                         -> H1(L_1) -> 0.

   The last boundary need not vanish, even on ordinary Y. A coreless
   matched source spin is necessarily effective. If both boundaries
   vanish, the primitive difference is the fifth power of a new source
   spin section modulo the endpoint section spaces. It need not be zero.

4. There is an UNCONDITIONAL higher-weight version. Since h^6=h^5 h,
   s³ is Cartier-zero in weight21. H1(omega^4)=0 supplies regular
   Q_X in H0(omega_X^20), Q_Y in H0(omega_Y^20) with nabla Q_i=s_i³.
   Their pulled-back difference is F_Z*R for a weight4 section on Z^(1).
   Its class modulo the two endpoint weight4 spaces is necessarily
   NONZERO. It is NOT a common weight4 tensor. Higher powers do not
   add independent constraints: primitives for s^(3+5j) may be chosen
   as s^(5j)Q_i, with mismatch exactly s_1^j[R].

5. Along an alternating one-leg Galois-closure tower, the spin spaces
   must grow strictly. This is NOT contradictory: on an ordinary genus2
   curve with an effective spin e²=eta and eta not a Cartier eigenform,
   its maximal abelian exponent5^n etale cover has group(Z/5^n)^2,
   genus5^(2n)+1, exactly5^n pulled-back spin sections, and a base-point-free
   BIRATIONAL complete spin series. These are genuine one-leg examples.
   Therefore ordinarity, many spin sections, birationality and faithful
   deck action cannot supply a one-leg exclusion.

6. If useful, use the equivalent tame-root form. The covers
   A->X and B->Y defined locally by w_i^7=h_(i,l) carry exact regular
   forms alpha_i=w_i²*pi_i*(l_i²), with div(alpha_i)=8D_i.
   Their genera are28(g(X)-1)+1 and29, and deg D_i=7(g(i)-1).
   The specified spin match gives a common source W and BOTH upper
   maps W->A,B ETALE, commuting with the same cyclic order-seven action.
   For a generator with w_i->zeta^4 w_i, alpha_i has character zeta.
   The embedded upper endpoint fields also have intersection k in this
   construction. Retain this full quotient/action data: uniform zero
   order8 and rational exactness alone have genuine coreless counterexamples.

## Counterexample tests and what would count as progress

Hom-zero endpoints CAN have actual etale common covers, including
absolutely simple endpoints in cored examples. Coreless Hom-zero spans
also exist in characteristic five without the displayed genus-two
spin-Cartier hypotheses. Neither Hom-zero nor corelessness by itself
is a contradiction. Conversely, an example with X=Y says nothing about
(J7), since its Jacobian Hom group is already nonzero.

The strict-growth argument over bar(F_5) only applies to a SINGLE
finite-dimensional subspace stable under both endpoint actions.
It cannot be applied to the union of growing section spaces.
Neither leg is assumed Galois, and no finite simultaneous Galois
closure may be assumed. No lifting of both maps is available.

Please give a proof of (J7), an actual counterexample satisfying all its
hypotheses, or a sharply stated undecided verdict with a new proved
constraint that genuinely uses Jacobian orthogonality AND the shared h.
Rephrasing the known mismatch or another one-leg dimension inequality
would not resolve the new issue. Work independently with the supplied
inputs; no access to our local files is needed.
