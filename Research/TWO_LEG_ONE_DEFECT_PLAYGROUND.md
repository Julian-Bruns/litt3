# The first genuinely mixed Witt obstruction: one simple zero

2026-09-10. Active research note, not a new common-cover theorem.
The canonical inputs are forced_canonical_witt_endpoint and the three
audited genus-two theta/Witt-cover theorems. Do not duplicate them here.

## Exact target

Keep actual jointly minimal coreless maps X<-Z->Y, g(Y)=2, Hom-zero,
ordinary J(Y), and matching admissible ACTIVE connections. BOTH endpoint
connections are indigenous-ordinary. The full canonical endpoint lifts
give two individually existing full source lifts, identified modulo25.
Their actual difference modulo125 lies in ker(Psi_Z), and it vanishes
exactly when the original diagram lifts; A=f*H1(T_X), B=g*H1(T_Y)
satisfy A intersect B=0. This is the already proved canonical theorem.

The returned Pro request restricted to dim ker(Psi_Z)=1 and
rank(Psi_Z²)=rank(Psi_Z). It asked for the ACTUAL vanishing, not a new
description of that kernel. No endpoint is changed and no source is
replaced. No witness satisfying the whole setup has been constructed.

## Why kernel dimension alone hid another complication

Let F be a Frobenius-semilinear endomorphism of a finite-dimensional
vector space over a perfect field, with dim ker F=1. Its Fitting
nilpotent part can have ANY positive dimension: it is a single chain,
not necessarily just its last, killed vector. Thus

    rank F²=rank F
      iff V=ker F direct-sum im F
      iff ker F intersects im F trivially.

In this case F is bijective on im F. If the equality fails, ker F is
contained in im F: their intersection is a subspace of the kernel line.
Consequently the unique covector annihilating im F KILLS ker F in
the latter case. It would be an invalid scalar test for a nonzero
kernel obstruction. This is elementary semilinear linear algebra;
the relative-Frobenius twists must be retained in its dual version.

The exact audited3x3 Psi matrix of the F625 laboratory has ranks

    rank(Psi^j), j=1,2,3,4: 2,1,1,1.

These were computed by M M^[5] ... M^[5^(j-1)], NOT M^j.
Thus that corank-one example has a two-step nilpotent chain. Its
nonzero one-endpoint epsilon does not test a simple-zero hypothesis.

There are actual one-leg simple-zero examples. For the high-degree
Y_t family, take the active quartic A=(t+1)²G, G=u(u-1)(u-2)(u-3),
and the bad double w²=u(u-3). The canonical active-twist proof gives
the anti-invariant Cartier block B direct-sum0, before fifth roots,
with

    det B=(t+3)(t+4)(t+1)^4.

The three-dimensional parent block is invertible. Hence the genus-three
source has a five-dimensional bijective part and one zero line. Its
canonical endpoint supplies a full source lift. This rules out trying
to contradict the simple-zero hypothesis from one-leg data alone.
The existing genus_two_active_twists certificate proves the needed
family conditions; this small symbolic determinant was recomputed.

## The exact scalar now available

With both endpoints ordinary, A+B is contained in im Psi_Z. Under the
simple-zero hypothesis choose nonzero phi in the one-dimensional
Serre annihilator of im Psi_Z, a regular quadratic differential on Z.
It satisfies f_*phi=g_*phi=0. Its pairing with the kernel line is
nonzero. Thus for the ACTUAL difference delta of the two canonical
source lifts,

    delta=0 iff <delta,phi>=0.

This is more suitable for an actual residue calculation than merely
knowing the source has one defect. It is still only an equivalent
test, NOT a vanishing proof. The endpoint trace identities do not
by themselves evaluate this pairing.

For the calculation, arbitrary reference endpoint C3 lifts suffice,
provided they lift the FIXED canonical C2 curves. Their two induced
source lifts differ from the canonical choices by A+B, annihilated
by phi. In compatible local coordinates, the ratio of their overlap
maps is 1+25*v_ij*d/dz. The scalar is the Serre/Cech pairing of this
actual vector-field cocycle with phi, or the corresponding sum of
residues in a punctured-chart presentation. This avoids computing
the canonical third lift corrections and the second inverse-Cartier
object solely to evaluate the scalar. It does NOT avoid retaining
the actual first-lift maps. There is no known reason for the residues
of this nontrivial Cech cocycle to sum to zero.

## Independent route / boundary

