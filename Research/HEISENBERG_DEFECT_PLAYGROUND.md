# Actual first nonabelian five-covers of the bad doubles

Research continuation,2026-09-11. The general Heisenberg lower bound25
is canonical/audited as augmentation_width_defect. The explicit
construction and three pilot ranks have focused independent audit PASS.
Both complete fixed-pair censuses have now passed independent full-rank
and coverage replay; final completion report is being written.
No common-cover exclusion is asserted.

## 1. Global UT3 Lang construction

Let D be one of the twelve ordinary genus-three backup bad doubles.
Use its actual biquadratic Laurent model kappa²=R(u),ell²=S(u),v=kappa*ell.
The two affine charts are U=D minus infinity and O=D minus the fiber u=0.
Their overlap admits finite Laurent polynomials in u with components
1,kappa,ell,v. The exact H1(O_D) basis is v/u,v/u²,ell/u; the exact
H1(T_D) basis is v/u,v/u²,v/u³,ell/u,kappa/u,ell/u².

For R of degree one or two, the infinity bounds are identical after
rounding integral u-exponents. Actual pole orders are
(0,deg R,deg S,5); the tangent frame eta=du/v has order two.
This is a two-affine calculation, not just a formal-infinity heuristic.

Choose an actual F5-plane of Artin--Schreier classes with representatives
chi1,chi2, and a complementary fixed class chi3. Write

    chi_i^5-chi_i=f_i,U-f_i,O,

by exact affine/infinity splitting. Both cohomology components vanish.

For the Heisenberg group H=UT3(F5), use triple multiplication
(a,b,c)(d,e,f)=(a+d,b+e,c+f+ae). The Lang equation F(W)=F_U W reads

    w1^5-w1=f1,U,
    w2^5-w2=f2,U,
    w3^5-w3=f1,U*w2+f3,U.

On the overlap set

    w1,O=w1,U-chi1,
    w2,O=w2,U-chi2,
    w3,O=w3,U-chi1*w2,U+kappa0.

The necessary scalar identity is

    f3,O=f3,U+(kappa0^5-kappa0)-chi1^5*f2,U+f1,O*chi2.   (1)

Let C=-chi1^5*f2,U+f1,O*chi2. Solve on H1(O_D)

    (F-1)[kappa0]=-[C].

The program solves the actual finite-field Lang linear system, not a
guessed central class. Then C+wp(kappa0) splits as affine+infinity;
take f3,U to be minus its affine part and f3,O its infinity part.
This proves(1) as an exact Laurent-polynomial identity.

Both affine algebras are finite etale: the triangular Jacobian in the
three w-variables has unit diagonal -1. The gluing is an invertible
UT3 translation satisfying(1), hence gives a global degree125 torsor
over the original smooth projective D. Its abelian quotient is the
connected C5² cover supplied by chi1,chi2. A subgroup of H surjecting
onto H/Z contains a nonzero commutator and thus the whole center;
therefore the torsor is connected, with group H and genus251.

All five central choices kappa0+j chi3,j in F5, are included. Given a
fixed abelian plane and chosen quotient basis, two lifts differ by an
H1_et(D,F5) character. Automorphisms of H inducing the identity on H/Z
change it precisely by the span of chi1,chi2. Thus there are exactly
five cover classes above each plane and31*5=155 in total. This is a
classification of actual H-Galois covers of the fixed D up to D-isomorphism;
no prime-to-five covers or non-Galois point stabilizers are included.

## 2. Actual Hodge matrices

The actual map before cohomology is Psi(f)=A*f^5 in the eta^-1 frame,
with A reconstructed from the given active datum. This is the already
verified multiplier, not a matrix fitted from base ranks.

The monomials w1^i w2^j w3^l,0<=i,j,l<5, ordered by i+j+2l,
have unipotent triangular gluing. The term -chi1*w2 in w3,O lowers
this weight. Reducing w2^5=w2+f2,U also lowers it. Since all graded
tangent lines have H0=0, their six base cohomology classes give all
750 actual tangent classes. Descending triangular Cech reduction is
exact and has no Laurent truncation parameter.

The algorithm computes selected Hodge columns in this basis and
the full deck generator h:(w1,w2,w3)->(w1,w2+1,w3+w1). The other two
generators g:(w1+1,w2,w3) and c:(w1,w2,w3+1) have constant binomial
cohomology matrices. The full750 deck relation gh=c hg and h^5=1
are independently checked on every basis vector after reduction.

## 3. Six-column acceleration

Put omega=w1^4*w2^4*w3^4. Summing over c,then b,then a gives

    sum_(g in H) g*omega=-1.

Consequently the six classes b_i*omega have norms -b_i. The actual
tangent cohomology is free of rank6 over k[H]. Norm identifies its
coinvariants and invariants; these six norms are a base basis. Nakayama
therefore proves that the six classes are an actual free module basis.

Compute ONLY their six Hodge images. Deck equivariance gives the images
of all125*6 basis vectors by applying (g-1)^i(h-1)^j(c-1)^l. The ordered
group-algebra monomials form a basis even though the group is nonabelian.
The coefficient Frobenius fixes these abstract deck operators, so this
is valid for the linearized Hodge map as well. No source750-matrix
inverse is needed; sparse elimination ranks the750 image vectors.

