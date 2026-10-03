#!/usr/bin/env sage
"""New bounded quotient-space probe; no actual source realization claim."""
import argparse,json,time
from pathlib import Path
from itertools import combinations
from math import comb
ap=argparse.ArgumentParser();ap.add_argument('--c-fiber',type=int,default=0);ap.add_argument('--certificates',action='store_true');args=ap.parse_args()
started=time.time()
E=GF(5**24,'e');R=PolynomialRing(E,'x');x=R.gen()
beta=(x*x-x-3).roots(multiplicities=False)[0]
def code(c):return E(c%5)+E(c//5)*beta
def poly(a):return R([code(c) for c in a])
P=poly([11,22,18,5,19,20,15,16,9,22,1])
A=poly([1,21,14,22,13]);Z=poly([15,19,24,12,10,19,3,24,18,16])
d=poly([1,22,9,1]);K,rem=(Z*d).quo_rem(P)
roots=d.roots(multiplicities=False);r0=code(8) if args.c_fiber==0 else next(r for r in roots if r!=code(8))
assert r0 in roots and all(P(r) for r in roots)
others=[r for r in roots if r!=r0]
def cubes(r):return (x**3-P(r)).roots(multiplicities=False)
Y0=cubes(r0);Y1=cubes(others[0]);Y2=cubes(others[1])
gvalues=[K(r)**3*P(r) for r in roots]
assert len(set(gvalues))==3,'Expand the C-single support at multiple fibers boundary'
ball_single=[]
for yy0 in Y0:
 for yy1 in Y1:
  for yy2 in Y2:
   candidate=R.lagrange_polynomial([(r0,-2*K(r0)*yy0),(others[0],-2*K(others[0])*yy1),(others[1],-2*K(others[1])*yy2)])
   if candidate.degree()<=1:ball_single.append(str(candidate))
assert not ball_single,'Expand B-one-sheet at all three fibers boundary'
endpoints=[(r,y) for r in A.roots(multiplicities=False)[:0] for y in []]
# One of the four A roots is omitted by the actual degree-ten support.
# Every omitted-root choice is retained separately below.
aroots=A.roots(multiplicities=False)
assert len(aroots)==4
def add(f,g):return [f[i]+g[i] for i in range(3)]
def scale(f,c):return [c*g for g in f]
def mul(f,g):
 h=[R.zero() for _ in range(5)]
 for i in range(3):
  for j in range(3):h[i+j]+=f[i]*g[j]
 h[0]+=P*h[3];h[1]+=P*h[4]
 return h[:3]
def pi(f,n):
 out=[R.zero() for _ in range(3)]
 for char,h in enumerate(f):
  quotient,target=divmod(char-n,3);raw=Z**n*h
  out[target]+=raw*P**quotient if quotient>=0 else raw.quo_rem(P**(-quotient))[0]
 return out
def finite_from_eta(etas):
 out=[[R.zero() for _ in range(3)] for _ in range(4)]
 for j in reversed(range(4)):
  out[j]=etas[j][:]
  for h in range(j+1,4):out[j]=add(out[j],scale(pi(out[h],h-j),-E(comb(h,j))))
 return out
basis=[]
for j in range(4):
 for char in range(3):
  for a in range((22-j-10*char)//3+1):
   etas=[[R.zero() for _ in range(3)] for _ in range(4)]
   etas[j][char]=x**a;basis.append(finite_from_eta(etas))
assert len(basis)==50
def ev(f,r,y):return sum((f[c](r)*y**c for c in range(3)),E.zero())
S=PowerSeriesRing(E,'s',default_prec=3);s=S.gen()
def series_polynomial(g,r):return S(g(R(r)+R.gen())) if False else sum((S(c)*(r+s)**j for j,c in enumerate(g)),S.zero())
def endpoint_rows(r,y):
 pp=series_polynomial(P,r);yy=S(y)
 for j in range(1,3):yy+=((pp-yy**3)[j]/(3*y*y))*s**j
 aa=series_polynomial(Z,r)/yy
 rows={(j,t):[] for j in range(3) for t in range(3-j)}
 for fs in basis:
  fseries=[sum((series_polynomial(f[c],r)*yy**c for c in range(3)),S.zero()) for f in fs]
  for j,t in rows:
   g=sum((E(comb(h,j))*aa**(h-j)*fseries[h] for h in range(j,4)),S.zero())
   rows[j,t].append(g[t])
 return rows
allrows={(r,y):endpoint_rows(r,y) for r in aroots for y in cubes(r)}
def coords(v):return [int(a) for a in v.polynomial().list()]
records=[]
# Cyclic simultaneous y-rotation lets Y0[0] represent the three choices.
yc=Y0[0];gamma=K(r0)*yc
for yb1 in Y1:
 for yb2 in Y2:
  # c has poles on one sheet at r0 and the two complementary sheets
  # at the other two fibers. b has the complementary support.
  poles=[(r0,yc)]+[(others[0],y) for y in Y1 if y!=yb1]+[(others[1],y) for y in Y2 if y!=yb2]
  content=[[ev(fs[j],r,y) for fs in basis] for r,y in poles for j in range(4)]
  av=[K(r0)*yc**2,-gamma*yb1-K(others[0])*yb1**2,-gamma*yb2-K(others[1])*yb2**2]
  xs=[r0]+others;aa=R.lagrange_polynomial(list(zip(xs,av)))
  for omitted in aroots:
   endpoints=[(r,y) for r in aroots if r!=omitted for y in cubes(r)]
   cbase={pt:(K(pt[0])*pt[1]**2+aa(pt[0])+gamma*pt[1])/d(pt[0])-Z(pt[0])/pt[1] for pt in endpoints}
   # All possible endpoint-zero sets of c=base+mu+nu*x, nu!=0.
   zerosets={()}
   for pt in endpoints:zerosets.add((pt,))
   for u,w in combinations(endpoints,2):
    if u[0]==w[0]:
     if cbase[u]==cbase[w]:raise AssertionError('coincident endpoint-zero lines: expand this boundary')
     continue
    nu=(cbase[u]-cbase[w])/(w[0]-u[0]);mu=-cbase[u]-nu*u[0]
    if not nu:continue
    hit=tuple(pt for pt in endpoints if mu+nu*pt[0]+cbase[pt]==0)
    zerosets.add(hit)
   dims=[];certificates=[]
   if args.certificates:
    base=matrix(E,content+[row for pt in endpoints for (j,t),row in allrows[pt].items() if t<2-j])
    ker=base.right_kernel_matrix();kk=ker.nrows();br=base.rank()
    assert br+kk==50 and (base*ker.transpose()).is_zero()
    brow=list(base.transpose().pivots());bcol=list(base.pivots());bdet=base.matrix_from_rows_and_columns(brow,bcol).det()
    assert bdet
   for hit in zerosets:
    if args.certificates:
     tags=[(i,j,t) for i,pt in enumerate(endpoints) if pt not in hit for (j,t) in allrows[pt] if t==2-j]
     extra=matrix(E,[allrows[endpoints[i]][j,t] for i,j,t in tags])*ker.transpose()
     rank=extra.rank();dims.append((len(hit),kk-rank))
     piv=list(extra.transpose().pivots());det=extra.matrix_from_rows(piv).det() if rank==kk else E.zero()
     certificates.append({'zero_endpoint_indices':[endpoints.index(pt) for pt in hit],'extra_pivot_row_tags':[tags[i] for i in piv],'extra_rank':int(rank),'extra_minor':coords(det)})
    else:
     selected=content[:]
     for pt in endpoints:
      for (j,t),row in allrows[pt].items():
       if pt in hit and t==2-j:continue
       selected.append(row)
     rank=matrix(E,selected).rank();dims.append((len(hit),50-rank))
   records.append({'critical_c_sheet':str(yc),'critical_b_sheets':[str(yb1),str(yb2)],'omitted_A_root':str(omitted),'zero_patterns':len(dims),'max_selected_c_zeros':max(k for k,n in dims),'max_quotient_kernel_dimension':max(n for k,n in dims),'nonzero_kernels':[(k,n) for k,n in dims if n]})
   if args.certificates:records[-1]['certificate']={'critical_c_point':[coords(r0),coords(yc)],'critical_b_points':[[coords(others[0]),coords(yb1)],[coords(others[1]),coords(yb2)]],'omitted_A_root':coords(omitted),'selected_endpoints':[[coords(r),coords(y)] for r,y in endpoints],'base_rank':int(br),'base_pivot_rows':brow,'base_pivot_columns':bcol,'base_minor':coords(bdet),'base_kernel':[[coords(v) for v in row] for row in ker.rows()],'endpoint_strata':certificates}
   print(len(records),'max_c_zeros',records[-1]['max_selected_c_zeros'],'max_kernel',records[-1]['max_quotient_kernel_dimension'],'seconds',time.time()-started,flush=True)
   if time.time()-started>105:break
  if time.time()-started>105:break
 if time.time()-started>105:break
out=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');out.mkdir(exist_ok=True)
report={'scope':'new necessary quotient-space probe at fixed delta3=q3 over F5^24; no generic-lambda or actual-source decision','critical_itinerary':'c-one-sheet at one q3 root, b-one-sheet at the two other roots; all simultaneous cyclic c-sheet rotations represented by symmetry','c_fiber':int(args.c_fiber),'critical_c_x':str(r0),'G_values_distinct':len(set(gvalues))==3,'B_one_sheet_all_three_impossible':not ball_single,'field_order':str(E.order()),'recorded_patterns':len(records),'complete_patterns':len(records)==36,'records':records,'seconds':time.time()-started}
report.update({'field_modulus':[int(c) for c in E.modulus().list()],'beta_coordinates':coords(beta),'critical_x_roots':[coords(r) for r in roots],'G_values':[coords(v) for v in gvalues],'sage_version':version(),'explicit_certificates':bool(args.certificates)})
(out/('quotient_probe_q3_%s%s.json'%(args.c_fiber,'_certified' if args.certificates else ''))).write_text(json.dumps(report,indent=2,default=int)+'\n')
print('DONE',len(records),time.time()-started,flush=True)
