"""Exact vector Newton interpolation used to construct the stored coefficient tables.
No global elimination routine is asserted.
"""
import time
import numpy as np
import exact as E

def interp_vec(points,vals):
 F=E.F;n=len(points);dd=vals.copy();t=time.time()
 for j in range(1,n):
  dif=F.sub(points[j:],points[:-j]);dd[j:]=F.mul(F.sub(dd[j:],dd[j-1:-1]),F.inv(dif).reshape((-1,)+(1,)*(dd.ndim-1)))
 out=np.zeros_like(vals);out[0]=dd[-1];cur=1
 for j in range(n-2,-1,-1):
  old=out[:cur].copy();out[1:cur+1]=old;out[0]=0
  out[:cur]=F.sub(out[:cur],F.mul(old,int(points[j])));out[0]=F.add(out[0],dd[j]);cur+=1
 print('interpolation sec',time.time()-t,flush=True);return out

