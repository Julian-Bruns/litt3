# Proof: the marked group, actual modifications and orbit energy

Version2,3October2026. Use the actual witness and its notation in
[admissible-line reconstruction](admissible_line_reconstruction.md):
h:S->X is connected finite etale of degree N,
H=h^*O, R=h^*R_X, R_X=O+Z_A, and
\[
q=f+b^5,\qquad \operatorname{div}q=3E-5G-10H,
\quad \deg E=5N,\quad \deg G=N,\quad E\cap G=\varnothing.
\]
E is reduced. The associated saturated embedded line
\(\mathcal A\subset h^{(1)*}\mathcal P_X\) has degree zero and exact
order five. Its determinant contact with the pulled-back canonical
line \(\lambda_X\) is \((R-E)^{(1)}+G^{(1)}\).
All divisor intersections below are coefficientwise minima.

## The later exact marked group supplies the arithmetic input

Every degree-zero divisor supported on R_X is an integral combination
of [P-O], P in Z_A. These generate exactly the group Gamma of
[the marked-divisor theorem](marked_divisor_relation_lattice.md),
whose exponent m is prime to five. Thus m annihilates every such
divisor class. The assertion on X^(1) follows by the base-field
automorphism defining that twist, which preserves geometric orders.

This replaces the separate Cartier-matrix and cubic-residue proof.
It concerns this downstairs support group. An individual selection
among points of h^*R_X need not have prime-to-five order.

Nontrivial order-five classes survive finite separable pullback:
if div(a)=5D, the regular form dlog(a) is zero exactly when
D is principal, since ker(d:k(V)->Omega)=k(V)^5. Pullback of a
nonzero rational differential through a separable field extension
is injective. We may therefore take the etale Galois closure of the
single map h without losing the actual order-five line or changing
its projected support.

## Actual stabilizers and the orbit size

Let Gamma_h be the deck group of this Galois witness and m_h the
orbit size of the embedded line. Its stabilizer equals those of E
and the normalized primitive q, and also stabilizes G. Indeed, the
line's adjunction recovers R-E, while fixed-selection uniqueness
recovers the line from E. Generically
\[
[q^2]=[f^2]+2b^5[f]\quad\text{in }k(S)/k(S)^5.
\]
The elements 1,f,f^2 are independent over k(S)^5 because df is
nonzero. Equality of these normalized lines forces equality of
b^5 and therefore q; its divisor then recovers G.

The line descends under its actual stabilizer to a saturated
degree-zero line on the connected etale stabilizer quotient, of
degree m_h over X, with the same reduced adjunction pattern.
The [degree-at-most-three trace obstruction](admissible_line_trace_obstruction.md)
applies even to twisted degree-zero lines; hence m_h>=4. This
descent need not preserve exact order five, so that stronger
assertion is unnecessary. If the original Galois group has
prime-to-five order, then 5 does not divide m_h.

## One valuation inequality gives all collision bounds

For two distinct conjugate primitives put a=b_i-b_j, so that
a^5=q_i-q_j. At a point use multiplicities e_i,e_j in{0,1},
g_i,g_j>=0 and h in{0,1}. Since e_i g_i=e_j g_j=0,
\[
v(a)\ge
\left\lceil\frac{\min(3e_i-5g_i-10h,\,
                            3e_j-5g_j-10h)}5\right\rceil
\ge\min(e_i,e_j)-2h-\max(g_i,g_j).
\]
When both e's are one this is 1-2h; otherwise it is at least
-2h-max(g_i,g_j). Therefore, with max also coefficientwise,
\[
\operatorname{div}a\ge(E_i\wedge E_j)-2H-(G_i\vee G_j),
\qquad
\deg(E_i\wedge E_j)+\deg(G_i\wedge G_j)\le4N.
\]
This proves the inequality for all multiplicities without a bounded
valuation table. Equality in degree also makes the displayed
divisor inequality an equality.

