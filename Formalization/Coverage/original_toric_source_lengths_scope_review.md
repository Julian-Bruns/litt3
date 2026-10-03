# Direct original toric source lengths: focused scope review

Root read the complete target `OriginalToricFormalTypeLengths.lean` and
solution `OriginalToricFormalTypeSourceLengths.lean`, and compared their
literal inputs and outputs with Version1 of `frobenius_truncated_hypersurfaces`.
The three new endpoints pass at their exact scopes. Their already accepted
toric basis, actual change/unit transport and symbolic arithmetic are reused;
no new normal-form existence assumption is introduced.

`original_balanced_toric_formal_type_length` proves the exact proposition
target for every prime-characteristic field, Q=p^n and s≥2. The target
quantifies the ORIGINAL f and assumes exactly the existence of an ACTUAL
coefficient-algebra automorphism e and unit u with e(f)=u(xy+z^s).
This is the archived balanced clause's own formal-type hypothesis. It
concludes BOTH the sum and floor/remainder formulas for the SAME original
quotient by f and (x^Q,y^Q,z^Q). The finite sum uses j∈Fin(Q−1) and
sj is written s(j+1), so it includes precisely indices one through Q−1.
Its floor expression uses m=Q/s and r=Q mod s. The proof transports the
actual original length, identifies it with the proved literal toric length
and applies the exact symbolic floor theorem. Q=1 is retained. Algebraic
closure, odd characteristic, p∤s, a supplied quotient rank and a separate
ideal-invariance premise are absent.

The two characteristic-five endpoints retain an arbitrary ORIGINAL f,
actual e and u, Q=5^n, R=5^a≤Q and s=2 or 4. Only if R≠Q do they
require e(z)=v z for an actual full-series unit v. They conclude exactly
2QR−(R²+1)/2 and 2QR−(R²+3)/4 for that original quotient. Positivity
of both powers is derived; powers one are included. The true original
equation and all three power relations remain. At R=Q, the lower-unit
condition is empty. The result is complete for a supplied ACTUAL compatible
formal change, and does not claim its construction from nondegenerate
plane rank and critical residual order.

The whole canonical source therefore remains partial for the unequal
relative/tame normal-form existence step. The completed original binary,
rank-one and balanced formal-type clauses are recorded separately in
[the consolidated scope review](frobenius_truncated_hypersurfaces_scope_review.md).

Focused [report.json](../../../litt3-computation-data/formalization-20261003/verification/20261003T193751Z/report.json)
builds the final source endpoint and audits 250 transitive theorem declarations
in 44 captured source files. Build and audit return zero; only
`Classical.choice`, `Quot.sound`, `propext` occur. Forbidden dependencies
and changed sources are zero. Root independently rehashed every captured
source against the report, with zero mismatches. Report SHA256:
`697ab2568487793abe92d48071f6be4ddfb2c4be1f49d511828548665a7df407`.

| Reviewed source relative to Formalization | SHA256 |
| --- | --- |
| `Theorems/Deformations/OriginalToricFormalTypeLengths.lean` | `4bf1c8cba01e0000302cf5eb4586cd6b3e209a5c03f66aeffca884eb86ced688` |
| `Solutions/Deformations/OriginalToricFormalTypeSourceLengths.lean` | `f6d68a46d4040676f2292c15dfafe5b7ccaaffd98a708c807a55a7b42b2aa192` |

The one-variable specialization `OriginalUnequalBinaryTruncation.lean`
was also read: Fin.sum_univ_one and P<Q directly give P−1<Q−1,
so the accepted whole original Part1 applies without another condition.
Focused report `20261003T192711Z` passes 207 transitive declarations and
47 sources, with the same clean trust outcomes. Its source SHA256 is
`573a009d081ad1d9d4ebb8fce4ed9b14c986dc68198c9297feccefc2a6b6cf32`.
Its report SHA256 is
`d31d70a3a4aa171b985e9faddd758e8718ad67e5739d2eeea14265976d7be585`.
