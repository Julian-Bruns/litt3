"""Fraction-free global source, retaining all points of the critical curve.
V=y*w^2, V^3=q^2*P; tau=q^3*d*mu; gi=q^3*d*Gi/w.
The monomial conversion below is an exact identity, not interpolation.
"""
from exact import ROOT,DATA,add,mul,neg,inv,power,code
import json

def build():
 src=json.loads((ROOT/'evidence/cramer_source.json').read_text())
 out={};maxq=maxu=weight=0
 for n,rows in src['G'].items():
  terms={}
  for ix,j,ls in rows:
   for ih,iw,ik1,ik2,a in ls:
    assert ik1==ik2==0
    r=iw-2*ih-1+j;assert r%3==0
    iq=r//3-j+3
    assert iq>=0
    key=(iq,ih,ix,j);terms[key]=add(terms.get(key,0),a)
    maxq=max(maxq,iq);maxu=max(maxu,ih);weight=max(weight,3*iq+6*ih+2*j)
  out[n]=[list(t)+[a] for t,a in sorted(terms.items()) if a]
 # g=b(q)u^2+2c(q)u+3e(q), monic of q-degree nine.
 invlead=inv(mul(3,DATA['e'][-1]));g=[]
 for up,name,s in [(2,'b',1),(1,'c',2),(0,'e',3)]:
  for iq,a in enumerate(DATA[name]):
   if a:g.append([iq,up,mul(mul(a,s),invlead)])
 assert next(a for iq,iu,a in g if (iq,iu)==(9,0))==1
 result={'variables':['q','u','x','V'],
  'coefficient_convention':'K codes from inputs/data.json',
  'G_tilde':out,'critical_monic':g,
  'curve_relation':'V^3=q^2*P(x)',
  'scale':'tau=q^3*d(q)*mu',
  'source_identity':'g_i=q^3*d(q)*G_i/w, with V=y*w^2, w^3=q, h=u/w^2',
  'residual_identity':'R_tilde=q^83*d(q)^36*Rcal_r(u/q,q,tau/(q^3*d(q)),x)',
  'max_q_degree_source':maxq,'max_u_degree_source':maxu,
  'max_weight_3q_6u_2V':weight}
 (ROOT/'evidence/global_source.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
 print('Fraction-free source: max q degree',maxq,'max u degree',maxu,'max weighted degree (3,6,2)',weight)
 print('Critical polynomial monic of degree 9 in q. Residual scaling q^83*d^36.')
 return result

if __name__=='__main__':build()