Regular deck action on each geometric fiber gives the exact identities
\[
\sum_{\sigma\in\Gamma_h}\deg(E\wedge\sigma E)=\sum_P e_P^2,
\qquad
\sum_{\sigma\in\Gamma_h}\deg(G\wedge\sigma G)
=\sum_{P,a\ge1}g_{P,a}^2.
\]
The second uses min(u,v)=sum_(a>=1)1_(u>=a)1_(v>=a), so retains
every multiplicity layer. Each of the N/m_h stabilizer elements
contributes deg E+deg G=6N; each other element contributes at most4N.
Consequently
\[
\sum_P e_P^2+\sum_{P,a}g_{P,a}^2
\le(4+2/m_h)N^2,\qquad
\sum_P e_P^2\le(4+1/m_h)N^2.
\]
For the second inequality subtract the stabilizer contribution
N^2/m_h from the G energy. Cauchy--Schwarz, using sum e_P=5N
and sum g_(P,a)=N, now gives
\[
25/r+1/d\le4+2/m_h,
\quad r=\#h(\operatorname{Supp}E),\quad
d=\sum_P\max_{Q/P}\operatorname{mult}_QG.
\]
These are necessary incidence bounds, not a reconstruction criterion.

## The actual determinant has no torsion ambiguity

Use f=Q(x)/y^5, Q'=PA^2. In B_X, Frobenius-target scalars are
fifth powers. The determinant of the rational generators [f],[f^2]
of the saturated plane has divisor Z_A^(1)-5O^(1):

- At an ordinary finite point with df a unit, subtracting the
  constant gives q of order one; [q],[q^2] form a local basis.
- At Z_A, q has order three. The basis [q],[q^2/t^5] shows one
  determinant zero on the Frobenius target.
- At a cubic branch point use y as parameter and c^5=Q(r).
  Then f=(c/y)^5+q with q of order one, since Q(x)-Q(r) has
  order two in x-r. The triangular change
  [f^2]=[q^2]+2(c/y)^5[q] has determinant one.
- At O, v(f)=-7 and v(f^2)=-14. The local basis
  [t^10f],[t^15f^2] has residues t^3,t, so the rational
  determinant has pole t^-25, of order five downstairs.

Since Z_A^(1) is linearly equivalent to12O^(1),
\[
\det\mathcal P_X=\mathcal O(7O^{(1)}).
\]
Only genuine Frobenius scalars entered the changes of basis.

## Seven missed points force an impossible scalar splitting

The mechanism is a general rank-two fact. Three distinct saturated
degree-zero lines in a degree-zero rank-two bundle force it to be
L direct-sum L: two lines have a nowhere-vanishing determinant and
split the bundle; the third projects isomorphically to both summands.

Suppose r<=6 and choose seven missed points with reduced sum D0
on R_X. Form the actual downstairs modification
\[
Q_0=\lambda_X+\mathcal P_X(-D_0^{(1)}),\qquad
\deg Q_0=0,\qquad
\det Q_0=\mathcal O(7O^{(1)}-D_0^{(1)}).
\]
At a marked point its lattice is <e1,s e2>, where e1 generates
lambda_X. Every actual conjugate line has contact containing
h^(1)*D0^(1), so its e2 coefficient is divisible by s and it lies
in h^(1)*Q0. It remains saturated there: its quotient embeds in
the locally free quotient of h^(1)*P_X by that line.

There are m_h>=4 distinct conjugates. The rank-two fact gives
\[
h^{(1)*}Q_0=\mathcal A\oplus\mathcal A,\qquad
h^{(1)*}\det Q_0=\mathcal A^{\otimes2}.
\]
The left determinant has order dividing the marked-group exponent m,
which is prime to five; the right has exact order five. This is
impossible, proving r>=7 for arbitrary etale monodromy.

The degree-zero hypothesis is essential: six missed points give a
degree-one modification. The argument does not exclude r>=7 or
replace an upstairs selection by a downstairs torsion class.

## Evidence and remaining scope

The exact marked lattice is the established arithmetic input; its
independent index and actual Jacobian certificates remain unchanged.
All new deductions above are symbolic. The superseded Cartier
producer and its aggregate checker are deleted completely; original
sources, proof, certificate and hashes remain in
[external provenance](../../../litt3-computation-data/admissible_support_before_hindsight/provenance.json).
No numerical certificate was replayed.

The failed incidence-only and direct-splitting shortcuts are grouped
in [the failed-route index](../../Research/FAILED_ROUTES.md).
Larger projected supports still require the actual scalar identity,
nontrivial line and connection. Neither an admissible witness nor
a solution of the unmarked common-cover problem is produced.
