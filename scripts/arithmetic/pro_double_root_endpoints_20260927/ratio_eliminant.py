"""Explicit ratio-only determinantal annihilators of the actual square ideal.

This certifies a global OPEN exclusion, not exclusion on the determinant
zero set. No generic denominator is suppressed: the remaining finite ratio
scheme is presented by the included determinant circuits.
"""
import ctypes as ct,subprocess,struct,json,time,gzip,hashlib,sys
from exact import ROOT,DATA,neg,mul,add,power,peval,prem
from ratio_eliminant_data import load
from factor import factor
from fibres_u import fibre_modulus
IP=ct.POINTER(ct.c_int)
NR=209;NC=71;DS=7;BOUND=3;HEIGHT=710;WIDTH=836
DEST=ROOT/'evidence/ratio_eliminant.json.gz'

def library():
 path=ROOT/'src/libstrongdifferential.so';source=ROOT/'src/strong_differential.cpp'
 if not path.exists() or path.stat().st_mtime<source.stat().st_mtime:
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(source),'-o',str(path)],check=True)
 lib=ct.CDLL(str(path));lib.ff_init();lib.ef_init((ct.c_int*2)(0,1),2)
 lib.strong_differential_certificate.argtypes=[IP,ct.c_int,ct.c_int,IP,IP,IP,IP,IP]
 lib.independent_det.argtypes=[IP,ct.c_int]
 lib.min_assignment.argtypes=[IP,ct.c_int,IP,IP,IP]
 return lib

def point_coefficients(raw,u0,q0):
 # Exact evaluation of every normalized coefficient, T-major then scale.
 from interpolate_global import library as ilib
 m=7*141*9;uvals=(ct.c_int*m)()
 ilib().ff_evaluate_rows((ct.c_int*len(raw))(*raw),133,m,u0,uvals)
 return [peval(list(uvals[(s*141+140-t)*9:(s*141+140-t+1)*9]),q0) for t in range(141) for s in range(7)]

def entry_location(r,col):
 j,t=divmod(r,10);m0,ell=divmod(col,4);m=m0+1
 n=m-j;s=t-ell;z=(3*j-m)%5
 if not z or not (0<=n<=140 and 0<=s<=6):return None
 return n,s,z

def matrix_at(A,columns):
 return [mul(loc[2],A[loc[0]*7+loc[1]]) if (loc:=entry_location(r,c)) else 0
         for r in range(HEIGHT) for c in columns]

def assignment(lib,cost):
 r=(ct.c_int*HEIGHT)();c=(ct.c_int*HEIGHT)();p=(ct.c_int*HEIGHT)()
 value=lib.min_assignment((ct.c_int*len(cost))(*cost),HEIGHT,r,c,p)
 rr,cc,pp=list(r),list(c),list(p)
 assert sorted(pp)==list(range(HEIGHT))
 assert all(rr[i]+cc[j]<=cost[i*HEIGHT+j] for i in range(HEIGHT) for j in range(HEIGHT))
 assert sum(cost[i*HEIGHT+pp[i]] for i in range(HEIGHT))==value==sum(rr)+sum(cc)
 assert all(cost[i*HEIGHT+pp[i]]<1000000 for i in range(HEIGHT))
 return {'value':value,'row_potentials':rr,'column_potentials':cc,'matching':pp}

