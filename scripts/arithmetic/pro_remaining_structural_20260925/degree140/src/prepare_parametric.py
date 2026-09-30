"""Create one exact pivot-zero branch, parameterized by R=F6 and lambda.
This is a reconstruction tool, not an exclusion certificate by itself.
"""
from reconstruct import *
from laurent import LP
from series import normalized_vector

def main(index=3,sign=0):
 cases=json.loads((ROOT/'data/spaces.json').read_text())['cases'];case=cases[index]
 charts=json.loads((ROOT/'data/charts.json').read_text())['cases'];ch=charts[index]
 exs=json.loads((ROOT/'data/exceptional.json').read_text())['cases'];ex=exs[index-1]
 q=ex['w3'];c0,c1,c2=ex['H_polynomial'];disc=ex['H_discriminant']
 assert LOG[q]%3==0 and LOG[disc]%2==0
 w=EXP[LOG[q]//3];sq=EXP[LOG[disc]//2];HH=div(add(neg(c1),sq if not sign else neg(sq)),mul(2,c2));h=mul(w,HH)
 assert powf(w,3)==q and peval([c0,c1,c2],HH)==0 and h and w
 cc=peval(ex['F6_constant'],HH);sl=mul(w,peval(ex['F6_slope_div_w'],HH));assert sl
 su=LP.load(ch['exceptional']['s']);sv0=su.eval([h,w,0,0]);sv1=sub(su.eval([h,w,0,1]),sv0)
 bc=json.loads((ROOT/'data/boundary_series.json').read_text())['cases'][index]
 rvar=LP.var(0);uu=(rvar-LP(cc))/LP(sl);ss=LP(sv0)+LP(sv1)*uu
 repl={0:LP(h),1:LP(w),2:ss,3:uu}
 assert not LP.load(bc['F']['4']).subs(repl) and not LP.load(bc['F']['5']).subs(repl)
 assert LP.load(bc['F']['6']).subs(repl)==rvar
 vec=normalized_vector(case)
 v0=np.array([p.eval([h,w,sv0,0]) for p in vec],np.int32)
 vv1=np.array([p.eval([h,w,add(sv0,sv1),1]) for p in vec],np.int32)
 dv=vsub(vv1,v0);rc0=vsub(v0,vmul(dv,div(cc,sl)));rc1=vmul(dv,inv(sl))
 H0,k0=unpack(rc0);H1,k1=unpack(rc1);assert k0==1 and k1==0
 # R is encoded as x^1024 for bounded Kronecker multiplication only.
 out=[P,Q,t,[neg(case['root']),1]]
 for i in range(2,6):
  for j in range(3):
   p=H0[i][j]+[0]*max(0,1024-len(H0[i][j]))+H1[i][j]
   out.append(trim(p))
 name=f'exceptional_param_{index}_{sign}'
 (ROOT/'data'/f'{name}.txt').write_text('\n'.join(' '.join(map(str,[len(p)]+p)) for p in out)+'\n')
 metadata={'index':index,'root':case['root'],'sign':sign,'w':w,'H':HH,'h':h,'R_convention':'R=F6 (not residual R0); u=(R-F6_constant)/F6_slope','F6_constant':cc,'F6_slope':sl,'vector_constant':rc0.tolist(),'vector_R':rc1.tolist(),'kronecker_stride':1024}
 (ROOT/'data'/f'{name}_metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
 print(name,'h=',h,'w=',w,'H=',HH,'F6=',cc,'+',sl,'u',flush=True)
 return name
if __name__=='__main__':
 import sys
 main(*(map(int,sys.argv[1:])) if len(sys.argv)>1 else (3,0))
