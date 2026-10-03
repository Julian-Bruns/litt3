# Proof: the intrinsic quartic controls ramification

[Statement](../../Theorems/deformations/generic_bt_comparison_etaleness.md).
This proof uses the actual finite group, its connection and Hodge line.
It strengthens the prior marked higher-level valuative comparison by
first recovering and extending a BT1 comparison that was only generic.

## Intrinsic generic construction and pullback

For an ordinary height-two, dimension-one BT1 over a function field,
split its two rank-one constituents over a finite separable extension.
Its Kummer extension class is represented by q modulo fifth powers.
The differential dlog(q) is unchanged by changing that representative.
Changing the constituent frames multiplies it by an element of
F_5^*. Its fourth tensor power is therefore intrinsic, and invariant
under actual group isomorphisms. Use the same harmless fixed sign as
in the [versal-BT1 symmetry theorem](versal_bt_tame_automorphisms.md).

This defines a rational quartic tensor s_H on the base function field.
It is functorial for EVERY separable field extension, not merely for
etale maps of complete curves. This follows directly by pulling back
q and dlog(q). A determinant character need not be trivial: its
constituent-frame ambiguity is already killed by the fourth power.

The [logarithmic character calculation](versal_bt_cartier_realization.md)
shows that for an everywhere-versal H with reduced supersingular
divisor S the tensor is regular and has divisor 2S. Briefly, on the
character double at a supersingular point put t=s^2. The logarithmic
form has order two in s, so its fourth power has order eight; the
pullback of (dt)^4 contributes order four. Thus the order downstairs
is (8-4)/2=2. At ordinary points versality gives order zero.

The supplied generic isomorphism first implies that b is nonconstant
and separable. Indeed, its BT1 reduction identifies the Hodge lines,
connections and second fundamental maps over k(T). The map for a^*H_X
is nonzero, since a is etale and H_X is versal. The one for b^*H_Y is
the pullback of its Kodaira--Spencer map followed by db. A constant
or inseparable b has db=0, a contradiction. A nonconstant map of
proper smooth curves is finite. We can now use separable pullback:
\[
a^*s_{H_X}=b^*s_{H_Y}\quad\text{in }H^0(T,\omega_T^4).
\tag{4}
\]
Only a generic group isomorphism was used to obtain (4). Its two
sides are already global regular tensors, so no extension theorem
for group schemes is being assumed at this stage.

## Global ramification is visible in the divisor

For a finite separable morphism c:T->C, the local different formula is
\[
\operatorname{div}(c^*s)
=c^*\operatorname{div}(s)+4\operatorname{Diff}(c).
\tag{5}
\]
This remains valid for wild ramification; the coefficient is the
different exponent, not e-1 unless the ramification is tame. Applying
(5) to (4), then dividing the resulting integral equality by two,
gives (3) of the statement.

Since a is etale, a^*S_X is reduced. At any ramified point of b,
the coefficient of 2Diff(b) is at least two, while the coefficient
of a^*S_X is at most one. Positivity of b^*S_Y makes this impossible.
Hence b is etale and the supersingular divisors agree. The same
argument proves the stated elementary r-differential criterion.

## Extend the supplied comparison at every level

Both pulled-back BT1s are now everywhere versal and have the SAME
reduced supersingular divisor. The [unmarked all-level valuative theorem](versal_bt_valuative_comparison.md)
therefore extends the supplied generic BT_N isomorphism uniquely.
Its local BT1 proof uses both Frobenius and Verschiebung to make
the triangular comparison's diagonal entries units, then the
Kodaira--Spencer map for its remaining entry. Its last-digit induction
retains every higher level. Any marking or determinant condition
holding generically extends with the actual group comparison.

Finally let K_X^ur be a chosen maximal unramified separable extension
of k(X), realized as the union of finite etale covers of X. A
Y-valued point over this field and a generic BT1 isomorphism have
finite presentation, so both descend to one finite subextension.
The corresponding smooth proper T is etale over X. Properness of Y
extends its rational point to b:T->Y. The theorem gives the second
etale map and the integral comparison. The converse is immediate
from an actual marked common span. This reformulation supplies no
point over K_X^ur, and imposes real generic BT data beyond a bare
one-sided dominating map.
