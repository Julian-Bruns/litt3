Imported Pro proof, 24 September 2026; focused integration and local verification are recorded in [the audit](../../Research/audits/STRUCTURAL_TRIPLET_2026_09_24.md). File references inside this report are relative to the preserved [results archive](../../../litt3-computation-data/structural_triplet_replies_20260924/originals/return/strict_second_return/). Generated certificates stay there; source copies are in scripts/arithmetic/pro_structural_triplet_20260924/return. The canonical theorem statement governs its accepted scope.

# Strict second Frobenius returns: proved reductions and exhaustive F25 exclusion

## 0. Completion status

**Partial result. The existence problem over the full algebraic closure is not decided.** No stable return parameter or geometric emptiness certificate is asserted.

This investigation proves a symmetry reduction from 51 to 24 morphism coefficients, identifies an exact parameter-only description of the remaining invertible locus on determinantal open sets, and excludes **every stable parameter in P^5(F25)**. The latter exclusion allows the coefficients of a putative isomorphism to lie anywhere in the algebraic closure: it is not merely a search for F25-valued matrices.

The computation also supplies a new, geometrically stable parameter outside the stated first-Frobenius scroll, with a nonzero quotient map to K and a two-dimensional full Hom space consisting entirely of singular maps. It disproves containment of the second quotient-incidence support in that scroll. Its second Frobenius pullback has a negative-degree quotient, so this parameter has no positive strict Frobenius period.

The remaining geometric question is precisely the determinant-nonzero locus in Section 6. The 96 exact polynomial systems in Section 10 give a second, complete presentation of that question. They have **not** been solved.

## 1. Conventions and complete input

Let k be an algebraic closure of F5. Coefficients are in F25 = F5[beta]/(beta^2-beta-3). An integer code a+5b means a+b beta, with 0 <= a,b < 5; arithmetic is not arithmetic modulo 25. Polynomial coefficient rows are ascending. The machine-readable input is `data/input.json`.

The curve and extension are

- X: y^3=P(x), with P=(11,22,18,5,19,20,15,16,9,22,1);
- e=y^2 sum_{m=1}^{10} [c_m] x^{-m}, c=(2,16,16,7,1,2,7,1,24,11);
- v=y^2 sum_{i=0}^{5} v_i x^{i-6};
- R_v has transition [[1,0,-v],[0,1,-e],[0,0,1]] and divisor-frame degrees (-1,-5,6).

The six-term expression for v is interpreted as a linear combination; the missing plus between two middle terms in one printed formula does not change the six-coordinate convention.

Write eta_i=v_i^25 for source parameters. Target parameters remain v_i. Throughout the geometric constructions **eta and v are different roles**. The only place where eta_i=v_i is used is the explicitly identified enumeration of F25-rational parameters. There is no assertion that strict Frobenius periodicity forces a parameter to be F25-rational.

For a reduced Laurent polynomial, a monomial x^i y^j has pole weight 3i+10j. We use the spaces and coefficient vectors

    B0(d) = {(i,j): j=0,1,2; i>=0; 3i+10j<=d},
    B1(d) = {(i,j): j=0,1,2; i<0; 3i+10j>d},

ordered by j and then i. L_d is the span of B0(d); [p]_d extracts B1(d). Positive and negative parts refer to the sign of the x exponent after reduction by y^3=P.

All general tensor data can be rebuilt from P and e with the eight original supplied source files, preserved under `upstream/`. The full nineteen-coordinate construction is specialized to indices 13,...,18. The exact specialized tensors, including recovery maps, are stored in `data/pure_v_return.npz` and in the lossless portable equivalent `data/pure_v_return.json.gz`.

## 2. Dependencies and elementary lemmas

### 2.1 Geometric inputs accepted from the problem

We use, rather than reprove, the supplied statements that K is stable; every nonzero R_v is semistable of degree zero; dim Hom(R_v,K)=1; the stable locus is exactly the complement of the ten specified b(r) points; the stated first-Frobenius scroll is a stable nonperiodic locus; and formulas (5)-(8) are complete morphism equations. The given finiteness and reducedness of the stable fixed locus are used only when discussing the structure of the remaining locus, not to infer emptiness.

The hypotheses concerning the unique maximal line, the two H0 vanishings, and absence of first returns are retained as input but are not substitutes for the determinant test. Nothing here assumes an unproved description of the support of the quotient module.

