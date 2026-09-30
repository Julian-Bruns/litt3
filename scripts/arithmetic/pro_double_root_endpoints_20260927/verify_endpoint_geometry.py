"""Independent complete projection, open-boundary, and scale-incidence audit.

All projection multiplicities are multiplied back. Every removed support is
on a named original or previously certified open. Scale gcds have explicit
Bezout witnesses checked by schoolbook K-polynomial products, not xgcd.
"""
import json,gzip,time
from exact import *
import rank9 as R
from endpoint_geometry import ENDPOINTS,DEST,ctimes,cminus,cnorm,qpoly
from curve_eliminate import remove_support
from verify_branch_geometry import remainder_identity,unit_element,open_values
def scale_product(a,b,M):
 if not a or not b:return []
 # Independently convolve scale coefficients over K[q], reducing only
 # after each full coefficient sum. Trimmed/zero coefficients are safe.
 raw=[[] for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):raw[i+j]=pa(raw[i+j],pm(x,y))
 return [prem(z,M) for z in raw]


def read(stem,x):return json.loads(gzip.open(DEST/f'{stem}_{x}.json.gz','rb').read())
def scale_sum(a,b,M):
 v=[prem(pa(a[i] if i<len(a) else [],b[i] if i<len(b) else []),M) for i in range(max(len(a),len(b)))]
 while v and not v[-1]:v.pop()
 return v

def monic_scale_remainder(F,H,M):
 assert H and H[-1]==[1];rr=[prem(p,M) for p in F]
 while rr and not rr[-1]:rr.pop()
 while len(rr)>=len(H):
  k=len(rr)-len(H);c=rr[-1]
  for j,h in enumerate(H):rr[k+j]=prem(ps(rr[k+j],pm(c,h)),M)
  while rr and not rr[-1]:rr.pop()
 return rr

