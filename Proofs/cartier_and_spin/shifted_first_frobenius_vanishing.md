# Proof using the actual cyclic norm, with both affine charts retained

Put E=F_abs^*K(O). Then det E=O_X(7O). The
[all-twist first-Frobenius theorem](../../Theorems/cartier_and_spin/fifth_symmetric_twist_vanishing.md)
already shows that F_abs^*K has no nonnegative-degree line. Hence E
has no positive-degree line. A nonzero map from a degree-zero line
into E must therefore be saturated of degree zero.

The fixed field is F25=F5[a]/(a^2-a-3), with ascending code n0+5n1
for n0+n1*a. The actual data are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad
c=(2,16,16,7,1,2,7,1,24,11),
\]
and K has transition(a,b)->(a-eb,b), where
e=y^2 sum_[m=1..10] [c_m]x^{-m}, with extension lines
O(-5O),O(6O). All calculations below retain this transition.

## Invariant line classes

Write gamma(x,y)=(x,zeta*y), with zeta^3=1 and zeta!=1.
The exhaustive invariant-twist reduction in the fifth symmetric
proof applies unchanged: all invariant degree-zero classes are
represented by D_s=sum s_i(R_i-O), s_i in{0,1,2}, s_10=0,
where the R_i are the ten cubic branch points. This gives19683
representatives over the full algebraic closure.

For E the extension lines are O(-24O),O(31O), and the class is
\[
e^5=yP^3x^{-50}C_5(x),\qquad
C_5(x)=\sum_{m=1}^{10}[c_m]^5x^{5(10-m)}.
\]
Use the same character bases and multiplication factors as in the
fifth symmetric proof, with these two new degrees. Every connecting
matrix has32 rows,23 columns, and rank23. Thus every invariant twist
of E has no sections. The full enumeration was executed; sixteen
independently reconstructed maps, expanded over F5, have rank184.
The second check audits the arithmetic implementation, while the
first enumeration supplies the exhaustive coverage.

Sources are
[the invariant-twist enumeration](../../scripts/arithmetic/k_first_frobenius_invariant_twists.py)
and [its independent checker](../../scripts/arithmetic/check_k_frobenius_invariant_twists.py),
both with the shift set to one. Receipts are
`k_first_frobenius_shift1_invariant_twists.json` and
`k_shift1_invariant_twists_independent.json` in
[the external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).

## A noninvariant line gives a particular norm identity

Apply the [cyclic determinant-section lemma](../../Theorems/cartier_and_spin/cyclic_determinant_section_reduction.md).
A noninvariant degree-zero line in E gives a nonzero section
s in H0(E tensor det E)=H0(F_abs^*K(8O)), with exactly seven zeros,
and a nonzero wedge satisfying
\[
s\,\gamma(s)\,\gamma^2(s)
=(s\wedge\gamma(s))G,\qquad G\in H^0(X,\operatorname{Sym}^3E).
\]
This is an identity of global sections. The wedge belongs to
(det E)^3=O(21O); its full divisor, including infinity, is retained.

The complete section space H0(F_abs^*K(8O)) has dimension seven.
Its actual Laurent matrix is25-by30 of rank23, independently of
rank46 over F5. Five basis sections have form(y*C_i,B_i), and two
have form(A_j,y^2*D_j), with all four entries polynomials in x.
The transition gives the actual linearization diag(zeta,1) on K,
and diag(zeta^2,1) on F_abs^*K. Thus these two section spaces have
characters0 and2 in the natural divisor trivializations.

Write
\[
s=p+q,\quad p=(yC,B)=\sum_{i=0}^4 b_i(yC_i,B_i),\quad
q=(A,y^2D)=\sum_{j=0}^1 d_j(A_j,y^2D_j).
\]
Its orbit product is p^3+q^3, and its wedge is a nonzero constant
times H=AB-PCD. Every one of the ten mixed wedge polynomials
has degree at most seven. Changing from the natural O(8O)
linearization to E tensor det E only multiplies the action by a
constant cubic character; it does not change the orbit product,
and its wedge constant is absorbed into G.

The rational polynomial H is gamma-invariant. Therefore G belongs
to the invariant part of H0(Sym3 E). This part has dimension seven:
the complete42-column Laurent system has rank35, independently of
rank70 over F5. In the ordinary symmetric-power coordinates its
sections are
\[
G=g_0(x)U^3+y^2g_1(x)U^2V+yg_2(x)UV^2+g_3(x)V^3.
\]
The g_i here are polynomial coefficients of a section in a fixed
seven-dimensional space, not independent arbitrary polynomials.
All sections and both chart coordinates are retained in
`k_shift1_adapted_sections.json`. Its endpoint coordinate change
has determinant[3], so it preserves the entire space.