The new canonical author theorem
[symplectic_p_cover_section_growth](../Theorems/Thm_symplectic_p_cover_section_growth.md)
explains a piece of the cover behavior in EVERY genus, without theta
properness: an odd tangent defect increases under any nontrivial
5-group-closure cover. For a one-defect base and Galois P it becomes
at least1+dim_F5 Hom(P,F5). A source defect1 is impossible for such
a nontrivial cover, and either actual leg's deck group has order prime
to5. This does NOT constrain arbitrary Galois-closure monodromy to
prime-to5. It is an elementary alternating cup-form argument, not a
new computation, and it explains why the laboratory plateau occurs
at the even value2. The proof is author-checked, not newly audited.
Version3 adds the Galois classification: ordinary endpoint to one-defect
source forces a quadratic character and a bad double, with prime-to5
section-preserving remainder. On selected Y_t this means one of the ten
known bad doubles, hence the source Psi zero is simple at ANY Galois
degree. Separately the finite-norm argument on normalized Cartier-kernel
products forces d_Z>d_X whenever d_X>0 and the Y-leg is Galois/coreless.
Therefore both ordinary-X and simple-zero assumptions of the Pro target
are automatic in the ENTIRE Galois Y-leg one-defect branch, not merely
in the first double example. No mixed scalar has yet been evaluated.

Investigate the mixed residue using the full pulled-back higher
inverse-Cartier data or a geometric reciprocity law. A calculation of
epsilon_Z alone will not help: it is already zero because EACH of
the two separately existing source lifts has a Hodge lift. The
difference can still lie in ker Psi_Z.

Likewise, replacing the source by a common etale refinement preserves
the whole diagram deformation functor. Both maps must be retained.
No source-ordinary lifting theorem applies to the remaining zero line.

## New: a nonzero obstruction can become invisible to every fixed-depth test

The new Section8 of symplectic_p_cover_section_growth proves more than
the preceding warning. For the entire Galois Y-leg one-defect branch,
at least TWO of the six cyclic5 directions from Y extend to actual
common-source cyclic5^n refinements Z_n with defect exactly ell=2 or4
at EVERY level. Put q=5^n, D=dim H1(Z,T_Z). Then

    rank(Psi_(Z_n)^j)=(D-1)q+max(q-j*ell,0).

The finite defect has stabilized, but the Frobenius nilpotent summand
has dimension q and nilpotence index ceil(q/ell). The proof uses the
ACTUAL semilinear Fitting decomposition as free modules over the cyclic
deck algebra; sigma fixes deck-1. Smith row/column reduction alone
would not justify the power formula. No larger cover was computed.

If the actual mixed delta on the minimal source is nonzero, its
pullback remains nonzero and satisfies EXACTLY

    delta_n in im(Psi_(Z_n)^j) iff j<=floor((q-1)/ell).

Thus all first-image Serre residues vanish after the first refinement,
and any fixed finite number of image tests can be passed by refining
farther. Yet delta_n is NEVER in the stable image and the same original
diagram still does not lift. In particular these operations do not
evaluate the scalar on the original simple-zero minimal source.

The local theta input is still on the GENUS-TWO endpoint: E_r tensor
its bad two-torsion line is symplectic with proper theta and the same
nonzero kappa self-translation. The audited multiplicity<=4 proof
therefore applies. It gives the two directions with ell2/4, first on
the bad double. Prime-to5 trace then transfers the whole nilpotent
summand to the actual source. No genus-three theta classification or
ordinary-source assumption is inserted.

The new Section8 has passed a focused medium audit,
[record](audits/SIMPLE_ZERO_CYCLIC_TOWERS_AUDIT_2026_09_10.md);
earlier Sections1--7 remain author proofs. This describes
what a HYPOTHETICAL nonzero delta would do. It does not construct such
a span or decide(R1). The submitted Pro target was on the original
joint normalization, where the simple-zero scalar is a valid test.

## Returned R1 answer: the useful addition and the equivalent reformulation

2026-09-10. Pro did not settle R1. Its proposed matched-connection
condition(M) is EQUIVALENT to R1 under the existing inputs: our audited
forced-canonical theorem gives R1=>M, while the new comparison gives
M=>R1. Therefore asking for(M) next would repeat the same unresolved
problem. The user explicitly criticized this kind of question selection.

The useful addition is BEFORE the Hodge projection. Put

    H=H1_dR(Z,Ad r_Z), F=H0(Z,omega²) subset H,
    B: H1(Z^(1),T) -> H,    pr_Hodge B=Psi_Z.

Mochizuki II2.12--2.14, pp73--77, identifies the dual B^vee as the
full infinitesimal Verschiebung; its restriction to F is the twisted
Cartier map C. The injection is proved on p79 before Cor2.16. These
pages were read and pp77/79 visually checked locally. The trace pairing
on the nilpotent p-curvature line vanishes; thus im B is isotropic and,
by its dimension and injectivity, Lagrangian. Consequently

          B:ker(Psi_Z) -> F intersect im B=ker(C)

is an isomorphism with the relative Frobenius twist retained.

The full Taylor variation in LSYZ Section5, equations preceding and
following(5.5.1) and proof of Proposition5.2, gives the flat-bundle
difference before Pr, not only its Hodge obstruction. Using the
matching previous-flow tuple and the two canonical source lifts gives

    iota(q)=+/-B(delta),
    q=(g2*rY,2can-f2*rX,2can)/5,    C(q)=0.

The choice of sign depends on the orientation of the source difference;
none of the following conclusions does. This is a source-checked
interpretation of the returned argument, not a fresh independent audit.

