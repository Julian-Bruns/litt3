# Actual neutral degree-five covers with source-only first Witt repair

Version1,2026-09-11. Independent geometric and exact-matrix audit PASS
by /root/audit_backup_cored_completion. Prose/computation, not Lean.

Let (C,r) be the explicit F625 pair of
[the nonzero endpoint obstruction](Thm_explicit_genus_two_witt_obstruction.md):

    t^4+4t^3+t²+4t+3=0,
    C:v²=u(u-1)(u-2)(u-3)(u-t), h0=4t+3,
    Psi(f)=A f^5 before cohomology,
    A=(u-t)(u-h0)²/(4+4t), epsilon_C=(4+4t)^(-1)!=0.

Retain its canonical marked C2 and full original previous-flow data,
including the actual flat square-trivial periodicity line. For each
unordered pair in {0,1,2,3,t,infinity}, let R be the product of its
finite linear factors, S=F/R, and let

    D:kappa²=R, ell²=S, v=kappa*ell.

The elliptic Prym E:ell²=S is ordinary. Its unique geometric connected
cyclic-five cover, pulled back to D, gives an actual connected cover
W→C with group D10. If tau is the involution inducing
(kappa,ell)→(-kappa,-ell), the actual quotient

    T=W/<tau> → C

is finite etale, non-Galois of degree five, with genus(T)=6 and
genus(W)=11. These give the fifteen geometric D10-monodromy degree-five
covers of C, distinguished by their quadratic resolvents.

Their actual indigenous defects are:

| Quadratic resolvent | Number | d_C | d_D | d_W | d_T |
| --- | ---: | ---: | ---: | ---: | ---: |
| R other than u-t | 14 | 1 | 1 | 2 | 1 |
| R=u-t | 1 | 1 | 2 | 8 | 4 |

Thus fourteen actual non-Galois degree-five covers are defect-neutral,
while their individual Galois closures are not neutral.

For ALL FIFTEEN covers, the pulled-back canonical T2 has some compatible
marked W3 extension T3. No such extension admits an extension of the
ORIGINAL map T2→C2 to ANY marked C3 above this C2. This is source-only
Hodge repair, not repair of the diagram.

The semilinear Fitting types distinguish this example from the earlier
simple-zero descent theorems. For each of the fourteen neutral covers:

| Curve | Bijective dimension | Nilpotent block lengths |
| --- | ---: | --- |
| C | 1 | 2 |
| D | 4 | 2 |
| W | 20 | 4,6 |
| T | 9 | 6 |

In particular defect one means a one-dimensional kernel, not a
one-dimensional Fitting nilpotent subspace. The cyclic closure's
obstruction module R5/(e²) is another, different invariant.

No compatible W4 extension or full compatible tower is asserted. These
are not counterexamples to non-Galois full-tower descent (N5), and no
second endpoint or common cover of the fixed main/backup pairs is built.

[Proof and certificates](../Solutions/Sol_explicit_non_galois_neutral_five.md) ·
[Focused audit](../Research/audits/EXPLICIT_NON_GALOIS_NEUTRAL_FIVE_AUDIT_2026_09_11.md).
