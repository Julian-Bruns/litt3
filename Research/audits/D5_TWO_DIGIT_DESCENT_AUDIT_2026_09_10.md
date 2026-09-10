# D5 two-digit descent audit

Date: 2026-09-10. Auditor: /root/audit_d5_two_digit_descent.
Verdict: PASS for the two compatible-reference scopes below, with root's
explicit local normalization repair; GAPS for full uniform D5 with an
arbitrarily incompatible lower reference. No counterexample.
Scope: the returned argument in [D5_RETURNED_COMPARISON.md](../D5_RETURNED_COMPARISON.md),
against [the complete target and inputs](../PRO_CYCLIC_FIVE_DELAYED_DESCENT_REQUEST.md).
The inherited characteristic-five Fitting calculation, integer carry and
prime-to-five descent theorem were inputs, not re-audited.

## What checks

The free deck-module argument is a real improvement. For the two-affine
Čech complex of the tangent or normal line bundle, H0=0 makes the
differential injective. Projectivity of H1 splits its cokernel. The resulting
deck-linear primitive operator sends exact e²-valued cochains to e²-valued
primitives. This works integrally when H1 is free over R2. The two integral
cohomology modules are free by cohomology/base change, lifting a free
special-fiber basis, and comparing W2-ranks. Cartan--Leray with H0=0 gives
the claimed downstairs/invariant identification; invariants in a free
regular module are its norm image. The two-digit curve deformation torsor
also has the stated square-zero range for n>=2.

If equation (4) holds with its stated properties, its use of the splitting
is sound: additive deck-equivariant operators preserve e², including
coefficient-Frobenius-semilinear ones. At n=2 a genuinely quadratic
equivariant expression in anti-tau corrections has no anti-tau projection.
The supplied carry then forces eta_0=d=0. The final marked-curve comparison
does retain the given truncation and the original map. Uniqueness and
naturality identify the Hodge data once the lower compatible lift exists.

