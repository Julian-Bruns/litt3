"""Factor discovered fixed-w denominators; not a global identity proof."""
import json, sys
from pathlib import Path

Fp = GF(5)
Rb = PolynomialRing(Fp, 'b0'); b0 = Rb.gen()
B = GF(25, name='b', modulus=b0^2-b0-3); b = B.gen()
Ra = PolynomialRing(B, 'a0'); a0 = Ra.gen()
def bcode(n): return B(n % 5) + (n // 5)*b
K = B.extension(sum(bcode(c)*a0^i for i,c in enumerate([5,2,6,7,1])), 'a')
a = K.gen()
Rh = PolynomialRing(K, 'h'); h = Rh.gen()
def decode(n):
    ans=K.zero()
    for i in range(4):
        ans += K(bcode(n % 25))*a^i; n //= 25
    return ans
def encode(z):
    return int(sum(25^i*(int(c[0])+5*int(c[1])) for i,c in enumerate(K(z).list())))
def row(p): return [encode(c) for c in p.list()]

inp=Path(sys.argv[1]); out=Path(sys.argv[2])
data=json.loads(inp.read_text())
result=[]
for rec in data['coefficients']:
    if rec['mismatches']: continue
    den=Rh([decode(c) for c in rec['denominator']])
    fac=[{'degree':int(f.degree()),'multiplicity':int(m),'polynomial':row(f)} for f,m in den.factor()]
    result.append({'index':rec['index'],'factors':fac})
out.write_text(json.dumps({'status':'discovery_only','input':str(inp),'factors':result},separators=(',',':'))+'\n')
for rec in result: print(rec['index'],[(f['degree'],f['multiplicity'],f['polynomial'] if f['degree']<=1 else None) for f in rec['factors']])
