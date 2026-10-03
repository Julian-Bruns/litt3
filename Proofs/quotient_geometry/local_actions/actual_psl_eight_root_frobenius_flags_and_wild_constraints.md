# Proof of the actual natural-root Frobenius flags

Version1, 3 October2026. Retain the exact ACTUAL curve, literal
\(\mathbf F_5\) module, central action, fourth-power comparison and
tame lift in the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_root_frobenius_flags_and_wild_constraints.md).
The component arguments were independently checked in the
[wild-value](../../../Research/notes/oct03_ten_hour/eight_module_actual_frobenius_flag_wild_obstruction_audit.md),
[scalar-frame](../../../Research/notes/oct03_ten_hour/eight_module_actual_frobenius_flag_scalar_frame_audit.md),
[saturation](../../../Research/notes/oct03_ten_hour/eight_module_actual_frobenius_flag_saturation_audit.md)
and [Moore-divisor](../../../Research/notes/oct03_ten_hour/eight_module_actual_moore_tame_exclusion_audit.md)
audits. Those reports pin their original note inputs.
The wild-value note later received only provenance and the
partition-independent base-point-free paragraph proved in both
of its audits. No computation or standalone tuple replay is used.

## Actual scalar powers and coordinate independence

The actual weak/tame Hurwitz formula gives
\[
\deg\omega_D=|Q|/10,\qquad\deg P=|Q|/40.
\]
Every point orbit on \(D\) has size at least \(|Q|/5\).
A nonzero genuine section \(\sigma\) gives a nonzero natural
intertwiner \(W^*\to H^0(D,P)\), which is injective by irreducibility.
Its eight coordinate sections are therefore \(k\)-linearly independent.
Their common base divisor is \(Q\)-invariant and has degree at most
\(\deg P<|Q|/5\), so it is empty.
The projective value is consequently defined everywhere.

The literal matrices give \(W^{[5]}=W\); the center's fifth power
also equals itself. The specified line comparison gives genuinely
\[
F_{\rm abs}^*E=E\omega,\qquad
(F_{\rm abs}^2)^*E=E\omega^6.
\]
Here SIX is \(1+5\). Thus \(\Phi_2,\Phi_3\) have the stated domains.
For a regular local \(P\)-frame \(e\), choose its fourth power as
the compatible canonical frame. Their coefficient columns really
are \(x,x^{[5]},x^{[25]}\). A frame change rescales the respective
columns by units and does not change determinant orders.
This uses absolute Frobenius on the actual stack; it does not
identify any original relative twist \(Y_1\) with \(Y\).

Divide the coordinate sections by a common rational \(P\)-frame.
Their functions \(f_1,\ldots,f_8\in k(D)\) remain \(k\)-linearly
independent, hence \(\mathbf F_5\)-linearly independent.
The Moore matrix \((f_j^{5^i})_{0\le i\le7}\) is invertible.
Indeed a singular matrix would give a nonzero linearized polynomial
of degree at most \(5^7\), with roots containing the size-\(5^8\)
rational span of these functions, an impossibility.
The first two and first three rows are therefore independent.

## Two-column saturation has no zero divisor

Let \(R_2\) be the actual saturated image on \(D\), and \(Z_2\)
its determinant zero divisor. Over a DVR the determinant order
is the sum of its Smith elementary divisors, so
\[
\deg\det R_2=-\deg\omega_D+\deg Z_2.
\]
Since \(R_2P^{-1}\) is a rank-two subbundle of
\(\mathcal O_D^8\), its determinant has degree at most zero.
The determinant inclusion has a nonzero component into one
constant summand, proving this bound without stability input.
Hence
\[
\deg Z_2\le\deg\omega_D+2\deg P
          =3|Q|/20<|Q|/5.
\]
The genuine map and unique saturation make \(Z_2\) invariant.
The orbit bound forces \(Z_2=0\).
Thus the map itself is its saturated image and its quotient is
locally free; the same holds on the stack by atlas descent.
The vectors \(x,x^{[5]}\) are independent at every point.
For \(x\ne0\), their proportionality is equivalent to all projective
coordinate ratios satisfying \(r^5=r\).
This proves the entire-row \(\mathbf F_5\)-avoidance.

## The third wild partition and the one-copy conclusion

Use the accepted exact lattices and splitting alternatives of the
[coarse-row proof](actual_psl_eight_canonical_root_coarse_rows_and_etale_geometry.md).
For wild type \(J_5\oplus J_2\oplus J_1\), it gives \(h^0(E)=1\),
and its nonzero wild evaluation lies only in the rational long
\(J_5\) socle line. Its base-point-free value would be projectively
\(\mathbf F_5\)-rational, a contradiction.
Thus this ACTUAL curve/root sector is empty.

