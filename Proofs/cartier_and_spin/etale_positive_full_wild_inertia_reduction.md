# Proof: faithful inertia, a depth budget, and the single-jump arithmetic

Version3,3 October2026. [Independent whole-scope review PASS](../../Research/audits/ETALE_POSITIVE_FULL_WILD_INERTIA_REDUCTION_AUDIT_2026_10_03.md). Version3 adds the final nonabelian exclusion and identity corollary. See the [statement and retained original source](../../Theorems/cartier_and_spin/etale_positive_full_wild_inertia_reduction.md). All calculations below are hand identities; no computational census is run.

## The projective kernel is genuinely free on the spin target

Write R for the ENTIRE positive projective coefficient image. The accepted [coefficient-row theorem](positive_finite_coefficient_row_geometry.md) gives an actual finite étale map T→D to the normalized coefficient-row image. Its row coordinates are ratios of constant combinations of the ORIGINAL b_i=q₀(x_i)u_i⁶. Every b_i descends to the extracted étale spin target Z. Hence k(D)⊂k(Z) inside the SAME k(T), and T→D factors through Z. Since T→D and T→Z are finite étale, the intermediate map Z→D is finite étale.

The kernel K_ρ of G→R fixes D. If g∈K_ρ fixes a point of Z, it is a deck automorphism of the connected finite étale map Z→D with a fixed point. It must be the identity. The actual G-action on Z is faithful, so g=ONE in G. Thus K_ρ acts freely on Z and every stabilizer I injects into R. This uses the ACTUAL row-normalization étaleness; freedom on T alone would not suffice.

The finite FIVE-group I₁ has a unique unipotent lift in the determinant-one central extension: the central μ₄ extension splits uniquely over a FIVE-group by coprime central cohomology. Its resulting faithful linear representation has a complete invariant flag in characteristicFIVE. In a flag basis it embeds in UT₄(k). Since the strictly upper triangular algebra has fourth power ZERO, every such element has order dividingFIVE. The group has class at mostTHREE; its derived subgroup is abelian. These assertions concern the actual I₁, not a quotient of its local action.

## The Cartier defect cuts off depth TWENTY

The original row coefficients also descend the ACTUAL embedding J_Z=M₁²⊗V→B_Z and its everywhere surjective adjoint evaluation, exactly as in the [cyclic-five proof](wild_cyclic_five_etale_positive_full_exclusion.md). Put n=g(Z)−ONE and e=deg(T→Z). Its total quotient length is THREE n. At a point z with inertia order i, the orbit has |G|/i points and n=|G|/e. Its local length a therefore satisfies
\[
a\,|G|/i\le3|G|/e,
\qquad a\le3i/e\le3,
\tag{1}
\]
because target stabilizers act freely on each étale φ-fiber and i divides e.

In a parameter t at z, put w=t⁵ on Z₁. A lattice of colength a≤THREE contains w³B_Z. If σ∈I₂₀, then σt−t has order at leastTWENTY ONE. On each of the four local Cartier basis vectors dt,t dt,t²dt,t³dt, the difference σ−ONE has differential-coefficient order at leastTWENTY, so
\[
(\sigma-1)B_Z\subset w^4B_Z\subset wJ_Z.
\tag{2}
\]
This also holds for arbitrary local coefficient functions: σw−w has w-order at leastTWENTY ONE. Hence σ acts trivially on the J_Z fiber. On the line M₁² its fiber scalar is ONE because σ has FIVE-power order. Thus its projective coefficient action is trivial. The faithful inertia injection proves σ=ONE. Therefore I₂₀=ONE, without assuming that the wild group is abelian.

## There is one wild and one tame value

The determinant-character and lcm theorems give coarse P¹, e even, every inertia order dividing e, and the lcm of the orders exactly e. A wild inertia of order i has different at least i+THREE, contributing at leastONE+THREE/i to quotient Hurwitz. Three or more branch values would therefore give area at leastTHREE/e, above its actual TWO/e; TWO wild values give at leastSIX/e. Thus there are at mostTWO values and preciselyONE wild value.

