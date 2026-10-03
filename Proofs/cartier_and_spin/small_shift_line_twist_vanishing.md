# Proof from the exact cubic norm

The fixed field is F25=F5[a]/(a^2-a+2), with coded coefficient
[i+5j]=i+ja. The curve and actual extension are
\[
X:y^3=P(x),\quad P=(11,22,18,5,19,20,15,16,9,22,1),
\qquad0\longrightarrow O_X(-5O)\longrightarrow K
\longrightarrow O_X(6O)\longrightarrow0,
\]
with rational transition(a,b)->(a-eb,b), where
\[
e=y^2\sum_{m=1}^{10}[c_m]x^{-m},\qquad
c=(2,16,16,7,1,2,7,1,24,11).
\]
All section and connecting-map calculations below use this actual
transition, not just its graded lines. The cubic action is
gamma(x,y)=(x,zeta*y), with bundle linearization diag(zeta,1).

## Invariant classes at the final shift

Set E=K(3O), so det E=O(7O). The
[invariant-Picard lemma](cyclic_determinant_section_reduction.md)
represents every gamma-invariant Pic0 class by
\(D=\sum s_i(R_i-O)\), \(s_i\in\{0,1,2\}\), \(s_{10}=0\).
Thus19683 divisors exhaust all geometric invariant classes.

Put \(A=\prod_{s_i=1}(x-r_i)\), \(B=\prod_{s_i=2}(x-r_i)\),
\(w=\deg A+2\deg B\), and \((D_0,D_1,D_2)=(1,B,AB)\).
A character-j basis of O(dO+D) is
\[
y^jx^i/D_j,\qquad
0\le i\le\left\lfloor(d-w-10j+3\deg D_j)/3\right\rfloor.
\]
H1 uses the exponents strictly between this upper bound and zero.
The actual class e shifts j to j+2 modulo three, with polynomial
factors AB,P/B,P/A. It gives the connecting map from d=9 sections
to d=-2 cohomology; the negative extension line has no sections.

Every one of the19683 maps is injective. Source dimensions4,3,2,1
occur11,1000,8802,9870 times respectively. A separate32-map literal
rational multiplication and F5-rank check covers all four dimensions
and passes. This is exhaustive class coverage, not a bounded-field
assumption on arbitrary Pic0 lines.

If a nonnegative-degree saturated line M in E has invariant class,
M(-deg(M)O) is an invariant Pic0 line mapping nontrivially into E,
contrary to these maps.

## The final cubic norm excludes all other nonnegative lines

For a noninvariant class, the three embedded conjugates are distinct.
The [general norm criterion](cyclic_determinant_section_reduction.md)
gives a nonzero \(s\in H^0(E\otimes\det E)\) and nonzero wedge with
\[
s\,\gamma(s)\,\gamma^2(s)=(s\wedge\gamma(s))G,\qquad
G\in H^0(\operatorname{Sym}^3E).
\]
This necessity holds for every nonnegative degree; no earlier shift,
stability assumption or degree-zero saturation is required.

The complete H0(E tensor det E)=H0(K(10O)) calculation has a6-by11
matrix of rank4, and hence dimension7. Its character multiplicities
are2 for character0 and5 for character1. The complete cubic space
H0(Sym3 K(9O)) has a20-by30 matrix of rank20 and dimension10; seven
of its sections have character0 and three have character1. Each
matrix rank is independently checked after restriction of scalars
to F5.

Write s=p+q with p in the two-dimensional character-zero part and
q in the five-dimensional character-one part. In rational coordinates
p=(y^2C,B), q=(A,yD), where A,B,C,D are polynomials in x.
The orbit product is p^3+q^3 and the wedge is a nonzero constant
times H=PCD-AB, of degree at most seven. Passing from the natural
K(10O) linearization to E tensor det E multiplies the action by a
constant cubic character; it leaves the orbit product unchanged and
only changes the wedge constant. Since H is invariant, G belongs
to the seven-dimensional invariant cubic space.
Write the coordinates of p,q,G as(b0,b1),(d0,...,d4),(g0,...,g6).
The equations have109 parameter monomials: four cubic b-monomials,
35 cubic d-monomials, and70 b_i*d_j*g_k products. Their coefficient
matrix has92 rows and rank35, independently rank70 over F5.

