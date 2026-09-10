# Initial cyclic-five Artin--Schreier product audit

Verdict: **PASS with the Taylor estimate corrected below.**
Auditor: `/root/audit_dihedral_initial_as_product` (fresh bounded audit).
Date: 2026-09-10.
Scope: the initial formula and descent of the GIVEN marked W3 lift in
`Research/DIHEDRAL_INITIAL_RETURNED.md`, with EXACT established inputs
from `Research/PRO_DIHEDRAL_INITIAL_OBSTRUCTION_REQUEST.md`.
No blocking objection remains after this correction. This is a prose
audit, not formal verification. No later-level or common-cover claim
is audited here.

The cochain-level q³ repair, normalized integral linear carry +d^5 q,
and vanishing of additive next-digit contributions on those inputs
are stipulated inputs, not conclusions re-established in this audit.

## 1. Corrected all-degree Taylor calculation

Let D be the reference tilde connection operator and z the divided
Frobenius displacement. Reference coefficients and operators come
from C. In weight one, D² is divisible by p, since D modulo p is the
square-zero Higgs operator. Consequently D^n is divisible by
p^floor(n/2). Work at p=5 modulo p³.

The returned estimate for the square of a displacement variation is
incorrect when n denotes the FULL Taylor degree. In the nth term,
exactly two varied factors in (z+p*zeta)^n give

    p²*zeta²*z^(n-2)*D^n / [2*(n-2)!].

Its valuation is at least

    2 + floor(n/2) - v5((n-2)!) >= 3,  n>=2.

Thus the stated vanishing survives. This includes n divisible by five
and does not truncate the Taylor series at degree four. For n=2,3
the bound is 3; for larger n use v5(m!)<=m/4. More generally, s>=2
changed displacement factors have valuation at least
s+floor(n/2)-v5(s!)-v5((n-s)!), which is at least 3.

For one p²X operator insertion the unchanged D factors split into
two blocks. Their combined valuation is at least
max(0,floor((n-2)/2)). Therefore the bound after n! division is

    2 + max(0,floor((n-2)/2)) - v5(n!) >= 2.

For two insertions there are three blocks, giving

    4 + max(0,floor((n-4)/2)) - v5(n!) >= 3.

These estimates remain valid when D differentiates the coefficients
of X: they are estimates for compositions of integral operators, and
the adjacent unchanged D blocks themselves are p-divisible. Higher
numbers of insertions only increase the sufficient bound.

For one operator insertion and one changed displacement factor, use
n/n!=1/(n-1)! rather than the cruder denominator n!. The bound is

    3 + max(0,floor((n-2)/2)) - v5((n-1)!) >= 3.

Additional varied factors satisfy the same vanishing. Hence Taylor
transport preserves the additive p² change and creates no quadratic
contribution modulo p³ from two displacement variations, two such
operator variations, or their mixed variation.

## 2. Actual filtered/graded and algebra bookkeeping

