# Proof record: Canonical-ring intersection of a coreless étale span

Canonical statement: [`canonical_intersection`](../Theorems/Thm_canonical_intersection.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# The canonical-ring intersection of a coreless etale span

Date: 2026-09-05. Author: `/root/canonical_ring_intersection_coreless_classification`.
Status: direct algebra proof; no common-cover obstruction or clump-existence theorem.

Let \(k\) be algebraically closed, and let \(X\leftarrow^f Z\to^g Y\)
be a finite etale span of smooth projective connected curves of genus
at least two. Use actual differential pullbacks to regard the full
canonical rings \(R(X),R(Y)\) as graded subrings of \(R(Z)\). Assume

\[
                     k(X)\cap k(Y)=k\quad\text{inside }k(Z).
\]

## Exact classification

**Theorem.** The graded intersection \(A=R(X)\cap R(Y)\) is either

\[
             A=k,\qquad\text{or}\qquad A=k[s],\quad\deg(s)=d>0.
\]

In the second case \(d\) is uniquely determined, \(s\) is unique up to
a nonzero scalar, and

\[
 A_m=\begin{cases}k s^{m/d}&d\mid m,\\0&d\nmid m.\end{cases}
 \qquad H_A(t)=\frac1{1-t^d}.
\]

Here the displayed component formula includes \(m=0\).

**Proof.** Both images are graded, so their intersection is graded.
For nonzero \(a,b\in A_m\), their ratio belongs to both endpoint
function fields, hence belongs to \(k\). Thus every component has
dimension at most one.

The full section ring of a line bundle on a normal projective curve
is integrally closed. For example, after choosing a rational frame
and writing its divisor as \(D\), the section ring inside \(k(X)[T]\)
is cut out by the valuation inequalities

\[
       v_P(a_m)+m\operatorname{ord}_P(D)\ge0
       \quad\text{for every coefficient }a_mT^m.
\]

Equivalently it is the intersection of \(k(X)[T]\) with the weighted
Gauss valuation rings, all integrally closed. The endpoint canonical
rings are therefore normal. If an element of \(\operatorname{Frac}(A)\)
is integral over \(A\), it lies in each endpoint fraction field and
is integral over each endpoint ring. It belongs to both rings, hence
to \(A\). This proves normality of \(A\), without assuming finite
generation of the intersection.

Suppose \(S=\{m>0:A_m\ne0\}\) is nonempty, and let \(d\) be its gcd.
There are finitely many \(n_i\in S\) and integers \(e_i\) with
\(\sum_i e_i n_i=d\). Choose \(0\ne a_i\in A_{n_i}\), and put

\[
                 t=\prod_i a_i^{e_i}\in\operatorname{Frac}(A).
\]

Negative exponents are allowed here: this is a homogeneous fraction
of degree \(d\), not yet asserted regular. For any \(n\in S\), choose
\(0\ne a\in A_n\), and write \(n=qd\). The degree-zero ratio
\(t^q/a\) lies in each endpoint function field, since both \(t\) and
\(a\) are homogeneous fractions of each endpoint canonical ring.
Corelessness gives \(t^q=c a\) for \(c\in k^\times\). Thus \(t\) solves
the monic polynomial \(U^q-ca\) over \(A\), so normality implies
\(t\in A_d\). This argument works even when the characteristic
divides \(q\); separability of this polynomial is unnecessary.

Set \(s=t\). All multiples of \(d\) now occur by taking powers of
\(s\), and every occurring degree is a multiple of \(d\) by definition.
The dimension bound identifies every component. Distinct powers of
\(s\) have distinct degrees, proving algebraic independence and the
claimed polynomial-ring description. Uniqueness follows. \(\square\)

The Bezout step is essential: normality saturates the degree semigroup
inside its generated group \(d\mathbf Z\), not inside all of
\(\mathbf Z\). It does not force \(d=1\).

The inherited Poisson bracket on \(A\) is identically zero, because it
is a biderivation and \(\{s,s\}=0\). This does not make \(s\) central
in either endpoint ring or in \(R(Z)\).

## Divisors and clumps

If \(A=k[s]\), write \(s=f^*s_X=g^*s_Y\) in degree \(d\). Etaleness
gives

\[
 D:=\operatorname{div}_Z(s)
   =f^*\operatorname{div}_X(s_X)
   =g^*\operatorname{div}_Y(s_Y),\qquad
 \deg D=d(2g_Z-2)>0.
\]

Consequently the nonempty finite support \(S_D\) is a clump: it is
saturated under both maps' fibers. Multiplicity is constant along
each fiber. Each nonempty multiplicity stratum is therefore also a
clump. The one-clump theorem then shows

\[
                         D=e\sum_{z\in S_D}[z]
                         \quad(e\in\mathbf Z_{>0}).
\]

Over \(k=\overline{\mathbf F}_5\), the converse can be proved directly.
Given a nonempty clump \(S\subset Z(k)\), put \(T=f(S)\), \(U=g(S)\),
and view these sets as reduced effective divisors. Write
\(a=\deg f\), \(b=\deg g\), \(h=2g_Z-2\), and \(N=|S|\). Then

\[
 f^*T=g^*U=S,\qquad
 |T|=N/a,\quad |U|=N/b,\quad
 2g_X-2=h/a,\quad 2g_Y-2=h/b.
\]

The line bundles \(\mathcal O_X(hT)\otimes\omega_X^{-N}\) and
\(\mathcal O_Y(hU)\otimes\omega_Y^{-N}\) have degree zero. Every
degree-zero line bundle over an algebraic closure of a finite field
is torsion: its point of the Jacobian is defined over some finite
field. Choose a common positive torsion-killing exponent \(r\).
There are sections of \(\omega_X^{rN}\) and \(\omega_Y^{rN}\) whose
divisors are respectively \(rhT\) and \(rhU\). Their pullbacks have
the same divisor \(rhS\); their ratio is a nonzero constant on \(Z\).
Rescaling one section makes the pullbacks equal. Hence \(A\ne k\).

Thus, in the characteristic-five setting at issue,

\[
 A\ne k\quad\Longleftrightarrow\quad
 \text{a nonempty clump exists}.
\]

An arbitrary effective divisor does not suffice: it must descend
under both maps. But once a clump is given, the requisite canonical
weights can indeed be obtained after taking powers. No extra
unproved canonical-divisor condition is needed here.

For the source boundaries: Krishnamoorthy's *Correspondences without
a core*, [published paper](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
Proposition 8.2 gives the section-dimension bound; Corollary 8.10
relates positive invariant line bundles to the canonical pair;
Theorem 9.6 gives clump uniqueness. Corollaries 8.13 and 9.2 imply
\(A=k\) for the characteristic-zero projective etale coreless setting.
Question 9.7 asks whether a clump always exists in positive
characteristic. The proof above classifies the intersection but
does not answer that question.

## Numerical content and limits

For the generator divisor \(D=eS\), the exact numerical identities are

\[
 e|S|=d(2g_Z-2),\quad
 e|f(S)|=d(2g_X-2),\quad
 e|g(S)|=d(2g_Y-2).
\]

In particular \(a,b\mid |S|\) and
\(|f(S)|/|g(S)|=(g_X-1)/(g_Y-1)=b/a\). These are compatibility
conditions on a clump and its multiplicity. Eliminating its unknown
cardinalities recovers the existing etale Riemann--Hurwitz identity;
this supplies no new restriction on the endpoint genus ratio.
Neither the algebra classification nor these divisor-degree
identities involve or determine endpoint-Jacobian \(p\)-ranks.
If \(d=1\), there is a common one-form; if \(d>1\), there is none.
A claim of further \(p\)-rank consequences requires an additional
argument beyond this note.

Characteristic-zero coreless examples have \(A=k\) by the cited
theorem. In positive characteristic the algebraic alternative
\(A=k\) is not an exhibited example: such an example under all the
present projective etale hypotheses would answer Question 9.7
negatively. The [checked literature boundary](../routes/global/CORELESS_CLUMP_PRIMARY_SOURCE_BOUNDARY_2026_09_05.md)
does not establish such an example. Known positive-characteristic
examples carrying an invariant Hasse pluriform instead have
\(A=k[s]\). Neither alternative can be ruled out merely by this
normality argument.
