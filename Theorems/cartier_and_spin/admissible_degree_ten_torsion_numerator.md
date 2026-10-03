# Compact torsion numerator, concentrated chart exclusions and dense opens

Version 10, 1 October 2026. Work over $k=\overline{\mathbf F}_5$ on the
fixed genus-nine curve, with the actual primitive degree-ten hypotheses of
[reconstruction](admissible_line_reconstruction.md). Retain reduced
$E$, the connected everywhere étale normalization and the nontrivial
order-five class $E-G-4h^*O$. The result below is necessary only.

Use the support represented by $t=A/([13](x-\alpha))$ in the audited
nonzero-first-moment reply. Its three finite $x$-roots are distinct.
Write $H=h^*O$, $\operatorname{div}(u)=2E-10H$,
$\chi=u/\phi$, $W=b+L_0/y$ and $w=b+B_0/y=W+a$. Let
\[
F_s=v(T^5+q_s)^2+(T^5+q_s)S_s+t^3,\qquad D_s=S_s',
\]
where $s_4\ne0$, $d=\operatorname{pole}_O v$ and
$m=\operatorname{pole}_O s_4$. The nine remaining infinity profiles are
those of [the profile theorem](admissible_degree_ten_nonzero_profiles.md).
The all-sector annihilator theorem gives a unique polynomial
$U_s$ of degree at most five with $U_s(W)=uD_s(W)$.

Put $U_f(T)=U_s(T-a)=\sum_{j=0}^5C_jT^j$ and
$U_s(T)=\sum_{j=0}^5A_jT^j$. Then every $C_j$ is affine regular on $X$,
including at zeros of $v$, and
\[
A_5=vm_4,\quad A_4=vm_5+s_4m_4,\quad
m_4\in\langle1,x,x^2\rangle,\quad m_5\in L_X(10O),
\]
with $\operatorname{pole}_O A_j\le25-j$ for $0\le j\le3$.
These conditions have an exact seventy-coordinate parametrization:
three coordinates for $m_4$, five for $m_5$ and
$r_j\in L_X((25-j)O)$ for $j=0,1,2,3$.

At every selected finite endpoint $P$, independently of concentration,
\[
\operatorname{ord}_P A_0\ge3,\qquad
\operatorname{ord}_P A_1\ge2,\qquad
\operatorname{ord}_P A_2\ge1.
\]
For all nine finite endpoints, the resulting matrix on the 62 lower
coordinates has rank 53, kernel dimension nine and cokernel dimension one.
This fixed lower kernel has an intrinsic bundle description. There is a
fixed rank-two extension
$0\to\mathcal O_X\to\mathcal A\to\mathcal O_X(8O)\to0$
defined by the finite/short translation, and
\[
V_0=H^0(X,\mathcal E),\qquad
\mathcal E=\mathcal O_X(-2O)\otimes\operatorname{Sym}^3\mathcal A.
\]
Its filtered quotient degrees are $-2,6,14,22$, hence
$\deg\mathcal E=40$ and $\chi(\mathcal E)=8$. The exact lower dimension
gives $h^0=9,h^1=1$. Under the actual trigonal map $x:X\to\mathbf P^1$,
\[
x_*\mathcal E\simeq
\mathcal O(1)^2\oplus\mathcal O^5\oplus\mathcal O(-1)^4\oplus\mathcal O(-2).
\]
The two positive pencils give the unique rank-four raw product relation;
this geometric description does not establish uniform trace injectivity.
The necessary numerator space has dimension 16 unless the cokernel
functional vanishes identically on its eight top coordinates. It has
dimension 17 precisely when
\[
v=c_y y,\qquad
(p_1,p_2,p_3,p_4)=
\lambda(\langle20295\rangle,\langle71689\rangle,\langle244055\rangle,1),
\]
where $s_4=p_0+p_1x+p_2x^2+p_3x^3+p_4x^4+p_y y$,
$p_0=[12]p_1+p_2+[24]p_3+[3]p_4$ and angle brackets use the audited
$K$-encoding. This exceptional case lies only on $d=10,m=10$ or $12$.
If its five selected branches have the same first slope, the stronger
necessary orders are $4,3,2,1$ for $A_0,A_1,A_2,A_3$, respectively.
At every one of the nine finite endpoints the four additional rows have
rank four on the fixed nine-dimensional lower space. Thus a finite
concentrated endpoint gives dimension 12, or 13 on the same exceptional
coefficient locus. Its fixed five-dimensional lower subspace has injective
symmetric-square multiplication, of rank 15.
The 16/17-dimensional space retains every concentration possibility;
the older 22-dimensional omitted-endpoint space is superseded.

More generally, if all five selected roots satisfy $W_i-C\in r^kR$,
where $C\in rR$, then the translated numerator coefficients satisfy
$\operatorname{ord}B_j\ge k(4-j)-1$ for $0\le j\le3$, and the translated
critical cubic coefficients satisfy
$\operatorname{ord}(D_s(T+C))_j\ge k(4-j)-3$.
In particular $k\le\operatorname{ord}_P s_4+3$.
If $s_4(P)\ne0$, a whole five-sheet common contact has $k\le3$.
The independent [critical parity section theorem](admissible_degree_ten_critical_parity_section.md)
sharpens the general bound to $k\le9$ and gives
$\sum_P(k_P-1)\le8$ across the nine finite endpoints.
For a concentrated finite endpoint, the full $k=2$ shifted numerator jets
remove all nine lower freedoms for every geometric first slope. Hence
projection to the eight coordinates of $(m_4,m_5)$ is injective.
The concentrated numerator space has dimension at most seven everywhere,
including the displayed exceptional $v,s_4$ locus. This bound is uniform
in the slope and all nine endpoint choices.
Its full shifted jet conditions are equivalent to two explicit polynomial
linear compatibilities on the top functions $A_5\in L_X(16O)$ and
$A_4\in L_X(20O)$, followed by a unique lower completion.
Those two forms are independent on this 21-dimensional top-function
space at every slope. After substituting $A_5=vm_4$ and
$A_4=vm_5+s_4m_4$, the numerator dimension is six wherever the two
resulting forms on eight coordinates are independent. No universal
independence on these eight source-dependent coordinates is asserted.

