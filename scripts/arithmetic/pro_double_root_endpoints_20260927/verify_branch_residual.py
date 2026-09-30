"""Check every finite graph norm against the independent complete global residual.
The equality is checked in the whole quotient algebra, not at field samples.
No additional coefficient or scale is inverted.
"""
import ctypes as ct,gzip,json,struct,hashlib,time,sys
from exact import ROOT,prem
from branch_graph_check import library

def run(x):
 start=time.time();d=json.loads(gzip.open(ROOT/'evidence/branch_root'/f'graph_x_{x}.json.gz','rb').read())
 M=d['modulus'];n=len(M)-1;u=d['u']+[0]*(n-len(d['u']));nu=d['nu']+[0]*(n-len(d['nu']))
 raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read();a=struct.unpack('<%dI'%(len(raw)//4),raw)
 lib=library();IP=ct.POINTER(ct.c_int);lib.finite_residual_values.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP]
 N=(ct.c_int*(141*n))();status=lib.finite_residual_values((ct.c_int*len(a))(*a),133,(ct.c_int*len(M))(*M),n,(ct.c_int*n)(*u),(ct.c_int*n)(*nu),N)
 assert status==0
 digest=hashlib.sha256(struct.pack('<%dI'%len(N),*N)).hexdigest();assert digest==d['actual_norm_sha256']
 out={'x_code':x,'status':'passed','finite_algebra_length':n,'coefficients_compared':141,
      'actual_norm_sha256':digest,'independent_path':'q^4*Rtilde actual global array, at tau=q^2*nu',
      'quotient_includes_nilpotents':True,'seconds':round(time.time()-start,3)}
 (ROOT/'logs'/f'branch_residual_x_{x}.json').write_text(json.dumps(out,indent=2)+'\n')
 print('INDEPENDENT WHOLE-ALGEBRA RESIDUAL',x,n,digest,'seconds',out['seconds'],flush=True)
 return out
if __name__=='__main__':
 roots=[int(x) for x in sys.argv[1:]] or [14,2514,7367,20130,364472,281660,154113,139659,104315]
 for x in roots:run(x)
