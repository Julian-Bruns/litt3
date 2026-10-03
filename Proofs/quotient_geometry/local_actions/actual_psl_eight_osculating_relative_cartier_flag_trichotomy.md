# Proof of the actual relative Cartier flag trichotomy

Version1, 3 October2026. Retain all ACTUAL curve, scalar-action,
literal-module and wild-partition hypotheses in the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_osculating_relative_cartier_flag_trichotomy.md).
The independent
[local/degree](../../../Research/notes/oct03_ten_hour/eight_module_actual_osculating_local_degree_audit.md),
[scalar/Cartier](../../../Research/notes/oct03_ten_hour/eight_module_actual_osculating_scalar_cartier_audit.md),
and [rank-six ledger](../../../Research/notes/oct03_ten_hour/eight_module_actual_osculating_six_ledger_audit.md)
audits pin the original two
[osculating](../../../Research/notes/oct03_ten_hour/eight_module_actual_osculating_four_five_cartier_flags.md)
[notes](../../../Research/notes/oct03_ten_hour/eight_module_actual_osculating_six_cartier_ledger.md).
No computation or abstract-tuple replay is used.

## Genuine projective differentiation

Put \(n=|Q|\), \(p_0=\deg P=n/40\), so \(\deg\omega=4p_0\).
The accepted actual first/third flags and universal-extension theorem
give \(U_3\subset R_3\) and all three genuine comparisons in the
statement. In compatible local scalar frames their coefficient columns
are \(x^{[5]},x^{[25]}\), and the original section has column \(x\).

For any genuine subbundle \(R\subset E\), differentiating coefficient
vectors in a regular \(P\)-frame gives
\[
\theta_R:R\longrightarrow(E/R)\omega.
\]
This map is linear because differentiation of a scalar multiple adds
a multiple of a section of \(R\). A change of scalar frame likewise
adds a scalar one-form times such a section, hence changes nothing in
the quotient. Constant natural \(H\)-matrix transport commutes with
differentiation and its cotangent pullback. The paired central actions
cancel, so the map is genuine on \(\mathcal S\).
No connection on \(P\) is chosen.

The two \(U_3\) columns have zero coefficient derivatives. Thus
\(\theta_{R_3}\) factors through \(R_3/U_3=\omega^2\) and gives
\(\psi_3:\omega\to E/R_3\).

## The first osculating map has no zeros

At an actual wild point choose
\[
g(t)=t/(1+t),\qquad u=t^5/(1-t^4),\qquad
r=(du)^{1/4}.
\]
The specified line comparison permits the invariant rational \(r\)
of valuation two; its fourth-root scalar ambiguity is trivial on
\(C_5\). Use the regular scalar frame \(r/t^2\).
For each rational Jordan chain the exact invariant coefficient lattice
is
\[
t^2\sum_{j=0}^{s-1}f_j(u)u^{\lceil(j-2)/5\rceil}
        \exp(-t^{-1}N)e_j,
\qquad Ne_j=e_{j-1},\qquad f_j\in k[[u]].
\tag{1}
\]
Write \(x=x_0+t x_1+t^2x_2+\cdots\). The accepted two-socle
value is \(x_0=a e_0+b f_0\), with \(ab\ne0\) and
\(a/b\notin\mathbf F_5\).
The first three terms of (1) are
\[
c_0t^2e_0+c_1(-t e_0+t^2e_1)
 +c_2(\tfrac12e_0-t e_1+t^2e_2),
\]
where \(c_j=f_j(0)\). Thus in BOTH partitions
\[
x_1=-2a e_1-2b f_1\pmod{\text{socles}},\qquad
x_2=2a e_2+2b f_2\pmod{\text{levels zero and one}}.
\tag{2}
\]
Both blocks have length at least three. No later lattice term affects
these coefficients.

Choose constants \(s,v\) with \(x_0^{[25]}=s x_0^{[5]}+v x_0\).
The irrational ratio gives \(v\ne0\). The exact third-flag wild
Smith order one makes
\[
h=t^{-1}(x^{[25]}-s x^{[5]}-v x)
\]
a regular generator supplementing \(U_3\) in \(R_3\).
Its value is \(-v x_1\), transverse to the socle plane, and its
derivative has value \(-v x_2\) modulo \(R_3(0)\).
The latter is nonzero by (2). Therefore \(\psi_3\) is nonzero
at every wild point.

