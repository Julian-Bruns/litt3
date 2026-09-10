# Scoped audit: proposed W4 defect polynomial

Date: 2026-09-10. Auditor: /root/audit_w4_defect_comparison.
Verdict: **GAPS — the actual W4 obstruction formula is not yet certified.**
This is not a counterexample to the proposed polynomial. The exact algebraic
identities and the conditional root description survive this audit.

## Scope and evidence

Read the request, `Research/W4_DEFECT_ADDITIVE_RESULT.md`, and the complete
`scripts/w4_defect_algebra_certificate.py`. Root additionally supplied the
returned prose about flat two-torsion frames, Taylor precision, local Hodge
corrections, and the scalar-solution residue argument; there is no fuller
geometric proof attachment. Root's exact certificate replay is accepted;
no large calculation or exploration was undertaken here. Read canonical
statements through the workspace CLI and the proofs for
`forced_canonical_witt_endpoint` and `explicit_genus_two_witt_obstruction`.

Checked the relevant primary source,
[LSYZ Section 5](https://arxiv.org/html/1404.0538#S5), especially the full
tuple after Definition 5.5 and the beginning of the proof of Proposition
5.2. The source defines the obstruction using frames already adapted to
the previous Hodge subbundle: its normal transition must vanish modulo
the previous precision before division by the next power of five.

## Principal unresolved comparison

Equation (1) in the result note is an identity for a formal Taylor/jet
comparison matrix relative to the reference oper frame. It has a normal
entry of order 5, not necessarily order 25:

    25 Z v - 5 Z^5 (f² F(v) + 5 f g F(v')).

The equation `Psi(v0)=0` makes the reduction of the coefficient of
`5 Z^5` a Cech coboundary. It does not itself identify the order-25
obstruction after correcting the local frames to the actual previous
Hodge line. The supplied prose recognizes that corrections are required,
but addresses their products only. It does not compute or prove the
vanishing of their *linear* order-25 carry in the Serre projection.
Such a carry has degree 5 in Z, so oddness cannot remove it and it can
alter the claimed beta.

Schematically, write the raw normal entry as

    5 Z^5 a + 25 (Z v + Z^5 b),     a mod5 = d c.

After lifting c and adapting the frames, the linear part includes the
divided difference between the lifted a and the lifted normal coboundary
of c, as well as the lifted reference transition factors. Knowing
`a mod5 = d c` says that this difference is divisible by 5; it does not
calculate its quotient. The formal matrix certificate has no c, no
adapted previous Hodge generators, and no reference normal-line
transition, so it cannot check this step.

There is a reasonable short way to close this gap. Identify the dual
normal line of the reference filtered bundle over W2 with its actual
quadratic-differential line, choose an actual lift of phi in it, and show
that all linear correction terms are its genuine lifted Cech
coboundaries. Their Serre traces then vanish. One must also show that
the local differential used in (2), `4(dx)²/y`, with the stated lift of y,
is the differential supplied by this identification and that (1) uses
the same lifted transitions. Alternatively construct the local Hodge
corrections explicitly and verify the corrected normal entry modulo125.
Neither comparison is included in the supplied derivation. This is the
decisive missing implication between (1) and (2).

## Reference input still needs a check

The mod25 reference connection `d + N x^4 dx` is compatible with the
displayed weight-rescaling in a suitable local oper frame. The canonical
ordinary tower exists by the inherited theorem. Those facts do not yet
construct the required comparison J for the specified marked reference.
The answer states the branch-center conditions and the existence of a
scalar solution of the form `f0(1+5d)` in this frame, but does not exhibit
the flat comparison on an affine/branch cover, its transition to the
x-frame, and its reduction to the specified previous graded data.

In particular the five residue equations and their invertible minor
prove uniqueness of Q *subject to those equations*. They are useful:
if the actual canonical reference is shown to satisfy this ansatz and
these necessary equations, existence of that reference plus uniqueness
will identify Q; a second construction of an arbitrary solution is not
required. The missing check is that the stated rational horizontal
ansatz and branch-center normalization are indeed forced by that actual
reference. A general local horizontal solution or the assertion of a
locally unipotent frame does not, without its gluing information, supply
the claimed global rational correction after auxiliary quadratic descent.
The certificate checks the equations after the ansatz is entered, not
this identification.

Keeping the two-torsion line in flat local frames is legitimate;
its scalar transitions can cancel projectively. I find no independent
objection to this stated treatment of the twist. Its compatibility must
also be retained in the missing reference comparison, as LSYZ requires.

## Checks which pass, and the degree claim

- The two residues of `(2y/x)(4 dx²/y)` normalize the special-fiber
  pairing to 16=1 in characteristic five.
- The adjoint matrix identity and the formal Taylor/jet identity are
  valid algebraic identities. Including the diagonal jet term matters.
- The stated inequality `j-1-v5(j!) >= 3` for j>=4 is correct. Together
  with the claimed weight-rescaling it controls omitted Taylor orders.
  The potential variation multiplied by25 indeed vanishes modulo125
  when it is divisible by5. This does not by itself check the input
  filtration or graded-identification transitions.
- Frobenius is retained in B^5 and C^5. Conditional on the identification
  of B,C and formula (2), the elimination giving
  `beta^5=3(t+1)^10+2(t+1)^8+1` is correct.
- Conditional on the corrected construction having only monomials
  Z, Z^5 and Z^10, the supplied oddness kills Z^10. Thus the polynomial
  degree claim is plausible but still depends on controlling the full
  corrected input, not just the formal Taylor matrix. Even granting
  the degree bound would not resolve the missing coefficient of Z^5.
- The factorization, irreducible degree-eight exceptional polynomial,
  and five simple roots away from beta=0 are correct for the candidate
  polynomial. At beta=0 the candidate is z and has only the zero root.

## Consequence of the verdict

Retain the formula as a positive, algebraically checked candidate with
the geometric comparison open. Do not promote its roots to proved
filtration-compatible W4 lifts until the corrected Hodge projection and
canonical reference identification above are supplied. No W5 or full
tower follows even if that comparison succeeds. This audit changes
nothing in the independent exclusion of the main Galois defect-one
branch and proves no new common-cover exclusion. It is a prose audit,
not proof-assistant verification.
