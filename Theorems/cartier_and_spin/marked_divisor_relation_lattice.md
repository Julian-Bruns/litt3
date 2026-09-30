# Exact marked-divisor relations and sharp invariant-function thresholds

Version2,29 September2026 (principal ideal and independent index proof).
Over k=algebraic closure of F5 use
F25=F5(beta), beta^2=beta+3, with [a+5b]=a+b beta. On the fixed
smooth proper curve X:y^3=P(x), put
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad A=(1,21,14,22,13),
\]
with ascending coefficients, and let O be the unique infinity.
Choose alpha with alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0,
choose rho^3=P(alpha), and write
\[
R_j=(alpha^{25^j},rho^{25^j}),\quad0\le j<12,\quad
Z=\{R_0,\ldots,R_{11}\},\quad\kappa=[R_0-O].
\]
The three points R_i,R_(i+4),R_(i+8) constitute the fibre over
alpha^(25^i). Write pi for coefficient25-Frobenius on J(X), and
Q(T)=T^8+T^4+1.

The marked subgroup Gamma=Z[pi]kappa has exponent
\[
m=276374206047011127348607572648116305293946023
 =3\cdot13\cdot16907427139\cdot22797284179
                 \cdot18385365305430963493897.
\]
As a finite abelian group,
\[
\Gamma\simeq (\mathbf Z/3)^2\oplus\mathbf Z/39\oplus\mathbf Z/m.
\]
In particular |Gamma|=351m=97007346322500905699361257999488823158175054073.

Its FULL relation lattice I in Z[T]/Q is specified by the following
necessary and sufficient congruences on H=sum_(i=0)^3(a_iT^i+b_iT^(i+4)):
\[
a_i+b_i=0\pmod3\quad(0\le i<4),\qquad
H=0\pmod{(13,T^2+6T+12)},
\]
\[
H(2575562790)=0\pmod{16907427139},\qquad
H(2456394558)=0\pmod{22797284179},
\]
\[
H(6084763979631986247767)=0\pmod{18385365305430963493897}.
\]
Thus these conditions decide principality of EVERY degree-zero divisor
supported on Z union{O}, with no bound on multiplicities.

There is a shorter presentation: I is the principal ideal(G), where
the ascending coefficient row of G is
\[
G=(-652173,104828,-133365,8040,4980,-494720,-65556,30252).
\]
The eight rows T^jG modulo Q,0<=j<8, are an integral basis of I.
The identity G(pi)kappa=0 has been checked directly on the actual
Jacobian. Together with actual point-order and small-primary counts,
their index proves completeness without assuming a Weil polynomial.

Two sharp consequences are:

1. Every rational function regular away from O, with zeros only in Z
   and pole order at most1,617,893, belongs to k[x]. The least pole
   order of such a function outside k[x] is exactly1,617,894.
   At that minimum there are exactly twelve possible zero divisors,
   forming one25-Frobenius orbit. Functions with the same divisor
   differ only by a nonzero constant.
2. Every rational function with divisor supported on Z union{O} and
   degree at most788,051 belongs to k(x). The least degree outside
   k(x), allowing finite poles, is exactly788,052. There are twelve
   minimizing nonzero relation vectors in I. Different representatives
   of one vector can have different complete-fibre factors; no count
   of all signed divisors or functions is asserted here.

For example the rootwise triples of an effective minimizing zero
divisor, in the order(R_i,R_(i+4),R_(i+8)), are
\[
(133365,65556,0),\quad(22212,0,30252),\quad
(0,4980,657153),\quad(599548,104828,0).
\]
Subtracting1,617,894 O gives a principal divisor. This is an exact
existence certificate by its zero Jacobian class, not an expanded
formula for the large function.

These assertions hold for arbitrary geometric coefficients. The same
pole bound applies to actual comparison norms whenever their zeros
and poles have the displayed support. In particular all comparison
poles<=1,617,893 not divisible by three are excluded. The invariant
comparison cases, including the unresolved uniform-eight case, remain.
No shared object on an unmarked common cover is produced, and no
unmarked common-cover decision follows.

[Proof](../../Proofs/cartier_and_spin/marked_divisor_relation_lattice.md),
[relation audit](../../Research/audits/MARKED_RELATION_LATTICE_2026_09_29.md),
the [primary-kernel and gauge audit](../../Research/audits/MARKED_PRIMARY_KERNEL_AND_EFFECTIVE_GAUGE_2026_09_29.md),
the [signed-gauge audit](../../Research/audits/MARKED_SIGNED_SUPPORT_GAUGE_2026_09_29.md),
and the [principal-ideal index audit](../../Research/audits/MARKED_PRINCIPAL_RELATION_IDEAL_2026_09_29.md).
