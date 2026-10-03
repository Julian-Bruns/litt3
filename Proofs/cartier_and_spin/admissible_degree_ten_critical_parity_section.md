# Proof of the primitive discriminant parity and contact budgets

[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
The general proof uses the actual divisor data and the
[global principal-support conclusion](uniform_admissible_norm.md).
The former degree-ten proof is retained below; its normalized support
does not require adding a torsion hypothesis. No numerical computation
or global square-root assumption is needed.

## Global content and the raw constant remainder in every degree

The uniform norm theorem gives $h_*E=5B$. Under $5(E-G-4H)\sim0$ its
new principal-support conclusion supplies functions $t,v$ with divisors
$B-nO$ and $h_*G-nO$. In the finite frame, the root pole orders are
exactly their $G$ multiplicities $g_i$; cancellation of the fixed poles
of $f$ is built into that frame. Thus
$\operatorname{ord}_Pv=\sum_i g_i$ at every finite point. Multiplying
the monic minimal polynomial by $v$ gives affine-regular finite-frame
coefficients. Indeed each coefficient has valuation at least
$-\sum g_i$. Primitive Gauss content is exact, since the product of
the pole-root leading terms times the integral-root monic polynomial
has a nonzero reduction after this scaling.

The [uniform raw-shape lemma](admissible_annihilator_trace_vanishing.md)
gives a constant remainder modulo $\phi_T=T^5+q_s$. If the raw remainder
is $c$, its norm identity and the given divisor show
$\operatorname{div}c=3B-3nO$. Hence $c/t^3$ is a nonzero constant.
Rescaling $t$ by a constant makes $c=t^3$, giving the stated raw form.
The derivative is $F'=\phi_T\mathscr H'$; separability ensures
$\mathscr H'\ne0$ and the nonzero critical resultant.

## Finite discriminant content and contact

Compute the discriminant in the finite frame; translation leaves it
unchanged. The raw expression is
\[
\operatorname{Disc}F=v^{2n-2}\prod_{i<j}(w_i-w_j)^2.
\]
At any finite point $\operatorname{ord}(w_i-w_j)\ge-\max(g_i,g_j)$.
Since $\max(g_i,g_j)\le g_i+g_j$, the sum of these maxima is at most
$(n-1)\sum_i g_i$. The content $v^{2n-2}$ therefore clears every
negative contribution. The discriminant is affine regular, including
above all zeros of $v$.

At a finite endpoint of occupancy $b$, exactly $s=5b$ selected roots
have a common residue and no $G$ poles. If they have contact at least
$k$, each selected pair difference has order at least $k$, adding
$s(s-1)k$ to the preceding nonnegative discriminant estimate. Since
$\operatorname{ord}t=b$,
\[
\operatorname{ord}(\operatorname{Disc}F/t^{20})
\ge5b[(5b-1)k-4]
=25b(b-1)+5b(5b-1)(k-1)\ge0.
\]
Every zero of $t$ is such an endpoint. Consequently $C$ is affine
regular. The estimate uses all selected pairs and retains arbitrary
unselected poles and repeated selected slopes.

## Infinity count and sign parity

Write $b=n-e$ for the number of unselected infinity sheets and
$g_\infty=\sum_i g_i$ for their total $G$ multiplicity. A selected
root has pole at most one; an unselected root has pole $2+g_i$.
The pole of $v$ is $d=n-g_\infty$. Bounding pair differences by the
larger root pole, the sum of the pair upper bounds is at most
\[
\binom e2+2eb+b(b-1)+(n-1)g_\infty.
\]
The first three terms come from selected pairs, mixed pairs, and
unselected pairs. The $g_i$ terms contribute at most $e\sum g_i$ in
mixed pairs and $(b-1)\sum g_i$ in unselected pairs. Therefore
\[
\operatorname{pole}_O\operatorname{Disc}F
\le(2n-2)d+2\left[\binom e2+2eb+b(b-1)+(n-1)g_\infty\right]
=4n^2-4n-e^2+e.
\]
The pole of $t$ is $n-e/5$, so division by $t^{20}$ gives exactly
the asserted $M=4n^2-24n-e^2+5e$. This number is even.
If it were negative, a nonzero affine function with that bound would
have a zero at infinity and no poles, which is impossible on a proper
connected curve.

On every completed disk the actual étale normalization splits into
base disks. All root differences belong to the base fraction field,
so the displayed pairwise square has even valuation everywhere.
The factors $v^{2n-2}$ and $t^{20}$ preserve evenness. Thus $\operatorname{div}C$
is even. Monic and raw discriminants differ by $v^{2n-2}$; the monic
discriminant differs from $C$ by the square $(t^{10}/v^{n-1})^2$.
Its square-class is the actual unramified determinant character of the
étale permutation representation, which need not be trivial.

Write $\operatorname{div}C=2Z-2aO$ with $Z\ge0$ finite. Then
$a\le M/2$ and $L=\mathcal O_X(Z-aO)$ is two-torsion. Its effective
divisor $Z+(M/2-a)O$ gives the asserted half-section. There are
$2^{18}$ such line classes; when $M/2>16$ the section dimension is
$M/2-8$ by Riemann--Roch. Summing the finite lower bounds against
the total zero degree at most $M$ proves the contact budget. At
$n=11,e=10$ this yields $M=170$, degree 85, dimension 77 and contact
excess at most eight on its nine occupancy-one endpoints.

## Quadratic occupancy and support size

Put $b_\infty=e/5$, so $\sum_Pb_P=n$. The baseline finite budget is
$25\sum_{P\ne O}b_P(b_P-1)$, and
$M=4n^2-24n-25b_\infty^2+25b_\infty$.
Move the baseline to the right and use
$\sum_{P\ne O}b_P=n-b_\infty$. The budget becomes exactly
\[
25\sum_Pb_P^2+
\sum_{P\ne O}5b_P(5b_P-1)(k_P-1)\le4n^2+n.
\]
Discarding the nonnegative contact term and applying Cauchy--Schwarz
to the $r$ nonzero occupancies gives
$n^2\le r\sum_Pb_P^2\le r(4n^2+n)/25$.
Thus $r\ge\lceil25n/(4n+1)\rceil$; for $n>6$ the fraction exceeds
six, giving seven. The proof uses the discriminant of the actual
primitive polynomial. Repeating that polynomial after a source
refinement would give repeated roots and zero discriminant, so no
degree substitution of that kind has been used.

## Formal critical resultant identity

Retain formal derivative degree $n-6$, even if the actual degree is
smaller. Multiplicativity with formal total degree $n-1$ gives
\[
\operatorname{Disc}F
=(-1)^{n(n-1)/2}\frac{\operatorname{Res}_{n,n-1}(F,F')}{v}
=(-1)^{n(n+1)/2}\frac{t^{15}\Delta}{v}.
\]
Here $\operatorname{Res}(F,\phi_T)=(-1)^nt^{15}$ comes from the
constant remainder. This proves $C=(-1)^{n(n+1)/2}\Delta/(t^5v)$
without discarding content factors at derivative-degree drops.
In degree ten $\mathscr H=v\phi_T+S$ and its actual derivative is the
cubic $S'$. The formal degree-four resultant is $v$ times the actual
cubic one, so the old $\Delta_{10,3}/t^5$ equals $-C$. All former
degree-ten parity and contact conclusions agree.

## Retained direct degree-ten proof

Version4 frame clarification: the lower coefficients in the short
frame have the stated infinity bounds, but need not be affine regular.
Affine content calculations below use $F_f(T)=F(T-Z/y)$ and
$D_f(T)=D(T-Z/y)$. The leading critical coefficient is unchanged
by this translation and is affine. Resultants, discriminants and
root differences are translation invariant, so none of the parity,
contact or pole estimates requires affine regularity of a lower
short coefficient.

## Finite content and the mandatory endpoint factor

Translation to the finite frame leaves the resultant unchanged. Its
affine coefficients imply that $\Delta$ is affine regular. Since the
source is separable and $F'=\phi_TD$, no source root annihilates $D$;
thus $\Delta\ne0$. Its actual cubic-degree norm identity is
\[
\Delta=v^3\operatorname{Nm}(D).
\]
At a finite selected endpoint, the five selected integral roots reduce
to the same value. Every other integral root has different residue:
otherwise its $\phi$ would vanish, contrary to the actual divisor.
Root poles are confined to the unselected $G$ sheets, with orders $g_i$.
Primitive content gives $\operatorname{ord}v=\sum g_i$.

For a selected root $w_i$, split differentiation gives
\[
\operatorname{ord}F'(w_i)
=\operatorname{ord}v+\sum_{j\ne i}\operatorname{ord}(w_i-w_j)
\ge\sum g_i-\sum g_i+4=4.
\]
The other selected roots contribute at least one each, the unselected
integral roots contribute zero, and the pole roots contribute $-g_i$.
Subtracting the exact $\phi$ order three shows
$\operatorname{ord}D(w_i)\ge1$ on each selected sheet.
For an unselected integral root the same formula and unit $\phi$ give
$\operatorname{ord}D(w_i)\ge0$. For a pole root, integral cubic
coefficients give $\operatorname{ord}D(w_i)\ge-3g_i$.
Consequently
\[
\operatorname{ord}\Delta
=3\sum g_i+\sum_i\operatorname{ord}D(w_i)\ge5.
\]
This retains zeros of $v$, unselected pole sheets and all possible
selected collisions. Therefore $\Delta/t^5$ is affine regular.

## Infinity pole and exact discriminant parity

On a small root, $D$ has pole at most
$\max(12+3,14+2,16+1,17)=17$. On a big root of pole $a\ge2$, its pole
is at most
\[
\max(12+3a,14+2a,16+a,17)=12+3a.
\]
The norm identity and $\sum a_i=20-d$ give
\[
\operatorname{pole}_O\Delta
\le3d+5\cdot17+5\cdot12+3(20-d)=205.
\]
Dividing by $t^5$, whose pole is 45, gives $C\in L_X(160O)$.
No Newton-profile restriction beyond the supplied five-small/five-big
ledger was used.

Because the monic inseparable polynomial $T^5+q_s$ has degree five and
the remainder of $F$ is $t^3$, its norm is $t^{15}/v^5$.
The degree-ten discriminant sign is $(-1)^{45}=-1$, and $F'=\phi_TD$.
Multiplicativity of resultants, retaining the raw leading-degree factors,
therefore gives
\[
\operatorname{Disc}(F)=-t^{15}\Delta,
\qquad \operatorname{Disc}(F/v)=-t^{15}\Delta/v^{18}.
\]
Equivalently use the monic derivative $\phi_TD/v$ and multiply back by
$v^{18}$. Every completed disk of the actual étale cover splits its
roots in the base fraction field, even when some coordinates have poles.
The monic discriminant is their pairwise-difference square, so its
valuation is even at every point. Since $v^{18}$ and $t^{20}$ are squares,
\[
\operatorname{div}(\Delta/t^5)\in2\operatorname{Div}(X).
\]
This proves parity, not squarehood of the function. A nontrivial
unramified quadratic determinant character may remain.

## The twisted canonical half-section

Write $\operatorname{div}C=2Z-2aO$, with $Z\ge0$ finite and $a\le80$.
The degree-zero line $L=\mathcal O_X(Z-aO)$ is two-torsion.
The monic discriminant differs from $C$ by the square
$(t^{10}/v^9)^2$ and a constant square, so this is its unramified
sign-character class. The effective divisor $Z+(80-a)O$ defines a
nonzero section of $\omega_X^5\otimes L$. Under the induced trivialization
of $L^2$, its square is $C\omega_0^{10}$ up to nonzero scalar.

The genus-nine Jacobian has $2^{18}$ two-torsion classes in characteristic
five. Each $\omega_X^5\otimes L$ has degree eighty, exceeding sixteen,
and Riemann–Roch gives dimension $80+1-9=72$. This supplies the finite
union of twisted square images while retaining all possible sign classes.

## Contact budget

If five selected roots have common contact order $k_P$, all their pair
differences have order at least $k_P$. The same differentiation formula
gives selected $F'$ orders at least $4k_P$, hence selected $D$ orders
at least $4k_P-3$. The unselected and content terms cancel as before, so
\[
\operatorname{ord}_P\Delta\ge20k_P-15,\qquad
\operatorname{ord}_PC\ge20(k_P-1).
\]
The affine function $C$ has total zero degree at most 160. Summing over
the nine selected endpoints proves $\sum(k_P-1)\le8$ and $k_P\le9$.
The twisted half-section has order at least $10(k_P-1)$ there and degree
eighty, giving the same bound without a trivial sign class.

No common-cover extraction or compatibility with a second canonical
section is inferred.
