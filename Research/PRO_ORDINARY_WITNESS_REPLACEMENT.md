# Can one replace a bad common source while keeping both endpoint pairs?

Please attempt the precise ordinary-witness replacement statement (OW)
below. This is a structural subproblem in Litt's common finite etale cover
problem, not a request to solve that entire problem. The supplied facts
are available as inputs; please spend the work on the replacement step.

## Target (OW)

Work over k=algebraic closure of F5. Let (C,r_C) and (B,r_B) be smooth
projective connected curves of genus at least two with active, admissible,
regular nilpotent projective connections. Suppose BOTH endpoint connections
are ordinary in the indigenous deformation-theoretic sense. Assume

    g(B)=2,             Hom_k(J(C),J(B))=0.

Suppose there exists an ACTUAL span

    C <-f- Z -g-> B,      f^*r_C=g^*r_B,

with both maps finite etale, from the SAME smooth projective connected
source, and f^*k(C) intersect g^*k(B)=k inside k(Z).

Must there exist ANOTHER actual finite etale span

    C <-a- W -b-> B,      a^*r_C=b^*r_B=r_W,

for which r_W is indigenous-ordinary?

The endpoint curves AND their connections are fixed. W is allowed to have
different degrees and different relative embeddings of these endpoint
fields. It need not refine Z, or even have a simultaneous refinement with
Z preserving both legs. No core condition is required of the new witness.
Neither span has a Galois or prime-to-five degree assumption.

This is NOT the stronger claim that every jointly minimal witness is
ordinary. A nonordinary jointly minimal example alone does not disprove
(OW): one must rule out alternative ordinary witnesses for its same
endpoint pairs.

## Exact intended application, if a general statement needs narrowing

The main required case is the following fixed genus-nine C=X. Choose
a in F25 with a^2+4a+2=0, and let X be the smooth projective model of

    y^3=x^10+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3ax^6+4ax^5
        +(3a+4)x^4+ax^3+(3a+3)x^2+(4a+2)x+(2a+1).

Its geometric Jacobian is simple of dimension nine. Take

    B=Y_t: v^2=u(u-1)(u-2)(u-3)(u-t),  [F5(t):F5]>828.

All85 active regular nilpotent connections on this Y_t are admissible
and indigenous-ordinary. Thus Hom(JX,JY_t)=0 automatically. Fix an
ordinary admissible active r_X and one of these r_t. A proof for this
specific X and family is sufficient even if the general formulation fails.
Counterexamples for other curves should be distinguished from this case.

The ordinariness of r_X is a REAL restriction in this request. We do not
assume all connections on X are ordinary. If r_X were nonordinary,
pullback injectivity would make (OW) impossible whenever a witness exists;
that trivial obstruction is deliberately excluded.

## Why a positive answer is immediately useful

The following finite-partner theorem is already proved, including its
source-identification step: for a FIXED ordinary nilpotent pair (C,r_C),
the genus-two partners having SOME ordinary common-source witness form a
finite set, without degree bounds. Mochizuki's canonical lifts identify
the two lifted sources when the shared reduction is ordinary, and
characteristic-zero common-cover partner finiteness then applies.

Therefore (OW) would remove the common-source hypothesis for all ordinary
endpoint pairs in the intended family. Taking a finite union over the
ordinary r_X would eliminate this entire partner branch by finite parameter
avoidance. The separate nonordinary-r_X branch, dormant matches, and
spans without a common connection would remain open. Do not claim a
solution to Litt's problem from (OW).

The precise lifting reference is Mochizuki, A Theory of Ordinary p-adic
Curves, ChapterIII Theorem3.2 and Corollary3.5, printed p.115:
https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf
Corollary3.5 expressly assumes ordinary UPPER reduction. Its statement
and proof have already been checked; ordinary endpoints alone do not
allow us to cite it for the original Z. Do not reprove only the supplied
ordinary-common-source finite-partner theorem.

## Scalar conventions and the exact source defect

In a separating coordinate x a projective connection is z''=r z, with

    r_w=(dx/dw)^2 r_x - {x,w}/2,
    {x,w}=x'''/x'-(3/2)(x''/x')^2.

Regularity is in every local uniformizer, including infinity. Put

    E(r)=r''-3r^2,
    N(r)=-(E')^2-3E(E''+3rE).

Dormant means E=0; nilpotent means N=0; active means N=0 and E!=0.
Admissible means the nonzero p-curvature is nowhere zero, equivalently
the intrinsic quartic s=E(dx)^4/3 has divisor2D with D reduced.
Ordinary means T_r N(C)=0 for the fixed-curve nilpotent scheme. It is
NOT ordinariness of J(C).

For a dormant d, there is a stable rank-two bundle V_d on C^(1), degree
2g(C)-2, whose sections are exactly regular quadratic tensors phi with

    phi''-d phi=0.

It has F_C^*V_d=J^1(omega_C^2) and is compatible with every finite
etale pullback. For active r let pi:C_s->C be its canonical etale double
torsor for O(D) tensor omega_C^(-2), retaining the split torsor when
appropriate. Its tautological quadratic q satisfies q^2=pi^*s, and
d_+=pi^*r+q, d_-=pi^*r-q are dormant. Put

    E_r=pi^(1)_* V_(d_+),     rank4, degree4(g(C)-1).

Then H0(C^(1),E_r)=T_r N(C), functorially for ALL finite etale maps.
Thus the desired witness is exactly one satisfying H0(W^(1),a^*E_rC)=0.
No extra choice of spin or companion is implicit.

## Known failure mechanisms that the replacement must genuinely avoid

1. Ordinary pullback is FALSE even in degree two. For the displayed
   Y_t, five of its85 ordinary active connections each have two nonzero
   two-torsion twists L with h0(E_r tensor L)=1. Their actual etale
   double covers acquire a nonordinary pulled-back connection. The
   other80 have no bad two-torsion twists. Canonical doubles themselves
   are ordinary. Counting ordinary endpoint connections does not answer
   the question.

2. A nonzero tangent section survives every further finite etale pullback.
   More strongly, when the endpoint Jacobians are simple, an actual
   existing two-leg span admits cyclic refinements with arbitrarily large
   endpoint tangent defects, while preserving BOTH maps. Thus refining or taking alternating
   Galois closures cannot cure a bad source. These refinements generally
   cease to be jointly minimal and do not refute replacement by a
   DIFFERENT correspondence.

3. One may first replace any witness by normalization in f^*k(C)g^*k(B).
   All resulting maps are etale and the common connection descends.
   This removes inessential refinements, but does not prove this joint
   normalization ordinary. We have no such theorem.

4. An admissible matched span does lift with both original maps to its
   same canonical marked W2 source even when nonordinary. Nothing
   supplies a W3 or full Witt lift. In fact finite etale refinement
   preserves the ENTIRE simultaneous Artinian deformation problem.
   A higher cover cannot remove a genuine higher lifting obstruction.

Please give a proof of (OW), or an actual counterexample addressing its
existential quantifier over alternative witnesses. A sufficient replacement
construction for all displayed endpoint pairs is equally sufficient.
If undecided, isolate the exact unproved step in the construction you
attempted; avoid returning only another source-dependent dimension bound
or restating the already supplied finite-partner implication. Both actual
maps and global projectivity/etaleness are essential throughout.
