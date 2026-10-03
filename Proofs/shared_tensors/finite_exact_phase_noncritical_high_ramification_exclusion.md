# Proof: source differential order is enough for the existing contact-five gate

Version1, 3 October2026. [Fresh independent five-check whole review PASS](../../Research/audits/OCT03_NONCRITICAL_SOURCE_HIGH_RAMIFICATION_CONTACT_FIVE_WHOLE_AUDIT_2026_10_03.md), with no required mathematical corrections. See the [statement](../../Theorems/shared_tensors/finite_exact_phase_noncritical_high_ramification_exclusion.md).

Put s=z(P)³∉{0,1} and k=e_P(z)≥5. In an arbitrary local source parameter u, the separating function z has expansion z(P)+a_k u^k+⋯. If five does not divide k, ord(dz)=k−1≥5. If five divides k, its first term differentiates to zero and the first subsequent nonzero derivative has order at least k≥5. Thus in ALL cases
\[
\ell=\operatorname{ord}_P(dz)\ge5,
\qquad\operatorname{ord}_P(z^3-s)=k.
\]
This elementary local differential estimate replaces the earlier uniform-π different assumption. No completed extension is presumed Galois.

## Ordinary endpoint coordinates

Suppose X1,X2,p(X1),p(X2) are units at P. Then X1−X1(P) is an ACTUAL source parameter by étaleness. Put v=ordq(X1)∈{0,1}; q(X2) has the same valuation. Exact differentiation of the original q and θ equations, cubing and clearing unit factors as in the [accepted contact-five proof](../cartier_and_spin/finite_uniform_five_ordinary_frozen_conic_exclusion.md), gives
\[
K=X_2^3p(X_2)^2-z^{33}X_1^3p(X_1)^2,
\qquad\operatorname{ord}_P K\ge\ell+v\ge5+v.
\]
Freeze the unique branch V through X2(P) satisfying V²=sX1²+d0(s−1). Since2X2(P) is a unit,
\[
(X_2-V)(X_2+V)=(z^3-s)q(X_1)
\]
gives ord(X2−V)≥k+v≥5+v. Also ord(z33−s11)=k. The frozen numerator
\[
V^3p(V)^2-s^{11}X_1^3p(X_1)^2
\]
therefore has source contact at least five. The accepted exact PSC3/4 certificate excludes ALL geometric s outside0,1 with this frozen contact. Its proof depends only on contact, fixed p/q and the exact phase κ³1. The index-five restriction in its earlier source application is not a restriction of the unchanged polynomial certificate. This includes v1 at q0-zero points.

## Both endpoints are trigonal branches

Suppose p(X1(P))=p(X2(P))=0. Write a=X1(P),b=X2(P). The [accepted exact branch-weight certificate](finite_p_branch_wild_diagonal_confinement.md) supplies units a,b,q(a),q(b),p′(a),p′(b) and pairwise distinct values
\[
W(a)=\frac{a p'(a)^2}{q(a)^9}
\]
on ALL ten geometric roots. The actual endpoint étaleness gives ord(y_i)=1, ord(X_i−X_i(P))3 and ord(dX_i)2.

The SAME original differential numerator now gives ordK≥ℓ+4≥9, exactly as in the branch proof with δ replaced by the actual orderℓ of dz. Freeze V as above. Its derivative at a is sa/b≠0, so p(V) and p(X2) both have source order three. The coordinate correction has order at least k, and the squared-p correction has order at least k+3≥8. The other corrections have order at least k+6. Hence the frozen numerator has source order at least
\[
\min(\ell+4,k+3)\ge8.
\]
It is a power series in X1−a, whose source order is three. Its order must therefore be a multiple of three; the displayed bound makes its polynomial multiplicity at least three. In particular the quadratic coefficient vanishes. The exact coefficient in the accepted proof is
\[
s^2a^2\bigl[bp'(b)^2-s^9ap'(a)^2\bigr].
\]
Its vanishing and s=q(b)/q(a) give W(a)=W(b). The accepted separation makes a=b and s1, contrary to the present hypothesis. This uses the already recorded certificate, without root enumeration or replay.

## Mixed branches, centers and infinity

If exactly one endpoint is a trigonal branch, its q-value is a unit and its q-variation has exact order three. The opposite ordinary noncenter endpoint has q-variation of exact order one. Their quotient z³ then varies to order one. If that opposite endpoint is centered, its q-variation has exact order two and the quotient varies to order two instead. Both contradict k≥5.

If neither endpoint is a trigonal branch but at least one centered coordinate is zero, its q-variation has order two. The other centered coordinate cannot be zero, since that would give s1. Its ordinary noncenter q-variation has order one, giving k1, another contradiction. All remaining finite cases were the ordinary-unit case above.

If either endpoint is infinity and z is a unit, the q-identity forces both endpoints to be infinity. Let ρ be their leading triple-pole ratio X2/X1. The ORIGINAL cubed theta equation and monicity of P give ρ=κ³, while the q-equation gives s=ρ². Exact phase κ³1 therefore forces s1. No infinity point satisfies the current s≠1 hypothesis.

Every case is excluded. The proof preserves both ACTUAL étale maps and requires only the actual source ramification of the separating z; no arbitrary tensor phase, intermediate Galois closure or fictitious endpoint map is introduced.

For the final application, the [accepted whole-block exact-phase theorem](../cartier_and_spin/canonical_ten_whole_block_exact_phase_tame_congruence.md) makes π tame, with local indices one or two. A degree-three Q/z cover is tame, since its monodromy embeds S3 and characteristic five does not divide six. At a unit noncritical Q-point of index three, any π-index-two source point has actual z-index six, excluded above. Thus all its π-completions are unramified. Critical values and lower indices remain untouched, and no whole three-block exclusion follows.
