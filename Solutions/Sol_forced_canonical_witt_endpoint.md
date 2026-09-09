# Proof: canonical endpoint necessity, not automatic higher lifting

[Statement](../Theorems/Thm_forced_canonical_witt_endpoint.md).
Author /root,2026-09-09. Version1. Focused medium audit PASS,
/root/audit_forced_canonical_witt; no blocker. Its two requested
clarifications about the twisted input and canonical comparison are
included below. Inherited theorems were accepted as inputs, not re-audited.

The returned W3 Pro answer supplied(K) at n=2 and the forced canonical
Y3 necessity. The new work here is the all-level induction, its equality
of whole deformation functors, and the exact residual sequence(S).
No W3 existence claim is imported from that answer.

## 1. Higher inverse-Cartier input and its precise scope

Here is the source-based lifting fact used in the proof. Suppose a
rank-two maximal-Higgs periodic flow is already defined over C_(n-1),
relative to C_n, with its original Hodge line N_(n-1). A chosen further
curve lift C_(n+1) defines an inverse-Cartier flat bundle H_n over C_n.
The obstruction to lifting N_(n-1) as a line subbundle is

    rho_C(C_(n+1)) in H^1(C,Hom(N_1,H_1/N_1))=H^1(C,T_C).  (1)

The last identification is dual to the second fundamental isomorphism.
Changing the curve lift by xi changes(1) by -Psi_C(xi), where Psi_C
is the semilinear Frobenius / Hodge-projection map of the ORIGINAL
mod-five oper. Both the construction and(1) are etale-functorial.

