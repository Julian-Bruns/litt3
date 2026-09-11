# Exact degree84 exclusion on the backup

2026-09-11. Author /root. Two new bounded audits PASS: the full native
normalization/cofactor chart, and final polynomial/provenance assembly.
Inherited census and earlier exclusions retain their recorded evidence.

## 1. The actual map supplies the necessary system

Use [triangle237_dormant_orbit_obstruction](../Theorems/Thm_triangle237_dormant_orbit_obstruction.md).
All surviving maps factor through the hyperelliptic quotient; the three
primitive census survivors are already excluded. The quotient map has
degree42 and complete profiles(1^6 2^18,3^14,7^6). Its six simple zero
points are exactly the fixed hyperelliptic branch divisor.

The audited [cofactor dictionary](../Theorems/Thm_triangle237_cofactor_necessary_system.md)
therefore gives polynomials A,B0,C with degrees18,14,6, leading
coefficients1,-1,1 and the necessary equations

    s F A^2-B0^3=C^7,          s=3b13+2c5 !=0,
    (F'A+2FA')C-2FAC'+B0^2=0,
    3(B0 C)'+sA=0,
    F(AC)''+4F'(AC)'+(3F''-P)AC=0.

Here F=u(u-1)(u-2)(u-3)(u-alpha), and P is one of the five explicitly
known dormant potentials. They form a single Frob125 orbit, so it is
enough to exclude one representative over F_(5^15). Conjugation of an
algebraic solution would supply a solution for that representative.
This is not a search restricted to rational points of that field.

Keep loc*s-1. The u^4,u^9,u^14 coefficients of the third equation give
s*a4=s*a9=s*a14=0; localization by s justifies adjoining those three
zero coefficients. The resulting118equations consist of all115native
rows plus these three consequences. A fresh independent audit rebuilds
every native row from the chosen alpha and dormant beta, in exact order.

The actual zero at u=0 is simple, not a pole. Thus C(0)!=0. Adjoin
pole0_inv*c0-1. Every cancellation of a proved relation f=c0*g uses

    g=pole0_inv*f-(pole0_inv*c0-1)*g.

This is the only additional actual-source localization in the early
nonlinear chain. Omitting other passport opens only enlarges the
necessary solution set and is harmless for an emptiness proof.

## 2. Retain the complete source equations through elimination

The exact chain has the following stages. All additions are proved
polynomial consequences, all discarded rows merely weaken the system,
and all substitutions have verified affine row-space pivots.

1. Seven affine pivots reduce39variables to32. The C(0) inverse gives
   33variables. Replayed low-degree consequences are successively added.
2. In the quadratic subideal,13more affine pivots reduce33variables to20.
   These express c0,c1 in terms of c2,c3,c5; the earlier c4 expression
   uses the same three variables.
3. Tracked partial polynomial bases are interleaved with exact division
   of ALL216equations of the full33-variable necessary system, transported
   through those13pivots. Three such full transports are retained. Thus
   the final full20-variable system has250equations.
4. The cofactor theorem gives A=A_raw/L for EVERY actual map, with
   L!=0. Substituting this expression with lead_inv*L-1 removes15more
   variables. The resulting seven-variable system has251equations.
5. Take its63rows of degree at most6. Fourteen tracked consequences,
   together with original seven-variable row213, form a15-row subideal.
   A short-identity computation proves this subideal contains1.

The geometric cofactor boundary is not inferred from a unit computation:
its separate theorem uses the actual squarefree/disjoint passport to
prove L!=0. The fresh chart audit also reconstructs all signed minors
independently, checks the full differential equation, and verifies the
joint three-pole substitutions against every native row.

## 3. The final unit and its independent verification

External data root: /Users/julian/Documents/litt3-computation-data.

The final source is
degree84-three-pole-final15-20260911/source.json, SHA256

    882058ddcfb3e4fe56b23b11f8dfea2269136a2830a9d67b90fcf105eb2d891a.

The frozen certificate is
degree84-three-pole-dag-snapshot-20260911/dag.json, SHA256

    d208d17e45f88e533ce5636f9b3cb3faecf824e8562778c5dffa1e3d7171aca8.

It contains190nodes. Each is an explicitly recorded polynomial linear
combination of the15input rows and earlier nodes; the last node is1.
Consequently every common zero of the input rows would satisfy1=0.
No claim that a candidate list is a complete Groebner basis is needed.
The standard-library verifier expands806607products in about5seconds.
A fresh auditor repeats the replay and verifies rejection after a
single-coefficient mutation.

The full manifest is
degree84-final-provenance-v3-20260911/manifest.json, SHA256

    fa1c6f5e8bdf02c0155ebb3fb958390d70b3dfbde0dcad1c7ca30d2b2003d5fb.

It closes all35source nodes, hashes287artifacts, and checks127previously
executed independent identity receipts. In addition to the hashes,
the assembler recomputes all equation-list links, factor cancellations,
affine pivots, exact subset/merge maps and full-equation transports.
The final auditor independently checks the parent closure, immediate
predecessor links, hashes and assembler logic. These are the evidence
for the nonlinear inherited chain, not merely the last15-row identity.

Reproduction uses
[assemble_degree84_provenance.py](../scripts/assemble_degree84_provenance.py)
under Sage, with a fresh output directory. Its --replay option also
reruns all127standard-library polynomial identity checks. The final unit
is always replayed. The underlying verifiers are
[verify_polynomial_basis_identities.py](../scripts/verify_polynomial_basis_identities.py),
[verify_field_macaulay_certificate.py](../scripts/verify_field_macaulay_certificate.py)
and [verify_polynomial_identity_dag.py](../scripts/verify_polynomial_identity_dag.py).
The actual geometry is audited separately; no software validation is
being represented as Lean verification.

The complete fresh --replay run also PASSED on2026-09-11, in390.486seconds:
all127constituent identity checks, all35source nodes and the final190-node
unit. Its independent receipts and manifest are retained in
degree84-final-provenance-full-replay-20260911. This is a full executed
replay, not merely a hash check of the earlier receipts.

## 4. Geometric conclusion

An actual surviving hyperelliptic-factor map supplies a zero of the
necessary system, then of every transported system, and finally of
the15rows. The unit identity contradicts this over any field extension.
All five dormant potentials are excluded by their Frobenius conjugacy.
Together with the earlier three primitive exclusions this removes every
remaining class of the complete degree84 census.

Thus the backup has no tame uniform degree84 map of profile(2,3,7).
The no-cored common-cover assembly and coreless problem are separate.
