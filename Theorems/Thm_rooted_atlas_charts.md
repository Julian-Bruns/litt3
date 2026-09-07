# Reduced Frobenius-rooted incidence and exhaustive scale-free charts

Let k be algebraically closed of characteristic5. Fix coefficient tensors
N: k^m x k^m -> k^r and R: k^m x k^m -> k^m, bilinear in their
displayed inputs. Suppose the affine scheme

    X: N(U,b^[5])=0, R(U,b^[5])=b, U.b=2

is finite and reduced. Take coefficientwise fifth roots of N,R and call
the resulting bilinear tensors n,s. Then

    Xr: n(v,b)=0, b=s(v,b)^[5], v.s(v,b)=2

is finite reduced and (v,b)->(v^[5],b) is an isomorphism Xr->X.
This is not the raw Frobenius pullback, which can have nilpotents.

For j=0,...,m-1 define a chart by

    n=0;
    b_h=s_h=0 for h<j;
    b_j=s_j=1;
    b_h=s_h^[5] for h>j;
    w*(v.s)=1.

These finite reduced charts form exhaustive disjoint strata of Xr/mu3.
Every geometric chart point has exactly three normalized lifts to Xr.
The quotient charts impose v.s!=0, NOT v.s=2. Earlier b_h and selected
b_j may be eliminated by substitution; their s equations must be retained.
No direction at infinity is omitted. These statements descend to a perfect
coefficient field when the tensors are defined there.

Application: the audited compact atlas system satisfies the hypothesis.
For its first genus-nine tensor this gives32 disjoint charts; the known
genus-two positive example gives11 directions and33 normalized lifts.
No whole genus-nine oper or common cover is excluded by this theorem.

Status: author proof, main read the bounded fresh-agent proof; actual
positive example verified exactly. No separate major-chunk audit claimed.
[Proof](../Solutions/Sol_rooted_atlas_charts.md).
