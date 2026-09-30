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

## The invariant twists

The invariant-class classification in the
[first-Frobenius proof](fifth_symmetric_twist_vanishing.md) applies to
K(sO) as well: all geometric gamma-invariant Pic0 classes are
represented by D=sum s_i(R_i-O), s_i in{0,1,2}, s_10=0. Here the R_i
are the ten cubic branch points. Thus19683 representatives suffice;
there is no bounded finite-field assumption on an arbitrary Pic0 line.

For clarity, set A(x)=product_(s_i=1)(x-r_i),
B(x)=product_(s_i=2)(x-r_i), w=deg A+2deg B, and
(D_0,D_1,D_2)=(1,B,AB). A character-j basis of O(dO+D) is
\[
y^jx^i/D_j,\qquad0\le i\le
\left\lfloor(d-w-10j+3\deg D_j)/3\right\rfloor.
\]
The H1 basis uses the integers strictly between that upper bound
and zero. Multiplication by e shifts j to j+2 modulo three and has
polynomial factors AB,P/B,P/A respectively. This is a finite exact
connecting matrix from the d=6+s sections to the d=-5+s cohomology.
The latter extension line has no sections for s=1,2.

For s=1 and s=2 every one of these connecting maps is injective.
The source-dimension histograms and the complete zero-kernel results
are retained in `k_original_shift1_invariant_twists.json` and
`k_original_shift2_invariant_twists.json`. A separate routine forms
the actual rational multiplication, checks its polynomial divisions,
and expands the maps over F5. It checks24 complete maps for each
shift, covering every nonzero source dimension. These independent
checks audit the arithmetic; exhaustive coverage is supplied by the
separate full19683 enumerations.

## A short alternative for K(O)

Put E=K(O), so det E=O(3O). The complete section space
H0(E tensor det E)=H0(K(4O)) is one-dimensional, of cubic character1.
The exact12-by5 Laurent matrix has rank4, independently rank8 over
F5. The [cyclic determinant-section lemma](../../Theorems/cartier_and_spin/cyclic_determinant_section_reduction.md)
and the invariant-twist computation therefore give all-Pic0-twist
vanishing for E. This reproves the earlier
[K(O) theorem](../../Theorems/cartier_and_spin/low_degree_twist_vanishing.md)
without repeating its shifted symmetric-power argument.

## The actual norm for K(2O)

Now E=K(2O), det E=O(5O). There is no positive-degree line M in E:
if deg M=m>=1, then M(-mO) is a degree-zero line mapping into
K((2-m)O), hence into K(O), which was excluded above. A nonzero
degree-zero-line map into E would consequently be saturated.
If its class is invariant it was already excluded by the enumeration.

Otherwise the cyclic determinant lemma produces a nonzero
s in H0(E tensor det E)=H0(K(7O)) and
\[
s\,\gamma(s)\,\gamma^2(s)=(s\wedge\gamma(s))G,
\qquad G\in H^0(X,\operatorname{Sym}^3K(6O)).
\]
This identity holds globally and retains all finite zeros, repeated
zeros, and infinity. The section-space calculation gives dimension4
for H0(K(7O)): its9-by8 matrix has rank4, independently rank8 over
F5. Its characters are0,1,1,1. Write s=p+q with p in the
one-dimensional character-zero part and q in the three-dimensional
character-one part. An eigenvector would give an invariant line,
so p and q are both nonzero. Normalize the coefficient of p to one;
scaling G by the same scalar preserves the norm identity.

In rational coordinates p=(y^2 C,B), q=(A,yD). Thus the orbit
product is p^3+q^3 and the wedge is a nonzero constant times
H=PCD-AB. Its degree is at most five. The rational wedge is
gamma-invariant, so only the invariant part of the cubic section
space contributes. The complete26-by24 matrix has rank21,
independently rank42 over F5; all three basis sections have character0.

Let d0,d1,d2 be the three coefficients of q and g0,g1,g2 those of G.
There are20 parameter monomials in the norm equation: the constant
p^3, ten cubic d-monomials, and nine d_i*g_j products. Expanding in
the actual algebra F25[x,y]/(y^3-P) gives an80-by20 coefficient
matrix of rank18, independently rank36 over F5. Constant row
reduction gives18 equations in the six variables. No value, torsion
condition or finite-field equation is imposed on these variables.

