# Proof: actual rank125 fifth values and the unique fixed-line lift

Version3,2026-09-15. This proves the
[scoped statement](../../../Theorems/deformations/elementary_covers/rank125_fixed_line_fifth.md).
All raw vectors, coefficient tables and run artifacts are outside the
research workspace. The argument audits the actual whole comparison;
it does not identify a characteristic-five cubic with that comparison.
Exposition consolidated2026-09-15: Section6 retains exact triangular
elimination; the general normalization algebra has moved to the
independent integral-oper lemma. The numerical
statement and its original computation inputs are unchanged.
The [bounded simplification audit](../../../Research/audits/ETALE_CARRY_AND_REPAIR_SIMPLIFICATION_AUDIT_2026_09_15.md)
checks the general lemmas and their scope independently of those
previously audited numerical inputs.
The [odd-kernel audit](../../../Research/audits/RANK125_FULL_ODD_KERNEL_AUDIT_2026_09_15.md)
also checks the new filtered elimination for all odd fourth choices.

## 1. Inputs and the conclusion from two values

The [escape proof](rank125_fourth_escape.md), Sections6,8,11, proves
for the original marked cover and its fixed canonical reference that

    theta5(H_lambda)=(0,0,vartheta(lambda),0),
    vartheta(lambda)=b+a*lambda.

These are actual obstruction statements, with all43 fourth choices
allowed. In particular vartheta=0 is equivalent to the existence of
a compatible W5 tuple after a suitable fourth translation. The
[fourth-reference proof](rank125_actual_fourth_reference.md) certifies
the numerical Hstar in the statement, its complete E4=0 comparison,
the original charts and whole first repairs.

The executed comparisons below give b=[56] and vartheta(1)=[81]. In
k0 these are 1+t+2t² and1+t+3t². Thus a=t²=[25] is nonzero. Moreover

    (1+t+2t²)+t²*(3+t)=1+t+t³=0.

There is exactly one geometric zero, lambda=3+t=[8]. The relative
image theorem then supplies a fourth translation cancelling the
complete primary-cokernel class; the full primary solve and whole
regular primitives supply its terminal fifth data. This proves
geometric existence, without asserting that the default fourth origin
already supplies that tuple. Section6 strengthens this to perfect-field
points, including k0, by an exact triangular argument.

## 2. Precision, actual charts and the first repaired tuple

The executed source is the
[whole fifth engine](../../../scripts/deformations/rank125/compare_fifth_fixed_line.py).
It uses the audited returned fourth engine preserved in the
[source reconstruction](../../../../litt3-computation-data/pro_rank125_fourth_reference_20260914/local_replay/).
The scalar symbol, all six primary rows, logarithmic character labels,
true Witt Frobenius, Hensel roots and square-trivial flat line are those
of the actual fourth-reference proof. No fifth scalar is an input.

All source algebra is computed modulo3125 and the fifth flat object
modulo625. The actual affine AS roots are lifted from25 to125 by
their etale equations, rather than by resectioning their Laurent
coefficients. The first affine graph is its genuine polynomial in
these roots modulo125. The first formal graph is the whole regular
expression in S_i+R_O,i, with the chosen integral sections transported
by jmath to the other infinity branch. In particular the lift of
the negated R_O,1 is its transported negative, not a fresh section.

Write A=a² for the pulled base coefficient. The whole first comparison
checks rho3(H)-rho3(0)=-A*n(H)^5. The affine and formal graphs have
signs -5*f_U and +5*f_O. Recompute each first column by negative
covariant differentiation, normalize its determinant, and recompute
the first column again. All four resulting jet entries and all four
inverse-Cartier horizontality entries agree at first flat precision25.

Crucially, extract P2,U and P2,O modulo25 from this FIRST repaired
tuple, using the oper equations for both columns. These are the
moving preceding potentials. Their residues are R and
z⁴*R-z³*D(g^-1). The canonical base potential alone does not replace
them, and neither does the potential after the next graph correction.

## 3. Full fourth source and whole second regular repairs

