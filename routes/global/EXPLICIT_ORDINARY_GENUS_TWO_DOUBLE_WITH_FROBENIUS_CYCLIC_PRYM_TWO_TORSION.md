# An ordinary genus-two double with Frobenius-cyclic Prym two-torsion

Date: 2026-09-05.
Authors: explicit parameter and initial calculation `/root`; geometric
verification and exact certificate `/root/gluing_cohomology_rigidity`.
Status: collaborative author proof and checked computation, not a
whole-note independent audit. No priority claim.

## Example lemma

Over \(\mathbf F_5\), put
\[
 f=t(t-1),\qquad c=t^3+t+1,\qquad
 g=(t-2)c=t^4+3t^3+t^2+4t+3.
\]
Let \(Y\) and \(E\) be the smooth projective models of
\[
                 Y:y^2=fg,\qquad E:v^2=g.
\]
Let \(U\) be the smooth projective normalization of
\[
                       u^2=f(t),\qquad v^2=g(t).
\]
Then the actual maps
\[
 a:U\longrightarrow Y,\quad (t,u,v)\longmapsto(t,uv),
 \qquad
 b:U\longrightarrow E,\quad(t,u,v)\longmapsto(t,v)
\]
have the following properties:

- \(Y\) is ordinary of genus two and \(a\) is a connected étale
  double cover; consequently \(g(U)=3\).
- The elliptic curve \(E\), with origin the rational branch point
  \((t,v)=(2,0)\), is ordinary. The map \(b\) is a ramified double
  cover and identifies \(J(E)=E\), by pullback, with the elliptic
  Prym \(P=(\ker\operatorname{Nm}_a)^0\) over \(\mathbf F_5\).
- Frobenius acts as a three-cycle on the three nonzero points of
  \(P[2]\). In particular \(P(\mathbf F_5)[2]=0\).

## Arithmetic certificate

The cubic \(c\) takes the nonzero values \(1,3,1,1,4\) on
\(\mathbf F_5\), so it is irreducible. The factors \(f\) and
\(g\) are squarefree and coprime. In particular both projective
hyperelliptic models are smooth of the stated genera.

For a hyperelliptic equation \(z^2=F(t)\) over \(\mathbf F_5\),
we use the Cartier--Manin coefficient convention
\(H_{ij}=[t^{5i-j}]F^2\). Transposing to the dual Hasse--Witt
convention does not change the determinant or ordinarity conclusion.
Here
\[
 fg=t^6+2t^5+3t^4+3t^3+4t^2+2t,
 \qquad
 H_Y=\begin{pmatrix}3&1\\3&4\end{pmatrix},\qquad\det H_Y=4.
\]
For \(E\), its Hasse invariant is \([t^4]g^2=1\).
These nonzero determinants prove ordinarity.

The quartic branch polynomial \(g\) factors with degrees \((1,3)\).
Frobenius therefore fixes one of the four branch points and cycles
the other three. The three nonzero elliptic two-torsion points are
the three unordered partitions of this branch set into two pairs;
the induced permutation is a three-cycle. This is an assertion about
the exact two-torsion representation, not merely an isogeny class.
Independently, direct point counting gives \(\#E(\mathbf F_5)=5\).

The executable
[Sage certificate](EXPLICIT_ORDINARY_GENUS_TWO_DOUBLE_WITH_FROBENIUS_CYCLIC_PRYM_TWO_TORSION_CERTIFICATE.sage)
checks all displayed polynomial, Hasse--Witt, factorization, partition,
and point-count assertions without a search.
It was run successfully with SageMath on 2026-09-05: determinant
\(4\), elliptic Hasse invariant \(1\), elliptic point count \(5\),
and the three-cycle \([1,2,0]\); every regression assertion passed.

## Actual covering geometry and Prym identification

The square classes of \(f\) and \(g\) are independent in
\(\overline{\mathbf F}_5(t)^*/\overline{\mathbf F}_5(t)^{*2}\):
their nonempty branch supports are disjoint. Thus \(U\) is
geometrically connected and is a Klein-four cover of the \(t\)-line.
Inertia at a root of \(f\) changes only the sign of \(u\), and
inertia at a root of \(g\) changes only the sign of \(v\).
Both polynomial degrees are even, so infinity is unramified.
The diagonal involution
\(\delta:(u,v)\mapsto(-u,-v)\) avoids every inertia group.
Its quotient is exactly \(Y\), proving that \(a\) is étale.

The double cover \(b\) adjoins \(\sqrt{f}\) to \(k(E)\).
It ramifies at the four geometric points of \(E\) above \(t=0,1\),
and nowhere else. Its Jacobian pullback is injective. Indeed its
kernel is killed by two and hence reduced; a nontrivial kernel line
would define an étale double of \(E\) dominated by \(U\).
Equality of degrees would identify this double with \(b\),
contradicting ramification.

The involution \(\delta\) induces the hyperelliptic involution on
\(E\), hence multiplication by \(-1\) on \(J(E)\). Therefore
\[
        (1+\delta^*)b^*=0,
        \qquad a^*\operatorname{Nm}_a b^*=0.
\]
The image of \(\operatorname{Nm}_a b^*\) lies in the finite kernel
of \(a^*\), and is zero because its domain is connected. Thus
\(b^*J(E)\subset P\). Both are one-dimensional and \(b^*\) is
injective, so this is an isomorphism over \(\mathbf F_5\).
No degree-two isogeny ambiguity is left in the Frobenius calculation.

## Exact use and boundary

This is a good **pair** \(U/Y\) for the separate theta-translate
argument: the at-most-one-exception lemma makes a possible bad
\(a^*J(Y)\)-coset a Frobenius-fixed nonzero two-torsion point of
\(J(U)/a^*J(Y)\). The quotient is isomorphic to \(P\) over
\(\mathbf F_5\), since the restriction \(P\to J(U)/a^*J(Y)\)
has kernel \(P[2]\) and factors through \([2]:P\to P\).
The three-cycle just proved excludes such an exception.

This calculation does **not** establish that all fifteen étale
doubles of this particular \(Y\) are good. Passing from one good
pair to a nonempty open of bases whose fifteen doubles are all good
is a separate moduli argument. No assertion about arbitrary
correspondence monodromy is made here.
