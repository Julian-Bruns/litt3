# Genuine eight-label endpoint boundaries exclude rank three

Version 1, 30 September 2026. Consolidated finite endpoint boundary.

## Exact coefficient model

Write [a+5b]=a+b beta, with beta^2=beta+3 over F5. Put B=F25 and
K=B(xi)=F_(5^14), where xi has order 29 and
\[
xi^7+[24]xi^6+[7]xi^5+[21]xi^4+[20]xi^3+[7]xi^2+[22]xi+[4]=0.
\]
Use F=K(t)=F_(5^56), with t^4=[21], and pi the projection onto
<t,t^2,t^3>_K along K. These are the normalized coordinates of the
[original incidence](../../Research/requests/post_ten_hour_bridges_2026_09_29/01_rank_three_shared_moments.md).

An endpoint L is four genuine unordered phase pairs {j_i,k_i} in Z/29,
including repetitions. Set P_i(T)=T^(j_i)+T^(k_i) in
F5[T]/(T^29-1), and Q_l=sum_i 2^(li)P_i, for 0<=l<4. Its actual
rows C,E,U,V have coordinate r_l=h_l Q_l(xi^n), with this fixed table:

| Row | n | h_0 | h_1 | h_2 | h_3 |
|---|---:|---:|---:|---:|---:|
| C | 5 | [13] | [3] | [9] | [2] |
| E | 8 | [4] | [3] | [14] | 0 |
| U | 17 | [22] | [24] | [12] | [11] |
| V | 4 | [6] | [21] | [11] | 0 |

Full support means c_1,c_2,c_3 are nonzero. Phase span is
dim_F5<Q_1,Q_2,Q_3>, equivalently the affine dimension of the P_i;
it is not a rank over K. For a second endpoint write its rows D,G,W,Z
in the same order. Define the stacked matrix by the four columns
\[
R=((pi E,pi D),(pi C,pi G),(pi U,-pi V),(pi Z,-pi W)).
\]

## Boundary theorem

For any two genuine full-support endpoints, rank_K R=4 if any of these
conditions holds:

1. Either endpoint has phase span one.
2. Both endpoints have phase span at most two.
3. Either endpoint has four doubled pairs {a_i,a_i}.
4. Either endpoint has (u_3/c_3)^29 in B, using its own row coordinates.

Thus a remaining rank-three pair has spans 2/3 or 3/3, neither endpoint
has four doubled pairs, and both displayed ratios have 29th powers
outside B. These necessary restrictions do not exclude those remaining
sectors. Rank three alone supplies neither a scalar graph nor the SAME
two moments with the actual row constants, and coefficient solutions
would still not supply two actual finite etale maps from the same source.

The proof includes the general two-candidate relative symmetry filter.

[Proof, shared method and retained certificates](../../Proofs/cartier_and_spin/eight_label_rank3_endpoint_boundary.md).
