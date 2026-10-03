# Original plane quadratic coordinate transport scope review

3 October2026. Owner whole-source readback of the four new coordinate files. Their focused build and transitive axiom audit passed at the hashes below; root independent readback is requested. The coordinate bridge is complete at its literal original-polynomial scope. Integration with the actual rectangular series equivalence and the two prepared length arguments is owned separately by root and `cartier_spin`.

Exact SHA-256 snapshots:

- `Solutions/Deformations/PlanePolynomialCoordinates.lean`: `784f1a50c67fc401b67494a75499a8c1eefedcfc99ca63554b959ba8f4de65b6`.
- `Solutions/Deformations/PlanePolynomialQuadraticCoefficients.lean`: `9810cd205f1463badf9bd44a23245ab46244f69899cb98b08ab47f0432e71183`.
- `Solutions/Deformations/PlanePolynomialLinearTransport.lean`: `d3c0eeba429445372be5ef9965ae109d02edb2d4dbb025c0bd19404927d30c69`.
- `Solutions/Deformations/OriginalPlaneQuadraticFrames.lean`: `404f6f77af01cfe2c79a3899be2dafe6a3ca286bce29788aadb27e8896cca0fc`.

The first file constructs an actual coefficient-algebra shear on the full original multivariate polynomial ring. Its inverse is the opposite shear, verified on every original variable. In characteristic p, the genuine prime-power identity expands `(x+t y)^(p^n)` as `x^(p^n)+t^(p^n)y^(p^n)`. Thus the equal cutoff on the two changed variables derives forward ideal preservation; applying the same argument to the actual inverse derives equality of the entire original variable-power ideal. All other variables are fixed and every other cutoff is arbitrary. The actual variable swap preserves the whole ideal whenever the two relevant cutoffs agree. The genuine hypersurface quotient equivalence transports the entire equation P to its literal image under the constructed algebra automorphism.

The coefficient file restricts an arbitrary original polynomial to its first two original variables, deriving that every binary coefficient equals the original coefficient with all remaining exponents zero. It proves that every linear homogeneous substitution commutes with every homogeneous component of the full polynomial. The binary quadratic component is then exactly `a x²+b xy+c y²`, with a, b and c the original square, mixed and square coefficients. No support truncation, hypothetical compatible frame or assumed quadratic approximation is supplied.

The linear transport file fixes the remaining variables and derives the exact matrix formulas from the genuine arbitrary-polynomial substitution `x↦u x+v y`, `y↦w x+z y`:
a'=a u²+b u w+c w²,
b'=2a u v+b(u z+v w)+2c w z,
c'=a v²+b v z+c z².
The discriminant convention is exactly `Δ=b²−4ac`; in particular b is the literal xy coefficient. The derived law is `Δ'=(u z−v w)²Δ`. The same homogeneous-component argument preserves every lower bound on total degrees in the support, including the original maximal-square bound. Higher-degree terms remain in the full transported polynomial throughout.

The terminal frame file works over any field of prime characteristic, with an explicit nonzero-two premise only for clearing the mixed coefficient. The two equal original cutoffs are p^n; the lower cutoffs remain arbitrary. The selected frame is the identity when a≠0, the actual swap when c≠0, and the actual shear `y↦y+x` when a=c=0 and b≠0. The latter gives selected square coefficient b. Every branch preserves the original discriminant, support bound, fixed remaining variables and entire original power ideal. The second actual shear `x↦x−b/(2a)y` clears the mixed coefficient after selecting a≠0. It does not remove higher terms from the equation.

`original_plane_quadratic_rank_one_quotient_frame` assumes the literal original equality `b²=4ac` and `a≠0∨c≠0`. It returns a full actual quotient equivalence to the actual transported polynomial with support degrees at least two, nonzero selected x² coefficient, zero xy coefficient and zero y² coefficient. The last vanishing follows from the preserved discriminant and nonzero 4a. `original_plane_quadratic_nondegenerate_quotient_frame` instead assumes the literal original `b²−4ac≠0` and returns the same full quotient equivalence with both square coefficients nonzero and the mixed coefficient zero. No splitting or algebraic closure premise is used. The stronger intermediate `original_plane_quadratic_cleared_frame` exposes the actual automorphism and explicitly proves every remaining original variable fixed.

Verification: `lake build Solutions.Deformations.OriginalPlaneQuadraticFrames` passed without warnings. The final focused report is `../litt3-computation-data/formalization-20261003/verification/20261003T190303Z/report.json`: 107 audited declarations, 14 local dependency source hashes, build and audit return codes zero, only `Classical.choice`, `Quot.sound` and `propext`, no forbidden dependency and no source change during the check. Generated build and axiom evidence remain outside the workspace. The four source files are frozen at the snapshots above for downstream independent readback and final audits.

This bridge alone claims no prepared-hypersurface length, formal Morse theorem for arbitrary series, complete inventory coverage or common-cover existence. The two specific original-source length clauses require their separately checked series/coefficient/preparation compositions. The unmarked common-cover problem remains unsolved.
