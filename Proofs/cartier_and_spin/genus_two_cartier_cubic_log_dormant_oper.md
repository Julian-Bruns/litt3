# Proof: logarithmic lattice, rational horizontals, and injectivity of the coefficient

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/genus_two_cartier_cubic_log_dormant_oper.md). Pending independent review. The differential factor is the one in [the bounded large-wild incidence](large_wild_genus_two_small_packet_incidence.md); the following intrinsic proof checks all lattice and projective-gauge issues explicitly. No numerical calculation is needed.

## The oper coefficient has pole at most FIVE

At a simple F-zero take t=F and write σ=f(t)dt. Exactness of F³σ kills f1, so D=1/f(t) has zero linear coefficient and dD is divisible by F there. Thus E is regular off P. For pole order7, D has pole≤10 and dD has pole≤10 because its possible leading pole10 term differentiates to zero. Fσ has pole5, giving E∈L(5P). For pole order5, dF has pole≤5 since its leading pole term is a fifth power; D has pole≤7 and dD pole≤8, while Fσ has pole3. Again E∈L(5P). The system's equations dF=Dσ,dD=FEσ hold as actual rational differential identities.

## The logarithmic lattice and its oper transversality

Off P use the meromorphic trivial basis e1,e2. Near P let t be a local parameter and choose the lattice basis t²e1,t⁻¹e2. These are precisely local bases for O(-2P),O(P). If g=diag(t²,t⁻¹), the connection matrix in this basis is
\[
g^{-1}dg-g^{-1}
\begin{pmatrix}0&1\\E&0\end{pmatrix}\sigma g.
\]
Its diagonal entries have residues2,−1. Its upper-right entry is−t⁻³σ, of order−1 with a nonzero leading coefficient. Its lower-left entry is−t³Eσ, of order at leastZERO since ordσ=2 and ordE≥−5. Hence the connection is logarithmic and its residue is triangular with distinct eigenvalues2,−1.

The second summand is the filtration line. Its second fundamental map is the nonzero upper-right entry and gives an isomorphism
\[
O(P)\longrightarrow O(-2P)\otimes\omega_Y(P)=O(P).
\]
It is an isomorphism off P because σ has no zero there, and at P the coefficient of dt/t is nonzero. This proves the genuine logarithmic oper condition. Removing the scalar half-trace gives eigenvalues2−1/2=−1 and−1−1/2=1 in k. Thus the projective radius is {1,−1}; the overall sign convention for the connection residue does not change this orbit.

## Dormancy follows from an actual rational horizontal basis

Cartier's Frobenius rule gives
\[
C(\sigma/F^2)=C(F^{-5}F^3\sigma)=F^{-1}C(F^3\sigma)=0.
\]
Therefore there is an ACTUAL rational function I with dI=σ/F². The two rational horizontal columns are
\[
\binom{F}{D},\qquad
\binom{FI}{DI+1/F}.
\]
Direct differentiation using dF=Dσ,dD=FEσ verifies both columns against the system. Their determinant is ONE. Hence the connection is rationally gauge equivalent to the trivial connection, so its p-curvature vanishes generically. Since its logarithmic p-curvature is a morphism of coherent bundles, it then vanishes everywhere. The projective logarithmic oper is dormant. No claim that these columns form the chosen logarithmic lattice at P is needed.

## A projective oper isomorphism cannot change E

The bundle O(-2P)⊕O(P) has a unique maximal-degree subline O(P). A projective bundle isomorphism over Y lifts to a vector bundle isomorphism after a line twist. Comparing determinant degrees makes that twist degree ZERO, and comparing the unique maximal sublines makes it trivial. Thus a filtered projective isomorphism has a linear lift with meromorphic-frame matrix
\[
B=\begin{pmatrix}a&0\\b&d\end{pmatrix},\qquad
a,d\in k^\times,\quad b\in L(3P).
\]
Projective connection comparison allows a scalar differential ψ, so one has dB=A(E')Bσ−BA(E)σ+ψB. The upper-right entry first gives d=a. The two diagonal entries then give bσ+aψ=0 and−bσ+aψ=0. Since TWO is invertible, b=ψ=0. The lower-left entry now forces E'=E. Thus injectivity is proved for projective connections, not merely after presuming a trace-zero linear lift of the isomorphism.

## Exact scope of the finiteness input

The moduli space of dormant logarithmic PGL2-opers with prescribed radius on a fixed pointed curve is finite. This is the rank-two pointed finiteness assertion of [Wakabayashi, A theory of dormant opers on pointed stable curves, Theorem3.34, p.102 in the arXiv version](https://arxiv.org/pdf/1411.1208); its hypothesis is p>2. The general TheoremC also applies here because p=5>2hPGL2=4. Apply this to the radius {1,−1}. Injectivity above makes the set of coefficient functions E itself finite.

Only E is controlled by this finiteness input. Horizontal solutions F of a fixed rational dormant connection are a rank-two module over k(Y)⁵, and a bounded horizontal pencil can persist. The moving low-A family has E=2q w² independent of its horizontal parameter, illustrating why this statement does not convert the Cartier gate into a finite F-census. It supplies a genuine logarithmic oper on the actual Y while preserving the inherited common-source problem and both endpoint maps.
