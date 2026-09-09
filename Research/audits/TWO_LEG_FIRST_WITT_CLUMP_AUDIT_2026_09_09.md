# Focused audit: shared negative extensions and first Witt lifts

Verdict: PASS, no blocking objection or required mathematical repair.
Auditor: /root/audit_first_witt_clump. Date: 2026-09-09.
Scope: version1 of [the statement](../../Theorems/Thm_two_leg_negative_extensions.md)
and [its proof](../../Solutions/Sol_two_leg_negative_extensions.md), Sections1--3
and their stated limitations. This is a bounded independent prose audit,
not formal verification or a fresh audit of inherited library results.

## Inputs and source check

Read the continuation records, canonical statement/dependency output, and
the existing pointed-extension proof Sections1--4a. Its previously audited
finite-field projective-monodromy argument is an input; the changes for
omega^m were checked here. The canonical-intersection statement is an
input for identifying the primitive tensor. The negative-cohomology and
zero-tangent deformation-ring arguments in etale_refinement_deformations
were inspected for the precise new application, not re-audited globally.

Read Mochizuki, *A Theory of Ordinary p-adic Curves*, printed pp.58--61,
directly from the supplied PDF: II Propositions1.1--1.2, Definition1.3,
Proposition1.4 and its local calculation. Proposition1.1 explicitly has
the injection H1_dR(T) into H1(T); Proposition1.2 concerns arbitrary
marked first Witt liftings of the Frobenius twist. Neither proposition
assumes that the FL projectivization is indigenous or ordinary.

## Checks

1. Replacing omega by omega^m, m>=1, preserves every needed sign:
   H0(omega^(1-5a)) vanishes, normalized pointed coordinates are sections
   of a positive line, and an unstable maximal line has positive degree.
   The pointed extensions remain nonsplit at every Frobenius iterate.
   Projective frames, rather than matching theta characteristics, retain
   both actual endpoint embeddings. The inherited maximal unramified
   extension argument introduces no finite simultaneous Galois closure.
   Matching HN projections give equal nonempty effective pullback divisors,
   hence a clump for the specified span.

2. The first Witt lift produces the fixed normalized obstruction class,
   not a separately rescaled projective extension. Its nonzero Cartier
   boundary and the forgetful injection make its underlying H1 class
   nonzero. For an actual lifted etale map, a local relative-Frobenius lift
   lifts uniquely to the etale target cover; its difference derivations
   pull back under the canonical tangent identification. This proves
   naturality of the normalized extension and connection on BOTH legs.
   Applying Witt-Frobenius base change to the given whole diagram supplies
   the required twisted lift. Dualization gives the claimed common
   pointed extension of omega^5 by O. There is no extra admissibility
   requirement at this stage and no assumption on source ordinariness.

3. For n=0 the dual FL p-curvature is nowhere-zero nilpotent, with kernel
   the distinguished O subbundle. Any horizontal line is p-curvature
   stable; a stable line for this rank-one nilpotent operator is its
   kernel. Thus the positive-degree HN line cannot be horizontal. For
   n>=1 the usual preceding-stage Cartier-descent argument applies.
   The genus-two bound P<deg N<=P+1 is therefore valid in both cases.
   The resulting second fundamental isomorphism pulls back and reflects
   along the actual etale legs, proving the endpoint degree formula.

4. Reducedness does not need zero p-curvature. At a zero of the
   projection write n=Ae+Bv, A a unit. Since e is horizontal, the
   coefficient of n wedge nabla(n) modulo B is A dB; terms involving
   nabla(v) carry a factor B. Its being a unit forces a simple zero
   of B. Hence deg Delta_Y=P-1 is also its number of geometric points.
   The determinant connection remains canonical, and its inverse
   square-root twist is horizontal since P is divisible by5. The
   existing local horizontal-section calculation consequently identifies
   the oper with intrinsic r_s also at n=0. Squaring the quotient section
   gives divisor2Delta; in sigma=c s^j, j divides2, yielding precisely
   the two stated primitive weight/zero-order pairs. Nonzero FL
   p-curvature survives projectivization, so n=0 is admissible active;
   n>=1 is dormant.

