#!/usr/bin/env python3
"""Independent exact four-jet obstruction verifier; Python standard library only.

This uses a coefficient-by-coefficient 2x2 recurrence, NOT the sextic
elimination/Newton procedure used in explore.cpp. Certificates are compared
exactly. Use --write-certificate only to regenerate the pinned certificate.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from math import comb
import platform
import sys
from pathlib import Path
from time import perf_counter

ROOT = Path(__file__).resolve().parents[1]
ADD = tuple(tuple((a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)
                  for b in range(25)) for a in range(25))
MUL = tuple(tuple(((a % 5)*(b % 5) + 3*(a // 5)*(b // 5)) % 5
                  + 5 * (((a % 5)*(b // 5)+(a // 5)*(b % 5)
                          +(a // 5)*(b // 5)) % 5)
                  for b in range(25)) for a in range(25))
NEG = tuple((-a % 5) + 5 * (-(a // 5) % 5) for a in range(25))
INV = (0,) + tuple(next(b for b in range(1,25) if MUL[a][b] == 1)
                   for a in range(1,25))

class F:
    """E in t-major order internally; multiplication reduces t before alpha."""
    __slots__ = ("v",)
    amonic: tuple[int, ...] = ()
    def __init__(self, v: tuple[int, ...]):
        self.v = v
    @classmethod
    def code(cls, x: int) -> F:
        return cls((x,) + (0,)*27)
    @classmethod
    def prime(cls, x: int) -> F:
        return cls.code(x % 5)
    @classmethod
    def basis(cls, alpha_power: int, t_power: int) -> F:
        v = [0]*28
        v[4*t_power+alpha_power] = 1
        return cls(tuple(v))
    def __bool__(self) -> bool:
        return any(self.v)
    def __eq__(self, b: object) -> bool:
        return isinstance(b, F) and self.v == b.v
    def __add__(self, b: F) -> F:
        return F(tuple(ADD[a][c] for a,c in zip(self.v, b.v)))
    def __neg__(self) -> F:
        return F(tuple(NEG[a] for a in self.v))
    def __sub__(self, b: F) -> F:
        return self + (-b)
    def __mul__(self, b: F) -> F:
        # Independent ordering from field.hpp: convolve t first, then reduce
        # t^7=-t-1, then alpha^4=-sum amonic[i]*alpha^i.
        acc = [[0]*7 for _ in range(13)]
        aa = [(i//4, i%4, a) for i,a in enumerate(self.v) if a]
        bb = [(i//4, i%4, c) for i,c in enumerate(b.v) if c]
        for t1,u1,a in aa:
            for t2,u2,c in bb:
                row = acc[t1+t2]
                row[u1+u2] = ADD[row[u1+u2]][MUL[a][c]]
        for t in range(12,6,-1):
            for u in range(7):
                a = NEG[acc[t][u]]
                if a:
                    acc[t-7][u] = ADD[acc[t-7][u]][a]
                    acc[t-6][u] = ADD[acc[t-6][u]][a]
        out = []
        for t in range(7):
            row = acc[t]
            for u in range(6,3,-1):
                a = NEG[row[u]]
                for k,c in enumerate(self.amonic):
                    row[u-4+k] = ADD[row[u-4+k]][MUL[a][c]]
            out.extend(row[:4])
        return F(tuple(out))
    def __pow__(self, n: int) -> F:
        if n < 0:
            return self.inv() ** (-n)
        a, out = self, ONE
        while n:
            if n & 1:
                out = out*a
            n >>= 1
            if n:
                a = a*a
        return out
    def inv(self) -> F:
        if not self:
            raise ZeroDivisionError("inverse of zero in E")
        result = self ** (5**56-2)
        require(self*result == ONE, "exact field inversion")
        return result
    def __truediv__(self, b: F) -> F:
        return self*b.inv()
    def row(self) -> list[int]:
        return [self.v[4*j+i] for i in range(4) for j in range(7)]

ZERO, ONE = F.code(0), F.code(1)

def require(condition: bool, message: str) -> None:
    if not condition:
        raise ArithmeticError(message)

def fpoly(p: list[int], x: F) -> F:
    out = ZERO
    for c in reversed(p):
        out = out*x + F.code(c)
    return out

# Small polynomials over F25, used for irreducibility tests, without E arithmetic.
def trim(a: list[int]) -> list[int]:
    while a and a[-1] == 0:
        a.pop()
    return a

def padd(a: list[int], b: list[int], minus: bool = False) -> list[int]:
    z = a[:] + [0]*max(0,len(b)-len(a))
    for i,c in enumerate(b):
        z[i] = ADD[z[i]][NEG[c] if minus else c]
    return trim(z)

def pmul(a: list[int], b: list[int]) -> list[int]:
    if not a or not b:
        return []
    z = [0]*(len(a)+len(b)-1)
    for i,c in enumerate(a):
        for j,d in enumerate(b):
            z[i+j] = ADD[z[i+j]][MUL[c][d]]
    return trim(z)

def pmod(a: list[int], modulus: list[int]) -> list[int]:
    a = trim(a[:])
    modulus = trim(modulus[:])
    if not modulus:
        raise ZeroDivisionError("polynomial modulus zero")
    while len(a) >= len(modulus):
        v = MUL[a[-1]][INV[modulus[-1]]]
        shift = len(a)-len(modulus)
        for i,c in enumerate(modulus):
            a[i+shift] = ADD[a[i+shift]][NEG[MUL[v][c]]]
        trim(a)
    return a

def ppow(a: list[int], n: int, modulus: list[int]) -> list[int]:
    out = [1]
    while n:
        if n & 1:
            out = pmod(pmul(out,a),modulus)
        n >>= 1
        if n:
            a = pmod(pmul(a,a),modulus)
    return out

def pgcd(a: list[int], b: list[int]) -> list[int]:
    a,b = trim(a[:]),trim(b[:])
    while b:
        a,b = b,pmod(a,b)
    return [MUL[c][INV[a[-1]]] for c in a] if a else []

# Dense truncated power series. Every coefficient remains an exact E element.
def sc(x: F, n: int) -> list[F]:
    return [x]+[ZERO]*(n-1)

def sadd(a: list[F], b: list[F], n: int) -> list[F]:
    return [(a[i] if i < len(a) else ZERO)+(b[i] if i < len(b) else ZERO)
            for i in range(n)]

def sneg(a: list[F]) -> list[F]:
    return [-x for x in a]

def ssub(a: list[F], b: list[F], n: int) -> list[F]:
    return sadd(a,sneg(b),n)

def sscale(a: list[F], c: F) -> list[F]:
    return [x*c for x in a]

def smul(a: list[F], b: list[F], n: int) -> list[F]:
    out = [ZERO]*n
    for i,x in enumerate(a[:n]):
        if x:
            for j,y in enumerate(b[:n-i]):
                if y:
                    out[i+j] = out[i+j]+x*y
    return out

def spow(a: list[F], e: int, n: int) -> list[F]:
    out = sc(ONE,n)
    while e:
        if e & 1:
            out = smul(out,a,n)
        e >>= 1
        if e:
            a = smul(a,a,n)
    return out

def seval(p: list[int], x: list[F], n: int) -> list[F]:
    out = [ZERO]*n
    for c in reversed(p):
        out = smul(out,x,n)
        out[0] = out[0]+F.code(c)
    return out

def shifted(a: list[F], shift: int, n: int) -> list[F]:
    return ([ZERO]*shift+a)[:n] if shift < n else [ZERO]*n

def deriv(a: list[F]) -> list[F]:
    return [F.prime(i)*a[i] for i in range(1,len(a))]

def rows(a: list[F]) -> list[list[int]]:
    return [x.row() for x in a]

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write-certificate",action="store_true",
                        help="regenerate certificate instead of verifying the pinned copy")
    args = parser.parse_args()
    start = perf_counter()
    data = json.loads((ROOT/"data/input.json").read_text())
    A, P = data["A"], data["P"]
    F.amonic = tuple(MUL[c][INV[A[4]]] for c in A[:4])
    print(f"Python {platform.python_version()}; standard library only")
    print("Checking finite-field presentations and exact input...")
    require(all((x*x-x-3)%5 for x in range(5)),"beta polynomial irreducible")
    m = data["F_modulus"]
    require(ppow([0,1],5**7,m) == [0,1],"t Frobenius test")
    require(pgcd(m,padd(ppow([0,1],5,m),[0,1],True)) == [1],"t gcd test")
    require(ppow([0,1],25**4,A) == [0,1],"alpha Frobenius test")
    require(pgcd(A,padd(ppow([0,1],25**2,A),[0,1],True)) == [1],"alpha gcd test")
    require(pgcd(A,P) == [1],"A and P coprime")
    require(pgcd(A,[MUL[i%5][A[i]] for i in range(1,len(A))]) == [1],"A squarefree")
    require(pgcd(P,[MUL[i%5][P[i]] for i in range(1,len(P))]) == [1],"P squarefree")
    alpha, t, j = F.basis(1,0),F.basis(0,1),F.code(7)
    require(j*j == F.prime(2),"j^2=2")
    require(F.code(3)+j == F.code(5),"beta=3+j")
    require(not fpoly(A,alpha),"A(alpha)=0")
    require(t**7+t+ONE == ZERO,"t^7+t+1=0")
    def ordinary(value: int) -> F:
        ans, tp = ZERO, ONE
        for _ in range(7):
            ans = ans+F.prime(value%5)*tp
            tp, value = tp*t,value//5
        require(value == 0,"ordinary integer field encoding")
        return ans
    zeta = ordinary(data["zeta_real_base5"])+j*ordinary(data["zeta_j_base5"])
    require(zeta**29 == ONE and zeta != ONE,"zeta has exact order 29")
    zetas = [zeta**i for i in range(29)]
    weights = data["weights"]
    require([weights.count(i) for i in range(4)] == [4,8,10,7],"fiber profile counts")
    require(sum(weights)+6 == 55,"degree 55 profile")
    require(sum(1 if w in (1,2) else 2 if w == 3 else 0 for w in weights) == 32,
            "degree 32 denominator profile")
    chi = F.prime(2)*F.code(22)
    def moment(a: int) -> F:
        out = ZERO
        for i,w in enumerate(weights):
            out = out+F.prime(w)*zetas[(i*a)%29]
        return out
    def endpoint(power: int, zeta_power: int) -> dict[str,F]:
        root = alpha**power
        L = zeta**zeta_power*fpoly(data["L_star"],root)
        return dict(root=root,L=L,a=fpoly(data["J_a"],root)*L**4,
                    b=fpoly(data["J_b"],root)*L**8,
                    m=fpoly(data["J_m"],root)*L**5)
    Z = [endpoint(i,data["zero_L_zeta_power"]) for i in data["zero_root_powers"]]
    I = [endpoint(i,data["infinity_L_zeta_power"]) for i in data["infinity_root_powers"]]
    half = F.prime(3)
    def avg(points: list[dict[str,F]], key: str) -> F:
        return half*(points[0][key]+points[1][key])
    den = avg(Z,"b")+chi*moment(-2)
    num = avg(I,"m")+chi*moment(-6)
    require(bool(den) and bool(num),"epsilon numerator/denominator nonzero")
    eps = num/den
    ei = eps.inv()
    require(eps*(avg(Z,"m")+chi*moment(6)) == avg(I,"b")+chi*moment(2),
            "second supplied trace-moment identity")
    print("PASS: field bases, embedded zeta, endpoint constants, profile, moment identities")
    # Construct the needed trace jets by expanding the supplied partial fractions
    # directly, rather than reusing the moment-series formulas in explore.cpp.
    n = 5
    R1, R2, r2inf = [ZERO]*n,[ZERO]*n,ZERO
    for xi,w in zip(zetas,weights):
        invxi = xi**28  # exact since xi^29=1
        res1 = chi*F.prime(w)*(xi-ei*invxi**3)
        res2 = chi*F.prime(w)*(eps*xi**5-xi)
        r2inf = r2inf+res2
        geom = -invxi
        for k in range(n):
            R1[k],R2[k] = R1[k]+res1*geom,R2[k]+res2*geom
            geom = geom*invxi
    T = R1[:]
    T[0],T[1] = avg(Z,"root"),avg(Z,"a")
    T[2],T[3] = T[2]+ei*avg(I,"m"),T[3]+ei*avg(I,"L")
    U = [avg(Z,"L"),avg(Z,"m"),ei*(avg(I,"a")-r2inf),
         ei*(avg(I,"root")+R2[0]),ei*R2[1]]
    require(T[2] == avg(Z,"b"),"zero-endpoint quadratic trace")
    a0,a1,L0,L1 = Z[0]["root"],Z[1]["root"],Z[0]["L"],Z[1]["L"]
    Ap = [MUL[i%5][A[i]] for i in range(1,5)]
    ap0,ap1 = fpoly(Ap,a0),fpoly(Ap,a1)
    a4 = F.code(A[4])
    M = [[ap0,-F.prime(4)*a4*L0**3],
         [-ap1,F.prime(4)*a4*L1**3]]
    det = M[0][0]*M[1][1]-M[0][1]*M[1][0]
    require(bool(det),"local recurrence matrix invertible")
    deti = det.inv()
    def K(Y: list[F], size: int) -> list[F]:
        out = [ZERO]*size
        for i,c in enumerate(A):
            shift = 13-3*i
            if shift < size:
                term = sscale(spow(Y,i,size-shift),F.code(c)*ei**(4-i))
                out = sadd(out,shifted(term,shift,size),size)
        return out
    X,Y = sc(a0,n),sc(L0,n)
    X[1] = a4*L0**4/ap0
    require(X[1] == Z[0]["a"],"first endpoint coefficient")
    recurrence = []
    for order in range(2,5):
        # X[order] and Y[order-1] are zero before the current linear solve.
        require(X[order] == ZERO and Y[order-1] == ZERO,"recurrence initialization")
        xb = ssub(sscale(T,F.prime(2)),X,n)
        yb = ssub(sscale(U,F.prime(2)),Y,n)
        e0 = ssub(seval(A,X,n),K(Y,n),n)[order]
        e1 = ssub(seval(A,xb,n),K(yb,n),n)[order]
        b0,b1 = -e0,-e1
        X[order] = (b0*M[1][1]-M[0][1]*b1)*deti
        Y[order-1] = (M[0][0]*b1-b0*M[1][0])*deti
        recurrence.append(dict(order=order,residual_before=[e0.row(),e1.row()],
                               solution=[X[order].row(),Y[order-1].row()]))
    require(X[2] == Z[0]["b"] and Y[1] == Z[0]["m"],"remaining specified zero jets")
    xb = ssub(sscale(T,F.prime(2)),X,n)
    yb = ssub(sscale(U,F.prime(2)),Y,n)
    require(xb[0] == a1 and xb[1] == Z[1]["a"] and xb[2] == Z[1]["b"],
            "conjugate x endpoint jets")
    require(yb[0] == L1 and yb[1] == Z[1]["m"],"conjugate y endpoint jets")
    require(not any(ssub(seval(A,X,n),K(Y,n),n)),"quartic identity on first sheet mod s^5")
    require(not any(ssub(seval(A,xb,n),K(yb,n),n)),"quartic identity on second sheet mod s^5")
    print("PASS: independent 2x2 jet recurrence; both quartic identities modulo s^5")
    # The differential obstruction needs X modulo s^5 and Y modulo s^4 only.
    precision = 4
    Phat = [ZERO]*precision
    for i,c in enumerate(P):
        shift = 30-3*i
        if shift < precision:
            term = sscale(spow(Y,i,precision-shift),F.code(c)*eps**i)
            Phat = sadd(Phat,shifted(term,shift,precision),precision)
    sdYminus3Y = ssub(shifted(deriv(Y[:4]),1,precision),
                        sscale(Y[:4],F.prime(3)),precision)
    lhs = sscale(smul(spow(sdYminus3Y,3,precision),
                      spow(seval(P,X,precision),2,precision),precision),eps**20)
    rhs = smul(spow(deriv(X),3,precision),spow(Phat,2,precision),precision)
    differential_residual = ssub(lhs,rhs,precision)
    require(not any(differential_residual[:3]),"differential identity orders 0,1,2")
    require(bool(differential_residual[3]),"nonzero order-three obstruction")
    # Third check of the obstructing coefficient, using a closed scalar formula
    # rather than power-series multiplication for the differential identity.
    Rpoly = pmul(P,P)
    hasse = []
    for order in range(4):
        value = ZERO
        for k in range(order,len(Rpoly)):
            value = value+F.prime(comb(k,order))*F.code(Rpoly[k])*a0**(k-order)
        hasse.append(value)
    x1,x2,x3,x4 = X[1:5]
    y1,y2 = Y[1:3]
    r0 = hasse[0]
    r1 = hasse[1]*x1
    r2 = hasse[1]*x2+hasse[2]*x1**2
    r3 = hasse[1]*x3+F.prime(2)*hasse[2]*x1*x2+hasse[3]*x1**3
    closed = eps**20*(F.prime(3)*L0**3*r3+L0**2*y1*r2
               +(F.prime(3)*L0**2*y2+F.prime(4)*L0*y1**2)*r1
               +(F.prime(4)*L0*y1*y2+F.prime(2)*y1**3)*r0
               -L0**20*(F.prime(2)*x1**2*x4+x1*x2*x3+F.prime(3)*x2**3)) \
               -F.prime(2)*F.code(P[9])*eps**19*L0**19*x1**3
    require(closed == differential_residual[3],"closed scalar formula for obstruction")
    print("PASS: closed Hasse-derivative formula gives the same obstruction")
    print("PASS: differential residual coefficients s^0,s^1,s^2 vanish")
    print("PASS: coefficient of s^3 is NONZERO:",differential_residual[3].row())
    cert = dict(
        schema="degree55-local-obstruction-v1",
        precision=dict(X=5,Y=4,T=5,U=4,differential=4),
        basis=data["certificate_field_basis"],
        field_checks=dict(t_irreducible=True,A_irreducible_over_F25=True,
                          compositum_degree_over_F5=56,zeta_order=29),
        zeta=zeta.row(),epsilon_numerator=num.row(),epsilon_denominator=den.row(),
        epsilon=eps.row(),chi=chi.row(),
        Z=[{k:v.row() for k,v in e.items()} for e in Z],
        I=[{k:v.row() for k,v in e.items()} for e in I],
        trace_T=rows(T),trace_U=rows(U[:4]),matrix=[rows(r) for r in M],
        determinant=det.row(),recurrence=recurrence,X=rows(X),Y=rows(Y[:4]),
        X_conjugate=rows(xb),Y_conjugate=rows(yb[:4]),
        differential_lhs=rows(lhs),differential_rhs=rows(rhs),
        differential_residual=rows(differential_residual),first_nonzero_order=3)
    path = ROOT/"certificates/local_obstruction.json"
    if args.write_certificate:
        path.write_text(json.dumps(cert,indent=2)+"\n")
        print("WROTE: certificates/local_obstruction.json")
    else:
        require(json.loads(path.read_text()) == cert,"pinned local certificate equality")
        print("PASS: every value equals the pinned local certificate")
    # Compare to the separately implemented sextic/Newton certificate if present.
    cross_path = ROOT/"certificates/exploration.json"
    if cross_path.exists():
        cross = json.loads(cross_path.read_text())
        require(cross["epsilon"] == eps.row(),"C++ epsilon agreement")
        require(cross["X"][:5] == rows(X),"C++ X-jet agreement")
        require(cross["Y"][:4] == rows(Y[:4]),"C++ Y-jet agreement")
        require(cross["T"][:5] == rows(T),"C++ T-jet agreement")
        require(cross["U"][:4] == rows(U[:4]),"C++ U-jet agreement")
        require(cross["differential_residual"][:4] == rows(differential_residual),
                "C++ differential obstruction agreement")
        print("PASS: agreement with independent C++ sextic/Newton certificate")
    print("COMPLETED NEGATIVE DECISION: the required local identities are inconsistent.")
    print(f"Elapsed seconds: {perf_counter()-start:.3f}")

if __name__ == "__main__":
    try:
        main()
    except (ArithmeticError,ValueError,KeyError,OSError) as exc:
        print(f"FAIL: {exc}",file=sys.stderr)
        sys.exit(1)
