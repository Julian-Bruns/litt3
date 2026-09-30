# All common quartic/quintic leading exceptions are excluded

30 September2026.
[Statement](../../Theorems/cartier_and_spin/root9_actual_monic_five_charts.md).
Use the exact divided traces and parameter definitions in
[their construction](root9_actual_divided_traces.md).

The coefficient export gives the quartic leading numerator N4 of
bidegree(15,37) and the quintic leading numerator N5 of bidegree(12,32).
The denominators are products of original units. With
\[
d(q)=(47171,357608),\qquad \sigma_0=\langle112400\rangle,
\]
the exact polynomial identity is
\[
N_5=c\prod_{k=1}^4\Phi_k,\qquad
\Phi_k=\Psi-k\sigma_0 d(q)H^3q^2,\quad c\ne0.
\]
This also has a short geometric explanation: both infinity poles of
Lambda have order four. The leading coefficient of the x-multiplied
trace is the signed difference of the inverse fourth powers of their
leading values. Their ratio is s/sigma0. Thus its zero condition is
s^4=sigma0^4. The polynomial identity retains the normalization.

The already completed
[six-curve exclusion](degree140_root9_six_scale_curves.md)
removes Phi1=0 and Phi4=0. On each of Phi2=0 and Phi3=0, compute the
fixed-polynomial resultant Res_H(Phi_k,N4). It has degree171 in q.
Removing only q, the original linear denominator and the two original
excluded q-fibres leaves degree129, with factors as follows:

| k | Irreducible q-factor degrees and multiplicities |
| --- | --- |
| 2 | (1,10),(7,1),(7,10),(42,1) |
| 3 | (1,10),(2,1),(7,10),(19,1),(28,1) |

Every listed factor is retained in its complete residue field. In
each field, compute the full H-gcd of Phi_k and N4, and remove only
its factors in H*Psi*(H-<42135>). The last factor is the already
excluded marked-content line. The degree-one and multiplicity-ten
degree-seven q-factors have no allowed H. The remaining H-gcd is
linear in every field. Thus the two allowed geometric supports have
degrees7+42=49 and2+19+28=49.

At every remaining H-value specialize the THREE ACTUAL trace
polynomials U_(0,0),U_(1,0),U_(2,0), keeping the scale indeterminate.
The saved extended-gcd identity gives a polynomial combination equal
to one in every complete residue field. These are all-scale
exclusions; none uses a bounded scan of scale values. Together with
the two previously excluded curves, they rule out every common leading
degeneration. The two stated monic charts therefore cover the actual
locus. No assertion of finiteness after inverting the scale is needed.

The [projection source](../../scripts/arithmetic/root9_actual_leading_geometry_20260930.sage)
retains the polynomial factor identity, full resultants, removed
original q-units and irreducible factors. A JSON serialization error
after the mathematics completed was repaired using the already saved
exact object; no result was lost or inferred from the failed write.
The [complete-field lifting source](../../scripts/arithmetic/root9_actual_leading_fibres_20260930.sage)
retains each full H-gcd, actual scale equations and Bezout identity.
Its first implementation repeatedly exponentiated q-field elements.
Replacing that with univariate remainder arithmetic made the remaining
six fibres finish in28 seconds on one core, with completed fibres
resumed rather than recalculated.

Exact evidence is in the
[root-nine trace directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/root9_traces/):
`actual_leading_geometry.sobj`, `actual_leading_geometry.json`,
`actual_leading_fibres.json` and the nine `actual_leading_fibre_*`
objects. The final receipt records complete exclusion.