There are precisely two needed charts: b1=1 with b0 free, and
b1=0,b0=1. The case p=0 is an eigenvector and is already excluded;
the case q=0 is either excluded the same way or gives the impossible
identity p^3=0 with zero wedge. Both charts therefore retain the
whole geometric problem. They give35 equations in13 variables and
33 equations in12 variables, respectively.

BOTH ideals are the unit ideal. Exact sparse F4 and independent
prime-field Singular std agree. Explicit identities for one contain
19077 terms on the boundary and949055 terms on the open chart.
The latter was extracted over F25, then expanded back to F5 with
the constant-field relation; this avoids a larger intermediate lift.
The independent standard-library verifier reconstructs all109
columns, each chart equation, and the exact polynomial identities.
Both replays passed. In particular this is an all-geometric exclusion,
not a computation at F25-valued parameter points.

Every nonnegative-degree line in E is therefore excluded. This proves
H0(K(3O) tensor L)=0 for every geometric Pic0 L, and all smaller shifts
follow by inclusion. A line
in K of degree at least minus three would contradict this after
twisting to degree zero, so every line has degree at most minus four.

The explicit section of K(4O) has affine coordinates
(A(x),y), where the ascending coded coefficients of A are
\[
A=(22,2,2,22,5,8,0,12,5,2).
\]
An exact polynomial Bezout identity gives gcd(A,P)=1. Therefore the
two coordinates never vanish simultaneously at a finite point. At O
the quotient line of K(4O) is O(10O), and y has order minus ten,
so the section is nonzero in that fiber too. It is nowhere zero,
giving the saturated sequence O(-4O),O(5O). The Bezout identity has
also been replayed by elementary coded-field multiplication. Thus
minus four is attained and is the exact maximum; the minimum quotient
degree is five and the Segre invariant is1-2*(-4)=9.

Finally, let0->N->R->K->0 have deg N=-1. A saturated line M in R
different from N maps nontrivially into K. Its image saturates to
a line of degree at least deg M, so deg M<=-4. A saturated line
generically contained in N is N itself. This proves the stated
uniqueness and gap, without asserting anything about rank-two
destabilizing subbundles of R.

## Reproducible evidence and scope

The evidence directory is
[the external overnight record](../../../litt3-computation-data/overnight_three_replies_20260926/).
The invariant census uses
[the exact enumeration](../../scripts/arithmetic/k_small_shift_invariant_twists.py)
for the final shift3, and
[its independent checker](../../scripts/arithmetic/check_k_small_shift_invariant_twists.py).
The complete bases are reconstructed by
[the section source](../../scripts/arithmetic/k_symmetric_section_space.py)
at (degree,twist)=(1,10),(3,9),(1,4).

The final-shift receipts have prefix `k_original_shift3`;
the determinant-twisted source is `k_original_determinant_shift3_sections.json`.
The [general norm constructor](../../scripts/arithmetic/k_small_shift_general_norm.py)
takes that source and `k_original_shift3_cubic_sections.json`, with
`--chart 0` or `--chart 1`. The coefficient reconstruction is repeated
by [the elementary general verifier](../../scripts/arithmetic/verify_k_small_shift_general_norm.py).
Its two final receipts are `k_original_shift3_chart0_elementary_check.json`
and `k_original_shift3_chart1_elementary_check.json`. The actual
identities are in `std_original_shift3_norm_chart0.json` and
`extension_original_shift3_norm_chart1.json`. The latter is produced
by [extension-field extraction](../../scripts/arithmetic/extract_k_norm_extension_certificate.py).
The complementary prime-field std receipt retains its successful
unit-ideal result; its redundant multiplier extraction was stopped
after the extension-field identity passed the independent replay.
The final saturated-line check is
`k_original_maximal_line_presentation.json`.

The lower-shift K(O) and K(2O) calculations are subsumed by this
direct final-shift argument; their two specialized norm algorithms
have been deleted completely. Original evidence and source hashes
remain in
[the external provenance](../../../litt3-computation-data/nonnegative_norm_before_hindsight/).
The final cubic norm certificates, complete section bases and
saturated-line check remain necessary. No claim is made about arbitrary
finite pullbacks, etale generation, higher returns or either original
common-cover problem.
