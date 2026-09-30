# The endpoint correction is an actual square on the source

30 September2026, version2.
[Statement](../../Theorems/cartier_and_spin/source_twisted_square_energy.md).

The universal weighted residue identity gives
\[
\operatorname{Tr}(w^2/\phi^2)=2\gamma/\tau.
\]
Trace commutes with differentiation, and dphi=dq. Dividing the
derivative of this identity by two therefore gives
\[
d(\gamma/\tau)
=\operatorname{Tr}(w\,dw/\phi^2)
-dq\operatorname{Tr}(w^2/\phi^3).
\]
In characteristic five, 2*3=1 and 3^2=-1. Expansion of
(dw+3w dq/phi)^2/phi proves the first equality in the statement.
The second follows by differentiating w phi^3. This calculation
is independent of N and of all critical-root multiplicities.

## The local bound needs only the order-three zero

Every integral source root reducing to a nonzero constant has phi
a unit, so its summand is regular. For a root w reducing to zero,
w belongs to r k[[r]] and phi=w^5+q has exact order three. Hence
w phi^3 belongs to r^10 k[[r]]. Its differential belongs to
r^10 k[[r]]dr as well: the possible r^9 term differentiates the
r^10 coefficient and vanishes in characteristic five. Therefore
\[
\operatorname{ord}_r\frac{d(w\phi^3)^2}{\phi^7}
\ge20-21=-1.
\]
Each summand already has at most a simple pole. Summation cannot
worsen that bound. This proves the assertion without identifying
the small-root factor or extracting its Newton sums. In particular
it covers arbitrary multiples of five small roots when tau has a
higher-order zero.

## The odd-characteristic identity and bound

For any odd p, the same weighted residue identity is
Tr(w^2/phi^2)=2gamma/tau. Differentiating and multiplying by -4dq
gives the cross and last terms of (dw-2w dq/phi)^2/phi. Since
p-2=-2 in the coefficient field, this also equals the square of
d(w phi^(p-2)) divided by phi^(2p-3).

Let e=(p+1)/2. A small integral root has ord(w)>=1 and ord(phi)=e.
Thus w phi^(p-2) has order at least
\[
1+e(p-2)=p(p-1)/2.
\]
This integer is divisible by p, so differentiation does not lower
the stated lower bound. The square divided by phi^(2p-3) has order
at least
\[
p(p-1)-e(2p-3)=(3-p)/2.
\]
Roots reducing to nonzero constants contribute regularly. This proves
the bound without a restriction on source degree or on tau. If the
W^(p-1) remainder coefficient vanishes, Tr(dw/phi)=0 and gamma is
unchanged by translation, proving the stated invariance as before.

## Coordinate and equation choices

If the W^4 remainder coefficient is zero, the weighted residue
identities give Tr(dw/phi)=Tr(1/phi)=0. Thus Tr(dw^2/phi) is
unchanged under dw -> dw+db. The remainder still has degree at most
three after translation, so its W^3 coefficient gamma and tau stay
unchanged; dq also stays unchanged because d(b^5)=0. Consequently
Qsharp is translation invariant, even for a meromorphic b.

Multiplying F by a base unit or rational function multiplies H,
gamma and tau by that same function. The ratio gamma/tau and the
source energy stay unchanged. The affine scaling law of earlier
corrections is a different issue and is not claimed for Qsharp.

## The uniform degree-ten section

Use the regular finite primitive coordinate. At ordinary affine
points every integral source root has phi a unit. At the selected
linear-v branch a root with pole at most one has phi of pole five;
q is regular. In dw+3w dq/phi the first summand has pole at most
two and the second is regular, so its square divided by phi is
regular. Integral roots again give regular terms. Thus Qsharp has
no pole there, regardless of critical-content behavior.

At every fixed t-endpoint a constant translation makes q have
order three. The local argument above applies to all the split
integral roots, and t removes the remaining simple pole.

At infinity use the short source coordinate, permitted by translation
invariance. The established root pole profiles and the two weighted
moment identities give order at least five for Tr(dw^2/phi), as in
the global energy theorem. In this frame q has pole seven, gamma
has pole at most thirteen and tau has pole twenty-seven. Therefore
dq d(gamma/tau) also has order at least five. Multiplication by t,
whose pole is nine, leaves a pole of order at most four. This proves
the claimed global section bound.

The older corrected energy is not discarded: it differs from Qsharp
by -2dq dgamma/tau, and its already proved section and divided-trace
identities remain valid. The new expression supplies the direct
source-square interpretation and the stronger all-degree local lemma.
