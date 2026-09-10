# Secondary deck-transfer audit

Verdict: **PASS**, for the actual W5 constant transfer in the precise
cyclic-five, defect-two setup of
[the request](../PRO_SECONDARY_NORM_TRANSFER_REQUEST.md).
Auditor: /root/audit_secondary_deck_transfer. Date: 2026-09-10.
This is a bounded prose audit, not formal verification.

Audited input: [returned argument](../SECONDARY_NORM_TRANSFER_RETURNED.md).
The previously audited initial and compatible-lower-reference cases in
[the canonical proof](../../Solutions/Sol_cyclic_five_compatible_reference_descent.md)
are inputs, not newly audited here. No common-cover exclusion or larger
deck-group application is certified by this record.

## Actual construction and the quadratic term

[LSZ, Section 4, Lemmas 4.6–4.10, printed pp.27–29](https://arxiv.org/pdf/1311.6424)
constructs the intermediate object from the previous filtered object AND
the prescribed graded object. In a filtered basis its local connection
uses arbitrary lifts in the non-Higgs entries and prescribed Higgs
entries in the adjacent graded position. The gluing morphism lifts both
the filtered reduction and graded morphism simultaneously. Its ambiguity
is in the higher filtration multiplied by the previous top power of5,
which the construction kills. These facts give exactly the weight-one
transition and connection in returned formula(6).

Thus the lower-left transition entry is zero before rescaling. This is
available because A4 and B4 each have a GLOBAL preceding filtered
object. It does not require either one to descend. A raw lift of the
matrix comparing unrelated local graph choices is not this morphism:
in those coordinates its lower-entry correction includes the negative
of the entire raw error, including125Q. The construction retains the
specified filtered reduction and grading; it does not replace them
by a new arbitrary lift. No assertion that Q itself has zero class is
needed or proved.

After gamma/graded normalization, previous H3 differences have order25;
their surviving changes in the intermediate object have order125.
Changes of the25beta entry vanish modulo625. The final graph change
and the leading Taylor change both have order25, so their product
vanishes modulo625. These are computations on the actual compatible
objects, and resolve the defect of the incompatible-reference argument.

## Equivariance, division, and orientation

The necessary equivariance does NOT mean that A4 is deck-fixed. The
leading comparison is multiplied by25, so its coefficient is needed
only modulo25. It consequently uses the common descended tuple on T2.
Any dependence on A4's non-descended H3 digit changes that coefficient
by25 and disappears modulo625. Corrections already multiplied by125
use only special-fiber coefficients. Their operations on the first
curve and normal-repair cochains are additive and deck-equivariant.
This precision argument is essential to justify formula(7).

[LSYZ, Section5, formula(5.5.1), Taylor gluing and Proposition5.2](https://arxiv.org/pdf/1404.0538)
supplies the divided-Frobenius comparison, the normal projection and
the minus sign in rho(S+nu)=rho(S)-Psi(nu). The preceding object in
that construction includes the periodicity line with its connection.
Its normal line cancels the common tensor factor; its flat object
does not. The returned argument preserves this distinction and the
original reduction identification.

Use the supplied integral deck-linear Cech section and primitive.
For nutilde in e³M2 the positive comparison cochain and its primitive
can be taken in e³. Their difference is the chosen representative of
its cohomology class and is divisible by5 because Psi(nu)=0. It is
only this difference that is divided. The other additive correction
terms project to zero, as do5B/5 terms on nu in e³. None of these
statements incorrectly moves division through the augmentation ideal.

The surviving positive comparison has

    [e² varphi(atilde e³+btilde e4)/5] = -a^5 e in R/e².

Indeed e5/5=-e-2e²-2e³-e4, whereas e6/5 has zero image here.
The obstruction difference has the opposite sign. Therefore

    epsilon(B4)-epsilon(A4)=a^5 e.

The exact integral carry verifier was replayed successfully. That replay
checks the algebra; the filtered-construction check above is what
identifies the algebra with the actual obstruction.

## Marked deck comparison and precise consequence

The smooth pulled-back reference fixes the origin of the marked
curve-lifting torsor even when its Hodge reference is incompatible.
Hence sigma T4−T4=e xi=c e³+d e4. Both translated objects have
compatible preceding tuples. Naturality of their actual obstruction
gives e epsilon(T4)=c^5e. Thus

    pi0 epsilon(T4)=c^5=eta0.

There is no extra coefficient Frobenius and no use of tau on C3.
If T5 is compatible, eta0=0. The supplied compatible-reference theorem
then applies and recovers the GIVEN T4 along the ORIGINAL map with
the full previous tuple. This is stronger than a computation on an
arbitrary lift of a semilinear matrix.

## Separate all-level local check

The SAME relative compatible-object comparison works for n>=3, with
A_(n+1), B_(n+1) over the same descended T_n and full previous tuple.
Replace25 by5^(n−1),125 by5^n, and625 by5^(n+1). The leading
coefficient again needs only W2 data; the other linear terms need
only special-fiber data. Products of two first corrections vanish
because2(n−1)>=n+1. The filtered/graded construction still removes
the raw lower transition before any weight division. The residual
is the same+a^5e on a e³+b e4.

This separately verifies the local extension needed for an induction.
It does not audit the subsequent induction's global hypotheses or any
application to cyclic25, dihedral groups, or all common-cover branches.
The n=2 quadratic case continues to use the earlier audited argument.

## Separate audit: induction, algebraization, and C10 consequence

Verdict: **PASS**, for Sections4–6 of
[the integrated proof](../../Solutions/Sol_cyclic_five_delayed_descent.md),
audited separately on2026-09-10 by the same bounded auditor. This
extends the scope of the preceding record only as specified here.

The induction uses the audited n=2 case once and the all-n relative
calculation thereafter. The extra upper digit forces eta0=0 before
the compatible-reference theorem is applied. That theorem then
recovers precisely the given next truncation and its original marked
map. Injectivity of tangent pullback for these finite etale hyperbolic
curves follows from negative H0 and the descent sequence, even though
the cover degree is5. Together with absence of infinitesimal curve
automorphisms this gives uniqueness of each lower deformation and
marked map. Hodge and projective graded uniqueness and the retained
two-torsion line give compatible full tuples throughout.

The compatible formal curves have ample canonical bundles, so their
algebraization and the proper henselian finite-etale equivalence give
the actual original cover over W(k). This repeats the already used
algebraization argument; it does not require the original C→Y to lift.

For the scoped ordinary-X/source-defect-two branch, Z→T is an ACTUAL
prime-to5 defect-neutral quotient. The supplied canonical-X upper
tower first descends along that map by the earlier theorem, with the
canonical W2 identification supplied by the two-leg result. It next
descends along T→C by the present theorem. Composing gives the two
actual maps X^can←Z^can→C^lift from the same source. No Galois closure
or presumed simultaneous lift replaces these maps.

The inherited genus-three partner estimate depends only on this
mixed-characteristic span and the fixed canonical lift of (X,r_X).
Its three factors are unchanged: at most5^24 connections, fewer
than2^80000000 partners, and at most80640 parameters per special-fiber
double. Stable-model uniqueness and simultaneous Frobenius transport
of both maps give the same strict bound2^80000073<K. Thus the stated
C10 carrier branch is excluded for the existing main pair.

The finite projectivity script was independently replayed: all ten
bad-double labels form one orbit of the order20 stabilizer of4 in
PGL2(F5). Transport of the actual connection and tuple uses their
intrinsic functoriality under the corresponding curve isomorphism;
the label check alone is not substituted for that functoriality.
The five-dimensional bijective block plus simple zero on each bad
double is an established input from the cited Section6 of
Sol_symplectic_p_cover_section_growth.md. Its Section8.1 then gives
the rank-one nilpotent block e²u(e)Frob when the cyclic-five carrier
has defect two. No additional operator classification is needed.

This separate verdict certifies the stated C10 consequence with the
explicit actual carrier hypotheses. It does not certify C25,
dihedral carriers, higher defects, or a complete common-cover exclusion.
