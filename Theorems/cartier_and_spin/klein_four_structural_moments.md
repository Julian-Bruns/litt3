# Structural reductions for the fixed coefficient moment problem

Version2, 30 September2026. These are coefficient statements. Work in
an algebraic closure of F5. The code [a+5b] denotes a+b beta, where
beta^2=beta+3 and 0<=a,b<5; rows ascend. Choose a root alpha of
A=(1,21,14,22,13), put K8=F25(alpha), K=F_(5^14), K+=F_(5^7),
and bar(x)=x^(5^7) on K. In the alpha basis put
b=(21,19,20,22), c=(22,7,9,23), e=(1,3,8,15), and eta=[22].
For a pair (i,xi), 0<=i<4, xi in mu29, its B-label is b^(25^i)xi,
its C-label is c^(25^i)xi^5, and its E-label is e^(25^i)xi^8.
Each of Q,H is a four-label multiset, with repetitions retained.
Write C(Q),E(Q),C(H),E(H) for the respective sums. A multiset is
balanced if it uses all four types i once, with one common phase.

For integer weights m_z in {0,1,2,3,4,6} at z in mu29, put
M_j=sum_z m_z z^j and m=sum_z m_z. Assume epsilon is nonzero and
the two coefficient identities hold:
\[
\epsilon(E(Q)-\eta M_{-2})=C(H)-\eta M_{-6},\qquad
\epsilon(C(Q)-\eta M_6)=E(H)-\eta M_2.
\]
No curve, map, inertia or pole profile is a hypothesis.

1. If epsilon belongs to K, both multisets must be balanced. Neither moment equation may
be used to assume this subfield condition without proof.
2. For any specified pair of endpoint multisets, the moment determinant
is a scalar quadric on the solution space of a seven-by-four linear
system over K+. The variables are the two coordinates each of
x=M2 and y=M6 in K/K+. All zero-vector and zero-scale boundaries
are retained when recovering epsilon.
3. Given x,y and total mass modulo5, all29 residue weights are uniquely
recovered by inverse Fourier transform. If their integer representatives
have sum r and exactly o of them are1, an allowed lift to weights
{0,1,2,3,4,6} of total mass m exists exactly when
(m-r)/5 is an integer in[0,o]. This does not impose inertia or
the nonlinear endpoint identities.
4. In the complementary-double-label sector defined in the proof,
every moment solution has residue mass at least37. That minimum is
attained by an allowed weight vector of total mass37 and a scale
epsilon outside K. Thus the two identities alone do not force the
subfield premise in assertion1.

Residue mass means the sum of the representatives in {0,1,2,3,4}.
These reductions and their exact sector example assert no actual
curve, map or common-cover decision.

[Proof and evidence](../../Proofs/cartier_and_spin/klein_four_structural_moments.md).
