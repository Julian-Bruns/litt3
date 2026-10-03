# Jacobian-disjoint correspondences force a basepoint-free pencil

ID: `hom_disjoint_correspondence_gonality`. Version1,2 October2026.
Focused independent argument review PASS:
[audit](../../Research/audits/HOM_DISJOINT_CORRESPONDENCE_GONALITY_AUDIT_2026_10_02.md).

Let k be algebraically closed, and let C,X,M be smooth connected projective
curves with finite nonconstant maps $h:C\to X$ and $r:C\to M$.
Put $e=\deg r$. If $\operatorname{Hom}(J_M,J_X)=0$, the effective
divisors
\[
D_m=h_*r^*[m]\qquad(m\in M(k))
\]
all belong to one degree-e complete linear system on X. Their linear
span is nonconstant and BASEPOINT FREE. In particular X has a
basepoint-free degree-e pencil, so $\operatorname{gon}(X)\le e$.
Ramification is allowed. No etale, Galois or simultaneous-closure
hypothesis is used.

If X has a UNIQUE trigonal pencil $x:X\to\mathbf P^1$ and $e=3$,
then there is an actual morphism $f:M\to\mathbf P^1$ satisfying
\[
x\circ h=f\circ r,\qquad \deg f=\deg h.
\]
For the fixed genus-nine trigonal X in characteristic five there are
no basepoint-free pencils of degrees one, two, four or five. Its
degree-three pencil is unique. Thus the corresponding degrees e of a
Jacobian-disjoint correspondence are excluded, and e=3 requires the
displayed factorization.

A smooth genus-five curve admitting a faithful $(\mathbf Z/2)^4$
action in characteristic different from two has no trigonal pencil.
Consequently, in characteristic five, if such an M is Jacobian-disjoint
from the fixed X and $\deg h=3$, then $e=3$ is excluded too.

This bounds auxiliary correspondences without replacing either of the
two actual etale maps in a common-cover problem. It does not exclude
every original source or every larger-degree correspondence.

[Proof](../../Proofs/curve_arithmetic/hom_disjoint_correspondence_gonality.md).
