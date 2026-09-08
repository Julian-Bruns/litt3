# Rational unit-root packets and Frobenius-group p-rank bridges

Version 2, 2026-09-08: compressed author proofs from 2026-09-05 by /root,
with /root/canonical_trace_algebra and /root/x_elliptic_quotient_maps.
No independent audit of this note. The representation-descent input is
the separately audited [Schur-index lemma](96_NONABELIAN_PACKET_SCHUR_INDEX_DOMINATION_BOUND.md#1-representation-descent-over-an-endomorphism-field).

Let k be algebraically closed of characteristic p>0; curves are smooth
projective connected. Write γ(C) for p-rank and V_pJ(C) for the rational
Tate module of its etale p-divisible group. Its dimension is γ(C), NOT
2g(C). Norm and pullback identify V_pJ(C)^H with V_pJ(C/H): the rational
projector |H|^(−1)Σh exists even when p divides |H|.

## 1. The exact rational p-group representation

For a nontrivial connected finite etale Galois p-group cover D→X with
group P, unramified Deuring--Shafarevich gives, for every H≤P,

\[
 \gamma(D/H)=1+[P:H](\gamma(X)-1).
\]

In particular γ(X)≥1, since otherwise γ(D)=1−|P|<0, and

\[
 \boxed{V_pJ(D)\simeq\mathbf Q_p\oplus
          \mathbf Q_p[P]^{\,\gamma(X)-1}.}                \tag{1}
\]

Proof. Let θ be the character on the left. For an element u of order p^a,
the values at generators of ⟨u⟩ agree: Gal(Q_p(ζ_(p^a))/Q_p) is transitive
on primitive p^a-roots, while the representation is defined over Q_p.
Its average on ⟨u⟩ is 1+|P|p^(−a)(γ(X)−1). Inducting on a, subtract
the identity value 1+|P|(γ(X)−1) and the already-known value 1 at every
nonidentity element of smaller order. The remaining φ(p^a) terms sum
to φ(p^a), hence θ(u)=1. These are the character values of (1), and
characteristic-zero semisimplicity proves the isomorphism. The standard
cohomological reference is [Crew, Theorems 1.5 and 1.8](https://www.numdam.org/item/CM_1984__52_1_31_0.pdf).

This is a p-GROUP representation theorem. An arbitrary deck group's
unit-root representation is not determined by the base p-rank.
The [modular amplification theorem](112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md)
uses actual projective summands and supplies different, non-Galois information.

## 2. Ordinary targets and Schur-index descent

Suppose such D has a nonconstant map to Y with ordinary geometrically
simple Jacobian A and geometric endomorphism algebra a number field K.
Put g=g(Y). Then either g≤γ(X), or some nontrivial complex irreducible
character χ of P satisfies

\[
 \boxed{g\le(\gamma(X)-1)[F\cap K:\mathbf Q]\,
                     \frac{d}{e_K(\chi)},\qquad
        d=\chi(1),\ F=\mathbf Q(\chi).}                   \tag{2}
\]

Use a compatible embedding of K in C. Here e_K(χ) is the Schur index
over FK, exactly as in the cited descent lemma. The map to Y may be
inseparable or ramified; this stronger one-sided assertion never replaces
the second actual etale leg in an application to common covers.

Indeed pullback followed by norm is multiplication by the nonzero degree,
so A is an isogeny factor of J(D). The trivial rational P-packet is J(X);
if A occurs there, its ordinary p-rank gives g≤γ(X). Otherwise choose
a nontrivial rational packet B_χ containing A. Equation (1) gives

\[
 \gamma(B_\chi)=(\gamma(X)-1)[F:\mathbf Q]d^2.
\]

This uses the rational central idempotent, independent of splitting at p.
The full A-isotypic part A^m is P-stable, so Hom^0(A,A^m) is a
K[P]-module of K-dimension m. The audited descent lemma gives
m≥d e_K(χ)[F:F∩K]. Since mg=γ(A^m)≤γ(B_χ), cancellation proves (2).
No faithfulness of an individual p-adic component of K is assumed.

If γ(X)=1, every p-group cover has p-rank one and cannot dominate ANY
ordinary curve of genus≥2. This last statement needs neither simplicity
nor an endomorphism-field hypothesis on that target.

## 3. The exact Frobenius-group bridge

Let W→X be finite etale Galois with G=P⋊H, P a nontrivial finite
p-group and h=|H|. Assume the action on G/H is Frobenius: every
nonidentity element fixes at most one point. Equivalently every nonidentity
element of H acts fixed-point freely on P\{1}. Put B=W/P and D=W/H.
Then

\[
 \boxed{\gamma(D)=\gamma(X)+
          \frac{|P|-1}{h}(\gamma(B)-1).}                 \tag{3}
\]

The rational permutation identity is

\[
 \mathbf Q[G]\oplus\mathbf Q^h
       \simeq\mathbf Q[G/P]\oplus\mathbf Q[G/H]^h.
\]

At a nonidentity element of P the right fixed-point counts are h and 0;
outside P they are 0 and 1. For the latter assertion the distinct point
stabilizers have disjoint nonidentity parts, whose total size is exactly
|P|(h−1). Identity dimensions agree too. Pair the character identity
with V_pJ(W) to get γ(W)+hγ(X)=γ(B)+hγ(D). Substitute
γ(W)−1=|P|(γ(B)−1) to obtain (3).

This applies to a faithful prime-to-p action C_(p^a)⋊C_h: the complement
injects into (Z/pZ)^×, hence h|(p−1), and each nonidentity multiplier
differs from 1 by a p-adic unit. A faithful action on a GENERAL p-group
need not be fixed-point free; that hypothesis cannot be dropped.

## 4. A cyclic-kernel ordinary-target bound

In Section 3 assume P=C_(p^a), and W dominates Y with ordinary simple
A=J(Y), End^0(A)=K and K∩Q^ab=Q. If A is not a factor of J(B), then

\[
 \boxed{g(Y)\le\gamma(B)-1
          \le\gamma(X)-1+(h-1)(g(X)-1).}                 \tag{4}
\]

The exclusion from J(B) is automatic when g(Y)>g(X), by the
[audited abelian-packet bound](95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md):
B→X is cyclic etale and the proof applies to its simple isogeny factors.
If g(X)=1, the same conclusion follows directly from g(B)=1.

For (4), the nontrivial P-packet containing A corresponds to
F_j=Q(ζ_(p^j)), 1≤j≤a. Equation (1) over B gives that packet p-rank
φ(p^j)(γ(B)−1). The descent bound forces its A-multiplicity
m≥φ(p^j), since F_j∩K=Q and the character degree/Schur index are one.
Ordinarity gives mg(Y)≤φ(p^j)(γ(B)−1). Finally the Prym of B→X
has dimension (h−1)(g(X)−1), so
γ(B)≤γ(X)+(h−1)(g(X)−1). This proves both inequalities.

## 5. Relevance and two-leg limits

For an ACTUAL span X←Z→Y, take only the etale Galois closure W→X
of the X-leg. The composed W→Y remains finite etale. If its group is G,
Riemann--Hurwitz first requires

\[
 \frac{g(Y)-1}{\gcd(g(X)-1,g(Y)-1)}\mid |G|.               \tag{5}
\]

For genera (9,25), this already requires that 3 divides |G|.
Pure 5-groups and faithful C_(5^a)⋊C_h with h|4 therefore fail before
any packet bound: their exclusion is NOT new progress for that pair.

The [optional genus-nine p-rank-one source](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md)
is not the project's fixed X. Nor does ordinary base imply ordinary
source for a non-Galois etale map even of degree p; the
[exact degree-five counterexample](NONGALOIS_ETALE_DEGREE5_CAN_DESTROY_ORDINARINESS.md)
retains its full geometric construction and Cartier matrices.
No result here constructs a simultaneous Galois closure or excludes
unbounded general monodromy for either fixed pair.
