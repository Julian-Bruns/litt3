# Prime-to-five covers do not create the next BT level

Version1,20 September2026. Let $C$ be a scheme of characteristic five,
let $A/C$ be an actual BT$_N$ group, $N\ge1$, and put $H=A[5]$.
Suppose a finite etale surjection $q:D\to C$ has constant degree
$d$ prime to five. If $q^*A$ has a marked BT$_{N+1}$ extension on
$D$, then $A$ has a marked BT$_{N+1}$ extension on the ORIGINAL $C$.

The assertion concerns existence. The constructed extension need
not pull back to the specified one on $D$. The cover need not be
Galois, and its Galois closure may have degree divisible by five.
No versality, genus, determinant or ordinariness hypothesis is needed.
For height two and dimension one, determinant normalization can
subsequently be imposed without changing the marked BT$_N$.

This is an explicit corestriction of finite-flat extension classes,
not an appeal to an isomorphism-descent theorem. It uses the additive
boundary condition that distinguishes BT$_{N+1}$ from an arbitrary
extension of $A$ by $H$.

Consequently, in the setting of
[common admissible BT1 realization](common_admissible_bt1.md),
$H_X$ has a global BT2 extension if $5\nmid\deg f$. Its pullback to
$Z$ already has a full extension, obtained by twisting $g^*G_Y$
by the Teichmuller lift of the order-four discrepancy. This conclusion
still does not make the endpoint BT2 groups compatible on $Z$.

The corresponding arbitrary-degree existence assertion is FALSE:
[the actual cyclic-five example](explicit_bt2_descent_failure.md)
has no BT2 downstairs although all six degree-five covers acquire one.
The earlier reduction to cyclic degree five remains valid: it uses
a Galois closure of only the chosen single cover and a Sylow subgroup.
It must not be read as an unresolved affirmative claim.
[Proof](../../Proofs/deformations/prime_to_five_bt_extension_descent.md).
