# Proof record: Cofinal saturation of inherited Raynaud theta directions

Canonical statement: [`raynaud_cofinal_saturation`](../Theorems/Thm_raynaud_cofinal_saturation.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Every finite collection of old Jacobian directions can be made theta-bad

Author: /root, 2026-09-06. Status: direct corollary of Raynaud's
Theorem2 and Proposition1(5); independently audited PASS by
`/root/raynaud_cofinal_refinement_major_audit`, 2026-09-06.
[Verdict and non-breaking observations](../routes/global/RAYNAUD_THETA_SATURATED_REFINEMENTS_ARE_COFINAL_AUDIT.md).
Not a new literature theorem or a counterexample to Litt3 or to the
JOINTLY MINIMAL two-leg theta claim.

## Exact theorem

Let C be a smooth projective connected curve of genus at least two
over an algebraically closed field of characteristic p>0. Put
B_C=F_*O_C/O_(C^(1)), and let Theta_C be its Raynaud theta divisor.

1. There is a connected finite etale Galois cover q:W->C, with
   solvable group of order prime to p, such that

       H^0(W^(1), B_W tensor q^(1)*L) != 0
       for EVERY L in J(C^(1))(k).                         (1)

   The covering degree can be bounded in terms of p and g(C) alone.
2. Covers satisfying (1) form an upward-closed cofinal collection
   among connected finite etale covers of C. Here the total cover
   of C in the cofinal assertion need not have prime-to-p degree.
3. Fix ANY actual finite bi-etale span X<-f-C-g->Y. Above every
   prescribed connected finite etale refinement V->C there is another actual
   refinement W->V for which

       H^0(W^(1), B_W tensor
           (f q)^(1)*L tensor (g q)^(1)*M) != 0            (2)

   for EVERY (L,M) in J(X^(1))(k) times J(Y^(1))(k),
   where q:W->C is the composite. All further refinements of this
   W still satisfy (2).

Thus no cofinal subsystem of refinements of a fixed span can have
generic vanishing on its fixed two-endpoint Jacobian parameter space.
This remains true when the original span is jointly minimal.

## Proof

Raynaud's Theorem2 gives a finite prime-to-p solvable group G,
depending only on p and g(C), a connected etale G-torsor W->C,
and a representation rho through G having no theta divisor. His
Proposition1(5) says exactly that this forces
q^(1)*J(C^(1)) to be contained in Theta_W.

For an explicit verification, write E_S for the associated bundle on
C^(1), using the torsor W^(1)->C^(1). The algebra k[G] is semisimple. Some simple
constituent S of rho has

       H^0(C^(1), B_C tensor E_S tensor L) != 0

for generic L: otherwise the finite intersection of the good open
sets for its constituents would make rho good. The same nonvanishing
holds for EVERY L by semicontinuity. The regular representation
contains S; projection formula and etale base change for B give
(1). Using the fixed group G gives the degree assertion.

If r:T->W is finite etale and connected, pullback injects each space
in (1) into its analogue on T. This proves upward closure. Given
V->C, either take a component of V times_C W, or apply assertion1
to V. In the latter case it gives nonvanishing for every class from
J(V^(1)), hence in particular every class pulled back from C.
This proves cofinality, and the map W->V in this construction can
be chosen Galois with prime-to-p solvable group.

For assertion3, the bundle
f^(1)*L tensor g^(1)*M belongs to J(C^(1)). Apply assertion2 and
pullback functoriality. Both maps remain finite etale from the SAME
source W. No Jacobian-factor substitute is used. QED.

## What changes, and what does not

The [earlier cyclic-tower boundary](../routes/global/CYCLIC_TOWER_NEW_ORDINARITY_AND_FIXED_SUPPORT_BOUNDARY.md),
Section4, already used the same no-theta representation to obtain
unbounded nonordinary defect. The additional point recorded here is
the universal quantifier over ALL old Jacobian directions and the
cofinal refinement consequence. File22 had cited Raynaud primarily
for failure of ordinarity under etale covers.

If the original span is jointly minimal, these new two-endpoint
presentations factor through C; the construction does not produce
a new jointly minimal image. It therefore does NOT disprove generic
two-leg vanishing on a jointly minimal span. Nor does it preclude
vanishing after enlarging the parameter space using new Jacobian
directions upstairs: Raynaud's theorem says Theta_W is proper in
the FULL J(W^(1)).

A proposed tower bridge must address this loss of minimality and
change of parameter space explicitly. A bridge claiming that generic
vanishing on the fixed endpoint directions can be retained cofinally
is false, not merely unproved.

## Primary source and proof location

M. Raynaud, *Revetements des courbes en caracteristique p>0 et
ordinarite*, Compositio123(2000),73--88,
[primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).
Theorem2(ii), p76, is the no-theta assertion; Proposition1(5),p75,
is the Jacobian-containment equivalence. Theorem17 and Corollary18,
p85, construct the bad representation using a divided polarization
and a line subsheaf of B_C. The proof of Theorem2 on pp85--86
first passes to a prime-to-p cyclic cover to meet the numerical
conditions and then induces the representation. Remark20(1),p86,
explicitly states that the regular representation has no theta divisor.
The proof is for EVERY curve, not just a generic curve.