If that were the sole value, its order would equal e, and Hurwitz would give different TWO e+TWO. But its zeroth term e−ONE is odd and each positive ramification term is even, so the different is odd. This is impossible. There is thus exactlyONE additional tame value of order j.

The cyclic χ₂ quotient is branched at BOTH values and totally ramified at each. If i=w h with w=|I₁| and FIVE∤h, then
\[
h_2=j_2=e_2,
\qquad g=\gcd(i,j)=\gcd(h,j),
\qquad e=ij/g.
\tag{3}
\]
In particular h,j,g are even and have the SAME full TWO-part.

## Single-jump inertia has bounded elementary order

Assume I₁=I₂=⋯=I_b and I_(b+ONE)=ONE. The standard lower-filtration commutator and power bounds make I₁ elementary abelian, of order w=FIVEʳ. Its only jump b is prime toFIVE, as is seen from a nonzero cyclic Artin–Schreier quotient. Section(2) gives b≤NINETEEN. A leading-coefficient parameter identifies I₁ with an additive F₅-subspace A⊂k of dimension r: for every nonidentity σ,
\[
\sigma t=t+a_\sigma t^{b+1}+\cdots,
\qquad a_\sigma\ne0.
\]
A tame generator of derivative ζ_h scales A by ζ_h to the power ±b. Its order h/gcd(h,b) therefore divides w−ONE. Indeed A is a vector space over F₅(ζ_hᵇ), whose degree divides r. Consequently
\[
h\mid b(w-1).
\tag{4}
\]
No false assumption h|w−ONE is made when b>ONE.

Its different is i−ONE+b(w−ONE). Substitution in the actual TWO/e area and (3) gives
\[
j\bigl[b(w-1)-1\bigr]=wh+2g.
\tag{5}
\]
The case w=FIVE is excluded by the accepted complete cyclic-five argument. Suppose w≥TWENTY FIVE. Put d=bj−h. Equation(5) gives
\[
wd=(b+1)j+2g>0,
\qquad [b(w-1)-1]d=(b+1)h+2bg.
\tag{6}
\]
From (4), reduction of the second identity modulo h gives h|d+TWO bg. Since g|h, it follows that g|d. The positive multiple d+TWO bg of h gives
\[
h/d\le1+2b,
\qquad
w=\frac{b+1}{b}(h/d+1)+2g/d
\le2b+6+2/b<45.
\tag{7}
\]
The final strict bound holds for ONE≤b≤NINETEEN. Thus w=TWENTY FIVE. Equation(7) also gives b≥TEN; since FIVE∤b, b≥ELEVEN.

Now (4) says h|TWENTY FOUR b. From (5), g≤h and b≥ELEVEN give
\[
j\le\frac{27\cdot24b}{24b-1}<28.
\]
Write H=h/g and J=j/g. They are odd, since (3) gives their common full TWO-part, and J is prime toFIVE. As g≥TWO, J≤THIRTEEN. Hence
\[
J\in\{1,3,7,9,11,13\},
\qquad J(b+1)+2=0\pmod{25}.
\tag{8}
\]
For b≤NINETEEN prime toFIVE, the complete six choices in (8) leave only J=SEVEN,b=THIRTEEN or J=ELEVEN,b=SEVENTEEN. The other residues are respectively b=TWENTY TWO,FIFTEEN,TWENTY ONE,TWENTY, all outside the allowed set. Finally (5) divided by g gives
\[
H=\frac{J(24b-1)-2}{25}.
\]
The two candidates yield H=EIGHTY SEVEN and H=ONE HUNDRED SEVENTY NINE. But h|TWENTY FOUR b requires H|TWENTY FOUR b; neither EIGHTY SEVEN divides THREE HUNDRED TWELVE nor ONE HUNDRED SEVENTY NINE divides FOUR HUNDRED EIGHT. Contradiction.

