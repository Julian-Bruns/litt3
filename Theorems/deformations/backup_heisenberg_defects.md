# Exact first Heisenberg defects for two actual backup bad pairs

Version1,2026-09-11. Complete finite geometric census and independent
full-rank/coverage audit PASS. Not Lean verification.

Let alpha³+alpha+1=0 over bar(F5), and
F=u(u-1)(u-2)(u-3)(u-alpha). For each row below let
D:kappa²=R,ell²=F/R,v=kappa*ell, and equip D with the corresponding
actual pulled-back active pair from
[the complete backup table](../genus_two/backup_active_double_germs.md).
The Hodge operator in the (du/v)^(-1) frame is A*f^5, with:

| Pair | R | A |
|---|---|---|
| Branch, case0/source4/twist7 | u(u-3) | (alpha+1)²u(u-1)(u-2)(u-3) |
| Mixed, case2/source4/twist6 | u(u-2) | (3+4alpha+3alpha²)+(1+alpha+2alpha²)u²+(4alpha+3alpha²)u³ |

Put H=UT3(F5), the exponent-five Heisenberg group of order125.
For each of these TWO fixed pairs there are precisely155geometric
isomorphism classes over D of connected finite etale H-Galois covers
T→D. They are indexed by31two-planes in H1_et(D,F5) and five central
characters modulo each plane. Their genera are251.

The indigenous defects of ALL such actual covers are:

| Base pair | Abelian character plane | Number | Defect(T) |
|---|---|---:|---:|
| Branch | Pullback from the ORIGINAL genus-two B | 5 | 37 |
| Branch | Any other plane | 150 | 29 |
| Mixed | Any plane | 155 | 29 |

The result is independent of the central character in this census.
Every further actual finite etale source dominating one of these
covers has at least the corresponding defect, by pullback of the
actual defect-bundle sections.

These exact values do not yet extend to all twelve backup bad pairs,
to the generic parameter, or to the main high-degree parameter.
They do not force arbitrary common sources to dominate these covers,
and do not give a higher-Witt or non-Galois descent assertion.

[Proof and replay](../../Solutions/deformations/backup_heisenberg_defects.md) ·
[Completion audit](../../Research/audits/HEISENBERG_CENSUS_COMPLETION_AUDIT_2026_09_11.md).
