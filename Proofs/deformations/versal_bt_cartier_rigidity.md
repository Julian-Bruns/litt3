# Proof: the difference is a regular Cartier-killed eigenform

[Statement](../../Theorems/deformations/versal_bt_cartier_rigidity.md).
Use the [sharp local pole bound](versal_bt_unitroot_ramification.md)
and [valuative comparison](versal_bt_valuative_comparison.md).

## The logarithmic character cover

On the ordinary open, the two constituents of $H$ have characters
$\chi$ and $\delta\chi^{-1}$, with values in $\mathbf F_5^*$;
$\delta$ is the determinant character and extends across $C$.
Kummer changes of constituent basis multiply $d\log q_H$ by
$\chi^2\delta^{-1}$. Use the connected cover corresponding to this
character. Its degree divides four. At a simple supersingular point,
the level-one Igusa character $\chi$ has inertia of order four;
the logarithmic character has inertia of order two.

Here is the local differential calculation, retaining the actual
crystal. In a paired frame, write
$F_0=(\begin{smallmatrix}t&0\\1&0\end{smallmatrix})$, and let
$b=C_{12}$ be the unit Kodaira--Spencer coefficient. On the Igusa
cover take $\beta^4=t^{-1}$; the ordinary frame has vectors
$\beta(1,t^{-1})$ and $\beta^{-1}(0,1)$. Its logarithmic form is
$\beta^{-2}b\,dt$. On the character double at this point, put
$t=s^2$. The form becomes a unit times $s^2ds$. It has zero order
exactly two. Away from $S$ it has no zeros by versality. Thus the
projective normalization $P$ has $\operatorname{div}\Omega=2R$.
Nontrivial determinant characters are retained in the possibly
degree-four cover; they are not silently trivialized on $C$.

The form is Cartier-fixed because it is locally logarithmic on an
ordinary constituent-splitting cover. Cartier commutes with separable
pullback, so this identity descends to $P$.

## The Cartier equation for an actual difference

Over a further separable extension, write $q_B=q_A r^5$ and
$c=d\log r/d\log q_A$. Both $\Omega$ and $c\Omega$ are logarithmic.
The projection rule for Cartier gives
\[
C_P\bigl((c^5-c)\Omega\bigr)
=cC_P(\Omega)-C_P(c\Omega)=c\Omega-c\Omega=0.
\tag{3}
\]
This is an equality of rational forms, verified after a faithfully
separable pullback and hence before it. The intrinsic function is
$\Delta=c^5-c$. Its pole orders on $C$ are at most one. At a
ramification point of $P$, multiplying by $\Omega$ cancels the
possible order-two pullback pole. Consequently $\pi^*\Delta\Omega$
is a REGULAR Cartier-killed form on the proper curve $P$.

Conversely, a rational form in the same character block is uniquely
$\pi^*r\Omega$. At ramification, its regularity is equivalent to
$v_s(r)\ge-1$; elsewhere it is equivalent to regularity of $r$.
Thus multiplication identifies $H^0(\mathcal O_C(S))$ with the whole
character block. The bound and valuative theorem make (1) injective.
This argument alone does not reverse the actual-group construction.
The subsequent [realization proof](versal_bt_cartier_realization.md)
does so by effective local windows and global Hopf-algebra patching.

## Identification with indigenous ordinariness

The actual Dieudonne connection, its Hodge line, and the
Kodaira--Spencer isomorphism form a projective oper. Its p-curvature
is nilpotent: Frobenius and Verschiebung identify its two generic
graded lines with Cartier-flat lines. It is nonzero generically,
since the ordinary Kummer logarithmic differential is nonzero and
Cartier-fixed. The local calculation above identifies its square
Hasse tensor, up to the fixed nonzero normalization, with
$-\Omega^4$. This descends to $\omega_C^4$ and has divisor $2S$.
In computing that divisor, remember the ramification contribution
in $\pi^*\omega_C\to\omega_P$: $\Omega^4$ has divisor $8R$,
whereas pulled-back base tensors contribute $4R$. Thus it gives
$2S$, not $4S$, on $C$. The oper is admissible.

The established
[Hasse--Cartier criterion](../projective_connections/hasse_cartier_criterion.md)
identifies indigenous ordinariness with injectivity on the inverse
character block. Its polarized de Rham argument proves equality of
the two inverse-character Cartier kernel dimensions. Therefore the
kernel in (1) has precisely the indigenous tangent dimension.
This handles degree two and degree four together.

If the connection is ordinary, (3) forces $\Delta=0$. Valuative
comparison then gives the actual marked normalized isomorphism on
the whole curve. No cover-degree averaging, new endpoint cover, or
connection-to-group effectivity assertion is used at this step.

For higher levels, a difference between two extensions of a fixed
BT$_N$ is measured by $q_B=q_A r^{5^N}$. Dividing the last connection
digit still gives $d\log r$. The last-digit pole bound, equation (3),
and all-level valuative comparison are unchanged. The comparison on
the ordinary locus is an actual Kummer-group comparison; scalar
determinant correction preserves the specified BT$_N$ marking.

## The two endpoints and the remaining source obstruction

The [genus-two active classification](../projective_connections/genus_two_active_critical_quartics.md)
has already proved ordinariness of all85 active connections for the
two parameter conditions in the statement. It is a theorem about
the entire geometric locus, not just rational points. Reusing it
proves endpoint rigidity for every actual $H$ in the stated class.

The local exploration independently tested the logarithmic cubic
equations in all16 root classes on the backup. Its
[untwisted](../../../litt3-computation-data/bt_valuative_pole_20260920/spectral_backup.json)
and [twisted](../../../litt3-computation-data/bt_valuative_pole_20260920/twisted_spectral_probe.json)
outputs are supporting experiments, not a replacement for the
already-established all-class theorem. No new BT1 existence or
geometric census is inferred from those experiments.

For the actual span, the [extension quotient](versal_bt2_extension_quotient.md)
identifies the choice obstruction with $Q_Z/(f^*Q_X+g^*Q_Y)$.
Injectivity and etale functoriality of (1) identify its image with
(2). Thus its vanishing is exactly the compatible-choice condition.
Ordinariness on $Y$ does not imply ordinariness of its etale pullback
to $Z$; the existing section-growth examples explicitly prevent that
shortcut. The nonordinary source is the remaining issue.
