# Proof: the Hermitian cohomology complex and its odd blocks

[Statement](../../../Theorems/deformations/section_growth/cyclic_symplectic_blocks.md).
The characteristic-five, degree-five proof was supplied in the first
focused Pro reply. The same proof works over any field of odd
characteristic and for every cyclic prime-power degree, as follows.

## The actual paired complex

Put \(R=k[\gamma]=k[t]/(t^N)\) and let \(\sigma(\gamma)=\gamma^{-1}\).
Étale locally the torsor splits, so \(q_*\mathcal O_D\) is an
invertible \(\mathcal O_C\otimes_kR\)-module. Denote the corresponding
line bundle on \(C_R\) by \(\mathcal P\). Its pairing
\[
h(a,b)=\sum_{i=0}^{N-1}\operatorname{Tr}_{D/C}(a\gamma^ib)\gamma^i
\]
satisfies \(h(ra,sb)=r\sigma(s)h(a,b)\) and
\(h(b,a)=\sigma h(a,b)\). In the split torsor an idempotent e of one
component is an R-basis and \(h(e,e)=1\). Thus h is perfect, including
when p divides N. The algebra unit is not this R-basis.

Tensor h with the alternating form on E. Relative cup product and
Serre trace give a perfect skew pairing
\[
\mathcal C\otimes_R^{\mathbf L}\sigma^*\mathcal C\longrightarrow R[-1],
\qquad
\mathcal C=R\pi_*(E\otimes\mathcal P).
\]
Here \(\pi:C_R\to\operatorname{Spec}R\). The complex is perfect of
amplitude [0,1], and \(\chi(E)=0\), so it has an equal-rank two-term
free representative. Splitting unit entries of its differential
removes contractible summands and gives a minimal representative
\(K=[M\xrightarrow A N']\), with both modules free of rank n and
\(A\equiv0\pmod t\). Its degree-zero cohomology is the actual section
module, with its actual deck action.

Represent the transported derived pairing by a chain map b. This is
possible because the source complex is bounded free. Its conjugate
graded transpose is
\[
b^\dagger(x,y)=(-1)^{|x||y|}\sigma b(y,x).
\]
The geometric skew symmetry says \(b^\dagger=-b\) up to homotopy.
Replacing b by \((b-b^\dagger)/2\) gives strict skew symmetry without
changing its derived class. The adjoint remains a quasi-isomorphism.
Both its source and target are minimal free complexes; reducing a
homotopy inverse modulo t shows that its two degree components are
isomorphisms. Hence its mixed pairing is perfect over R, not just
over the residue field.

Choose dual bases so that
\(b(x,v)=x^{\mathsf T}\sigma(v)\), for \(x\in M,v\in N'\).
Strict skew symmetry gives \(b(v,x)=-v^{\mathsf T}\sigma(x)\).
The chain-map condition on two degree-zero elements is
\[
0=b(Ax,y)+b(x,Ay)
 =x^{\mathsf T}(-A^{\mathsf T}+\sigma(A))\sigma(y).
\]
Consequently \(A^*=A\), where \(B^*=\sigma(B)^{\mathsf T}\). In
particular the differential is Hermitian, not skew-Hermitian.

## Successive leading forms

The element \(z=(\gamma-\gamma^{-1})/2\) equals t times a unit,
and \(\sigma(z)=-z\). Thus \(R=k[z]/(z^N)\).
Suppose a nonzero remaining block of A has minimum entry valuation e.
Write it as \(z^e B\), over \(S=k[z]/(z^{N-e})\). Its symmetry is
\(B^*=(-1)^eB\). The reduction \(B_0\) is symmetric for even e and
alternating for odd e. Choose a complement to its radical, on which
it is nondegenerate. With \(\varepsilon=(-1)^e\), write
\[
B=\begin{pmatrix}C&D\\ \varepsilon D^*&F\end{pmatrix},
\qquad C\text{ invertible},\quad C^*=\varepsilon C.
\]
The invertible congruence with
\(S_0=\left(\begin{smallmatrix}1&-C^{-1}D\\0&1\end{smallmatrix}\right)\)
splits B into
\[
C\ \oplus\ (F-\varepsilon D^*C^{-1}D).
\]
The second block vanishes modulo z. Lift the congruence to R and
repeat on this higher-valuation remainder. This terminates with
\[
A\sim\bigoplus_{j=1}^{N-1}z^jC_j\ \oplus\ 0_{r_N},
\qquad C_j^*=(-1)^jC_j,
\]
where \(C_j\) is invertible over \(k[z]/(z^{N-j})\). For odd j its
reduction is invertible alternating and therefore has even size.
Each nonzero block has kernel
\[
\ker(z^jC_j)\simeq (z^{N-j}R)^{r_j}
\simeq(R/(z^j))^{r_j}.
\]
The zero block contributes \(R^{r_N}\). Since z and t generate the
same ideals, uniqueness of the cyclic-module decomposition proves
\(b_j=r_j\), and proves the claimed separate parities. If the total
dimension is odd, \(b_N\) must be odd, since all other summands have
even total dimension. Therefore that dimension is at least N.

## Actual deck groups

For an element \(\gamma\) of order \(p^a\) in the deck group of a
connected finite étale cover \(T\to C\), the free action gives the
actual intermediate torsor \(T\to T/\langle\gamma\rangle\).
The bundle descends from C, and étaleness identifies the pulled-back
canonical lines. Apply the preceding result to this torsor. If m is
odd, it gives \(p^a\le m\). Cauchy's theorem proves the assertion when
\(m<p\). No common Galois closure or section-preservation hypothesis
has entered the argument.
