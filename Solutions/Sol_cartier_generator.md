# Proof record: Frobenius and Cartier constraints on a primitive invariant

Canonical statement: [`cartier_generator`](../Theorems/Thm_cartier_generator.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Frobenius and Cartier constraints on a coreless invariant generator

Date: 2026-09-05. Author: `/root/coreless_invariant_degree_cartier_constraints`.
Status: direct proof with explicit Frobenius conventions; no new
common-cover obstruction or clump-existence claim.

Let \(k=\overline{\mathbf F}_5\), and let \(X\leftarrow^f Z\to^g Y\)
be an actual finite etale span of smooth projective connected curves
of genus at least two, with \(k(X)\cap k(Y)=k\) inside \(k(Z)\).
Use actual differential pullbacks for the canonical rings. By the
[intersection classification](Sol_canonical_intersection.md),
their graded intersection is either \(k\) or \(k[s]\).
Assume the latter, and put \(d=\deg s>0\). Thus \(A_m=0\) unless
\(d\mid m\), and \(A_{qd}=ks^q\).

## Statement

The primitive degree satisfies \(5\nmid d\). Let \(1\le r\le4\)
be the inverse of \(d\) modulo 5, and put

\[
 n=\frac{rd-1}{5},\qquad w=n+1=\frac{rd+4}{5}.
\]

There is a canonical additive, inverse-Frobenius-semilinear operator

\[
 C_{C,n}:H^0(C,\omega_C^{5n+1})
       \longrightarrow H^0(C,\omega_C^{n+1})
\]

for every smooth curve \(C/k\), compatible with etale pullback.
Consequently \(C_{Z,n}(s^r)\in A_w\), with the exact alternatives

\[
 \begin{cases}
 C_{Z,n}(s^r)=0,&d\nmid4,\\
 C_{Z,n}(s^r)=c s\quad(c\in k),&d\mid4.
 \end{cases}                                                     \tag{1}
\]

In the second line \(r=5-4/d\) and \(w=d\); the scalar \(c\) is
allowed to be zero. Every other power of \(s\) with weight congruent
to 1 modulo 5 is \(s^{r+5q}\), \(q\ge0\), and satisfies

\[
 C_{Z,n+qd}(s^{r+5q})=s^q C_{Z,n}(s^r).                         \tag{2}
\]

Thus if \(d\nmid4\), Cartier kills all eligible homogeneous
invariants. This argument does **not** force \(d\mid4\): there is
no nonvanishing theorem for the image in (1).

There is also a restriction on each zero multiplicity \(e\) of \(s\):

\[
                            e+d\not\equiv0\pmod5.              \tag{8}
\]

In particular it applies to the common multiplicity in the clump
divisor \(\operatorname{div}_Z(s)=eS\).

## The canonical connection excludes a factor of five

For \(m\ge0\), the line bundle \(\omega_C^{5m}\) has the canonical
connection

\[
 \nabla_m:\omega_C^{5m}\longrightarrow\omega_C^{5m+1}.
\]

In a local frame \(e\) of \(\omega_C^m\), its formula is

\[
                  \nabla_m(ae^5)=e^5\otimes da.                 \tag{3}
\]

Changing \(e\) by \(u e\) changes \(e^5\) by \(u^5\), whose
differential is zero. Formula (3) therefore glues, preserves
regularity, and commutes with etale differential pullback. In
relative Frobenius notation, it is the canonical connection on
\(F_C^*\omega_{C^{(5)}}^m\simeq\omega_C^{5m}\).
This line-bundle identification is not the differential of
Frobenius, which is zero.

If \(d=5m>0\), write \(s=f^*s_X=g^*s_Y\). Functoriality gives

\[
 \nabla_m s=f^*(\nabla_m s_X)=g^*(\nabla_m s_Y)\in A_{d+1}.
\]

Since \(d\ge5\) and \(d\nmid d+1\), this common section is zero.
Pullback of regular pluriforms along a finite etale surjection is
injective, so both endpoint sections are horizontal.

Every horizontal regular section of \(\omega_C^{5m}\) is the fifth
power of a unique regular section of \(\omega_C^m\). Indeed, in a
rational frame write it \(ae^5\). Horizontality means \(da=0\),
and \(\ker(d:k(C)\to\Omega^1_{k(C)/k})=k(C)^5\), since \(k\) is
perfect and \(k(C)\) has transcendence degree one. Write \(a=b^5\).
The resulting rational section \(be\) is regular because its fifth
power is regular: every valuation of \(be\) is one fifth of the
corresponding nonnegative valuation. Uniqueness follows from
injectivity of fifth powers in the function field.

Thus \(s_X=t_X^5\), \(s_Y=t_Y^5\) for regular weight-\(m\) sections.
Their pullbacks have equal fifth powers, hence are equal. They give
a nonzero element of \(A_m\), contrary to \(0<m<d\). This proves
\(5\nmid d\).

## Relative Cartier and the precise untwisting

Put \(C'=C^{(5)}=C\times_{k,F_k}k\), and let \(F_C:C\to C'\)
be relative Frobenius. Projection formula followed by ordinary
relative Cartier gives a canonical \(k\)-linear map

\[
 \begin{aligned}
 \operatorname{Car}_{C,n}:H^0(C,\omega_C^{5n+1})
 &\simeq H^0(C',\omega_{C'}^n\otimes F_{C*}\omega_C)\\
 &\longrightarrow H^0(C',\omega_{C'}^{n+1}).
 \end{aligned}                                                   \tag{4}
\]

For every weight \(a\), scalar base change gives a canonical
additive bijection

\[
 j_{C,a}:H^0(C,\omega_C^a)\longrightarrow H^0(C',\omega_{C'}^a),
 \qquad j_{C,a}(\lambda u)=\lambda^5j_{C,a}(u).