After removing the displayed y-residues, the norm identity is exactly
\[
\begin{aligned}
PC^3+A^3&=H g_0,\\
3(C^2B+A^2D)&=H g_1,\\
3(CB^2+PAD^2)&=H g_2,\\
B^3+P^2D^3&=H g_3.
\end{aligned}
\]
If q=0, s is an eigenvector and its saturated line class is invariant,
which was already excluded. The same holds if p=0; alternatively
the displayed identity is impossible then, since H=0 and the nonzero
orbit product cannot vanish in the function-field symmetric algebra.

## Two exhaustive geometric ideals

Normalize d1=1 when d1!=0. The remaining boundary is d1=0,d0=1.
These are exhaustive because s and G may both be scaled by the
same nonzero scalar: the norm scales cubically and H quadratically.
No restriction on b, the other d-coordinate, or the seven coefficients
of G is imposed.

The four polynomial identities have109 parameter monomials:35 cubic
monomials in the five b-coordinates, four in the two d-coordinates,
and70 wedge-times-G monomials. Their coefficient matrix has rank35.
Constant invertible row reduction gives35 cubic equations in13
variables in the first chart, and35 in12 variables on the boundary.
The exact equations, variable orders, coefficients and input hashes
are retained in `k_shift1_norm_seven_chart1.json` and
`k_shift1_norm_seven_chart0.json`.

In BOTH charts the polynomial ideal is the unit ideal. The calculation
was independently completed by sparse F4 in msolve0.10.1 and by
Singular std, over F5 with the additional equation a^2-a+2. Thus it
excludes all geometric points, not just points in a bounded finite
field. Working over F5 with that irreducible constant-field equation
retains both conjugate embeddings of F25; it does not impose a
finite-field equation on any unknown geometric parameter.

The source [norm reconstruction](../../scripts/arithmetic/k_shifted_seven_zero_norm.py)
constructs the complete equations from the actual section bases.
The [F4 wrapper](../../scripts/arithmetic/k_exact_msolve_chart.py)
and [independent prime-field check](../../scripts/arithmetic/check_k_prepared_prime_ideal.py)
retain their exact inputs and outcomes. The independent
[elementary verifier](../../scripts/arithmetic/verify_k_shifted_norm_identities.py)
reconstructs all109 columns using binary-vector multiplication,
checks the row-reduced system in coded F25 arithmetic, and checks
any saved ideal-membership identity by literal F5 multiplication.
It does not call a Groebner-basis routine.

The completed independent std receipts are
`prime_std_norm_seven_chart0.json` and
`prime_std_norm_seven_chart1.json`; the F4 receipts have prefix
`msolve_shift1_norm_seven_chart`. The two retained identities for1
have2598 and261215 multiplier terms respectively. BOTH passed the
independent elementary replay, including reconstruction of the norm
matrix and every prepared prime-field equation. The replay receipts
are `norm_seven_chart0_elementary_check.json` and
`norm_seven_chart1_elementary_check.json`. Intermediate Groebner
bases are not required to verify either identity.

For example, reconstruct a chart by calling the norm source with
the seven-zero and adapted-section JSONs, `--chart 1` or `--chart 0`,
and an external `--output` path. Run either exact ideal checker on
that output. The independent std checker takes `--certificate` to
extract an explicit identity; the elementary verifier takes the two
section JSONs, prepared chart, and prime-field certificate in that
order. The actual global sections are regenerated by
[the seven-zero source](../../scripts/arithmetic/k_shifted_seven_zero_sections.py)
with `--twist 8`; its rank and both-chart tests are automatic.

This closes the noninvariant case and proves all-twist vanishing.
No conclusion about the larger discriminant-square locus is needed:
its general open chart remains undecided. The successful ideals
encode the actual norm factors, a strictly stronger condition.

## Consequence for arbitrary rank-three first returns

Let R have rank three and degree zero, with a surjection R->K and
kernel N. Then N is a line of degree minus one, necessarily
N=det R(-O). Suppose F_abs^*R is isomorphic to R tensor M.
Degrees give deg M=0. Transport the inclusion N tensor M into
R tensor M across this isomorphism, and project to F_abs^*K.
This composite is nonzero: otherwise it would factor through
F_abs^*N, but
\[
\operatorname{Hom}(N\otimes M,F_{\mathrm{abs}}^*N)=0
\]
because the line degrees are minus one and minus five. The nonzero
composite would therefore give
\[
H^0\bigl(F_{\mathrm{abs}}^*K(O)\otimes
            (\det R\otimes M)^{-1}\bigr)\ne0,
\]
contrary to the proved vanishing. This proof does not need stability,
uniqueness of a maximal line, a connection comparison, or finite
monodromy. Applying the accepted finite-coefficient image theorem
gives the stated consequence for irreducible rank-three coefficients.

Higher returns remain open. The explicit positive presentation of
F_abs^{2*}K prevents repetition of this particular vanishing argument
at height two. No common coefficient or second actual endpoint map
has been extracted from an arbitrary unmarked common cover.
