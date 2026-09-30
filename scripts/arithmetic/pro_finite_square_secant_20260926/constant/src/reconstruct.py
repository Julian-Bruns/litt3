"""Reconstruct the 6-dimensional affine space and normalized degree-140 chart."""
from exact import *
from math import comb
import time

B2=ppow(B0,2);B3=ppow(B0,3);L2=ppow(L0,2);L3=ppow(L0,3)
t2=ppow(t,2);t3=ppow(t,3)
E=pquo(psub(Q,ppow(L0,5)),t3)
y10=[[],ppow(P,3),[]]
SLOTS=[(i,j,k) for k,d in [(2,12),(3,46),(4,57),(5,70)] for i,j in basis(d)]
assert len(SLOTS)==155

def as_G(vec):
 gs={k:cp(ZERO) for k in [2,3,4,5]}
 for u,(i,j,k) in zip(vec,SLOTS):
  if u:
   v=monomial(i,j)
   if k==2:v=cmul(v,monomial(0,2))
   gs[k]=cadd(gs[k],cscale(v,u))
 return gs

def linear_values(gs,inhom=False):
 g2,g3,g4,g5=(gs[i] for i in [2,3,4,5])
 r=[]
 r+=flatten(crem_y(csub(g3,cscale(cmulpoly(g2,B0),3)),3),(10,10,10))
 r+=flatten(crem_y(cadd(csub(g4,cscale(cmulpoly(g3,B0),2)),cscale(cmulpoly(g2,B2),3)),4),(20,10,10))
 r+=flatten(crem_y(csub(cadd(csub(g5,cmulpoly(g4,B0)),cmulpoly(g3,B2)),cmulpoly(g2,B3)),5),(20,20,10))
 c0=cmulpoly(cadd(csub(cadd(cneg(cmulpoly(g2,L3)),cmulpoly(g3,L2)),cmulpoly(g4,L0)),g5),E)
 if inhom:c0=cadd(c0,y10)
 r+=flatten(crem_poly(c0,t2),(6,6,6))
 c1=cadd(csub(cscale(cmulpoly(g2,L2),3),cscale(cmulpoly(g3,L0),2)),g4)
 r+=flatten(crem_poly(c1,t),(3,3,3))
 tail=cmulpoly(g5,Q)
 if inhom:tail=cadd(tail,cmulpoly(y10,t3))
 r+=[coeff(tail,42,0),coeff(tail,39,1)]
 assert len(r)==149
 return r

def coordinates(gs):
 d2=cdiv_y(gs[2],2)
 return [coeff(d2,4),coeff(gs[4],19),coeff(gs[4],12,2),coeff(gs[5],16,2)]

LINEAR_FILE=ROOT/'evidence/affine_basis.json'
def reconstruct_linear():
 assert pder(Q)==pmul(P,ppow(A,2))
 assert pgcd(P,pder(P))==[1] and pgcd(A,pder(A))==[1]
 assert pgcd(P,A)==[1] and pgcd(E,t)==[1]
 assert not pmod(psub(Q,ppow(B0,5)),ppow(P,2))
 assert not pmod(psub(Q,ppow(L0,5)),ppow(A,3))
 zero=as_G([0]*155);const=linear_values(zero,True)
 columns=[]
 for i in range(155):
  v=[0]*155;v[i]=1;columns.append(linear_values(as_G(v)))
 rows=[[columns[c][r] for c in range(155)]+[neg(const[r])] for r in range(149)]
 part,ker,meta=solve_affine(rows,155)
 check_affine(rows,part,ker)
 piv=meta['pivot_columns']; minor=array('I',(row[j] for row in rows for j in piv))
 mp=(ctypes.c_uint32*len(minor)).from_buffer(minor)
 lib.matrix_det.restype=ctypes.c_uint32
 minor_det=lib.matrix_det(mp,len(piv));assert minor_det
 assert len(ker)==6
 # Coordinate normalization: get affine section and a two-dimensional kernel.
 co=[coordinates(as_G(v)) for v in ker];base=coordinates(as_G(part))
 coordrows=[[co[j][i] for j in range(6)]+[neg(base[i])] for i in range(4)]
 sec0,k2,cmeta=solve_affine(coordrows,6)
 assert len(k2)==2
 def combine(s,offset):
  return [add(offset[i],dot([v[i] for v in ker],s)) for i in range(155)]
 origin=combine(sec0,part)
 sect=[]
 for j in range(4):
  rr=[row[:] for row in coordrows]
  for i in range(4):rr[i][-1]=1 if i==j else 0
  sv,_,_=solve_affine(rr,6);sect.append(combine(sv,[0]*155))
 finalkernel=[combine(v,[0]*155) for v in k2]
 assert coordinates(as_G(origin))==[0]*4
 for j,sv in enumerate(sect):assert coordinates(as_G(sv))==[int(i==j) for i in range(4)]
 for sv in finalkernel:assert coordinates(as_G(sv))==[0]*4
 # Verify independent given epsilon and c=C_d w relations.
 for v,aff in [(origin,True)]+[(z,False) for z in sect+finalkernel]:
  gs=as_G(v)
  assert coeff(gs[3],12,1)==(EPS if aff else 0)
  assert coeff(gs[3],15)==mul(CD,coeff(gs[4],19))
 obj={'field_size':QFIELD,'field_generator_code':GENERATOR,'slots':SLOTS,'origin':origin,'sections':sect,'kernel':finalkernel,'rank':meta['rank'],'coordinate_rank':cmeta['rank'],'congruence_rows':149,'columns':155,'pivot_columns':piv,'free_columns':meta['free_columns'],'pivot_minor_determinant':minor_det}
 LINEAR_FILE.write_text(json.dumps(obj,separators=(',',':'))+'\n')
 return obj

