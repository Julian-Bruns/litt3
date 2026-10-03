# Proof: supported alternating groups and a wild conductor gap over any base

Version1, 3 October2026. [Independent whole-proof audit PASS](../../Research/audits/CANONICAL_TEN_SMALL_COMPLEMENT_ARBITRARY_BASE_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_small_complement_arbitrary_base_exclusion.md). This uses only the normal closure of the SINGLE actual bridge E/R. Both original actual endpoint maps, if present, remain on their SAME original T.

The inputs are actual fields F=k(R), E=k(E), A=k(A), K=k(T), with K=AE, separating degree [E:F]=n betweenELEVEN andNINETEEN, T/E étale, and [K:A]=TEN with S₁₀ geometric monodromy. Since K/E is separable and E/F is separable, A/F is separable as well. Set d=n−TEN.

## 1. The ten-orbit supplies a genuinely supported A₁₀

Let L/F be the normal closure of E/F and M=Gal(L/F), acting faithfully and transitively on its n E-sheets. Restriction identifies H=Gal(LA/A) with a subgroup of M. The ACTUAL component K/A corresponds to a TEN-element H-orbit Ω, and its induced permutation action is S₁₀. The complementary set Q, of size d< TEN, is H-stable.

Let B be the kernel of H→Sym(Q). Its restriction to Ω is injective and has normal image in S₁₀. If B were trivial, H would embed in S_d, impossible because H surjects onto S₁₀ and d!<TEN factorial. Thus its image is a nontrivial normal subgroup of S₁₀ and contains A₁₀. Consequently M contains A(Ω) acting on Ω and fixing EVERY complementary letter. There is no assumption that an abstract A₁₀ quotient is already supported in the original representation.

## 2. One-point overlap closes n=NINETEEN without classification

We use the elementary lemma that A(U),A(V) generate A(U∪V) when |U|,|V|≥FOUR and U∩V is nonempty.

First, A(U) together with a cycle (a b c), for distinct a,b∈U and c∉U, generates A(U∪{c}). The group A(U) is TWO-transitive on ordered pairs for |U|≥FOUR, so conjugation gives every THREE-cycle containing c and TWO letters of U; the THREE-cycles entirely inside U are already present. These generate the alternating group on the enlarged set.

If U∩V contains at leastTWO letters a,b, the cycles (a b c) for c∈V\U successively adjoin every new letter. If U∩V={a}, choose distinct b,c∈U\V and distinct d,e∈V\U. With rightmost-first composition,
\[
[(a\ b\ c),(a\ d\ e)]=(a\ b\ d).
\]
This first adjoins d to U. The enlarged set meets V in TWO letters, and the previous argument finishes the union. This proves the lemma including the one-point case.

Every pair of TEN-element supports inside an n-set with n≤NINETEEN meets in at leastONE letter. All M-conjugates of A(Ω) are present. Their supports have union the whole n-set by transitivity. Successively applying the lemma gives A_n⊂M; hence
\[
M=A_n\quad\text{or}\quad M=S_n.
\]
No Jordan theorem, classification or group enumeration is required at n=NINETEEN.

## 3. The actual resolvent forces its normal closure over E to be étale

Let J≤M stabilize Q setwise and put Z=L^J. Since H preserves Q,
\[
Z\subset L^H=L\cap A\subset A,\qquad [Z:F]=D_n=\binom nd.
\]
This is an ACTUAL intermediate field of A, not an abstract permutation quotient.

The distinguished E-sheet i belongs to Ω, so Q avoids i. Its point stabilizer V=Gal(L/E) is A_(n−ONE) orS_(n−ONE). The extension EZ/E corresponds to V's orbit of Q, consisting of ALL d-subsets of the other n−ONE letters. This action is transitive and faithful for ONE≤d≤NINE<n−ONE. Faithfulness follows directly: the intersection of all d-subsets containing a given letter is that letter; a permutation fixing every subset fixes every letter. This covers the d=ONE case as well.

Thus the normal closure of EZ/E is EXACTLY L/E. Because EZ⊂AE=K and K/E is genuinely étale, EZ/E is étale. A normal closure of a finite étale cover remains étale, since conjugate finite étale covers and their connected composita remain finite étale. Therefore L/E is étale.

For every inertia group I of L/F, this implies that I intersects every conjugate E-sheet stabilizer trivially. Indeed L/E is étale at every L-point, and conjugation transports its point stabilizers. Thus I acts semiregularly on the n original sheets, as does EVERY subgroup in its lower ramification filtration. In particular the order of such a subgroup divides n. Every nonidentity element of order h consists of n/h cycles of length h: a shorter cycle would make a nonidentity power fix a sheet.

## 4. Exact element counts imply a uniform subgroup bound

