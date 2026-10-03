# Unequal toric actual formal-change transport: independent review

The Deformations owner read the complete three frozen root modules
`SeriesUnequalFrobeniusUnitInvariance`, `UnequalToricFormalType` and
`OriginalToricFormalTypeClosedLengths` on 3 October 2026.
Verdict: **PASS at every exact stated scope**. The inverse lower-unit
argument, original unequal quotient, positive-sign composition, closed
formulas and cutoff-one boundary were checked directly. No scope defect
was found.

The genuine original toric basis and length are accepted unchanged in
`toric_hypersurface_basis_independent_review.md`. The earlier actual balanced
formal-type and sign-involution bridge is accepted unchanged in
`original_toric_formal_type_independent_review.md`. Their scoped notes were
read; this review does not repeat those settled mathematical arguments.

## Whole original ideal and its true inverse

For any prime-characteristic field K, positive arbitrary integer cutoffs
q_i<=Q=p^n and an actual formal-series ring automorphism e, the new
invariance theorem permits each lower coordinate to satisfy
e(X_i)=u_i X_i with a genuine series unit u_i. Coordinates with cutoff Q
are unrestricted. The units may be arbitrary actual full-series units;
they are not silently restricted to constants.

The forward inclusion checks each ORIGINAL variable-power generator.
For a largest coordinate, the actual e(X_i) has zero constant coefficient.
Its actual finite projection lies in the whole augmentation ideal, whose
Qth powers vanish by the settled Frobenius theorem and the ORIGINAL
generator cutoffs. For a lower coordinate, the actual unit-times-X_i
equation gives its original power as u_i^(q_i) X_i^(q_i), which lies in
the SAME original ideal. The proof establishes inclusion of the whole
ideal, rather than only generator-image equations.

The inverse condition is derived from the true original e. Applying
e^-1 to e(X_i)=u_i X_i gives
X_i=v_i e^-1(X_i), v_i=e^-1(u_i), with v_i constructed as the actual
mapped unit. Multiplying only the right-hand product by v_i^-1 yields
e^-1(X_i)=v_i^-1 X_i. The proof's explicit cancellation and `congrArg`
replace the product v_i e^-1(X_i) by X_i on the correct side; no guessed
inverse-coordinate formula or global substitution of X_i is used.
The forward theorem applied to e^-1 gives I.map(e^-1)<=I. Mapping this
inclusion by e and using e composed with e^-1 equal to the identity gives
I<=I.map(e). Together these prove equality of the WHOLE actual ideal.

When Q=1, positivity and q_i<=Q force every cutoff to be one. Thus the
lower-coordinate premise is empty, and the same proof preserves the
original augmentation ideal. The theorem needs no prime-power assumption
on the smaller q_i.

## Exact original quotient transport

The unequal theorem retains an actual K-algebra automorphism e, an
arbitrary ORIGINAL f and a genuine original unit u, with the full literal
equation e(f)=u(xy-z^s). Its source quotient remains
K[[x,y,z]]/(f,x^Q,y^Q,z^T), Q=p^n, 0<T<=Q, s>0.
Only when T!=Q does it require e(z)=v z for an actual series unit v.
The two largest coordinates remain unrestricted. The proof derives the
full generic lower-coordinate condition: a coordinate whose cutoff
differs from Q must be precisely the original third coordinate.
For T=Q, including Q=T=1, no lower-unit condition is imposed.

Original ideal invariance is derived by the new theorem. The settled
actual unit/normal-equation quotient equivalence then retains the entire
ORIGINAL f and every power relation. The literal toric ideal is proved
equal to exactly the power ideal joined with the span of xy-z^s. The
actual toric series basis therefore gives
T+2 sum_(j=1)^(Q-1) min(T,sj) for the original source quotient.
No quotient rank, length or assumed ideal invariance is a premise.

For e(f)=u(xy+z^s), the proof composes the genuine sign involution AFTER e.
It changes x to -x and fixes y,z. The new equation unit is exactly
-sign(u). The new lower-coordinate unit is the actual mapped original
v: sign(e(z))=sign(v)z because sign(z)=z. Both the whole equation and
the lower-coordinate condition survive this actual composition.

## Closed original-f consequences and source boundary

For s>=2 the final wrapper proves the exact original quotient formula
2QT-s(T/s)^2-(T%s)(2(T/s)+1). It compares the proved original-source sum
with the proved literal toric sum and then uses its actual closed length;
the quotient being measured does not change to an abstract rank input.
The balanced p=5 wrappers retain the actual original f, e and unit in
the positive-sign convention and give (3Q^2-1)/2 and (7Q^2-3)/4 for
Q=5^n and s=2 or 4, including n=0. The source ideal there is the full
original balanced power ideal with every cutoff Q.

These transport statements work in every prime characteristic and do
not need algebraic closure, odd characteristic or p not dividing s,
because the actual pure toric formal change is explicitly supplied.
Its existence from an arbitrary ORIGINAL nondegenerate plane quadratic
and an original residual-series order is a different source theorem and
remains outside this acceptance. No such normal-form existence result,
project length conclusion or abstract replacement algebra is inserted
as an axiom. The archived balanced formal-type clause explicitly assumes
an actual invertible change and unit, so its exact scope is covered.

## Frozen trust evidence

Focused report
[report.json](../../../litt3-computation-data/formalization-20261003/verification/20261003T192237Z/report.json)
builds `Solutions.Deformations.OriginalToricFormalTypeClosedLengths` and
audits 243 transitive Litt3 theorem declarations, only `Classical.choice`,
`Quot.sound`, `propext`. Build and audit return zero, forbidden dependencies
are zero and changed sources are zero. The independent reviewer rehashed
all 42 captured local sources against this report: zero mismatches.
No numerical or settled basis/Weierstrass replay was performed.
Report SHA256:
`457dc57aa4369fa674c6f837f3688b2346696eb5349f25927e2736516ae53ce1`.

| Fully reviewed source, relative to Formalization | SHA256 |
| --- | --- |
| `Solutions/Deformations/SeriesUnequalFrobeniusUnitInvariance.lean` | `54bc46466018de8e1ff3d386ce934f9eaba9858a31deb7a355857ec9491a0cf9` |
| `Solutions/Deformations/UnequalToricFormalType.lean` | `cfc5a1d7676a20948e22ad6fe2c2f9db4d61101b20a094b3f103cb788e1e8ee8` |
| `Solutions/Deformations/OriginalToricFormalTypeClosedLengths.lean` | `2a5f62aec6225cdec521869b7c84dd8c67d9f89926d5ddf8e705ef0c29cafb77` |
