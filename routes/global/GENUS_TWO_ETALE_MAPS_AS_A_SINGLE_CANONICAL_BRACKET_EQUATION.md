# Genus-two etale maps as one canonical bracket equation

Date: 2026-09-05. Author: root. Status: elementary author proof using
the independently checked canonical-Poisson reconstruction theorem.
The explicit reduction below is not separately audited.

This gives an exact finite-equation test for maps to ANY genus-two
curve, from source curves of arbitrary genus and in unbounded degree.
It illustrates a general canonical-ring method, rather than resolving
one numerical covering degree. It does not assert solutions exist.

Work over an algebraically closed field of characteristic different
from two, in particular over \(\overline{\mathbf F}_5\). Let \(Y\) be
the genus-two curve with weighted canonical presentation
\[
 R(Y)=k[u,v,w]/(w^2-F_6(u,v)),\qquad
       \deg u=\deg v=1,\quad\deg w=3,                  \tag{1}
\]
where \(F_6\) is a squarefree binary sextic.
Use the Poisson sign convention of
[the canonical Poisson theorem](CANONICAL_POISSON_RINGS_RETAIN_EXACTLY_THE_ETALE_CONDITION.md).

## 1. The bracket has an explicit finite presentation

Its values on the algebra generators are
\[
 \{u,v\}=-w,\qquad
 \{u,w\}=-\tfrac12\,\partial_vF_6,\qquad
 \{v,w\}=\tfrac12\,\partial_uF_6.                       \tag{2}
\]
To verify them on \(u\ne0\), put \(x=v/u\), \(y=w/u^3\).
Then \(y^2=F_6(1,x)=h(x)\), and \(u=dx/y\) in this
canonical presentation. The first identity is the local bracket
formula. Since \(D=y\,d/dx\) is dual to \(u\), \(D(y)=h'(x)/2\).
Substitution gives the other two identities, using the polynomial
identity
\(\partial_uF_6(1,x)=6h(x)-xh'(x)\).
This remains valid if the characteristic divides six.
Equality on this dense chart proves equality in the ring.

Equivalently, these are the Jacobian Poisson bracket for
\(w^2-F_6\), multiplied by \(-1/2\), with the indicated ordering of
variables. Formula (2) preserves the defining equation.

## 2. An exact criterion on an arbitrary same source curve

**Theorem.** For a smooth projective curve \(Z\) of genus at least two,
giving a finite etale map \(g:Z\to Y\) is equivalent to giving two
linearly independent one-forms \(U,V\in H^0(Z,\omega_Z)\) such that

1. \(U,V\) have no common zero on \(Z\); and
2. the single identity
   \[
               \boxed{\ \{U,V\}^{\,2}=F_6(U,V)\ }       \tag{3}
   \]
   holds in \(H^0(Z,\omega_Z^6)\).

The equivalence uses the fixed presentation (1). The associated map
has degree \(g(Z)-1\).

**Proof.** Pull back \(u,v\) along an etale map. They are independent,
remain a base-point-free pair, and satisfy (3) by (1),(2) and
Poisson functoriality.

Conversely, put \(W=-\{U,V\}\). Linear independence implies that
\(V/U\) is nonconstant, so no nonzero homogeneous polynomial over
\(k\) in \(U,V\) vanishes. Thus \(k[u,v]\to R(Z)\) is injective,
and \(F_6(U,V)\ne0\). In particular \(W\ne0\).
Equation (3) supplies a graded homomorphism from (1) by
\[
                     u\mapsto U,\quad v\mapsto V,\quad w\mapsto W.
                                                               \tag{4}
\]
It is injective. Indeed \(F_6(u,v)\) is not a square in \(k(u,v)\)
because its distinct linear factors have odd valuations. Hence the
quadratic defining (1) is irreducible over \(k(u,v)\), and a
homomorphism taking its root into the field \(\operatorname{Frac}R(Z)\)
has no additional kernel.

The first relation (2) holds by the definition of \(W\). Apply the
bracket with \(U\) to \(W^2=F_6(U,V)\). The Leibniz rule gives
\[
 2W\{U,W\}=(\partial_vF_6)(U,V)\{U,V\}
                         =-(\partial_vF_6)(U,V)W.
 \]
Cancel the nonzero \(W\) and divide by two to obtain the second
relation (2). Bracketing with \(V\) gives the third.
Thus (4) is a graded Poisson injection. The reconstruction theorem
gives a unique separable map \(g:Z\to Y\) whose differential pullback
is (4). Since \(u,v\) generate \(\omega_Y\) everywhere, a zero of
\(dg\) would be a common zero of \(U,V\). Condition (1) therefore
forces \(g\) to be etale. Riemann--Hurwitz gives
\(\deg g=g(Z)-1\). \(\square\)

In rational coordinates, (3) says
\[
          \left(\frac{d(V/U)}{U}\right)^2
                           =F_6(1,V/U).                \tag{5}
\]
The nonzero right side prevents inseparability. The no-common-zero
condition is essential: without it the same equation describes
separable maps that may be ramified.

## 3. Explicit characteristic-five test

For \(Y:y^2=x^5-x\), choose
\[
 F_6(u,v)=uv^5-u^5v,\quad
 u=dx/y,\quad v=x\,dx/y,\quad w=y(dx/y)^3.
\]
The six branch points are distinct, including infinity. Formula (2)
becomes, in characteristic five,
\[
          \{u,v\}=-w,\qquad
          \{u,w\}=3u^5,\qquad
          \{v,w\}=3v^5.
\]
The identity map supplies a solution of (3). This is the same
genus-two test curve for which the sum of five translation graphs
has zero trace in weights zero through three but nonzero trace in
weight four; see
[the trace counterexample](CANONICAL_RING_GENERATORS_DO_NOT_DETERMINE_TRACE_REALIZATIONS.md).
The bracket algebra does not lose the products which that summed
trace forgets.

## 4. How to use the criterion without dropping a leg

If an actual finite etale map \(f:Z\to X\) is already given, finding
forms \(U,V\) satisfying (3) and the no-common-zero condition ON THAT
SAME \(Z\) is equivalent to supplying the second etale map to \(Y\).
The criterion makes no assumption on the Galois closure of \(f\).

For two genus-two endpoints with equations \(F_6,G_6\), a common cover
requires two such pairs of forms on the same source canonical ring,
one solving each bracket equation. Independent solutions on unrelated
source curves do not suffice.

The generalization mechanism is the same for other target genera:
use a finite canonical-ring presentation, its brackets on algebra
generators, and base-point-free pullback forms. Genus two packages
these into one particularly short equation; no bound on source genus
or existence theorem follows from that simplification.
