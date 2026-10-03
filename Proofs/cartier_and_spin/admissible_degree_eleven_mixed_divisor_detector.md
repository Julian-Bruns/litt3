# Proof of the degree-eleven mixed divisor detector

[Statement](../../Theorems/cartier_and_spin/admissible_degree_eleven_mixed_divisor_detector.md).
The actual degree-eleven projected support comes from the
[support reduction](../../Theorems/cartier_and_spin/admissible_degree_ten_eleven_reduction.md).
Primitivity and the degree-six interpolation bound follow from the
[uniform annihilator lemma](admissible_annihilator_trace_vanishing.md).
No numerical computation is used in this detector.

## Norm identities and the carry polynomial

The chosen constant remainder gives
$\operatorname{Nm}\phi=t^{15}/v^5$: switching the order in
$\operatorname{Res}(F,\phi)$ contributes a minus sign, canceled by
the fifth power of the remainder $-t^3$. The divisor of an actual
annihilator gives $\operatorname{Nm}u=ct^{10}$. A scalar rescales this
to $t^{10}$ over the algebraically closed constant field. Then
$\operatorname{Nm}(t^2/u)=t^{12}$.

For an actual annihilator, its ten selected infinity sheets have pole
eight and its one unselected sheet pole ten. Hence
$e_j(u)\in L_{8j+2}$ for every $j\ge1$. In particular the first four
belong to $L_{10j}$ and its fifth and sixth coefficients belong to
$L_{42},L_{50}$. The reciprocal has ten poles ten and one pole eight,
so $e_j(u')\in L_{10j}$ for $j\le10$. At finite points both are
regular. With $a_j=e_j(u)$ and $a_j'=e_j(u')$, the identity
\[
e_{11-j}(u)=t^{10-2j}e_j(u')
\]
gives precisely the displayed $M$. In particular
$e_5(u')=a_6$ and $e_6(u')=t^2a_5$.

Since $U(W)=uD(W)$ and $\Delta=v^5\operatorname{Nm}D$, the formal
degree-six resultant is $v^6\operatorname{Nm}(ZD-U)=v\Delta M(Z)$.
For a candidate satisfying this identity, separability and $\Delta\ne0$
show that $M$ is exactly the characteristic polynomial of $u$.
Its constant term gives $\operatorname{Nm}u=t^{10}$ and $u\ne0$.
All coefficients are affine regular, so $u$ is finite regular on the
actual normalization. The characteristic polynomial of $u'=t^2/u$
has coefficients, in order,
\[
a_1',a_2',a_3',a_4',a_6,t^2a_5,t^4a_4,t^6a_3,t^8a_2,t^{10}a_1,t^{12}.
\]
They too are affine regular, proving finite regularity of $u'$.

Fix a base parameter $r$ at infinity. The scaled $\widehat u=r^{10}u$
has a monic polynomial with integral coefficients by the displayed
spaces, so it is integral on every sheet. For
$\widehat u'=r^{10}u'$ its coefficient valuations are nonnegative at
indices one through six and eleven. At indices seven through ten they
are at least $-6,-4,-2,0$, respectively, since $t$ has pole nine.
Each bound is strictly greater than minus its index. A root with an
integer pole order $m\ge1$ would make the leading monomial uniquely
lowest in valuation: for the $j$th other term the valuation difference
is greater than $-j+jm\ge0$. This is impossible. Actual étaleness
makes all sheet valuations integers, so $\widehat u'$ is integral too.
This step would not apply unchanged to ramified candidates.

Their product is $r^{20}t^2$ of exact order two. Thus on every infinity
sheet $0\le\operatorname{ord}\widehat u\le2$. Also
$\operatorname{Nm}\widehat u=r^{110}t^{10}$ has order twenty, giving
\[
\sum_{i=1}^{11}\operatorname{ord}\widehat u_i=20.
\]

## The mixed coefficients and finite assignment

Put $\chi=u/\phi$ and
$B_k=v^5[z^k]\operatorname{Nm}(\phi+zu)$.
Then $B_k=t^{15}e_k(\chi)$. Formal degree ten gives
\[
\operatorname{Res}_{11,10}(F,\phi D+zU)
=v^{10}\operatorname{Nm}D\operatorname{Nm}(\phi+zu)
=\Delta\sum_kB_kz^k.
\]
All $B_k$ are affine regular once the carry identity holds. Indeed,
at a finite point the only negative valuations of $\phi$ are $-5g_i$
on the $G$ sheets, while $u$ is integral. Every norm coefficient has
valuation at least $-5\sum g_i$. Primitive content gives
$\operatorname{ord}v=\sum g_i$, and $v^5$ clears this bound.

At a finite endpoint, both $u,u'$ are integral and $uu'=t^2$, so every
$u_i$ has order between zero and two. On the five selected sheets
$\phi_i$ has exact order three; therefore $\chi_i$ has order between
minus three and minus one. On all other sheets $\chi_i$ is integral.
The product of the five selected values is the unique term of smallest
valuation in $e_5(\chi)$: replacing any negative value by a nonnegative
one raises the valuation strictly. If $s$ is the sum of the five selected
orders of $u$, then $\operatorname{ord}B_5=s$.
The identity $B_5=t^{10}b_5$ forces $s\ge10$. Since $s\le10$,
all five selected orders are two. The norm has total order ten, so all
six unselected orders are zero. Outside these endpoints $t$ is a unit,
and finite regularity of $u,u'$ makes both units. This recovers the
entire prescribed finite divisor without any cancellation assumption.

## Infinity assignment uses the tenth coefficient

Set $\widehat\phi=r^{10}\phi$. On the ten selected infinity sheets
its order is three; on the unselected sheet its order is $-5g\le0$.
Because $\chi=\widehat u/\widehat\phi$, its ten selected orders are
between minus three and minus one, and its remaining order is
nonnegative. Their selected tenfold product is uniquely lowest in
$e_{10}(\chi)$. If $s$ is the sum of the ten selected orders of
$\widehat u$, then
\[
\operatorname{ord}B_{10}=s-30-135=s-165.
\]
The $L_{145}$ bound forces $s\ge20$. The total sum is twenty and each
order is nonnegative and at most two, so every selected order is two
and the unselected order is zero. Thus the selected $u$ poles are eight
and the remaining pole is ten, exactly the infinity part of
$\operatorname{div}u=2E-10H$.

Conversely this divisor makes $B_{10}$ have exact pole 145. It makes
$B_5$ affine and divisible by $t^{10}$. At infinity every selected
$\chi$ has pole one and the other value is integral, so $e_5(\chi)$
has pole at most five. Consequently $B_5$ has pole at most 140 and
$b_5=B_5/t^{10}$ has pole at most 50, as required. This proves necessity
and sufficiency of both mixed conditions together with the carry.

Finally, an actual $u$ has a unique pole-ten sheet at infinity. The other
ten have pole eight, so its ordinary trace has exact pole ten. In the
fixed basis $L_{10}=\langle1,x,x^2,x^3,y\rangle$ the $y$ coefficient
is therefore nonzero. This concerns the trace of the annihilator; it
does not identify it with the source's nonzero-first-moment sector.
Everywhere étaleness, the prescribed primitive source, and the
order-five nontriviality question remain explicit separate inputs.
