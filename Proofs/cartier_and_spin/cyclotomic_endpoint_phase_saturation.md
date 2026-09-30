# Proof: the endpoint equation and all binary phase sums

[Statement](../../Theorems/cartier_and_spin/cyclotomic_endpoint_phase_saturation.md).
Use the phase field F5[xi] with irreducible modulus
\[
x^{14}+2x^{13}+4x^{12}+4x^{10}+4x^9+3x^8+x^7
 +3x^6+4x^5+4x^4+4x^2+2x+1.
\]
Its irreducibility and the exact order29 of xi were independently
checked in the pole18 arithmetic replay.

Split the29 phases into14 and15. Enumerate all16,384 and32,768
half-subsets, recording their exact14-coordinate sum in F5 and their
binary mask. Retain every mask with a given sum. Match opposite sums.
Every one of the2^29 subsets is represented exactly once. The only
matches are the empty subset and the full29-element subset. Reversing
the split gives the same two masks. The
[standard-library verifier](../../scripts/arithmetic/verify_mu29_binary_zero_sums.py)
and [exact output](../../../litt3-computation-data/pole18_descent_reply_20260927/local_extension/mu29_binary_zero_sums.json)
certify this complete finite statement over the algebraic closure.

Now assume zD''+2D'=0, and let d=deg D. At any root a,
\[
\sum_{b\ne a}\frac1{1-b/a}=-1.
\]
All ratios lie in mu29, and 5^7=-1 mod29. Apply the5^7 Frobenius
to this equation and add. Each pair of summands adds to one, so
d-1=-2 in F5, or d=4 mod5. The coefficient of z^(d-2) in
zD''+2D' now has the nonzero multiplier (d-1)d=2. Therefore
the coefficient of z^(d-1) in D vanishes: the distinct roots sum to
zero. Divide by a0 and apply the complete binary-sum certificate.
The subset is all mu29, proving the asserted form of D.

Conversely z^29-a0^29 is squarefree and its differentiated expression
is29*30 z^28=0, so it does satisfy the equation. The bound29 is exact
for this local polynomial test; the full-phase solution is not a
geometric realization of the original two-map problem.