If its zero divisor is \(Z\), its saturated image is \(\omega(Z)\).
The globally generated quotient \((E/R_3)P^{-1}\), of rank five,
has degree \(23p_0\). The image line after this twist has degree
\(3p_0+\deg Z\); the remaining rank-four quotient is globally
generated. Hence \(\deg Z\le20p_0=n/2\).

Equality cannot hold. A globally generated degree-zero bundle is
trivial: a generically independent set of global sections has a
nonzero determinant without zeros. A quotient of
\(W\otimes\mathcal O_D\) onto that trivial bundle is constant on
the proper connected curve. The paired action, after the \(P^{-1}\)
twist, makes its proper constant kernel an \(H\)-stable subspace
of irreducible \(W\), a contradiction. Thus the bound is strict.
The invariant \(Z\) contains no wild point. Every remaining orbit
has size at least \(n/2\), forcing \(Z=0\).

The inverse image of the everywhere line subbundle \(\omega\)
gives \(R_4\), with \(R_4/R_3=\omega\) and
\(\det R_4=\omega^{-4}\).
Its fundamental form kills \(R_3\), because all derivatives of
\(R_3\) already lie in \(R_4\omega\). It therefore factors as
\(\psi_4:\mathcal O\to E/R_4\).

## Exact wild zeros of the next form

