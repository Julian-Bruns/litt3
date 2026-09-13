# Proof: inverse incidence, Frobenius feedback and exact boundary scope

[Statement](../../Theorems/atlases/inverse_cup_atlas_system.md), Version6.
The general inverse-block, selected-column and minor-patch arguments
are proved once in [cohomological Bézout](cohomological_bezout.md).
We retain all former fixed-oper conclusions and their concrete evidence.

## 1. The full inverse equations are the atlas criterion

On every admissible section the top-left block of D^-1 is K(eta_u).
For the fixed curve K is injective, since L32·L32=L64. Thus specifying
that block recovers the normalized extension itself, even when r=3
and its rank is21. In scalar coordinates, twist the coefficients of
the ENTIRE Čech construction: the block becomes K(eta_u)^[5], B stays
quadratic and a,q stay linear in U. This is not substitution U->U^[5]
into a previously defined polynomial matrix.

Over any coefficient ring DG=I makes det D a unit and G the unique
inverse. The block equation Gamma(beta)=(D^-1)_11 is precisely the
Wronskian-one extension graph with eta=i^-1(beta) in J, after the stated
coefficient Frobenius base change. It introduces no extra nilpotents
or choices. The determinant is a constant times the same reduced
resultant Delta as in [the gradient theorem](resultant_gradient_atlas.md).
On this graph that theorem identifies the FULL projected R with

    i(R_U eta^[5])=-dlog Delta
                 =-(Tr(G partial_i D))_i.                (1)

Consequently all32 gradient equations are exactly the compact R
equations. The [compact-atlas theorem](compact_etale_atlas_system.md)
supplies finiteness, reducedness and reconstruction of actual atlas data.
These conclusions are not inferred from an equation count.

Let E0=diag(I_n,0_r). Mixed homogeneity gives

    sum U_i partial_i D=E0 D+D E0.

Contracting (1) with U yields U.beta=-2n=-48=2 in characteristic5.
The linear mixed blocks contribute2r to the radial trace, since
aX=Yq=I_r. Omitting them would give -2(n-r)=3 when r=3, instead of2.

## 2. Rooting and the three-column criterion

Apply [partial Frobenius feedback rooting](rooted_atlas_charts.md)
with x consisting of U and ALL inverse-block auxiliary coordinates,
y=beta, A=DG-I, and B_i=-Tr(G partial_i D). Both polynomial tuples
depend on beta only through beta^[5]. The lemma gives exactly (R),
including fifth powers on all auxiliary entries, as an isomorphism of
finite reduced schemes. It also identifies it as the reduction of the
raw substitution scheme; a geometric-point bijection alone would not
justify that conclusion. Weighted Euler in rooted coordinates gives
v.t=-2n=2. The degree bounds follow from the quadratic and linear blocks.

The multiplication map S·L32->L64 for S=<y,x^10,x^4 y²> is onto.
Since L64 is globally generated, S has no base point. The Bézout
selected-column theorem therefore gives the entire inverse-cup incidence
from those three columns over every coefficient algebra. Its proof
excludes boundary sections before inverting D, then uses split linear
injectivity of cup restriction; it applies equally to rank24 and rank21.
The same argument holds after coefficient rooting. On that normalized
incidence, (1) identifies the full compact s tensor with the full rooted
mixed trace t. Hence all32 equations b=s^[5] give precisely (C).

The auxiliary block has3r entries and is unique. Thus the equation and
variable counts follow immediately. Neither weak N equations, extra
normalization, a chosen nonzero minor nor a normal-corank assumption is
being used to remove a stratum.

## 3. The complete minor formulations

The Bézout theorem supplies Gamma=P Bbar^-1 L on each pair of maximal
minor opens and the determinant product with det(q0)det(a0). Its trace
identity gives the corresponding gradient, including derivatives of
the matrices P,L inside Bbar. All admissible sections lie on these opens.

For the fixed determinant det V=omega, use the same Serre-dual row and
column minor. Then a=q^T, L=P^T and Bbar is symmetric as a universal
identity on the localized polynomial ring, hence after any base change.
Symmetry of Gamma turns Gamma q=0 into both annihilation equations and
gives Gamma=P Z1 P^T. The remaining inverse condition is Bbar Z1=I.
Differentiating `det D=(-1)^r det(q0)^2 det Bbar` proves (S). This
retains all exceptional directions and both logarithmic contributions.