[Lan--Sheng--Yang--Zuo, Section5, Proposition5.2 and Lemma5.3](https://arxiv.org/html/1404.0538#S5)
prove this variation at every n. Their Lemmas5.1 and5.4 supply the
maximal graded Higgs lift and the two-torsion lift. The detailed input
tuple after Definition5.5 includes the PREVIOUS filtered flat bundle
and its graded identification; a bare new Higgs bundle is not enough.
We supply this tuple inductively below. The local variation calculation
does not require ordinariness. Their ordinary hypothesis is used to
solve(1), not to define it or to prove the formula.

For clarity about functoriality, the construction first forms an
integrable p-connection from that tuple, then pulls it back by local
Frobenius lifts and glues by the Taylor formula. For a lifted etale
map choose the upper local Frobenius lifts by its etale lifting
property. Both the p-connection and the Taylor matrices then pull
back. The local off-diagonal errors for lifting N pull back as well.
Their Cech classes give(1). No trace or division by a map degree is
involved. At all levels relative Frobenius twists are transported
together; passing to absolute semilinear notation uses Witt Frobenius,
not a change of either original map.

The operator in(1) is Mochizuki's Phi^tau, up to the sign in the
variation formula. In his
[ordinary-curve theory, II2.12--2.13 and III Lemma2.6](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf)
it is Frobenius followed by the p-curvature/Hodge projection; III
pp109--114 construct the canonical ordinary lift by these successive
filtration-compatible choices. Thus if r_C is ordinary, Psi_C is
bijective and, above each canonical C_n, exactly one C_(n+1) has
rho_C=0. It is the next canonical curve lift. This is a statement
about an ordinary ENDPOINT; no ordinary-source compatibility theorem
is being applied.

For the finite-level canonical comparison specifically, the canonical
indigenous MF object supplies a projective maximal-Higgs periodic flow
at EVERY truncation (Mochizuki III Corollary3.3). Compare our flow with
this already existing canonical tower inductively: unique Hodge-line
and projective graded identifications align the previous data, then
bijective Psi_C makes the next filtration-compatible curve lift unique.
We do not apply an infinite MF characterization to a truncated object.

The normal line in(1) has negative degree. Consequently the possible
lifts of N, when they exist, form a torsor under H^0(C,T_C)=0.
They are unique. Their second fundamental map stays an isomorphism
by reduction modulo5 and Nakayama. Hence their associated graded
Higgs object is again maximal.

## 2. Projective data and two-torsion choices

An admissible active oper supplies the initial maximal-Higgs flow
relative to its canonical W2 lift. Equivalently, use the normalized
FL dictionary and Mochizuki II Proposition2.10. For an SL2 realization
choose a theta line L_C. The maximal graded Higgs object is

              L_C direct-sum L_C^(-1),
              theta: L_C -> L_C^(-1) tensor omega_C.

The graded object after inverse Cartier can differ by a two-torsion
line kappa_C. This is permitted, and gives a two-periodic flow. It
must NOT be silently set to the trivial line.

For the comparisons, one may either work projectively, or trivialize
the difference between the pulled-back theta choices by a fixed finite
etale double refinement of Z. The latter preserves the ENTIRE marked
deformation functor and(J), by
[etale refinement](Sol_etale_refinement_deformations.md). The square-
compatible theta identification lifts uniquely over nilpotent bases.
The kappa lines also lift uniquely as two-torsion; their pullbacks
match because the filtered bundles do. Thus the construction works
on both legs simultaneously without assuming a split canonical double.

Once the Hodge line lifts, its square is omega by the determinant and
second fundamental isomorphisms. The associated graded object is the
unique lift of its old maximal graded Higgs object. Its identification
with the original graded object tensor kappa is unique PROJECTIVELY:
graded automorphisms commuting with the nonzero Higgs isomorphism
are scalar. Scalar choices in an SL2 presentation can be adjusted to
lift the previous choices; they disappear projectively. This supplies
the full previous-flow tuple needed for the NEXT use of Section1.
Explicitly, in LSYZ notation this tuple is

    (E_n,theta_n, Hbar_(n-1),nabla_bar,Fil_bar,psi_bar),
    (Hbar_(n-1),nabla_bar)=(H_(n-1),nabla_(n-1))
                           tensor(kappa_(n-1),nabla_kappa),
    Fil_bar=Fil_(n-1) tensor Fil_tr,

with the graded identification induced by the previous periodicity
isomorphism. The twisted flat bundle in this input is not the untwisted
flat bundle whose Hodge line is now to be lifted. The two differ by
kappa_(n-1); all these twists are included in the two-leg comparison.

## 3. Induction on EXISTING simultaneous curve lifts

The [canonical W2 dictionary](Sol_admissible_two_leg_w2_lifts.md)
gives one simultaneous W2 diagram. Since(J) holds, the full marked
diagram has no tangent directions and its ring is W/(5^e), by
[the deformation-ring theorem](Sol_etale_refinement_deformations.md).
In particular its W2 diagram is unique. Every given W_N diagram
therefore reduces to this one. The initial projective flow data match
on its special fiber, including the specified original Hodge lines.

Assume a diagram has been given over W_(n+1), and the induction has
already supplied compatible flow data through W_(n-1), relative to
its W_n reduction. The unique maximal Higgs lifts over the W_n curves
match under both maps. The FULL previous-flow tuple also matches by
induction. Higher inverse Cartier therefore gives matching projective
flat bundles H_(X,n), H_(Y,n) on the two endpoints and H_(Z,n) on the
same source. Naturality of the Hodge obstruction yields

    rho_Z(Z_(n+1))=f*rho_X(X_(n+1))=g*rho_Y(Y_(n+1)).     (2)

These classes lie in the two prescribed tangent images. Apply(J)
FIRST to get rho_Z=0, then individual H^1(T) pullback injectivity
to get rho_X=rho_Y=0. Injectivity alone would not justify that step.

The Hodge lines consequently lift on all three curves. Their unique
upper lifts agree along both maps. Section2 extends the compatible
projective periodic data through W_n. On Y, the inductive curve
Y_n is canonical, and Psi_Y is bijective, so rho_Y=0 forces

                        Y_(n+1)=Y^can mod5^(n+1).        (3)

This proves the induction. The source in(3) is the unique lift of its
specified finite etale g-cover. Marked identifications are unique
since H^0(T)=0. If a double refinement was used for rank-two notation,
the resulting statement about the original curve diagram follows from
the same refinement equivalence. No new endpoint or embedding is used.

The order of quantifiers matters: we assumed an actual W_(n+1) curve
diagram before writing(2). The vanishing in(2) cannot construct such a
diagram. It only constructs its compatible filtered data one level
lower and identifies the endpoint of a diagram that already exists.

## 4. Equality of deformation functors, not just Witt-valued points

Let R=W/(5^e) be the prorepresenting ring. If e is finite, its universal
diagram is itself a W_e diagram, so its Y-curve is canonical by Section3.
If e is infinite, every truncation is canonical, compatibly by marked
uniqueness, so the universal formal Y is the canonical formal curve.
Thus the universal diagram over R has Y fixed to Y^can. Base change
proves that EVERY deformation over EVERY Artinian W-algebra has this
property. Conversely it is tautologically a deformation if it belongs
to that fixed-endpoint subfunctor. This proves equality of functors.

This argument uses the representing ring. It does not assume that
arbitrary Artinian bases can be tested merely by their W_n-valued points.
The equality fixes where the obstruction must be tested; it neither
bounds e nor proves that5 is nonnilpotent.

## 5. The exact residual obstruction and its two components

Suppose a diagram has reached W_n, n>=2. Choose arbitrary next endpoint
curve lifts, and call the two induced source lifts tau_f and tau_g.
For d=tau_g-tau_f in V_Z, naturality and the variation formula give

    g*rho_Y - f*rho_X = -Psi_Z(d).

The left side lies in A+B, so barPsi([d])=0. Its class is the usual
two-leg obstruction o_(n+1). This proves(K) at every REACHED level.

For the residual sequence, the etale maps identify V_X direct-sum V_Y
with A+B by(J) and negative-H1 injectivity. Apply the snake lemma to

    0 -> V_X direct-sum V_Y -> V_Z -> Q -> 0

and the three semilinear Psi maps. One can first linearize Frobenius
over the perfect field k, so the usual vector-space snake lemma applies.
Since ker Psi_Y=coker Psi_Y=0, the result is exactly(S).

There is a concrete interpretation of its connecting arrow. Fix the
canonical next Y lift and its source tau_g, so rho_Y=rho_Z(tau_g)=0.
For an arbitrary next X lift with source tau_f, the same calculation
gives Psi_Z(d)=f*rho_X. Thus the connecting image of o_(n+1) is the
class of rho_X in coker Psi_X (with sign changed if the opposite
convention for d is chosen). If this class vanishes, adjust X to
make rho_X=0. The still-possible source mismatch is then in ker Psi_Z,
modulo the pulled-back ker Psi_X. Neither contribution is discarded.

Finally, a semilinear endomorphism of a finite-dimensional space over
a perfect field is bijective on its stable image. Consequently(K)
makes stable-image containment of o_(n+1) equivalent to its vanishing.
It is not a new sufficient condition easier than the original problem.

## Boundary of the result

The actual remaining test is f-descent of the fixed canonical g-source
at the next level. A canonical curve exists on Y at all levels, but no
existence statement for that descent has been proved. Source indigenous
nonordinariness, the possible nilpotent quotient direction, and finite
Witt height all remain. No common-cover case is excluded by this lemma
alone. In particular it is not a replacement for the ordinary-COMMON-
source hypothesis in the previously proved full-lifting theorem.
