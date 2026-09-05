# Complete and presentation-compatible classification of finite over-orbifolds

## Status

Proved, using the results in files 15--18. This note assembles those results
and adds the uniqueness needed when the same target has two presentations.

Put

\[
 S=\mathbf P^1_k(31,31,31),\qquad
 S_0=\mathbf P^1_k(2,3,62),\qquad
 k=\overline{\mathbf F}_5,
\]

and let \(\pi _0:S\to S_0\) be the quotient by the permutations of the
three order-\(31\) points.

## Theorem

Let \(\mathcal O\) be a smooth proper connected Deligne--Mumford curve with
trivial generic stabilizer, and let

\[
                   f:S\longrightarrow\mathcal O
\]

be representable finite etale. Then:

1. \(\mathcal O\) is tame;
2. there is a representable finite etale map
   \(h:\mathcal O\to S_0\) and a 2-isomorphism
   \(hf\simeq\pi _0\);
3. the map \(h\) is unique up to a unique 2-isomorphism, independently of
   the presentation \(f\); and
4. \(\mathcal O\), together with \(h\), is one of the following four
   intermediate quotients:

\[
\begin{array}{c|c|c|c}
\deg f&\deg h&\mathcal O&\text{subgroup of }S_3\\ \hline
1&6&\mathbf P^1(31,31,31)&1\\
2&3&\mathbf P^1(2,31,62)&C_2\\
3&2&\mathbf P^1(3,3,31)&C_3\\
6&1&\mathbf P^1(2,3,62)&S_3.
\end{array}                                                   \tag{19.1}
\]

In particular, if \(f_1,f_2:S\rightrightarrows\mathcal O\) are two such
maps, one and the same map \(h:\mathcal O\to S_0\) satisfies

\[
                    hf_1\simeq\pi _0\simeq hf_2.              \tag{19.2}
\]

## Proof

Files 16 and 18 exclude respectively the weakly and non-weakly ramified
wild possibilities. Thus \(\mathcal O\) is tame.

File 17 proves the complex commensurator identity required in file 15.
The specialization theorem of file 15 therefore applies without a remaining
hypothesis and supplies a representable finite etale map

\[
                    h:\mathcal O\longrightarrow S_0,
                    \qquad hf\simeq\pi _0.                    \tag{19.3}
\]

The map \(\pi _0\) is a connected finite etale \(S_3\)-torsor of degree
six. The chosen 2-isomorphism in (19.3) makes \(\mathcal O\) an
intermediate object over \(S_0\). By the Galois correspondence for connected
finite etale covers, every such factorization is the intermediate quotient
by a subgroup
\(H\leq S_3\):

\[
                    \mathcal O\simeq[S/H],
                    \qquad \deg f=|H|,
                    \qquad \deg h=6/|H|.                      \tag{19.4}
\]

Up to conjugacy, the subgroups of \(S_3\) are

\[
                         1,\ C_2,\ C_3,\ S_3.
\]

It remains to compute the signatures. For \(H=C_2\), an involution fixes
one of the three order-\(31\) points and one ordinary point, and exchanges
the other two order-\(31\) points. Their images have inertia orders
\(62,2,31\), respectively. For \(H=C_3\), the three order-\(31\) points
form one orbit and the two fixed ordinary points have inertia order \(3\),
giving \((31,3,3)\). The cases \(H=1,S_3\) are the definitions of \(S\)
and \(S_0\). This proves the table.

We now prove uniqueness. Up to 2-isomorphism, the automorphism groups of
the four source orbifolds in (19.1) are

\[
\begin{array}{c|c}
\mathbf P^1(31,31,31)&S_3\\
\mathbf P^1(2,31,62)&1\\
\mathbf P^1(3,3,31)&C_2\\
\mathbf P^1(2,3,62)&1.
\end{array}                                                   \tag{19.5}
\]

