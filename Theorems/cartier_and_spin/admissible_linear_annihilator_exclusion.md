# Low-degree polynomial annihilators contradict actual source bounds

Version3, 1 October2026. Retain the actual primitive admissible source
$h:S\to X$ of degree $n\ge6$ on the fixed genus-nine curve, with
$H=h^*O$, reduced $E$, effective $G$, $E\cap G=\varnothing$, and
actual functions satisfying
\[
\operatorname{div}\phi=3E-5G-10H,\qquad
\operatorname{div}u=2E-10H.
\]
Use $B=h_*E/5$, the short primitive coordinate $W$, primitive raw
content $v$, and the nonzero affine discriminant quotient
$C=\operatorname{Disc}(F)/t^{20}$ of
[the parity theorem](admissible_degree_ten_critical_parity_section.md).
Suppose, additionally, that
\[
u=A W+B_1,\qquad A,B_1\in k(X).
\]
Then $A\ne0$. At a finite selected endpoint $P$, write
$s=5\operatorname{ord}_P B$ and $\ell=n-s$, and assume $0<s<n$.
The coefficient $A$ cannot have a pole at $P$. If $A$ is a unit there,
all selected roots have complete second-order contact, no unselected
root has a $G$ pole, and
\[
\operatorname{ord}_PC\ge2s(s-3).
\]
If $A$ has a zero of order $a\ge1$ there, all $\ell$ unselected
roots have exact pole order $a$, and
\[
\operatorname{ord}_PC\ge s(s-5)+\ell(\ell-1)a.
\]
These local inequalities require neither distinct unselected residues
nor a squarefree critical derivative.

Consequently no actual admissible source of degree ten or eleven has
an affine-linear annihilator. Indeed
[their support reduction](admissible_degree_ten_eleven_reduction.md)
gives nine distinct finite endpoints with $s=5$ and respectively
$\ell=5$ or six. Each contributes at least twenty, while the parity
theorem bounds the entire zero degree by 160 or 170.

## Quadratic and other low-degree polynomial annihilators

In degree ten, also exclude $u=A W^2+B_1W+B_2$ in each of the
four one-big-sheet profiles of
[the nonzero profile reduction](admissible_degree_ten_nonzero_profiles.md).
These have $d=\operatorname{pole}_O v\in\{0,3,6,9\}$, cubic
critical leading coefficient $\delta_3$ of pole twelve, five
selected short roots of pole at most one, four unselected roots
of pole two, and one unselected root of pole $12-d$. The bounds
$\operatorname{pole}_O\rho\le6$ and $U_5=v\rho$ force a contradiction
at infinity, independently of residual distinctness or discriminant
squarefreeness.

At $d=10$, put $m=\operatorname{pole}_O\delta_3$. The five
pole-two roots have at least four distinct leading residues.
Every quadratic expression therefore requires
\[
\operatorname{pole}_O A\le6,\quad
\operatorname{pole}_O B_1\le8,\quad
\operatorname{pole}_O B_2\le9,\quad
\operatorname{pole}_O\rho\le m-4.
\]
Every polynomial-quadratic annihilator also has the exact critical
quotient $Q=0$, hence $n_0=n_1=0$ and $n_2=v\rho^2/\delta_3$.
This excludes the entire $m=3,6,9$ quadratic-annihilator cases:
at $m=6,9$ the remaining exact poles of the affine $n_2$ would
be Weierstrass gaps. The other two profiles first require
\[
\delta_3=cv,\quad n_2=\rho^2/c\quad(m=10),
\]
\[
\deg\rho=2,\quad\delta_3=c\rho^2,\quad n_2=v/c\quad(m=12),
\]
where $c\in k^\times$. Both are impossible: the $m=12$ identities
force an affine function of exact pole four, and the $m=10$
identities force $\rho=0$ using the fixed derivative and translation
certificates. Thus every polynomial-quadratic annihilator in degree
ten is excluded. In fact no degree-ten annihilator is a polynomial
in $W$ of degree at most six: interpolation first reduces such a
polynomial to degree at most two.

In EVERY primitive admissible degree $n\ge12$ not divisible by
five, no annihilator is a polynomial in $W$ of degree at most five.
The leading interpolation coefficient makes its possible linear
coefficient $A=\rho/(n-5)$ affine, with at most six finite zeros.
A pole of its finite-frame constant coefficient would contribute
at least $2n(n-1)$ discriminant zeros; combining the selected
endpoint inequalities exceeds the global budget. The finite-frame
constant coefficient is therefore affine. The infinity bound and
the same fixed translation matrix force $\rho=0$, a contradiction.
Degree eleven is excluded by the earlier finite endpoint budget.

More generally, in any primitive admissible degree $n$ not divisible
by five, a polynomial expression for $u$ in $W$ of degree at most
five must have degree at most one.

Consequently, in the actual admissible-line problem with
$T=E-G-4H$ nontrivial and killed by five, no witness of ANY
degree $n$ not divisible by five has an annihilator polynomial
in $W$ of degree at most five. No primitivity assumption is
needed for this corollary: the primitive intermediate carries
the polynomial annihilator and remains actually admissible;
the established exclusion through degree nine handles its
small degrees. Nontriviality of $T$ is an explicit input to this
use of the small-degree theorem.

If $5\mid n$ and the source moment $M=\operatorname{Tr}_hW$ is
nonzero, the critical derivative instead has degree $n-7$ and
leading coefficient $vM$. Any polynomial expression for $u$ of
degree at most six reduces to degree at most two. A genuinely
quadratic expression necessarily satisfies
\[
Q=0,\quad n_0=n_1=0,\quad
n_2=\rho^2/M\in L(14O),\quad A=n_2/\rho,
\qquad\rho\in\langle1,x,x^2\rangle\setminus\{0\}.
\]
This is necessary structure in every such degree, not a
nonexistence claim beyond the degree-ten exclusions.

There is a conditional degree-ten critical-incidence consequence.
If $D$ is a squarefree cubic over $k(X)$ and the exact critical
quotient $Q$ is zero, then $D\mid U$ and $u=U(W)/D(W)$ is
polynomial of degree at most two. Consequently the entire $Q=0$
case is excluded. In particular this applies when
$\rho=n_0=n_1=n_2=0$.
No uniform auxiliary rank assertion supplies these vanishings, and
squarefreeness of $D$ is an explicit input to this corollary.

These statements exclude the specified annihilators on already actual
sources. They do not decide all degree-ten or degree-eleven sources,
construct the second étale map, or settle the unmarked problem.

[Proof](../../Proofs/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
