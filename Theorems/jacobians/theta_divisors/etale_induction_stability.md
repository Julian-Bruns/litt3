# Generic stability under etale induction with moving line twists

Version2,16 September2026. The added converse, strong-stability and
finite comparison are proved in the appended argument.

Let X<-f-Z-g->Y be two actual finite etale maps of smooth projective
connected curves of genus at least2 over an algebraically closed
field of any characteristic. Suppose the span is jointly minimal:
k(X) and k(Y) generate k(Z) inside the given source field.

Let V be a vector bundle on X whose pullback to a connected Galois
closure of f is stable. Then \(V\otimes f_*g^*M\) is stable
for M in a nonempty open of J(Y).
In particular the statement holds for any V remaining
stable under all connected finite etale pullbacks. It needs no
prime-to-characteristic degree or monodromy hypothesis and no
Hom-zero or corelessness assumption.

For relative Frobenius B_C=F_*O_C/O_(C^(1)) in characteristic p>0,
both actual induced bundles
\[
B_X\otimes f^{(1)}_*g^{(1)*}M,\qquad
B_Y\otimes g^{(1)}_*f^{(1)*}L
\]
are therefore generically stable. Their ranks are (p-1)deg(f) and
(p-1)deg(g), and slopes g(X)-1 and g(Y)-1 respectively. This
strengthens generic stability of the degree-zero pushforwards.

Stability does not assert a theta divisor or generic cohomology
vanishing for these special families. Both common-cover problems
remain unresolved.

## Joint minimality is exactly generic stability

Without assuming joint minimality in advance, let L_eta be the
geometric generic line of J(X) and E_eta=g_*f^*L_eta. Then
\[
E_\eta\text{ is stable}\quad\Longleftrightarrow\quad
k(Z)=k(X)k(Y).
\]
In positive characteristic, in the jointly minimal case E_eta is
strongly stable. The statement uses the geometric generic parameter,
not an asserted k-point in a countable intersection of opens. It
needs no nonhyperellipticity assumption on X. The statements with
the two legs exchanged hold as well.

## An algebraic square for the whole one-step comparison

Work in characteristic p>0 and use the Frobenius twists of the span.
Suppose it is jointly minimal and m=deg(g)>1. Over an algebraic
closure Omega of k(J(X^(1))), put E_eta=g^(1)_*f^(1)*L_eta and
S=J(Y^(1))_Omega. There are algebraic vector bundles U_eta,V_eta
on S, both of rank m(g(Y)-1), and a morphism phi_eta such that
\[
0\to H^0(B_Y\otimes E_\eta\otimes M)
\to (U_\eta)_M\xrightarrow{(\phi_\eta)_M}(V_\eta)_M
\to H^1(B_Y\otimes E_\eta\otimes M)\to0
\]
for every geometric M in S. In particular, the actual generic mixed
defect is the generic corank of this ONE algebraic matrix. When
g(Y)=2 its size is exactly m. This does not assert that its
determinant is nonzero; generic stability alone does not supply
the required rank.

[Proof](../../../Proofs/jacobians/theta_divisors/etale_induction_stability.md).
