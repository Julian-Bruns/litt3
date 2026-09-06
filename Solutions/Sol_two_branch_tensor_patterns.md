# Proof record: Bounded tame orders and integer tensor patterns

Canonical statement: [`two_branch_tensor_patterns`](../Theorems/Thm_two_branch_tensor_patterns.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Two-branch atlases have genus-bounded tame orders and tensor patterns

Author: /root, 2026-09-06. Status: direct corollary of the audited
first-layer theorem; not separately audited. This does NOT bound the
wild group or address a coreless correspondence.

## Theorem

Fix p>=3 and h=2g(C)-2>0. Suppose C is a representable finite etale
atlas of an effective proper orbifold with coarse curve P1 and exactly
two branch points: one wild, with inertia order qt and different delta,
and one tame, with inertia order d. Assume 1<delta/(qt)<2.

There are effective bounds, depending only on p,h, for:

* the full tame complement t and the other inertia order d;
* the weight, uniform zero order, and support size of a nonzero regular
  tensor on C obtained by pulling back a rational tensor on P1.

No bound on q, upper-jump denominators, or the deeper ramification
groups is assumed. In particular, an unbounded sequence of such atlases
has a subsequence with a single fixed integer tensor pattern (d,e,u).
This means a fixed pattern, NOT a fixed tensor or divisor.

## Proof

Write c=delta-qt, t=g0*t0, d=g0*m, gcd(m,t0)=1. The checked local/genus
identities give

    c*m-q*t0=D,  D|h,  c>=q-2,  n=(h/D)*q*g0*t0*m.

Let b be the first lower break and p^r the order of its graded quotient.
The [audited first-layer theorem](Sol_wild_first_layer.md)
bounds b,r by constants B,R depending only on p,h. The tame character
on that quotient gives t | b*(p^r-1), so

    t <= T := B*(p^R-1).

Consequently g0,t0<=T. Since q>=p>=3,

    m=(q*t0+D)/c <= (q*T+h)/(q-2)
      =T+(2T+h)/(q-2) <= T+(2T+h)/(p-2) =: M.

Thus d=g0*m<=T*M. None of these bounds involves q.

Put the wild point at zero and the tame point at infinity, with
coordinate z. The rational d-differential

    beta=(dz)^d / z^(d+1)

has orders -(d+1) at zero and 1-d at infinity. Its pullback has order

    -(d+1)*qt+d*delta = d*c-qt = g0*D

at every point over zero, and order

    (1-d)*d+d*(d-1)=0

at every point over infinity. It has no zeros or poles elsewhere.
Thus the nonzero regular tensor s=pi^*beta has

    div(s)=e*E,  e=g0*D,  E reduced,
    u=deg(E)=n/(qt)=h*m/D.

In particular d<=T*M, e<=T*h, and u<=h*M. These finite integer
ranges prove the assertion. Pullback is nonzero because the coarse
map is separable. All maps and local orders refer to the actual atlas.
QED.

The same tensor may equivalently be written (dw)^d/w^(d-1) after
w=1/z, up to a nonzero scalar. This explains the alternative convention
in earlier notes.

## Geometric content and exact limitation

For any fixed pattern, O(E)^e is isomorphic to omega_C^d. Multiplication
by e on the Jacobian is finite, even when p divides e, so there are
only finitely many geometric line-bundle classes O(E) for that pattern.
But the effective divisors in one class form a projective linear
system, which may have positive dimension. Neither a finite list of
integer patterns nor a finite list of line-bundle classes proves
finiteness of atlases or supplies a fixed tensor in an unbounded family.

This isolates the remaining geometric question from unbounded local
group order. Endpoint restrictions on a bounded collection of linear
systems can now be useful uniformly in the atlas degree. The stronger
[fixed-genus-nine theorem](Sol_fixed_x_orbifold_bound.md)
already resolves the atlas bound for that particular curve.