## 4. Executed first case and measured cost

Case0 is branch datum source4/twist7 of the canonical backup table.
Plane0 is the original base plane; central choice0 is the program's
specified Lang representative, retained explicitly in the JSON files.

* Actual torsor and Lang setup:0.65s.
* Eight highest-weight direct Hodge columns:58.66s; the needed six
  top columns take43.2s. This is a deliberately expensive-column pilot.
* Full750 deck columns:30.61s, including setup.
* All750 group-relation checks and full750-image rank:2.08s.
* Complete Hodge rank713, hence defect37.

Scripts:
`scripts/backup_heisenberg_defect.py`,
`scripts/rank_heisenberg_free_columns.py`.
Receipts:
`Research/computations/heisenberg125_pilot_high.json`,
`Research/computations/heisenberg125_deck_full_case0_plane0.json`,
`Research/computations/heisenberg125_rank_case0_plane0.json`.

Two contrasting cases are now complete as well: case0/plane1/central0
has rank721, defect29; mixed A1 case2/plane0/central0 also has rank721,
defect29. Their full750 deck relations passed. Measured total cost is
about75--85seconds per cover before the degree12 optimization. All three
ranks now have independent geometric/computational audit PASS. They are
not a census or a uniform formula.
The code retains every local cover equation, field embedding and matrix
coefficient in heisenberg125_{hodge,deck,rank}_case*_plane*.json.

## 5. Next optimization

Coefficient125-Frobenius fixes D and its active datum and permutes the
155covers, so defects are constant on those actual cover orbits. It
acts on the already computed three-dimensional AS space. The central
coordinate must ALSO be transported; merely quotienting31planes is
not enough to quotient155covers. In ordinary central coordinates,
an abelian basis change M=[[a,b],[c,d]] acts by

    w3 -> det(M)w3+(ac/2)w1²+(bd/2)w2²+bc*w1*w2.

In logarithmic coordinates z=w3-w1*w2/2 the transformation is simply
z->det(M)z. The displayed formula is not a formula for z.

Use this exact UT3 automorphism and Cech cohomology to match Frobenius
conjugates, retaining the central character modulo the actual plane.
Script scripts/heisenberg_frobenius_orbits.py has completed this exact
transport on every central character. Independent audit of all310
transports, both affine charts and the31planes gives51orbits for case0
and42for case2. Burnside independently gives these counts. The residual
cohomology classes are Frobenius-fixed and matched modulo the target
plane. These audited reductions are used in the current full censuses.

Parity shows the canonical central Lang primitive is zero in all cases:
the error is even for the hyperelliptic involution while H1(O_D) is odd.
All actual coefficients therefore lie in F_(5^12), not F_(5^60).
Independent root-based field transport checks all1187Hodge and10471deck
coefficients from the earlier large-field pilots. Runtime is16--100s
per cover; nonzero central characters are slower than the initial pilot.

## 6. Complete fixed-pair result

Case0: all51Frobeniusorbits/all155covers complete in3593.36seconds;
the five covers above the ORIGINALbaseplane have defect37, all150others29.
Case2: all42orbits/all155covers complete in3031.82seconds, everydefect29.
No failed jobs. Directories
DATA/heisenberg125-census-20260911/case0 andcase2 contain each full
cover equation, six Hodge columns,750deckcolumns, rankreceipt andhashes.

Independent completion audit /root/audit_actual_heisenberg_defect:
all93densefullranks and279artifacts checked, both exactFrobeniuscover
tables and every label/link/equation checked. Case0highplane was matched
to the original base geometrically, not just byitsstoredBoolean.
OneCPUreplays215.52s+270.30s. Finalreport complete/PASS at10:43:
Research/audits/HEISENBERG_CENSUS_COMPLETION_AUDIT_2026_09_11.md.
Canonical theorem backup_heisenberg_defects now records this scope.
Scope remains these TWO fixed active pairs. No all12/generic claim.

## 7. A tested boundary to a formal shortcut

scripts/test_heisenberg_higher_terms.py works only in the actual
group algebra k[UT3(F5)], NOT on geometric Hodge operators. Set
X=log(g),Y=log(h),Z=log(c), with the finite degree4logarithms.
Under the genuine inverse anti-involution, X*,Y*,Z*=-X,-Y,-Z.

The self-adjoint elements X²+Y² and X²+Y²+Z² have the SAME abelianized
germ and colengths31and29, respectively. Likewise X²+Y⁴ has colength37
while X²+Y⁴+YZ has colength44. Z is central, so YZ is self-adjoint;
these too have the same abelianized germ. All four ranks were executed
exactly, along with276relatedtests,0.15safterstartup.

Thus the abelian A1/A3 germ and scalar adjoint symmetry alone do not
determine Heisenberg defect. This rejects only that algebraic shortcut,
not any of the geometric census results. The observed actual29/37
pattern needs an additional geometric constraint before generalization.
