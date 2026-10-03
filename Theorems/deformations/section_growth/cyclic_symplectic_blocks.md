# Symplectic sections on prime-power covers

Version2,2026-10-03. The first-socle and cyclic-block audits retain
their scoped conclusions; the other growth arguments retain author status.

Let \(C\) be a smooth proper connected curve in odd characteristic \(p\),
and let \(E\) have a perfect alternating pairing \(E\otimes E\to\omega_C\).
No stability, genus or ordinariness hypothesis is needed.

## Section growth and actual deck groups

For this part the ground field is algebraically closed. Put \(r=h^0(C,E)\).

1. For a connected finite étale Galois cover \(h:T\to C\) with nontrivial
   \(p\)-group \(P\), set \(d=\dim_{\mathbf F_p}\operatorname{Hom}(P,\mathbf F_p)\).
   Its first socle bundle is
   \(0\to\mathcal O_C\to\mathcal F_C\to\mathcal O_C^d\to0\).
   Let \(B_i\) be its alternating cup forms on \(H^0(E)\), and
   \(R=\bigcap_i\operatorname{rad}(B_i)\). Then
\[
h^0(T,h^*E)\ge h^0(E\otimes\mathcal F_C)=rd+\dim R.
\]
   Thus \(r=1\) gives at least \(1+d\) sections. Preservation of any
   \(r>0\) forces \(P\) cyclic and \(r\) even.

2. Every nontrivial connected finite étale cover with \(p\)-group
   Galois closure increases an odd \(r\), and preserves \(r=0\).
   Such a cover never has exactly one section upstairs.

3. For any connected finite étale \(h:T\to C\) with
   \(m=h^0(T,h^*E)>0\), each nontrivial \(p\)-subgroup of its
   ACTUAL deck group has \(d(P)\le m-1\). In particular \(m=1\)
   excludes deck \(p\)-torsion, and \(m=2\) forces those subgroups cyclic.

4. A Galois cover preserving \(r>0\) has a characteristic normal
   prime-to-\(p\) subgroup with cyclic \(p\)-power quotient. If \(p\)
   divides its degree, \(r\) is even. Whenever \(m=1\), the section
   character has order at most two, and is trivial exactly when \(r=1\).
   If \(r=0\), it is nontrivial quadratic and the cover
   factors through its distinguished étale double \(C_L\to C\),
   \(h^0(E\otimes L)=1\), and \(T\to C_L\) has prime-to-\(p\)
   degree and adds no sections.

## Full cyclic block parity

This part holds over ANY field \(k\) of odd characteristic \(p\).
Let \(q:D\to C\) be a torsor for the constant cyclic group
\(\langle\gamma\rangle\) of order \(N=p^a\), \(a\ge1\). Write
\[
H^0(D,q^*E)=\bigoplus_{j=1}^{N}
       (k[t]/(t^j))^{b_j},\qquad t=\gamma-1.
\]
Every odd \(j<N\) has even \(b_j\). No parity restriction is asserted
for the free summands \(b_N\). Consequently an odd total section
dimension is at least \(N\).

For ANY connected finite étale cover, every \(p\)-power-order element
of its actual deck group has order at most the upstairs section
dimension \(m\), if \(m\) is odd. Thus every odd \(m<p\) excludes
deck \(p\)-torsion, including \(m=3\) in characteristic five.
This does not bound the monodromy of a non-Galois cover: passing
to its Galois closure can add sections.

[Proof](../../../Proofs/deformations/section_growth/cyclic_symplectic_blocks.md).