The ideal of these18 equations is the unit ideal. Its exact certificate
is particularly small:37 terms in the polynomial multipliers express
one as their combination. The coefficient field is represented over
F5 by adjoining a with a^2-a+2=0. The independent elementary verifier
reconstructs the entire80-by20 matrix, checks every resulting equation,
and multiplies the saved identity literally. It returns exactly one,
without calling any Groebner-basis procedure. This excludes all
geometric solutions of the necessary norm identity.

Together with the invariant cases this proves the claimed vanishing.
For any line M in K of degree m>=-2, the degree-zero line
M(-mO) maps into K(-mO), hence into K(2O), a contradiction. Thus
deg M<=-3. Taking determinants gives deg Q>=4 for every line-bundle
quotient Q of K.

## The next shift and the exact maximum line degree

Set E=K(3O), so det E=O(7O). The established K(2O) result excludes
positive-degree lines in E. The same invariant-twist enumeration
with s=3 gives zero sections for all19683 representatives. The
source dimensions4,3,2,1 occur11,1000,8802,9870 times respectively.
A separate32-map rational multiplication and F5-rank check covers
all four nonzero source dimensions and passes.

The complete H0(E tensor det E)=H0(K(10O)) calculation has a6-by11
matrix of rank4, and hence dimension7. Its character multiplicities
are2 for character0 and5 for character1. The complete cubic space
H0(Sym3 K(9O)) has a20-by30 matrix of rank20 and dimension10; seven
of its sections have character0 and three have character1. Each
matrix rank is independently checked after restriction of scalars
to F5.

A noninvariant line must again satisfy the exact norm identity, with
p in the two-dimensional character-zero part, q in the five-dimensional
character-one part, and G in the seven-dimensional invariant cubic
space. Write their coordinates(b0,b1),(d0,...,d4),(g0,...,g6).
The rational wedge is still PCD-AB, now of degree at most seven.
Its equations have109 parameter monomials: four cubic b-monomials,
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

This proves H0(K(3O) tensor L)=0 for every geometric Pic0 L. A line
in K of degree at least minus three would contradict this after
twisting to degree zero, so every line has degree at most minus four.

The previously computed unique section of K(4O) has affine coordinates
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
The relevant source files are:

- [Invariant enumeration](../../scripts/arithmetic/k_small_shift_invariant_twists.py),
  run with Sage Python and `--shift 1` or `--shift 2`.
- [Independent invariant checker](../../scripts/arithmetic/check_k_small_shift_invariant_twists.py).
- [Complete section reconstruction](../../scripts/arithmetic/k_symmetric_section_space.py),
  with `(degree,twist)=(1,4),(1,7),(3,6)`.
- [Norm construction](../../scripts/arithmetic/k_small_shift_norm_separation.py),
  taking the K(7O) and Sym3 K(6O) section receipts.
- [Prime-field ideal certificate](../../scripts/arithmetic/check_k_prepared_prime_ideal.py),
  with `--certificate` on the prepared norm equations.
- [Independent elementary identity replay](../../scripts/arithmetic/verify_k_small_shift_norm_identity.py),
  taking the two section receipts, norm matrix and ideal certificate.

The final replay receipt is `k_original_shift2_norm_elementary_check.json`;
the identity is `k_original_shift2_norm_ideal.json`. The matrix and
prepared equations have prefix `k_original_shift2_norm_relaxation`.
The section receipts are `k_original_determinant_shift2_sections.json`
and `k_original_shift2_cubic_sections.json`. Independent twist receipts
have names `k_original_shift1_independent.json` and
`k_original_shift2_independent.json`.

For shift3, the analogous receipts have prefix `k_original_shift3`;
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

The rank18 linear relaxation alone has solutions: the other19 columns
also have rank18. The nonlinear cubic norm compatibility is essential.
No claim is made about arbitrary finite pullbacks, etale generation,
higher Frobenius returns, or either original common-cover problem.
