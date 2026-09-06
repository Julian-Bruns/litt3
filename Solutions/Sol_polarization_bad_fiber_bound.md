# Proof record: Polarization bounds for finite bad-fiber schemes and determinant defects

Canonical statement: [`polarization_bad_fiber_bound`](../Theorems/Thm_polarization_bad_fiber_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Polarization volume bounds isolated bad fibers and their generic defects

Date: 2026-09-05. Author: `/root`.
Status: author proof, not independently audited. This is a general
intersection-theoretic test. It bounds isolated exceptions; it does
not eliminate a reduced exception of generic defect one.

## 1. Finite bad-fiber schemes for an ample divisor

Let k be algebraically closed. Let J be an abelian variety, A an
abelian subvariety, and pi:J -> Q=J/A the quotient. Choose an abelian
subvariety P complementary to A, and write psi=pi|P:P -> Q. Put

    r=dim P=dim Q,       e=deg psi,

with r>=1. Let L be an ample line bundle on J, with a nonzero section
s. Suppose addition a:A times P -> J splits its pullback as

    a^*L = L_A external-tensor L_P,                  (1)

where L_A,L_P are ample. This holds, with the Picard-zero twists
included, when L is a positive multiple of a principal polarization
and P is its orthogonal complementary subvariety.

Every fiber of pi carries a translate of L_A, so its higher cohomology
vanishes. Therefore E=pi_*L is a vector bundle, its formation commutes
with base change, and s corresponds to a section sigma of E. Define
the bad-fiber SCHEME B as the zero scheme of sigma. Its support is
exactly the set of q such that the full fiber pi^(-1)(q) is contained
in div(s). This definition retains possible nonreduced structure.

### Theorem 1.1

If B is finite, then

    e length(B) <= c_1(L_P)^r.                       (2)

Here degree of the isogeny and length are scheme-theoretic, including
inseparable degree. Separability of psi is unnecessary for (2).

### Proof

The cartesian square obtained by base changing pi along psi is
identified with A times P -> P by addition. Hence (1) and proper
base change give

    psi^*E = H^0(A,L_A) tensor L_P.

Thus psi^*sigma is a finite list of sections of the same line bundle
L_P, whose base scheme is exactly B_P=P times_Q B. It is finite.
Choose r general linear combinations of these sections. They have
zero-dimensional common zero scheme: successively avoid every
positive-dimensional component of the preceding intersections,
which is possible because the full linear system has finite base
locus. At each step only finitely many proper linear conditions on
the choice are excluded, and k is infinite.

The resulting r divisors intersect properly, with total intersection
length c_1(L_P)^r. Their common zero scheme contains B_P, so

    length(B_P)<=c_1(L_P)^r.

Every isogeny of abelian varieties is finite flat. Base change of
psi therefore makes B_P -> B finite flat of degree e, giving
length(B_P)=e length(B). This proves (2). QED.

## 2. Determinant defects force local scheme length

Now suppose J=J(C^(1)) for a smooth projective curve in characteristic
p>0, L is its Raynaud determinant line bundle, and s its determinant
section. Thus L has numerical class (p-1)Theta, and its family is
computed by B_C tensor N, of Euler characteristic zero.

For q in supp(B), let delta_q be the generic minimum of

    h^0(C^(1),B_C tensor N),         N in pi^(-1)(q).

It is a positive integer. No ordinarity or Galois hypothesis is
needed for the next local argument.

### Theorem 2.1

At q, the ideal of B is contained in m_q^(delta_q). Consequently

    length(O_(B,q)) >= binomial(r+delta_q-1,r),

and, if B is finite,

    sum_(q in supp(B)) binomial(r+delta_q-1,r)
                       <= floor(c_1(L_P)^r/e).        (3)

### Proof

At the generic point of the smooth integral fiber A_q=pi^(-1)(q),
the two-term cohomology complex for B_C tensor N is represented by
a square matrix whose corank modulo the fiber ideal is delta_q.
Splitting off an invertible block leaves a delta_q-square matrix
whose entries vanish modulo that ideal. Its determinant lies in
the delta_q-th power of the ideal. Multiplication by the removed
invertible determinant does not change this assertion.

This order-of-vanishing statement at the generic point holds along
the entire fiber for this section. To see this without a saturation
assumption, consider successive associated graded terms for the
fiber ideal. Smoothness of pi identifies these terms with

    L|A_q tensor Sym^j(T_q^*Q).

They are vector bundles on the integral A_q. For j<delta_q, the
corresponding coefficient section vanishes at its generic point,
and hence vanishes identically. Induction on j proves that s
vanishes along the whole delta_q-th infinitesimal fiber.

Since pi_*L is locally free and commutes with these infinitesimal
base changes, the coordinate functions of sigma all belong to
m_q^(delta_q). Thus the ideal I_(B,q) is contained in that power.
It follows that O_Q/I_(B,q) surjects onto O_Q/m_q^(delta_q).
Regularity of the r-dimensional local ring O_(Q,q) gives

    length(O_Q/m_q^(delta_q))=binomial(r+delta_q-1,r).

Summing and applying Theorem 1.1 proves (3). QED.

The estimate uses the order of the determinant in every normal
direction, not only its multiplicity on a selected transverse curve.
It gives a lower bound even if the bad-fiber scheme has further
embedded multiplicity. The support alone would lose this information.

## 3. Symmetries make the bound an all-exceptions test

Suppose a finite group Gamma preserves the quotient, the determinant
family, and its bad scheme. Then delta_q is constant on each orbit.
Writing k_j for orbit size and delta_j for its generic defect, (3)
becomes

    sum_j k_j binomial(r+delta_j-1,r)
                       <= floor(c_1(L_P)^r/e).        (4)

Thus a lower bound on orbit size controls every possible generic
defect at once. This is not a point-by-point search or a bound on the
degree of the original curve cover.

## 4. The ordinary cyclic-triple test case

Use the actual family and the proved finiteness in
[the ordinary cyclic-triple theorem](Sol_ordinary_cyclic_triple_finite_bad_cosets.md):
ordinary genus-two Y, connected cyclic etale triple U/Y, and U
ordinary. Its Jacobian has complementary ordinary P=E^2,

    r=2,    e=9,    L_P for the Raynaud divisor =4H,
    H^2=6.

Hence c_1(L_P)^2=96 and (3) gives the uniform bound

    sum_q delta_q(delta_q+1)/2 <=10.                 (5)

In particular there are at most ten geometric bad cosets. This
strengthens finiteness but does not make the set empty.

The group generated on Q by the C3 generator R and inversion is
cyclic of order six. Zero is not bad. There is no other orbit of
size one: simultaneous fixed points satisfy 2q=0 and (R-1)q=0;
the latter kernel has order nine, so the intersection is trivial.
Every orbit therefore has size at least two. Formula (5) yields

    delta_q<=2 for every bad q.                      (6)

Indeed delta_q>=3 costs at least six at each of at least two points.
If delta_q=2, its orbit cannot have size six; that would cost eighteen.
Its orbit has size two or three. Accordingly either

    (R-1)q=0,   or   2q=0.

The first group is killed by three, because R^2+R+1=0 and Rq=q.
Thus defect-two exceptions lie in two explicit finite subgroup
schemes' geometric points. Away from those subgroups every possible
exception has generic defect ONE and lies in an orbit of size six.
There is at most one such orbit, by (5).

This is a test for the general bound, not a classification of the
remaining points or a proof of their existence. The order of a
defect-one exception is not bounded by (5).

## 5. What this method does and does not remove

The estimate excludes higher generic section defects in one step,
and the theorem is parameterized by quotient dimension, polarization
volume, and symmetry orbit sizes. It can be used after changing the
curves or the cover degree whenever finite bad-fiber support is known.

It cannot by itself rule out a reduced isolated zero with delta=1:
that contributes only one unit to (3). Such zeros are permitted for
general sections of vector bundles. An additional property of the
actual Cartier determinant, or of the actual two etale maps, is
needed to force more multiplicity or propagation. No such extra
property is assumed or proved in this file.
