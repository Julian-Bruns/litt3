# Audit: the parameterized bad-double abelian A3 germ

Verdict: PASS on the stated parameter domain.

Auditor: /root/audit_parameterized_bad_double_germ.
Date: 2026-09-11. This is a bounded independent mathematical audit,
not Lean verification. No coefficient correction was found.

## Exact scope

For the actual genus-three pair in
`Research/PRO_BAD_DOUBLE_ABELIAN_GERM_REQUEST.md`, the returned proof and
certificate establish

    f_t ~ UV + W^4

whenever

    Delta(t) = (t^5-t)(t^2+2t+3) != 0.

Consequently every actual maximal balanced (Z/5^n)^3 cover has defect

    (7*5^(2n)-3)/4, n >= 1.

This includes alpha^3+alpha+1=0 and every algebraic parameter of degree
at least three over F5. It supplies the stated lower bound on defects
of further actual etale covers dominating these balanced covers. It
does not supply a second endpoint map, an arbitrary-cover formula, or
a common-cover exclusion.

The existing fixed-specialization theorem
`bad_double_abelian_a3_specialization` is retained as an established
input and numerical benchmark. Its proof was consulted for the actual
cover presentation and the finite-to-formal mechanism, not reopened
as a separate audit.

## 1. The passage from the actual cover to Picard coordinates is valid

For the actual elementary-abelian torsor h:T_5 -> C, the regular function
module h_*O is locally free of rank one over O_C tensor k[G]. Here G is
abelian, so this is an honest line bundle over the product with the
Artin parameter scheme. A local normal generator is
w_1^4 w_2^4 w_3^4. The augmentation specialization is O_C via the norm/
trace identification; it should not be confused with the constant
function, whose degree-125 trace is zero. The local generator has
nonzero trace and gives the required identification.

On polynomials of w-degree at most four, translation by one has
logarithm d/dw. Thus a change w_U=w_O+chi acts on the normal generator
by

    exp(chi log(1+e))

through parameter degree four. This is a polynomial identity with
denominators 1,2,3,4 only. Tensoring the three identities gives the
displayed exponential cocycle. The argument never uses a
characteristic-zero exponential through degree five or beyond.

On the Frobenius-twisted curve, the coefficients of the actual
Artin--Schreier classes are transported by coefficient Frobenius.
The abstract e_i are unchanged. Ordinariness makes the three fixed
classes a k-basis of H^1(O_C), so the classifying map to Picard has
invertible tangent map. Picard is smooth of dimension three.
Restricting to the quotient by m^5 consequently identifies the two
order-four parameter neighborhoods.

Only this order-four identification is needed. One may extend the
resulting polynomial coordinate change to a formal automorphism; no
assertion that every full formal Picard deformation is an actual
infinite etale-cover character is required.

The projection formula identifies H^1(E tensor h_*O) with the actual
upper defect cohomology. Twisting the defining sequence of E gives
the asserted map

    H^1(T_(C^(1)) tensor L) -> H^1(T_C tensor Fr^*L).