Let Ψ be the set of d-subsets of the n letters, of size D_n. An element of order h in a semiregular group fixes exactly
\[
f_n(h)=\begin{cases}\binom{n/h}{d/h},&h\mid d,\\ZERO,&h\nmid d.\end{cases}
\]
The element order already divides n. Since gcd(n,d)=gcd(n,TEN), the only possible positive fixed counts for a nonidentity element are orderTWO in the even rows and orderFIVE at n=FIFTEEN. The exact table is
\[
\begin{array}{c|r|r|r|c}
n&d&D_n&\max_{h>ONE} f_n(h)&\eta_n=ONE-\max f_n/D_n\\\hline
11&1&11&0&1\\
12&2&66&6&10/11\\
13&3&286&0&1\\
14&4&1001&21&140/143\\
15&5&3003&3&1000/1001\\
16&6&8008&56&142/143\\
17&7&19448&0&1\\
18&8&43758&126&2424/2431\\
19&9&92378&0&1.
\end{array}
\]
Each bound is optimal among arbitrary semiregular subgroups of S_n: take the cyclic subgroup generated by the free involution in the even rows, the free orderFIVE element at n=FIFTEEN, or any nontrivial free cyclic subgroup in the other rows. No geometric realization of an optimal inertia group is assumed or needed. In every row η_n≥TEN/ELEVEN.

For any nontrivial semiregular subgroup B, put q=|B|. Burnside's formula yields the exact ratio
\[
\frac{ONE-\#(\Psi/B)/D_n}{ONE-ONE/q}
=ONE-\frac{\sum_{g\in B\setminus\{ONE\}} f_n(\operatorname{ord}g)}{(q-ONE)D_n}
\ge\eta_n.
\]
The denominator is the normalized orbit-codimension on the original n sheets, whose B-action is free. For the trivial group both orbit-codimensions are ZERO, so the inequality still holds without division. This argument allows arbitrary B; it does NOT presume cyclic tame inertia. The orderFIVE row explicitly includes all possible wild lower groups at n=FIFTEEN.

## 5. The same bound holds term by term for wild conductors

At a base point of R, let I_i be the lower ramification groups of its inertia I=I₀ in L/F. For a characteristic-ZERO permutation representation W, its Artin conductor is
\[
a_I(W)=\sum_{i\ge ZERO}\frac{|I_i|}{|I|}\operatorname{codim}W^{I_i}.
\]
Use a rational or auxiliary ℓ-adic permutation representation, not a characteristicFIVE dimension calculation. Each fixed-space dimension is the number of permutation orbits. Every lower group is semiregular on the original sheets, so the preceding subgroup inequality applies term by term. All weights are nonnegative. Since the conductor of a permutation representation is the total different contribution of its associated separating cover at the base point, summing over R gives
\[
\frac{\Delta_Z}{D_n}\ge\eta_n\frac{\Delta_E}{n},
\]
where Δ_E,Δ_Z are the degrees of the ACTUAL different divisors of E/R and Z/R. This includes wild ramification and requires no bound on conductors or ramification jumps.

The exact table is elementary binomial arithmetic. A NEW tiny [source](../../scripts/genus_two/oct03_small_complement_conductor_bounds.py) checks the nine rows and fractions in one single-process execution. Its [external receipt](../../../litt3-computation-data/oct03_small_complement_conductor_bounds/bounds.json) records each allowable element order, fixed-subset count, exact η and genus gap. No finite-group enumeration, large certificate replay or numerical cover search is used; the displayed formulas already supply the proof.

## 6. Arbitrary base genus and the exact half-genus contradiction

Put b=2g(R)−TWO, u_E=(2g(E)−TWO)/n and u_A=(2g(A)−TWO)/[A:F]. Riemann–Hurwitz for E/R gives Δ_E/n=u_E−b. For Z/R the conductor inequality therefore gives
\[
\frac{2g(Z)-TWO}{D_n}
=b+\frac{\Delta_Z}{D_n}
\ge\eta_nu_E+(ONE-\eta_n)b.
\]
Since the ACTUAL field Z lies inside A, Riemann–Hurwitz for A/Z and the degree equality [A:F]=[A:Z]D_n imply
\[
u_A\ge\frac{2g(Z)-TWO}{D_n}.
\]
This proves the stated general normalized-genus bound for EVERY base genus.

Under the exact half-genus equality u_A=u_E/TWO, we may use η_n≥TEN/ELEVEN: monotonicity in η is valid because u_E−b=Δ_E/n≥ZERO. The gap is at least
\[
\left(\frac{10}{11}-\frac12\right)u_E+\frac b{11}
=\frac{NINE u_E+TWO b}{22}.
\]
If u_E≥SIXTEEN and g(R)≥ZERO, then b≥−TWO and this is at least
\[
\frac{144-FOUR}{22}=\frac{SEVENTY}{ELEVEN}>ZERO.
\]
Thus the required resolvent genus is strictly larger than permitted by its actual inclusion in A. The configuration is impossible. The same calculation proves the sharper condition NINE u_E+TWO b>ZERO.

For g(E)=SIXTEEN r+ONE, u_E=THIRTY-TWO r/n. The numerical threshold holds whenever r≥n/TWO, including the stated equal-block application n=r. An application still requires the actual field/compositum, endpoint retention, étaleness, TEN-sheet S₁₀ monodromy and exact half-genus equality over that same R. This result alone does not construct those data or classify other block sectors.

The two original actual finite étale endpoint maps remain on T throughout. Z and conjugate E-fields are auxiliary analysis of a single normal closure; no replacement common source or simultaneous endpoint Galois closure is used. The unmarked common-cover problem remains open.
