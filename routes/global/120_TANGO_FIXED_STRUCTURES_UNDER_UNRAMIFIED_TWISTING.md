# Fixed Tango structures are unchanged by unramified quadratic twisting

**Status: collaborative author proof, 2026-09-05.**
Authors: `/root` and `/root/gluing_cohomology_rigidity`.
The second author independently checked the descent and affine-action
arguments. This is not yet a full independent audit of the associated
explicit curve computations.

This generalizes the sufficient criterion of file 119: the rank of the
auxiliary unramified double cover is no longer restricted. File 119 is
retained pending an audit of the more general theorem, as requested.

## 1. Construction and notation

Work over an algebraically closed field of odd characteristic p. Let
Y -> B be a ramified double cover of smooth projective connected curves,
and let B' -> B be a connected finite etale double cover. Suppose
g(B) >= 2. Form the connected smooth fiber product

\[
 W=Y\times_B B'.
\]

Write a for the involution acting on the Y-coordinate and b for the
involution acting on the B'-coordinate. Then G=<a,b> is a Klein four
group, and

\[
 W/\langle b\rangle=Y,\qquad
 W/\langle ab\rangle=X,
\]

where X is the quadratic twist of Y by B'. Both displayed quotient
maps are finite etale: b and ab are fixed-point-free. Let tau_Y and
tau_X be the residual involutions of Y/B and X/B.

As in files 111 and 115, maximal Tango structures mean embedded
Cartier-zero Frobenius roots of the canonical bundle. Equivalently,
they are regular dormant canonical connections whose horizontal
rational differential line is Cartier-zero. This formulation includes
the descent data on the structure, not just an isomorphism class of
an unspecified line bundle.

## 2. Invariant structures survive the twist exactly

### Theorem 120.1

Pullback to W and finite etale descent give canonical bijections

\[
 \boxed{
 \operatorname{Tan}(Y)^{\tau_Y}
 \ \simeq\ \operatorname{Tan}(W)^G
 \ \simeq\ \operatorname{Tan}(X)^{\tau_X}.}
                                                               \tag{120.1}
\]

There is no p-rank hypothesis.

#### Proof

A tau_Y-invariant Tango connection pulls back to a connection on W
fixed by both a and b. Conversely, a G-invariant Tango connection on W
descends through the finite etale b-quotient to a Tango connection on Y,
and its invariance under a gives tau_Y-invariance. Descent here is
ordinary faithfully flat descent for a connection on the fixed
canonical bundle, with its canonical group action. Zero p-curvature
and the Cartier-zero condition are checked after the faithfully flat
etale pullback. Thus the first pair of operations is inverse.

The same argument with the free involution ab gives the second
bijection. The residual action of G/<ab> is tau_X. No descent through
the ramified maps Y/B or X/B is being asserted. QED.

## 3. Minimal p-rank forces every canonical dormant connection to be fixed

Write gamma(C) for p-rank and

\[
 V_C=\{\beta\in H^0(C,\omega_C):\operatorname{Car}(\beta)=\beta\}.
\]

Its dimension over F_p is gamma(C).

### Lemma 120.2

Let pi:C -> B be a double cover of smooth projective curves in odd
characteristic, with involution tau. If gamma(C)=gamma(B), then tau
fixes every regular dormant connection on omega_C.

#### Proof

Pullback of regular differentials is injective for a separable map and
commutes with Cartier. Hence pi^*:V_B -> V_C is injective and, by the
rank hypothesis, bijective. Thus tau acts trivially on V_C.

If the set D(C) of regular dormant canonical connections is empty,
there is nothing to prove. Otherwise it is an affine torsor under V_C.
For any nabla in D(C), put delta=tau^*nabla-nabla. Then delta is in V_C,
so tau^*delta=delta. Applying tau twice gives

\[
 0=(\tau^*)^2\nabla-\nabla=\delta+\tau^*\delta=2\delta.
\]

Since p is odd, delta=0. Every nabla is fixed, as claimed. QED.

This argument does not assume gamma(B)>0 and does not require choosing
an invariant origin in the affine torsor.

### Corollary 120.3

In the construction of Section 1, assume

\[
 \operatorname{Tan}(Y)^{\tau_Y}=\varnothing,
 \qquad \gamma(X)=\gamma(B).
\]

Then Tan(X) is empty. If Tan(Y) is nonempty, the etale double cover
W -> X has a maximal Tango structure although X does not.

#### Proof

By Lemma 120.2 every Tango structure on X is tau_X-invariant.
Theorem 120.1 identifies such structures with an empty set. Pulling
back any Tango structure on Y proves the last assertion. QED.

## 4. Exact role in the current test

For the genus-six Hoshi curve, the reflection quotient B has genus two
and p-rank one. The ten verified Tango structures on Y are exchanged
in five pairs. Therefore every unramified quadratic twist X has no
tau_X-invariant Tango structure. In particular, any Tango structures
on such an X must come in pairs.

This observation is useful even when gamma(X)>gamma(B): it is a
consistency check on a complete geometric Tango count, and excludes
all invariant candidates at once. A p-rank-one twist would satisfy
Corollary 120.3 immediately, without the extra gamma(B')=1 condition
of file 119.

The root's scalar-only calculation of the fifteen nontrivial twists
found thirteen of p-rank five and two of p-rank three, not one.
Thus that finite test does not meet the rank hypothesis either.
Direct Tango enumeration of selected twists is a separate remaining
test, not a consequence of this theorem.
