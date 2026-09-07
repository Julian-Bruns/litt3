# Canonical gluing orders: exact two-branch and uniform multibranch bounds

Version2,2026-09-08: consolidated by /root/library_generalization_cleanup_max,
with both original audited scopes preserved and no stronger audit claim.
[Global degree and exact two-branch results: PASS,2026-09-04](audits/101_CANONICAL_GLUING_ORDER_AND_LARGE_DEGREE_BOUND_AUDIT.md);
[valuation interpolation and multibranch bounds: PASS,2026-09-05](audits/102_MULTIBRANCH_INTERPOLATION_AND_CANONICAL_GLUING_EXPONENT_AUDIT.md).
Both auditors: abelian_p_index_group_audit. No breaking objections;
the first audit suggested only see-saw and completion-test exposition.
The sharper exact two-branch order is NOT replaced by the general bound.
Section5 preserves author-level comparison/bookkeeping from a superseded
strategy note; the above audit claims concern Sections1–4 only.

## 1. The same two etale legs and their singular-image invariant

Work over k=Fbar_p. Let X,Y be smooth projective connected curves,
s_X=g(X)−1>0,s_Y=g(Y)−1>0, with Hom(J(X),J(Y))=0.
Let Z normalize its integral joint image C⊂X×Y, with BOTH original
projections f:Z→X,g:Z→Y finite etale, degrees d_X,d_Y. An arbitrary
common cover can be replaced by this joint normalization without
losing either leg: each is an intermediate of an etale map.
Riemann–Hurwitz gives s_Xd_X=s_Yd_Y.

The split-class identity is

    O(C)=A⊠B,             deg A=d_Y,             deg B=d_X.         (1)

Indeed the fiber restrictions to Y give a map X→Pic^(d_X)(Y).
After translation this factors through Hom(J(X),J(Y))=0, so
see-saw gives(1). Define M=ω_X⊠ω_Y⁻¹. The differential maps give
a SPECIFIED unit τ=(df)⁻¹dg of ν*(M|C), viewed as
Hom(g*ω_Y,f*ω_X), and deg(M|C)=0.

The canonical gluing order t(C) is the order of M|C in Pic(C).
It is finite: the degree-zero generalized-Jacobian point and its
curve descend to a finite field, where that finite-type group's
rational-point group is finite. Equivalently t(C) is the least n>0
such that τ^n descends to a UNIT on singular C. Any trivialization
on C pulls back to a constant multiple of τ^n, since Z has only
constant global units. Triviality on the normalization is automatic;
triviality on C is an extra gluing condition.

**Audited degree bound.** If M^n|C is trivial, then

    d_Y≤2ns_X,       d_X≤2ns_Y,
    t(C)≥ceil(d_Y/(2s_X))=ceil(d_X/(2s_Y)),
    g(Z)−1≤2t(C)s_Xs_Y.                                      (2)

Retain the direct proof independently of later coefficient refinements.
The sequence0→M^n(−C)→M^n→M^n|C→0 has H⁰(M^n)=0, so its
connecting class is nonzero. By(1), the only nonzero possible
Kunneth summand of H¹(M^n(−C)) is

    H⁰(X,ω_X^n A⁻¹)⊗H¹(Y,ω_Y^−n B⁻¹).

Thus ω_X^n A⁻¹ has a section; interchange factors and use M^−n
for the other inequality. This proves the stronger necessary
EFFECTIVITY of both displayed connecting line bundles as well
as(2). The [coefficient/equality theorem](105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP.md)
gives additional author-level structure, with evidence separated there.

## 2. Exact local and global orders for two branches

Every formal branch is a graph y=u_i(x), with u_i' a unit, because
both original projections are etale. Hence a unibranch point is
smooth. For exactly two branches y=u(x),y=v(x), put
m=ord_x(u−v). Their completed local ring inside its normalization is

    {(a,b)∈k[[x]]² : a−b∈(u−v)}.                              (3)

