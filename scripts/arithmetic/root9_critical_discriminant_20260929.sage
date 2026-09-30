#!/usr/bin/env sage
"""New test of nonsplitting of the root-nine critical quadratic.

Uses the already verified affine source and Cramer coordinates.  It does
not replay their reconstruction.  All output is written outside the
research repository.  A Groebner outcome is discovery until an exact
ideal certificate is retained and checked.
"""
import argparse, json, time
import hashlib
from pathlib import Path

pa = argparse.ArgumentParser()
pa.add_argument('--data', required=True)
pa.add_argument('--output', required=True)
pa.add_argument('--eliminate', action='store_true')
pa.add_argument('--export-only', action='store_true')
args = pa.parse_args()
data = Path(args.data); out = Path(args.output)
out.mkdir(parents=True, exist_ok=True)
started = time.time()
F5 = GF(5); AX = PolynomialRing(F5, 'a'); aa = AX.gen()
K = GF(5**8, name='a', modulus=aa**8+aa**6+2*aa**3+4*aa**2+2*aa+2)
a = K.gen(); beta = -(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
assert beta**2 == beta+3
assert a**4+(2+beta)*a**3+(1+beta)*a**2+2*a+beta == 0

def decode(c):
    z=K.zero()
    for i in range(4):
        digit=c%25; c//=25
        z += (digit%5+(digit//5)*beta)*a**i
    assert c == 0
    return z

# The tower code is just a different F5-basis of K.  Use exact linear
# algebra to encode certificate entries without enumerating the field.
code_basis=[beta**j*a**i for i in range(4) for j in range(2)]
def prime_vector(c):
    pp=K(c).polynomial()
    return vector(F5,[pp[i] for i in range(8)])
code_change=matrix(F5,[prime_vector(b) for b in code_basis]).transpose().inverse()
def encode(c):
    digits=code_change*prime_vector(c)
    return int(sum(ZZ(digits[2*i])*25**i+ZZ(digits[2*i+1])*5*25**i for i in range(4)))
assert all(encode(decode(c))==c for c in [0,1,5,24,25,390624,15383,118020])
def sparse(poly):
    return [[int(i),int(j),encode(c)] for (i,j),c in sorted(poly.dict().items())]

HW = PolynomialRing(K, names=('h','w')); h,w = HW.gens()
Frac = HW.fraction_field()
X = PolynomialRing(Frac, 'x'); x=X.gen()
Y = PolynomialRing(X, 'y'); y=Y.gen()
P = X([decode(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])

cr = json.loads((data/'cramer.json').read_text())
src = json.loads((data/'affine_source.json').read_text())['source_G']
def laur(row):
    return sum((decode(c)*Frac(h)**i*Frac(w)**j for i,j,c in row), Frac.zero())
det=laur(cr['kernel_determinant'])
par=[Frac.one(),Frac(h),Frac(w),laur(cr['e']),laur(cr['f']),
     laur(cr['kernel0_numerator'])/det,
     laur(cr['kernel1_numerator'])/det]
gs=[]
for k in range(4):
    gg=Y.zero()
    for j in range(3):
        nn=max(len(src[i][k][j]) for i in range(7))
        coeff=[]
        for n in range(nn):
            coeff.append(sum((par[i]*decode(src[i][k][j][n])
                              for i in range(7) if n<len(src[i][k][j])), Frac.zero()))
        gg+=Y(X(coeff))*y**j
    gs.append(gg)

delta=(4*gs[1]**2+3*gs[0]*gs[2])%(y**3-P)
dc=[]
for j in range(3):
    quotient, remainder = delta[j].quo_rem(P**2)
    assert remainder == 0
    dc.append(quotient)
assert all(dc[j].degree()<=d for j,d in enumerate((10,7,4)))
assert dc[2].degree()==4
save({'delta':dc,'P':P,'source_G':gs,'parameters':par,'determinant':det},str(out/'actual_delta.sobj'))
if args.export_only:
    print('DELTA_EXPORTED', [c.degree() for c in dc], 'LEADING', dc[2][4], flush=True)
    raise SystemExit(0)
obstruction=dc[1]**2-4*dc[0]*dc[2]

g2c=[gs[0][2],X.zero(),X.zero()]
for j,target in ((0,1),(1,2)):
    g2c[target],rem=gs[0][j].quo_rem(P)
    assert rem==0
norm_g2=g2c[0]**3+P*g2c[1]**3+P**2*g2c[2]**3-3*P*prod(g2c)
J,rem=norm_g2.quo_rem(x-decode(9))
assert rem==0 and J.degree()==12
A=X([decode(c) for c in [1,21,14,22,13]])
tt,rem=A.quo_rem(decode(13)*(x-a))
assert rem==0 and J.gcd(tt)==1
print('GENERIC_NORM_FACTOR',int(J.degree()),'COPRIME_TO_ENDPOINTS',flush=True)

UQ = PolynomialRing(K, names=('u','q')); u,q=UQ.gens()
rows=[]; polys=[]
for i,cc in enumerate(obstruction):
    if not cc: continue
    # Fractions are put in lowest terms by Sage.  Their denominators
    # consist only of the original w and Cramer units.
    num=cc.numerator(); den=cc.denominator()
    terms={}; residues=set()
    for (he,we),c in num.dict().items():
        expo=we-2*he
        residues.add(expo%3)
        terms[(he,expo)]=c
    assert len(residues)==1
    shift=min(ex for he,ex in terms)
    pp=sum((c*u**he*q**((ex-shift)//3) for (he,ex),c in terms.items()), UQ.zero())
    rows.append({'x_degree':i,'w_shift':int(shift),'numerator':str(num),
                 'denominator':str(den),'ratio_polynomial':str(pp)})
    polys.append(pp)
meta={'scope':'Necessary square-root obstruction for the actual critical quadratic; all geometric ratios.',
      'degrees_delta':[int(c.degree()) for c in dc],
      'obstruction_degree':int(obstruction.degree()),
      'rows':rows,'elapsed_seconds':time.time()-started,
      'source_sha256':{n:hashlib.sha256((data/n).read_bytes()).hexdigest() for n in ['affine_source.json','cramer.json']},
      'norm_g2_div_v_degree':int(J.degree()),'norm_factor_coprime_to_t':True}
(out/'critical_obstruction.json').write_text(json.dumps(meta,indent=2)+'\n')
save(polys,str(out/'obstruction_polynomials.sobj'))
print('BUILT',[(r['x_degree'],p.degree(u),p.degree(q),len(p.dict())) for r,p in zip(rows,polys)],flush=True)
if args.eliminate:
    selected=[p for r,p in zip(rows,polys) if r['x_degree']>=12]
    ideal=UQ.ideal(selected)
    gb=ideal.groebner_basis()
    print('TOP_GROEBNER',gb,flush=True)
    save(gb,str(out/'top_groebner.sobj'))
    meta['top_groebner']=[str(p) for p in gb]
    if ideal.reduce(q)==0:
        multipliers=list(q.lift(ideal))
        assert len(multipliers)==len(selected)
        assert sum((b*p for b,p in zip(multipliers,selected)),UQ.zero())==q
        certificate={'target':sparse(q),'generators':[sparse(p) for p in selected],
                     'multipliers':[sparse(p) for p in multipliers],
                     'generator_x_degrees':[12,13,14],
                     'scope':'q belongs to the three necessary critical-square coefficient equations.',
                     'source':'accepted affine_source.json and cramer.json; reconstructed delta=(4G3^2+3G2G4)/P^2'}
        (out/'critical_nonsplit_certificate.json').write_text(json.dumps(certificate,separators=(',',':'),default=int)+'\n')
        print('EXACT_Q_IDENTITY', [len(p.dict()) for p in multipliers],flush=True)
    meta['elapsed_seconds']=time.time()-started
    (out/'critical_obstruction.json').write_text(json.dumps(meta,indent=2)+'\n')