\]

It is induced by \(u\mapsto u\otimes1\); perfectness makes it
bijective. Define

\[
 C_{C,n}=j_{C,n+1}^{-1}\operatorname{Car}_{C,n},\qquad
 C_{C,n}(\lambda u)=\lambda^{1/5}C_{C,n}(u).                      \tag{5}
\]

This is canonical on section spaces. It requires no choice of a
\(k\)-isomorphism \(C\simeq C'\), and asserts no such isomorphism.
The construction in (4), and the maps \(j\), commute with etale
pullback and its Frobenius twist. Therefore (5) commutes with
pullback on the original curves.

For an explicit rational-coordinate formula, choose a separating
parameter \(t\), and uniquely write \(a=\sum_{i=0}^4 a_i^5t^i\).
Then

\[
 C_{C,n}\bigl(a(dt)^{5n+1}\bigr)=a_4(dt)^{n+1}.                  \tag{6}
\]

Coordinate independence and regularity follow already from (4).
They can also be checked using ordinary Cartier and its identity
\(C(b^5\eta)=bC(\eta)\): changing the differential frame in its
weight-\(5n\) factor contributes a fifth power, precisely canceled
by this identity. The same rule gives, for sections of weights
\(a\) and \(5n+1\), respectively,

\[
                 C_{C,n+a}(v^5u)=v C_{C,n}(u).                  \tag{7}
\]

## Applying Cartier to the invariant generator

Apply the pullback compatibility of (5) to \(s_X^r,s_Y^r\). Their
Cartier images pull back to the same regular weight-\(w\) section
on \(Z\). It belongs to \(A_w\). Since \(5w=rd+4\), and \(5\nmid d\),

\[
                         d\mid w\iff d\mid4.
\]

If \(d\nmid4\), then \(A_w=0\), proving the first line of (1).
If \(d\mid4\), then \(d\in\{1,2,4\}\), and its inverse modulo 5
in the specified range is \(r=5-4/d\). Substitution gives \(w=d\),
so \(A_w=ks\), proving the second line. Formula (7) with \(v=s^q\)
proves (2). For scalar multiples the additional factor is the
fifth root of the scalar, as in (5).

## The zero multiplicity cannot be minus the weight modulo five

Let \(P\in Z(k)\) be a zero of \(s\) of order \(e>0\), choose a
uniformizer \(t\) at \(P\), and write in the completed local ring

\[
                  s=t^e u(t)(dt)^d,\qquad u(0)\ne0.
\]

Suppose \(e+d\equiv0\pmod5\). Since \(rd\equiv1\pmod5\), this
is equivalent to \(er\equiv4\pmod5\). The coefficient of \(s^r\)
then starts with the nonzero term \(u(0)^r t^{er}\). Formula (6),
or its power-series version, shows that the Cartier image is
nonzero and has exact order

\[
                 \operatorname{ord}_P C_{Z,n}(s^r)
                       =\frac{er-4}{5}.                        \tag{9}
\]

Indeed Cartier selects precisely the powers of \(t\) congruent to
4 modulo 5, and the first nonzero term is already one of them.
If \(d\nmid4\), nonvanishing contradicts (1). If \(d\mid4\), (1)
makes the image \(cs\) for a nonzero scalar \(c\), of order \(e\).
But \(r\le4\) gives \((er-4)/5<e\), again a contradiction.
This proves (8), even without using clump uniqueness.

For the unique clump \(S\) and its endpoint image \(T=f(S)\), write
\(t=|T|\) and \(h_X=2g_X-2\). The divisor-degree identity is

\[
                              et=d h_X.
\]

If \(5\nmid h_X\), the already proved \(5\nmid d\) forces both
\(e\) and \(t\) to be prime to 5. Reducing the identity modulo 5 gives

\[
             e+d\ne0\iff d(h_X+t)\ne0\iff t\ne-h_X
                         \quad\text{in }\mathbf F_5.
\]

For an endpoint of genus 9, \(h_X=16\equiv1\pmod5\), so its clump
image size cannot be congruent to 4 modulo 5 (and is also not 0
modulo 5). For an endpoint of genus 25, \(h_Y=48\equiv3\pmod5\),
the corresponding image size is neither 2 nor 0 modulo 5.
These are conditional arithmetic restrictions on the unknown clump
sizes, not a contradiction to the genus-9/genus-25 pair.

## Literature and scope

In Krishnamoorthy's
[*Correspondences without a core*](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
Proposition 8.2 proves the invariant-section dimension bound;
Corollary 8.10 relates positive invariant line bundles to canonical
powers; Corollary 8.13 uses a primitive pluricanonical section in
characteristic zero; Question 9.7 asks for existence of invariant
pluricanonical forms in positive characteristic. The passages checked
do not state the characteristic-five primitive-degree restriction
or (1), nor the local zero-multiplicity consequence (8). This
limited check is not a claim of literature-wide novelty.

The operator (4) is the same twisted Cartier quotient used in the
[Frobenius residue-block note](../routes/global/PLURICANONICAL_FROBENIUS_RESIDUE_BLOCKS_AND_CARTIER_EXTENSIONS.md).
Its zero-image possibility belongs to the existing Cartier-kernel
and Tango framework. A Cartier-zero twisted pluriform alone does
not provide a maximal Tango structure: the additional line-bundle,
divisor, and regular-connection conditions must still be proved;
compare the [local maximal Tango equation](../routes/global/LOCAL_MAXIMAL_TANGO_CONNECTION_EQUATION_CHAR5.md).
No conclusion about endpoint \(p\)-ranks, existence of a clump, or
nonexistence of the given span follows here beyond the exact
degree restriction, Cartier dichotomy, and multiplicity congruence
proved above.
