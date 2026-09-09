# Equivariant ramified-root contact audit

Verdict: **PASS**, with the canonical choice of root lift made explicit below.
Auditor: `/root/audit_equivariant_root_contact`.
Date: 2026-09-08.
Scope: `Research/ROOT_CONTACT_CORE_DRAFT.md`, read in full, against the
statements and proofs of `spin_cartier_root_normal_form`,
`contact_degree_bound`, and `finite_correspondence_groupoid`.
This is a bounded independent prose audit, not Lean verification.

No fatal objection was found. In particular, the contact is at least22,
the reduced-union bound is valid, and finiteness supplies a core for each
original actual finite etale span. Neither ordinarity, Cartier vanishing,
nor a Jacobian hypothesis is used. This excludes precisely the stated
marked profile from a coreless span; it does not solve the original
unmarked common-cover problem.

## Clarification required in the published proof

The upper correspondence must be the **canonical one preserving the root
one-forms exactly**, not an arbitrary component of the inverse image of
the downstairs correspondence in the product of the two root curves.
There are seven possible relative root identifications, and exactly one
preserves these forms. The deck action on the displayed root form is
`alpha -> zeta^2 alpha`; since2 is invertible modulo7, the preserving
identification is unique. This is available functorially from equality of
the actual pulled-back tensors, as proved in the existing root theorem.
It ensures the same slope equation for every branch of every component.
The draft already specifies equality of the pulled-back root forms, so
this is an exposition clarification, not a missing mathematical hypothesis.

## Checked local calculation

At an endpoint zero choose a spin frame l, take x to be the coefficient
of its reduced section h, and write l^2=v_X(x)dx with v_X(0) nonzero.
At the other endpoint use y and v_Y. The canonical roots have parameters
A,B with x=A^7,y=B^7, and their forms are

    alpha_X=7 A^8 v_X(A^7)dA,
    alpha_Y=7 B^8 v_Y(B^7)dB.

Every upper branch is a graph over A because the upper endpoint map is
etale. If its downstairs graph is y=psi(x), then

    B=A U(A^7),  U(x)^7=psi(x)/x.

Existence of U follows from Hensel extraction of the unit, with7
invertible. Exact equality of the root forms gives the leading equation

    eta^9=v_X(0)/v_Y(0),  eta=U(0).

There are at most9 slope classes (indeed nine possible nonzero roots,
since5 does not divide9). Also eta^7=psi'(0). The map from upper slopes
to downstairs slopes is injective on these nine possibilities because
gcd(7,9)=1. Consequently two branches with equal upper slope have equal
downstairs slope, and conversely.

For distinct downstairs branches of equal slope, write their contact
order as I>=2. Composing one graph with the inverse of the other gives
a formal automorphism z -> z+c z^I+..., c nonzero, preserving a tensor
z^2 V(z)(dz)^7. At relative degree I-1, its change is
(2+7I)c; the change of the unit V begins in degree I. Thus
2+7I=0 in characteristic5, so I=4 modulo5 and I>=4.

For the corresponding upper branches with the same slope eta,

    B_1^7-B_2^7=psi_1(A^7)-psi_2(A^7).

The right side has order7I. The quotient of the left side by B_1-B_2
has order6 with leading coefficient7 eta^6 nonzero. Hence their contact
is exactly7I-6, and is at least22. This argument does not assume that
a coefficient divisible by5 differentiates nontrivially. Distinct
branches cannot have identical formal graphs: the normalizations map
birationally to distinct reduced joint images and formal graph branches
of such an image are distinct.

For r branches at a root-grid point, with at most9 slope classes r_j,
the resulting delta contribution is at least

    binom(r,2)+21 sum_j binom(r_j,2)
      >= (5/3)r^2-11r.

All branches are smooth, including branches of the same irreducible
image, so the local delta is exactly the sum of their pairwise contacts.

## Checked global budget

