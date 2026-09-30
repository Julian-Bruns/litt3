# Actual BT2 existence fails to descend through cyclic degree five

Version1,21 September2026. Work over $k=\overline{\mathbf F}_5$.
Choose $\tau$ with $\tau^4+4\tau^3+\tau^2+4\tau+3=0$, and put
\[
C:v^2=F(u)=u(u-1)(u-2)(u-3)(u-\tau),
\]
\[
P=2u^3+(2\tau+3)u^2+(3\tau^2+3)u
 +2\tau^3+4\tau^2+4\tau+4,
\quad r=2(F'/F)^2-F''/F+P/F.
\]
Retain the canonical first periodic datum of this admissible ACTIVE
oper. Realize it by the preceding
[finite-level effectivity theorem](admissible_periodic_bt_effectivity.md),
using any compatible flat fourth-root correction. This defines an
ACTUAL everywhere-versal height-two, dimension-one BT1 $H/C$.
Its supersingular divisor is reduced. The base curve has ordinary
Jacobian; the indigenous oper has defect one.

Then:

- $H$ has NO BT2 extension on $C$, even without determinant normalization.
- For EVERY connected cyclic finite etale cover $q:D\to C$ of degree
  five, the actual group $q^*H$ DOES have a BT2 extension on $D$.
- There are exactly six such geometric covers, each of genus six.
  Its normalized marked BT2 extension classes form a nonempty torsor
  under a two-dimensional Cartier difference space.
- No finite etale cover of degree prime to five repairs the missing
  level. The smallest possible degree of an etale repair is therefore five.

All $4^4=256$ BT1 realizations of this projective oper have the same
nonexistence and repair properties; finite-character twists do not
change the projective higher-Hodge obstruction.

With the normalized higher-Witt pairing of the existing certificate,
the actual comparison class is evaluated by
\[
\langle J(e(H)),\phi\rangle
=2(4+4\tau)^{-1}
=1+3\tau+3\tau^2+\tau^3\ne0.
\]
The equality specifies the normalized comparison $J$, not an arbitrary
choice of scale on the alternating bundle pairing.

This disproves unconditional cyclic-five descent of NEXT-LEVEL
EXISTENCE for actual groups in this class. It is a ONE-MAP example.
It does not construct a second finite etale map, a common-cover
counterexample, or a full group on any of the six covering curves.
All objects descend to some finite extension of $\mathbf F_5$;
no claim that every chosen fourth root is defined over $\mathbf F_{625}$
is needed or made.

[Proof](../../Proofs/deformations/explicit_bt2_descent_failure.md).