Monic division by(y−u)(y−v) writes a local function as A(x)+B(x)y,
which proves both directions of(3). In the frame dx⊗dy⁻¹ the
coefficients of τ are u',v'. Therefore τ^n descends precisely when
u'^n−v'^n∈(u−v), and its EXACT local order is:

| Contact | Local order |
| --- | --- |
| m=1 (ordinary node) | ord(u'(0)/v'(0)), prime to p |
| m≥2 and p divides m | 1 |
| m≥2 and p does not divide m | p |

For m=1, the congruence is equality of constant terms. For m≥2,
the derivative constants agree. If p|m, differentiation kills the
leading term of u−v and ord(u'−v')≥m, so n=1 works.
Otherwise ord(u'−v')=m−1; writing n=p^a b with p∤b gives

    ord(u'^n−v'^n)=p^a(m−1).

This reaches m exactly when a≥1. Thus arbitrarily large contact
order alone does not increase the local gluing order.

If EVERY singular point has two branches, let e be the lcm of
ordinary-node tangent-ratio orders (e=1 if none), and ε=1 if
some tangency has contact order not divisible by p, otherwise0.
Then

    t(C)=e p^ε,       d_Y≤2s_X e p^ε,       d_X≤2s_Y e p^ε.        (4)

Descent is local and can be checked after faithfully flat completion;
a descended section with unit branch values is itself a unit.
Consequently the global order is exactly the lcm of the local orders.

With no ordinary nodes, d_Y≤2ps_X, or≤2s_X if all contacts
are divisible by p. If the node tangent ratios lie in F_q×,
then e|(q−1); rationality of both endpoints over F_q alone does
NOT put their singular points, branches or slopes over F_q.
For the genus-(9,25) pair in char5, N=d_Y and d_X=3N give
N≤16e5^ε, hence N≤80 without nodes and N≤16 when additionally
all tangencies have contact order divisible by5.

## 3. Integral interpolation over an arbitrary DVR

Let R be a DVR with uniformizer π and normalized valuation v.
For distinct u₁,…,u_r∈R and b₁,…,b_r∈R, assume an integer L≥r−1
satisfies

    v(b_i−b_j)≥L v(u_i−u_j)                  for every i≠j.        (5)

Then the unique degree-<r interpolating polynomial belongs to R[y].
For r=1 this is immediate. Inductively set

    d=min_(i≠j)v(u_i−u_j),
    v_i=(u_i−u₁)/π^d,       c_i=(b_i−b₁)/π^(Ld).

These are integral and v(c_i−c_j)≥L v(v_i−v_j). Partition v_i
by residue class. There are at least two classes, each smaller
than r; induction supplies integral interpolants within each.
The monic polynomials F_α=∏_(i∈α)(y−v_i) have pairwise unit
resultants. Chinese remaindering and monic division therefore give
Q∈R[y],deg Q<r, with Q(v_i)=c_i. Finally

    b₁+π^(Ld) Q((y−u₁)/π^d)

interpolates the original data. Every denominator introduced has
exponent at most(r−1)d≤Ld, proving integrality and the claim.

## 4. Multibranch differential powers and their exact tame part

Locally let r≥2 branches be y=u_i(x), u_i∈xk[[x]], u_i' units.
Their ring is k[[x]][y]/∏(y−u_i), inside ∏_i k[[x]].
A tuple belongs to this ring exactly when its degree-<r interpolation
polynomial is integral, by monic division.

