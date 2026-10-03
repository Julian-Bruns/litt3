# Uniform low traces of an admissible annihilator

Version6,1 October2026. Let $k=\overline{\mathbf F}_5$,
$B=\mathbf F_5(\beta)$, $\beta^2=\beta+3$, and encode
$a+b\beta$ by $[a+5b]$, $0\le a,b<5$. The following polynomial
rows are ascending:
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad
A=(1,21,14,22,13),
\]
\[
Q=(0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24),
\]
\[
B_0=(8,14,19,2,10,19,3,24,18,16),\quad
L_0=(18,20,20,15).
\]
Let $X$ be the smooth proper model of $y^3=P(x)$, with unique point
$O$ at infinity, $\operatorname{ord}_O x=-3$ and
$\operatorname{ord}_O y=-10$. Put $f=Q/y^5$ and
$R=O+x^*\operatorname{div}_0A$. The fixed inputs are that $P,A$
are squarefree and coprime, $P^2\mid Q-B_0^5$, and
$A^3\mid Q-L_0^5$.

Let $h:S\to X$ be an **actual** connected finite étale cover of any
degree $n\ge1$, with $S$ smooth proper and $H=h^*O$. Suppose
$b\in k(S)$, $E\le h^*R$ is reduced of degree $5n$, $G\ge0$
has degree $n$, $E,G$ have disjoint support, and
\[
\phi=h^*f+b^5,\qquad
\operatorname{div}(\phi)=3E-5G-10H.
\]
Neither $E$ nor $G$ is required to avoid $H$. Suppose a nonzero
$u\in k(S)$ satisfies
\[
\operatorname{div}(u)=2E-10H.
\]
This last condition is precisely the annihilation $5T\sim0$ for
$T=E-G-4H$; no nontriviality of $T$ is needed for the theorem.

Set $W=b+h^*(L_0/y)$, $\chi=u/\phi$, and
$m_j=\operatorname{Tr}_{k(S)/k(X)}(\chi W^j)$. Then
\[
m_0=m_1=m_2=m_3=0,\qquad
m_4\in\langle1,x,x^2\rangle_k,\qquad
m_5=\operatorname{Tr}_{k(S)/k(X)}(u)\in L_X(10O).
\]
No primitivity of $b$, support-pushforward reduction, source polynomial
form, infinity partition or restriction to a finite coefficient field is
assumed.
Also, without primitivity and even before assuming that $u$ exists,
\[
\operatorname{Tr}_{k(S)/k(X)}(W^j/\phi)=0
\qquad(0\le j\le4).
\]

There is also a support criterion for primitivity. Let
$B=h_*E/5$, the integral effective divisor supplied by the uniform
norm theorem, and let $c(B)$ be the greatest common divisor of its
nonzero integer coefficients. Then
\[
[k(S):k(X)(b)]\mid c(B).
\]
In particular $c(B)=1$ forces $b$ to be primitive. This criterion
needs the divisor hypotheses but not the annihilator or torsion
condition. By the established degree-ten/eleven support reduction,
every actual admissible source of degree ten or eleven has
$B=(n-9)O+x^*(r_1+r_2+r_3)$ with distinct roots of $A$, hence
$c(B)=1$ and a primitive $b$.

If in addition $b$ is primitive, let $F(T)\in k(X)[T]$ be the monic
minimal polynomial of $W$. Then $n\ge6$, and
\[
F(T)=(T^5+q_s)\mathscr H(T)+\tau,\qquad
q_s=(Q-L_0^5)/y^5,\quad \tau\in k(X)^*,\quad
\deg\mathscr H=n-5.
\]
The raw polynomial form needs only the preceding divisor hypotheses,
before assuming that $u$ exists. It follows from the established
[fifth-power norm theorem](uniform_admissible_norm.md).
There is $U(T)\in k(X)[T]$ such that
\[
\deg_T U\le n-5,\qquad
U(W)=\chi F'(W)=u\mathscr H'(W).
\]
For the established degree-ten raw form
$F_s=v(T^5+q_s)^2+(T^5+q_s)S_s+t^3$, this gives $\deg U\le5$ and
$U(W)=uS_s'(W)$ with that raw polynomial's normalization.
Every coefficient belongs to the original source.

There is a direct coefficient bound whenever the actual infinity
profile is given. Write the raw polynomial as
$F_{\rm raw}=v\prod_i(T-W_i)$ and its trace-dual numerator as
$U_{\rm raw}=\sum_jA_jT^j$. Let $d=-\operatorname{ord}_O v$,
let $e$ be the number of small sheets (those in $E$ above $O$),
and let $A_{\rm big}$ be the sum of the pole orders of the other sheets.
Then
\[
\operatorname{pole}_O A_j\le d+A_{\rm big}+e-j
\qquad(0\le j\le\min\{n-5,e-1\}).
\]
The bound allows repeated leading residues and regular small roots.

For every actual degree-ten source, using the established raw
normalization $\operatorname{div}(v)=h_*G-10O$,
$e=5$, $A_{\rm big}=20-d$, and hence
$A_j$ has pole at most $25-j$ for $0\le j\le4$, while
$A_5=vm_4$ has pole at most $d+6$.
For every actual degree-eleven source in the remaining profiles below,
using $\operatorname{div}(v)=h_*G-11O$,
every coefficient $A_j$, $0\le j\le6$, has pole at most $23-j$.

Under the original hypotheses, with the annihilator $u$ but without
primitivity of $b$, the number of infinity sheets on which $W$ has pole
exactly two is either zero or at least four. Thus one, two or three
pole-two sheets are excluded in **every** covering degree, with repeated
leading residues and arbitrary finite $G$-multiplicities retained.
Also, if there are no pole-two sheets, there cannot be exactly one
pole-three sheet.

For an actual admissible source of degree eleven, the projected support
has $B_\infty=2$, hence ten small infinity sheets and one big sheet.
If $v$ satisfies $\operatorname{div}(v)=h_*G-11O$ and
$d=\operatorname{pole}_O v$, then its big pole is $13-d$.
The possible values of $d$ in $L_X(11O)$ are $0,3,6,9,10$.
The unique pole-three obstruction excludes $d=10$; consequently
$v\in L_X(9O)$ and the remaining possible big poles are $13,10,7,4$.
This is a necessary reduction, not an exclusion of degree eleven.

These are necessary traces and interpolation identities on an existing
actual admissible source. They do not construct an admissible line from
an unmarked pair of finite étale maps, or decide arbitrary-degree source
existence.

[Proof](../../Proofs/cartier_and_spin/admissible_annihilator_trace_vanishing.md).