def load_linear():
 return json.loads(LINEAR_FILE.read_text()) if LINEAR_FILE.exists() else reconstruct_linear()

# Truncated power series in xi, precision normally 7.
def smul(a,b,n):return (pmul(a,b)+[0]*n)[:n]
def sadd(a,b,n):return (padd(a,b)+[0]*n)[:n]
def sscale(a,c,n):return (pscale(a,c)+[0]*n)[:n]
def spow(a,e,n):
 r=[1]+[0]*(n-1)
 while e:
  if e&1:r=smul(r,a,n)
  a=smul(a,a,n);e//=2
 return r

def Yseries(n):
 # Cube root of reversed P(x) after x=xi^-3. 3 is invertible.
 v=[0]*n
 for i,c in enumerate(P):
  if 30-3*i<n:v[30-3*i]=c
 y=[1]+[0]*(n-1)
 for k in range(1,n):
  known=spow(y,3,k+1)[k]
  y[k]=div(sub(v[k],known),3)
 assert spow(y,3,n)==v
 return y

def infinity(a,shift,n):
 y=Yseries(n);yp=[spow(y,j,n) for j in range(3)];ans=[0]*n
 for j,pol in enumerate(a):
  for i,c in enumerate(pol):
   if not c:continue
   k=shift-3*i-10*j
   if k<0:raise ArithmeticError(f'negative series power {k}')
   for m in range(n-k):ans[k+m]=add(ans[k+m],mul(c,yp[j][m]))
 return ans

def Fseries(gs,h,w,n=7):
 aa=sscale(infinity(gs[2],35,n),3,n)
 bb=sscale(infinity(gs[3],46,n),2,n)
 cc=infinity(gs[4],57,n)
 assert aa[0]==0 and bb[0]==mul(2,EPS)
 rr=[div(mul(2,w),EPS)]+[0]*(n-1)
 for k in range(1,n):
  val=sadd(sadd(smul(aa,spow(rr,2,k+1),k+1),smul(bb,rr,k+1),k+1),cc,k+1)[k]
  rr[k]=div(neg(val),bb[0])
 assert sadd(sadd(smul(aa,spow(rr,2,n),n),smul(bb,rr,n),n),cc,n)==[0]*n
 first=sadd(infinity(frompoly(Q),57,n),[0,0]+spow(rr,5,n),n)
 second=sadd(infinity(gs[5],70,n),[0,0]+sadd(smul(aa,spow(rr,3,n),n),sscale(smul(bb,spow(rr,2,n),n),2,n),n),n)
 return sadd(smul(first,second,n),infinity(cmulpoly(y10,t3),127,n),n)

def make_chart(h,w,verify=True):
 if not h or not w:raise ValueError('h,w must be nonzero')
 obj=load_linear();z=div(mul(2,w),EPS);c=mul(CD,w)
 e=sub(neg(mul(c,z)),div(ETA,mul(24,z)))
 f=sub(neg(div(mul(w,w),EPS)),mul(div(8,24),power(z,5)))
 coords=[h,w,e,f]
 base=[add(obj['origin'][i],dot([v[i] for v in obj['sections']],coords)) for i in range(155)]
 gs=as_G(base);ff=Fseries(gs,h,w)
 assert ff[:4]==[0]*4
 fs=[]
 for v in obj['kernel']:
  vec=[add(a,b) for a,b in zip(base,v)]
  fv=Fseries(as_G(vec),h,w)
  fs.append([sub(fv[i],ff[i]) for i in [4,5]])
 rows=[[fs[j][i] for j in range(2)]+[neg(ff[4+i])] for i in range(2)]
 sol,ker,_=solve_affine(rows,2);assert not ker
 vec=[add(base[i],dot([v[i] for v in obj['kernel']],sol)) for i in range(155)]
 gs=as_G(vec);fv=Fseries(gs,h,w)
 assert fv[:6]==[0]*6
 H=mul(h,w);q=power(w,3)
 expected=div(add(peval(A0,q),mul(peval(A1,q),H)),mul(q,power(PSISCALE,2)))
 assert fv[6]==expected,(fv[6],expected)
 det=sub(mul(fs[0][0],fs[1][1]),mul(fs[1][0],fs[0][1]))
 if verify:
  assert linear_values(gs,True)==[0]*149
  assert coordinates(gs)==coords
  assert pole(cdiv_y(gs[2],2))==12
 return {'h':h,'w':w,'H':H,'q':q,'z':z,'e':e,'f':f,'kernel_coordinates':sol,'determinant':det,'F6':fv[6],'G':gs}

if __name__=='__main__':
 st=time.time();obj=reconstruct_linear()
 print(json.dumps({k:v for k,v in obj.items() if k not in ['slots','origin','sections','kernel']},sort_keys=True))
 tests=[]
 for h,w in [(1,1),(1,2),(2,3),(25,6),(12345,67890)]:
  d=make_chart(h,w)
  tests.append({k:v for k,v in d.items() if k!='G'})
 print(json.dumps(tests,sort_keys=True))
 print('seconds',time.time()-st)
 (ROOT/'evidence/reconstruction_checks.json').write_text(json.dumps(tests,indent=2)+'\n')
