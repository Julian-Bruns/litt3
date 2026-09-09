# Second-height pointed Frobenius audit

Verdict: PASS for the second-height statement of
[pointed_frobenius_dormant_model](../../Theorems/Thm_pointed_frobenius_dormant_model.md),
version2, Sections5--8 of its proof.

Auditor: /root/audit_height2_frobenius_transfer. Date:2026-09-09.
Blocking objections: none. Sections1--4 and the earlier dependency tree
were used as inputs, not independently re-audited. This is a mathematical
prose/code audit with exact replay, not Lean verification.

The checked dictionary uses H1(O(-2O)) with gap representatives
z^-3,z^-1,z. The sixteen square-root torsors give all Pic[2] classes;
their anti-invariant affine module has basis kappa,v/kappa. Its two
pole-order progressions give the stated source and target bases,
including the order-zero gap for nontrivial twists. The formal infinity
lattice is retained. The connecting-map kernels detect height-two
instability: first instability at two supplies omega^13 tau; instability
at one supplies omega^15 tau after pullback and hence a map from
omega^13 tau. Conversely any such map destabilizes after saturation.

The precision margin exceeds every retained exponent, and both parity
blocks are necessary and checked. The three disjoint extension charts
cover the whole projective plane. Exact unit identities against original
minors exclude geometric points over the algebraic closure, rather than
only rational points over F125. A fresh single-process replay with
OPENBLAS_NUM_THREADS=1 and OMP_NUM_THREADS=1 of
`sage scripts/pointed_frobenius_theta_diagnostic.sage --height 2 --all`
completed all48 cases, both blocks, with `excluded:true` in22.1591s.
It agrees with the consolidated22.2516s receipt.

The corrected implicit equation for U is consistent with x=z^2 Ftilde(x).
Its coefficient recursion, square roots, inverses, and monic triangular
reduction preserve the stated T-degree filtration. Matrix entries have
degree at most62. For a c-column block, basepoint-free maximal minors at
alpha admit three basepoint-free linear combinations over the algebraic
closure. Their Koszul complex gives degree-D surjectivity for D=3c-2;
surjectivity descends to F125. A full-row minor of the matrix of all
degree-D multiples is therefore a nonzero polynomial in F5[T], with
degree at most binom(3c,2)c*62 <=597246. Apply this separately to each
block; no product of32 bounds is required. Thus parameter degree greater
than600000 suffices.

No repair is required in the audited new argument. The conclusion is
semistability through the second Frobenius pullback on the stated
parameters, not strong semistability at every height or an exclusion of
actual common covers. The current endpoint's parameter-degree choice is
an inherited application input.
