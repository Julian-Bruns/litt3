"""Independent polynomial-identity audit of every projection and open boundary.
The fraction-free remainder is checked by polynomial long division after
clearing b^n, not by the recurrence used in construction. All removed supports
are proved to lie on named, previously excluded units. All pivots are checked
on entire finite algebras; no generic-only inversion is accepted.
"""
from exact import *
import rank9 as R
from branch_geometry import ROOTS
from branch_root import extract
from curve_eliminate import remove_support
import gzip,json,time

def read(x):return json.loads(gzip.open(ROOT/'evidence/branch_root'/f'geometry_x_{x}.json.gz','rb').read())
def unit_element(powers):
 q=R.zero();q[1]=[1];u=R.zero();u[0]=[0,1]
 dr=neg(div(DATA['d'][0],DATA['d'][1]));d=R.zero();d[0]=[neg(dr)];d[1]=[1]
 return R.times(R.times(R.power(q,powers['q']),R.power(d,powers['d_monic'])),R.power(u,powers['u']))
def eval_r(p,u,M):
 # Horner in u, with q-polynomial coefficients (opposite nesting to construction).
 ans=[]
 for i in range(max(map(len,p))-1,-1,-1):
  c=trim([p[j][i] if i<len(p[j]) else 0 for j in range(9)])
  ans=prem(pa(pm(ans,u),c),M)
 return ans

def remainder_identity(h,a,b,n):
 B=DATA['b'];Bn=pp(B,n);rows=[]
 for i in range(max(map(len,h))):rows.append(pm(trim([h[j][i] if i<len(h[j]) else 0 for j in range(9)]),Bn))
 while len(rows)<2:rows.append([])
 rows[0]=ps(rows[0],a);rows[1]=ps(rows[1],b)
 for i in range(len(rows)-1,1,-1):
  t=pexact(rows[i],B)
  rows[i]=ps(rows[i],pm(t,B));assert not rows[i]
  rows[i-1]=ps(rows[i-1],pm(t,pc(DATA['c'],2)))
  rows[i-2]=ps(rows[i-2],pm(t,pc(DATA['e'],3)))
 assert not rows[0] and not rows[1]

def open_values(u,M):
 b,c,e=[DATA[k] for k in ['b','c','e']]
 out={'q':[0,1],'u':u,'d':DATA['d'],'b':b,'e':e,
      'q10149':[neg(10149),1],'q64426':[neg(64426),1],
      'ordinary_double':prem(pa(pm(b,u),c),M),
      'leading_companion':pa(pp(c,2),pm(b,e)),
      'u24_minus1':ps(pmodpow(u,24,M),[1]),
      'Delta0':json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())['zero_F_projection']['polynomial']}
 out['F']=prem(pa(pa(pm(DATA['a0'],pmodpow(u,3,M)),pm(b,pmodpow(u,2,M))),pa(pm(c,u),e)),M)
 return out

