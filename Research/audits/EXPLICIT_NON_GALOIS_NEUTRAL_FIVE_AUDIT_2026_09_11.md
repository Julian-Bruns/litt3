# Actual neutral non-Galois degree-five covers: focused audit

Verdict: PASS for the actual covers, primary Hodge ranks, primary Witt
repair and failure of map-preserving repair. The independently reconstructed
semilinear Fitting ranks also PASS. No fourth-Witt-digit or full-tower
assertion is audited or obtained here.

Auditor: `/root/audit_backup_cored_completion`. Date: 2026-09-11.
This is an independent prose/computation audit, not Lean verification.

## Scope and inherited inputs

The endpoint is the obstructed genus-two laboratory pair over F625, not
either endpoint of the main/backup common-cover problem:

    t^4+4t^3+t^2+4t+3=0,
    C: v^2=F=u(u-1)(u-2)(u-3)(u-t),
    h=4t+3, mu=4+4t, eta=du/v.

The canonical `explicit_genus_two_witt_obstruction` supplies the actual
active-admissible pair, its specified canonical first lift and previous
filtered/graded/twisted input, and

    epsilon_C != 0, <rho_C,phi>=mu^(-1)=3+4t+4t^2+3t^3.

The canonical `etale_p_witt_obstruction`, proof Section 4, supplies the
actual PRE-cohomology Hodge map in the eta^(-1) frame,

    f |-> A f^5,  A=(u-t)(u-h)^2/mu.

Its validity after arbitrary actual etale pullback is essential. This
audit does not infer that formula from a small base matrix or recompute
the higher inverse-Cartier jet comparison. The same canonical result
supplies the cyclic cokernel/norm theorem. The intrinsic obstruction
definition and inherited etale naturality supply the Witt consequence.
Both canonical statements and their prerequisite lists were inspected
through `research_workspace.py`; the currently needed proof was read.

Producer: `scripts/explicit_nonordinary_dihedral5.py`, using
`CurveAlgebra` from `scripts/backup_heisenberg_defect.py`.
Frozen input: `Research/computations/explicit_nonordinary_dihedral5.json`.
The independent implementation imports NEITHER file.

## 1. Actual projective cover geometry

Index the branch points by `(0,1,2,3,t,infinity)`. For each of the fifteen
unordered pairs, let R be the product of its finite branch factors and
S=F/R. The connected etale double has smooth affine model

    D: kappa^2=R, ell^2=S, v=kappa*ell.

R and S are squarefree and coprime; their degrees are (1,4) or (2,3).
The square class R is the nontrivial two-torsion class corresponding to
that pair. At every place of C its valuation is even, including infinity,
so its connected projective normalization is etale over C. These are the
fifteen distinct nonzero classes in J(C)[2], not fifteen sampled points
of an unbounded coefficient search. D has genus 3.

Put H=[u^4]S^2 and choose lambda with H*lambda^4=1. The audit checks
H!=0 for all fifteen pairs in the exact field. With chi=lambda*ell/u,

    chi^5-chi=f_U-f_O,
    f_U=ell*lambda^5*sum_(i>=5) [u^i]S^2*u^(i-5),
    f_O=-ell*lambda^5*sum_(i=0,...,3) [u^i]S^2*u^(i-5).

The u^(-1) coefficient cancels by H*lambda^4=1. The first expression
is regular on the affine chart; the second is regular on the chart
excluding the u=0 fiber, including both infinities. Thus

    w_U^5-w_U=f_U,
    w_O=w_U-chi,  w_O^5-w_O=f_O

are TWO ACTUAL compatible finite etale AS algebras, not merely a formal
principal-parts class. The nonzero class ell/u in H1(D,O_D), multiplied
by lambda, is Frobenius-fixed. Artin-Schreier identifies it with a
nontrivial torsor over the algebraically closed constant field; hence
W is geometrically connected. W->D is cyclic of degree 5 and genus(W)=11.

The double involution lifts on both charts as

    tau:(kappa,ell,w_U) |-> (-kappa,-ell,-w_U).

Indeed chi, f_U and f_O are all anti-invariant, so w_O is negated too.
For sigma(w)=w+1, tau*sigma*tau=sigma^(-1). The ten transformations give
the entire group of W->C, namely D10. Tau is free, since its projection
to D is the free deck involution of the etale double. Therefore

    T=W/<tau> -> C

