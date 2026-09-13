# Proof: the parameterized abelian quartic defect relation

[Statement](../../Theorems/deformations/bad_double_abelian_a3_family.md).
The original generic certificate and independent Laurent audit establish
the actual four-jet; relative formal splitting determines its full type.

## Actual cover modules and the Picard four-jet

The curve and active admissible pair are those in the statement. The established
bad-double calculation gives ordinary Jacobian, defect1 and a rank5 constant
Hodge presentation on the stated domain. The actual defect bundle is

    E_r=coker(T_(C^(1)) -> F_(C*)T_C),

with H0 and H1 identifying its kernel and obstruction cokernel. It commutes with
actual etale pullback. The actual balanced cover tower has a six-generator
presentation over Lambda=k[[e1,e2,e3]]; elimination of its rank5 constant block
leaves one scalar f. This follows from free negative cohomology and the
[actual-cover norm/base-change theorem](abelian_p_defect_node.md):
lift the constant unit pivot in each finite quotient and take compatible
free bases in the inverse limit.

Let h:T_5->C be the actual maximal elementary abelian cover, and
R=k[e1,e2,e3]/(e1^5,e2^5,e3^5). The sheaf h^(1)_*O_(T_5^(1)) is an invertible
O_(C^(1)) tensor R module: a local normal generator is w1^4w2^4w3^4.
Its augmentation is O_(C^(1)) via trace, not via the constant function.
Projection formula identifies cohomology of its tensor product with E_r with
the actual cover defect cohomology. This is the finite-locally-free projection
formula, [Stacks Lemma20.54.2](https://stacks.math.columbia.edu/tag/01E6).

For an Artin--Schreier overlap w_U=w_O+chi, translation of the normal generator
is(1+e)^chi. Through total parameter degree4 this is
exp(chi log(1+e)); all denominators are units. On C^(1), the coefficients of
the actual classes chi are raised to fifth powers; e itself is not.
Ordinarity says these three classes span H1(O_(C^(1))). Thus the classifying
map of this line bundle into Pic^0 has invertible tangent map. Pic^0 of a
genus3 curve is smooth of dimension3, by
[Stacks Lemma44.6.7](https://stacks.math.columbia.edu/tag/0B9R).
It follows that the order4 deck neighborhood is identified with an order4
Picard neighborhood. An invertible order4 coordinate change extends formally.
The ideal(e1^5,e2^5,e3^5) has no terms of degree<5, so the entire4-jet of f
is determined in this finite cover.

Twisting the defining sequence by a formal Picard line L presents the defect by

    H1(C^(1),T_(C^(1)) tensor L)
        -> H1(C,T_C tensor Fr^*L).

Both terms are free of rank6 at the required Artinian precision: their H0
vanishes and Riemann--Roch gives rank6. The old six cochain representatives
still form free bases by reduction and Nakayama. Hence one computes their
images in the twisted target quotient; no invented source Hodge repair is used.

## Exact Laurent-polynomial computation

Put R0=u(u-3), S=(u-1)(u-2)(u-t), ell=v/kappa. Then

    kappa^2=R0, ell^2=S, v=kappa ell.

On C minus its two infinity points, the coefficient ring in the eta^-1 frame,
eta=du/v, is the biquadratic algebra with basis1,kappa,ell,v over k[u].
The other affine is C minus the fiber u=0. On their intersection use Laurent
polynomials in u. At both infinities, orders of(u,kappa,ell,v,eta) are
(-2,-2,-3,-5,2). In the four components1,kappa,ell,v the infinity tangent
modules consist respectively of powers u^j with

                         j<=-1,-2,-3,-4.

Nonnegative powers are affine. The two independent involutions separate
components and exclude hidden cross-component cancellations. Thus the six
remaining tangent cochains are exactly

             B=(v/u,v/u^2,v/u^3,ell/u,kappa/u,ell/u^2).

This is a two-affine Cech calculation, not an unbounded Laurent precision
assumption. Let P and Rinf be the cohomology and infinity projections.
The analogous O-cohomology basis is(v/u,v/u^2,ell/u).

Use exp(Bpic) through total degree4 on C^(1), with

    Bpic=X v'/u'+Y v'/u'^2+Z ell'/u'.

Its relative Frobenius pullback is exp(Dloc), where

    Dloc=X vF^2/u^5+Y vF^2/u^10+Z ell S^2/u^5.

Relative Frobenius fixes X,Y,Z. Divide the injection by the unit(t+1)^2,
leaving coefficient G. For source basis vector b_j put h_(j,0)=G b_j^5.
The twisted infinity lattice is exp(Dloc) times the old one, so recursively

    h_(j,n)=-sum_(a=1)^n Dloc^a/a! * Rinf(h_(j,n-a)),
    M_n[:,j]=P(h_(j,n)),                  1<=n<=4.

This computes all six columns over F5[t] by finite Laurent-polynomial
arithmetic. The script performs the full two-sided Schur complement, not a
self-adjoint surrogate. The exceptional index is kappa/u. The good constant
block splits into

    [3t^2+2t, t+3,       1;
     4t^2,   2t^2+4t,   3t+2;
     0,      3t^2+4,    t^2+t+1]

and

    [3t+1,       3t+3;
     t^2+3t+1,  t^2+4t].

Their determinants are(t+1)(t^5-t) and(t-1)(t-2). Therefore the calculation
specializes on t^5-t!=0. Its full exported scalar4-jet has

    f_2=3D X^2+4D/(t+1)^2 Z^2, D=t^5-t,
    f_1=f_3=0, [Y^4]f_4=3, [XY^3]f_4=2t(t^4+3),

and every coefficient with odd Z exponent is zero. Two actual involutions
explain these parity checks, but the computation independently verifies them.

## Both corrections and the formal type

On the Y-axis the relevant anti-invariant block has shape[B,b;c,d], with
B0 the displayed invertible2x2 matrix. Its first coefficients satisfy

    b1=(2t,4t^2+1)^tr, c1=(3t^3+3t^2,4t^3), d2=3t^2,
    B0^-1 b1=(1,3)^tr, d2-c1 B0^-1 b1=0.

The full quartic Schur coefficient is

    d4-c3 B0^-1 b1-c1 B0^-1 b3+c1 B0^-1 B2 B0^-1 b1.

Its first two terms give t^7+3; the remaining subtracted contraction gives
t^7. The resulting3 is thus after all invertible-block repairs, not the
exceptional matrix entry alone.

The Hessian has rank2, radical the Y-axis. Setting Y=W and solving the two
transverse critical equations gives

    X(W)=-2t(t^4+3)/(t^5-t) W^3 mod W^4,
    Z(W)=0 mod W^4.

There are no cubic terms, so both repairs start at order>=3. Their quadratic
contribution begins at order6. The corrected radical restriction is therefore
3W^4 mod W^5. In other deck coordinates there can be quadratic transverse
repairs; the logarithmic coordinate change accounts for them, rather than
discarding them.

Formal implicit elimination and splitting of the nondegenerate transverse
quadratic form give a binary nondegenerate form plus g(W)=3W^4+O(W^5).
Only inversion of2 is used in that formal splitting. Inversion of4 gives a
fourth root of the unit g(W)/(3W^4), so the one-variable factor becomes W^4
after scaling; over algebraically closed k the binary form is UV. Hence
f is formally equivalent to UV+W^4. No higher unknown jet can change this type.

The only extra factor beyond t^5-t is the established ordinary-Prym condition
t^2+2t+3, needed for the actual three-direction Picard identification.
Exact reduction gives Delta(alpha)=-alpha^2 for alpha^3+alpha+1=0. Every root
of Delta has degree at most2, proving both main and backup specializations.

## Every balanced level and actual dominating sources

For q=5^n, the [Frobenius truncation lemma](frobenius_truncated_hypersurfaces.md)
with Q=R=q and s=4 gives the actual balanced defect (7q²−3)/4.
Pullback of H0(E_r) into every further actual finite etale cover is
injective, giving the asserted lower bound on dominating sources.

## Replay and provenance

Canonical executable scripts:
[generic four-jet](../../scripts/genus_two/parameterized_bad_double_four_jet.py) and
[independent Laurent audit](../../scripts/genus_two/audit_parameterized_bad_double_laurent.py).
The generic script requires SymPy, available in the existing Sage Python;
the independent script uses NumPy and explicit small-field tables.

The generic script reproduces the complete original matrix/scalar JSON
byte for byte. The independent Laurent
audit passed at alpha, the F625 benchmark and the separate degree4 parameter,
including enlarged precision. It recovered all benchmark quadratic coefficients,
the corrected quartic3a+3a^2, and both previous transverse repair coefficients.
Its independent125x125 normal-form multiplication matrix has rank82/length43;
the lengths at q25 and q125 are1093 and27343.

Original bundle and regenerated data reside at
/Users/julian/Documents/litt3-computation-data/quartic-parameter-audit-20260911-T4Ydbg/quartic_certificate.
Every supplied SHA256 checksum passes. See the focused
[audit verdict](../../Research/audits/PARAMETERIZED_BAD_DOUBLE_GERM_AUDIT_2026_09_11.md).
These are exact computation plus audited prose, not Lean verification.

The earlier t²+2=0 specialization lies in the same domain. Its
[independent six-column audit](../../Research/audits/BAD_DOUBLE_ABELIAN_GERM_AUDIT_2026_09_11.md)
and original actual degree125 data remain as a separate verification
of the family theorem. That audit records its precise Artin–Schreier
basis, all Laurent columns and the corrected quartic3a²+3a. The generator
[bad_double_abelian125_module.sage](../../scripts/genus_two/bad_double_abelian125_module.sage)
and the full original receipt are retained.
