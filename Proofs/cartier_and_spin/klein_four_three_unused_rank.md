# Proof of the three-unused-location bound

Work throughout in the actual word space of
[the statement](../../Theorems/cartier_and_spin/klein_four_three_unused_rank.md).
For 0<=d<=6, let W_d(C) consist of pairs
\[
F=2t^{22}T+F_{\rm low},\quad\deg T\le d,\quad
\deg F_{\rm low}\le15+d,\quad C\mid F.
\]
All coefficients of its defining equations lie in M=F_(25^7).
The established Fourier minors give dim W_d(C)=17+2d-deg C.
At an unused location a the actual word satisfies
\[
L_a(F,T):=F(a)-a^{22}T(a)=0. \tag{1}
\]
No unrelated curve coefficients are being specialized to M.

## The two-dimensional mixed evaluations have no triple collision

First consider deg C=15+2r,0<=r<=5, so dim W_r(C)=2.
Every functional L_a with a outside C is nonzero. For r=0 this
follows from the word(F,T)=(C,0). For r>=1, if L_a vanished identically,
choose a nonzero word with T(a)=0. Then F(a)=0 as well, and division
by t-a gives a nonzero word in W_(r-1)(C). This is impossible:
the lower Fourier code has dimension15+2r and cannot have that many
distinct prescribed zeros. Thus the mixed functionals have projective
directions.

The complete calculation shows that each direction occurs at most twice.
For r=0, write F=2CQ+C*b*T, Q=floor(t^22/C). Its direction at a is
determined by
\[
b(a)=a^{22}/C(a)-2Q(a).
\]
With J the14 complementary roots and h_j=(-1)^j e_j(J), use
\[
b(a)=\sum_{j=0}^{14}(j+1-2\mathbf1_{j\le7})h_j a^{7-j}.
\tag{2}
\]
This follows from C(a)=29a^28/J'(a). The full enumeration has240
two-node collisions in240 distinct subset orbits, so no triple.

For r>=1 use the established(r-1)-by(r+1) kernel in the coefficients
of T, with entries h_(8-2r+i+j). Its two basis words are
F=2C*floor(t^22*T/C). At a node a, multiply L_a by J'(a); the resulting
row on that basis is
\[
3a^{28}Q(a)-a^{22}T(a)J'(a),\qquad Q=\lfloor t^{22}T/C\rfloor.
\tag{3}
\]
The exact complete totals are
\[
\begin{array}{c|r|r|r|r}
r&\text{normalized subsets}&\text{orbits}&\text{mixed nodes}&\text{colliding pairs}\\
0&37442160&191280&2677920&240\\
1&21474180&128037&1536444&111\\
2&6906900&49478&494780&24\\
3&1184040&10645&85160&3\\
4&98280&1196&7176&0\\
5&3276&65&260&0.
\end{array}
\]
No row is zero and no direction occurs at three nodes. All node choices
are retained within each subset orbit. Normalizing by rotations and
Frobenius preserves proportionality of the mixed rows.

## Three mixed constraints on the four-dimensional word space

Now let deg C=13+2d and assume three distinct unused locations a,b,c.
Because deg C<=e<=26, d<=6, so the preceding ranges suffice.
The space W_d(C) has dimension four.

For d=0, its T=0 subspace consists of C times polynomials of degree<=2.
Evaluation at three distinct points outside C is invertible, so the
three L-functionals are independent.

For d>=1, suppose their rank were at most two. Their common kernel
would have dimension at least two. For each a choose a nonzero word
in that kernel with T(a)=0. Its F(a) also vanishes. Dividing both F,T
by t-a gives a nonzero word in W_(d-1)(C) killed by L_b and L_c.
Thus L_b,L_c are proportional on this two-dimensional lower space.
Repeating for b and c makes all three lower mixed directions the same,
contrary to the complete no-triple-collision result. Therefore their
rank is three, and the actual word space after these constraints has
dimension at most one over M.

## The forced first jet is rational over M

If the actual leading endpoint denominator B were zero, the established
first-jet identities would make both F and T divisible by t^2. For
d<=1 this is already impossible. For d>=2, division by t^2 gives a
nonzero word in W_(d-2)(C), whereas
\[
\deg C=13+2d>16+2(d-2),
\]
again exceeding the maximum number of zeros in that Fourier code.
Thus T(0)!=0. A nonzero actual word in the M-line just obtained has
\[
r=F(0)/T(0)\in M,\qquad
s=(F'T-FT')(0)/T(0)^2\in M.
\]
The actual endpoint field lemma permits this for at most one of the
three characters. The same conclusion for c=14+2d was proved by
the two-unused-location theorem. The uniform bound allows no larger c.
Hence at most one character has c>=13+2d when e<=26.

Writing the three nonnegative uniform slacks as
delta_i=14+2d_i-c_i, at least two are at least two. Therefore
\[
4\le\sum\delta_i=2(48+j-g),
\]
which proves g<=46+j.

For the more general constant-character assertion, its T=0 subspace
has dimension16-c, consisting of C times polynomials of degree<=15-c.
If c>=e-13, there are at least16-c unused locations. Their evaluations
on this subspace are independent Vandermonde equations. They leave
at most an M-line in W_0(C); the same nonzero-denominator argument
and endpoint field lemma apply. This property can therefore be combined
with the preceding characters, rather than counted independently.

## Evidence and checks

The complete sources are
[constant_mixed_rank.cpp](../../scripts/arithmetic/klein_four_constant_mixed_rank.cpp)
and [mixed_pencil_rank.cpp](../../scripts/arithmetic/klein_four_mixed_pencil_rank.cpp).
Compile with C++17; the latter takes the range `1 5`.
The [independent checker](../../scripts/arithmetic/check_klein_four_mixed_rank.py)
uses direct division of t^(22+i) by C and solves the opposite coefficient
system to reconstruct both basis words. It checks all378 exceptional
pairs, plus24 other kernels, for402 direct reconstructions in total.
Every pair is reproduced and no triple occurs. The complete coverage
is the separate C++ enumeration, not these bounded implementation checks.

Logs `constant_mixed_rank.log`, `mixed_pencil_rank.log` and
`mixed_rank_independent.json` are retained in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The direct checker explicitly handles empty polynomial quotients;
an initial missing guard was corrected before its completed run.
The profile script with `--three-unused` supplies the stated necessary
numerical relaxation. No resulting integer profile is asserted to be a curve.