is an actual connected etale map of degree 5, with genus(T)=6. It is
non-Galois: the reflection subgroup of D10 is not normal. The fifteen
different quadratic resolvents distinguish these degree-five covers.
This does not assert that they are all possible degree-five covers of C.

The receipt works in F_(5^16) to contain all chosen fourth roots lambda.
The audit verifies irreducibility of its modulus, the exact embedded
parameter equation and degree four of t, and every H*lambda^4 equation.
It does not silently regard Frobenius as fixing coefficients outside F5.

## 2. Complete cohomology and an independent exact quotient

At each infinity the pole orders of `(1,kappa,ell,v)` are
`(0,deg R,deg S,5)`. Eta has order 2. Thus the regular tangent coefficient
bounds for `u^j` in these four components are respectively

    j<=-1, j<=-2, j<=-3, j<=-4.

The bounds are the same for both degree patterns. They are simultaneous
bounds at both infinities: equal leading orders are separated by the
biquadratic characters, so cancellation at one infinity cannot hide
a pole at the other. The complement of the affine and infinity modules
therefore has the exact six-element basis

    v/u, v/u^2, v/u^3, ell/u, kappa/u, ell/u^2.

The analogous O_D quotient has basis `(v/u,v/u^2,ell/u)`. This verifies
the nontriviality of chi above. Pulling the tangent line to W and filtering
the AS algebra by w-degree gives five trivial graded line quotients.
Every intermediate tangent bundle has H0=0 by negativity, so the thirty
classes obtained by multiplying the six gaps by w_U^j, 0<=j<=4,
form the COMPLETE tangent H1, not merely a convenient subspace.

The audit reconstructs a finite Laurent cochain window with monomials

    kappa^a ell^b u^i w_U^j,  i>=L+j, i<0, 0<=j<=4.

For L=-20 it has dimension 360. It forms all 330 infinity boundary
columns explicitly by expanding `(w_U-lambda*ell/u)^j`, then globally
row-reduces the resulting boundary matrix. This single quotient projection
differs from the producer's successive component-by-component reduction.
Every boundary projects to zero, and all thirty gap vectors project to
the standard basis. The window is stable under each boundary expansion:
lowering w-degree from j to l lowers the u-exponent by at most j-l;
polynomial reductions by R,S only increase it. Nonnegative u powers
discarded by this construction are actual affine coboundaries.

The actual Hodge image of each gap is independently expanded using

    A*(kappa^a ell^b u^i)^5*(w_U+f_U)^j.

Its coefficient Frobenius and every AS/biquadratic reduction are retained.
All 900 entries per cover agree with the frozen producer: 13,500 exact
entries altogether. Repeating with L=-24 gives 440 cochains and 410
boundaries, with all matrices unchanged. There is no unvalidated Laurent
series truncation. Regularity of the actual Hodge morphism follows also
from the inherited multiplier: A has pole 6, whereas fifth powers of
regular tangent coefficients have vanishing at least 10 at infinity.

Tau acts on `kappa^a ell^b w^j` by `(-1)^(a+b+j)`. Its positive part
has dimension 15. Since 2 is invertible, this is precisely tangent H1
on the actual quotient T. The audit reconstructs both deck matrices,
checks the full D10 relations and Hodge equivariance, and verifies the
entire positive block, not just its dimension.

## 3. Exact defects and primary obstruction transfer

The verified table is:

| Branch-pair cases | Count | d_C | d_D | d_W | d_T | C5-deck cokernel Smith lengths on W |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| All except (t,infinity) | 14 | 1 | 1 | 2 | 1 | [2] |
| Canonical double R=u-t | 1 | 1 | 2 | 8 | 4 | [4,4] |

Smith lengths here refer to the DECK augmentation action on coker(Psi_W)
over k[e]/e^5. They were checked independently from all dimensions of
e^j coker(Psi_W), using ranks of the augmented matrices `[Psi_W,e^j]`.
They are NOT the semilinear Fitting lengths in Section 4.