The relevant construction uses both the previous filtered morphism
modulo p² and the prescribed new graded morphism modulo p³.
The weight-one formulas in [LSZ, Lemmas 4.7 and 4.10](https://arxiv.org/pdf/1311.6424)
give the tilde connection and transition matrices used in the returned
record. Their diagonal transition entries and lower connection entry
are supplied by the prescribed graded data. A raw nonfiltered graph
overlap is not such a morphism.

With these entries fixed, the order-p change in the previous tuple
enters the tilde data additively at order p². Quadratic terms that
are zero in that previous tuple are not rescaled from arbitrary raw
lifts. New graded changes from the order-p² curve deformation have
no surviving quadratic term at the precision in question. The first
graded identification is restored by linear operations; determinant
normalization divides by 2, a unit, and introduces no division by p.
The full Taylor formula and the explicit warning about the previous
flat twist appear in [LSYZ, Section 5, pp. 35–38](https://arxiv.org/pdf/1404.0538).

On an actual AS chart, translation by lambda on polynomials of degree
at most four has logarithm lambda*d/dw. This is a statement about
the reduced polynomial representation, NOT a derivation rule on A.
It gives q³A=P1 and q²A=P2 directly. For two elements in P1 their
ordinary product has degree at most two, so it lies in P2; no AS
reduction or Leibniz rule for q is involved.

Base derivations preserve these low-degree spaces: differentiating
w^5-Hw=f in characteristic five gives dw=-(df+w*dH)/H, of degree
at most one (here H is constant on the curve). Frobenius also
preserves them by w^5=Hw+f. AS chart translations preserve degree.
Thus the first reduced transition corrections and Hodge repairs lie
in P1 throughout the first linear normalization. Base bundle units,
reference operators and the actual pulled-back flat twist do not
increase this degree.

At the final graph calculation every ordinary quadratic term is a
product of two such reduced P1 coefficients times a base coefficient.
It already has coefficient p². Its divided reduction therefore lies
in P2=q²A. This applies also to quadratic graph normalization terms;
the Taylor estimates above exclude an extra divided quadratic term.
The divided remainder of the FIRST, order-p bracket must instead be
retained: it is the stipulated integral linear carry, not something
annihilated by this degree argument.

On the pulled-back two-affine Cech cover a P2-valued normal 1-cochain
has a q² primitive coefficientwise; every 1-cochain is a cocycle.
Its class is therefore in q²H1(T,N). The supplied Fitting description
places this subspace in im(Psi_T), including the bijective part.
All quadratic terms vanish in D_T. The stipulated additive terms
vanish there as well, leaving exactly

    epsilon_T(T3(d,b)) = d^5 q.

## 3. Consequence and exact generality

Since q is nonzero in R/q², existence of a compatible W4 extension
forces d=0. The corresponding compatible C3 lift differing from
C3^0 by b times the specified lower kernel generator pulls back to
the GIVEN T3(0,b). The torsor classification uses the given W2
marking and the ORIGINAL finite etale h. Naturality of the full
construction and uniqueness of its Hodge line identify the previous
tuple, its prescribed graded identification and its actual flat
periodicity twist. This is descent of the specified truncation, not
merely existence of some abstract lower curve. Conversely epsilon=0
has the stated compatible-next-lift interpretation by the supplied
obstruction theory. No new specialization exclusion is introduced.

Neither involution nor the special elliptic AS right-hand side is
used in this cancellation. The argument applies to ANY actual
connected cyclic-five AS torsor supplied with these same reference,
cochain repair, Fitting/image, integral linear carry, additive
comparison, twist and marked deformation inputs. It does not prove
those inputs for an arbitrary torsor. In particular it supplies no
automatic statement for longer cyclic covers or higher defect blocks.

## Separate scoped audit: simple-defect inputs and order-twenty carrier

Verdict: **PASS Sections 8–9 of `Solutions/Sol_cyclic_five_delayed_descent.md`.**
Auditor: `/root/audit_dihedral_initial_as_product`.
Date: 2026-09-10. No blocking objections. This second review treats
the previously audited all-level comparison and partner count as
established inputs. It checks the new general input verification and
the application, not longer cyclic towers or the original global
common-cover problem.

For a connected cyclic-five etale h:T→C with g(C)>=2, the absence of
H0(T,T_T) makes the Cartan–Leray edge map an isomorphism
H1(C,T_C) ≅ H1(T,T_T)^C5. If r=3g(C)-3, these spaces have dimensions
r and 5r before taking upper invariants. A k[C5] indecomposable has
length at most five and one invariant dimension. There must therefore
be exactly r summands, all of length five. This proves freeness, not
just the dimension of the invariant subspace. The maximal Higgs
identification gives the same normal line; the periodicity twist
cancels in this normal identification without being trivialized in
the actual flat tuple.

The semilinear Fitting decomposition is deck-stable and a direct
decomposition of this free module. Its summands are projective over
the local ring k[e]/e^5, hence free. Restricting the bijective and
nilpotent operators to invariants preserves their respective types.
The lower simple zero block consequently forces the upper nilpotent
summand to have module rank one. In rank one its multiplier has
kernel dimension equal to its e-adic order; source defect two gives
exactly e² times a unit. This supplies the claimed kernel, cokernel
and q²-image statements with arbitrary r.

Over W2 the negative-degree bundles have zero H0 and free cohomology
of the expected W2-rank. Lifting a group-ring basis modulo five gives
a surjection from the free W2[C5] module of rank r; equality of
W2-lengths makes it an isomorphism. Integral pullback has image in
invariants, the norm submodule of this regular representation, and
its reduction is the above isomorphism. Nakayama identifies the whole
norm submodule. For the two-affine Cech complex, freeness of H1 over
W2[C5] splits the quotient map. Its kernel is the image of Cech0,
and H0=0 makes the inverse onto that image unique and equivariant.
Thus the needed primitive operator preserves q^j images integrally.
No averaging by five has been used.

The established later comparison only sees this deck algebra, its
one nilpotent block, the equivariant primitive, and the actual common
deck-descended W2 tuple. Changing r introduces additional bijective
coordinates, whose contributions are removed by Psi. Neither the
relative formula nor the marked deck-translate argument uses genus
three or rank six. Once the lower obstruction is zero, an actual
compatible lower reference exists and its pulled-back next cokernel
class is zero (the norm maps the lower zero line to e^4, zero modulo
e²). The relative formula then kills the e³ coefficient. Together
with the audited initial product argument, this proves descent of
each GIVEN truncation along the original h. The existing marked
induction and algebraization apply without alteration.

For the main reduced order-twenty carrier, the established deck
reduction supplies actual maps T→Y'→C→Y with genera 21,5,3,2,
degrees 5,2,2, and defects 2,1,1,0. Prime-to-five trace splits the
Psi module of C inside that of Y'. Both kernels have dimension one,
so the complementary six-dimensional summand has zero kernel and
is bijective. The retained C summand has five bijective dimensions
and one zero line. Hence Y' has eleven bijective dimensions and one
zero line, precisely the simple-defect input above.

The canonical ordinary Y reference lifts these original covers and
provides the initial marking and compatible reference. For the GIVEN
ordinary-X source tower, descend first through the prime-to-five
defect-neutral quotient Z→T, then the cyclic-five T→Y', then the
prime-to-five defect-neutral Y'→C. Each descent retains the existing
source and original map. Thus the characteristic-zero span still has
both maps from Z^can and a genus-three endpoint C^lift. The unchanged
genus-three partner count applies; no genus-five count and no lift
of C→Y are needed. The same reasoning includes reduced C10 and D10.
It excludes exactly the stated ordinary-X/source-defect-two stratum
with actual five-part order five and nontrivial action, not five-part
order twenty-five or larger, nor trivial-action or non-Galois cases.
