# Proof: conjugates of the source already generate the normal closure

[Statement](../../Theorems/cartier_and_spin/normal_closure_section_field.md).
Author /root,2026-09-08.

Put G=Gal(k(T)/k(C)), E=H0(T,q^*A), and let S be the subfield generated
by all ratios of nonzero sections in E. The canonical deck linearization
of q^*A makes E G-stable, hence S is G-stable. Pulling back sections
from Z shows k(Z) is contained in S. Therefore S contains every
G-conjugate of k(Z). These conjugates generate k(T), by the definition
of the normal closure. Thus S=k(T). Global generation persists under
pullback and enlargement to the full section space.

For the more general assertion, any G-stable intermediate field of a
finite Galois extension is Galois over the base. An element of G fixes
every section ratio exactly when its action on E is scalar. Indeed,
choose a basis e_i and write g(e_i)=sum_j a_ij e_j with a_ij in k.
The equal-ratio condition says the vector of section values is an
eigenvector of this constant matrix at the generic point. Its
eigenvalue is algebraic over k, hence in k. All e_i then lie in that
eigenspace as rational sections, so the matrix is scalar. This proves
the kernel assertion without any assumption that the section map is
an embedding.

For the application start with an actual common source whose complete
pulled-back spin series is base-point-free and birational.
At each new step the line is still the pullback of the spin on the
endpoint over which the normal closure is taken. The first assertion
therefore applies inductively. Normal closures of finite etale covers
remain finite etale, and composition with the other map preserves its
etaleness. Enlarging the ambient field does not alter the intersection
of the two fixed embedded endpoint fields. The common spin and section
are simply pulled back at each step.