This is the actual cohomological presentation, not a substitute
bundle with coincident special-fiber dimensions. The two external
references used in this step support exactly the needed facts:
[projection formula, Lemma 20.54.2](https://stacks.math.columbia.edu/tag/01E6)
and [smoothness and dimension of Picard, Lemma 44.6.7](https://stacks.math.columbia.edu/tag/0B9R).

## 2. The Laurent-polynomial splitting is an exact Cech model

Take the two actual affine opens C minus its two infinity points and
C minus the points over u=0. Their overlap has coordinate ring

    k[u,u^-1,kappa,ell]/(kappa^2-u(u-3),
                        ell^2-(u-1)(u-2)(u-t)).

The finite branch divisors of the two quadratic equations are disjoint
on t^5-t != 0. The four components 1,kappa,ell,v give its free
Laurent-polynomial decomposition. The differential eta=du/v has no
finite zero or pole and order two at each infinity point. Therefore
a tangent coefficient in the eta^-1 frame must have order at least
two at both infinity points.

The component valuations give exactly these infinity bounds:

    1: j<=-1; kappa: j<=-2; ell: j<=-3; v: j<=-4.

The deck-character decomposition prevents cancellation of a forbidden
principal part between distinct components: both infinity conditions
are imposed, and the order-four deck group is semisimple in
characteristic five. Nonnegative powers are affine. The six residual
monomials are precisely the basis in the returned proof. For O_C the
same calculation leaves v/u, v/u^2, ell/u.

This justifies the exact projections P and R_infinity. It is not an
asymptotic Laurent-series assertion requiring an unspecified cutoff.

For either negative tangent line twisted by a formal degree-zero line,
H^0 vanishes and H^1 is free of rank six over the Artin parameter ring.
The unchanged six cochains therefore lift to bases of both twisted
H^1 modules by Nakayama and cohomology/base change. No additional
source-column correction is omitted by keeping those representatives.

## 3. The twisted matrix recursion computes the stated map

Relative Frobenius sends u' to u^5, kappa' to kappa R^2, ell' to
ell S^2, and v' to v F^2, while fixing the formal parameters X,Y,Z.
After dividing the injection by the unit (t+1)^2, its image of a source
basis cochain is exactly G b_j^5. This verifies both the initial
columns and the displayed pulled-back cocycle D.

In the target quotient, an ordinary infinity part r can be replaced
by -(exp(D)-1)r. Iterating this identity gives the recursion (1), with
P(h_n) furnishing the coefficient in the fixed target basis. The
source also has a twist, but its unchanged basis cochains are valid
lifts as explained above; the target recursion is therefore enough
to compute their images.

I inspected the generic implementation. Its four-component
multiplication uses kappa^2=R, ell^2=S, v^2=F correctly, its cutoff
matches the exact infinity module, and its factorials are truncated
at total degree four. The Schur operation is two-sided and makes no
self-adjointness assumption.

## 4. The quartic and the specialization domain have no missing factor

The invertible constant blocks have determinants

    (t+1)(t^5-t), (t-1)(t-2).

Thus their formal inverses exist throughout t^5-t != 0. Every matrix
coefficient before Schur elimination is a polynomial in t, so all
Schur coefficients belong to the localization at these determinants.
There is no unrecorded extension-field denominator. The omitted
normalization factor (t+1)^2 is a unit on the same domain.

The computed scalar jet is

    f_1=f_3=0,
    f_2=3D X^2 + 4D/(t+1)^2 Z^2,
    [Y^4]f_4=3,
    [XY^3]f_4=2t(t^4+3).

The radial quartic includes every Schur repair term. Its two
contractions are t^7+3 and t^7, giving their difference 3. It is not
the exceptional matrix entry alone.

Since the cubic part is zero, the transverse critical solution begins
in order three. In particular

    X(W)=-2t(t^4+3)/D * W^3 mod W^4,
    Z(W)=0 mod W^4.

The quadratic form evaluated on these repairs starts at degree six.
The corrected one-variable quartic is therefore exactly 3W^4. This
is consistent with, rather than a replacement of, the nonzero
quadratic transverse repair in the original deck coordinates: the
deck-to-Picard coordinate change is nonlinear.

The only extra factor needed in the stated domain is the already
supplied ordinary-Jacobian condition t^2+2t+3. Independently, the
u^4 coefficient of ((u-1)(u-2)(u-t))^2 is t^2+2t+3, agreeing with
the elliptic Prym Hasse invariant. Exact reduction of Delta modulo
t^3+t+1 is -t^2, which is nonzero at alpha. All roots of Delta have
degree at most two over F5.

## 5. The four-jet suffices for the full formal and all-level assertions

The rank-two transverse Hessian splits off formally because 2 is
invertible. The remaining one-variable series is 3W^4+O(W^5). Its
unit factor has a formal fourth root because 4 is invertible. Thus
every possible higher term of the actual completed scalar relation
is absorbed, giving UV+W^4. This argument does not divide by any
integer divisible by five.

The established compatible actual-cover presentations identify the
four-jet just computed with that of the completed relation f_t.
An isomorphism of its cyclic presented module changes the scalar
principal ideal only by a unit. The finite Picard coordinate change
extends formally, so the formal-type conclusion applies to f_t itself.

For q=5^n, the ideal generated by the q-th powers of formal parameters
is m^[q], which every formal automorphism preserves in characteristic
five. Therefore arbitrary normal-form coordinates preserve the
balanced truncation ideal. This is why the result holds for balanced
covers; an arbitrary unbalanced truncation would need another argument.

The semigroup presentation of UV-W^4 has basis indexed by pairs
(a,b)>=0 with a=b mod4. Quotienting by U^q,V^q,W^q retains exactly
a,b<4q with a<q or b<q. This gives (7q^2-3)/4 for q=1 mod4. The
reported values 43,1093,27343 are correct for q=5,25,125. Pullback
of sections of the actual E is injective under further finite etale
covers, so the final domination lower bound follows.

## Verification and provenance

Returned bundle inspected at

    /Users/julian/Documents/litt3-computation-data/
    quartic-parameter-audit-20260911-T4Ydbg/quartic_certificate

The main agent separately replayed the full generic certificate and
the independent infinity-expansion audit. It reported PASS for the
complete matrix/scalar four-jet, alpha, both benchmark parameters,
enlarged Laurent precision, the Artin--Schreier coefficient-Frobenius
checks, and both old transverse repair coefficients. Those executions
are not claimed as independently rerun by this auditor.

Additional small checks by this auditor verified, with elementary
mod-five matrices, that log(translation by one) is differentiation
on 1,w,...,w^4 and that its truncated exponential gives every scalar
translation in F5. Independent direct semigroup enumeration gave
lengths 1,43,1093,27343 at q=1,5,25,125. These checks accompany the
geometric proof above, rather than substitute for it.

No substantive objection remains. The family theorem is suitable for
canonical integration with exactly the scope stated at the top.
