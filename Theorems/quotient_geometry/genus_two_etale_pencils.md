# Genus-two étale quotients from one canonical-pencil identity

## Statement

Version 1. Let k be algebraically closed of characteristic different
from 2. Let H(A,B) be a squarefree homogeneous binary sextic, and let Y
be the smooth projective genus-two curve with affine equation

    y² = H(1,x).

Fix the ordered canonical basis eta0=dx/y, eta1=x dx/y. For regular
one-forms a=A(z)dz and b=B(z)dz on a smooth curve, set

    {a,b} = (B A' - A B')(dz)³.

This definition is independent of the local parameter. Let C be a
smooth projective connected curve of genus at least two. There is a
bijection between actual finite étale morphisms q:C→Y and ordered pairs
a,b in H0(C,omega_C) satisfying both conditions:

1. a and b have no common zero;
2. {a,b}² = H(a,b), as sections of omega_C^6.

The map to pairs is q↦(q*eta0,q*eta1). Conversely, writing W={a,b}, the
map is recovered on function fields by

    x ↦ b/a,              y ↦ -W/a³.

The identity forces this morphism to be separable. The first condition
then forces it to be étale, including when its degree is divisible by
the characteristic. No independent degree-three generator of the
canonical ring is required. Simultaneous scaling of a valid pair by
c in k* preserves the identity exactly when c²=1; changing both signs
composes the quotient with the hyperelliptic involution.

## Exact formulation retaining both legs

Fix also a smooth projective connected curve X of genus at least two.
An actual span X←C→Y with both maps finite étale exists if and only if
there are:

- a finite locally free étale O_X-algebra A of positive rank whose
  relative spectrum is connected;
- sections a,b in H0(X,omega_X tensor A) for which the A-module map
  A²→omega_X tensor A, (s,t)↦sa+tb, is surjective;
- the identity {a,b}²=H(a,b) in H0(X,omega_X^6 tensor A).

In this formulation the bracket is calculated using the unique
extensions of local derivations of O_X to A. It is the actual bracket
on C=Spec_X A. The rank n of A is the degree of the first map, and the
constructed second map has degree n(g(X)-1).

For the project's genus-two family the sextic is

    H(A,B)=A B(B-A)(B-2A)(B-3A)(B-tA),

with t distinct from 0,1,2,3. Thus the same exact formulation applies
to the main and backup endpoints. It remains an existence problem
over étale algebras of unbounded rank: the identity alone neither
forces a clump nor excludes a common cover.

## Evidence

The two-leg formulation has no independence or canonical-ring
hypothesis. [Proof](../../Proofs/quotient_geometry/genus_two_etale_pencils.md).