Compute the whole fourth numerator modulo125 and divide by25 before
normal projection. Its scalar quotient is zero at both Hstar and
Hstar+nu39. To solve its FULL normal class, first transform the six
normal rows from W monomials into logarithmic derivative-of-top
coordinates. If b is this six-row target, solve

    f*x0=ell*b

in the125-dimensional truncated polynomial ring. Its multiplication
rank is82. Then use the invertible constant ordinary five-by-five
block of M to solve the remaining five rows in increasing degree.
The source is accepted only after checking M*x=b in all six rows.
Apply inverse coefficient Frobenius, the original character scaling,
and the derivative-of-top factorials to recover the actual curve
source n4. It is inserted at125 in the source exponential; its whole
normal response is checked to be -A*n4^5.

Triangular base splitting of the repaired rho4 determines an actual
finite affine polynomial f2,U. The formal repair is defined by the
WHOLE expression

    f2,O=(rho4_repaired-f2,U)/z² mod5.

The normal part vanishes, f2,U is affine regular, and this quotient
is formal regular. Its full available series is used in the next
comparison; the truncated boundary used for normal elimination is
not used as the formal primitive. The other branch is again defined
by transport of the whole integral section.
The second affine polynomial is evaluated on the actual affine roots
modulo25; the whole formal quotient receives its regular coefficient
section lift. Both weight25 graphs are retained modulo625, while the
earlier weight5 graphs require repair lifts through125.

The fourth connections have lower-left entries

    -25*Phi_U(P2,U)*zeta_U,    -25*Phi_O(P2,O)*zeta_O.

Here Phi_U(P2,U), modulo25, includes the correction
(F_U(z)-z^5)*Phi_O(partial_z P2,U). Both second graphs have weight25.
After determinant normalization and column recomputation, all four
corrected second-jet entries match the actual source jet modulo125.
This verifies a complete compatible fourth tuple before the fifth
comparison is attempted.

## 4. Whole fifth division and tail control

The fifth Taylor comparison uses the SAME preceding P2,U. Form its
whole normal numerator modulo625, divide by125, and only then reduce
and project. All four fifth inverse-Cartier horizontality entries
pass. The calculation retains fourth- and fifth-order Taylor terms;
their factorials cannot simply be treated as units.

The uniform bound in [integral oper calculus](../integral_oper_calculus.md),
Section1, is v5(K_j/j!)>=j-1-v5(j!). For every j>=6 it is at least4,
including all later factorial jumps, so these terms vanish modulo625.
The source exponential and determinant normalizations retain every
term of smaller weight. The
[independent formula audit](../../../Research/audits/RANK125_FIFTH_TUPLE_EXTENSION_AUDIT_2026_09_14.md)
checks these bounds and the precise preceding/new slot placements.

The divided fifth cochains have certified exclusive Laurent precisions
741,741,1055 in the three runs below. Projection uses precision150;
conversion from S to W_U loses at most28 and whole formal-boundary
elimination loses at most another28. The minimum retained normal
precision is94, while the six base normal coordinates require only
exponents through1. The finite projection therefore determines the
exact normal class of the whole cochain.

Arithmetic uses the faithful35-factor etale algebra decomposition
and exact GMP integer convolution of the fourth-reference proof.
The native arithmetic was separately checked against direct Python
integer convolution at625 and3125. The larger-precision replay changes
the affine Frobenius; it retains the same positive infinity anchor
and transports its integral sections to the other branch.

## 5. Executed vectors and independent checks

For the chosen fourth origins the only nonzero scalar normal entries
are as follows. These full vectors depend on that origin; their E100
coordinate is the invariant vartheta.

| Coordinate | Hstar | Hstar+nu39 |
| --- | --- | --- |
| E100 | [56] | [81] |
| E111 | [80] | [10] |
| E120 | [112] | [34] |
| E300 | [105] | [105] |
| E131 | [9] | [57] |
| E140 | [97] | [99] |
| E311 | [34] | [45] |
| E320 | [20] | [10] |
| E331 | [31] | [107] |
| E340 | [63] | [56] |

For the raw W_U coefficients b_e of the already divided fifth
cochain, the separate two-trace extraction is

    -N0(b344)+[85]N1(b444)+[85]N2(b444)+[48]N3(b444).