5. For no-clump spans, J1=0 makes the entire marked representing ring a
   quotient of W(k). Absence of a W2 point forces that quotient to be k.
   This uses the established complete local deformation presentation,
   not an implication from the absence of unramified lifts for a general
   ring with parameters. It requires no endpoint full-lift exclusion.

No claim of common-cover nonexistence follows: characteristic-five spans
with ring k remain logically possible, and positive-clump spans may have
later FL instability. No W3 lift, all-height bound, automatic ordinary
source, or solution of the unmarked common-cover problem was established.

## Separate version2 extension audit

Verdict: PASS, no blocking objection or required mathematical repair.
Auditor: /root/audit_first_witt_clump. Date: 2026-09-09.
Scope: ONLY the newly added proof Section4 and theorem Part4, version2.
The preceding verdict remains the separate evidence for Parts1--3.

The incidence construction is scheme-compatible: for degree-m effective
D, both L^-1 and L^-1(D) have negative degree. The connecting map from
the length-m quotient therefore injects with constant rank m into
H1(L^-1). Over Sym^m(Y) these kernels form a vector bundle, whose
projectivization is proper and maps everywhere to P H1(L^-1). Thus its
image is closed, irreducible, and consists of precisely the nonzero
classes for which an inclusion L(-D)->L lifts, including nonreduced D.

At a general reduced D, local variation of points and nonzero span
coefficients supplies the values and first derivatives at D. The ordered
distinct-point chart is etale over its symmetric-product chart even when
5 divides m!, so no characteristic-zero assumption enters. For the
degree-two bundle M(-2D), Riemann--Roch gives h0=1 except when it is omega,
when h0=2. The exceptional equality is avoided generically: for m>=2 use
surjectivity of the Abel map and finiteness of multiplication by2 on
Pic; for m=1 it is the finite Weierstrass locus. Hence the 2m jet
functionals have full rank, the projective differential has rank2m-1,
and the closed image has exactly that dimension. It is a hypersurface.

A lifted L(-D) is injective since its composite into L is injective.
Its degree is m; semistability of E forces its saturation still to have
degree m, so it was saturated already. The quotient also has degree m.
Twisting by theta^-m and then pulling back by any Frobenius gives an
extension of degree-zero lines, hence a semistable bundle. This is exactly
the strong-semistability configuration excluded by the existing two-leg
argument. Every projective line meets the hypersurface, proving dim J_m<=1
under the stated semistability hypothesis.

The clump-size criterion does not equate multiplicities with support:
an unstable index-zero projection has nonempty divisor of degree<m,
whose support is an endpoint clump. The unique-clump input forces that
support to contain exactly the given r points, contradicting r>=m.
No assertion of reducedness for this arbitrary unstable projection is
needed.

Finally a nonzero J1 and a W2 lift identify the SAME intrinsic oper by
the earlier proved identities. The former is dormant, excluding index0
of the FL construction. Its later reduced clump has size at least24;
uniqueness identifies the two supports and their cardinalities. Thus
dim J5<=1 applies. Frobenius twisting is a field automorphism over k and
preserves the dimension and nonvanishing of the common tangent space.
Its Frobenius pullback gives a nonzero common J5 class lying in the
zero-boundary subspace of the de Rham exact sequence on Z. The class
from the given marked W2 diagram has nonzero boundary. The forgetful
injection makes the two underlying H1 classes linearly independent.
Dualizing the FL extension may change the uniform sign of this
identification, which cannot change zero versus nonzero boundary.
The contradiction and the zero-tangent deformation-ring consequence
therefore follow with precisely the stated scope.

The result is rigidity of W2-liftable coreless genus-two spans. It does
not remove characteristic-five-only one-tangent spans, bound their
deformation rings, or supply higher Witt lifts.
