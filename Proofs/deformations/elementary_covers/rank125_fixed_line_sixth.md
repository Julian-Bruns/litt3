# Proof: the sixth scalar and its odd-family criterion

Version2, 2026-09-24. This proves the
[scoped statement](../../../Theorems/deformations/elementary_covers/rank125_fixed_line_sixth.md).
Generated outputs and saved objects remain outside litt3.

## 1. Geometric inference and exact field arithmetic

The [sixth affinity proof](rank125_sixth_fixed_line_affinity.md)
gives psi6(tau)=b6+a6*tau over every perfect field containing F125.
The [complete late comparison](../late_relative_hodge_response.md)
identifies the actual relative sixth image with E100=0 on the
fixed target, allowing all43 fifth directions. These inputs concern
the genuine comparison, not an auxiliary characteristic-five graph.

The executed values in Section2 give b6=[101] and psi6(1)=[1].
Field-code subtraction, in F5[t]/(t³+t+1), gives

    a6=[1]-[101]=t²=[25],
    [101]+t²*(t+4t²)=0.

The second equality follows from t³=-t-1 and t⁴=-t²-t.
Since t² is nonzero, tau=t+4t²=[105] is the unique zero.
All coefficients lie in F125. The complete relative image theorem
solves its other nine fixed scalar coordinates over F125, with
the actual additive tails retained; the full primary preimage and
whole regular primitives then give a compatible W6 tuple over that
field. Uniqueness refers to the fourth point on this line, not all
higher source choices. No seventh or unmarked claim is used.

On the full odd fourth-choice fiber, the [supporting affinity
proof](rank125_sixth_fixed_line_affinity.md), Section5, gives the
four-channel residual with an additive map $L_-$ in the three
anti-invariant coordinates and $b_6+a_6x_1$ in the invariant coordinate.
The computed values give $b_6+a_6x_1=[101]+[25]x_1$, whose unique zero is
$[105]$. The other three channels vanish exactly when $L_-=0$.
Additivity gives $L_-(0)=0$, recovering existence on the fixed line.

## 2. Whole comparison and independent replay

The [new sixth driver](../../../scripts/deformations/rank125/compare_sixth_fixed_line.py)
retains the original source snapshots and constructs the source
through15625 and flat output through3125. It solves the full fourth
and fifth primary equations, transports whole regular repair pairs,
and extracts P3 modulo125 from the genuine second-repaired tuple.
It uses P3 in the sixth inverse-Cartier connection. In particular
P3 is not replaced by the previous P2. True Witt Frobenius sends
T to15371+571T+15244T² modulo15625.

The weight25 graph is normalized by the exact quadratic formula
with the ACTUAL changed connection, established in
[integral oper calculus](../integral_oper_calculus.md), Section2.
The weight125 graph and the final weight625
same-line connection reframe use the appropriate exact truncations.
All source-exponential and divided Taylor terms through order6
are retained. Exact lower images of high-weight frames preserve
certified Laurent ranges; no series precision is manually enlarged.

The three completed receipts are:

| tau | Workspace | Frobenius / branch | E100 | Divided sixth precision |
| --- | --- | --- | --- | --- |
| 0 | 4800 | 0 / +1 | 101 | 515 |
| 1 | 4800 | 0 / +1 | 1 | 515 |
| 0 | 5600 | 1 / -1 | 101 | 1191 |

Receipts: [first baseline](../../../../litt3-computation-data/rank125_sixth_local_20260915/tau0_N4800_v0_b1_sixth.json),
[tau1](../../../../litt3-computation-data/rank125_sixth_local_20260915/tau1_N4800_v0_b1.json),
[independent baseline](../../../../litt3-computation-data/rank125_sixth_local_20260915/tau0_N5600_v1_b-1.json).
The independent run reconstructs its first tuple afresh, changes
the regular affine Frobenius and infinity branch, and increases
the Laurent workspace. Its complete125-entry quotient-normal-form
E6 vector equals the first baseline exactly. The first baseline
continued from a checked whole fifth tuple; its original receipt,
pickle, driver and observed same-run provenance are explicitly
bound in the [preserved input record](../../../../litt3-computation-data/rank125_sixth_local_20260915/tau0_N4800_v0_b1_fifth_input_binding.json).
The successful finisher's actual input hashes match this record.
The audit distinguishes this later attestation from an original
embedded hash. Fresh main executions embed each saved object hash.

In the order E100,E111,E120,E300,E131,E140,E311,E320,E331,E340,
the baseline vector is

    (101,69,81,103,75,116,49,82,39,54).

All other quotient-normal-form coordinates vanish. Full projection
from precision150 retains normal precision94; the six normal base
coordinates require exponents only through1. Its E100 value also
agrees with the exact b344/b444 two-trace formula. This second
extraction shares interpolation/base splitting and is not an
independent arithmetic engine. Independent evidence is the fresh
larger-workspace, changed-Frobenius/opposite-branch complete replay.

All recorded full jet and horizontality checks pass, including the
genuine preceding truncations, retention of the whole fifth prefix,
and all four final inverse-Cartier connection entries. Arithmetic
uses the faithful35-factor decomposition and GMP integer convolution.
No floating-point operation or finite parameter search supplies
the obstruction value or its support theorem.
