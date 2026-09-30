# Proof: an existing curve lift supplies enough actual truncated data

[Statement](../../Theorems/deformations/active_span_witt_bound.md).
This is a local synthesis of the accepted all-height dictionary,
forced canonical-endpoint induction, and bounded-degree descent.
No Pro request or independent audit is used.

## A single finite field for the entire normalized tower

The [ordinary-oper classification](ordinary_oper_bt_effectivity.md)
gives exactly $21760=85\cdot4^4$ geometric classes of actual
everywhere-versal height-two BT1 groups on the FIXED curve $Y_k$.
Frobenius of $\mathbf F_{q_0}$ permutes this finite set. A chosen
class therefore has a period $s\le21760$. Put $q=q_0^s$ and
choose an isomorphism from its $q$-Frobenius twist to itself.

Here invariance of an isomorphism class can legitimately be made
into descent data. Spread the BT1 and this isomorphism to some
$\mathbf F_{q^d}$. The $d$-fold composite is an automorphism
over the identity of $Y$. Generic versality makes every such
automorphism a scalar in $\mathbf F_5^\times$, of order dividing
four. After enlarging the field to $\mathbf F_{q^{4d}}$, the
$4d$-fold composite is the identity. This is an actual cyclic
descent datum; descent of its finite locally free Hopf algebra
produces the BT1 over $\mathbf F_q$. The enlargement was used
to check the cocycle, not to replace the final field $\mathbf F_q$.

Let $H/\mathbf F_q$ be this model. It determines its finite
determinant character and the Teichmuller lifts of that character.
Over $k$, every normalized marked next extension exists and is
unique by ordinary-oper effectivity and Cartier rigidity. Moreover
the isomorphism retaining the BT1 marking and normalized determinant
is unique. Thus each normalized BT$_N$ extension has a unique
Frobenius comparison lifting the given descent of $H$.

This comparison is continuous descent data: put the finite group
and the comparison over some finite extension. Its composite around
that extension is a normalized marked automorphism and hence is
the identity. Effective finite-flat descent gives the group over
$\mathbf F_q$. Uniqueness aligns all truncations, inclusions and
multiplication maps. They therefore give the full normalized group
$G/Y$ over the SAME $\mathbf F_q$. No inverse limit of growing
fields is being used.

For each class the resulting $q=q_0^s$ satisfies $q\le Q_Y$.
The formula for $N_q(d)$ is increasing in the numerical values
of $q=5^f$, $f$, and $d$. Consequently $N_q(d)\le N_{Q_Y}(d)$.
There is no need to assert that $s$ divides $21760$.

## Fix the linear first datum once

The [actual common-BT1 construction](common_admissible_bt1.md)
chooses $H_X,H_Y$ inducing the supplied common projective oper.
Its only comparison discrepancy is a flat character of order
dividing four on the ORIGINAL $Z$. Kill it by its connected
character cover $h:Z'\to Z$, of degree $c=1,2$, or $4$.
Then there is an actual comparison
\[
(fh)^*H_X\simeq(gh)^*H_Y.
\tag{3}
\]
Choose the normalized full prolongation $G/Y$ of $H_Y$ and its
finite field as above. Normalize determinant comparisons by the
Teichmuller lift of the determinant of (3). All finite characters
lift uniquely over nilpotent curve thickenings.

This fixes a linear first periodic datum on the two endpoints
and on $Z'$. Its projectivization is the initial datum in the
forced canonical-endpoint theorem. The central scalar choices
are retained here; no new theta or character cover is chosen
at later heights.

## Apply the induction to an existing curve diagram

Suppose a simultaneous $W_M$ lift of the ORIGINAL curve span
exists, with $M\ge2$. The fixed etale cover $Z'\to Z$ lifts
uniquely, so the refined span has the same $W_M$ lift.
Corelessness and the genus-two endpoint give zero joint tangent.
This remains true after refinement, by negative-H1 pullback
injectivity or the established refinement equivalence.

The [forced canonical-endpoint induction](forced_canonical_witt_endpoint.md)
now constructs matching periodic filtered data through $W_{M-1}$,
relative to these $W_M$ curves. It starts with the fixed first
datum and retains each predecessor. Its Hodge-line obstruction
is simultaneously a pullback from both endpoints, hence is zero
by the zero joint tangent. Each Hodge lift is unique since its
normal line is $T_C$ and $H^0(C,T_C)=0$.

For completeness, this projective induction lifts to the normalized
linear data just fixed. At every step the determinant and flat
periodicity characters have their specified etale lifts. A maximal
graded Higgs identification is unique projectively. Its possible
linear discrepancy on $Z'$ is a global scalar. Normalize each
endpoint identification by its determinant, choosing the square
root that reduces to its PREVIOUS scalar. These square roots exist
since two is invertible. The remaining comparison scalar has square
one and reduces to one, so it is one. Thus the actual linear divided
maps, not only their projectivizations, agree and retain the first
BT1 marking. There is no new higher character ambiguity: determinants
are fixed throughout, and any such scalar discrepancy is killed by
the same square-one argument.

The [all-height actual BT/Hodge dictionary](all_height_bt_hodge_dictionary.md)
therefore produces normalized groups $A_{M-1}/X$ and $B_{M-1}/Y$
with an ACTUAL compatible comparison on $Z'$. The indexing is
exactly this: a filtered periodic object through $W_{M-1}$,
relative to $W_M$, corresponds to BT$_{M-1}$. In particular
$M=2$ recovers (3), and $M=3$ gives a comparison of BT2 groups.

On $Y$ the normalized extension is unique at every level, so
$B_{M-1}$ is the specified $G[5^{M-1}]$, retaining its marking.
The comparison on $Z'$ is normalized as required for bounded-degree
descent. No arbitrary origins in an extension torsor are equated:
the existing curve diagram supplied the matching filtered objects.

## The degree-dependent contradiction

The refined maps have degrees $cn$ and $8cn$. If
\[
M-1\ge N_q(8c^2n^2),
\tag{4}
\]
then [bounded-degree descent](bounded_degree_bt_descent.md)
extends the actual comparison to full groups. These force a
simultaneous full lift of the refined curve span and therefore
of the ORIGINAL span. Both selected endpoint pairs exclude that
conclusion, by their arithmetic full-lift exclusions.

Thus every existing $W_M$ diagram satisfies
$M-1<N_q(8c^2n^2)$, or $M\le N_q(8c^2n^2)$.
The active branch has deformation ring $W/(5^e)$ and its universal
$W_e$ diagram exists. This proves (2). Finally $c^2\le16$ and
$q\le Q_Y$ give (1).

The numerical bound is deliberately very large. Its purpose is
to remove dependence on the hypothetical span's definition field
and on a supplied full group on $X$. Improving its size would not
address the missing common-oper or common-cover existence step.
