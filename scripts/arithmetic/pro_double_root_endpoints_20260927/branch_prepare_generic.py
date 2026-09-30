"""Exact scale graph plus retained pivot boundary for branch norm incidence."""
from exact import *
from curve_eliminate import remove_support
from branch_prepare import eval_ring
import json,time,sys

def run(x):
 tic=time.time();base=ROOT/'work/branch_root'/f'x_{x}';d=json.loads((base/'data.json').read_text());p=json.loads((base/'projection.json').read_text())
 M=p['allowed_projection'];M=pc(M,inv(M[-1]));a,b=p['primitive_linear_remainder'];g,iv,j=pxgcd(b,M);assert g==[1];u=prem(pc(pm(a,iv),4),M)
 assert not prem(pa(pa(pm(DATA['b'],pmodpow(u,2,M)),pm(pc(DATA['c'],2),u)),pc(DATA['e'],3)),M)
 vals={'q':[0,1],'d':DATA['d'],'b':DATA['b'],'e':DATA['e'],
       'leading_companion':pa(pp(DATA['c'],2),pm(DATA['b'],DATA['e'])),
       'q10149':[neg(10149),1],'q64426':[neg(64426),1],
       'ordinary_double':prem(pa(pm(DATA['b'],u),DATA['c']),M),'u':u,
       'u24_minus1':ps(pmodpow(u,24,M),[1])}
 vals['F']=prem(pa(pa(pm(DATA['a0'],pmodpow(u,3,M)),pm(DATA['b'],pmodpow(u,2,M))),pa(pm(DATA['c'],u),DATA['e'])),M)
 vals['Delta0']=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())['zero_F_projection']['polynomial']
 removed={};oldM=M
 for key,val in vals.items():
  M,removed[key]=remove_support(M,val)
  if len(removed[key])>1:print('removed',key,'degree',len(removed[key])-1,flush=True)
 M=pc(M,inv(M[-1]));u=prem(u,M)
 cc,bb,aa=[eval_ring(v,u,M) for v in d['components'][0]['nu_coefficients']]
 ff,ee,dd=[eval_ring(v,u,M) for v in d['components'][1]['nu_coefficients']]
 vv=prem(ps(pm(aa,ff),pm(cc,dd)),M);ww=prem(ps(pm(aa,ee),pm(bb,dd)),M)
 good,removed_w=remove_support(M,ww);good=pc(good,inv(good[-1]));bad=pexact(M,good)
 print('whole allowed M',len(M)-1,'scale graph',len(good)-1,'pivot boundary',len(bad)-1,flush=True)
 gg,iw,_=pxgcd(ww,good);assert gg==[1]
 nu=prem(pc(pm(vv,iw),4),good)
 assert not prem(pa(pa(pm(aa,pmodpow(nu,2,good)),pm(bb,nu)),cc),good)
 assert not prem(pa(pa(pm(dd,pmodpow(nu,2,good)),pm(ee,nu)),ff),good)
 good2,nonzero_removed=remove_support(good,nu);good2=pc(good2,inv(good2[-1]));nu=prem(nu,good2)
 out={'x_code':x,'allowed_ratio_modulus':M,'u':u,'scale_graph_modulus':good2,'nu':nu,
      'scale_graph_before_nonzero':good,'excluded_zero_scale_factor':nonzero_removed,
      'scale_pivot_boundary_modulus':bad,'scale_pivot':ww,'scale_numerator':vv,
      'removed_open_support':removed,'initial_modulus':oldM}
 (base/'finite.json').write_text(json.dumps(out,separators=(',',':'))+'\n');print('nonzero scale graph degree',len(good2)-1,'seconds',time.time()-tic,flush=True)
 return out
if __name__=='__main__':run(int(sys.argv[1]) if len(sys.argv)>1 else 14)