For every row, the cyclic cokernel has no free length-five summand.
The inherited norm theorem therefore says that W->D kills the ENTIRE
primary obstruction cokernel, including for the exceptional row. Etale
naturality gives epsilon_W=0. Since W->T has degree 2, its cokernel
pullback is injective, hence epsilon_T=0 for ALL FIFTEEN rows.

There is a second direct check: a nonzero representative of the
one-dimensional base cokernel is chosen by exact linear algebra, pulled
to the actual T block, and verified to belong to its Hodge image in
every row. This verifies the zero pullback without identifying an
arbitrary cokernel vector with a higher obstruction on a different pair.
The actual epsilon_C spans that inherited one-dimensional cokernel.

Thus all fifteen pulled-back canonical T2 tuples admit some compatible
W3 lift. Exactly fourteen have d_T=d_C=1, so those are genuine
non-Galois defect-neutral examples.

NONE of these compatible T3 lifts can extend the original T2->C2 to
any marked C3 above the given C2. If one did, naturality BEFORE passage
to cokernels would give `0=rho_T(T3)=h^*rho_C(C3)`. Tangent H1 pullback
along an actual etale cover is injective for every degree: pass to the
individual Galois closure and use Cartan-Leray with negative H0=0.
Thus rho_C(C3)=0, contradicting epsilon_C!=0. The source-only repair is
therefore genuinely distinct from repair of the original map.

## 4. Semilinear iteration: no simple-zero inference

The audit also reconstructs each iterate as the RIGHT-ordered product

    M*M^[5]*M^[25]*...,

using the newly calculated matrix M. This is independently compared
with `analyze_dihedral5_hodge.py`, whose recursion left-multiplies the
Frobenius twist of its accumulated product. All fifteen rows and all
five blocks agree. For each of the fourteen neutral rows:

| Actual block | Ranks from identity to first repeated rank | Nilpotent Fitting lengths |
| --- | --- | --- |
| C | 3,2,1,1 | 2 |
| D | 6,5,4,4 | 2 |
| W | 30,28,26,24,22,21,20,20 | 4,6 |
| T | 15,14,13,12,11,10,9,9 | 6 |
| Tau-negative part | 15,14,13,12,11,11 | 4 |

In particular the base defect/kernel is one-dimensional, but its
nilpotent Fitting part is TWO-dimensional. Any inherited wording
"one-dimensional nilpotent tangent" must be read/corrected to
"one-dimensional kernel/defect" here. The old simple-zero cyclic
descent theorem does NOT apply to these matrices. This is an actual
new distinction, not evidence for or against fourth-digit continuation.

## 5. Replay and limitations

Independent source: `scripts/audit_explicit_nonordinary_dihedral5.py`.
Receipts:

- `Research/computations/explicit_nonordinary_dihedral5_audit.json`;
- `Research/computations/explicit_nonordinary_dihedral5_audit_window24.json`.

Replay from the project root (one CPU):

```sh
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 sage -python scripts/audit_explicit_nonordinary_dihedral5.py Research/computations/explicit_nonordinary_dihedral5.json --output /tmp/dihedral5-audit.json
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 sage -python scripts/audit_explicit_nonordinary_dihedral5.py Research/computations/explicit_nonordinary_dihedral5.json --lower-bound -24 --output /tmp/dihedral5-audit-window24.json
```

The full runs including all semilinear iterates took 8.03 and 8.28 seconds.
The receipts retain input hashes, per-matrix hashes, quotient dimensions,
all defect/Smith/Fitting data and runtime. No producer, canonical-library
or research-state record was edited by this audit.

Recorded SHA256 values:

    producer receipt: e7e2a1c92bd38b68ddec12be5e4a1c6272fe5f8fc296ce9e9e1a868b8ab3cf2f
    audit source: d633539ea91962848fa9eeaac87eb823d99bab36e47c8452666c73c58b9fe6b8
    L=-20 receipt: 16e1cb3902cc3eed8b5061a1da4961c111fa2d5b4212c679ff5f53f6fe89220b
    L=-24 receipt: 548e3736c773c2a0a0017bf38b417ec874f9a89ca41832793b2e32e793ee2305

The conclusion is an actual primary one-step repair at constant defect,
with failure of map-preserving repair. No W4 obstruction, compatible
full tower, neutral-degree-five full-descent counterexample, second
endpoint, or common-cover exclusion is supplied by it.