The local connection normalization supplied by root during review also
checks. For a graph change I+epsilon*q*E21, the lower connection entry is
gamma+epsilon*(q'-2alpha*q)-epsilon²*beta*q². A determinant-one diagonal
change with v²=gamma/gamma' restores gamma. Its first variation is additive
and deck-equivariant. This justifies the extra weight in the connection
variation for genuinely compatible, graded-aligned previous tuples.

## Scoped positive verdicts

(a) PASS: D5 at n=2, with the canonical full compatible reference tower.
Every compatible given T4 extending the marked T2 has its ORIGINAL T3
truncation descend along the ORIGINAL map to a compatible C3.

(b) PASS: for every n>=2, D5 under the additional hypothesis that there
EXISTS a compatible C^0_(n+1) extending the given compatible C_n. The
conclusion retains the ORIGINAL given T_(n+1), not merely a replacement
upper lift. No compatibility of a chosen C^0_(n+2) is required. At n=2 use
the canonical reference as in (a); later levels use the assumed compatible
reference. These are assertions about the exact cyclic-five construction
and supplied Fitting inputs in the request, not arbitrary covers.

Here is the verification with the repair distinguished from the returned
argument. In these scopes eta_0=0, so first compatibility gives

    xi=d*e³+b*e^4.

The preceding reference Hodge filtration genuinely glues through W_n.
Consequently its adapted transition matrices are triangular at the level
needed for weight rescaling. Both compared tuples carry the prescribed
maximal graded Higgs identification. Root's graph and diagonal calculation
above fixes the lower connection coefficient. The induced identification
Fil² with the cotangent line fixes the diagonal transition factors through
the first changed digit: the curve itself first differs in order5^n, and
square roots with specified reduction lift uniquely since2 is invertible.
Thus the first changes of preceding transitions are upper triangular
unipotent, and those of the connection have only diagonal and upper
entries. They gain at least one factor5 under the displayed rescaling.
This explicit normalization repair was supplied by root during this audit;
it should be included in any canonical proof rather than attributed
verbatim to the returned Pro text.

The free Čech splitting chooses the tangent representatives in e², and
the exact first normal error has its unique primitive in e². The remaining
first frame and normalization corrections are additive deck-equivariant
expressions in these data; the square-root normalization's first digit is
-epsilon*(q'-2alpha*q)/(2gamma). Therefore all the linear terms left after
the additional division preserve e² and vanish in R/(e²). The Taylor
valuation j-1-v5(j!)>=1 for j>=2 bounds the remaining higher linear terms;
the j=1 case uses the explicit normalization just checked. Products of
first corrections contribute only for n=2 at the two-digit precision.
There the canonical reference, its local choices and the Čech splitting
can be tau-equivariant. All first corrections are anti-tau, and their
quadratic term has zero anti-tau projection. No tau lift is needed later.

For a compatible C^0_(n+1), an arbitrary smooth C^0_(n+2) still supplies
the next reference error downstairs. Its two-digit class has zero first
digit: tilde eta=5*eta_1. Its divided norm image therefore reduces to
e^4*eta_1, zero in R/(e²). There is no earlier non-gluing filtration error
of the type identified in the next section. In these scopes equation(4)
has the necessary properties, and the divided carry is just -d^5*e.
It forces d=0. The remaining xi=b*e^4 is the pullback of a lower kernel
direction beta. Changing the compatible reference by beta preserves its
compatibility and produces the class of the GIVEN T_(n+1). The resulting
marked isomorphism preserves T_n, hence transports the finite etale map
extending the GIVEN T_n→C_n. The full preceding tuple, graded marking and
flat square-trivial twist agree by their retained naturality and Hodge
uniqueness. This proves precisely (a) and (b).

## Blocking missing term: an incompatible reference is not triangular

For n>=3 the proof deliberately allows the lower reference C^0_(n+1)
to be incompatible. Its preceding de Rham object has only local Hodge
extensions at the missing digit. In frames adapted to these local lines,
its overlap matrices need not have the triangular shape asserted in (2).
Writing m=n-1, their possible lower entry is 5^m*r_ij. The normal class of
r_ij is precisely the obstruction which has not yet been proved zero.

The stated weight change has the elementary consequence

    S^-1 [[a,b],[5^m*r,d]] S
       = [[a,5*b],[5^(m-1)*r,d]],  S=diag(1,5).

Thus the missing lower overlap error loses a factor of five; it does not
obey the extra-factor estimate used for triangular preceding transitions.
Local normalization of the second fundamental form cannot make a
non-gluing collection of Hodge lines glue. Neither a deck-linear primitive
for an already exact normal error nor the integer carry calculation
removes this issue before the corrected upper filtration is inserted.

The sentence saying to retain the incompatible reference's overlap error
does not calculate this rescaled contribution, its interaction with the
upper graph correction, or its eventual normal projection. The required
claim is that their TOTAL contributes only the downstairs term of (4)
and additive e² corrections at the asserted precision. This may be true,
but is not established by the displayed triangular calculation. In
particular the estimate removing all quadratic terms for n>=3 must be
rechecked after the factor-losing overlap term has been included.

This is a gap in deriving the ACTUAL two-digit comparison, not a defect
in the exact coefficient identities. The source
[LSYZ, Section 5, Proposition 5.2 and its proof](https://arxiv.org/pdf/1404.0538)
compares the last curve digit with a fixed compatible previous tuple; it
does not itself supply the missing incompatible-reference calculation.

The objection is absent in the two PASS scopes just proved. They do not
give a compatible lower reference in the general case: that existence is
exactly what eta_0 potentially obstructs. To close the remaining audit gap, write the
local overlap matrices including 5^m*r_ij, combine their rescaling with the
actual correcting Hodge graphs and retained graded/twist data, and derive
the residual equation before using eta_0=0. No new large computation or
reproof of the established module/carry inputs is required.