Let e, prime to p, kill all ratios of the constants u_i'(0).
For a p-power q≥2(r−1), the tuple ((u_i')^(eq)) descends to a
UNIT. If every pair with contact m_ij=ord(u_i−u_j)≥2 has p|m_ij,
it suffices that q≥r−1. Indeed:

- for m_ij=1, taking e-th powers makes the constants equal, and
  the q-th power gives difference valuation≥q;
- for m_ij≥2, differentiation gives valuation≥m_ij−1. Raising
  to e cannot lower it, and raising to q gives at least
  q(m_ij−1)≥(r−1)m_ij;
- if p|m_ij, the derivative valuation is already≥m_ij, giving
  the sharper bound with q≥r−1.

Thus(5) holds with L=r−1. The interpolant descends, and its
branch values have the same nonzero residue, so it is a unit.

Globally let R_max be the largest number of branches at a point
of C, and let e be the lcm of ALL pairwise slope-ratio orders
at its singular points. The ratios are intrinsic: a coordinate
change multiplies all slopes at that point by the same scalar.
One has R_max≥2: if C were smooth, adjunction using(1) would give
g(Z)−1=d_Xd_Y+2s_Xd_X, contradicting etale Riemann–Hurwitz.

Let q_R be the least p-power≥2(R_max−1). Then

    t(C) divides e q_R,      prime-to-p part of t(C) is EXACTLY e,
    d_Y≤2s_X e q_R,          d_X≤2s_Y e q_R,
    g(Z)−1≤2s_Xs_Y e q_R.                                   (6)

The local result gives descent of τ^(e q_R) everywhere. Conversely
descent requires equality of all branch residues, so e divides
every descending exponent. Together these prove the divisibility
and the exact tame part. Apply(2) for the degree bounds.
If all higher contact orders are divisible by p, replace q_R
by the least p-power≥R_max−1; the sharper EXACT two-branch
formula(4) remains available.

Since q_R<2p(R_max−1), one has d_Y<4ps_X e(R_max−1).
For genus-(9,25) in char5,

    N≤16e·5^ceil(log_5(2(R_max−1))) <160e(R_max−1).

Thus unbounded primitive common-cover degrees require unbounded
branch multiplicity or unbounded combined tangent-ratio order.
Huge contacts by themselves do not evade the bound: the local
model(y−x)(y−x−x^(p^m)) has arbitrarily large conductor defect but
gluing order1. The remaining parameters are NOT uniformly bounded
on our fixed product. No Galois hypothesis, simultaneous closure,
or exclusion of all common covers has been obtained.

## 5. What an actual cyclic diagram contributes to these bounds

Suppose an ACTUAL diagram V --p--> B --c--> X, V --a--> Y has
p cyclic etale of degree r and c,a etale of degree M. Let Z
normalize the image of(cp,a), and κ=deg(V/Z). Then V/Z is etale,

    d_X=rM/κ,        d_Y=M/κ,        κ divides M.

Every normalization point over(x,y) has κ preimages on V. Hence
the number of branches of the X×Y image at(x,y) is exactly

    κ⁻¹ #{v∈V : cp(v)=x, a(v)=y}.

For ANY point P∈Y set D_P=p_*a*P on B. The same count gives

    mult_x(c_*D_P)=κ·r_C(x,P).                                  (7)

Thus a collision bound on B before pushforward is not the required
branch bound on X after pushforward. Bounds only at marked points
do not control unmarked singularities either. Likewise the small
branch count for a B×Y image cannot simply be substituted into(6):
its intermediate Jacobian may have a nonzero norm from J(Y),
whereas the global degree proof needs Hom between its two endpoints
to vanish. Coefficient-field indices, sign-choice counts and tangent-
ratio orders are different data; none is identified with R_max here.

The [actual diamond/coefficient sieve](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md)
and [signed-orbit proof](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
retain their own hypotheses, not an automatic bound for(7).
The [incidence square](MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md)
also preserves its missing-second-leg boundary.

Finally the gluing class lies in ker(Pic(C)→Pic(Z)) and is already
trivial on smooth Z. Torsion information only on Z does not control
its order in this kernel. Local residue p-th-power conditions are
vacuous over Fbar_p; a GLOBAL p-th-power or higher-order differential
identity still needs a proof. These comparisons preserve the useful
limits of the older route without reinstating its superseded plan.
