# Proof: test the annihilator with a prescribed(p-1)-jet

[Statement](../Theorems/Thm_cartier_jet_tensor_surjectivity.md).
The Frobenius coefficient twists affect scalar semilinearity, not the
vanishing or rank argument below.

By Serre duality an annihilator of the tensor image is a section

    s in H0(V tensor K^vee tensor omega),

viewed as a homomorphism K->V tensor omega. For a in A, contraction
with a and transport by j^-1 gives

    w_(s,a) in H0(F_C^*V tensor omega).

The sign from dualizing the extension has no effect on its vanishing.
The dual of the Frobenius map H1(V^vee)->H1(F_C^*V^vee) is the
V-valued Cartier trace. In local frames it acts coefficientwise on
differentials. Thus s annihilates the entire tensor iff

    Cartier_V(w_(s,a))=0       for every a in H0(V^vee M).   (1)

This use of Cartier trace is not ordinary function-field trace, which
would vanish for a purely inseparable extension. One can verify the
duality directly by the residue identity

    Res(f^p eta)=(Res(f Cartier(eta)))^p.

Apply it componentwise to local cocycles for V^vee and sum residues;
the perfect Serre pairing proves the equivalence (1).

Fix a point P where the jet evaluation in the hypothesis is onto,
a uniformizer t, and regular local frames for V,M and their pullbacks.
Write w_(s,a) in the pulled-back V frame as

    sum_j (sum_i a_i(t) b_ij(t)) e_j dt.

The matrix b(t) is obtained from s by invertible local frame changes
and j, so b(P)=0 iff s(P)=0. For each i choose a GLOBAL section a whose
local coefficient row is t^(p-1)e_i modulo t^p. Jet surjectivity supplies
this section, not just a formal germ. The value of its Cartier image
at P is the row of pth roots of b_ij(P): Cartier retains the coefficient
of t^(p-1)dt. Equation (1) therefore forces every b_ij(P)=0.
Thus s vanishes on a dense open, hence identically. Its annihilator is
zero and the finite-dimensional tensor map is surjective.

For the intrinsic rank-two setup write n=g-1. The determinant identity
gives V^vee M~=V omega. The obstruction to evaluation on pP is

    H1(V omega(-pP))^vee = H0(V^vee(pP)).

The latter bundle is stable of slope p-n. If n>=p it has no section:
for negative slope this is immediate, and at slope zero a nonzero
section would saturate to a line subbundle of degree>=0, contradicting
stability of the rank-two bundle. Evaluation is consequently onto at
EVERY P. At p=5 this proves the claimed uniform rank statement.

The theorem does not say the affine atlas equations have a solution.
It says the constant annihilator which reduced the genus-two example
is forced to disappear in these genera, whether or not an atlas exists.
