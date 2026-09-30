# Independent Sage polynomial arithmetic for the degree-seven trace test.
F5 = GF(5)
Z.<z> = PolynomialRing(F5)
F.<beta> = GF(25, modulus=z*z-z-3)
R.<x> = PolynomialRing(F)
decode = lambda r: R([F(c % 5)+F(c // 5)*beta for c in r])
encode = lambda c: int(c[0])+5*int(c[1])
P = decode([11,22,18,5,19,20,15,16,9,22,1])
Q = decode([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])
B = decode([8,14,19,2,10,19,3,24,18,16])
assert (Q-B^5) % (P^2) == 0
M = matrix(F, 3, 3, lambda i,j: ((x^j*B) % P)[i+7])
assert M.det() == 3+4*beta
N = matrix(F, 2, 4, lambda i,j: ((x^j*B) % P)[i+8])
expected = matrix(F, [list(decode(row))+[F(0)]*(4-len(decode(row).list()))
                     for row in [[1,0,18,20],[0,1,15,11]]])
assert N.rank() == 2 and expected.rank() == 2 and N*expected.transpose() == 0
print('PASS independent Sage determinant:', encode(M.det()))
print('PASS degree-nine necessary matrix:', [[encode(t) for t in row] for row in N])
print('PASS degree-nine kernel:', [[encode(t) for t in row] for row in expected])
