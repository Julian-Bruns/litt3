# Odd block parity on cyclic prime-power covers

Version1, 16 September 2026. Bounded independent review passed.
This extends the returned characteristic-five assertion to
every odd prime and every cyclic prime-power degree.

Let k be a field of odd characteristic p, C a smooth proper
connected curve over k, and E a vector bundle with a
perfect alternating pairing \(E\otimes E\to\omega_C\). Let
\(q:D\to C\) be a finite étale torsor for the constant cyclic group
\(\langle\gamma\rangle\) of order \(N=p^a\), with \(a\ge1\).
Neither stability nor an ordinariness or genus hypothesis is needed.
Write
\[
H^0(D,q^*E)=
\bigoplus_{j=1}^{N}\bigl(k[t]/(t^j)\bigr)^{b_j},
\qquad t=\gamma-1.
\]
Then \(b_j\) is even for every odd \(j<N\). There is no asserted parity
restriction on \(b_N\), the number of free group-algebra summands.
In particular an odd section dimension is at least N.

More generally, let \(h:T\to C\) be any connected finite étale cover
and put \(m=h^0(T,h^*E)\). If m is odd, every p-power-order element
of the ACTUAL deck group of h has order at most m. If m is odd and
\(m<p\), that deck group has order prime to p. In particular, in
characteristic five a source with exactly three sections has no
five-torsion in its actual deck group. For a Galois cover this makes
the degree prime to five.

This gives no prime-to-p assertion about the Galois closure of an
arbitrary non-Galois cover: closure can add sections.

[Proof](../../../Proofs/deformations/section_growth/cyclic_symplectic_blocks.md).