def run():
 tic=time.time();prod=[1]
 for x in ROOTS:prod=pm(prod,[neg(x),1])
 assert prod==DATA['P'] and pgcd(prod,pder(prod))==[1] and DATA['r']==9
 records=[];moduli=[]
 for x in ROOTS:
  d=read(x);pr=d['projection'];fin=d['finite'];comp=d['components']['components']
  assert d['fixed_source_r_code']==9 and d['components']['fixed_source_r_code']==9
  actual=extract(x)
  for j in range(3):
   fac=unit_element(comp[j]['stripped_common_units'])
   for s in range(3):assert R.times(fac,comp[j]['nu_coefficients'][s])==actual[j][s]
  c,b,a=comp[0]['nu_coefficients'];f,e,dd=comp[1]['nu_coefficients']
  if x==9:
   assert a==dd==R.zero();det=R.minus(R.times(b,f),R.times(c,e))
  else:
   v=R.minus(R.times(a,f),R.times(c,dd));w=R.minus(R.times(a,e),R.times(b,dd));z=R.minus(R.times(b,f),R.times(c,e))
   det=R.minus(R.times(v,v),R.times(w,z));assert pr['scale_subresultants']==[v,w,z]
  assert R.times(pr['determinant'],unit_element(pr['determinant_unit_powers']))==det
  A,B=pr['remainder'];aa,bb=pr['primitive_linear_remainder'];content=pr['content']
  remainder_identity(pr['determinant'],A,B,pr['denominator_b_power'])
  assert pm(content,aa)==A and pm(content,bb)==B and pgcd(aa,bb)==[1]
  units=pm(pm([0,1],DATA['d']),DATA['b']);assert pr['units_used_to_remove']==units
  assert len(remove_support(content,units)[0])==1
  res=pa(ps(pm(DATA['b'],pp(aa,2)),pm(pc(DATA['c'],2),pm(aa,bb))),pm(pc(DATA['e'],3),pp(bb,2)))
  assert res==pr['quadratic_resultant']
  allowed=pr['allowed_projection'];removed=pr['removed_projection_factor']
  assert pm(allowed,removed)==res and pgcd(allowed,units)==[1]
  assert len(remove_support(removed,units)[0])==1
  M=fin['modulus'] if x==9 else fin['allowed_ratio_modulus'];u=fin['u']
  assert M==pc(allowed,inv(allowed[-1]))
  assert pgcd(bb,M)==[1] and not prem(pa(aa,pm(bb,u)),M)
  assert not prem(pa(pa(pm(DATA['b'],pmodpow(u,2,M)),pm(pc(DATA['c'],2),u)),pc(DATA['e'],3)),M)
  opens=open_values(u,M)
  assert all(pgcd(v,M)==[1] for v in opens.values())
  if x==9:
   assert len(M)-1==170
   records.append({'x_code':9,'complete_ratio_length':170,'all_original_and_inherited_units_checked':True})
   moduli.append((x,M))
  else:
   cc,bb0,aa0=[eval_r(v,u,M) for v in [c,b,a]]
   ff,ee,dd0=[eval_r(v,u,M) for v in [f,e,dd]]
   vv=prem(ps(pm(aa0,ff),pm(cc,dd0)),M);ww=prem(ps(pm(aa0,ee),pm(bb0,dd0)),M)
   assert vv==fin['scale_numerator'] and ww==fin['scale_pivot'] and pgcd(ww,M)==[1]
   assert fin['scale_pivot_boundary_modulus']==[1] and fin['scale_graph_before_nonzero']==M
   G=fin['scale_graph_modulus'];zero=fin['excluded_zero_scale_factor'];nu=fin['nu']
   assert pm(G,zero)==M and len(remove_support(zero,vv)[0])==1 and pgcd(G,vv)==[1]
   assert not prem(pa(pm(ww,nu),vv),G)
   assert not prem(pa(pa(pm(aa0,pmodpow(nu,2,G)),pm(bb0,nu)),cc),G)
   assert not prem(pa(pa(pm(dd0,pmodpow(nu,2,G)),pm(ee,nu)),ff),G)
   assert len(M)-1==530 and len(G)-1==486 and len(zero)-1==44 and pgcd(nu,G)==[1]
   records.append({'x_code':x,'complete_ratio_length':530,'nonzero_scale_graph_length':486,
                   'zero_scale_support_length':44,'scale_pivot_is_unit_on_whole_ratio_algebra':True,
                   'all_original_and_inherited_units_checked':True})
   moduli.append((x,G))
  print('INDEPENDENT COMPLETE GEOMETRY',x,flush=True)
 # Distinct q projections, not an assumption of symmetry between P-roots.
 assert all(pgcd(moduli[i][1],moduli[j][1])==[1] for i in range(len(moduli)) for j in range(i))
 result={'status':'passed','branches':records,'branch_projections_pairwise_coprime':True,
         'fixed_source_r_code':9,'bounded_search':False,'seconds':round(time.time()-tic,3)}
 (ROOT/'logs/branch_geometry_independent.json').write_text(json.dumps(result,indent=2)+'\n')
 print('ALL TEN COMPLETE BRANCH GEOMETRIES INDEPENDENTLY VERIFIED',result['seconds'],flush=True)
 return result
if __name__=='__main__':run()
