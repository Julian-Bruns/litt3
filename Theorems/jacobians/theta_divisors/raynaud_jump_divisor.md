# A squarefree inherited theta cone forces a genuine jump divisor

Version2,3 October2026. The independently audited local and quartic
arguments are unchanged; the later all-defect theorem supplies and
strengthens the global determinant constraint.

Let k be algebraically closed of odd characteristic. For a smooth
projective connected curve C put B_C=F_(C/k)*O_C/O_(C^(1)),
a(C)=h0(B_C), and let Theta_(B_C) be its Raynaud theta divisor.
Keep BOTH actual finite etale maps X<-f-Z-g->Y from the same source.
Assume p does not divide deg(f) and a(Z)=a(X)+1. Set

    P=J(X^(1)) x J(Y^(1)),  H=J(X^(1)) x {O},  o=(O,O),
    N_(L,M)=f^(1)*L tensor g^(1)*M,
    delta=generic_(L,M) h0(B_Z tensor N_(L,M)).

Suppose the initial equation of Theta_(B_X) at O is nonzero and
geometrically squarefree. Then either delta=0, or delta=1 and all
the following hold in a neighborhood of o:

1. The actual universal cohomology complex splits as a zero map
   between two line bundles plus a square matrix E of size a(X).
   The kernel line has NONZERO base change at o, with image the
   f-trace-zero line in H0(B_Z).
2. The determinantal jump scheme V2={h0(B_Z tensor N)>=2} is the
   reduced Cartier divisor det(E)=0. Its intersection with H is
   Theta_(B_X), as a Cartier divisor, and it is flat over J(Y^(1))
   at o. Every local component through o dominates this Jacobian.
3. If the inherited initial equation is geometrically irreducible,
   the jump divisor has just one local component through o.

These conclusions need no Hom-zero, ordinariness, primitivity,
corelessness, genus-two or restriction on deg(g). They do not assert
that delta is positive, or that the resulting divisor is impossible.

For reference, the underlying local identity is

    theta_X = unit * s|H * alpha * [-1]^*alpha,

where s measures the divisorial torsion of the actual first
cohomology sheaf and alpha measures the vanishing of its kernel
line on H. A squarefree initial theta equation makes alpha a unit.

## The fixed genus-nine curve

For the [fixed X](../../../Definitions/fixed_pair.md) over F25,
Theta_(B_X) has multiplicity exactly4 at O and a geometrically
irreducible quartic tangent cone. An exact second-order Cech
calculation proves this; no hypothetical cover is input.

Consequently the alternatives above apply to either candidate
endpoint whenever 5 does not divide deg(f) and a(Z)=4. With the
additional Hom(JX,JY)=0 hypothesis, positive delta further forces
the jump divisor's tangent cone at o to be geometrically
irreducible of degree4. The locus V3={h0>=3} has codimension at
least3 in P at o.

For a universal kernel of ANY positive generic rank whose abelian
parameter map P->J(Z^(1)) has finite kernel, its dual determinant
line bundle is ample, by the later all-defect dimension theorem.
Under Hom-zero, that determinant dual splits as a product of ample
lines on the two endpoint Jacobians. This global constraint does
not exclude the local jump divisor.

[Proof and compact arithmetic](../../../Proofs/jacobians/theta_divisors/raynaud_jump_divisor.md).
Both unmarked common-cover problems remain unresolved.
