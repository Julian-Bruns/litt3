# Task 01: extract the profile-4 curve problem from a non-visible correspondence

## Status

Open. No retained argument explains why an arbitrary non-visible
self-correspondence produces degree \(35\), common reduced boundary, or the
single displayed incidence profile. The over-orbifold route does not supply
this extraction.

Work over \(k=\overline{\mathbb F}_5\).  Let
\[
  S=\mathbb P^1_k(31,31,31)
\]
be the stacky projective line with stabilizer order \(31\) at
\(0,1,\infty\).  The symmetric group \(S_3\) acts on \(S\) by permuting the
three stacky points.  Write
\[
  S_0=[S/S_3]\simeq \mathbb P^1_k(2,3,62)
\]
and let \(\pi_0:S\to S_0\) be the quotient map.

A finite étale self-correspondence of \(S\) means a connected smooth proper
Deligne–Mumford curve \(T\) with two representable finite étale maps
\[
  u,v:T\to S.
\]
Call it visible if \(\pi_0\circ u\simeq \pi_0\circ v\), equivalently if
\((u,v)\) factors through \(S\times_{S_0}S\), equivalently if
\[
  v\simeq\sigma\circ u
\]
for one fixed \(\sigma\in S_3\) on connected \(T\).

For a smooth proper connected curve \(C/k\), a separable function
\(h:C\to\mathbb P^1\) has profile \((31;4)\) if it has degree \(35\), all
ramification lies above \(0,1,\infty\), and for each
\(a\in\{0,1,\infty\}\),
\[
  h^{-1}(a)=31P_a(h)+E_a(h),
\]
where \(P_a(h)\) is one point and \(E_a(h)\) is reduced of degree \(4\).  For
one fixed \(h\), the three divisors \(E_0(h),E_1(h),E_\infty(h)\) are pairwise
disjoint.  Such a map has source genus \(11\), by Riemann-Hurwitz.

The target curve-level object is a triple \((C,x,r)\) where:

1. \(C/k\) is smooth, proper, connected of genus \(11\);
2. \(x,r\in k(C)\) are separable profile-\((31;4)\) functions;
3. \(k(C)=k(x,r)\);
4. the unramified boundary divisors agree as a reduced divisor
   \[
      U=E_0+E_1+E_\infty=F_0+F_1+F_\infty,
   \]
   where \(E_i=E_i(x)\) and \(F_j=E_j(r)\);
5. after possibly swapping \(u,v\), and composing one side by an \(S_3\)
   symmetry, the incidence matrix
   \[
      M_{ij}=\deg(E_i\cap F_j),\qquad i,j\in\{0,1,\infty\},
   \]
   is
   \[
      M=
      \begin{pmatrix}
      0&1&3\\
      1&2&1\\
      3&1&0
      \end{pmatrix}.
   \]

Prove the following theorem completely.

**Theorem.**  If there exists a non-visible connected finite étale
self-correspondence \(u,v:T\to S\), then there exists a curve-level triple
\((C,x,r)\) satisfying conditions 1--5 above.

This is a proposed bridge, not a known true theorem. A rigorous refutation is
also a valid outcome: exhibit the precise obstruction or counterexample, then
state the strongest corrected implication that the geometry supports. In
particular, do not assume that taking components, Galois closures, or
intermediate quotients preserves degree \(35\) or the displayed incidence
matrix.

Facts proved in the active global route and available without reproving:

- The cyclic curve \(Y:y^{31}=x(x-1)\) is a finite étale atlas of \(S\).
- \(S_0\simeq \mathbb P^1_k(2,3,62)\).
- Visible correspondences are exactly the \(S_3\)-graph correspondences.
- Standard Riemann-Hurwitz and tame stack-cover bookkeeping for
  \(\mathbb P^1(a,b,c)\).

Do not use internet search. The proof should be concrete: pass from the correspondence
to explicit function fields, inertia/orbit data, divisor profiles, and the
incidence matrix.
