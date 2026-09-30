# A fixed branch-algebra correction for the companion traces

Version1,30 September2026. Retain the family, orientation, and notation of
[the endpoint-multiplied traces](degree140_endpoint_multiplier_traces.md).
Write the regular critical discriminant in the affine cubic algebra as
\[
\Delta_0=(G_3^2+2G_2G_4)/y^6
        =d_0(x)+y d_1(x)+y^2 d_2(x),
\qquad N=B_0-L_0,\qquad \gamma=3[13]^2.
\]
The letters d_i here denote discriminant coefficients, not the coefficients
of the primitive scale quadratic. For f in K[x], compute the two infinity
residues for Q_f=Tr(t^4 f v/phi) using the shorter coordinate (Z+L0)/y.
Their difference from the original-coordinate infinity sum is the constant
\[
R_f=-2\gamma\operatorname{Tr}_{K[x]/(P)}
       \bigl(f(x-\alpha)^2 N d_0d_1\bigr).
\]
There is no difference in any positive scale coefficient. Therefore the
ACTUAL companion trace equals the shorter-coordinate infinity sum, plus
the fixed rank-three endpoint correction in the preceding theorem, minus R_f.
Both corrections use fixed finite algebras. Neither requires a varying
denominator or any new restriction on the parameter chart.

For f=1,x,x^2 the companion degrees are at most13,14,14. Their coefficients,
after H=hw,q=w^3,ell=w*mu, lie in K[H^+-1,q^+-1,Psi^-1]. They vanish at
every nonzero entirely ramified actual critical fibre. This theorem adds
equations; it does not decide their simultaneous geometric zero locus.

[Proof and new implementation](../../Proofs/cartier_and_spin/degree140_companion_trace_coordinate_correction.md).
