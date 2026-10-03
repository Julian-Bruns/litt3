# An exact polynomial model for the remaining triangle covers

Version2,3October2026. Work over an algebraically closed field of
characteristic zero. Let $B,C$ be monic quartics, with $C(0)=1$, and
let $s\ne0$. Put
\[
A=(2B+4xB')C-5xBC',\qquad sB(0)\operatorname{Res}(B,C)\ne0.
\]
The condition
\[
C^5+s x^2B^4=A^2F,\qquad \deg F=4
\]
is equivalent to a normalized rational map
\[
q=1+\frac{s x^2B^4}{C^5}
\]
with passport $(1^4 2^8;2^2 4^4;5^4)$, where the two points of
index two in the middle fiber are $0,\infty$. Its actual genus-two
double cover $y^2=xF$ has a complete uniform degree-forty map of
type $(2,4,5)$, with hyperelliptic deck fixed-point counts $(4,2,0)$.
Every such degree-forty map is obtained this way.

The normalized coefficient locus has exactly236 geometric points.
They represent21 cover classes with deck group of order two,
15 with deck group of order four, and4 with deck group of order
eight, with respectively8,4,2 normalizations per class.
The168 points in the first part are the remaining candidates from
the backup arithmetic reduction. The other68 have extra automorphisms.
The twelve normalized models with \(C_3=[x^3]C=0\) all have
\(B_1=B_3=C_1=0\):
their source quartics are even, so each source has an order-four
automorphism. Exact characteristic-zero point verification and the
independent permutation count establish completeness without a
finite-field or rational-ideal dimension calculation.

For computation, allow arbitrary nonzero $c_0=C(0)$ and retain
monic $B,C$. The square identity is equivalent to
\[
C(2A'F+AF')-5C'AF-sxB^3=0,\qquad
4B(0)^2F(0)=c_0^3.
\]
Its leading coefficient is $F_4=1/4$. The next four highest
coefficients determine $F_3,F_2,F_1,F_0$ successively by division
by $2,4,6,8$. This leaves an explicit polynomial system in the
eight coefficients of $B,C,s$ after either scale normalization.

This is a model and completeness result for the finite cover list.
It does not evaluate reduction at five or settle a common-cover case.

[Proof and computation](../../Proofs/curve_arithmetic/triangle245_model_space.md).
