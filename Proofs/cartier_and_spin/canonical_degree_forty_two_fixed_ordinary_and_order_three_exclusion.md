# Proof: corrected next norm gate and the sole remaining field candidate

Version2,3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_degree_forty_two_fixed_ordinary_and_order_three_exclusion.md). [Independent whole-case review PASS](../../Research/audits/BACKUP42_WHOLE_REPAIRED_EXCLUSION_AUDIT_2026_10_03.md). The withdrawn Version1 argument is retained only as [external provenance](../../../litt3-computation-data/oct03_backup42_differential_shape/failed_fixed_ordinary_v1/proof.md).

Retain BOTH actual finite étale maps, and all actual hypotheses of the [differential-shape reduction](canonical_degree_forty_two_differential_shape_reduction.md). Normalize its noninvariant F as
\[
F=U+ay,\quad U=w^3+bw^2+dw+e,\quad a^2=4q,
\quad d=4b/q^3,\quad e=q^{-1}+3bq^{-2}.
\]
The fixed centered equation is y²=Φ=w⁵+qw⁴−w−q. Put ∂=d/σ,D=∂F,g=βc²G,h=βc³H,τ=αβ²c⁶. The actual shape is
\[
g=D^2+F\partial D-F^2(3qw^2+ay),\qquad
h=\partial(Fg),\qquad h^2=g^3+\tau F^7.
\]
Here b,q,τ are nonzero. The exact primitive leading coefficient gives τ=4q³/b. With x=b/q,Q=q⁻⁴, the valid highest norm coefficient therefore imposes
\[
B(x,Q):=x(1-Q)[3x^4-(1+3Q)x^3-x^2+4]-4=0.
\]

The originally proposed next odd coefficient does NOT constrain x. For completeness, the corrected even w⁸ coefficient R of Fg is
\[
R=3d^2+3be+2b^2d+2q^2d
 +2qb^3+4bq^3+3b^2q^2+4q^4-4.
\]
Its corresponding bracket is q(4e+2qd)−4, identically zero at the displayed fixed d,e. The omitted q(bd+e) in Version1 is corrected; neither its quadratic nor its finite-field consequence is used.

Instead compare the even w¹⁸ coefficient of the ORIGINAL norm h²−g³−τF⁷, using first τ=t²−L³ from its highest coefficient. Direct multiplication after the fixed d,e substitutions gives q⁵A(x,Q), where
\[
A(x,Q)=1+3x+4x^2+2x^3+x^4
+Q(2-x-2x^2+2x^3-2x^4)
+Q^2(-2x+x^2-2x^3+x^4)+Q^3x^4.
\]
Thus A=0 is necessary. The [fresh Laurent source](../../scripts/genus_two/oct03_backup42_fixed_next_norm_coefficients.py) carries out these original operations, with s=ay,s²=4qΦ and δ=a∂. It computes g=((δF)²+Fδ²F)/(4q)−F²(3qw²+s) and h²=(δ(Fg))²/(4q), so no square root or hidden normalization is introduced. Its [receipt](../../../litt3-computation-data/oct03_backup42_differential_shape/fixed_next_norm_coefficients.json) records the exact coefficient and the identically zero earlier ones. The next odd coefficients are multiples of A and are not counted as independent conditions.

We use the ACTUAL five fixed-coordinate values, rather than the erroneous Version1 degree argument. Write α³+α+1=0 and r=α+1, so r³=3r²+r+1. For P=a₀∈{0,1,2,3}, choose the F₅ fractional linear map m(z)=4+(z−4)/(z−a₀), preserving the missing branch4 and sending P to infinity. The resulting centered q is −r/(α−a₀). At the original infinity q=−r. Multiplication by another nonzero F₅ factor does not change Q=q⁻⁴. The actual values and exact polynomial gcds are

| Fixed origin | Q | gcdₓ(A(x,Q),B(x,Q)) |
|---|---|---|
| infinity | r²+4 | 1 |
| 0 | 4r²+r+3 | 1 |
| 1 | 3r²+3 | x+4r+4 |
| 2 | r²+2r+1 | 1 |
| 3 | r²+2r+3 | 1 |

The [five-origin source](../../scripts/genus_two/oct03_backup42_fixed_next_norm_bezout.py) computes in F₅[r]/(r³−3r²−r−1)[x] and verifies EACH polynomial identity Au+Bv=gcd literally. Every coefficient of these Bézout witnesses is recorded in the [receipt](../../../litt3-computation-data/oct03_backup42_differential_shape/fixed_next_norm_bezout.json). Consequently the four unit rows exclude roots over ANY algebraic extension. At origin1 every common root must be x=r+1.

It remains to test this ONE candidate in the original norm. Choose the displayed coordinate factor one, so
\[
q=-r/(r-2)=4r^2+r+2,\qquad
b=q(r+1)=2r^2+2r+1,\qquad \tau=4r.
\]
In the representation E+sO, s=ay, let δ=a∂. Evaluate the explicitly defined g and δ(Fg) at these field values. The even w¹⁶ coefficient of
\[
\frac{(\delta(Fg))^2}{4q}-g^3-4r F^7
\]
is EXACTLY 3r²+1, nonzero because r has degree THREE over F₅. The [single-candidate source](../../scripts/genus_two/oct03_backup42_fixed_last_candidate_norm.py) independently reconstructs the original differential shape and evaluates the full original norm, rather than reducing an already truncated relation. Its [receipt](../../../litt3-computation-data/oct03_backup42_differential_shape/fixed_last_candidate_norm.json) gives g,δ(Fg),τ and every nonzero residual coefficient. In particular the odd s w¹³ coefficient is also r²+2≠0. No repeated-root exclusion is being smuggled in: the displayed candidate's F norm is squarefree.

Thus the final common root of A and B fails the actual norm identity. All FIVE fixed origins are excluded for either original stated profile. The proof does not need t≠0 and would also exclude the order-two fixed branch, but that separate order-two argument is preserved rather than silently enlarging this statement. Every step concerns the same actual source, canonical primitive coefficient and original descended spin sections; no abstract curve solution or presumed common Galois closure replaces the original two maps.
