# Proof of abstract finite eight-dimensional tuple existence

This proves the [statement](../../../Theorems/quotient_geometry/local_actions/actual_eight_dimensional_finite_tuple_existence.md).
All matrix identities below are in \(\mathbf F_5\). The
[independent eight-item audit](../../../Research/audits/OCT03_EIGHT_TUPLE_FULL_GENERATION_AUDIT_2026_10_03.md)
checked the fixed inputs with its own elimination and matrix arithmetic;
it did not import or run the producer verifier or replay discovery.

## Exact matrices and local classes

Use \(U,X,A,S,B,C\) displayed in the statement. Direct multiplication gives
\[\det A=\det B=\det C=1,\quad A^5=B^5=I,
\quad AB=S,\quad S^2=3I,\quad C^2=2I.\]
For \(N_A=A-I\) and \(N_B=B-I\), elimination gives
\[(\operatorname{rank}N_A^i)_{i=1}^5
=(\operatorname{rank}N_B^i)_{i=1}^5=(6,4,2,1,0).\]
The numbers of blocks of length at least \(i\) are successive rank
differences, starting with \(\operatorname{rank}N^0=8\).
They are \((2,2,2,1,1)\), giving exactly \(J_5\oplus J_3\).
The nonzero fourth powers show exact order five.

The polynomial \(x^2-2\) has distinct roots \(\pm\lambda\) in
\(\mathbf F_{25}\). Solving the eigenvector equations for the scalar
off-diagonal blocks of \(S\), or of \(C=S^{-1}\), gives a four-dimensional
eigenspace for each root of the corresponding quadratic. For \(C\) the
roots satisfy \(\lambda^2=2\), so \(\lambda^4=4=-1\), and both have exact
order eight. Its projective square is the identity and \(C\) is not scalar.
Thus the projective tuple has orders \(5,5,2\) and product one.

## A transvection in the generated group

Put \(H=\langle A,B\rangle\). In literal words use \(a=A^{-1}\) and
\(b=B^{-1}\). The fixed word
\[w=AAbAbb=A^2B^{-1}AB^{-2}
\]
has exact order \(15620=4\cdot5\cdot11\cdot71\). The certificate checks
\(w^{15620}=I\) and nonidentity for the exponent divided by each of the
distinct primes \(2,5,11,71\), which proves exactness also for the factor
\(2^2\). Its 3124th power is
\[\tau=w^{3124}=I+v\phi,\qquad
v=(3,0,3,3,2,4,4,0)^{\mathsf T},\qquad
\phi=(1,4,3,2,4,1,0,0).
\]
Since \(v,\phi\ne0\) and \(\phi(v)=0\), this is a nonidentity rank-one
transvection in \(H\).

## The full finite-field transvection star

For a word \(g\), let \(v_g=gv\), \(\phi_g=\phi g^{-1}\), and
\(\alpha_g=\phi(v_g)\). If \(\phi_g(v)=0\), multiplying the four
rank-one factors gives the literal commutator identity
\[[\tau,g\tau g^{-1}]
=\tau(g\tau g^{-1})\tau^{-1}(g\tau^{-1}g^{-1})
=I+v(\alpha_g\phi_g).
\]
Indeed with \(N=v\phi\) and \(M=v_g\phi_g\), one has
\(N^2=M^2=MN=0\), \(NM=v\alpha_g\phi_g\), and all products of length
three vanish. This proves the displayed sign and order of multiplication.

The following exact seven words satisfy those hypotheses:

| \(g\) | \(\alpha_g\) | \(\alpha_g\phi_g\) |
|---|---:|---|
| \(aB\) | 1 | \((3,3,2,2,4,4,0,1)\) |
| \(BBa\) | 1 | \((3,2,1,3,4,1,3,0)\) |
| \(AAb\) | 1 | \((2,1,1,0,1,2,4,4)\) |
| \(AbAA\) | 1 | \((2,0,1,1,3,0,3,4)\) |
| \(ABBA\) | 1 | \((2,1,4,1,4,4,0,1)\) |
| \(BAbA\) | 4 | \((3,2,1,4,1,2,4,1)\) |
| \(aBBAA\) | 2 | \((1,2,1,0,1,0,3,3)\) |