Put m_X=g(X)-1,m_Y=g(Y)-1. For any finite reduced union of preserving
joint images with normalizations Z_i, write

    a=sum deg(Z_i/X), b=sum deg(Z_i/Y), t=a m_X=b m_Y.

Joint minimalization retains etaleness: its two maps are intermediate
covers of the actual etale covers. Tensor equality descends by injectivity
of separable differential pullback. This applies to every component of
every composition later used in the groupoid.

The canonical root W_i is connected of degree7 over Z_i because its
reduced zero divisor is nonempty. Both W_i->A and W_i->B are Cartesian
base changes and etale, of degrees a_i,b_i. Their endpoint fields
generate k(W_i): they already generate k(Z_i), and the root from either
endpoint generates its canonical root extension. Thus W_i is the
normalization of its upper joint image, with no hidden covering degree.
Distinct downstairs images give distinct upper images by projection.

Riemann--Hurwitz gives g(A)-1=28m_X, g(B)-1=28m_Y and
sum_i(g(W_i)-1)=28t. For the reduced upper union C, Hodge index yields
C^2<=2ab. Adjunction, including the number of components in the
normalization formula, gives

    delta(C)=C^2/2+28t <= ab+28t.

There are exactly S=7t points on the disjoint normalization above the
root-zero grid, counting branches. The grid has49m_Xm_Y points, hence
S^2/(49m_Xm_Y)=ab. Summing the checked local bound gives

    delta(C)>=(5/3)ab-77t.

Comparison gives (2/3)ab<=105t, or

    a <= (315/2)m_Y, b <= (315/2)m_X.

This controls the total degree of every finite reduced union, not only
an individual image. It therefore bounds the number of distinct images.
For genus2 Y the integer bound is a<=157.

## Core conclusion

Apply the same argument to each of XxX, XxY, YxX, YxY, using their
specified endpoint tensors. The complete set of preserving jointly
minimal images is finite, contains identities, and is closed under
transpose and reduced normalized composition. Each composition comes
from a genuine fiber product of etale covers, and its outer tensor
pullbacks agree. The finite_correspondence_groupoid theorem therefore
applies on X disjoint_union Y. The original span connects the two
components and factors through the relation of the resulting smooth
proper effective DM curve. Its one-dimensional coarse function field
embeds in both original endpoint fields inside the actual source field.
This is precisely a core. No simultaneous Galois closure is taken.

The known genus33 coreless exact-form example is not contradicted by this
calculation. Zero order8 alone gives ordinary same-slope contact only2
in characteristic5. The improvement to22 uses the specified ramified
order7 quotient and the actual downstairs tensor-preserving graphs; an
arbitrary shared exact one-form does not supply these data.

## Checked parameterized extension

For coprime positive d,e with p not dividing d(e+d), use the canonical
degree-d tensor roots of a shared weight-d tensor with divisor eD,
D nonempty reduced. The cyclic roots are connected and totally ramified
over D; their root forms have zero order n-1, where n=e+d. If m>=2 is
least with e+dm=0 modulo p, the analogous upper contact is
L=1+d(m-1), with at most n slope classes. Coprimality ensures injectivity
of upper slopes over downstairs slopes. The genus multiplier is
d(n-1)/e and the normalization zero count is2dt/e. The resulting bound is

    [d(m-1)-n]ab/(2n) <= [d/e][n+d(m-1)]t.

Thus positivity is exactly d(m-1)>e+d. In that case every finite reduced
union satisfies

    a <= 2nd[n+d(m-1)] m_Y / (e[d(m-1)-n]),
    b <= 2nd[n+d(m-1)] m_X / (e[d(m-1)-n]),

and the same finiteness-to-core proof applies. This algebra specializes
to315/2 for d=7,e=2,p=5. A general statement should explicitly construct
the normalized canonical tensor root, since the spin presentation is
special to the weight7/double-zero case.

## Arbitrary gcd extension: PASS with a component-pair correction

Additional scope supplied by the main agent during this audit: remove
gcd(d,e)=1 by allowing disconnected canonical tensor roots. I also read
the statement, dependencies and full proof of `etale_root_contact_bound`
for its component accounting. The following corrected extension passes.