For \(J_4\oplus J_4\), (1) gives \(x_3=0\), \(x_4\) in the
socle plane and \(x_5\) in chain levels zero and one.
Since \(u=t^5+O(t^9)\), put \(A=-s x_1^{[5]}-v x_5\); then
\[
h=-v x_1-vt x_2-vt^3x_4+t^4A+O(t^5),
\quad h''=-6v t x_4+12t^2A+O(t^3).
\tag{3}
\]
By the nowhere-zero result, \(R_4\) is locally generated by the
two \(U_3\) columns, \(h\), and \(h'\). Those first two columns
are constant modulo \(t^5\). The linear socle term of \(h''\)
can therefore be removed using them, leaving order at least two.
This proves wild order at least TWO for nonzero \(\psi_4\).

For \(J_5\oplus J_3\), the additional \(j=4\) term is
\(t^2u f_4(u)\exp(-t^{-1}N)e_4\). Its first term has degree
three and is in the long socle. Therefore \(x_3\) is a socle
vector, and \(h''(0)=-2v x_3\) vanishes modulo \(R_4(0)\).
This proves wild order at least ONE only. No stronger reduction
is used in this partition.

For \(\psi_4\ne0\), let its zero divisor be \(Z_4\).
The globally generated rank-four quotient \((E/R_4)P^{-1}\)
has degree \(20p_0\), and the saturated image line has degree
\(-p_0+\deg Z_4\). The remaining globally generated quotient
gives \(\deg Z_4\le21p_0\), with equality excluded by the same
irreducibility argument. A wild orbit has degree \(8p_0\),
a tame orbit \(20p_0\), and an ordinary orbit \(40p_0\).
The compulsory wild zero consequently forces
\[
Z_4=D_5\quad\hbox{or}\quad2D_5.
\tag{4}
\]
For the length-four partition only \(2D_5\) is possible.
The accepted genuine Picard calibration is
\(\mathcal O(D_5)=\omega^2\).

If \(\psi_4=0\), \(R_4\) is horizontal. If \(Z_4=2D_5\),
its saturated image is \(\omega^4\), giving \(R_5/R_4=\omega^4\)
and \(\det R_5=\mathcal O\). The next form factors as
\(\omega^3\to E/R_5\). After twist by \(P^{-1}\), its nonzero
image would have degree at least \(11p_0\), inside a globally
generated rank-three quotient of degree \(5p_0\).
Its remaining quotient would have negative degree, impossible.
Thus \(R_5\) is horizontal.

## Relative Cartier determinant and the rank-seven closure bound

Let \(\mathcal S_1=\mathcal S^{(1)}\), \(E_1=E^{(1)}\).
Under the usual semilinear projection, the specified absolute identity
gives \(F_{\rm rel}^*E_1=E\omega=P^5W\).
In a compatible regular \(P\)-frame \(e\), the frame \(e^5\)
is a relative pullback frame, with canonical coefficient connection
\(d\). Its connection on a twisted subbundle \(R\omega\)
agrees modulo that subbundle with the projective differentiation above.
Consequently horizontal \(R\) descends to a subbundle of \(E_1\).
Cartier descent is applied on the smooth actual atlas and then to its
compatible genuine group isomorphisms; no wild invariant averaging is
needed. The quotient descends as a bundle as well.

The genuine Picard groups on both actual stacks are free, generated
by their canonical lines, and \(F_{\rm rel}^*\omega_1=\omega^5\)
as line bundles. Hence for a horizontal rank-\(r\) subbundle with
\(\det R=\omega^e\), necessarily
\[
e+r\equiv0\pmod5.
\tag{5}
\]
This uses genuine Picard descent, rather than ordinary Picard
pullback injectivity on \(D\).

The smallest projectively horizontal closure of \(R_3\) has generic
rank at most seven. Choose a rational \(P\)-frame and a separating
parameter \(t\) for \(K=k(D)\). Then \([K:K^5]=5\), so its
coefficient vector decomposes as
\[
x=\sum_{j=0}^4t^jv_j,\qquad v_j\in(K^5)^8.
\]
The span of these five vectors is horizontal for coefficient
differentiation and contains \(x\); adding the two horizontal
columns \(x^{[5]},x^{[25]}\) gives dimension at most seven.
The smallest derivative-stable generic subspace containing \(R_3\)
therefore has at most that dimension. Its regular saturation remains
connection-preserved: differentiation of a regular section is regular
and stays in the horizontal rational subspace. The canonical connection
and unique smallest closure make this saturation genuine.
Every subsequent osculating inverse image stays inside the closure.
In particular an osculating flag of rank seven must be horizontal.

## The length-five residual branch reaches rank six

Suppose \(Z_4=D_5\). It is available only for \(J_5\oplus J_3\).
Then \(R_5/R_4=\omega^2\), \(\det R_5=\omega^{-2}\), and
the next form factors as \(\psi_5:\omega\to E/R_5\).
It cannot be zero by (5): horizontal \(R_5\) would give
\(-2+5=3\), not a multiple of five.

The globally generated rank-three quotient \((E/R_5)P^{-1}\)
has degree \(13p_0\). Its saturated image line has degree
\(3p_0+\deg Z_5\), giving \(\deg Z_5\le10p_0\).
Thus the invariant zero divisor is \(0\) or \(D_5\).
If it were \(D_5\), the next rank-six flag would have quotient
\(\omega^3\) and determinant \(\omega\). Its next form would
factor as \(\omega^2\to E/R_6\).
The globally generated quotient after \(P^{-1}\)-twist has degree
\(2p_0\), while any nonzero image has degree at least \(7p_0\).
The map must be zero, making \(R_6\) horizontal, contrary to
(5), since \(1+6=7\). Therefore \(Z_5=0\).

We obtain \(R_6/R_5=\omega\), \(\det R_6=\omega^{-1}\).
If \(R_6\) were not horizontal, its next form would factor as
\(\mathcal O\to E/R_6\).
The globally generated rank-two quotient after scalar twist has
degree \(10p_0\); the remaining quotient bound gives
\(\deg Z_6\le11p_0\). Thus \(Z_6=0\) or \(D_5\).
The next rank-seven flag would have determinant \(\omega^{-1}\)
or \(\omega\). It must be horizontal by the closure bound,
but (5) gives respectively six or eight, neither divisible by five.
Both alternatives fail. Hence \(R_6\) is horizontal.

## Descended flags and precise scope

In the rank-four, five and six cases the determinants of
\(R_i\omega\) are respectively \(\mathcal O\), \(\omega^5\)
and \(\omega^5\). The genuine Picard comparison therefore gives
descended determinants \(\mathcal O\), \(\omega_1\), \(\omega_1\).
Each higher flag contains \(U_3\), and
\[
U_3\omega=\mathcal O\oplus\omega^{-5}
 =F_{\rm rel}^*R_{2,1}
\]
as the ACTUAL inclusion: it is obtained by taking relative Frobenius
of the original first flag. Full faithfulness descends its containment.

Absolute Frobenius, the semilinear projection and the actual relative
twist remain distinct. No \(\mathbf F_5\)-model or original \(Y_1\)
identity has been introduced. A source application needs its existing
actual quotient/pullback and exact original scalar/relative calibration;
matching numerical invariants does not identify an original kernel.
The actual weak-curve sectors remain conditional, and neither original
endpoint is descended. BOTH actual finite étale legs remain on the
SAME original \(T\); the common-cover problem remains open.