### 2.2 Stable bundles are simple in the case used here

If E is stable of degree zero and a nonzero endomorphism has rank less than rank E, its proper nonzero kernel has negative degree. Its image consequently has positive degree. Saturating that image contradicts stability. Thus every nonzero endomorphism has full rank. Its determinant is a global function on the connected proper curve, hence a nonzero constant, and the endomorphism is an isomorphism. Over k, subtracting an eigenvalue on one fiber shows that every endomorphism is scalar. In particular, if E' is isomorphic to E, then Hom(E',E) is one-dimensional.

### 2.3 No maps from a semistable degree-zero bundle to a negative line

A nonzero map E -> O_X(-O), with E semistable of degree zero, would have rank-one image of negative degree. Its kernel is a subbundle of positive degree, contradicting semistability. Thus Hom(E,O_X(-O))=0.

### 2.4 A stable periodic bundle has stable iterated Frobenius pullbacks

A nonnegative-degree proper subbundle of any pullback remains a nonnegative-degree proper subbundle under further Frobenius pullback. On a smooth curve Frobenius is flat; locally this is the familiar freeness of the parameter-power extension of a discrete valuation ring. Degrees multiply by 5. If a later pullback returns to a stable bundle, such a subbundle is impossible. In particular a stable second return forces F*R_v to be stable, and a stable bundle whose second pullback is not semistable cannot have any positive strict period.

## 3. Every stable return respects the order-three action

### Proposition 3.1

Every isomorphism F^{2*}R_v -> R_v with R_v stable lies in the invariant character of the order-three action induced by y -> zeta y.

### Proof

Take zeta=[11]; exact arithmetic gives zeta^3=1, zeta!=1, and zeta^25=zeta. Under gamma:(x,y)->(x,zeta y), both e and v are multiplied by zeta^2. The constant matrix

    D=diag(zeta,zeta,1)

therefore defines a linearization gamma*R_v -> R_v: it satisfies D gamma*(G)=G D for the displayed transition matrix G. The same linearization is induced on F^{2*}R_v because D^{[25]}=D. The divisor frames are respected by this action.

If a stable return exists, its full Hom space is one-dimensional by Section 2.2. The order-three action on that line is a character. Consider any finite branch point (r,0), P(r)=0. Such a point is fixed by gamma; the U frames are regular there. On both source and target fibers, the linearization has character multiset {zeta,zeta,1}. Twisting this multiset by either nontrivial character does not preserve it: the character of multiplicity two changes. An invertible fiber map that is an eigenvector of a nontrivial character is consequently impossible. The Hom character must be trivial. This argument does not require r to be F25-rational. QED.

### Corollary 3.2: the matrix character pattern

An invariant matrix satisfies D gamma*(H) D^{-1}=H. Its entries have y exponents

    [[0,0,2],
     [0,0,2],
     [1,1,0]]       modulo 3.

Thus the free polynomials in formula (5) can be restricted exactly to

    f     = y * sum_{i=0}^{7} f_i x^i,       dimension 8;
    alpha =     sum_{i=0}^{6} a_i x^i,       dimension 7;
    g0    = y * sum_{i=0}^{40} g_i x^i,      dimension 41;
    q0    =     sum_{i=0}^{40} q_i x^i,      dimension 41;
    s0    =     sum_{i=0}^{8} s_i x^i,       dimension 9;
    t0    =     sum_{i=0}^{41} t_i x^i,      dimension 42.

For example, e f has y exponent zero after y^3=P, so the prescribed expression for a has the required character. The remaining formulas preserve the listed pattern. Conversely, uniqueness of the full free-polynomial parametrization forces these restrictions on every invariant morphism. No morphism that could be a stable isomorphism is discarded.

## 4. Exact reversible reduction to a 37-by-24 matrix

In this character sector, the B*, A*, N* residuals have respectively 47, 58, 56 coefficients: B* has y exponent 0, and A*,N* have y exponent 2. The 148 free coefficients are reduced by two constant eliminations:

- the (g0,q0) block has shape 105 by 82 and rank 82;
- the t0 block has shape 56 by 42 and rank 42.

These ranks were computed exactly and are checked in `src/build_equivariant.py`. They leave 23+14 equations on 15+9 unknowns. Set c=(f_0,...,f_7,a_0,...,a_6) and s=(s_0,...,s_8). Define

    T(z)=sum_j z_j T_j,       T_j: 23 by 15;
    Q(z)=sum_j z_j Q_j,       Q_j: 14 by 9;
    C(v,eta)=sum_{i,j} v_i eta_j C_ij,    C_ij: 14 by 15.