On the concentrated $(d,m)=(0,12)$ chart, the source equations reduce,
at each endpoint, to one parameter $\eta$ and a unique rational source
tuple. A degree-18 common denominator $H(\eta)$ and a degree-27
numerator $R(\eta)$ satisfy a certified Bezout identity. Thus $H=0$
cannot occur with the normalized nonzero source scale. The valid domain
also retains $R\ne0$ and the nonzero degree-29 leading-coefficient
numerator required by $m=12$.
On this entire valid domain the two restricted top compatibilities have
rank two, at all nine endpoint choices and every geometric slope.
Consequently its necessary numerator space has dimension exactly six.
The entire concentrated $(d,m)=(0,12)$ chart is excluded: there is no
actual source with a concentrated finite endpoint on this profile.
This includes every geometric first slope, all nine endpoint choices,
the degree-18 source-denominator boundary and every closed trace-rank
locus. The proof uses the even critical parity section, its polynomial
norm to the $x$-line and two exact square-tail equations. Certified
polynomial gcd and saturation identities exclude the full valid
one-parameter source domain at each of the three finite $x$-roots;
the raw source pair transfers the result to all three cyclic sheets.

The entire concentrated $(d,m)=(10,3)$ and $(10,6)$ charts are also excluded, at all
nine endpoints and every geometric first slope and free source
coordinate. This includes the source-denominator boundary, the
zero-leading-critical endpoint boundary, and every slope where the
fifteen quadratic trace auxiliary rows have singular determinant.
The source equations reduce to a two-parameter polynomial family;
their two numerator compatibilities have a global free rank-six kernel.
Keeping all fifteen trace auxiliaries independent, exact polynomial
row identities annihilate each of the twenty-one numerator products
by a nonzero scalar times the square of the excluded source denominator.
No auxiliary determinant, finite content coefficient or generic
critical discriminant is inverted in this certificate.

There are explicit nonempty dense coefficient opens, on the irreducible
Newton coefficient charts $(d,m)=(10,3)$ and $(0,12)$ that contain no actual
torsion numerator. They are defined
by the rational pivot and evaluation opens and nonvanishing maximal minors
in the proof. The closed rank-drop loci, their denominator boundaries,
the unconcentrated parts of $(0,12)$, $(10,3)$ and $(10,6)$, the remaining profiles and
the 17-dimensional exceptional case are not excluded.

Every actual source also satisfies the formal resultant identity
\[
\operatorname{Res}_{10,5}(F_s,U_s)=
c\,v^2t^{10}\operatorname{Res}_{10,3}(F_s,D_s),\qquad c\ne0.
\]
Normalize $\operatorname{Nm}(u)=t^{10}$ by its scalar over $k$, and put
$u'=t^2/u$. There are affine functions
$a_j,a_j'\in L_X(10jO)$ for $1\le j\le4$ and $a_5\in L_X(50O)$ such that
\[
M(Z)=Z^{10}-a_1Z^9+a_2Z^8-a_3Z^7+a_4Z^6-a_5Z^5
+t^2a_4'Z^4-t^4a_3'Z^3+t^6a_2'Z^2-t^8a_1'Z+t^{10},
\]
\[
\operatorname{Res}_{10,5}(F_s,U_s-ZD_s)
=v^2\operatorname{Res}_{10,3}(F_s,D_s)\,M(Z).
\]
The resultant degree is formal and is retained at degree drops.
For a separable primitive candidate with $\gcd(F_s,D_s)=1$, this identity
with affine $a_j,a_j',a_5$ forces both $U_s(W)/D_s(W)$ and its reciprocal
$t^2D_s(W)/U_s(W)$ to be finite regular on the normalization.
This converse is only a regularity criterion; it does not force the
prescribed reduced divisor or establish étaleness.

The prescribed divisor can be imposed with one further middle coefficient.
Write $\phi_s=T^5+q_s$ and
$\Delta=\operatorname{Res}_{10,3}(F_s,D_s)$. There is
$b_5\in L_X(50O)$ satisfying
\[
[z^5]\operatorname{Res}_{10,8}(F_s,\phi_sD_s+zU_s)
=\Delta\,t^{10}b_5.
\]
For an already actual primitive connected étale source with the prescribed
$\phi$-divisor, support and nine infinity profiles, the two characteristic
and mixed resultant identities, with the stated affine coefficient
spaces, are equivalent to
$\operatorname{div}(U_s(W)/D_s(W))=2E-10H$ after norm normalization.
No zeros of $v$, $t$ or $\Delta$ are deleted from these polynomial
identities. The generic functions $v,t,\Delta$ must be nonzero.
This equivalence detects annihilation of the divisor class. Once it holds,
its nontriviality is equivalent to $d(\phi u)\ne0$, since
$\operatorname{div}(\phi u)=5(E-G-4H)$.
This additional differential condition still does not construct the source.

No emptiness or realization of the full actual-source locus, and no
unmarked common-cover decision, follows from this theorem.

[Proof and exact certificates](../../Proofs/cartier_and_spin/admissible_degree_ten_torsion_numerator.md).
