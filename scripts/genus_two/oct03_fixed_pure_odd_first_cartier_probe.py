#!/usr/bin/env python3
"""Tiny NEW exact F25 linear probe; no endpoint or certificate replay.

The diagnostic only probes the first necessary large-wild Cartesian packet.
It does not establish a global carrier or an exclusion over the family.
Field F25=F5[b]/(b^2-2); coefficient variables are fifth powers of V_i.
"""

class K:
    def __init__(self, a=0, b=0): self.a, self.b = a % 5, b % 5
    def __add__(self, z):
        z = cast(z); return K(self.a+z.a, self.b+z.b)
    __radd__ = __add__
    def __neg__(self): return K(-self.a,-self.b)
    def __sub__(self,z): return self+-cast(z)
    def __rsub__(self,z): return cast(z)+-self
    def __mul__(self,z):
        z=cast(z); return K(self.a*z.a+2*self.b*z.b,self.a*z.b+self.b*z.a)
    __rmul__=__mul__
    def __pow__(self,n):
        if n<0: return self**23
        out=K(1); z=self
        while n:
            if n&1: out=out*z
            z=z*z; n//=2
        return out
    def __truediv__(self,z): return self*cast(z)**23
    def __bool__(self): return bool(self.a or self.b)
    def __eq__(self,z):
        z=cast(z); return self.a==z.a and self.b==z.b
    def __repr__(self): return f"({self.a},{self.b})"

def cast(x): return x if isinstance(x,K) else K(x)
def trim(p):
    p=list(p)
    while len(p)>1 and not p[-1]: p.pop()
    return p
def add(p,q):
    return trim([(p[i] if i<len(p) else K())+(q[i] if i<len(q) else K()) for i in range(max(len(p),len(q)))])
def scale(p,x): return trim([v*x for v in p])
def mul(p,q):
    out=[K() for _ in range(len(p)+len(q)-1)]
    for i,x in enumerate(p):
        for j,y in enumerate(q): out[i+j]=out[i+j]+x*y
    return trim(out)
def power(p,n):
    out=[K(1)]
    for _ in range(n): out=mul(out,p)
    return out
def evaluate(p,x):
    out=K()
    for z in reversed(p): out=out*x+z
    return out
def coef(p,i): return p[i] if 0<=i<len(p) else K()
def derivative(p): return trim([p[i]*i for i in range(1,len(p))])

def rref(rows,n):
    rows=[list(r) for r in rows]; original=[list(r) for r in rows]; pivots=[]
    witnesses=[[K(int(i==j)) for j in range(len(rows))] for i in range(len(rows))]
    for j in range(n):
        hit=next((i for i in range(len(pivots),len(rows)) if rows[i][j]),None)
        if hit is None: continue
        k=len(pivots); rows[k],rows[hit]=rows[hit],rows[k]
        witnesses[k],witnesses[hit]=witnesses[hit],witnesses[k]
        iv=rows[k][j]**23; rows[k]=[v*iv for v in rows[k]]
        witnesses[k]=[v*iv for v in witnesses[k]]
        for i in range(len(rows)):
            if i!=k and rows[i][j]:
                z=rows[i][j]; rows[i]=[x-z*y for x,y in zip(rows[i],rows[k])]
                witnesses[i]=[x-z*y for x,y in zip(witnesses[i],witnesses[k])]
        pivots.append(j)
    inconsistent=any(not any(r[:n]) and r[n] for r in rows)
    obstruction=None
    for row,weights in zip(rows,witnesses):
        if not any(row[:n]) and row[n]:
            obstruction=[v/row[n] for v in weights]
            # Guard the affine inconsistency by DIRECT original-row multiplication.
            checked=[sum(w*r[j] for w,r in zip(obstruction,original)) for j in range(n+1)]
            assert checked==[K()]*n+[K(1)]
            break
    return rows,pivots,inconsistent,obstruction

def probe(a):
    q=K(4)/a**3
    assert q.b and a**3==K(4)/q
    phi=[4*q,K(4),K(),K(),q,K(1)]
    bb=[-a,K(1)]
    ff4=mul(power(phi,2),power(bb,4))
    dd=add(phi,scale(mul(bb,derivative(phi)),K(3)))
    pp=mul(phi,power(bb,3))
    assert not coef(pp,4)
    hbase=[K() for _ in range(len(pp)+1)]
    for i,v in enumerate(pp):
        assert (i+1)%5 or not v
        if v: hbase[i+1]=v/K(i+1)
    d5=power(dd,5)
    n=15; rows=[]
    # Unknowns v0^5,...,v11^5,alpha^5,L0,L1.
    for j in range(21,26):
        row=[coef(ff4,j-i)**5 for i in range(12)]+[coef(d5,j)**5,K(),K(),K()]
        rows.append(row)
    for x in [K(1),K(2),K(3),K(4),-q,a]:
        dv=evaluate(dd,x)**5
        rows.append([x**(5*i) for i in range(12)]+[K(),-2*dv,-2*x**5*dv,2*evaluate(hbase,x)*dv])
    # Fifth powers of the exact Cartier-zero polynomial coefficients.
    for j in [4,9,14,19,24]:
        vc=[sum((coef(ff4,k-i)*coef(pp,j-k))**5 for k in range(26)) for i in range(12)]
        ac=sum((coef(d5,k)*coef(pp,j-k))**5 for k in range(26))
        rows.append(vc+[ac,K(),K(),K()])
    rr,piv,bad,witness=rref(rows,n)
    out={"a":repr(a),"q":repr(q),"rank":len(piv),"inconsistent":bad}
    if witness:
        labels=[f"pole{j}" for j in range(21,26)]+[f"fiber{repr(x)}" for x in [K(1),K(2),K(3),K(4),-q,a]]+[f"cartier{j}" for j in [4,9,14,19,24]]
        out["direct_checked_affine_witness"]=[(s,repr(w)) for s,w in zip(labels,witness) if w]
    if not bad:
        if 12 in piv:
            ar=rr[piv.index(12)]
            out["alpha_fifth_constant"]=repr(ar[n])
            out["alpha_fifth_free_coefficients"]=[(j,repr(ar[j])) for j in range(n) if j not in piv and ar[j]]
        else: out["alpha_fifth_free"]=True
    return out

if __name__=="__main__":
    import json
    print(json.dumps(probe(K(0,1)),sort_keys=True))