Then the invariant full Hom space is exactly

    ker A(v,eta),  A(v,eta)=[[T(eta),0],[C(v,eta),Q(eta)]],
    eta_i=v_i^25.                                             (4.1)

All arrays are in `data/equivariant.npz` and its portable JSON counterpart. Indices into the original 35 c coordinates are

    11,12,13,14,15,16,17,18,23,24,25,26,27,28,29.

The nine s coordinates are indices 0,...,8. Nonzero row selections in the original reduced tensors are recorded in the same file. Rows omitted by the selection vanish identically on the invariant sector, not merely at tested points.

### 4.1 Reconstruction and exact infinity conditions

For embedded vectors c_full in k^35 and s_full in k^16, the full tensors recover

    (g0,q0) = sum_j eta_j lower_recovery[j] c_full,
    t0 = sum_ij v_i eta_j t_recovery_c[i,j] c_full
         + sum_j eta_j t_recovery_s[j] s_full.

These are coefficient vectors in the ordered L_d bases. Substitution in the supplied formulas gives

    a=(ef)_+ + alpha;                 p=a-ef;
    chi=e g0;                        q'=q0+chi_+;
    B*=E g0+V f;                     h=-(B*)_+;
    A*=-eh+E(q0-chi_-)+V p;           r=-(A*)_+;
    n=s0+(vf)_+;                     n_V=s0-(vf)_-;
    n_a=t0+(v g0)_+;
    N*=-vh+E(t0-(v g0)_-)+V n_V;      n_b=-(N*)_+,