Indeed, an automorphism of an effective three-point root stack is determined,
up to 2-isomorphism, by its coarse automorphism, which must preserve the
marked points and their orders. Here is a local check that there is no hidden
ghost automorphism. At an order-\(n\) point use the chart
\([\operatorname{Spec}k[[t]]/\mu_n]\), with coarse parameter \(t^n\).
An automorphism inducing the identity on the coarse disc has an invertible
linear term \(ct\). Equivariance forces its automorphism of \(\mu_n\) to be
the identity, and equality on the coarse parameter forces the map on the
disc to be \(t\mapsto\zeta t\), with \(\zeta^n=1\). This is 2-isomorphic
to the identity quotient-stack map. Away from the marked points the stack
is its coarse line, so these local 2-isomorphisms glue uniquely. Thus there
is no additional kernel, and preservation of the three marked orders gives
exactly the groups in (19.5).

Every automorphism in (19.5) lies over \(S_0\). For \(S\), this is the
defining \(S_3\)-invariance of \(\pi _0\). For
\(\mathbf P^1(3,3,31)\), the subgroup \(C_3\) is normal in \(S_3\), so
the degree-two map in (19.1) is Galois; its deck involution is precisely
the swap of the two order-\(3\) points. The other two automorphism groups
are trivial.

Now let \(h_1,h_2:\mathcal O\rightrightarrows S_0\) arise from two
factorizations. The corresponding subgroups \(H_1,H_2\leq S_3\) have the
same order, because

\[
 \deg K_S=(\deg f_i)\deg K_{\mathcal O}.
\]

Here \(\deg K_{\mathcal O}>0\), since its pullback under either \(f_i\)
is the positive-degree bundle \(K_S\), so cancellation is legitimate.
Subgroups of the same order in the above list are conjugate. Conjugation
therefore identifies the two standard intermediate quotients over \(S_0\).
Using the two identifications of \(\mathcal O\) with those quotients, we
obtain an automorphism \(\alpha\) of \(\mathcal O\) such that
\(h_1\simeq h_2\alpha\). Under the identification compatible with \(h_2\),
the calculation (19.5) says that every such \(\alpha\) lies over
\(S_0\), so \(h_2\alpha\simeq h_2\). Hence \(h_1\simeq h_2\).

Finally, this 2-isomorphism is unique. The argument of file 10 applies also
when the source is a Deligne--Mumford curve: pull two candidate
2-isomorphisms back to a smooth scheme atlas of \(\mathcal O\). Their ratio
is the identity over the dense generic locus because \(S_0\) has trivial
generic inertia; separatedness of the isomorphism sheaf makes it the
identity on the atlas, and hence on \(\mathcal O\).
This proves all assertions. \(\square\)

## Consequence for the remaining envelope gate

Suppose a self-correspondence \(u,v:\mathcal C\rightrightarrows S\) has a
connected finite etale refinement \(W\to\mathcal C\) for which the two
maps \(W\rightrightarrows S\) are Galois. Let their deck groups generate
the finite group \(H\leq\operatorname{Aut}(W)\), and put
\(\mathcal O=[W/H]\). The two quotient presentations give maps
\(f_1,f_2:S\rightrightarrows\mathcal O\). By (19.2), their composites with
the unique \(h:\mathcal O\to S_0\) agree with \(\pi _0\). Pulling back to
\(W\) gives a 2-isomorphism between the pullbacks of
\(\pi _0u\) and \(\pi _0v\). Its two pullbacks to
\(W\times_{\mathcal C}W\) agree: they are 2-isomorphisms between the same
dominant maps to \(S_0\), so the uniqueness argument above applies.
Effective finite-etale descent along \(W\to\mathcal C\) therefore gives

\[
                         \pi _0u\simeq\pi _0v.
\]

Thus the over-orbifold side of the global route, including compatibility
between two presentations, is complete. What remains is the separate
question whether an arbitrary self-correspondence has such a simultaneous
finite Galois refinement.