It agrees with E100 in every run. This checks the projection identity;
the two extraction paths share interpolation and base splitting and
are not claimed to be independent arithmetic implementations.

The exact receipts are
[lambda0,workspace3200](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/lambda0_N3200_v0_b1.json),
[lambda1,workspace3200](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/lambda1_N3200_v0_b1.json), and
[lambda0,workspace3600,changed Frobenius](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/lambda0_N3600_v1_b1.json).
The changed-Frobenius run reproduces the entire first column of the
table, not only its E100 entry. Each receipt contains all50 executed
checks, the full fourth source and second affine coefficients, the
whole formal definition, precision bounds, and hashes of all19 source
dependencies. Whole fourth objects and divided fifth cochains are
preserved separately beside these receipts.

The [receipt and field checker](../../../scripts/deformations/rank125/certify_fixed_line_fifth_values.py)
independently verifies source hashes, required checks, precision,
agreement and field arithmetic. Its
[small summary certificate](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/fixed_line_values.json)
is supplementary to the executed comparisons. The bounded independent
audit above checks the whole-tuple formulas, receipts, and the exact
scope of the existence inference. Neither this calculation nor that
inference addresses a sixth extension or an arbitrary two-map common
source.

## 6. Exact fixed-source fibers over perfect coefficient fields

Put H=Hstar+[8]nu39. Let Gamma be generated by
H(s)->-H(-s) and H(s)->-H(-s1,s2,s3). Its fixed scalar source K^Gamma
has the ten basis vectors in the statement. Its fixed scalar target
has basis E100, then the three degree-three, four degree-five and two
degree-seven coordinates of the table above. All operators are
defined over k0, with coefficient Frobenius and its inverse included.

The established complete relative identity is

    R_H(V)=E4(V)-Q(V,V)+2Q(H,V).

It is additive and F5-linear, although not assumed F-linear. Write
E4(V)=Q(V,V)-C(fV)+D_regular(V). The actual D_regular preserves
J-filtration. Therefore below degree5 on K, and below degree7 on
K7, the response is exactly the k-linear expression
-C(fV)+2Q(H,V). On K9 it is exact in the full quotient, since its
regular tail lies in J9 subset(f). The characteristic-five Q and
carry tables used here were reconstructed and audited independently
in the escape proof. The566 supplied Q pairs have leading-degree
sum at most16; each omitted pair has sum at least17 and therefore
Q lies in J8 subset(f). No surviving pair is omitted.

In the ordered source complement

    nu1,nu2,nu11

the output coordinates E111,E120,E300 have matrix

    L=[[6,7,5],[59,51,17],[32,42,116]], det L=[113].

The next complement

    [121]nu11+nu12, nu15, nu16, nu27

lies in K7 and in the kernel of those low outputs. Its matrix in
coordinates E131,E140,E311,E320 is

    M=[[0,59,43,0],[91,86,59,0],
       [62,106,55,37],[51,81,37,116]], det M=[44].

Finally gamma1=[11]nu27+nu30 and gamma2=[87]nu27+nu31 have only
degree-seven outputs, with matrix

    N=[[101,35],[24,70]], det N=[58]

in coordinates E331,E340. All entries are field codes. Together
these nine vectors and nu39 form a basis of K^Gamma. The previously
proved terminal formula gives R_H(F*nu39)=0 exactly.

These matrices are computed by the
[triangular solver](../../../scripts/deformations/rank125/solve_fixed_fifth_correction.py),
with its [complete profile](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/fixed_correction_profile.json).
The independent audit checks every displayed entry and all three
determinants. In coordinates x in F³,y in F⁴,z in F²,t in F, the
complete response therefore has successive nontrivial blocks

    L*x,  M*y+T5(x),  N*z+T7(x,y),

where the actual additive tails T5,T7 are retained. They are defined
over k0 using finite sums, products, Frobenius and inverse Frobenius;
they take F-points to F-points because F is perfect.

The [triangular point-torsor lemma](../marked_obstruction_torsors.md),
Section2, applies without assuming that these tails are field-linear.

