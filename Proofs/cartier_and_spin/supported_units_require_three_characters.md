# Proof: a three-value map and the exact marked-divisor kernel

[Statement](../../Theorems/cartier_and_spin/supported_units_require_three_characters.md).
We first prove the general reduction, then apply the later lattice.

## A least counterexample has disjoint conjugates

Let gamma have order three with quotient P1, O be totally ramified,
and Z consist of s unramified fibres. Choose a missing-character
noninvariant supported function g of least pole degree delta.
There is a fixed point other than O: a cyclic cubic quotient of
genus at least two cannot have only one tame branch point, by
Riemann--Hurwitz. At such a point g is regular and nonzero, while
a nontrivial-character regular function vanishes. Thus the invariant
component of g is nonzero. Exactly two characters are present:
\[
g=g_0+g_j,\qquad \gamma^*g_j=\zeta^j g_j,\quad j=1\text{ or }2.
\]
At an unramified orbit, vanishing on two sheets forces both
components to vanish, hence vanishing on all three. Dividing by
the corresponding base linear factor removes one complete zero
fibre and lowers the pole by three. It preserves support,
noninvariance and the two characters, contrary to minimality.
Therefore g occupies at most one sheet per fibre, and the zero
divisors of its three conjugates are pairwise disjoint.

In positive characteristic p, a pth root of g would preserve
regularity, support and noninvariance and permute its characters
since p is prime to three. Its smaller pole contradicts minimality.
Thus this least witness is not a pth power.

## The ratio is separating and has three short fibres

In characteristic zero every nonconstant ratio is separating.
In characteristic p, suppose g/gamma^*g were a pth power.
Disjointness forces every zero multiplicity of g to be divisible
by p, hence also its pole degree. Consequently dlog(g) is regular.
The pth-power ratio makes it gamma-invariant. Tame descent gives
an invariant regular differential on P1, so dlog(g)=0.
The kernel of d on the function field over this perfect field is
its pth powers. This contradicts the preceding minimality argument.

The two present characters give a constant relation
Ag+B gamma^*g+C gamma^(2*)g=0 with A,B,C all nonzero.
Set phi=-Ag/(B gamma^*g). Its degree is delta, because the
conjugate zeros are disjoint and the poles at O cancel.
Moreover 1-phi=-C gamma^(2*)g/(B gamma^*g).
Its complete fibres over0,1,infinity are precisely the three
conjugate zero divisors. If their occupied multiplicities are
m_1,...,m_t, with t<=s and sum m_i=delta, their different
contribution is at least3(delta-t). Hence
\[
2G-2+2\delta\ge3(\delta-t),\qquad
\delta\le2G-2+3t\le2G-2+3s.
\]
At a multiplicity divisible by p, each of its three ramified
points contributes at least m_i rather than m_i-1. Retaining
those three extra exponents gives the stated improvement by3w.
This argument is on the endpoint and uses no common-cover map.

## The later lattice closes the reduction in every degree

For X, G=9 and s=4, any missing-character function would therefore
give a noninvariant effective supported function of pole at most28.
The [exact marked-divisor lattice](marked_divisor_relation_lattice.md)
proves that every such function below pole1,617,894 lies in k[x].
This contradiction excludes missing characters in ALL degrees,
including functions with common polynomial factors or arbitrary
fifth powers. It is not extrapolation from a bounded classification.

The original
[ramification audit](../../Research/audits/DOUBLE_ROOT_AND_HERMITE_2026_09_27.md)
retains the fixed-curve argument. The present general reduction
has focused author review; the independently checked lattice is
the arithmetic input. Its proof does not use this theorem, so the
replacement has no cycle. All former finite Hermite sources were
already unnecessary. Three-character functions at the exact high
threshold remain; realization as a norm of both actual maps is
a separate question.
