# Focused audit: all-power late cyclic descent

Verdict: **PASS for the stated late range n >= a+1, a >= 2**, with the
explicit scalar-recurrence clarification below incorporated in the proof.
This is a proof expansion, not an additional geometric hypothesis.

Auditor: /root/audit_cyclic_power_late_descent. Date: 2026-09-10.
Scope: [the canonical proof](../../Solutions/Sol_cyclic_power_late_descent.md),
especially Section3's
elimination of every required preceding-oper digit. The canonical
cyclic25 theorem and all-power additive norm theorem are inherited
inputs. No early cyclic125 comparison, full all-power tower descent,
or common-cover exclusion is certified here. This is audited prose,
not Lean verification.

## 1. The all-digit scalar recurrence must be explicit

Put p=5, m=n-1 and M=m+a+1, the exponent of the modulus for the final
flat/Hodge comparison. The actual and auxiliary data agree modulo
p^m. In particular, their local preceding-oper scalars have difference

    r_actual-r_aux = p^m R.

The scalar R is needed only modulo p^(a-1): the inverse-Cartier response
to a preceding scalar change gains p^2. The Hodge graph is p^m u;
its truncation needed to normalize that preceding oper is the reduction
of this SAME u. Choose all local module identifications compatibly
under reduction and use the specified periodic tuple for this assertion.
It is not permissible to substitute an independently chosen preceding
Hodge repair or assume that the actual preceding scalar descends.

One can now write the local normalization equation, at its required
precision, as

    R = V + A(X) + D(u) + K_r(R)  modulo p^(a-1).       (A)

Here V consists of descended auxiliary compatibility errors; A and D
are additive differential/transport operators with descended reference
coefficients; and K_r raises p-adic valuation by at least two. This
equation follows by normalizing the actual inverse-Cartier connection
and actual Hodge line, rather than identifying the auxiliary oper with
its possibly incompatible inverse-Cartier output.

The normalization is integral: it takes a Hodge generator, differentiates
it, divides by the maximal-Higgs determinant unit, and uses the uniquely
specified square root. These operations introduce no division by p.
The first-order scalar formula in the cyclic25 proof supplies its
linearization; it can be used over the whole coefficient ring at this
precision, not merely over the residue field. Indeed, all quadratic
normalization terms begin in p^(2m), whereas the scalar is required only
modulo p^(M-2)=p^(m+a-1). Since m>=a, those terms are absent.

The connection fed to normalization depends on the preceding scalar
only through the inverse-Cartier response. That response retains the
factor p^2, including in the ordinary local connection after applying
the integral map dF/p. Thus (A) is a contracting linear equation. Solve
it by the finite additive inverse of I-K_r. No division of K_r by p^2
is needed to justify the inverse, so no equivariance claim is inferred
from dividing a map by p. Additivity implies K_r(p^j x)=p^j K_r(x),
and therefore its iterates raise valuation successively by at least2.

Substituting (A)'s solution into the final normal comparison gives
additive operators in X and u and a descended constant error. Its
variable feedback still gains p^2. This proves the full higher-digit
claim needed in Section3; using only D25's first scalar digit would
not prove it when a>=3.

For the specified projective periodicity with its square-trivial flat
line, the line is retained in all transition matrices. In compatible
flat local frames it contributes pulled-back scalar units; it cancels
in the normal line and does not affect the contraction. The present
audit does not enlarge the statement to arbitrary independent members
of an unspecified longer periodic flow.

## 2. Precision and actual filtered/graded construction

The genuine auxiliary oper extension uses H1(omega^2)=0 on the smooth
curve and is available without asserting auxiliary compatibility.
Its graded Higgs data and previous filtered object are legitimate
inputs to the higher construction. The relevant rules are the separate
prescribed graded morphism and previous filtered morphism in LSZ
Lemma4.10, and reduction compatibility in the proof of Theorem4.1.
They are essential to (A)'s identification of the preceding graph.

In determinant-horizontal oper frames the corrected tilde matrices are

    Jtilde = epsilon [[lambda,p lambda'/f'],[0,lambda^-1]],
    nablatilde = p partial + [[0,p^2 r],[1,0]].

