"""New conceptual five-zero gate, no endpoint census or matrix replay."""
R.<D> = PolynomialRing(GF(5))
K = R.fraction_field()
A.<z> = PolynomialRing(K)
P = z^5 + z^4 - D
V = z^3-z^2+z
L = [A(1),z^4,V]
pairs = [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]
M = matrix(K,5,6,lambda i,j: ((L[pairs[j][0]]*L[pairs[j][1]])%P)[i])
print('rank', M.rank())
for v in M.right_kernel().basis():
    print('quadratic kernel', v)
    Q = matrix(K,3,3)
    for c,(i,j) in zip(v,pairs):
        Q[i,j] = c if i==j else c/2
        Q[j,i] = Q[i,j]
    print('determinant',Q.det().factor())
    assert M*v == 0
