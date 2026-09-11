# Degree84: exact differential reduction and completed native trial

Updated 2026-09-11 01:27 CEST. Research diagnostic, NOT an exclusion.
The requested ten-core/thirty-minute run is COMPLETE. No second such
run is authorized. The A18 census and charts are not being restarted.
Subsequent field-aware experiments are recorded in
[the optimization comparison](BACKUP_A18_OPTIMIZATION_TRANSFER.md).

## Actual necessary equations

The audited triangle237 dormant-decoration argument has removed the
three primitive classes. The42 remaining classes factor through the
backup's hyperelliptic quotient. Let

    F=u(u-1)(u-2)(u-3)(u-alpha), alpha^3+alpha+1=0.

Place the Weierstrass point over infinity at a simple zero of the
degree42 quotient. An actual quotient with full fibers
1^6 2^18,3^14,7^6 has

    s F A^2 - B^3 = C^7,
    deg A=18, A monic; deg B=14, leading(B)=-1;
    deg C=6, C monic; s!=0.

Here s is the square of the leading coefficient of the unnormalized
A. The top coefficient identity gives s=3b13+2c5. The actual geometric
open also requires disjoint squarefree divisors; omitting those tests
enlarges the necessary system safely for a possible unit certificate.

For q=sFA^2/C^7 the complete ramification gives

    q'=-s A B^2/C^8.

Comparing derivatives of q and q-1 yields TWO useful identities:

    (F'A+2FA')C-2FAC'+B^2=0,
    3CB'-2BC'+sA=0.

These are quadratic, unlike the seventh-degree passport equation.
They retain the original polynomial relation; the relation has NOT been
replaced merely by its derivative in the production native test.

The rational horizontal solution t^2(t-1)^2 of the triangle's dormant
scalar oper pulls back as a half-density. In characteristic five its
logarithmic derivative is that of F^2AC. Consequently H=AC satisfies

    F H''+4F'H'+(3F''-P)H=0,
    P=2u^3+beta*u^2+b1*u+b0,
    b1=beta^2+3F4*beta+3F3,
    b0=-F2+(F4+2beta)*b1.

The five allowed beta form the known irreducible dormant quintic over
F125. One representative over F_(5^15) suffices by coefficient
Frobenius. The27-by25 generic-field matrix has rank15, hence a
10-dimensional horizontal space. This linear reduction is directly
checked. The separate focused geometric audit has now returned PASS:
[necessary dictionary](audits/DEGREE84_DIFFERENTIAL_SYSTEM_AUDIT_2026_09_10.md).
In particular, it checks the half-density logarithmic derivative without
assuming the half-density itself descends. No coefficient correction.

## Small diagnostics

scripts/diagnose_triangle237_compressed_system.sage builds the equations.
Two30-second full Groebner tests and45-second diagnostic tests were
inconclusive. A degree-bound/protocol test was unhelpful: final reduction
still did substantial work beyond the displayed low-degree stage.
The quadratic-only system also timed out after45seconds. None is a
negative geometric result, and none is a solved component.

The historical production export retained the full passport, BOTH derivative
identities, all horizontal coefficients and loc*s-1. Exact linear
elimination removes two redundant variables. The resulting system has
37 variables and112 generators over F_(5^15).

## Initial native adaptation (historical implementation)

Retained: repeated-multiplier coefficient-table factorization; look-ahead
Lanczos as a candidate finder; randomized row diagonals and column
congruence; global orthogonality/rank guards; exact scalar final replay;
atomic20-second checkpoints with input fingerprints.

Not transferred: A18's U/beta grading,32-direction tensor, old chart
normalization and saved weak-point skips. None describes this system.

Replaced coefficient arithmetic: the old kernel is fixed to F25. The
new exporter restricts the degree15 coefficient field to F5, multiplying
each equation by all15 basis elements before expanding coefficients.
The matrix has F5 entries, although Krylov arithmetic may still use F25.
A primal's constant F5 coefficient is an F5 primal and reconstructs an
actual polynomial identity over the original degree15 field. No
specialization or bounded coefficient-field point search is used.

The new prime-input kernel needs two component products rather than
three; it tiles them across all ten workers. Every matrix coefficient
is checked to be prime before this path is enabled. The accelerated
Gram operator is compared with the original scalar matrix on the actual
input. Thirty tiny rank-deficient tests, two congruence modes each,
returned48 independently checked certificates and12 inconclusive
searches; no incorrect certificate was accepted.

The complete export provenance was also independently replayed using
standard-library integer polynomial reduction, not Sage or the solver:
all61,410,920 nonzero entries passed in7.27seconds.

## Thirty-minute run and exact scope

