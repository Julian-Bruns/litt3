"""Complete finite fibres of the new rational jet-module certificate."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);st=time.time()
d=load(str(root/'vertical_jet_module.sobj')); c=load(str(root/'generic_kappa_certificate.sobj'))
K=d['K']; P=d['P']; PX=P.parent(); x=PX.gen(); C=d['curve']; M=d['matrix']; kap=d['kappa']
coeff=c['certificate']; den=PX.one()
for f in coeff:
 for a in f.list():den=lcm(den,PX(a.denominator()))
fac=den.factor();print('certificate denominator degree',den.degree(),'factors',[(f.degree(),m) for f,m in fac],flush=True)
report={'denominator_degree':int(den.degree()),'factor_degrees':[(int(f.degree()),int(m)) for f,m in fac],'fibres':[]}
save({'denominator':den,'factors':fac,'certificate':coeff},str(root/'jet_certificate_denominator.sobj'))
for idx,(f,m) in enumerate(fac):
 # Every geometric x above this factor is retained by its whole field.
 E=PX.quotient(f,'xb'); xb=E.gen(); YY=PolynomialRing(E,'Y'); Y=YY.gen()
 yp=Y**3-E(P.quo_rem(f)[1]); yf=yp.factor()
 for yi,(g,gm) in enumerate(yf):
  L=YY.quotient(g,'yb');yb=L.gen()
  def ev(t):return sum(L(E(a.quo_rem(f)[1]))*yb**j for j,a in enumerate(t))
  A=matrix(L,9,8,lambda i,j:ev(d['jet_columns'][j][i])); kr=vector(L,list(map(L,kap)))
  rank=A.rank(); rr=A.stack(matrix(L,1,8,list(kr))).rank()
  rec={'x_factor':idx,'x_degree':int(f.degree()),'y_factor':yi,'y_degree':int(g.degree()),'y_multiplicity':int(gm),'rank':int(rank),'rank_with_kappa':int(rr),'kappa_forced_zero':bool(rank==rr)}
  evidence={'x_factor':f,'y_factor':g,'matrix':A,'kappa':kr,'receipt':rec}
  if rank==rr:
   u=A.transpose().solve_right(kr); assert u*A==kr;evidence['left_certificate']=u
  else:
   ker=A.right_kernel().basis();w=next(v for v in ker if kr.dot_product(v));w=w/kr.dot_product(w)
   assert A*w==0 and kr.dot_product(w)==1;evidence['formal_coefficient_witness']=w
  save(evidence,str(root/f'jet_fibre_{idx}_{yi}.sobj'));report['fibres'].append(rec);print(rec,flush=True)
  (root/'fibre_summary.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
report['complete']=True;report['seconds']=time.time()-st
(root/'fibre_summary.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print('complete',report['seconds'],flush=True)
