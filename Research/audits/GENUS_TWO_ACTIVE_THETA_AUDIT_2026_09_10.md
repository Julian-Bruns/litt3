# Focused audit: genus-two active theta

Verdict: PASS for the new characteristic-five reconstruction and Parts1--3
of the stated theorem. No blocking mathematical objection.

Auditor: /root/audit_genus_two_active_theta. Date:2026-09-10.
Scope: `Theorems/Thm_genus_two_active_theta.md` version1 and
`Solutions/Sol_genus_two_active_theta.md`, Sections1--6, as read this turn.
This is a bounded independent prose audit, not Lean verification.
The inherited tangent-bundle construction/stability/naturality and the
audited p-group obstruction theorem are inputs, not freshly audited in full.
No computations, endpoint changes, or canonical content edits were made.

## Reconstruction and specialization

The elementary globally-generated-bundle bound is valid: general s+1
sections generate a rank-s bundle on a curve, and absence of a dual
section makes the dual evaluation map injective on constants. The ensuing
rank exclusions, saturation of I at degree5, and quotient-degree proof
of stability of G_M all work in characteristic5.

The scheme-simple degeneracy argument was checked independently. In the
basis sa,sb,t of H0(K(p+q)), the multiplication relation's t-coefficient
must vanish at p and q. Conversely every such coefficient is attainable,
because the canonical-pencil multiplication is surjective. Thus the
rank-two evaluated image at p really is H0(M(-p-q)), in the stated
ambient fiber. The relation built using c has derivative outside that
image: evaluation at q detects it. This proves an elementary divisor of
order exactly one, not merely a set-theoretic rank drop. The exceptional
base-point case M=K²(z) is handled correctly. Generic reducedness of the
residual pair can also be seen from the degree-three linear series: its
base-point-free case is separable in characteristic5, and its base-point
case reduces to the separable canonical pencil. No inseparable generic
smoothness assumption is hidden here.

The degree5 image therefore spans all four sections, and two general
such subspaces span the seven-dimensional extension-dual space. This
establishes M²=K⁵. The six complementary-pair wedges then span the entire
exterior square. Riemann--Roch supplies the subbundle H0 vanishing needed
in the connecting-map test; it is not a negative-slope assertion.

The relative construction preserves the actual exterior-square
annihilator. Its quotient is locally free since 2 is invertible and the
fiber dimensions are constant. Consequently the lift remains a base
point on the generic fiber. The use of the complex classification and
the normalized Raynaud model is consistent with their exact scope in
[Pauly, Sections2.1--2.2](https://arxiv.org/pdf/0804.3001): it occurs after
this construction, not by importing the special-fiber classification.
The [2]-descent model extends over the DVR with finite etale equal-line
splitting on each fiber. A primitive generic isomorphism specializes
nontrivially; semistability of its source and stability of its target
force full rank and then an isomorphism. No flatness or reducedness of a
moduli base locus is used.

## Actual bundles, parity, and degree-five covers

The determinant claim is stronger than its degree and has been checked:
the jet transition has determinant u⁵ and the scalar system has trace
zero. Its determinant connection is precisely the canonical connection
on F*omega_(C^(1)), so Cartier descent gives det V_d=omega_(C^(1)).
This does not infer equality of lines from equality of their Frobenius
pullbacks. Wedge followed by etale trace supplies the asserted
nondegenerate canonical-valued alternating form on E_r. Its determinant
is omega²; twisting by a theta characteristic has trivial determinant.
The Frobenius-unstability contradiction and the separate split-double
rank-two argument are valid.

The parity input is the even theta-section statement of
[Hitching, Section1, Lemma2](https://arxiv.org/pdf/math/0604637).
Twisting the canonical-valued bundle by a theta characteristic turns it
into the trivial-valued symplectic bundle used there. Translation back
to Pic0 preserves the normalized even sign for order-four theta.
The written lifting argument is valid: the symplectic torsor has no
H2 obstruction on a curve, a lifted acyclic twist keeps its theta
section nonzero, and the involution eigenspaces specialize with 2
invertible. The normalized algebraic order-four conventions agree with
[Kopeliovich--Pauly--Serman, Sections1--2](https://math.univ-cotedazur.fr/~pauly/theta.pdf).

The [2](Theta) comparison is valid also against reducible/nonreduced
D_r. Its normalization is C, its numerical class is4Theta, and its six
Weierstrass preimages give multiplicity at least6 at zero. The local
intersection lower bound36 exceeds the total32. Containment forces
equality by ample intersection; kappa-invariance would then induce a
fixed-point-free involution of the genus-two normalization, impossible
by etale Hurwitz. Thus the multiplicity bound4 follows.

The six subgroup tangent directions are the six distinct F5-rational
lines after a basis choice for mu5². A nonzero degree-at-most4 initial
term survives on at least two subgroup schemes to order below5.
The one-entry minimal cohomology complex is justified by h0=h1=1.
Restriction computes a length strictly below5. Pushing the Poincare
line over the full nonreduced mu5 gives the regular representation of
the actual constant Z/5 torsor: its generator acts on
k[t]/(t⁵-1) by multiplication by t. This is the required representation,
not a decomposition into geometric character points. Projection formula
and Frobenius transport therefore give the actual upstairs tangent
dimension. The audited cyclic p-group theorem then kills every class
in the one-dimensional source cokernel on those covers.

## Objections and limits

No blocking objections or required proof repairs. The new theorem ID was
not yet registered when the metadata CLI was checked; root was informed
so its ongoing integration can register the statement and dependencies.
The conclusion remains a one-source obstruction-removal result. It does
not construct matching endpoint connections, a map-preserving repair,
or an unmarked common-cover exclusion.
