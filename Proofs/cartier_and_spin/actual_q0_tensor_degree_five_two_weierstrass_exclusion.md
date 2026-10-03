# Proof: the calibrated two-Weierstrass necessary ideal is ONE

Version1,3 October2026. New whole specified-position exclusion, whole scoped review PASS. No previous arithmetic or gate is replayed. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

The [complete calibrated model](actual_q0_tensor_degree_five_calibrated_distinct_form.md) retains genus-TWO B and the elliptic common-linear-root auxiliary presentation. If BOTH distinct simple poles are Weierstrass, its exact even-pole conditions force L=λJ. Accepted strong-Sidon reflection forces λ≠ZERO. Thus write s=v−ONE,t=λ² and
\[
J=z^2+s^2z+s^4,\quad b=vz+s^2,\quad c=z+v s,\quad u=vs,
\quad H=tJ+z^2+z+1,\quad\Psi=zJH.
\]
All actual candidates have the physical open
\[
v s(s^6-1)t(t+1)(ts^4+1)\ne0.
\]
The calibrated form proves each factor: exact pole distinctness, absence of an odd-numerator common root, smoothness at the two ACTUAL Weierstrass poles, nonzero λ, and actual leading/simple-zero coefficients. No discriminant of the auxiliary degree-five Ψ is used, since it may have the elliptic double root.

Define V,W as in that form. The two exact norm numerators are
\[
M_1=V^2-4tu^2\Psi J^2,\qquad M_2=W^2-4tv^2\Psi J^2.
\]
They have degree TEN and square leading coefficients v²(t+ONE)² and4(t+ONE)². Both must be quintic squares. Choose their square roots with leading v(t+ONE) and2(t+ONE). Recursively match degrees NINE through FIVE, dividing only by these nonzero known roots. The remaining degrees FOUR through ZERO give TEN necessary equations in v,t. Clearing their denominators introduces only already-open factors v and t+ONE.

The new [source](../../scripts/genus_two/oct03_q0_degree_five_two_weierstrass_gate.py) constructs these exact polynomials over F5, asserts M=zc²−b²=(z−ONE)J, both degrees and leading coefficients, and the support of every cleared denominator. It records both recursive polynomial roots and the ten equations, then adjoins one inverse for the stated physical open and computes the basis with Sage/libSingular. The completed basis is exactly[ONE]. The [external receipt](../../../litt3-computation-data/oct03_q0_degree_five_two_weierstrass_gate/gate.json) records all these assertions' inputs, the exact open polynomial and completed result. The entire mathematical phase took0.067763 CPU seconds on one worker with a ten-CPU-second cap; no timeout or retry occurred.

Consequently no actual candidate in this entire paired-Weierstrass stratum can meet even its necessary norm-square equations. The genus-one common-root presentation was included through Ψ=h²Φ and the exact quadratic norm; it was not promoted to a smooth genus-two curve. No fixed-P cube test, arbitrary source extension or simultaneous Galois completion is used.

All original maps stay on the SAME original source. Ordinary or mixed-position simple poles and the other elliptic odd-numerator configurations are not decided here.