For either two-block partition, the accepted wild evaluation is
injective into the two-dimensional rational socle plane and
\(1\le h^0(E)\le2\). If its dimension were two, choose a section
evaluating to any nonzero rational socle vector.
This again contradicts the two-column conclusion.
Therefore \(h^0(E)=1\), and the established coarse degree minus
seven and splitting alternatives give
\(\pi_*E=\mathcal O\oplus\mathcal O(-1)^7\).
Its two socle coefficients are both nonzero with ratio outside
\(\mathbf F_5\), since otherwise its projective value is rational.
Nothing changes the other-row multiplicity.

## Exact rank-three wild order and the preliminary divisor alternatives

In rational chain coordinates write
\[
x_0=a e_0+b f_0,\qquad ab\ne0,\quad a/b\notin\mathbf F_5.
\]
The accepted first-jet calculation gives
\[
x'_0=-2a e_1-2b f_1
       \pmod{\langle e_0,f_0\rangle}.
\]
It is transverse to the socle plane.
The first two Frobenius values are independent there.
Express \(x_0^{[25]}=u x_0^{[5]}+v x_0\).
Here \(v\ne0\): otherwise \((a/b)^{25}=(a/b)^5\), forcing
\(a/b\in\mathbf F_5\).
Subtract this constant combination from the third column.
Its transverse linear coefficient is \(-v x'_0\), because the
first derivatives of fifth and twenty-fifth powers vanish.
Consequently
\[
x_0\wedge x_0^{[5]}\wedge(-v x'_0)\ne0.
\]
The minimum three-minor order is EXACTLY ONE at every wild point.

For the saturated \(R_3\) and determinant divisor \(Z_3\),
the same scalar-bundle bound gives
\[
\deg\det R_3=-7\deg\omega_D+\deg Z_3,\qquad
\deg Z_3\le7\deg\omega_D+3\deg P=31|Q|/40.
\]
After the compulsory \(D_5\) contribution, the budget permits
at most one tame orbit and no unramified orbit.
Thus initially \(Z_3=D_5\) or \(D_5+D_2\).
At a tame point the value \(x\) is in one eigenspace of the
retained rational \(c\). Since \(\lambda^5=-\lambda\),
\(x^{[5]}\) is in the other eigenspace and \(x^{[25]}\) in the first.
The rank-three drop is therefore equivalent to
\(x^{[25]}\) proportional to \(x\), namely projective
\(\mathbf F_{25}\)-rationality.

## Full Moore factorization rules out the tame alternative

The full nonzero Moore determinant is a section of
\[
P^{1+5+\cdots+5^7}=P^{97656}=\omega^{24414}.
\]
Its zero divisor is invariant and has exact total degree
\[
97656|Q|/40=12207|Q|/5.
\]
Over \(\mathbf F_5\), its polynomial factors up to a nonzero
constant as the product of one linear form for each rational
hyperplane. Every such form divides it, because the corresponding
rational relation makes the Moore matrix singular.
There are \((5^8-1)/4=97656\) distinct prime linear factors,
equal to the determinant's degree, proving the identity.

At a point where the coordinates span at most two dimensions
over \(\mathbf F_5\), the rational annihilator has dimension at
least six. At least \((5^6-1)/4=3906\) factors vanish, each to
order at least one. None vanishes identically on \(D\), by
coordinate independence.
At every wild point the two rational socle coordinates have exactly
this dimension, so the wild orbit already contributes
at least \(3906|Q|/5\) zeros.

A projectively \(\mathbf F_{25}\)-rational tame value would have
coordinate span at most two, and rational matrix/scalar transport
preserves that property at all \(|Q|/2\) tame points.
The two disjoint orbits would contribute at least
\[
3906(|Q|/5+|Q|/2)=13671|Q|/5>12207|Q|/5,
\]
contradicting the total degree. Thus the tame alternative is impossible.
An unramified \(\mathbf F_{25}\)-rational value would give
\(3906|Q|\) zeros by itself and is likewise impossible.

For a tame eigenvector, the rational matrix equation \(cx=\pm\lambda x\)
makes its coordinate span stable under multiplication by
\(\lambda\), which generates \(\mathbf F_{25}\) over \(\mathbf F_5\).
Its dimension is even; dimension two is exactly projective
\(\mathbf F_{25}\)-rationality. The remaining dimensions are
four, six and eight. Moore independence on any four independent
coordinates makes the first four columns independent there.

## Genuine determinant and scope

We have proved \(Z_3=D_5\).
The accepted [two-point Picard presentation](two_point_wild_orbifold_picard_group.md)
gives genuinely \(5D_5=U\), \(2D_2=U\) and
\(\omega=-2U+8D_5+D_2\).
It follows that \(D_5=2\omega\), \(D_2=5\omega\);
this is a same-action identity, not just a degree equality.
Thus
\[
\det R_3=\omega^{-7}\mathcal O(D_5)=\omega^{-5}.
\]
The full Moore wild order is at least \(3906\); the three-minor
wild order just proved is one. They are distinct determinant divisors.

All statements require the ACTUAL curve and specified root/module
calibrations. No existence or original-source transfer is inferred.
The abstract admissible tuple and both surviving curve sectors
remain outside an exclusion claim.
BOTH actual endpoint legs remain on their SAME original source.