Thus every single-positive-jump wild inertia is impossible. The weak case b=ONE can also be read off before (7): h|w−ONE and (5) give ZERO<j−h<SIX. Equal full TWO-parts force j−h=FOUR, whence h+g=TWO w−FOUR and h=w−ONE; then h₂≥FOUR forces EIGHT|(j−h), again impossible.

## Every remaining abelian first wild group is also impossible

Suppose P=I₁ is abelian with more thanONE positive lower jump. Apply Hasse–Arf to the LOCAL P-action, after removing the tame quotient. Lower subgroup filtrations are unchanged by this restriction. At its second jump b₂>b₁, the lower jump gap is a positive integer multiple of [P:P_(b₂)]. As both jumps are at mostNINETEEN, this index can only beFIVE. A third jump would have index at leastTWENTY FIVE and gap at leastTWENTY FIVE, impossible. Thus there are exactlyTWO positive jumps, and
\[
|P|=w\ge25,
\qquad [P:P_{b_2}]=5,
\qquad b_2=b_1+5d,
\qquad u_2=b_1+d,
\qquad d\ge1.
\tag{9}
\]
Here u₂ is the second upper jump for the P-action. The first leading-coefficient quotient has orderFIVE, so the tame generator acts on it by ζ_h to the power ±b₁. Therefore h|FOUR b₁. The positive different terms are
\[
D=b_1(w-1)+(b_2-b_1)(w/5-1)=wu_2-b_2.
\]
The actual area identity j(D−ONE)=wh+TWO g becomes
\[
w(ju_2-h)=j(b_2+1)+2g.
\tag{10}
\]
Since g≤h, b₂≤NINETEEN, u₂≥b₁+ONE, w≥TWENTY FIVE and h≤FOUR b₁,
\[
j\le\frac{h(w+2)}{w(b_1+1)-20}
\le\frac{4b_1(w+2)}{w(b_1+1)-20}
\le\frac{108b_1}{25b_1+5}<5.
\tag{11}
\]
The penultimate inequality uses that the displayed rational expression decreases with w. The tame order j is positive and even, so it is TWO orFOUR.

If j=TWO, equality of the full TWO-parts in (3) gives h₂=TWO and g=TWO. Since h|FOUR b₁, its odd part divides the odd part of b₁, so h≤TWO b₁. Then (10) gives
\[
w(2u_2-h)=2(b_2+3)\le44.
\]
But 2u₂−h≥TWO and w≥TWENTY FIVE, making the left side at leastFIFTY.

If j=FOUR, similarly h₂=FOUR, g=FOUR, and h/FOUR≤b₁. Divide (10) byFOUR to obtain
\[
w(u_2-h/4)=b_2+3\le22.
\]
Here u₂−h/FOUR≥ONE, so the left side is at leastTWENTY FIVE. This too is impossible.

Thus no abelian first wild group remains. Since groups of orderFIVE orTWENTY FIVE are abelian, the retained frontier has NONABELIAN first wild group of order at leastONE HUNDRED TWENTY FIVE, exponentFIVE and class TWO orTHREE, with TWO or more positive lower jumps, all at mostNINETEEN. No uniform group-order bound or new endpoint map has been inferred.

## The local tame congruence deletes every first jump except ONE

Suppose now P is nonabelian, so w=|P|≥ONE HUNDRED TWENTY FIVE. Write D=Σ_(i≥ONE)(|I_i|−ONE), the positive different terms. The general accepted [local ramification constraints](../../quotient_geometry/local_actions/ramification_constraints.md) give
\[
h\mid D,
\qquad b_1\equiv\cdots\equiv b_\ell\ne0\pmod5.
\tag{12}
\]
These constraints apply to the actual local inertia, with no abelian premise. In particular successive distinct positive lower jumps differ by at leastFIVE. The area identity is j(D−ONE)=wh+TWO g.