where E=e^25 and V=sum eta_j (y^2 x^{j-6})^25. The matrix is H=[[n,n_a,n_b],[a,q',r],[f,g0,h]]. The complete residual vector has lengths 152,163,159 as in the question. Hence zero reduced residuals, followed by these reversible recoveries, give all original infinity checks.

The point-evaluation arrays reconstruct every H entry at ([5],[14]). The file `src/core.py` implements both the direct Laurent formulas and independent tensor evaluation.

### 4.2 What was verified coefficient by coefficient

`src/check_tensors.py` treats v and eta as independent coefficient variables. For each of six source indices, fifteen c basis vectors, and six target indices it checks the mixed contribution directly: 540 tests. Another 54 tests check the six source indices and nine s basis vectors. The checks verify the eliminated equations, all residual tensors, all recovered evaluation entries, and the character pattern. The constant left inverses and annihilators are also verified during rebuilding.

These 594 checks cover every coefficient of the relevant linear and bilinear expressions. They establish identities over any coefficient extension; they are not a finite-field sample offered as a geometric proof. The log is `logs/tensor_checks.log`.

## 5. Strong necessary ranks, valid over the full algebraic closure

### Proposition 5.1

At every stable strict second return,

    rank T(v)=14,       rank Q(v)=9.                           (5.1)

The invariant full Hom matrix has rank 23, and the complete 123-by-51 Hom matrix has rank 50.

### Proof

The invariant kernel of T(eta) parametrizes invariant maps F^{2*}R_v -> K. The quotient R_v -> K is invariant for the induced linearization. Composing it with an invariant return gives a nonzero invariant map. But a return identifies the entire quotient Hom space with Hom(R_v,K), which has dimension one by the supplied input. Thus ker T(eta) has dimension exactly one, or rank 14.

The kernel of Q(eta) parametrizes invariant maps F^{2*}R_v -> O_X(-O), as can be seen by setting c=0 in the reversible construction. At a return these are maps from the semistable degree-zero bundle R_v to a negative line, so the kernel is zero by Section 2.3. Thus rank Q(eta)=9.

Because the tensor coefficients are fixed by the 25th-power map,

    T(v^25)=T(v)^{[25]},       Q(v^25)=Q(v)^{[25]}.

Frobenius preserves ranks over k, proving (5.1). This rank identity does not permit replacement of v^25 by v in C(v,v^25) or in the recovered return matrix. Finally a stable return has a one-dimensional entire Hom space, proving the two full-matrix ranks. QED.

Consequently all stable points with rank T different from 14, or rank Q less than 9, are excluded geometrically. This is stronger than merely testing whether the quotient has a nonzero map. Even rank T=14 and rank Q=9 are **not** sufficient for return: lifting and determinant conditions remain.

## 6. A parameter-only description of the residual determinant-one locus

Let U be the stable locus intersected with {rank T(v)=14, rank Q(v)=9}. Every possible return lies in U. The supplied scroll exclusion can additionally be used; no classification of all Frobenius destabilizations is presumed.

The following formulas give an exact finite open cover of the remaining problem, with no free morphism coefficients except the scalar used to normalize the determinant.

### 6.1 The quotient kernel: nine equations

Choose fourteen rows I of T and fourteen columns J. Let k be the missing column, A=T(v)_{I,J}, and Delta=det A. Work where Delta is nonzero. Define the fifteen-component polynomial vector kappa by

    kappa_k=Delta,
    kappa_J=-adj(A) T(v)_{I,k}.                               (6.1)

Every entry is homogeneous of degree 14. The chosen fourteen rows annihilate kappa identically. The remaining **nine** rows give

    T(v)_ell kappa(v)=0,    ell not in I.                     (6.2)

These equations have degree 15 and, on Delta!=0, are exactly the rank-14 condition. The actual source quotient kernel is spanned by c0=kappa(v)^{[25]}, not by kappa(v) with unchanged coordinates.

### 6.2 Lifting the quotient: five further equations

Choose nine rows L of Q, and write

    delta=det Q(v)_L,
    G=C(v,v^25) kappa(v)^{[25]},
    z=-adj(Q(v)_L)^{[25]} G_L.                               (6.3)

On delta!=0 the lower top-row equations determine s uniquely. A denominator-free representative is

    c'=delta^25 kappa(v)^{[25]},       s'=z.                   (6.4)

The nine rows L of the top residual vanish identically. The remaining **five** equations are

    (Q(v^25) z + delta^25 G)_ell=0,    ell not in L.           (6.5)

Before choosing an affine projective chart, these are homogeneous of degree 601: kappa^25 has degree 350, G has degree 376, z has degree 576, and delta^25 has degree 225.

Equations (6.2) only describe quotient incidence. Equations (6.5) are the additional exact lifting conditions to the original R_v. Neither set alone establishes invertibility.

### 6.3 The indispensable determinant

Embed c',s' into the full coordinate spaces, recover H as in Section 4.1, and set

    D(v)=det H_U([5],[14]).                                  (6.6)

The entries have homogeneous degrees

    [[576,601,601],
     [575,600,600],
     [575,600,600]],

so D is homogeneous of degree 1776, or is the zero polynomial. These degree statements concern this deliberately denominator-free representative and are not claims of minimal possible degrees.

On the stable open with Delta delta !=0, equations (6.2) and (6.5), together with **D(v)!=0**, are equivalent to a strict second return. All infinity conditions have been included by reconstruction; both determinant lines are trivial, so this nonzero fiber determinant is a globally nonzero constant. To obtain determinant exactly one, add a scalar a and the equation

    a^3 D(v)=1,                                               (6.7)

then multiply H by a. Conversely every return occurs on one of these minor opens, since both required ranks hold. The one-dimensional quotient kernel and injectivity of Q show that every invariant lift is scalar-proportional to this representative. This proves both directions, without assuming semistability of the source in advance.

Taking all choices of I,J,L and all six projective charts covers every geometric possibility. The degree bounds and formula construction are proved; no expanded degree-1776 determinant or saturation of all these opens was computed.

At stable returns the determinant-one choices form a mu_3 torsor over the parameter locus: the automorphisms are scalars and characteristic 5 does not divide 3. Combined with the supplied fixed-locus result, this explains the finite reduced structure, but gives no count.

## 7. Exhaustive exclusion over F25

`src/scan_f25.py` enumerates canonical representatives with first nonzero coordinate equal to 1. The disjoint chart counts are:

| First nonzero coordinate | Number of parameters | rank(T)<15 |
|---|---:|---:|
| v0 | 9,765,625 | 651 |
| v1 | 390,625 | 26 |
| v2 | 15,625 | 0 |
| v3 | 625 | 0 |
| v4 | 25 | 0 |
| v5 | 1 | 0 |
| Total | **10,172,526** | **677** |

The rank-pair distribution at the 677 exceptional parameters is:

| rank T | rank Q | Count |
|---:|---:|---:|
| 10 | 5 | 26 |
| 10 | 6 | 2 |
| 13 | 7 | 648 |
| 14 | 8 | 1 |

The other 10,171,849 parameters have rank T=15. Thus no F25 parameter satisfies both necessary ranks in (5.1). Every stable F25 parameter is excluded.

All 676 points with rank T<14 lie on the displayed first-Frobenius scroll. The one rank-14 point lies outside it. Scroll membership is checked by applying M^{-1} and testing the six 2-by-2 minors of

    [[z0,z1,z3,z4],
     [z1,z2,z4,z5]].

The actual enumeration log is `logs/f25_scan.log`; all exceptional coordinates are retained in `data/f25_scan.json`. The audit in `src/certify_scan.py` recomputes both ranks at every exceptional point using the separate full rref routine and compares the fast rank routine at 2,000 additional seeded parameters. Re-executing the scan, not just checking the hit list, is included in the default verification entry point.

Linear-system dimensions commute with coefficient extension. Therefore this conclusion excludes isomorphisms over k at F25-rational parameter points, even if their matrix coefficients would not lie in F25. It does **not** exclude parameters defined only over F625 or any other larger field. No geometric conclusion is inferred from finite-field point counts alone.

## 8. An additional stable point outside the scroll

The unique invariant quotient rank-14 point in the enumeration is

    v_star=(1,[10],[15],[16],[5],[8]).

(The entries in machine files are all integer field codes, including the initial 1.) Its certified properties are:

    rank invariant T = 14;      rank full quotient T = 34;
    rank invariant Q = 8;       rank full negative-line Q = 15;
    dim full Hom(F^{2*}R_v,R_v) = 2.

### 8.1 Geometric stability and failure of scroll membership

On v0=1, the exact polynomial gcd

    gcd(P, b_i-v_i b_0 for i=0,...,5)=1

proves that v_star is not any b(r), even for roots r in arbitrary extensions. Thus it is geometrically stable under the supplied classification. The six scroll minors do not all vanish. Both statements are checked in `src/certify_point.py`.

### 8.2 A negative-line map and the full Hom basis

One basis vector has c=0. Its n=s0 polynomial has ascending coefficient row

    (11,24,1,19,12,2,19,18,1).

It gives a nonzero map F^{2*}R_v -> O_X(-O); after inclusion in R_v, the recovered matrix has only the first row nonzero. The second basis vector has a nonzero quotient block. The archive records both complete 51-coordinate vectors, all six free polynomials, and all nine recovered Laurent-polynomial matrix entries in `certificates/additional_point.json`.

For each basis matrix every one of the original 474 residual coefficients is checked to vanish. The two vectors are independent and the complete 123-by-51 matrix has kernel dimension two, so there are no omitted Hom maps in other characters.

### 8.3 Every map is singular, including over coefficient extensions

Let the two recovered matrices be H0,H1. The computation expands the four global Laurent determinants

    det H0, det H1, det(H0+H1), det(H0+2H1)

and obtains zero for all four. A homogeneous binary cubic is determined by these four tests in characteristic 5: after the pure cubes vanish, the mixed coefficients satisfy the invertible linear system with rows (1,1) and (2,4). Therefore det(a H0+b H1) is identically zero for all a,b in k.

This is a direct determinant certificate, separate from the simpler stability/simplicity obstruction. It is not a return witness. The nonzero negative-line map also proves that F^{2*}R_v is not semistable; Section 2.4 excludes every positive strict period.

In particular, the quotient-incidence support really is larger than the stated scroll. Moreover the first fixed-target line tests vanish at this point by the supplied scroll classification, while the second negative-line test does not. No conclusion about all other possible first-Frobenius destabilizations is asserted.

## 9. Exact ideals for the excluded points on every chart

To make the stability exclusion independently usable, `src/stability_charts.py` computes its affine ideal on each v_j=1 chart without approximating roots.

Let d_j=gcd(P,b_j), P_j=P/d_j, and A_j=F25[x]/(P_j). Since P is squarefree, A_j is finite etale. In A_j, b_j is invertible. The chart coordinate v_i is mapped to b_i/b_j for i!=j. The resulting algebra homomorphism from a polynomial ring in five variables is onto; this is certified by an explicit full-rank basis of images. Its kernel is the ideal of all excluded geometric points on the chart.

A graded-lexicographic monomial enumeration finds independent image monomials. Each dependent monomial gives a polynomial relation. The generated leading ideal has exactly the recorded standard monomials; they form a full-rank basis of A_j. These facts prove equality with the kernel: the polynomial quotient is spanned by at most dim A_j standard monomials and maps onto the dim A_j-dimensional algebra with independent images. There are no additional components or missing extension-field points.

Every chart has 16 recorded generators of degree at most three. The numbers of excluded points are respectively 10,9,10,10,9,10. All data, basis matrices, and coordinate images are in `data/stability_charts.json`. The generator vanishing and standard-monomial checks are actually executed.

For any chart parameter, stability is exactly the condition that at least one of these 16 generators is nonzero.

## 10. Ninety-six exact residual systems, generated but not solved

`src/export_system.py` emits an exact Singular system for a chosen chart j and a chosen nonzero stability generator f. The 6 times 16 choices cover the stable geometric locus.

Each system has 35 variables: five target coordinates, five separate source coordinates, fifteen c variables, nine s variables, and one inverse variable z. The equations are:

1. eta_i-v_i^25=0 for the five unfixed source coordinates;
2. all 37 equations from (4.1);
3. det H_U(P_star)-1=0, using the full recovered matrix;
4. z f(v)-1=0, removing the strictly semistable points on this stability open.

The ground field declaration is F25 with its specified quadratic minimal polynomial. The variables are not constrained to finite-field values. The determinant entries are kept as explicit intermediate polynomials. The only exponent-25 equations on the parameter variables link source and target; there are no equations v_i^25-v_i.

This is a complete invertible-return problem, not the quotient-incidence ideal. An invariant stable return appears in at least one system, and every solution of a system reconstructs a stable globally invertible strict return. Proving all 96 ideals to be unit ideals would decide the original problem negatively. A proper ideal would require extracting an exact geometric point and verifying its recovered matrix before reporting a positive witness.

`generators/example_chart0_open0.sing` was generated and its regeneration is verified. **No Singular standard-basis calculation was run.** The remaining 95 systems are obtained by the same executable generator; their creation does not constitute an emptiness certificate. Singular is not installed in the execution environment.

## 11. Bounded approaches that did not decide the problem

We tested constant chain maps Q(v)A=B T(v); their vector space is zero. Allowing A and B to be linear in v gives a 207-dimensional space of A matrices, but all are the trivial maps A(v)=D T(v) with D a constant 9-by-23 matrix. They vanish on ker T and yield no injection of quotient kernels into negative-line kernels. The dimensions and span equality are checked exactly; see `certificates/chain_map_attempt.json` and the three chain-map scripts.

These bounded calculations do not prove that all quotient support lies in the negative-line locus, nor that the open U of Section 6 is empty. No higher-degree chain-map conclusion is claimed.

The earlier 841-generator module calculation, stopped saturations, and bounded membership attempts mentioned in the question were not rerun or used as theorems. The explicit point of Section 8 independently rules out the simpler proposed containment in the first scroll.

## 12. Verification, scope, and remaining work

Tested software: Python 3.13.5, NumPy 2.3.5, Numba 0.65.1. Only these Python dependencies are required for the executed verification. The exact environment record and logs are under `logs/`.

The full recorded run rebuilds the upstream tensors, checks entry-for-entry equality, repeats the invariant reduction and 594 coefficient tests, regenerates the stability ideals, reconstructs both matrices at v_star, repeats the exhaustive F25 scan, verifies its exceptional-point certificate, and repeats the bounded chain-map calculations. Portable JSON arrays are compared to the NPZ arrays. Verification runs in a temporary copy so that it does not rewrite the archived evidence.

The final archive manifest covers every file except the manifest itself. The detailed run took place before the final documentation and manifest were frozen, using the documented verifier with its internal manifest-skip switch. This skips only the not-yet-created packaging manifest; it does not skip any arithmetic, reconstruction, or exhaustive scan.

What remains unproved is emptiness or nonemptiness of the determinant-nonzero locus in Section 6 over k, equivalently solvability of at least one of the 96 systems in Section 10. In particular, this archive contains no geometric saturation certificate, no expanded global Nullstellensatz identity, and no stable return matrix. The finite reducedness supplied in the question does not close that gap. The reusable outcome is a smaller exact geometric problem, a complete F25 exclusion, and an additional certified stable false positive outside the original scroll.

