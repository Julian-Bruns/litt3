# No canceled rational critical root in the m3 profile

1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m3_critical_coprimality.md).
The inputs are the actual coefficient and infinity profiles in
[the nine-profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
the numerator bounds in
[the compact numerator theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md),
finite critical-root affinity and the fixed gap rows in
[the reduced-linear critical denominator proof](admissible_linear_critical_denominator.md),
and the established
[polynomial annihilator exclusion](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
The new leading-order argument received a focused independent review
from the parent research agent. No settled coefficient enumeration is
repeated.

Write
\[
D=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0,
\quad U=\sum_{j=0}^5 A_jT^j.
\]
On this profile $v$ has exact infinity pole10, $\delta_3$ has exact
pole3 and belongs to $L_3=\langle1,x\rangle$. The other critical
coefficients have pole bounds14,16,18 for $\delta_2,\delta_1,\delta_0$,
respectively; the last relaxed bound suffices. The uniform numerator
bounds give
\[
A_5=v\rho,\quad A_4=vm_5+s_4\rho,\quad
\rho\in\langle1,x,x^2\rangle,\quad m_5\in L_{10},
\quad\operatorname{pole}_O A_j\le25-j\ (j\le3).
\]

Suppose $D(c)=U(c)=0$ for $c\in k(X)$. In the finite frame
$w=W+a$, $a=Z/y$, the critical polynomial $D_f$ has affine
coefficients, the same cubic coefficient $\delta_3$, and root
$c_f=c+a$. Multiplying its cubic root equation by $\delta_3^2$
shows that $\delta_3c_f$ satisfies a monic polynomial with affine
coefficients. Since the affine curve is normal, $\delta_3c_f$ is
affine regular. Equivalently this follows from the finite DVR
leading-term argument already proved in the reduced-linear record;
no unit leading coefficient or distinct finite critical roots are
required.

If $c$ has infinity pole at most10, then $\delta_3c$ has pole at
most13. The non-affine remainder of $a\delta_3$ has leading candidate
gap poles17,14,11. Write
\[
\delta_3c=f-a\delta_3,\qquad f=\delta_3c_f\text{ affine}.
\]
After separating the fixed affine polynomial part of $a\delta_3$,
the remaining affine function has pole at most17 and therefore at
most16. Thus its gap17 remainder coefficient must vanish. The next
possible remainder has pole14, so the same argument lowers the
affine pole to at most13 and kills that coefficient too. These are
the two fixed independent gap forms on $L_3$. Their invertible
matrix forces $\delta_3=0$, a contradiction. This argument concerns
successive LEADING poles; it makes no false assertion that an affine
function lacks subleading Laurent terms at gaps.

Thus $c$ must have pole at least11. On the other hand $D(c)=0$
forces pole at most11: for pole $r>11$, the cubic term has pole
$3+3r$, strictly greater than $14+2r$, $16+r$ and18.
Therefore $c$ has exact pole11 and $\delta_2$ exact pole14.

Now use $U(c)=0$. If $\rho\ne0$, the pole of $A_5c^5$ is at
least $10+55=65$, whereas $A_4c^4$ has pole at most64 and all
lower terms at most55. This unique leading term cannot cancel;
hence $\rho=0$ and $A_4=vm_5$. A nonconstant $m_5\in L_{10}$
has pole at least3, giving pole at least57 for $A_4c^4$ against
the same lower bound55. Hence $m_5$ is constant, possibly zero.
If $A_3$ had pole22, then $A_3c^3$ would have pole55, while
$A_4c^4$ has pole at most54 and all remaining terms at most45.
It follows that $A_3$ has pole at most21.

At a large infinity branch $W$ has pole2. Consequently
\[
\operatorname{pole}(U(W))\le
\max(10+8,21+6,23+4,24+2,25)=27.
\]
The pole18 leading polynomial of $D(W)$ has degree at most two
in the nonzero large residue $\beta$, and its quadratic coefficient
is nonzero because $\delta_2$ has exact pole14. The profile theorem
gives at least four distinct large residues. Thus at least one
large branch has $D(W)$ of exact pole18. On every large branch
the prescribed annihilator $u$ has exact pole10. The identity
$U(W)=uD(W)$ then gives pole28 at that branch, contradicting27.
This proves the rational canceled-root exclusion.

Finally consider $g=\gcd(D,U)$. If it has degree one, or has a
reducible degree-two factor, it supplies a rational canceled root,
already impossible. If $g$ is an irreducible quadratic, the cubic
$D$ is its product with a distinct linear factor; this $D$ is
automatically squarefree, because degree two is prime to five.
The reduced denominator is linear, excluded on $m=3$ by
[the reduced-linear theorem](../../Theorems/cartier_and_spin/admissible_linear_critical_denominator.md).
If $g$ has degree three, $D\mid U$ and $u=U/D$ is polynomial
of degree at most two, excluded by the polynomial annihilator
theorem. Thus $g$ is constant. There is no global squarefreeness
hypothesis in the coprimality conclusion.