If(M) holds, q belongs to the sum of the two pulled-back quadratic
spaces. Endpoint ordinariness makes C bijective on each summand and
hence on their sum; therefore q=0 and injectivity gives delta=0.
Conversely R1 supplies compatible canonical projective connections
one Witt level below. This proves the asserted equivalence.

The symplectic structure alone leaves the scalar free. In a symplectic
space V direct-sum V^vee, take B(v1)=v1^vee and B(vi)=vi for i>1.
Its image is Lagrangian, its projection has one simple zero, and the
nonzero pair delta=v1, q=v1^vee satisfies the full comparison. This is
only a linear-algebra test, not a geometric counterexample. It shows
why isotropy is not itself a route to evaluating the actual scalar.

## A tested replacement: the next kernel-to-cokernel obstruction

The new [cubic-defect theorem](../Theorems/Thm_bad_double_cubic_defect.md)
computes the ENTIRE fixed-curve nilpotent germ on the explicit bad
double C→Y: k[[z]]/(z³). Its cubic coefficient is3(t+1), and an actual
branch deformation has nonzero transverse derivative3(t+1)². Both
were checked symbolically in under a second after startup. This is a
nonlinear mechanism, rather than another assumption that the old
unknown scalar vanishes. It is not yet an arithmetic Witt calculation.

On C choose v in ker(Psi_C) with <v,phi>=1, phi=gamma/F*(du)^2. The
canonical full lift of the ORIGINAL Y-cover supplies a reference C3^0.
All C3(z)=C3^0+zv have a lifted Hodge line. Each thus supplies its FULL
previous filtered object for the next inverse-Cartier step. Define

       P_t(z)=<rho_(C3(z))(C4),phi>,

using any C4 lifting C3(z). This is independent of that choice because
variation is -Psi_C and phi annihilates its image. Its zero set is
exactly the parameters admitting the NEXT filtration-compatible step.
The canonical origin gives P_t(0)=0; the double involution gives oddness.
The cubic mod-five coefficient does not determine P_t; retain the full
jet/Taylor construction and Witt-Frobenius transport.

### Why this computation can affect the actual two-leg stratum

In the selected Galois Y-leg defect-one branch, Z→Y factors through one
of the bad doubles C, with H=Gal(Z/C) of order prime to5. Trace and the
known defect equality identify the complete kernel line with that on C.
An actual difference delta of the two canonical W3 sources is pulled
back from zv. Therefore the f-source W3 curve is isomorphic, with its
marking, to the lift of the original cover Z→C over C3(z): the two
curve-lift torsors have the same reference and the same difference.
The filtered data over W2 agree by naturality and uniqueness of the
Hodge and projective graded lifts.

Choose ANY C4 over C3(z) and lift the original Z→C to it. Naturality
identifies the resulting upper Hodge obstruction with pullback of
rho_C(C4). Changing that upper W4 curve changes the class only by
im(Psi_Z). But a compatible upper W4 curve DOES exist, from the full
f-canonical source. Hence the pulled-back coker(Psi_C) class is zero.
Trace commutes with Psi (via its matched square-Hasse tensor and
etale Frobenius base change), and its composite with pullback is
the prime-to5 degree. Thus pullback on cokernels is injective, and
P_t(z)=0 follows. No choice of an averaged lift is needed.

This transfer in fact works for any actual prime-to5 intermediate
cover with the same one-dimensional defect, even if not Galois.

If the only root is0, this proves R1 in this Galois branch. If additional
roots occur, the computation identifies the surviving parameters; it
does not construct the other endpoint or an actual counterexample.
If P_t is identically zero, this next one-leg test cannot restrict R1,
and the research should move past it rather than requesting another
equivalent vanishing statement. The argument uses trace on an ACTUAL
prime-to5 intermediate cover, not a presumed simultaneous Galois closure.

The ten bad doubles in the family are one orbit under the order20
subgroup of PGL2(F5) fixing the omitted rational point4. It preserves
{0,1,2,3,infinity}; its action on the distinguished pair and bad pair
has orbit size10, exactly the existing twist table. This finite action
was checked exhaustively. Reparametrizing t by these fractional-linear
maps transports the one model and preserves t^5-t!=0. Thus a uniform
calculation for this model addresses every bad-double family, with
the naturally transported scalar normalization.

## Subsequent main-pair exclusion and target reassessment

The audited all-level theorem
[defect_preserving_etale_descent](../Theorems/Thm_defect_preserving_etale_descent.md)
now excludes this entire Galois one-defect branch for the unchanged
main pair, independently of P_t. It descends the full f-canonical
source to the genus-three carrier, then uses a uniform partner count;
it does not assert that the carrier's map to Y lifts. P_t remains
uncomputed, but is no longer needed for that exclusion.

The Pro run subsequently RETURNED; it was not broken. Its candidate
additive polynomial passed algebraic replay but has geometric audit
gaps; see [the returned result](W4_DEFECT_ADDITIVE_RESULT.md). An unchanged
resend is not recommended. The [carrier frontier](DEFECT_CARRIER_FRONTIER.md)
records the checked higher-defect and non-Galois limitations to use
when selecting a genuinely new, useful question.