The rows annihilate \(v\) and have rank seven; they therefore form a basis
of \(\operatorname{Ann}_{\mathbf F_5}(v)\). Products and powers of the
commutators satisfy
\[(I+v\psi)(I+v\eta)=I+v(\psi+\eta),\qquad
(I+v\psi)^t=I+v(t\psi).
\]
Consequently \(H\) contains every \(I+v\psi\) with an \(\mathbf F_5\)-valued
functional \(\psi\in\operatorname{Ann}_{\mathbf F_5}(v)\). Parameters in
the algebraic closure are not being included in this finite subgroup.

## Eight directions give all elementary roots

For the fixed words
\[(g_1,\ldots,g_8)=(1,A,B,a,b,AA,BA,bA),
\]
the columns \(g_i v\) form a basis. Write \(Q\) for the matrix of those
columns and \(\ell_j\) for its dual rows. For \(i\ne j\), the functional
\(\ell_jg_i\) annihilates \(v\), so the preceding star supplies
\(I+v(\ell_jg_i)\). Conjugation by \(g_i\) gives
\[I+(g_i v)\ell_j=Q(I+E_{ij})Q^{-1}\in H.
\]
For each of all 56 ordered pairs the verifier solves the seven star
coefficients and multiplies the corresponding group expression, checking
this equality directly. Powers give \(Q(I+tE_{ij})Q^{-1}\) for every
\(t\in\mathbf F_5\).

Elementary row operations reduce an invertible determinant-one matrix to
a determinant-one diagonal. Such a diagonal is also an elementary product:
on two coordinates, with \(e_{ij}(t)=I+tE_{ij}\), put
\[w_{ij}(t)=e_{ij}(t)e_{ji}(-t^{-1})e_{ij}(t).
\]
Then \(w_{ij}(t)w_{ij}(-1)\) is \(\operatorname{diag}(t,t^{-1})\) on those
coordinates and identity elsewhere. Pairing diagonal entries reduces every
determinant-one diagonal to such products. Thus the elementary roots
generate \(SL_8(\mathbf F_5)\). Conjugation by \(Q\in GL_8(\mathbf F_5)\)
preserves that group. Since \(H\subseteq SL_8(\mathbf F_5)\), this proves
\[H=\langle A,B\rangle=SL_8(\mathbf F_5).
\]
No finite-group classification or genericity assertion enters this proof.

## Internal inverse conjugacy

The explicit matrix
\[P=\begin{pmatrix}
3&0&2&0&4&2&3&0\\
4&1&0&4&0&3&1&4\\
4&3&1&3&0&4&4&2\\
4&2&0&0&0&0&0&3\\
3&3&2&2&0&1&3&0\\
1&2&4&2&0&1&3&1\\
3&0&0&2&0&1&0&4\\
1&1&2&3&0&4&3&2
\end{pmatrix}
\]
satisfies \(\det P=1\) and \(PA^{-1}P^{-1}=B\). These identities are checked
directly, without using a generic Jordan-form argument. The full-generation
proof places this SAME \(P\) inside \(H\), establishing internal inverse
conjugacy. The projective images inherit it.

## Exact multiplier and finite projective quotient

Commuting with all elementary roots forces a matrix to be scalar. Thus
\(Z(H)=\mathbf F_5^\times I=\mu_4\), which is exactly the kernel of the
natural map \(H\to PGL_8(k)\). Its image is \(G=PSL_8(\mathbf F_5)\).
Any character \(H\to k^\times\) kills \(A\) and \(B\), since \(k^\times\)
has no nonidentity element of order five. It is therefore trivial.
The low-degree central-extension sequence consequently injects
\[\operatorname{Hom}(\mu_4,k^\times)\hookrightarrow H^2(G,k^\times).
\]
The natural multiplier is the transgression of the faithful scalar
character, or its inverse according to cocycle convention. Injectivity
proves EXACT order four. This uses the actual matrix extension, without
any labeled geometric group or descent assumption. A quotient of \(G\)
of order prime to five kills the images of both order-five generators,
and is therefore trivial.

## Irreducibility, primitivity and tensor restrictions