Write h=gH and j=gJ. The positive integers H,J are coprime and odd by (3). From h|D and the area identity,
\[
H\mid J+2,
\qquad D=wH/J+1+2/J.
\tag{13}
\]
If the first jump b₁ is at leastTWO, D≥TWO(w−ONE)>w+THREE, so H>J. An odd divisor H of J+TWO greater than J must be J+TWO itself; every proper odd divisor is at most(J+TWO)/THREE<J. Therefore
\[
D=w+1+2(w+1)/J.
\]
Its lower bound TWO(w−ONE) implies J≤TWO(w+ONE)/(w−THREE)<THREE. As J is odd, J=ONE, H=THREE, and
\[
D=3w+3.
\tag{14}
\]
If b₁≥FOUR, already D≥FOUR(w−ONE)>THREE w+THREE, impossible. If b₁=THREE, nonabelian P cannot have a single jump, so (12) gives a further interval of length at leastFIVE with nontrivial group. It contributes at leastTWENTY above THREE(w−ONE), again contradicting (14).

It remains b₁=TWO. All breaks are TWO moduloFIVE and belowTWENTY. Thus the last break is TWO+FIVE K for K∈{ONE,TWO,THREE}. Let Q_k denote the nontrivial group on the kth length-FIVE interval following the first break. The Q_k can coincide if a potential jump is absent; all their orders are multiples ofFIVE. The different is
\[
D=2(w-1)+5\sum_{k=1}^K(|Q_k|-1).
\]
Equation(14) gives
\[
\sum_{k=1}^K|Q_k|=w/5+K+1.
\tag{15}
\]
The left side is ZERO moduloFIVE. Since w≥ONE HUNDRED TWENTY FIVE is a FIVE-power, w/FIVE is also ZERO moduloFIVE. But K+ONE is TWO,THREE orFOUR. This is impossible. Thus the only remaining first jump is ONE.

## First jump ONE forces the wild group to be weak

Choose σ∈I₁ with σt=t+a t²+⋯, a≠ZERO. Its action on the Cartier fiber spanned by dt,t dt,t²dt,t³dt is regular J₄: the first successive superdiagonal coefficients are TWO a,THREE a,FOUR a, all nonzero. Consequently every proper σ-invariant subspace is contained in the unique invariant hyperplane spanned by t dt,t²dt,t³dt.

The fiber image of J_Z→B_Z is σ-invariant. The everywhere surjective adjoint evaluation F*J_Z→ω_Z requires this image to have a nonzero dt component. It cannot therefore be a proper invariant subspace. It is the whole Cartier fiber, and Nakayama gives
\[
(J_Z)_z=(B_Z)_z
\]
as integral lattices. There is ZERO Cartier defect at this wild point.

By (12), every element of I₂ has break at leastSIX: the first possible subsequent break afterONE isSIX. Such an element acts trivially on the four-dimensional B_Z fiber, since all its differential-coefficient variations have order at leastSIX, hence lie in wB_Z. It acts trivially on the identical J_Z fiber and therefore has trivial projective coefficient action. The faithful inertia injection proves I₂=ONE. Thus I₁ is weak and elementary abelian, contrary to the abelian exclusion already proved. This deletes the last nonabelian possibility.

## The extracted identity carrier is the exact surviving conclusion

Every wild positive full-trace étale target has now been excluded. If e>ONE and the quotient is tame, the accepted [complete tame signature theorem](tame_etale_positive_full_spin_signature_reduction.md) gives e=TWO; the accepted [quadratic determinant-character field theorem](etale_spin_quadratic_determinant_character_exclusion.md) deletes it on BOTH endpoints. Therefore e=ONE, and the actual extracted target Z equals T.

This last identification does not bound the dimension of the original spin series. It does not descend the X-map to a new smaller source or solve the identity case. The original unmarked common-cover problem remains open.
