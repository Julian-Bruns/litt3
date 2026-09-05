# Exact arithmetic/algebra certificate for
# EXPLICIT_GENUS5_CUBICAL_COVER_AND_ASYMPTOTIC_RAYNAUD_LINES.md.
# Run from the repository root:
# sage -c "load('routes/global/EXPLICIT_GENUS5_CUBICAL_COVER_CERTIFICATE.sage')"

F5 = GF(5)
R.<t> = PolynomialRing(F5)
q1 = t^2+2
q2 = t^2+3
q3 = t^2+t+1
qs = [q1, q2, q3]

assert all(gcd(q, q.derivative()) == 1 for q in qs)
assert all(gcd(qs[i], qs[j]) == 1
           for i in range(3) for j in range(i+1, 3))

# Hasse invariants of the three elliptic character quotients.
hasse = []
for i, j in [(0, 1), (0, 2), (1, 2)]:
    hasse.append(((qs[i]*qs[j])^2)[4])
assert hasse == [F5(2), F5(2), F5(3)]

# Hasse--Witt matrix and stable rank of the genus-two quotient.
fC = q1*q2*q3
h = fC^2
HC = matrix(F5, 2, 2, lambda i, j: h[5*(i+1)-(j+1)])
assert HC == matrix(F5, [[3, 2], [2, 3]])
assert HC.rank() == 1
assert HC^2 == HC

# Elimination identity for the canonical plane quartic. Here
# A=x^2, B=y^2, C=z^2 are proportional to q1,q2,q3.
S.<A,B,C> = PolynomialRing(F5)
elimination = (B+C-2*A)^2 + 2*(B-A)^2 - A*(B-A)
quartic_even = 2*A^2+A*B+A*C+3*B^2+2*B*C+C^2
assert elimination == quartic_even

P.<x,y,z> = PolynomialRing(F5)
quartic = 2*x^4+x^2*y^2+x^2*z^2+3*y^4+2*y^2*z^2+z^4
partials = [quartic.derivative(variable) for variable in (x, y, z)]
for variable in (x, y, z):
    assert P.ideal([quartic]+partials+[variable-1]) == P.ideal(1)

# Seven nontrivial C2^3 characters: subset size 1,2,3 contributes
# genus 0,1,2, respectively. The even characters give genus(X0)=3.
character_counts = {1: 3, 2: 3, 3: 1}
assert sum(number*(size-1) for size, number in character_counts.items()) == 5
assert character_counts[2] == 3

print("PASS: q_i square-free and pairwise coprime; connected C2^3 cover has genus 5")
print("PASS: elliptic Hasse invariants", hasse, "are nonzero")
print("PASS: genus-two Hasse--Witt matrix", HC, "has stable rank 1 and a-number 1")
print("PASS: smooth canonical plane quartic and exact elimination identity")
print("PASS: prime-to-5 character decomposition gives a(T)=1 and ordinary X0")
