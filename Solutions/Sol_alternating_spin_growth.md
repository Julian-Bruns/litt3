# Proof: finite-dimensional descent and the fixed divisor

[Statement](../Theorems/Thm_alternating_spin_growth.md).
Pro strict-growth argument supplied2026-09-08; root generalization and
base-point-free consequence the same day. No independent audit claimed.

## 1. The actual tower and a finite-dimensional lemma

Write M for the union of the embedded k(Z_n). It is Galois over both
k(X) and k(Y): every element and every conjugate enter a later closure
over that endpoint. Put G_X=Gal(M/k(X)), G_Y=Gal(M/k(Y)), and let Gamma
be the group they generate. Then M^Gamma=k(X) intersect k(Y)=k.
Finite etale closures and their compositions remain etale over both
endpoints. These are the recursive closures of
[Krishnamoorthy, Section4](https://arxiv.org/html/1704.00335v2), not an
assumed finite simultaneous closure; see also
[Stacks, Galois covers](https://stacks.math.columbia.edu/tag/03SF).

If a finite-dimensional k-space V in M is stable under G_X and G_Y,
then V is contained in k. Indeed, the pointwise stabilizer of a finite
basis is open in each profinite Galois group, so each group has finite
image in GL(V). The entries of those TWO finite matrix groups belong to
one finite subfield of bar(F_p). Their generated matrix group is finite.
The orbit polynomial of any v in V therefore has coefficients in
M^Gamma=k; algebraic closedness gives v in k. This argument genuinely
uses k=bar(F_p), not an arbitrary algebraically closed field of char p.

## 2. Passing from sections to functions, without adding a root cover

Use the specified pullback identifications to view
E_n=H0(Z_n,L_n) as nested spaces. If r_(n+1)=r_n, then E_(n+1)=E_n.
In the general setting of the statement, consider the finite-dimensional
space of rational functions

    V_n=span_k{e_1 ... e_m / h_n : e_i in E_n} in k(Z_n).

At a stage normal over X this space is G_X-stable, since both the line
bundle and h_n are pulled back from X. At a stage normal over Y it is
G_Y-stable. Equality of E_n and E_(n+1) gives equality of their V-spaces,
so the common V-space is stable under BOTH groups for n>=1. The lemma
therefore puts it in k. If E_n contains a nonzero e, e^m/h_n cannot be
constant: m div(e)=div(h_n) would contradict the specified coefficient
not divisible by m, which stays unchanged under etale pullback.
Thus equality is impossible whenever r_n>0.

For the spin setting, spin_primitive_matching_defect gives r_0>=1:
if it were zero the two unique global spin primitives would match and
their ratio b^(p+2)/h^p would provide a core. Injectivity of pullback
now proves assertion1. No primitive-existence assumption is added here.

## 3. The genus-two endpoint removes all base points at stage2

Let q:T->Y be any connected finite etale Galois cover and L a line
bundle of degree1 on Y. If h0(T,q^*L)>=2, then q^*L is globally
generated. Its complete section space is Galois-stable, so its fixed
divisor B is invariant. Since q is etale and k is algebraically closed,
B=q^*B_0 for an effective integral divisor B_0 on Y.

If B_0 were nonzero, deg B>=deg q=deg(q^*L). Removing B leaves a line
bundle of degree at most0, with at most one independent section. That
contradicts h0>=2. Hence B=0, proving the assertion for q.

Apply this to Z_2->Y. Assertion1 gives r_2>r_1>=1, and a spin line on
genus2 has degree1. Thus L_2 is globally generated. A pulled-back
globally generated line stays globally generated, completing assertion2.

## Boundary

Neither finite-dimensional descent nor the base-point-free argument
bounds the dimensions as n varies. The spaces at successive stages are
different; their union is not finite-dimensional. In particular it is
invalid to apply the finite-field matrix argument to that entire union.
The ordinary towers in ordinary_dihedral_spin_growth have unbounded,
linearly growing spin dimensions and eventually globally generated spin.
They have only one prescribed endpoint, not the two-sided closure data.