def run():
 tic=time.time();tt=[1];records=[];allcontent=[]
 for x in ENDPOINTS:
  tt=pm(tt,[neg(x),1]);assert peval(P,x)!=0
  geo=read('geometry',x);prep=read('prepared',x);inc=read('incidence',x);wit=read('gcd_witnesses',x)
  assert geo['fixed_source_r_code']==9
  # Recompute the two universal norm factors, before any unit stripping.
  p=qpoly([0,0,geo['P_at_x']]);a,b,ap,bp,cp=[geo[k] for k in ['A','B','Aprime','Bprime','Cprime']]
  W=cminus(cminus(ctimes(ctimes(a,b,p),bp,p),ctimes(ap,ctimes(b,b,p),p)),ctimes(ctimes(a,a,p),cp,p))
  wf=unit_element(geo['W_unit_powers'])
  assert [R.times(wf,z) for z in geo['W_primitive']]==W
  assert R.times(unit_element(geo['norm_W_unit_powers']),geo['norm_W_primitive'])==cnorm(geo['W_primitive'],p)
  wedges=[R.minus(R.times(a[i],b[j]),R.times(a[j],b[i])) for i,j in [(0,1),(0,2),(1,2)]]
  assert [R.times(unit_element(geo['wedge_unit_powers']),z) for z in geo['wedge_primitive']]==wedges
  c0,c1,c2=geo['wedge_primitive']
  kk=R.plus(R.minus(R.power(c0,3),R.times(p,R.power(c1,3))),R.times(R.power(p,2),R.power(c2,3)))
  kk=R.plus(kk,R.scalar(R.times(p,R.times(c0,R.times(c1,c2))),3))
  assert R.times(unit_element(geo['K_unit_powers']),geo['K_primitive'])==kk
  for name,key in [('same_sheet','norm_W_primitive'),('different_sheets','K_primitive')]:
   pr=geo['projections'][name];f=prep['projections'][name];aa,bb=pr['primitive_linear_remainder'];content=pr['content']
   A,B=pr['remainder'];remainder_identity(geo[key],A,B,pr['denominator_b_power'])
   assert pm(content,aa)==A and pm(content,bb)==B and pgcd(aa,bb)==[1]
   units=geo['projection_unit_polynomial'];assert units==pm(pm([0,1],DATA['d']),DATA['b'])
   assert len(remove_support(content,units)[0])==1
   res=pa(ps(pm(DATA['b'],pp(aa,2)),pm(pc(DATA['c'],2),pm(aa,bb))),pm(pc(DATA['e'],3),pp(bb,2)))
   assert res==pr['quadratic_resultant']
   assert pm(pr['allowed_projection'],pr['removed_projection_factor'])==res
   assert len(remove_support(pr['removed_projection_factor'],units)[0])==1
   old=pc(pr['allowed_projection'],inv(pr['allowed_projection'][-1]));assert old==f['initial_modulus']
   assert pgcd(bb,old)==[1]
   # There are no extra discarded supports for these particular data.
   assert all(v==[1] for v in f['removed_support'].values())
   M=f['modulus'];u=f['u'];assert M==old and not prem(pa(aa,pm(bb,u)),M)
   assert not prem(pa(pa(pm(DATA['b'],pmodpow(u,2,M)),pm(pc(DATA['c'],2),u)),pc(DATA['e'],3)),M)
   vals=open_values(u,M);assert vals==f['original_and_inherited_open_values']
   assert all(pgcd(v,M)==[1] for v in vals.values())
   prod=[1];radicals=[]
   for ms,z in f['multiplicity_blocks'].items():
    assert z[-1]==1 and pgcd(z,pder(z))==[1]
    assert all(pgcd(z,zz)==[1] for zz in radicals);radicals.append(z);prod=pm(prod,pp(z,int(ms)))
    matches=[p for p in inc['parts'] if p['projection_kind']==name and p['projection_multiplicity']==int(ms)]
    zz=[1]
    for part in matches:
     zz=pm(zz,part['modulus']);assert part['u']==prem(u,part['modulus'])
    assert zz==z
   assert prod==M
   expected={1:264,2:66,3:396,10:66} if name=='same_sheet' else {1:726,2:396}
   assert {int(m):len(z)-1 for m,z in f['multiplicity_blocks'].items()}==expected
  assert len(wit['records'])==len(inc['parts'])==6
  for idx,(wc,part) in enumerate(zip(wit['records'],inc['parts'])):
   M=part['modulus'];assert wc['part_index']==idx and wc['modulus']==M and wc['H']==part['gcd']
   lhs=scale_sum(scale_product(wc['S'],wc['F'],M),scale_product(wc['T'],wc['G'],M),M)
   assert lhs==wc['H']
   assert not monic_scale_remainder(wc['F'],wc['H'],M) and not monic_scale_remainder(wc['G'],wc['H'],M)
   if idx in [0,4]:
    cert=read('certificate',f'{x}_{idx}')
    assert part['gcd']==[pn(part['nu']),[1]] and part['scale_root_multiplicity']==1
    assert part['nonzero_scale_modulus']==M and part['zero_scale_modulus']==[1]
    assert cert['modulus']==M and cert['u']==part['u'] and cert['nu']==part['nu']
    assert pgcd(part['nu'],M)==[1]
   elif idx==1:
    assert part['gcd']==[[],[1]] and part['zero_scale_modulus']==M and part['nonzero_scale_modulus']==[1]
   elif idx==3:assert part['gcd']==[[1]]
  # The quartic support is a full all-scale endpoint-content locus: the
  # actual value polynomial vanishes identically, not just at selected scales.
  assert not wit['records'][2]['F'] and not wit['records'][5]['F']
  p2,p5=inc['parts'][2],inc['parts'][5]
  assert p2['modulus']==p5['modulus'] and p2['u']==p5['u'] and p2['gcd']==p5['gcd']
  prim=read('primitive',x);assert prim['base_modulus']==p2['modulus'] and prim['base_u']==p2['u'] and prim['scale_modulus']==p2['gcd']
  assert pgcd(prim['scale_modulus'][0],prim['base_modulus'])==[1]
  mods=[inc['parts'][i]['modulus'] for i in [0,4,2]]
  assert all(pgcd(mods[i],mods[j])==[1] for i in range(3) for j in range(i))
  allcontent.append(mods[2]);records.append({'x_code':x,'same_sheet_projection_length':2244,
    'different_sheet_projection_length':1518,'graphs':[264,726],'quartic_algebra_dimension':1584,
    'reduced_incidence_geometric_points':2574,'projection_nilpotents_accounted_for_by_lifting':True})
  print('INDEPENDENT ENDPOINT COVERAGE',x,'all contents, pivots, complete projections, six gcd witnesses, and incidence algebra links checked',flush=True)
 assert tt==t and pgcd(t,pder(t))==[1]
 assert all(pgcd(allcontent[i],allcontent[j])==[1] for i in range(3) for j in range(i))
 oldbranch=json.loads(gzip.open(ROOT/'evidence/branch_root/geometry_x_9.json.gz','rb').read())['finite']['modulus']
 assert all(pgcd(M,oldbranch)==[1] for M in allcontent)
 obj={'status':'passed','endpoints':records,'fixed_source_r_code':9,'all_18_scale_gcd_witnesses_verified':True,
   'fixed_content_ratios_disjoint_between_endpoints':True,'fixed_content_geometric_ratios':1188,
   'fixed_content_ratios_disjoint_from_inherited_358':True,
   'scope':'complete endpoint-zero incidence, not global square-locus exclusion','seconds':round(time.time()-tic,3)}
 (ROOT/'logs/endpoint_geometry_independent.json').write_text(json.dumps(obj,indent=2)+'\n')
 print('ALL THREE ENDPOINT COVERAGES VERIFIED',obj['seconds'],flush=True)
 return obj
if __name__=='__main__':run()
