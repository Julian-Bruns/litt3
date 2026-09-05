# Conductor Frobenius is not determined by contacts or differential ratios

Date: 2026-09-05.
Author: `/root/gluing_cohomology_rigidity`.
Status: direct local proof plus exact scalar-F5 regression computation;
not independently audited. No global realization or theta conclusion
is claimed. Earlier files are unchanged.

## 1. A same-contact, same-derivative counterexample

Work over \(k=\overline{\mathbf F}_5\). For \(\epsilon=0,1\), consider
the three branches
\[
 \phi_1=x,\qquad \phi_2=x+x^4,\qquad
 \phi_3=x+2x^4+\epsilon x^5,
\]
and put
\[
 R_\epsilon=k[[x,y]]/
       \left(\prod_{i=1}^3(y-\phi_i(x))\right),\qquad
 \widetilde R=\bigoplus_{i=1}^3k[[x]],\qquad
 Q_\epsilon=\widetilde R/R_\epsilon.
\]
All branches are smooth and étale over both original coordinates:
\[
 \phi_1'=1,\qquad \phi_2'=1+4x^3,\qquad \phi_3'=1+3x^3.
                                                               \tag{1.1}
\]
In particular, **the three full derivative series, and hence every
ratio \(\phi_j'(x)/\phi_i'(x)\) in the common X-coordinate, are
identical for both models**.
The \(x^5\) perturbation differentiates to zero.

Every pairwise contact is 4, so both models also have
\[
 m_{12}=m_{13}=m_{23}=4,\qquad c_1=c_2=c_3=8,
 \qquad\dim_k Q_\epsilon=\delta=12.                       \tag{1.2}
\]
Nevertheless, for the semilinear Frobenius \(F\) induced on \(Q\),
\[
 \begin{array}{c|ccc|cc}
 \epsilon&\operatorname{rank}F^0&\operatorname{rank}F&
              \operatorname{rank}F^2&\dim\ker F&\dim\ker F^2\\
 \hline
 0&12&3&2&9&10\\
 1&12&4&2&8&10
 \end{array}                                               \tag{1.3}
\]
Rank 2 is stable in both cases. Thus neither the contact orders nor
those orders together with all differential-ratio functions determine
the Frobenius kernel sequence on the normalization quotient.

### Direct proof, independent of the script

The conductor contains \(\bigoplus_i x^8k[[x]]\). Thus we may compute
exactly in \(V=(k[x]/x^8)^3\). Use \(w=y-x\) only as an auxiliary ring
generator; the two original étale coordinate maps remain \(x,y\).
The image \(S_\epsilon\) of \(R_\epsilon\) in \(V\) is
\[
 S_\epsilon=
 \{a(x)(1,1,1)+h(x)(0,x^4,2x^4+\epsilon x^5):
             \deg a<8,\ \deg h<4\}.                      \tag{1.4}
\]
Indeed \(1,w,w^2\) generate \(R_\epsilon\) over \(k[[x]]\), and
\(w^2\) evaluates to zero modulo \(x^8\). The two displayed subspaces
in (1.4) meet trivially, so \(\dim S_\epsilon=8+4=12\).

The fifth-power image of the ambient normalization jets is
\[
 U=\bigl(\operatorname{span}_k\{1,x^5\}\bigr)^3,
 \qquad\dim U=6.
\]
For a vector in (1.4) to lie in \(U\), its first coordinate forces
\(a=a_0+a_5x^5\). The second coordinate then forces \(h=cx\).
The third is
\[
                 a_0+(a_5+2c)x^5+\epsilon c x^6.
\]
Therefore \(\dim(S_0\cap U)=3\), whereas
\(\dim(S_1\cap U)=2\). Since \(F(S_\epsilon)\subset S_\epsilon\),
\[
 \operatorname{rank}(F\mid Q_\epsilon)
     =\dim U-\dim(U\cap S_\epsilon)=3\text{ or }4.
\]
The image of the twenty-fifth power on ambient jets is just \(k^3\);
its intersection with \(S_\epsilon\) is the diagonal \(k\), giving
\(\operatorname{rank}F^2=2\). This proves (1.3).

The same construction works for every prime \(p\ge5\), using
\(\phi=(x,x+x^{p-1},x+2x^{p-1}+\epsilon x^p)\).
Then \(\delta=3(p-1)\), the conductor cutoff is \(2p-2\), and the
first Frobenius ranks are again 3 and 4, with stable rank 2. In the
intersection calculation, the extra term has degree \(p+1<2p-2\).

## 2. What is determined by the branch data