The scalar is absent from the filtered jet transition. For the Taylor
recursion, diagonal conjugation gives the entrywise p-powers recorded
in the cyclic25 proof. Scalar variations in degrees1,2,3 have minimum
valuation2; in degrees j>=4, j-1-v5(j!)>=3. Consequently every linear
scalar response has the required gain2 even when a is large enough
that additional Taylor degrees must be retained. Products of scalar
changes gain at least the same2 and start no earlier than p^(2m+2),
outside the final modulus.

The curve difference ideal p^n/p^(n+a+1) is square-zero in the stated
range. For at least two changed displacement factors the Taylor
valuation is at least2m+1, also outside the final modulus. For graph
changes, the sole possible nonlinear term is the first square at m=a:
its order is2a=M-1. First-times-second products and all cubics vanish.
Thus after the scalar elimination the draft's actual normal equation

    delta u+E-BX+H(u)+1_(m=a) p^a Q(Xbar,ubar)=0        (B)

has the claimed form. H is additive, deck-equivariant and gains at
least one p; its scalar-feedback portion gains two. Fixed auxiliary
errors multiplied by a variable are incorporated into H or B, not
discarded as though the reference were compatible.

I replayed `verify_cyclic_power_late_budget.py`: 1,089,375 finite
Taylor/order inequalities and27 actual boundary function-product
checks passed. The symbolic inequalities above supply the all-a
argument; the numerical range of the script alone does not do so.

## 3. Integral elimination and norm passage

The actual integral Cech splitting has P delta=1 and preserves
augmentation before division. PH raises valuation, so

    J=(I+PH)^-1

exists as a finite geometric series of additive operators and commutes
with the deck action. Applying P and then pi to (B) gives exactly the
draft's operators

    Lscript=pi B-pi H J P B,
    E'=pi E-pi H J P E.

There is no coefficient-semilinearity restriction: all maps are
additive on groups killed by p^(a+1), hence Z/p^(a+1)-linear, and the
geometric inverse remains valid. In particular, mixed coefficient
Frobenius terms cause no failure of the calculation.

At m=a, primary compatibility gives Xbar in e^(q-3); the invariant
reference error is in e^(q-1) of the actual torsor-function algebra.
The mod-p primitive therefore gives ubar in e^(q-3) at cochain level.
After trivializing the torsor, this is the span of binomial functions
B0,B1,B2. Their products have degree at most4, proving

    (e^(q-3) A)^2 subset e^(q-5) A.

Thus the sole quadratic Q is in e^(q-5), an image of Psi since q>=25.
It is already at the last digit; there is no additional divided product.
Applying H or J-I to its p^a multiple gives zero at this precision.

E' is invariant because the auxiliary error and every operator used
to construct E' are descended/deck-equivariant. The free integral
target identifies invariants with its norm submodule, so E'=N eta.
This is a statement about the integral error, before obstruction
quotients. The bijective-block Schur complement preserves both norms
and augmentation, and the terminal correction removing the quadratic
term does not alter the given leading curve digit.

The resulting actual integral equation satisfies precisely the known
mixed-additive norm theorem. It forces eta0=c=d=0 and the leading
solution into k e^(q-1). Changing the compatible auxiliary lower next
curve by the corresponding base zero-line parameter recovers the GIVEN
T_(n+1) along the ORIGINAL map. The marked-map, Hodge-line, projective
graded and flat-line uniqueness arguments are the established ones.

## 4. Scope and sources checked

The result starts at n=a+1. It does not construct missing lower
truncations for n<a+1. For q125 it begins at n4; the n2 and n3
bootstrap remains a separate geometric problem. In particular, the
early product B100*B24=B124 is not controlled by the late first-square
argument and is not silently discarded.

Primary construction checked: [LSZ Section4, especially Lemmas4.7 and
4.10 and the reduction-compatible composite](https://arxiv.org/html/1311.6424v4#S4).
The definition of the higher Hodge obstruction with the previous tuple
retained was checked in [LSYZ Section6](https://arxiv.org/html/1404.0538v2#S6).
These sources provide the construction; the scalar recurrence and
late-range precision analysis above are the mathematical audit of the
new extension, not a claim that those papers state this descent theorem.
