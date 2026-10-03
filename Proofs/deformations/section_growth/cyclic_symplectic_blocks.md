# Proof: symplectic section growth and cyclic block parity

[Statement](../../../Theorems/deformations/section_growth/cyclic_symplectic_blocks.md).
Sections1–4 use an algebraically closed field. Section5 works over
any field of odd characteristic and retains the actual cyclic deck action.

## 1. The first socle and its alternating cup forms

Let \(h:T\to C\) be a connected Galois \(P\)-cover, \(P\) a nontrivial
\(p\)-group. Put \(d=\dim_{\mathbf F_p}\operatorname{Hom}(P,\mathbf F_p)\).
In the regular representation the functions
\(x\mapsto c+\lambda(x)\), \(\lambda\in\operatorname{Hom}(P,k_{\rm add})\),
form a translation-stable subspace. Its trivial outer actions give
\[
0\to\mathcal O_C\to\mathcal F_C\to\mathcal O_C^d\to0,
\qquad\mathcal F_C\subset h_*\mathcal O_T.
\]
Write \(\alpha_i\) for its extension classes and \(V=H^0(E)\).
The pairing identifies \(H^1(E)=V^*\), and the connecting map
\(\delta:V^d\to V^*\) is the sum of the cup forms
\[
B_i(s,t)=\operatorname{Tr}_{H^1(\omega)}
                       (\alpha_i\cup\langle s,t\rangle).
\]
Each is alternating, by a Čech representative and the form on \(E\).
The transpose kernel is \(R=\bigcap_i\operatorname{rad}(B_i)\), so
\[
h^0(E\otimes\mathcal F_C)
=r+rd-\operatorname{rank}\delta=rd+\dim R.
\]
Projection formula and the inclusion give the same lower bound upstairs.
No division by \(p\) or group-ring cokernel freeness is used.

## 2. Growth, zero preservation and positive preservation

For cyclic \(p\)-covers the bound is \(r+\dim\operatorname{rad}(B_1)\);
an odd \(r\) grows. If \(r=1\), all forms vanish and the bound is \(1+d\).
If a nontrivial \(P\)-cover preserves \(r>0\), then
\(rd+\dim R\le r\) forces \(d=1,R=0\). Burnside's basis theorem
makes \(P\) cyclic; the nondegenerate alternating form makes \(r\) even.

A non-Galois cover with \(p\)-group closure \(L/C\) also contains an
ACTUAL cyclic-\(p\) intermediate: a maximal subgroup containing
\(\operatorname{Gal}(L/T)\) is normal of index \(p\). Pullback gives
odd growth. If zero sections became nonzero, the nonzero section
\(P\)-module on \(L\) would have nonzero invariants, hence a section
on \(C\), a contradiction. Together with injective section pullback,
this excludes upstairs dimension one for every such nontrivial cover.

For an arbitrary Galois cover preserving \(r>0\), \(\chi(E)=0\).
The [section-preserving theorem](section_preserving_galois_covers.md)
gives a characteristic normal prime-to-\(p\) subgroup and cyclic
\(p\)-quotient. A nontrivial Sylow subgroup preserves the sections
over its actual quotient, so the same parity argument makes \(r\) even.

## 3. Actual deck subgroups

For a nontrivial \(p\)-subgroup \(P\) of \(\operatorname{Deck}(T/C)\),
the free action gives the actual étale quotient \(T\to T/P\).
Its downstairs section dimension is
\(r=\dim H^0(T,h^*E)^P\ge1\), with the pulled-back symplectic form.
Section1 gives \(m\ge1+d(P)\) if \(r=1\); if \(r\ge2\), it gives
\(m\ge rd(P)\ge2d(P)\ge1+d(P)\). Thus \(d(P)\le m-1\).
For \(m=1\) there is no deck \(p\)-torsion; for \(m=2\), all its
\(p\)-subgroups are cyclic. Section5 gives the stronger odd-\(m\)
element-order bound. These use actual quotients, not closure monodromy.

## 4. The unique section has a quadratic character

If \(h\) is Galois with \(h^0(T,h^*E)=1\), its section
character \(\chi:G\to k^*\) is trivial exactly when \(h^0(C,E)=1\),
by descent. The character
line \(L\) has \(h^0(E\otimes L)=1\). Duality and \(\chi(E\otimes L)=0\)
give \(h^0(E\otimes L^{-1})=1\). Both pull back into the SAME
one-dimensional section space, with characters \(\chi,\chi^{-1}\);
hence \(\chi^2=1\). If downstairs has no section, its order is exactly two.
In this nontrivial case the actual quotient \(T/\ker\chi=C_L\) is
the distinguished double.
It has one section, and \(T\to C_L\) adds none. Section3 makes its
remaining degree prime to \(p\).

## 5. Odd blocks in the actual cyclic cohomology complex

### 5.1 The actual paired complex

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

### 5.2 Successive leading forms

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

### 5.3 Actual deck groups

For an element \(\gamma\) of order \(p^a\) in the deck group of a
connected finite étale cover \(T\to C\), the free action gives the
actual intermediate torsor \(T\to T/\langle\gamma\rangle\).
The bundle descends from C, and étaleness identifies the pulled-back
canonical lines. Apply the preceding result to this torsor. If m is
odd, it gives \(p^a\le m\). Cauchy's theorem proves the assertion when
\(m<p\). No common Galois closure or section-preservation hypothesis
has entered the argument.

## Evidence

The [first-socle audit](../../../Research/audits/FIRST_SOCLE_SECTION_FORMULA_AUDIT_2026_09_13.md)
and [cyclic-block audit](../../../Research/audits/FOCUSED_LOCAL_RETURNS_AUDIT_2026_09_16.md)
retain their original scopes. General p-group growth and quadratic
character arguments retain author-prose status; audited cyclic parity
is unchanged. This consolidation uses no new computation.

The same [focused integration review](../../../Research/audits/SYMPLECTIC_ALL_CYCLIC_TOWERS_INTEGRATION_AUDIT_2026_10_03.md)
checks the extraction and acyclic dependency direction, without replacing
the original scoped audits.