Let c=gcd(d,e), d0=d/c, e0=e/c, n0=d0+e0. Keep
p not dividing d(e+d), and put q>=2 least with e+dq=0 modulo p and
mu=d0(q-1). Normalize the canonical degree-d root schemes. Their
components have cyclic degrees hX,hY dividing d, each divisible by d0,
and ramification index d0 over each reduced zero. A common root
component over Z_i has degree h_i dividing gcd(hX,hY), also divisible
by d0. All these claims follow from the transitive mu_d action on
components, its stabilizers, and the local valuation e of the tensor
coefficient. The upper endpoint maps remain Cartesian and etale.

**Actual objection to the unpartitioned draft extension:** a fixed pair
of endpoint root components need not be compatible with every original
image in a finite reduced union. The count gcd(hX,hY)/h_i of common
components over that pair is valid only if at least one common component
maps to the pair. This is a real possibility: for s=omega^2 with a
globally defined form omega, a correspondence sending omega to -omega
requires opposite root components, whereas the diagonal requires the
same root component. One cannot apply the lcm coefficient indiscriminately
to an unrestricted union.

Here is the checked repair. Put h=gcd(hX,hY) and H=lcm(hX,hY).
There are d/hX endpoint components on one side and d/hY on the other.
The diagonal mu_d action on pairs has stabilizer mu_h, hence exactly

    [(d/hX)(d/hY)]/(d/h)=d/H

orbits. The common root scheme over each connected original image has
transitive mu_d action on its components, so its image in the set of
endpoint-component pairs is exactly ONE such orbit. Partition the
original finite reduced union by these d/H compatibility classes.

For a single class choose a representative pair A,B. Every original
image in this class has exactly h/h_i common root components mapping
to A,B. Their full reduced upper union has

    A_degree=a h/hX, B_degree=b h/hY,
    sum(g(W)-1)=h(n0-1)t/e0.

Here a,b,t denote totals only in the selected class. Distinct upper
images remain distinct both across original images and across root
components: the original endpoint coordinates recover the jointly
minimal field, and either tautological root recovers the root point.
The endpoint root genera satisfy
g(A)-1=hX(n0-1)m_X/e0, and similarly for B.

At each branch point one may choose x=A_local^d0 and y=B_local^d0.
The root forms are units in A_local^d0 and B_local^d0 times the
(n0-1)-st power of the respective parameter and its differential.
Their exact equality gives at most n0 slopes. The map from upper
slopes to downstairs slopes is injective because gcd(d0,n0)=1.
The same difference-of-powers calculation as above gives contact
at least1+mu for same-slope branches. Thus, with

    S*=2ht/e0,
    grid size=4hXhY m_Xm_Y/e0^2,
    S*^2/(grid size)=A_degree B_degree,

adjunction and local contacts give exactly

    (mu-n0)A_degree B_degree/(2n0)
       <= h(n0+mu)t/e0.

For mu>n0, put K=2n0(n0+mu)/(e0(mu-n0)). Since
hXhY/h=H, the bounds within a compatibility class are

    a <= K H m_Y, b <= K H m_X.

There are at most d/H classes. Summing these degree bounds (rather
than summing their quadratic inequalities) proves for ANY finite
unrestricted reduced union

    a_total <= K d m_Y, b_total <= K d m_X.

The original stronger lcm coefficient is retained for a single image
or a single compatibility class; the coefficient d is the verified
unrestricted-union bound. This suffices for finiteness and the same
actual-span core conclusion. Positivity is equivalently

    d0(q-1)>e0+d0, or d(q-2)>e.

For c=1, the zero ramification already forces hX=hY=d, so there is
only one compatibility class. Thus this correction has no effect on
the original weight7/double-zero theorem or its constant315/2.

No downstream classification of all genus-two clump profiles was
audited here; this audit establishes the parameterized contact and
core theorem, including its precise component bookkeeping.
