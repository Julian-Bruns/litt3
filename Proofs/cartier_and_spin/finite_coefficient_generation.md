# Proof: finite coefficients and generation

This is the manually returned reduction, with focused author review.
The stable degree-one bundle K, its all-Picard-zero-twist vanishing,
and the six nonperiodicity conclusions are reused as established
inputs. The supplied [arithmetic verifier](../../scripts/arithmetic/pro_k_etale_symmetry.py)
executes without alteration; its
[output](../../../litt3-computation-data/finite_coefficients_contacts_20260923/k_symmetry_output.txt)
certifies only the arithmetic below, not the earlier Frobenius chains.

Let V be trivialized on a connected finite Galois etale cover and let
V->K be nonzero. A torsion-free image E is locally free and has
nonnegative degree, since it is a quotient of the semistable degree-zero
bundle V. A rank-one image would saturate to a nonnegative line in K.
Stability forces its degree to be zero, contrary to all-twist
vanishing. Thus E has rank two and degree zero or one.

Degree one means E=K. In degree zero, K/E is a skyscraper of length
one. On the same cover E is globally generated of degree zero, hence
trivial: two sections independent at one point have a determinant
section of degree zero, with no zeros. Thus E is an actual finite
etale coefficient. Two distinct such embedded images E,E' sum to K.
Indeed a proper sum would still have colength one, making E'=E.

The explicit F25-model and cubic linearization of K act on embedded
images by gamma and by coefficient conjugation sigma:c->c^25.
These operations preserve etale trivializability. This sigma is NOT
absolute Frobenius pullback. A jointly fixed image has quotient
supported at a cubic-fixed F25-point. Exact arithmetic gives
\[
\gcd(P,x^{25}-x)=(x-[9])(x-[14]),\qquad
P=(x-[9])(x-[14])(18,15,10,4,1)(8,2,21,11,1).
\]
The two quartics are irreducible. Including infinity, the only
possible supports are O,([9],0),([14],0). Cubic invariance makes the
fiber quotient one of its two distinct eigenquotients. Hence a jointly
fixed image is one of the six nonperiodic modifications.

An etale-trivializable bundle over the algebraic closure of F5 has
a strict absolute Frobenius return: on a finite Galois trivializing
cover its descent matrices have coefficients in some finite field,
and a power of Frobenius fixes them. Thus the six exclusions prohibit
a jointly fixed finite image. Every degree-zero finite image moves
under gamma or sigma; summing it with that conjugate generates K.
The fiber product of their etale trivializations is an allowed
trivializing cover. This proves the equivalence between a nonzero
finite-coefficient map and generation. A section on any cover can
be treated on its Galois closure and its equivariant evaluation
descended, proving the section formulation.

For an arbitrary finite representation take a composition series.
At the first term with a nonzero restricted map to K, that map factors
through a simple quotient R. Rank one is excluded as above. If R has
rank at least three and its image had degree zero, the quotient R->E
would be a quotient of finite representations: on a common connected
proper trivializing cover its matrix has constant entries. This
contradicts irreducibility. Hence R surjects onto K. If R has rank two,
its generic injection identifies it with its degree-zero image E,
and the conjugate-sum argument applies. No semisimplicity of the
starting representation is assumed.

Finally tensor the actual defining extension
0->O(-5O)->K->O(6O)->0 by R-dual. Semistability gives
H^0(R-dual(-5O))=0, identifying Hom(R,K) with the printed cup kernel.
Riemann--Roch gives target dimension13r. Neither this dimension nor
ampleness decides the kernel.
