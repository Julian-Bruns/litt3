# Proof: trace descent for nilpotent germs and compatible Witt towers

[Statement](../../Theorems/deformations/defect_preserving_etale_descent.md).

## 1. Trace and the two relevant linear operators

Let d=deg h, prime to p. Normalized trace d^(-1)Tr_h splits pullback
on H^0(omega²), its Frobenius twist Q, and H^1(Tangent); no Galois
hypothesis is needed. Use Mochizuki's Verschiebung
V_C:S(C)→Q(C), with nilpotent fiber N(C)=V_C^(-1)(0), as in
[the scalar model, Section2](../projective_connections/nilpotent_scalar_model.md#2-n-equations-their-exact-length-and-infinity).

The derivative L_r=dV_C respects these splittings. Indeed, after an
etale local splitting of h, its pullback is the same linear differential
operator on every sheet, so it commutes with summation. On Q use trace
for h^(1); Tr(q^p)=Tr(q)^p and d^(-1) lies in the prime field.
The trace-zero source and target have equal dimensions. Equality(D)
of tangent defects therefore makes the trace-zero block invertible.

For the Witt assertion, now take k=bar(F5) and r admissible active.
The infinitesimal Verschiebung duality in
[forced canonical lifting, Section1](forced_canonical_witt_endpoint.md)
identifies the defect with dim ker(Psi), where Psi on H^1(Tangent) is
relative Frobenius followed by the square-Hasse multiplier. Frobenius
commutes with etale trace, and multiplication by a pulled-back tensor
commutes by the projection formula. Thus the trace-zero block of Psi
is also bijective: it has no kernel by(D), and k is perfect. Hence

    ker(Psi_T)=h*ker(Psi_C),
    h*:coker(Psi_C)→coker(Psi_T) is an isomorphism.       (1)

All relative twists are retained in this calculation.

## 2. The entire fixed-curve germ

Return to any odd characteristic. Center S(C),S(T) at r,h*r and choose
source coordinates x in the pulled-back quadratics and y in the
trace-zero complement. Let G(x,y) be the trace-zero component of V_T.
Etale naturality gives G(x,0)=0 as a polynomial identity, so

                            G(x,y)=A(x,y)y.

The square matrix A has invertible constant term by Section1.
Consequently (G)=(y) in the completed local ring. Modulo(y), the
remaining equations are exactly V_C(x)=0. This proves the full
scheme-theoretic germ isomorphism, without active admissibility.
The same elimination works wherever det A is invertible.

In particular, the germ k[[w]]/(w³) of
[the explicit bad double](abelian_covers/bad_double_cubic_defect.md)
persists under every prime-to-five cover satisfying(D).

## 3. Descending one next Witt step

Use the higher inverse-Cartier input in
[forced canonical lifting, Sections1–2](forced_canonical_witt_endpoint.md):
above a compatible C_n with its full previous filtered flow, graded
identification and square-trivial periodicity twist, a curve lift
C_(n+1) has obstruction rho_C in H^1(T_C). Variation by xi changes it
by -Psi_C(xi), and this construction is etale-functorial. Hodge-line
lifts are unique because H^0(T_C)=0; maximal graded Higgs
identifications are unique projectively.

Suppose a compatible T_(n+1) is given and its full W_n data have already
descended along the original h. Choose a reference curve lift
C_(n+1)^0, possible since H^2(T_C)=0, and lift h to obtain T_(n+1)^0.
Its obstruction is h*rho_C(C_(n+1)^0). The difference xi_T from this
reference to the given upper curve satisfies

                 Psi_T(xi_T)=h*rho_C(C_(n+1)^0).          (2)

Its trace-zero part is zero by the invertible complementary block of
Psi_T. Hence xi_T=h*xi_C for a unique xi_C. Changing the lower
reference by xi_C makes its induced cover the given marked upper
curve; (2) and injectivity of pullback make its Hodge obstruction zero.

The lower Hodge line and projective graded identification pull back
to the given ones by uniqueness. The periodicity twist is the unique
lift of its initial two-torsion line. Thus the entire previous-flow
tuple descends and is available for the next step. Uniqueness of the
lower curve and original map follows from uniqueness of xi_C and
[the marked deformation monomorphism](etale_refinement_deformations.md).

## 4. The full tower and its algebraization

The canonical W2 lift and initial flow commute with h by
[the first-lift dictionary](admissible_two_leg_w2_lifts.md).
Inductively apply Section3. Uniqueness makes the descended lifts and
maps compatible; conversely every lower compatible tower pulls back.

The formal lower curve is smooth and proper, with ample canonical
bundle, so Grothendieck existence algebraizes it over W(k).
The proper henselian finite-etale equivalence then algebraizes the
lift of h. Its truncations identify its source with the supplied upper
tower, as in [etale refinement](etale_refinement_deformations.md).
Only the complementary Psi block must be invertible; C may be
nonordinary. The argument descends existing towers and does not
supply their existence.

## 5. Counting the genus-three intermediates

For the coreless span in the statement,
[defect growth and two-leg strictness](section_growth/symplectic_p_cover_section_growth.md),
Sections1–7, give:

* r_X is ordinary;
* the Galois leg factors as Z−h→C−pi→Y_t, with pi a bad etale double;
* g(C)=3, d(C)=d(Z)=1, and deg h is prime to5.

Lift the original f-cover to the full canonical ordinary curve X^can.
Its source Z_f^can carries the pulled-back compatible flow, whose W2
data agree with those from C by the first-lift dictionary. Part2
descends this given tower along h, producing the actual bi-etale span

                       X^can ← Z_f^can → C^lift.          (3)

For each r_X, the [characteristic-zero partner bound](../curve_arithmetic/low_genus_arithmetic_bounds.md)
gives fewer than 2^80000000 genus-three geometric generic classes
C^lift. Stable-model uniqueness makes distinct special-fiber classes C
give distinct generic classes; see
[ordinary-source partner finiteness, Section2](../projective_connections/ordinary_source_partner_finiteness.md).
Each C has at most [three genus-two etale quotient classes](../quotient_geometry/hyperelliptic_etale_quotients.md),
each with at most [twenty family parameters](../curve_arithmetic/prime_field_branch_family.md).
Finally N(X) has at most 5^(3g(X)−3) points by Mochizuki's count.
Multiplying gives

                   B=60 · 5^(3g(X)−3) · 2^80000000.

The map pi:C→Y_t need not lift: only the genus-three intermediate is
placed in the bounded characteristic-zero partner set. Both maps in(3)
are actual lifts of the indicated original maps.

If X/F_q is fixed, q-Frobenius transports both maps, the matched
connections, Galoisness and defect. The entire orbit of t therefore
lies in the set counted by B, giving [F_q(t):F_q]<B.

For the prescribed main pair, 5^24<2^56 and 60<2^6, hence
B<2^80000062. Its existing prime parameter degree exceeds K, where
D=335999!, G=1+8D, L=336000² and K>=3^(4G²L).
Since D>=2^335998, we have K>2^(D²)>2^80000062.
Thus this pair excludes the Galois Y-leg active stratum of source
defect one. Defect zero was already excluded; the remaining active
source defect for a Galois Y-leg is at least two.

The argument gives no control on defect after a non-Galois leg's
Galois closure and does not exclude higher defects, dormant matches,
or spans without a matching connection.

The germ extension to every odd characteristic has bounded medium
audit PASS, /root/audit_extension_fiber_scope,2026-09-14. The Witt
descent and counting steps retain their
[scoped audit](../../Research/audits/DEFECT_PRESERVING_ETALE_DESCENT_AUDIT_2026_09_10.md).
