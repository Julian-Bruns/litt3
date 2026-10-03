# Proof: the first leading-coefficient exceptional locus

Version1, 3 October2026. Independent review pending. [Statement](../../Theorems/cartier_and_spin/wild140_first_subresultant_exception_exclusion.md).

Normalize a₃=1 by w=a₃²X,y=a₃⁵Y. The highest odd and even Cartier rows give
\[
l=3+2Q+2T,\quad
\mathcal A=X^3+lX^2+BX-B(l-T)+3Tl^2+QT^3,
\quad\Psi=X^5+QX^4+S,
\]
where Q=q/a₃²,S=s/a₃¹⁰,T=b/a₃². The remaining three rows are coefficients X¹⁴,X⁹,X⁴ of (𝒜³+3𝒜Ψ(X−T)²)Ψ². They must vanish by the actual ordinary differential relation.

Assume Q=T+1. If T=0, then Q=1 and the [centered cubic exclusion](wild140_centered_cubic_even_part_exclusion.md) already rules out the actual profile. Otherwise Q,S,T are units. Substitution gives l=4T. The following small exact ideal equality holds in F₅[B,S,T,Z]:
\[
(r_{14},r_9,r_4,Z(T+1)ST-1)
=(Z^2-2,B-2Z-1,S+2Z,T-2).
\]
The [source](../../scripts/genus_two/oct03_wild140_first_leading_exception.py) constructs the ORIGINAL rows and saves [polynomial lifts](../../../litt3-computation-data/oct03_wild140_quotient_pseudo_remainder_gate/first_leading_exception_certificate.json) for every right-hand generator, together with reverse-containment checks. Run `sage -python scripts/genus_two/oct03_wild140_first_leading_exception.py --verify-only` to verify those original-row identities without recalculating the first ideal. This is a new sparse branch calculation, not a replay of an endpoint certificate.

Thus T=2,Q=3,S=3Z,Z²=2. The ratio Q⁵/S equals1/Z, so
\[
(q^5/s)^2=(Q^5/S)^2=3.
\]
On MAIN put r=t+1 as in the moving model. There q⁵/s=4r²⁰/(r⁴−1)⁴. Squaring the last equality gives
\[
r^{40}-3(r^4-1)^8=0,
\]
a nonzero F₅ polynomial of degree40. A parameter of degree greater than40 cannot satisfy it. On BACKUP the translated model has q=[15]=3α,s=[9]=4+α. From α³=−α−1 one gets α¹⁰=3α²+3α+3, hence q¹⁰=2α²+2α+2=[62], while3s²=3α²+4α+3=[98]. These are different, so the same equality is impossible there.

For its relevance to the quotient remainder arithmetic, let N=𝒜²−Ψ(X−T)². Its first three coefficients are N=−X⁷+n₆X⁶+n₅X⁵+…, where n₆=1−Q+2T and n₅=2l−T²+2QT. The first pseudo-remainder of N by N′ has degree-at-most-five leading coefficient n₆²+4n₅=Q(Q−T−1). Since Q is a unit, the excluded locus is exactly that leading-coefficient exception. Later leading-coefficient loci remain unexamined by this theorem.
