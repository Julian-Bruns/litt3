# Proof: equivariant ramified roots improve the contact budget

[Statement](../Theorems/Thm_ramified_root_contact_core.md).
Author /root,2026-09-08, prompted by the root-contact calculation in
the returned J7 Pro response. That response did not observe the degree
bound. Fresh medium audit /root/audit_equivariant_root_contact checked
the spin case and identified the component-orbit distinction below.

## 1. Canonical root components and their actual common pullback

The normalized d-th-root cover of a tensor s is defined on rational
frames by alpha^d=s, with alpha a rational one-form. Since p does not
divide d, it is a tame cyclic cover, possibly disconnected. Every
connected component A->X has the same degree h_X dividing d. At a
point of D_X its ramification index is d0, since the root coefficient
has valuation e. Elsewhere it is etale. In particular d0 divides h_X.
The tautological form has order N-1 at every point above D_X and
no other zeros or poles. Riemann--Hurwitz gives

    g(A)-1=h_X*(N-1)*(g(X)-1)/e0,
    deg R_A=2h_X*(g(X)-1)/e0,                         (1)

where R_A is the reduced inverse image of D_X. Construct B similarly.

For a jointly minimal preserving span, equality of the actual tensors
identifies the two pulled-back ROOT COVERS, not merely their branch
indices. Any component W of this common cover has finite etale maps
to its image components A,B by base change; normalization commutes
with etale base change. If its degree over Z is h_Z, then h_Z divides
both h_X,h_Y. Its joint field is k(W): the upper endpoint fields
contain the original compositum k(Z), and either root then generates
k(W). Thus its joint image is birational to W.

Put h=gcd(h_X,h_Y), L=lcm(h_X,h_Y). The diagonal mu_d action has
d/L orbits on the pairs of connected endpoint components. All common
root components of any one connected Z map to precisely ONE such
orbit, since mu_d acts transitively on those components. Partition
the downstairs images according to this orbit. Within one class fix
a pair (A,B). Exactly h/h_Z components of its common root cover map
to this pair, with total degree h over Z. This is the orbit-stabilizer
calculation for stabilizers mu_h and mu_h_Z.

The chosen upper images are distinct, also between components over
the SAME Z: their generic joint endpoints recover both the base point
of Z and its root. Images over different downstairs images are
distinct after projection to X times Y. This rules out multiplicity
in the reduced upper union used next.

## 2. Global and local budgets in one compatibility class

Take a finite reduced union in one component-pair orbit. Write a,b for
its total downstairs degrees, and
t=a(g(X)-1)=b(g(Y)-1). The selected reduced upper union C in A times B
has total degrees

    a'=a*h/h_X, b'=b*h/h_Y,
    t'=sum(g(W_i)-1)=h*(N-1)*t/e0.                   (2)

All its normalization maps are etale. By Hodge index, C^2<=2a'b'.
Adjunction for a reduced union with smooth branches therefore gives

    delta(C)<=a'b'+t'.                              (3)

Here delta is the sum of pairwise local intersection multiplicities,
including pairs belonging to different components. This is precisely
the reduced-union budget in
[contact_degree_bound](Sol_contact_degree_bound.md#1-global-intersection-budget).

At a point of D_X times D_Y, choose base parameters x,y and compatible
root parameters A0,B0 with x=A0^d0,y=B0^d0. A downstairs preserving
branch y=psi(x) lifts to

    B0=A0 U(A0^d0), U(x)^d0=psi(x)/x.                (4)

Indeed the upper map is equivariant for the local cyclic inertia,
which has the SAME parameter character on both roots because their
tautological one-forms agree and gcd(e0,d0)=1. Equivalently, take
the d0-th root of the unit psi(x)/x. The choice of its constant is
the chosen upper branch. Both tautological forms have order N-1,
so its slope eta=U(0) satisfies eta^N=kappa for one fixed nonzero
kappa at the chosen root-grid point. There are at most N slope classes.

If two upper branches have the same slope, their downstairs branches
do too. Write I>=2 for the downstairs contact. Comparing the first
changed coefficient under x->x+a*x^I+... in a tensor
x^e*unit*(dx)^d gives e+dI=0 in k. Thus I>=q. The branches cannot have
identical downstairs formal germs: that would identify their integral
joint image, and equality of the canonical root form selects a unique
lift over a prescribed pair of root points. More explicitly, the
two possible upper slopes would have both equal d0-th powers and
equal N-th powers; gcd(d0,N)=1 makes them equal, after which the
d0-th root of a unit is unique.

For distinct same-slope branches, (4) therefore gives EXACT contact

    1+d0*(I-1)>=1+mu.                               (5)

Different slopes have contact1. If r branches meet at this grid point,
distributed among at most N classes r_j, its delta contribution is

    binom(r,2)+mu*sum binom(r_j,2)
      >=(1+mu/N)*r^2/2-(1+mu)*r/2.                  (6)

The total number of normalized branches over the root grid is
S=2h*t/e0. By (1) its grid size is
4h_X*h_Y*(g(X)-1)*(g(Y)-1)/e0^2. Consequently S^2/grid=a'b'.
Sum (6), apply Cauchy--Schwarz over the grid, and compare with (3):

    (mu-N)/(2N)*a'b' <= h*(N+mu)*t/e0.               (7)

Since mu>N, substituting (2) proves

    ab <= 2L*N*(N+mu)*t/(e0*(mu-N)).                (8)

This bounds a and b separately after dividing by t. There are d/L
component-pair orbits. Apply the bounds to each class and add, giving
the statement with coefficient d in place of L. Using L for the
UNRESTRICTED union would be unjustified when different images select
different component-pair orbits.

For d=7,e=2 one has d0=7,e0=2,N=9,q=4,mu=21. The root covers are
connected and no partition is needed. Formula (6) is
(5/3)r^2-11r, while t'=28t and S=7t. Hence

    (5/3)ab-77t <= delta(C) <= ab+28t,
    ab <= (315/2)t.                                 (9)

No exactness or Cartier hypothesis occurs in this calculation.

## 3. A finite relation supplies an actual core

Apply the proved bound to each of the four ordered pairs from
X disjoint_union Y, with its fixed tensors. Every distinct jointly
minimal image has a positive integral projection degree. Thus there
are finitely many tensor-preserving images. This includes all images
generated by the original span, its transpose and the diagonals.
Normalized fiber-product composition preserves BOTH actual etale legs
and tensor equality; joint minimalization does too by injectivity of
separable differential pullback.

The audited [finite_correspondence_groupoid](Sol_finite_correspondence_groupoid.md)
therefore gives a connected effective proper smooth DM curve S with
actual finite etale atlases X,Y->S. In the original specified source
field the coarse field k(S) lies in both endpoint fields. It has
transcendence degree one, so their intersection is nonconstant.
The Galois envelope, if wanted, is formed only AFTER this quotient;
none was presumed in obtaining it.

## Scope and sharp local boundary

The new input is equivariance under the RAMIFIED tensor-root action.
Using only the uniform zero order N-1 of the root form would allow
many more local branches and lose (5). The earlier exact-form
counterexamples supply no such ramified quotient with the required
smaller endpoint tensor, and hence do not contradict the theorem.
Tensor powers leave the positivity inequality invariant, though they
can weaken the numerical constant. No improvement of the old sharp
DOWNSTAIRS contact order is asserted; it is amplified upstairs.

Neither this theorem nor the J7 Pro calculation establishes existence
of a shared positive tensor. Profiles with mu<=N and the no-clump
case remain separate. The unmarked common-cover problem is unsolved.
