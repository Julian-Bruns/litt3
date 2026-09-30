"""Exact F_25 arithmetic in the user's [a+5b] convention (standard library)."""
from __future__ import annotations
P = 5

def add(x: int, y: int) -> int:
    return (x % 5 + y % 5) % 5 + 5 * ((x // 5 + y // 5) % 5)

def neg(x: int) -> int:
    return (-x % 5) % 5 + 5 * ((-(x // 5)) % 5)

def sub(x: int, y: int) -> int:
    return add(x, neg(y))

def mul(x: int, y: int) -> int:
    a, b = x % 5, x // 5
    c, d = y % 5, y // 5
    return (a*c + 3*b*d) % 5 + 5*((a*d+b*c+b*d) % 5)

def power(x: int, n: int) -> int:
    if n < 0:
        return power(inv(x), -n)
    ans = 1
    while n:
        if n & 1:
            ans = mul(ans, x)
        x = mul(x, x)
        n >>= 1
    return ans

def inv(x: int) -> int:
    if x == 0:
        raise ZeroDivisionError("zero in F_25")
    return power(x, 23)

def trim(f: list[int]) -> list[int]:
    f = list(f)
    while f and f[-1] == 0:
        f.pop()
    return f

def padd(f: list[int], g: list[int]) -> list[int]:
    return trim([add(f[i] if i < len(f) else 0,
                     g[i] if i < len(g) else 0)
                 for i in range(max(len(f), len(g)))])

def pneg(f: list[int]) -> list[int]:
    return trim([neg(x) for x in f])

def psub(f: list[int], g: list[int]) -> list[int]:
    return padd(f, pneg(g))

def pmul(f: list[int], g: list[int]) -> list[int]:
    if not f or not g:
        return []
    h = [0] * (len(f)+len(g)-1)
    for i, a in enumerate(f):
        for j, b in enumerate(g):
            h[i+j] = add(h[i+j], mul(a,b))
    return trim(h)

def pscale(f: list[int], a: int) -> list[int]:
    return trim([mul(a,x) for x in f])

def pdivmod(f: list[int], g: list[int]) -> tuple[list[int], list[int]]:
    f, g = trim(f), trim(g)
    if not g:
        raise ZeroDivisionError("zero polynomial")
    q = [0] * max(0, len(f)-len(g)+1)
    while f and len(f) >= len(g):
        d = len(f)-len(g)
        a = mul(f[-1], inv(g[-1]))
        q[d] = a
        f = psub(f, [0]*d + pscale(g,a))
    return trim(q), f

def pxgcd(f: list[int], g: list[int]) -> tuple[list[int], list[int], list[int]]:
    """Return monic d and a,b with af+bg=d."""
    r0, r1 = trim(f), trim(g)
    a0, a1, b0, b1 = [1], [], [], [1]
    while r1:
        q, r2 = pdivmod(r0,r1)
        r0,r1 = r1,r2
        a0,a1 = a1,psub(a0,pmul(q,a1))
        b0,b1 = b1,psub(b0,pmul(q,b1))
    c = inv(r0[-1])
    return pscale(r0,c), pscale(a0,c), pscale(b0,c)

def derivative(f: list[int]) -> list[int]:
    return trim([mul(i%5,f[i]) for i in range(1,len(f))])

def evaluate(f: list[int], x: int) -> int:
    v = 0
    for a in reversed(f):
        v = add(mul(v,x),a)
    return v