Apply the lemma with L,M,N: every desired nine-coordinate target
has a solution in F, unique in x,y,z, with t arbitrary. The zero
target forces x=y=z=0. Thus the mixed-additive tails introduce no
extra finite point-kernel. This proves precisely the
kernel, image and perfect-functor fiber assertions of Version2; it
does not assert reducedness of a Frobenius-parameter scheme.

### The entire odd kernel

The same elimination principle sharpens the earlier odd image theorem
without evaluating any additional reference coefficient. On the
22-dimensional K_odd, the degree-one output is identically zero and
the degree-three response is an F-linear matrix of rank6. On the
18-dimensional K7, its restriction has rank2. These are the exact
constant-minor calculations of the escape proof, Section6; H5 differs
from H_A by K9, whose polarization changes only outputs in J5.

The kernel of the degree-three matrix on K_odd has dimension16.
The kernel of its restriction to K7 also has dimension16 and is a
subspace of it. Hence the two kernels are equal. Every element of
the full response kernel is therefore in K7, with zero degree-three
output. The mixed-additive regular term has played no role: its
degree is at least5 on K and at least7 on K7.

On this 16-dimensional linear kernel, the degree-five response is
again F-linear and has rank8, by the independently verified constant
minor[104]. Its kernel has dimension8. The whole K9 is in the
degree-three kernel; it has odd dimension10 and degree-five rank2.
Thus the degree-five kernel inside K9 is another dimension8 subspace
of the preceding kernel and must equal it. Every full odd kernel
element is consequently in K9. All these matrices have the same
ranks over every extension F, since their indicated minors are units
and the upper bounds are exact coefficient identities.

On K9 the entire relative response is the F-linear L_H5: its regular
term vanishes in the scalar quotient. The escape proof, Sections4
and7, identifies this map with L_H_A and computes its full odd
kernel as

    F*([117]nu32+nu33) + F*nu39 + F*nu40 + F*nu41.

The preceding two eliminations therefore prove that this is the
kernel on ALL of K_odd, not only on K9. In particular no finite
kernel of a nontrivial additive Frobenius polynomial can hide outside
K9. Dimension is used only for nested kernels of the genuinely
F-linear output blocks; it is never used to infer the point-kernel
of an arbitrary mixed-additive map. This is the reusable argument:
force a zero into successively smaller filtered subspaces using
linear output blocks, until every unknown additive tail vanishes.

The explicit Vstar below is odd and gives a complete fifth tuple.
Additivity of the actual relative response now identifies its entire
odd fifth-admissible fourth fiber with Vstar plus this four-dimensional
kernel. All primary sources and whole regular repairs stay over the
perfect field F. This proves the added Version3 assertion and makes
no assertion about even fourth choices or the next obstruction.

For the actual default fourth origin at lambda=[8], a separate whole
comparison gives E100=0 and the other nine entries

    (109,75,4; 13,98,89,67; 51,50)

in the above degree3/5/7 order. Its
[receipt](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/lambda8_N3200_v0_b1.json)
has source3125/flat625 and divided cochain precision741. To retain all
unknown tails in the explicit correction, the solver executes whole
mixed-characteristic E4 comparisons at

    Vlow=[93]nu1+[39]nu2+[30]nu11,
    Vhigh=[52]nu11+[83]nu12+[90]nu15+[57]nu16+[65]nu27.

Their COMPLETE relative responses, evaluated as E4-Q+2Q, are

    R_H(Vlow)=(46,50,1; 57,52,39,108; 38,101),
    R_H(Vhigh)=(0,0,0; 85,5,32,105; 26,63).

All other coordinates vanish. Adding [119]gamma1+[28]gamma2 cancels
the remaining degree-seven tail. The sum is exactly Vstar in the
statement, and E5(default)+R_H(Vstar)=0 in the FULL scalar quotient.
The [complete correction receipt](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/fixed_fifth_correction.json)
retains both actual E4 vectors, Q and mixed vectors, whole matrix
checks, coefficient tables and source hashes. The independent audit
verifies their arithmetic and the use of additivity, without treating
the whole R_H as an F-linear matrix.