def degree_certificates(lib,meta,columns):
 weights=meta['weights_by_T_scale'];vals=meta['unit_valuations_by_T_scale'];big=1000000
 costs={name:[] for name in ['negative_weight','q','d_monic','u']}
 for r in range(HEIGHT):
  for c in columns:
   loc=entry_location(r,c)
   if loc is None or weights[loc[0]][loc[1]]<0:
    for a in costs.values():a.append(big)
   else:
    t,s,_=loc;costs['negative_weight'].append(-weights[t][s])
    for name in ['q','d_monic','u']:costs[name].append(vals[t][s][name])
 duals={name:assignment(lib,cost) for name,cost in costs.items()}
 w=-duals['negative_weight']['value']
 # Store separate valuation lower bounds only. They are NOT combined into
 # a product divisibility assertion or subtracted from the weight bound.
 # The reported norm bound uses the unstripped determinant throughout.
 return {'unstripped_weight_bound':w,'separate_valuation_duals':duals,
         'unstripped_norm_degree_bound':(9*w)//2}

def build(verify=False):
 start=time.time();meta,raw=load();lib=library();records=[]
 for index,(u0,offset) in enumerate([(25,0),(27,279),(25,557)]):
  mod=fibre_modulus(u0)[0];q0=neg(next(f for f,m in factor(mod) if len(f)==2)[0]);A=point_coefficients(raw,u0,q0)
  columns_order=list(range(offset,WIDTH))+list(range(offset))
  out=(ct.c_int*WIDTH)();stats=(ct.c_int*5)();pivs=(ct.c_int*HEIGHT)();det=(ct.c_int*1)();tic=time.time()
  result=lib.strong_differential_certificate((ct.c_int*len(A))(*A),7,3,out,stats,pivs,det,(ct.c_int*WIDTH)(*columns_order))
  assert result==0 and stats[2]==HEIGHT
  columns=list(pivs);matrix=matrix_at(A,columns);direct=lib.independent_det((ct.c_int*len(matrix))(*matrix),HEIGHT)
  assert direct==det[0] and direct
  # The point is on the exact original open, not merely on an abstract plane model.
  b,c,e=[peval(DATA[z],q0) for z in ['b','c','e']]
  assert add(add(mul(b,power(u0,2)),mul(2,mul(c,u0))),mul(3,e))==0
  F=add(add(mul(peval(DATA['a0'],q0),power(u0,3)),mul(b,power(u0,2))),add(mul(c,u0),e))
  assert all([u0,q0,peval(DATA['d'],q0),F,add(mul(b,u0),c)])
  assert q0 not in DATA['excluded_q']
  deg=degree_certificates(lib,meta,columns)
  record={'id':index+1,'point':{'u_code':u0,'q_code':q0},'point_role':'nonzero determinant witness and all-scale excluded actual ratio, not a residual square witness','column_order_offset':offset,
   'selected_columns':columns,'point_minor_determinant':direct,
   'point_macaulay_stats':list(stats),'point_cubic_scale_certificate':list(out),
   'point_coefficients_sha256':hashlib.sha256(struct.pack('<%dI'%len(A),*A)).hexdigest(),
   **deg}
  records.append(record)
  print('RATIO DETERMINANT',index+1,'point',u0,q0,'det',direct,'weight',deg['unstripped_weight_bound'],
        'separate unit powers',{n:deg['separate_valuation_duals'][n]['value'] for n in ['q','d_monic','u']},
        'seconds',round(time.time()-tic,3),flush=True)
 output={'status':'proved_global_open_exclusion_with_explicit_finite_exceptional_scheme; global decision unresolved',
  'coefficient_algebra':'A=K[u,q]/(monic_q(g))','normalized_residual_raw_sha256':meta['raw_sha256'],
  'matrix_shape':[HEIGHT,WIDTH],'matrix_rows':'row=10*j+t, 0<=j<=70,0<=t<=9',
  'matrix_columns':'column=4*(m-1)+ell, 1<=m<=209,0<=ell<=3',
  'matrix_entry':'(3*j-m)*[T^(m-j)*nu^(t-ell)]Astar; zero outside displayed coefficient ranges',
  'Astar':'T^140*Rstar(nu,T^-1)',
  'global_identity':'sum_m C_m(nu)*[T^(m-1)](2*Astar*Bprime-Astarprime*B)=det(M_selected)*B0, with C from adj(M_selected)*e_(0,0)',
  'no_scale_localization':True,'determinants_are_ratio_only':True,
  'determinant_coefficients_expanded':False,'representation':'exact determinant arithmetic circuits over the archived, exactly normalized actual coefficient array',
  'records':records}
 payload=json.dumps(output,separators=(',',':')).encode()
 if verify:assert gzip.open(DEST,'rb').read()==payload
 else:DEST.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('THREE GLOBAL RATIO-ONLY ANNIHILATOR CIRCUITS VERIFIED; remaining determinant-zero locus OPEN; seconds',round(time.time()-start,3),flush=True)
 return output
if __name__=='__main__':build('--verify' in sys.argv)