If a nonzero \(k\)-subspace is \(H\)-invariant, choose a vector in it with a
nonzero \(j\)th coordinate. Applying \(I+E_{ij}\) and subtracting the vector
gives the \(i\)th coordinate vector, for \(i\ne j\). The remaining elementary
roots then give every coordinate vector. This proves absolute
irreducibility.

A nontrivial equal-block system has two, four, or eight blocks. The
order-five generators cannot permute two or four blocks, making every
block invariant, contrary to irreducibility. On eight lines an order-five
monomial matrix has permutation identity or one five-cycle with three
fixed lines. In the identity case it is identity, since diagonal scalars
of order five in \(k\) are trivial. In the five-cycle case rescaling its
line basis makes that cycle the usual permutation cycle, whose type in
characteristic five is \(J_5\); the other lines give \(3J_1\). This
contradicts the type \(J_5\oplus J_3\) of \(A\), proving primitivity.

A nonidentity rank-one transvection cannot be a tensor \(X_1\otimes X_2\)
with both factor dimensions at least two. All products of eigenvalues
would be one, so each factor has just one eigenvalue. Scalar-normalizing
the factors makes them unipotent without changing the tensor product.
If exactly one is nonscalar, the deviation rank is its positive deviation
rank times the other dimension, hence at least two. If both are nonscalar,
each has an invariant two-dimensional Jordan-chain subspace restricting
to \(J_2\). On their tensor product the deviation of \(J_2\otimes J_2\)
has rank two in characteristic five: on a basis \(e_1,e_2\) with
\(Ne_2=e_1\), its image contains \(e_1\otimes e_1\) and
\(e_1\otimes e_2+e_2\otimes e_1+e_1\otimes e_1\). Restriction rank is
a lower bound for ambient rank. Both cases contradict rank one for
\(\tau\in H\).

In dimension eight the only additional tensor-factor permutation case is
three two-dimensional factors. The induced map to \(S_3\) kills both
order-five generators and is trivial. Grouping two factors reduces to the
excluded \(2\otimes4\) case. Thus tensor indecomposability includes factor
permutations.

## Forms

A preserved line of nonzero bilinear or \(5^r\)-Frobenius-sesquilinear forms
defines a similitude character of \(H\). It is trivial by the character
argument above. But \(3I\in H\) acts on the form by \(3^2=4\), or by
\(3^{5^r+1}=4\), respectively. This contradicts its being invariant.
The argument excludes even degenerate nonzero forms; no classification
of form-preserving subgroups is needed.

## Exact evidence and scope

The [standalone standard-library verifier](../../../scripts/genus_two/oct03_eight_tuple_verify.py)
is run by
`python3 scripts/genus_two/oct03_eight_tuple_verify.py --output ../litt3-computation-data/oct03_ten_hour/eight_tuple_verified.json`.
It uses fixed inputs and no search. Its SHA256 is
`739266625d2836bfda6b80d2ffd46a1122acec41d98bc5ae261bb36f3ccd20cc`.
The [external certificate](../../../../litt3-computation-data/oct03_ten_hour/eight_tuple_verified.json)
contains all displayed matrices, seven stars, the basis, 56 root coefficient
rows and \(P\). The producer check passed in a single process in 0.049 seconds
with Python 3.14.7.

The fresh independent audit checked the note frozen at SHA256
`4a0cd81dd9beebdbb7bed29183399816527ffde9aab488ee0db1ec814380c54b`.
Its [independent source](../../../../litt3-computation-data/oct03_eight_tuple_independent_audit_2026_10_03/independent_verify.py)
and [output](../../../../litt3-computation-data/oct03_eight_tuple_independent_audit_2026_10_03/verification.json)
record one serial run, all checks passed, in 0.054685458 seconds, with
five-second CPU and wall limits. The attempted macOS affinity tag returned
46; no hard CPU-core pin is claimed. The two later wording clarifications
concern only \(\mathbf F_5\)-valued star parameters and invariant
Jordan-chain subspaces. Numerical inputs and verifier were unchanged.

This proof has no source-geometry dependency. It establishes finite
representation nonemptiness, not a weak cyclic curve, an original
canonical line, an original spin carrier, or either of the two finite
étale endpoint maps from the SAME source. The unmarked common-cover
problem remains UNSOLVED.
