"""Experimental integral oper engine through source15625 / flat3125.

Keeps all lower-stage algorithms, adds the sixth source/Taylor terms and
weight-aware exact determinant normalization. No sixth result is an input.
"""
import math,time
from fractions import Fraction
import numpy as np
import witt_cubic as w

class Engine:
 def __init__(self,Ser,base,n,flat_precision=125):
  self.Ser=Ser;self.o=base;self.n=Ser(n);self.mod=w.MOD
  self.u,self.v,self.g,self.gi,self.xi,self.fuz,self.R=(Ser(base[k]) for k in ('u','v','g','Dz','xi','fuz','R'))
  self.z=Ser(w.Z);self.mu=Ser(base['mu'])
  self.digits=[]
  for codes in ([31,119,44],[2,0,123],[77,86,64]):
   self.digits.append(sum((Ser(w.ca([c%5,c//5%5,c//25]))*self.z**e for c,e in zip(codes,(-3,-1,1))),Ser(0)))
  self.ell=self.xi-5*(self.digits[0]+self.n)-25*self.digits[1]-125*self.digits[2]
  assert self.mod in (625,3125,15625)
  self.weights={};self.vals={}
  for j in range(1,7):
   den=math.factorial(j);v=0
   while den%5==0:den//=5;v+=1
   order=j-v
   if 5**order<self.mod:
    self.weights[j]=Ser(w.cm(w.ca(5**order),w.ci(den)))
    self.vals[j]=order
  self.checks=[]
  self.frame_certificates={}
  self.frame_ancestors={}
 def D(self,x):return x.deriv()*self.gi
 def zero(self,x,m,bound,label):
  reduced=x.mod(m).cut(bound)
  assert reduced.prec>=bound and reduced.iszero(),(label,reduced,reduced.prec)
  self.checks.append({'label':label,'modulus':m,'precision':bound})
 def mm(self,a,b,m=None):
  S=self.Ser
  out=[[sum((a[i][k]*b[k][j] for k in range(2)),S(0)) for j in range(2)] for i in range(2)]
  return self.mmod(out,m) if m else out
 def mmod(self,a,m):
  previous=self.frame_ancestors.get(id(a))
  if previous is not None and previous[0] is a and previous[2]%m==0:
   return self.mmod(previous[1],m)
  return [[x.mod(m) for x in row] for row in a]
 def madd(self,a,b):return [[a[i][j]+b[i][j] for j in range(2)] for i in range(2)]
 def scalar(self,c,a):return [[c*x for x in row] for row in a]
 def mi(self,a,m):
  # All input frames are the actually determinant-normalized frames.
  original=a;certified=self.frame_certificates.get(id(a))
  a=self.mmod(a,m)
  if certified is None or certified[0] is not original or certified[1]%m:
   self.zero(a[0][0]*a[1][1]-a[0][1]*a[1][0]-1,m,30,'frame determinant')
  else:self.checks.append({'label':'frame determinant from exact graph identity','modulus':m})
  return [[a[1][1],-a[0][1]],[-a[1][0],a[0][0]]]
 def require_exact_frame(self,I,m):
  # A finite Laurent check alone cannot certify an arbitrary infinite tail.
  # Certificates enter only through exact normalization/graph constructions
  # or the driver's hash-bound previously constructed first prefix.
  cert=self.frame_certificates.get(id(I))
  assert cert is not None and cert[0] is I and cert[1]%m==0, 'exact normalized-frame provenance required'
 def ED(self,x,m):return (self.ell.mod(m)*x.mod(m).deriv()*self.gi.mod(m)).mod(m)
 def tau(self,value,outmod=None):
  if outmod is None:outmod=self.mod
  value=self.Ser(value);out=value.mod(outmod);term=value
  for j,weight in self.weights.items():
   modulus=outmod//5**self.vals[j]
   if modulus<=1:continue
   term=self.ED(term,modulus);out=out+weight*term
  return out.mod(outmod)
 def overlap(self):
  S=self.Ser;Az=S(1);term=self.ell
  for j,weight in self.weights.items():
   modulus=self.mod//5**self.vals[j]
   Az=Az+weight*(term.mod(modulus).deriv()*self.gi.mod(modulus)).mod(modulus)
   term=self.ED(term,modulus)
  Az=Az.mod(self.mod);x=(Az-1).mod(self.mod)
  q=self.z*self.nil_binomial(x,Fraction(1,2),self.mod)
  qinv=self.z**-1*self.nil_binomial(x,Fraction(-1,2),self.mod)
  azinv=self.nil_binomial(x,Fraction(-1),self.mod)
  tz=self.tau(self.z)
  self.zero(Az-self.tau(self.g)*tz.deriv()*self.gi,self.mod,30,'actual source eta overlap')
  delta=(self.tau(self.fuz)-tz.frob()).divint(5)
  J=[[qinv,S(0)],[-self.D(q)*azinv,q]]
  jt=[[qinv.frob(),S(0)],[(-5*self.D(q)*azinv).frob(),q.frob()]]
  return {'delta':delta,'J':J,'jet':jt,'tz':tz}
 def transition(self,data,potential,flat_modulus):
  S=self.Ser
  Au=[[S(0),-self.g],[-25*S(potential)*self.g,S(0)]]
  K=[[S(1),S(0)],[S(0),S(1)]];total=K
  power=S(1)
  for j in range(1,7):
   den=math.factorial(j);v=0
   while den%5==0:den//=5;v+=1
   if 5**(j-1-v)>=flat_modulus:break
   K=self.madd(self.scalar(S(5),[[x.deriv() for x in row] for row in K]),self.mm(Au,K))
   divided=[[x.divint(5**v)*S(w.ci(den)) for x in row] for row in K]
   power=(power*data['delta']).mod(flat_modulus)
   term=[[(self.tau(x).frob()*power).mod(flat_modulus) for x in row] for row in divided]
   total=self.mmod(self.madd(total,term),flat_modulus)
  return self.mm(data['jet'],total,flat_modulus)
 def comparison(self,data,GU,GO,potential,flat_modulus,division):
  G=self.transition(data,potential,flat_modulus)
  source_frame=self.mmod(GU,flat_modulus)
  comp=self.mm(self.mm(self.mi(GO,flat_modulus),G,flat_modulus),[[self.tau(x,flat_modulus) for x in row] for row in source_frame],flat_modulus)
  numerator=(self.z*comp[0][1]).mod(flat_modulus)
  return numerator.divint(division).mod(5),G
 def covariant(self,vec,di,B):
  return [(vec[i].deriv()+sum((B[i][j]*vec[j] for j in range(2)),self.Ser(0)))*di for i in range(2)]
 def nil_binomial(self,value,exponent,modulus,order=1):
  # Value is globally p^order-divisible; binomial denominators are units.
  S=self.Ser;value=S(value).mod(modulus)
  coefficient=Fraction(1);terms={}
  for j in range(1,7):
   coefficient=coefficient*(exponent-j+1)/j
   assert coefficient.denominator%5
   num=coefficient.numerator;v=0
   if num:
    while num%5==0:num//=5;v+=1
    if 5**(order*j+v)<modulus:terms[j]=coefficient
  out=S(1);power=S(1)
  for j in range(1,max(terms,default=0)+1):
   power=(power*value).mod(modulus)
   if j in terms:
    c=terms[j];co=S(w.cm(w.ca(c.numerator),w.ci(c.denominator)))
    out=(out+co*power).mod(modulus)
  return out
 def normalize_line(self,h,di,B,outmod,order=1):
  B=self.mmod(B,outmod);di=di.mod(outmod)
  h=[x.mod(outmod) for x in h]
  col=[-x for x in self.covariant(h,di,B)]
  excess=(self.mu*(col[0]*h[1]-col[1]*h[0])-1).mod(outmod)
  assert not np.any(excess.a%(5**order)),('Wronskian valuation',order)
  factor=self.nil_binomial(excess,Fraction(-1,2),outmod,order)
  h=[(factor*x).mod(outmod) for x in h]
  col=[(-x).mod(outmod) for x in self.covariant(h,di,B)]
  self.zero(self.mu*(col[0]*h[1]-col[1]*h[0])-1,outmod,30,'normalized determinant')
  self.zero(self.mu-1,outmod,30,'determinant-one volume convention')
  out=[[col[0],h[0]],[col[1],h[1]]]
  self.frame_certificates[id(out)]=(out,outmod)
  return out
 def corrected(self,I,hodge,di,B,weight=5,outmod=125):
  I=self.mmod(I,outmod)
  h=[(I[i][1]+weight*hodge*I[i][0]).mod(outmod) for i in range(2)]
  order=1 if weight==5 else 2
  return self.normalize_line(h,di,B,outmod,order)
 def corrected_connection(self,I,q,di,Bold,Bnew,Pold,weight=25,outmod=3125):
  """Exact quadratic graph, allowing the actual connection to change.

  Input I is normalized in Bold, not silently in Bnew. In the I frame
  write di*(Bnew-Bold)=weight*C. Normalize h+weight*q*c in Bnew
  using the explicit relative matrix. The omitted cube is zero.
  """
  assert weight**3%outmod==0 and outmod%weight==0
  S=self.Ser;m=outmod//weight
  self.require_exact_frame(I,outmod)
  q=q.mod(m);di0=di.mod(m);P=Pold.mod(m)
  change=[[(Bnew[i][j]-Bold[i][j]).mod(outmod).divint(weight).mod(m)
           for j in range(2)] for i in range(2)]
  C=self.mm(self.mm(self.mi(I,m),self.scalar(di0,change),m),self.mmod(I,m),m)
  self.zero(C[0][0]+C[1][1],m,30,'relative connection trace')
  half=S(w.ci(2));eighth=S(w.ci(8));quarter=S(w.ci(4))
  deriv=lambda x:(x.deriv()*di0).mod(m)
  alpha=(deriv(q)+C[0][1]).mod(m)
  da=deriv(alpha)
  T=[[-half*alpha,q],[q*P+C[0][0]-half*da,half*alpha]]
  linear=self.mm(self.mmod(I,m),self.mmod(T,m),m)
  out=self.mmod(self.madd(I,self.scalar(weight,linear)),outmod)
  # This equality is integral, including unknown Laurent tails: every
  # coefficient of out-I is divisible by weight. Reuse the original
  # frame when reducing to a divisor of weight, rather than inheriting
  # the irrelevant high-weight term's shorter Laurent range.
  self.frame_ancestors[id(out)]=(out,I,weight)
  self.zero(T[0][0]+T[1][1],m,30,'relative graph linear determinant')
  if weight*weight%outmod:
   m2=outmod//(weight*weight)
   q2=q.mod(m2);p2=P.mod(m2);a2=alpha.mod(m2);da2=da.mod(m2)
   c11=C[0][0].mod(m2);c21=C[1][0].mod(m2)
   beta=(p2*q2*q2+2*q2*c11).mod(m2)
   dbeta=(beta.deriv()*di.mod(m2)).mod(m2)
   V=[[half*p2*q2*q2-eighth*a2*a2-half*q2*da2,half*q2*a2],
      [half*a2*(q2*p2+c11)-c21*q2-half*dbeta-3*quarter*a2*da2,
       half*beta+3*eighth*a2*a2]]
   quadratic=self.mm(self.mmod(I,m2),self.mmod(V,m2),m2)
   linear_out=out
   out=self.mmod(self.madd(out,self.scalar(weight*weight,quadratic)),outmod)
   self.frame_ancestors[id(out)]=(out,linear_out,weight*weight)
   determinant_term=V[0][0]+V[1][1]+T[0][0]*T[1][1]-T[0][1]*T[1][0]
   self.zero(determinant_term,m2,30,'relative graph quadratic determinant')
  # det(I)=1 is checked above. The two displayed determinant identities
  # certify det(out)=1 at the entire output precision without multiplying
  # irrelevant high-weight Laurent tails against each other.
  self.frame_certificates[id(out)]=(out,outmod)
  return out
 def potential(self,I,di,B,modulus):
  I=self.mmod(I,modulus);B=self.mmod(B,modulus);di=di.mod(modulus)
  c=[I[i][0] for i in range(2)];h=[I[i][1] for i in range(2)]
  cc=self.covariant(c,di,B);hh=self.covariant(h,di,B)
  result=(-self.mu*(c[0]*cc[1]-c[1]*cc[0])).mod(modulus)
  for i in range(2):
   self.zero(hh[i]+c[i],modulus,30,'actual oper upper entry')
   self.zero(cc[i]+result*h[i],modulus,30,'actual oper potential')
  return result
 def graph(self,I,q,di,P,weight,outmod):
  assert weight*weight%outmod==0
  self.require_exact_frame(I,outmod)
  m=outmod//weight;q=q.mod(m);di=di.mod(m);P=P.mod(m)
  dq=(q.deriv()*di).mod(m);ddq=(dq.deriv()*di).mod(m)
  half=self.Ser(w.ci(2));T=[[-half*dq,q],[q*P-half*ddq,half*dq]]
  delta=self.mm(self.mmod(I,m),self.mmod(T,m),m)
  result=self.mmod(self.madd(I,self.scalar(weight,delta)),outmod)
  self.frame_ancestors[id(result)]=(result,I,weight)
  self.zero(T[0][0]+T[1][1],m,30,'square-zero graph determinant trace')
  self.frame_certificates[id(result)]=(result,outmod)
  return result
 def phi_affine(self,value,modulus):
  value=value.mod(modulus);out=value.frob();derivative=value
  delta=(self.fuz-self.z**5).mod(modulus);power=self.Ser(1)
  for j in range(1,5):
   if 5**j>=modulus:break
   derivative=derivative.deriv();power=(power*delta).mod(modulus)
   out=(out+power*derivative.frob()*self.Ser(w.ci(math.factorial(j)))).mod(modulus)
  return out.mod(modulus)
 def connections(self,PU,PO,modulus):
  S=self.Ser;zu=S(self.o['zeta']);zo=self.z**4*(self.g/self.z**2).frob()
  m=modulus//25
  return [[S(0),-zu],[-25*self.phi_affine(PU,m)*zu,S(0)]],[[S(0),-zo],[-25*PO.mod(m).frob()*zo,S(0)]]
 def jet_check(self,data,G,GU,GO,m,label):
  comp=self.mm(self.mm(self.mi(GO,m),G,m),[[self.tau(x,m) for x in row] for row in GU],m)
  for i in range(2):
   for j in range(2):self.zero(comp[i][j]-data['J'][i][j],m,30,f'{label} {i}{j}')
 def connections2(self):
  S=self.Ser;zu=S(self.o['zeta']);zo=self.z**4*(self.g/self.z**2).frob()
  return [[S(0),-zu],[S(0),S(0)]],[[S(0),-zo],[S(0),S(0)]]
 def first_jet_check(self,data,G,GU,GO):
  whole=self.mm(self.mm(self.mi(GO,25),G,25),[[self.tau(x,25) for x in row] for row in GU],25)
  for i in range(2):
   for j in range(2):self.zero(whole[i][j]-data['J'][i][j],25,30,f'complete corrected first jet {i}{j}')
 def horizontal_check(self,data,G,BU,BO,m):
  tauBU=[[self.tau(x,m) for x in row] for row in BU]
  h=self.madd(self.madd(self.mm(BO,G,m),self.scalar(-data['tz'].deriv(),self.mm(G,tauBU,m))),[[x.deriv() for x in row] for row in G])
  for i in range(2):
   for j in range(2):self.zero(h[i][j],m,30,f'complete inverse-Cartier horizontality {i}{j}')

def base_first(o):
 S=w.Ser;eng=Engine(S,o,S(0));mm=eng.mm
 def affine_lift(records):
  return sum((S(w.ca(row['coefficient']))*o['v']**row['v']*o['u']**row['u'] for row in records),S(0))
 IU=mm([[S(1),affine_lift(o['affine'])],[S(0),S(1)]],eng.mi(o['SU'],w.MOD))
 IO=mm([[S(1),o['qO']],[S(0),S(1)]],eng.mi(o['SO'],w.MOD))
 data=eng.overlap();rho,G=eng.comparison(data,IU,IO,S(0),25,5)
 normal,aff,remainder,records=o['reduce_h1'](rho,n=2)
 assert not np.any(normal),('fixed base first digit',normal)
 aff=affine_lift(records);formal=(remainder/w.Z**2).mod(5)
 assert formal.valuation>=0
 eng.zero(rho-aff-w.Z**2*formal,5,60,'whole canonical first repair')
 BU,BO=eng.connections2()
 GU=eng.corrected(IU,-aff,o['Dz'],BU)
 GO=eng.corrected(IO,formal,w.Z**2*o['Dz'],BO)
 eng.first_jet_check(data,G,GU,GO);eng.horizontal_check(data,G,BU,BO,25)
 rho4,G4=eng.comparison(data,GU,GO,o['R'],125,25)
 normal4,_,_,_=o['reduce_h1'](rho4,n=2)
 return {'IU':IU,'IO':IO,'rho3':rho,'affine':aff,'formal':formal,'records':records,
         'GU':GU,'GO':GO,'rho4':rho4,'normal4':normal4,'checks':eng.checks}
