# Primitive discriminants give parity sections and contact budgets

Version4, 1 October2026. Work on the fixed genus-nine curve $X$.
Retain an actual connected finite étale primitive admissible source
$h:S\to X$ of degree $n\ge6$, with $H=h^*O$,
\[
\operatorname{div}\phi=3E-5G-10H,\quad
E\le h^*R_X\text{ reduced},\quad \deg E=5n,\quad\deg G=n,
\quad E\cap G=\varnothing.
\]
For this general-degree assertion assume the admissible torsion
condition $5(E-G-4H)\sim0$, equivalently an annihilator
$\operatorname{div}u=2E-10H$. Write $h_*E=5B$ and
$e=5\operatorname{ord}_O B$, the number of selected infinity sheets.
The global principal-support theorem supplies affine functions
\[
\operatorname{div}t=B-nO,\qquad
\operatorname{div}v=h_*G-nO.
\]
With a scalar choice of $t$, the raw primitive polynomial is
$F=(T^5+q_s)\mathscr H+t^3$, has leading coefficient $v$, and
$\deg\mathscr H=n-5$. Define the formal-degree critical resultant and
discriminant quotient by
\[
\Delta=\operatorname{Res}_{n,n-6}(F,\mathscr H'),\qquad
C=\operatorname{Disc}(F)/t^{20},\qquad
M=4n^2-24n-e^2+5e.
\]
Then
\[
C\ne0,\quad C\in L_X(MO),\quad
\operatorname{div}C\in2\operatorname{Div}(X),\qquad
C=(-1)^{n(n+1)/2}\frac{\Delta}{t^5v}.
\]
The resultant retains formal degree $n-6$ when the derivative degree
drops. The parity conclusion does not make $C$ a square in $k(X)$.
Its half-divisor defines the unramified sign-character line
$L\in\operatorname{Pic}(X)[2]$, and a nonzero section of
$\mathcal O_X((M/2)O)\otimes L$ whose square represents $C$.
Here $M$ is even; if $M<0$, these conditions exclude the source.

At a finite endpoint $P$ with $b_P=\operatorname{ord}_PB>0$, its
$5b_P$ selected roots have a common residue. If their common contact
order is at least $k_P\ge1$, then
\[
\operatorname{ord}_PC\ge
25b_P(b_P-1)+5b_P(5b_P-1)(k_P-1).
\]
The sum of these lower bounds over all finite endpoints is at most
$M$. Repeated residues, finite $G$ poles and zeros of $v$ are retained.
In degree eleven the established support has $e=10$, nine finite
$b_P=1$ endpoints, and $M=170$. Hence
$\sum_P(k_P-1)\le8$ and complete-cohort contact has order at most nine.
Its half-section spaces have degree 85 and dimension 77.

Writing $b_P$ for all thirteen projected occupancies, including infinity,
the same budget has the concise form
\[
25\sum_P b_P^2+
\sum_{P\ne O}5b_P(5b_P-1)(k_P-1)\le4n^2+n.
\]
In particular the projected support size $r$ satisfies
$r\ge\lceil25n/(4n+1)\rceil$, so $r\ge7$ for $n>6$.
This is a direct discriminant consequence on a primitive source; it
does not require a monodromy orbit construction or survive unchanged
when the primitive function is pulled to a larger nonprimitive source.

## Degree-ten specialization

The following sharper displayed cubic normalization needs no extra
torsion assumption once its normalized projected support is supplied.
Use $\operatorname{div}\omega_0=16O$ and retain an actual connected finite
étale primitive admissible degree-ten source $h:S\to X$, with
\[
\operatorname{div}\phi=3E-5G-10H,\qquad H=h^*O,
\qquad E,G\text{ disjoint},\qquad \deg E=50,\quad\deg G=10.
\]
Use the normalized support $h_*E/5=O+\operatorname{div}_0t$, where $t$
has three distinct finite $x$-roots, nine simple endpoint points and pole
nine at $O$. Let $W$ be the short coordinate and retain the full normalized
source polynomial
\[
F=v\phi_T^2+\phi_T S+t^3,\quad \phi_T=T^5+q_s,
\quad S=\sum_{i=0}^4s_iT^i,\quad D=S',\quad s_4\ne0.
\]
It is the raw minimal polynomial of $W$, with leading coefficient $v$,
$\operatorname{div}v=h_*G-10O$ and $d=\operatorname{pole}_O v$.
The supplied short coefficient bounds at infinity are
\[
\operatorname{pole}_O s_4\le12,\qquad
\operatorname{pole}_O s_3\le14,\qquad
\operatorname{pole}_O s_2\le16,\qquad
\operatorname{pole}_O s_1\le17.
\]
Only $s_4$ is additionally affine regular. The lower short
coefficients may have finite poles at cubic branch points; these
displayed bounds do not put them in the affine spaces $L_{14}$,
$L_{16}$ or $L_{17}$.
Five infinity sheets are selected, with $W$ pole at most one; the five
big sheets have poles $a_i\ge2$ with $\sum a_i=20-d$.
The finite coordinate is $w=W+Z/y$, where the fixed numerator is
$Z=(15,19,24,12,10,19,3,24,18,16)$ in the established ascending
coefficient convention. This translation is regular at selected endpoints,
but may have poles at cubic branch points. Write $F_f(T)=F(T-Z/y)$
and $D_f(T)=D(T-Z/y)$; the corresponding finite $q_f,F_f,D_f$
have affine-regular coefficients and primitive content
$\operatorname{ord}_P v=\sum_{h(Q)=P}g_Q$ at every finite point, where
$g_Q$ are its root pole orders. These are the actual normalized source
hypotheses; they are not imposed on arbitrary separable polynomials.
At each finite endpoint the five selected short roots have order at least
one and $\phi$ has exact order three on them. No annihilator or torsion
hypothesis is needed for the conclusions below.

With actual cubic-degree resultant
\[
\Delta=\operatorname{Res}_{10,3}(F,D),\qquad C=\Delta/t^5,
\]
this specialized $C$ differs from the general discriminant quotient
only by a nonzero constant, and
one has
\[
\Delta\ne0,\qquad C\in L_X(160O),\qquad
\operatorname{div}C\in2\operatorname{Div}(X).
\]
The function $C$ need not be a square in $k(X)$. Its half-divisor defines
the unramified sign-character two-torsion line $L$, and
$C\omega_0^{10}$ is the square, with this twist, of a nonzero section
of $\omega_X^5\otimes L$. There are $2^{18}$ possible classes $L$;
each corresponding section space has dimension 72.

At each selected finite endpoint $P$, choose a common local center $C_P$
and an integer $k_P\ge1$ such that all five selected short roots satisfy
$W_i-C_P\in r^{k_P}R$ in the completed actual étale split disk. Then
\[
\operatorname{ord}_P C\ge20(k_P-1),\qquad
\sum_{P\in\operatorname{div}_0t}(k_P-1)\le8.
\]
In particular complete-cohort contact has order at most nine. Zeros of
$v$, repeated slopes and concentrated endpoints are retained.

This is a bounded one-leg necessary condition. It does not supply a
shared section from the second actual map or decide source existence.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
