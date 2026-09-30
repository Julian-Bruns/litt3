"""Regenerate the rational signatures and portable field/input descriptions."""
from ff25 import *
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
DATA = ROOT / 'data'
DATA.mkdir(exist_ok=True)
P = [11,22,18,5,19,20,15,16,9,22,1]
A = [1,21,14,22,13]
p, a = Rat(P), Rat(A)
H = p**2 * a.der()**3 / a**3
J = a / a.der() * H.der() / H
K = a / a.der() * J.der()
R = H**13 / a**48
signatures = [('H', H), ('J', J), ('K', K), ('R', R)]
for name, f in signatures:
    print(name, 'degrees', len(f.a)-1, len(f.b)-1)
    if name in ['J', 'K']:
        print(f)
assert [(len(f.a)-1,len(f.b)-1) for _,f in signatures] == [(29,12),(16,16),(31,32),(377,348)]
data = {key: {'numerator': f.a, 'denominator': f.b} for key, f in signatures}
(DATA / 'signature.json').write_text(json.dumps(data, indent=2)+'\n')
with (DATA / 'signature_polys.txt').open('w') as out:
    for poly in [J.a, J.b, K.a, K.b]:
        out.write(str(len(poly)-1)+'\n'+' '.join(map(str,poly))+'\n')
field = {
    'characteristic': 5,
    'F25_modulus': [2,4,1],
    'F25_encoding': 'a+5*b means a+b*beta, 0<=a,b<5',
    'F15625_modulus_over_F25': [1,0,1,1],
    'F15625_encoding': 'a+25*b+625*c means a+b*theta+c*theta^2 with a,b,c F25 codes',
}
(DATA / 'field.json').write_text(json.dumps(field, indent=2)+'\n')
print('rational signatures and field descriptions: PASS')
