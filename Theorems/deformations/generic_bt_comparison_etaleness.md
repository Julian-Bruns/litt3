# A generic versal-BT comparison forces the second map to be etale

Version1,21September2026. Work over an algebraically closed field k of
characteristic five. Let X,Y,T be smooth proper connected curves, with
X and Y hyperbolic. Let A/X and B/Y be actual height-two, dimension-one
BT_N groups, N>=1, whose first truncations are generically ordinary,
everywhere versal, and have reduced supersingular divisors S_X,S_Y.

Suppose a:T->X is finite etale and b:T->Y is a morphism. If there is
an ACTUAL generic group-scheme isomorphism
\[
u_\eta:(a^*A)_{k(T)}\xrightarrow{\sim}(b^*B)_{k(T)},
\tag{1}
\]
then b is finite etale, and (1) extends uniquely to an actual
group-scheme isomorphism on ALL of T. No determinant normalization,
indigenous ordinariness, full group, or supplied BT1 marking is needed.
Any markings or determinant condition already satisfied by (1) are
retained by its extension.

The second map is not even assumed separable: the nonzero
Kodaira--Spencer map first forces that property. The isomorphism in (1)
must be an actual finite-group isomorphism, not just an F,V comparison
omitting the connection.

## The divisor identity behind the assertion

An actual BT1 H as above has the intrinsic regular quartic tensor
\[
s_H\in H^0(C,\omega_C^4),\qquad \operatorname{div}(s_H)=2S_C.
\tag{2}
\]
It is the fourth power, with the established fixed normalization, of
the logarithmic character differential. Fourth powers remove every
constituent-basis ambiguity in F_5^*. Generic isomorphisms preserve it.

More generally, if a and b are finite separable and their pulled-back
BT1 groups are generically isomorphic, their different divisors satisfy
\[
\boxed{a^*S_X+2\operatorname{Diff}(a)
       =b^*S_Y+2\operatorname{Diff}(b).}
\tag{3}
\]
This is an equality of ACTUAL effective divisors on the same T; it is
not an equality of degrees. If a is etale, every coefficient on the
left is at most one. A ramified b would contribute at least two on
the right. Thus b is etale, with a^*S_X=b^*S_Y.

The elementary tensor assertion is independent of BT theory: for
nonzero regular r-differentials whose zero multiplicities are all
strictly less than r, equality of their pullbacks and etaleness of
one map force etaleness of the other. Here r=4 and the multiplicities
are zero or two.

This gives a one-sided formulation of the marked problem: a generic
matching point for H_Y over the maximal unramified function-field
extension of X already yields an actual common finite etale cover.
It does NOT produce that point or the initial common BT1. The Artin
approximation construction still need not have even one globally
etale projection. Both unmarked common-cover candidates remain open.

[Proof](../../Proofs/deformations/generic_bt_comparison_etaleness.md).