## 4. Boundary classes and the invalid jet family

In the stable extension conventions let E>0 be the zero divisor of u.
Its saturation gives

    0 -> L^-2(E) -> W L^-1 -> O(-E) ->0.

Because H0(O(-E))=0, the induced H1 map from L^-2(E) is injective.
Factoring the original u map through it proves the boundary kernel
formula. Stability gives deg E<ell, so H0(L^-2(E))=0. The principal-part
sequence then gives its dimension deg E. Cup product with these classes
factors through restriction to E, since a section vanishing on E kills
its principal part. This proves the rank bound, including multiplicities
and infinity. Here ell=24, giving rank<=23. A rank21 cup block cannot
therefore replace the full exceptional inverse criterion.

For the fixed curve identify E=H1(O(-48O)) with L64^vee by residues,
and J=Ann ker Q, dim J=32. In regular local oper and line frames at
any P, the scalar Q has order3 with invertible leading coefficient.
Evaluation of Q's output defines a nonzero functional eta_P on the
length-four jets of O(64O); these jets are separated by global sections
because H1(O(64O-4P))=0. It kills ker Q, hence lies in J, and its
third-jet coefficient makes its support exactly4P rather than3P.
This intrinsic regular-frame description also applies at O, despite
the pole of the chosen rational differential frame there.

Distinct P give distinct projective classes: L64 separates the union
of two length-four jets, by the analogous length-eight vanishing.
Sections of W(24O) vanishing on4P form a24-dimensional vector space;
the eight evaluation conditions are independent since the Serre-dual
obstruction is stable of slope -24+16+4=-4. Every such section pairs
with eta_P in the boundary kernel. Thus P varies in a curve and [U]
in P23, giving a24-dimensional family in projective N/J incidence.
Coefficient Frobenius transports the support construction and preserves
these dimensions. All its members are invalid quotients and have cup
rank at most4. Moreover i(eta_P) evaluates Q(L64)=S_U at P, so its
pairing with such U is zero. This directly contradicts the compact
radial normalization U.beta=2. Both inverse criteria exclude the family
as well; N incidence alone does not.

## 5. Exact evidence and limits of the shortcuts

The following retained computations concern their named tensors only.
The scheme equivalences above do not assume their numerical outcomes
for other opers.

- `wronskian_trace_linearization.sage` checks every coefficient of
  `-H(beta^[5])U-R_proj(U,beta^[5])=C N(U,beta^[5])` for the first oper,
  with a saved constant32 by64 matrix C. H is symmetric because it is
  the Hessian of the quadratic Tr(Gamma B(U)), holding Gamma fixed.
- `wronskian_polar_determinant_lines.sage` gives two deterministic
  projective lines with coprime det H and det Gamma, of degrees32 and24.
  Both leading matrices are invertible, so infinity is checked. Roots
  of det H are therefore cup-invertible points where H is singular;
  no such point is asserted to solve the remaining atlas equations.
- [The exceptional diagnostic](../../scripts/atlases/exceptional_inverse_cup_diagnostic.sage)
  and [its exact coefficient receipt](../../Research/computations/exceptional_inverse_cup_invariant0.json)
  reconstruct H0(V), the section space, Q, and the cup/q tensors, checking
  every kernel and fifth-power reconstruction. Its invariant_0 cup has
  rank21, but U->Gamma q(U) has rank29; three kernel basis directions
  have q ranks3,3,1. This disproves the proposed full-column-rank shortcut
  on the rank21 cup stratum. It does not produce an atlas.
- `check_rooted_inverse_cup.sage` replays12 sparse cubic inverse equations
  against original N/R provenance, including four diagonal units. The
  associated60-second diagnostic did not finish and did not test the
  full replacement (R); its raw evidence remains in
  `atlas-normalized-rooted-cubic-20260908` outside the repository.
- The nonzero56-square multiplication minor for S, all304,128 entries
  of the six-section quadratic Bézout reconstruction, and their sources
  are retained in [the Bézout proof](cohomological_bezout.md).

The full exceptional B/minor-patch tensors have not been exported. None
of these necessary ranks, chart identities or equivalent formulations
excludes a whole representative, any additional torsion twist or an
unmarked common-cover branch. The original problem remains unsolved.