For any reduced collision of \(r\) smooth graph branches over a perfect
field of characteristic \(p\), put
\[
 \delta=\sum_{i<j}m_{ij},\qquad
 c_i=\sum_{j\ne i}m_{ij},\qquad N=\max_i c_i.
\]
The branchwise conductor formula is recorded in
[the collision-divisor note](BIETALE_JOINT_IMAGE_COLLISION_DIVISOR_AND_NORMAL_LINE.md#2-every-singularity-is-a-collision-of-smooth-graph-branches).
There is a Frobenius-stable direct sum
\[
 Q\simeq (k^r/k)\oplus Q_+,
\]
where the first summand consists of branch constants modulo diagonal
constants, and \(Q_+\) is represented by tuples vanishing at the origin.
Frobenius is bijective on the first summand. It kills \(Q_+\) after
\(p^e\ge N\), because all branch exponents are then at least the
conductor cutoff. Hence
\[
 \dim Q_{\rm stable}=r-1,\qquad
 \dim Q_{\rm nil}=\delta-r+1.                             \tag{2.1}
\]
These two total dimensions are determined by contacts and branch count;
the intermediate kernel dimensions need not be.

For two branches of contact \(m\), there is the sharper exact formula
\[
 Q\simeq k[[x]]/(x^m),\qquad
 \operatorname{rank}F^e=\left\lceil\frac{m}{p^e}\right\rceil,
 \qquad
 \dim\ker F^e=m-\left\lceil\frac{m}{p^e}\right\rceil.      \tag{2.2}
\]
The isomorphism sends a branch pair to its difference modulo
\(\phi_2-\phi_1\), whose ideal is \((x^m)\), and commutes with
Frobenius. Thus coefficient dependence first appears with more than
two branches in the examples here.

## 3. Reusable finite-jet computation and checks

The small script
[MULTIGRAPH_CONDUCTOR_FROBENIUS_JETS.py](MULTIGRAPH_CONDUCTOR_FROBENIUS_JETS.py)
uses exact scalar arithmetic over \(\mathbf F_5\), with NumPy only for
array operations. Run

```sh
python3 routes/global/MULTIGRAPH_CONDUCTOR_FROBENIUS_JETS.py
```

Its public function `analyze(branches, p=5)` accepts exact polynomial
branch series. It forms the ring image using the generators
\(x^ay^j\), \(0\le a<N,0\le j<r\), modulo \(x^N\) on each branch.
This truncation is exact, not an experimental approximation: the
branch-supported polynomial
\(\prod_{j\ne i}(y-\phi_j(x))\) evaluates to a unit times \(x^{c_i}\)
on branch \(i\) and zero on the others, so the conductor contains
every branch-supported \(x^N\).

It computes
\[
 \operatorname{rank}(F^e\mid Q)
   =\dim\bigl((R_N+F^eV_N)/R_N\bigr),
\]
and asserts the exact dimension \(\dim Q=\delta\), Frobenius stability
of the ring image, the stable rank \(r-1\), the two-branch formula,
and both counterexample sequences. Although the matrices are over
\(\mathbf F_5\), their ranks give the semilinear ranks over
\(\overline{\mathbf F}_5\): the scalar Frobenius is an automorphism and
all matrix coefficients lie in the prime field.

The deterministic suite passes. Selected kernel sequences below start
with \(\ker F\), omitting \(\ker F^0=0\), and end at stability.

| Branch model | \(\delta\) | Kernel dimensions | Stable dimension |
|---|---:|---|---:|
| Transverse triple | 3 | 1 | 2 |
| Transverse quadruple | 6 | 3 | 3 |
| Two branches, contact 5 | 5 | 4 | 1 |
| Two branches, contact 25 | 25 | 20, 24 | 1 |
| Two branches, contact 125 | 125 | 100, 120, 124 | 1 |
| Triple \((x,x+x^5,x+2x^5)\) | 15 | 12, 13 | 2 |
| Same triple with \(x^6\) added to branch 3 | 15 | 11, 13 | 2 |
| Four branches with contacts \(m_{12}=25,m_{13}=m_{23}=5\), others 1 | 38 | 28, 34, 35 | 3 |

The suite also varies coefficients in the last mixed-contact cluster;
those particular variations give the same ranks. This is not an
invariance assertion for all coefficients with that cluster.

## 4. Exact scope for the global problem

The counterexamples are genuine reduced formal plane singularities
with both normalized local coordinate maps étale. They show that local
Frobenius cannot in general be reconstructed from the contact divisor
and canonical differential-ratio functions alone.

No realization as the joint image of a specified pair of global proper
étale maps is claimed. In particular, the calculation does not settle
restricted Raynaud-theta properness. It identifies extra local
coefficient information that a proposed Frobenius--collision argument
must retain.
