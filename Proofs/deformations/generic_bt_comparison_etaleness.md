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

The [logarithmic character calculation](versal_bt_cartier_rigidity.md)
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

## A generic BT1 isomorphism is integral after this step

It remains to extend the supplied isomorphism. This requires a new
BT1 base case, since the existing higher-level comparison starts
with an already integral marking. Work at a completed local ring
R=k[[t]], K=k((t)) of T. Both pulled-back BT1 groups are now versal;
their supersingular supports agree and are reduced.

Evaluate their contravariant Dieudonne crystals, and choose integral
frames whose second vectors generate the Hodge lines. Write their
Frobenius and connection matrices as
\[
F_i=\begin{pmatrix}a_i&0\\c_i&0\end{pmatrix},\qquad
V_i=\begin{pmatrix}0&0\\d_i&e_i\end{pmatrix},\qquad
\nabla_i=d+C_i\,dt,\quad i=1,2.
\tag{6}
\]
At an ordinary point all a_i,e_i are units. At a supersingular point
all have valuation one, c_i,d_i are units, and (C_i)_{12} are units
by versality. All these are the actual Hasse and Kodaira--Spencer
data, as in the earlier local comparison proof.

The generic group isomorphism preserves the Hodge line. In these
frames its crystalline matrix therefore has the form
\[
U=\begin{pmatrix}x&0\\z&w\end{pmatrix}\in\operatorname{GL}_2(K).
\tag{7}
\]
Use the orientations UF_2=F_1 U^{(5)} and U^{(5)}V_2=V_1U.
Their upper-left and lower-right entries respectively give
\[
x a_2=a_1 x^5,\qquad w^5e_2=e_1w.
\tag{8}
\]
Since v(a_1)=v(a_2) and v(e_1)=v(e_2), equations (8) give
4v(x)=4v(w)=0. Thus BOTH x and w are units. In particular det(U)
is a unit without any assumption or construction involving its
determinant character. The Verschiebung equation is retained here.

Horizontality is U'+C_1U=UC_2. Its upper-left entry is
\[
x'+(C_1)_{11}x+(C_1)_{12}z=x(C_2)_{11}.
\tag{9}
\]
At a supersingular point the coefficient of z is a unit, and all
other terms are in R, so z is integral. At an ordinary point the
lower-left entry of the Frobenius identity already gives
\[
z a_2+w c_2=c_1x^5,
\]
and a_2 is a unit, again giving z in R. Consequently U and its
inverse are integral at every completed point.

The F,V and connection identities now hold integrally, because
R injects into K. Crystalline full faithfulness for the two existing
finite flat groups, in the precise formal-smooth setting used in
[valuative comparison](versal_bt_valuative_comparison.md), produces
the actual integral BT1 isomorphism. This is not an assertion of
effectivity for arbitrary F,V matrices. Regularity in every completed
stalk extends the finite Hopf-algebra maps on T; equality generically
proves both inverse identities and uniqueness.

## Retain all higher levels and markings

For N>1 the extended BT1 comparison is now an actual marking.
Apply [all-level valuative comparison](versal_bt_valuative_comparison.md)
to the supplied generic BT_N isomorphism with this marking. It
extends at every completed point and hence globally. Any determinant
condition or other marking satisfied generically extends as an
equality of maps between finite locally free Hopf algebras.

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
