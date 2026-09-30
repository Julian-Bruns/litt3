"""Evaluate the EXACT NECESSARY RATIO CURVE, not a square-locus decision.
The curve is a fixed-degree Sylvester determinant of selected square errors.
This arithmetic circuit defines a regular function on the whole specified ratio open set.
"""
import argparse,json
from pathlib import Path
import numpy as np
import exact as E
from residual import evaluate_chart,residual_lambda
from scale_errors import errors

def determinant(M):
 F=E.F;M=M.copy().astype(np.int32);det=1;n=len(M)
 for j in range(n):
  ix=np.flatnonzero(M[j:,j])
  if not len(ix):return 0
  k=j+int(ix[0])
  if k!=j:M[[j,k]]=M[[k,j]];det=F.N(det)
  pivot=int(M[j,j]);det=F.M(det,pivot)
  if j+1<n:
   factors=F.mul(M[j+1:,j],F.I(pivot));M[j+1:,j:]=F.sub(M[j+1:,j:],F.mul(factors[:,None],M[j,None,j:]))
 return det

def sylvester(f,g,m,n):
 if len(f)>m+1 or len(g)>n+1:raise ValueError('degree exceeds declared degree')
 fd=np.zeros(m+1,dtype=np.int32);gd=np.zeros(n+1,dtype=np.int32);fd[:len(f)]=f;gd[:len(g)]=g;fd=fd[::-1];gd=gd[::-1]
 M=np.zeros((m+n,m+n),dtype=np.int32)
 for i in range(n):M[i,i:i+m+1]=fd
 for i in range(m):M[n+i,i:i+n+1]=gd
 return determinant(M)

def specification(root):return ([100,101],[75,75]) if root is None else ([71,72],[53,54])

def compute(atlas,chart,h,w):
 H,p=evaluate_chart(atlas,chart,h,w);R=residual_lambda(H,atlas['root']);_,es=errors(R);indices,degrees=specification(atlas['root']);fs=[es[i-71] for i in indices]
 val=sylvester(fs[0],fs[1],*degrees)
 return val,indices,degrees

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--data',required=True);ap.add_argument('--h',type=int,default=2);ap.add_argument('--w',type=int,default=1);ap.add_argument('--save',action='store_true');args=ap.parse_args();E.init(args.tables);specs=[]
 for fn in sorted(Path(args.data).glob('atlas_*.json')):
  a=json.loads(fn.read_text());c=json.loads(fn.with_name(fn.name.replace('atlas_','chart_')).read_text());val,indices,degrees=compute(a,c,args.h,args.w)
  entry={'atlas':fn.name,'root':a['root'],'error_indices':indices,'fixed_degrees':degrees,'test_h':args.h,'test_w':args.w,'determinant_value':val}
  specs.append(entry);print(fn.name,indices,degrees,'necessary-curve value',val,flush=True)
 if args.save:Path(args.data,'necessary_curve_specs.json').write_text(json.dumps(specs,indent=2)+'\n')
