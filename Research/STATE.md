# Continue here — ONE optimized all-core enumeration

Last updated: 2026-09-06, 18:42 CEST. Litt3 is UNSOLVED.

## Latest user instruction and exact active computation

User explicitly requested: remove old algorithms and run the new one on
all available cores. DONE. There is ONE solver process; do not resurrect
the obsolete full-system or auxiliary searches.

PRIMARY: PTY97862, PID90081, started18:39:56CEST.
Executable:
  /tmp/litt3-msolve-lowmem.bQGL6w/msolve-0.10.1/msolve
Arguments:
  -t10 -l2 -m250 -v2 -g2
  -f Research/computations/normalized_oper_msolve.in
  -o Research/computations/normalized_oper_msolve.gb

This is14 variables overF25, represented by15 overF5 (the extra variable
zeta satisfies zeta²+4zeta+2). Expected F5 length19290, F25 length9645.
It is NOT a Weil restriction. All10 physical/logical CPUs are enabled;
serial portions need not use all10 simultaneously. Pair cap250 limits
selected pairs, NOT a hard RAM bound. Monitor late memory growth.

Input SHA256:
c378d97ee11e2f1e306402a47a90cca586316734df3475d0099d3eabe2253f2a
Simplified generator was rerun and produced the IDENTICAL input hash.
  sage scripts/normalized_oper_quotient.sage --msolve-input
Checkpoint normalized_oper_quotient.sobj=(Q,eqs,Ahat,Chat,B,Lambda).
On successful solve:
  sage scripts/export_oper_basis.sage --normalized [--radical]
This checks F25 length9645 and checkpoints basis before further work.
Then implement exact radical/closed-point enumeration, reconstruct all
three cube roots t³=Lambda at each point, and attach full local lengths.
Export is not yet implemented for the unknown remaining radical points.

The previous2-thread trial peaked about2GB in its first9min. This is
not an eventual memory guarantee or ETA. The old unlimited matrix had
42GB allocated and severe compression; it has been terminated.

## Cleanup completed — no legacy support

All old processes terminated, INCLUDING Singular/Python backup and paused
full/15-variable/B4/B8 trials. No old process remains intentionally paused.
Obsolete inputs/checkpoints/incomplete outputs moved recoverably to:
  /Users/julian/.Trash/litt3-retired-solvers.2a0Fl7/
They are NOT research context and not needed to continue.
Removed inverse-variable and auxiliary-B code paths. The normalized
generator now has a single14-variable presentation. Original equation
builder remains for proof/invariant/c4 certificates, but no longer launches
the obsolete24-variable solve. The exact55-point data were preserved.
Do not claim killed in-memory work was saved as a durable checkpoint.

## Mathematical optimization already proved and saved

fixed_x_oper_cubic_quotient:14-variable finite scheme, length9645.
Cubic reconstruction gives remaining original length28935.
The inverse variable is redundant: at Lambda0, e0 forces B to one of
the55 invariant opers, and e1 forces W_B(Chat)=0. Exact rank5 minors
at all six closed points (degrees1,1,2,9,19,23) force Chat0, contradicting
its monic degree4 coefficient. Nullstellensatz makes Lambda a UNIT of
the full algebra, so dropping its inverse loses no nilpotents/multiplicities.
Certificate:
  scripts/normalized_oper_lambda_unit.sage
  Research/computations/normalized_oper_lambda_unit.json

Source optimization: separate msolve build skips unused tracing bitmaps
ONLY in exactF5 sparse2 NO_TRACER mode; arithmetic unchanged. Eight
selected upstream finitefield tests passed, invariant/c4 bases match
original byte-for-byte, independent Sage checks lengths55/330.
Source patches and test metadata:
  Research/computations/msolve_lowmem/
Do not claim full upstream suite or unused old interreduction branch tested.
Temporary build above must remain present while the active process runs.
No active subagents.

## Exact enumeration completed so far

