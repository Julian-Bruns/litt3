# Degree-seven norms cannot vanish for actual etale maps to X

Version1,22September2026. Let $k$ be algebraically closed of
characteristic five and let $X$ be the smooth proper model of
$y^3=P(x)$, where $P$ is squarefree of degree ten.

There is NO degree-seven map $u:X\to\mathbf P^1$ whose every
branch fiber is complete and uniform: at any given target point,
all points in its fiber would have the same ramification index.
This assertion is independent of the coefficients of $P$.

Consequently, for any two actual finite etale maps of smooth proper
connected curves
\[
C\xleftarrow{\pi}T\xrightarrow{h}X,
\qquad\deg\pi=7,
\]
the norm homomorphism satisfies
\[
\boxed{h_*\pi^*:J(C)\longrightarrow J(X)\quad\text{is nonzero}.}
\]
Neither map is assumed Galois. In particular, no such span exists
if $\operatorname{Hom}(J(C),J(X))=0$. Etaleness of BOTH maps is
essential to this proof; a merely separable second map is not
covered by the statement.

For the FIXED genus-nine endpoint of the two common-cover
candidates, let $G$ be the Galois-closure group of an actual
genus-two leg. Then
\[
\boxed{|[G,G]|\ne7.}
\]
More generally, $G$ has no normal subgroup of order seven whose
quotient cover has no $J(X)$ isogeny factor. This extends the
existing derived-order exclusions $1,2,4,5$, with no bound on
$|G|$. It does not settle either unrestricted common-cover problem.

The geometric ingredient is a classification at the minimal
nontrigonal pencil degree. Under the uniformity assumption the
pencil has, after a target coordinate change, the form
\[
u=\frac{y-A(x)}{B(x)},\qquad
\deg A\le3,\quad \deg B=3,\quad B\mid P-A^3,
\]
where $B$ is squarefree and coprime to $P$. Its five totally
ramified points would give a polynomial identity contradicting
the characteristic-five polynomial $abc$ inequality.

[Proof](../../Proofs/quotient_geometry/degree_seven_uniform_norm_exclusion.md).