The default fourth source, Vstar and the prescribed third source
have both tame scalar parities. Their actual polynomial representatives
give the corresponding invariant source curves. The Hodge line at
each fixed source extension is unique since H0(X,T_X)=0, so the
prescribed projective filtered tuple inherits these tame symmetries;
one does not infer integral equivariance merely by resectioning a
negated coefficient at the other branch. Opposite-branch sections
are transported as in Sections2--3. The source and whole regular
splitting operations take place in the faithful etale algebra over
W(k0); using its quartic factors does not enlarge the field of the
resulting object. The terminal full-primary solve uses inverse
Frobenius in k0 and whole regular primitives over the same field.
Average any terminal primary preimage over Gamma using1/4 in F5;
the primary and its coefficient Frobenius commute with Gamma and
are F5-linear, so this is an invariant solution over the same field.
This supplies the asserted compatible W5 tuple over W5(k0).

## 7. Direct completion of the whole fifth tuple

The [completion script](../../../scripts/deformations/rank125/complete_fixed_fifth_tuple.py)
independently executes the last existence step at tau=0. Its original
fourth-object cache is bound to the lambda8 receipt by the filename,
the complete source4 coefficient table, and recorded hashes. Insert
n(Vstar) in the fourth source and apply its whole incremental second
graphs. Directly recomputing and dividing the ENTIRE fifth numerator
gives a zero full scalar vector, with divided cochain precision563
and minimum normal projection precision94. This confirms the complete
relative correction without substituting the relative formula for
the actual comparison.

The exact graph formulas are now proved once in
[integral oper calculus](../integral_oper_calculus.md), Section2.
For this fifth completion only the square-zero formula is needed.
At weight25, the current potential modulo25 is the stored moving
P2: the earlier second graph and the difference between its local
connections begin at25. At weight125 only its residue is needed.
At infinity the derivation is D_O=z²D, with its variable coefficient
differentiated. This avoids the artificial Laurent-precision loss
of repeatedly normalizing already certified lower frames.

At sixth precision the older weight25 graph has nonzero square625;
the quadratic changed-connection formula must be used. Its linear
coefficient is needed modulo125 and its quadratic coefficient modulo5.
The final weight625 reframe of an unchanged Hodge line is the same
formula with q=0 and square zero. The
[focused audit](../../../Research/audits/RANK125_CONNECTION_NORMALIZATION_AUDIT_2026_09_15.md)
and [32-case check](../../../../litt3-computation-data/rank125_sixth_local_20260915/quadratic_connection_normalization_guarded.json)
verify the actual connection slots, all four entries, variable
derivations and determinant provenance. These original checks remain
evidence for the executed engines; their algebra is no longer
duplicated in this numerical proof.

Solve the now primary-exact six-row fifth target with the same full
RREF/ordinary-block rule. Its actual source has180 nonzero polynomial
terms and both tame parities. Insert it at625 in the source exponential
and recompute the whole normal cochain. The response is checked to be
-A*n5^5. Full normal splitting then gives a15,561-term affine third
repair and the WHOLE regular quotient

    f3,O=(rho5_source-repaired-f3,U)/z² modulo5,

of certified exclusive precision561. Its integral section is retained
as a whole formal expression, with the opposite branch transported.
The third graphs have signs -125*f3,U and +125*f3,O. Their full
corrected jet matches the source in all four entries modulo625, and
the inverse-Cartier transition satisfies all four connection equations
both before and after the terminal source insertion.

The [execution receipt](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/complete_fifth_tuple.json)
records all29 additional checks, full source and affine coefficient
tables, whole formal definition, and hashes of its sources and three
input artifacts. Its
[whole-object artifact](../../../../litt3-computation-data/rank125_fifth_fixed_line_20260914/complete_fifth_tuple.pkl)
retains the actual frames, preceding potentials, source exponential
coefficient and regular primitives. These are computation data, not
replacements for the human-readable argument above. Combined with
the already verified original fourth tuple, the direct checks establish
the complete compatible fifth tuple with the original reference,
twist and marking. They make no sixth-stage assertion.