Data: /Users/julian/Documents/litt3-computation-data/degree84-native-20260910-krDJ5g/c3

Multipliers: constant, every remaining variable, and all degree2/3
monomials in the six C coefficients;115 multipliers in total.
All112 generators are retained for each multiplier and field-basis
element. This is a BOUNDED unit-certificate ansatz, not a full Groebner
basis computation.

    rows193200, columns1656495, nonzeros61410920;
    base_rows1680; binary matrix307827408bytes.
    matrix SHA256:
    28e4fed55995876a1ff7b9b6aae453b8918d7d1289b757ff65dc1c253332daa0

The first50.7seconds enabled support pruning. It removed only600columns
but serialized work into two groups:18.3steps/sec,1.84cores,about2GB.
Checkpoint910 was retained. Disabling that pruning gives the SAME
original operator on the target component, since the omitted component
coordinates of every saved vector are zero. The resumed full operator's
scalar comparison passed. Initial new rate41steps/sec,6.4actualcores,
ten enabled threads, about0.9GBcurrent/1.3GBpeak memory.

The complete invocation used1799.764143seconds and73126steps, averaging
6.627actualcores with1.31GBpeak memory. It ended without a verdict and
retained its checked checkpoint. No busy reminder/polling loop was used.

The SAME finite multiplier span was subsequently settled in2.02264s by
sparse elimination over its ORIGINAL coefficient field. Its exact dual
independently replayed all61,410,920 expanded input terms in5.39462s.
Thus this span cannot contain a unit identity; its old checkpoint must
not be resumed in search of one. This is not a point or cover certificate.

A C4-only enlargement and the full-quadratic span were likewise rejected
by independently replayed exact duals. The current direction uses the
row operations to extract and reuse new low-degree consequences rather
than continuing those exhausted finite spans. See the linked experiment
record for timings, source hashes and current bounded tests.

## Further exact reductions found during the timed run

The timed input was not changed. The following reductions were discovered
during that trial and subsequently tested, as recorded separately.

1. In characteristic five, the second derivative identity is
   `3(BC)' + s A=0`. Its coefficients at u^4,u^9,u^14 are s*a_i.
   With the existing guard g=loc*s-1,
   `loc*(s*a_i)-a_i*g=a_i`. Therefore a4=a9=a14=0, with exact input-
   ideal certificates. The optional exact-derivative-reduction diagnostic
   reduces37variables/112equations/4182terms to34/109/3474 in0.45s.

2. A substantially stronger cofactor formula eliminates ALL18 A
   coefficients. The two degree-four horizontal solutions H0,H1 have
   gcd1 and Wronskian a nonzero constant times F. Over k(T),T=u^5,
   form the5x6matrix with columns C,Cu,Cu^2,Cu^3,-H0,-H1,
   reduced modulo u^5-T. Its signed maximal minors give A_raw of
   degree18 with coefficients cubic in the six C coefficients. Its
   leading coefficient has degree2 and four terms. Every ACTUAL cover
   has that coefficient nonzero and A=A_raw/lc18: squarefreeness of
   C proves rank5, and squarefreeness of A proves primitivity, so the
   cofactor multiplier is a nonzero constant. Focused coverage audit
   [PASS](audits/DEGREE84_COFACTOR_REDUCTION_AUDIT_2026_09_10.md).
   The symbolic cofactor/ODE replay takes0.22s. The current direct
   cleared formulation has22variables,86equations,31846terms and
   degree up to11, retaining the passport. Fewer variables do NOT
   by themselves establish faster solving; the larger term count is
   a real tradeoff. See diagnose_triangle237_cofactor_reduction.sage.

3. Field-aware singleton peeling, BEFORE scalar restriction, removes
   7975 of12880rows and leaves4905rows,8123monomialcolumns,85788terms,
   versus110433columns/480930terms initially. The expanded F5 support
   conceals these field-block eliminations. Receipt field_peeling.json
   is saved beside the original source. The target still has14incident
   rows: peeling alone is NOT a bounded dual or an exclusion.
   There are24repeated-row-mask groups; these can replace the old
   component groups in a future factorized kernel. The completed run's
   checkpoint is preserved, not reused for the different pruned operator.

## Degree2 remains separate

C's degree2 hyperelliptic map exists. A matching atlas would be an
actual degree16 map X→P1(2,2,2,2,2,2) to the SAME branch set. Its
pullback gives an actual etale double X'→X and etale X'→C of degree16.
The split case contradicts Hom(JX,JC)=0; the connected case has genus17
and is still open. Ordinary JC and one-leg Jacobian orthogonality do
not forbid a JC factor in the Prym. The low-degree W3 torsion theorem
does not apply to the degree8 branch fibers. No such shortcut was used.
