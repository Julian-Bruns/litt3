# Proof: the second arithmetic orbit and all cyclic refinements

[Statement](../../../Theorems/deformations/cyclic_descent/all_cyclic_five_fourth_obstructions.md).
21 September2026. The old rational computation and the whole-parameter
lemma are reused. Only the other arithmetic orbit is newly computed.

Let $F(u)=u(u-1)(u-2)(u-3)(u-\tau)$ and $z=u^2/v$ on $C:v^2=F(u)$.
The Frobenius matrix on $H^1(C,\mathcal O_C)$ in the basis
$z^{-3},z^{-1}$ is
\[
M=\begin{pmatrix}
4\tau^2+\tau+2&3\tau+3\\
\tau^3+3\tau^2+3&4\tau^2+1
\end{pmatrix}.
\]
The six projective Frobenius-fixed directions have slopes satisfying
\[
P(\lambda)=M_{01}\lambda^6-M_{11}\lambda^5
 +M_{00}\lambda-M_{10}=0.
\tag{1}
\]
The root $\lambda=\tau$ gives the
[explicit rational cover](../rational_cyclic_bt_repair.md). The four-step
matrix has one nontrivial unipotent Jordan block projectively, so
the other five roots are one $625$-Frobenius orbit. Equivalently the
factor $P(\lambda)/(\lambda-\tau)$ is irreducible of degree five.

Put $\chi=M_{00}+M_{01}\lambda^5$ and
$c=z^{-3}+\lambda z^{-1}$. Divide
\[
F^7+\lambda^5F^2u^{20}-\chi Fu^{24}-\chi\lambda u^{28}
\]
by $u^{30}$ and denote its polynomial quotient by $A_\lambda(u)$.
The remainder has degree27. Thus the actual affine equation
\[
w_U^5-\chi w_U=vA_\lambda(u),\qquad w_O=w_U-c
\tag{2}
\]
has a regular infinity equation, with remainder of valuation one.
Both derivatives in the cover coordinate equal $-\chi\ne0$.
The nonzero class $[c]$ proves geometric connectedness after scaling
to the constant Artin--Schreier equation. These are actual etale
genus-six covers, not just classes in a cohomology group.

The [primary computation](../../../scripts/deformations/cyclic/probe_rational_repair_hodge.sage)
uses the 15 classes $z^e w_U^j\eta^{-1}$, with $e=-3,-1,1$ and
$0\le j\le4$. It retains the term $\chi w_U$ in the Frobenius
equation and all infinity coboundaries. Its actual Hodge matrix has
rank13, its cokernel is the length-two indecomposable cyclic module,
and the pulled base obstruction lies in its image. The geometric
deck action is checked after adjoining a fourth root of $\chi$.
The two-dimensional primary solution space has no cyclic fixed point.

For the remaining orbit, all coefficients are represented in the
field of degree20 over $\mathbf F_5$ with modulus
\[
x^{20}+4x^{10}+3x^9+2x^8+3x^6+4x^3+x+2.
\]
The exact coefficient array is also included in the primary receipt.
The embedded
$\tau$ and the chosen root $\lambda$ are retained separately.
The integral coefficient ring is its unramified lift modulo625.
Its Frobenius is computed by Hensel lifting the fifth-power image of
the generator, not by taking fifth powers of Witt coefficients.

The integral engine is an adaptation of the previously audited
[rational-orbit calculation](cyclic_five_fourth_obstruction.md).
It retains the original nonsplit periodicity line, the original
marked second curve, the full corrected third Hodge frames, the
divided Taylor terms through order125, and the geometric cover (2).
There is one necessary field-coordinate correction. Coefficientwise
lifting in the new degree20 basis changes the smooth third reference.
The engine computes its actual base normal vector $\rho^{\rm act}$,
checks that its pairing is still $1/\mu$, and solves
\[
\Psi_C(\xi_{\rm adj})=\rho^{\rm act}-\rho^{\rm old}.
\tag{3}
\]
The fifth root in this semilinear equation is taken in the full
degree20 field. Adding its pullback to the old primary solution makes
the complete 15-coordinate primary error zero. This changes the
choice of third reference; it does not change the original second
tuple or discard an obstruction. The actual reference, adjustment,
and corrected primary solution are recorded and independently checked.

The resulting fourth normal cochain is
$\rho_4=z(\Gamma_3)_{12}/25\bmod5$. It is contracted with
\[
\Lambda_C\operatorname{Tr}_q,
\qquad \Lambda_C=(3\tau^2+\tau+1,3\tau+4,3).
\]
Trace kills cover degrees below four and sends $w_U^4$ to $-\chi$.
The same scalar is checked from the unreduced residue and from the
Riccati expression, including the divided carry, mixed repairs, and
repair product. In the basis $1,\lambda,\ldots,\lambda^4$ the answer is
\[
\begin{aligned}
E={}&(1+3\tau+3\tau^3)+(3+3\tau^3)\lambda\\
&+(4+3\tau+\tau^2+2\tau^3)\lambda^2\\
&+(3+4\tau+4\tau^2+3\tau^3)\lambda^3\\
&+(2+\tau+\tau^2+2\tau^3)\lambda^4.
\end{aligned}
\tag{4}
\]
An independent Sage field calculation contracts the entire computed
cohomology vector, checks (3), verifies the Frobenius field degree,
and proves
\[
\prod_{j=0}^4 E^{625^j}=4+2\tau+2\tau^2+4\tau^3=3/\mu.
\tag{5}
\]
In particular every conjugate is nonzero.

The [secondary-trace constancy theorem](cyclic_five_secondary_trace.md)
applies to this actual cover: the base defect is one and source
defect two, so its Smith factors are units and $e^2$. It proves
that (4) is unchanged on the ENTIRE primary affine plane. The
numerical calculation at one actual repair therefore excludes all
fourth repairs, over the algebraic closure. Frobenius conjugacy covers
the five nonrational classes; the previously audited rational case
covers the sixth.

Every cyclic $5^a$ source has defect two by the
[abelian defect theorem](../abelian_covers/abelian_p_defect_node.md).
Beyond the first cover each cyclic-five step is defect-neutral.
Its obstruction pullback vanishes, yielding one extra upper digit;
the [neutral two-digit descent theorem](../neutral_galois_witt_descent.md)
forces any further upper digit to descend the preceding GIVEN digit.
The same induction as in the rational case gives exact height $a+2$
for every cyclic tower, independent of its first quotient.

The [all-height dictionary](../all_height_bt_hodge_dictionary.md)
identifies compatible Witt length \(a+2\) with actual BT level
\(a+1\) for the same pulled-back first marking, and excludes the next
level. The normalized and finite-character variants, including the
degree-five BT2 fiber, are detailed in the
[supporting height argument](../cyclic_bt_exact_heights.md).

## Reproduction and scope of checks

Sources and commands are recorded in the
[engine README](../../../scripts/deformations/cyclic/repair_orbits/README.md).
The primary input is
[nonrational_repair_hodge.json](../../../../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_repair_hodge.json).
The integral receipts are
[precision1200](../../../../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1200_v2.json)
and [changed Frobenius, precision1500](../../../../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1500_variant1.json).
The [independent field receipt](../../../../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_independent_check.json)
records (3)--(5), source hashes and comparison of the runs.

The new computation is author-checked, not a fresh independent audit
of the integral engine. The old geometric engine and the full-plane
constancy mechanism were independently audited. The Sage check is
independent finite-field arithmetic, not a second mixed-characteristic
Laurent implementation. No assertion concerns other oper classes,
noncyclic covers, or either original unmarked common-cover candidate.