Original dormant-oper scheme length29375 is from audited chart plus
literature count, not yet independently confirmed by full Groebner solve.
Invariant A=C=0 slice has55 distinct points. ALL have full local length8,
Hilbertfunction(1,3,3,1); exact truncated lengths4,7,8,8 and Nakayama.
All55 tuples, Frobenius conjugates separate, no duplicates:
  Research/computations/invariant_oper_solutions.json
Its short README gives field conventions. Bulk local certificates are
reference-only; do not load them into routine context. Reproduce with
scripts/invariant_oper_multiplicities.sage, then --export-only.
Total accounted length440; remaining28935; distinct remaining count UNKNOWN.

The c4=0 slice has length330, radical55, slice local length6 (NOT8).
Those exact certificates remain. Top equation a10=c4². On c4!=0,
put t=c4, Lambda=t³, C=t Chat,A=t² Ahat. Both normalized polynomials
are monic; B and Lambda reconstruct polynomially. The etale cubic
preserves local lengths and gives distinct original tuples.

## Proof frontier after enumeration work

Latest Pro response has been integrated and materially strengthened.
Canonical IDs (read statements via CLI, proofs only as needed):

1. semilinear_hermitian_lift VERSION2: AUDITED general horizontal
   differential retraction. EVERY allowed genus, INCLUDING nontrivial
   tau³=O. Exactly ONE extension candidate for fixed V,pi,j, leaving
   7(g-1) residual coordinates. No rank assumption. Rank bound<=4g-5
   retained. The weaker rank-stratified theorem/proof was deleted.

2. scalar_hermitian_reconstruction: fixed geometric oper on X, explicit
   Pro formulas. All10 identification parameters and all40 extension
   variables removed. Exact56-equation test on all quotient loci.
   Frame and differential-elimination audits PASS; complete scalar
   theorem including normalization is author proof, not fully audited.

KEY SCALAR IDENTITY:
Dbar=-rho32 delta on P48; Q1-Dbar Q2=rho32(z1+delta z2).
The c48 correction cancels since delta(t48)=-t31+O(t32).
For Pro zeta: zeta1+delta zeta2=-a(lambda+delta eta)-b eta.
After normalizing a1,b0:
  lambda*=-rho32(delta eta),
  rho48(kappa5(T+eta5 U)-eta-U lambda*5)=0 (56 equations).
Here HS5=[U,T;delta U,delta T]. No first40 equations, rank strata or
Frobenius root search are needed. Quotient regularity still essential.

General explanation saved in semilinear_hermitian_lift:
J=K M^-1≅F*(Vvee), with canonical connection; subline N=M^-1,
quotient Q=omega^-1 M^-1, Q omega=N. Second fundamental scalar c!=0
by Cartier degree divisibility. R=c^-1(q tensor1)nabla retracts N
as sheaves of k-vector spaces and kills every dual Frobenius class.
Thus lambda=P(b0)=-P(xi0) uniquely. Fixed marked data, not arbitrary
nonreduced-family theorem. Audit PASS horizontal_retraction_audit.

Scalar test implementation remaining: compute eta,T and lambda*, then
ONLY lower56 residual. scripts/scalar_residual_rank.sage already computes
lower matrix. All16 samples satisfy full upper=Dbar*lower; two chosen
samples checked globally reduced zeros, hence actual surjective pi.
These are NOT solutions of the residual56 equations.

## Broader boundary

Only large CORED cases are currently attacked: [H/PSU3(5)] and
[H/PGU3(5)], H genus10 Hermitian. No fixed-X atlas excluded.
Small cored and coreless branches remain. Explicit scalar test is untwisted
PSU; general retraction includes torsion twists, not their scalar computation.
Do not infer arbitrary H-commensurable curves are atlases of these stacks.
Ordinary and superspecial curves can share etale covers.
Coreless shared canonical ring k or k[s]; nonconstant s not proved.
Preserve both actual etale maps, no simultaneous Galois closure.
Closed failed routes: Raynaud saturation, universal HN polygons,
Tango-preservation implying a core.

Hourly waiting timer: functions.exec cell286, due about18:59CEST.
Update.md refreshed18:42, but timer still due18:59; wait/rearm then.
