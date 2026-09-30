"""Portable exact data for the new polynomial vertical-jet identity."""
import sys,json
from pathlib import Path
root=Path(sys.argv[1]);d=load(str(root/'vertical_jet_module.sobj'));v=load(str(root/'reduced_jet_identity.sobj'))
K=d['K'];a=K.gen();F5=GF(5);beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def pv(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
change=matrix(F5,[pv(beta**j*a**i) for i in range(4) for j in range(2)]).transpose().inverse()
def enc(c):
 z=change*pv(c);return int(sum(ZZ(z[2*i])*25**i+ZZ(z[2*i+1])*5*25**i for i in range(4)))
def poly(f):return [enc(c) for c in f]
out={'scope':'one polynomial identity on the full affine curve; no finite-point restriction',
 'field':{'characteristic':5,'beta_relation_ascending':[2,4,1],'alpha_relation_F25_ascending':[5,2,6,7,1],'encoding':'base25 tower codes, ci=ai+5bi'},
 'P':poly(d['P']),'B0':poly(d['B']), 'slots':d['slots'],
 'basis':[list(map(enc,b)) for b in d['basis']],
 'regular_coefficients':[[[poly(p) for p in f] for f in col] for col in d['regular_coefficients']],
 'kappa':list(map(enc,d['kappa'])),'jet_order':['g2','delta_g2','delta2_g2','g3','delta_g3','delta2_g3','g4','delta_g4','delta2_g4'],
 'coefficient_y_powers':v['weights'],'certificate_polynomials':list(map(poly,v['certificate'])),
 'delta':'delta(x)=3*y^2, delta(y)=Pprime(x), y^3=P(x)',
 'identity':'sum_i certificate_polynomials[i](x)*y^coefficient_y_powers[i]*jet[i] = kappa, for every column of the recorded source basis',
 'executed_check':'exact polynomial identity over K(x)[y]/(y^3-P), all eight columns; no denominator remains'}
(root/'global_vertical_jet_identity.json').write_text(json.dumps(out,separators=(',',':'),default=int)+'\n')
print('portable bytes',(root/'global_vertical_jet_identity.json').stat().st_size,flush=True)
