#!/usr/bin/env python3
"""Eliminate *all* unknown pole moments by a 7-by-4 linear system and one quadric.

This tool analyzes one specified endpoint pair. It does not enumerate endpoint
multisets, pole profiles, field elements, branch curves, or actual covers.
Endpoint label 29*i+j means b^(25^i)*zeta^j, i=0..3, j=0..28.
All ranks are over F_(5^7). See REPORT.md, Appendix L.
"""
from __future__ import annotations
import argparse,json
from functools import lru_cache
from pathlib import Path
import structural_field as F

ETA=F.old25(22)
@lru_cache(maxsize=1)
def labels():
    c=F.lift25row([22,7,9,23]);e=F.lift25row([1,3,8,15]);C=[];E=[]
    for i in range(4):
        for j in range(29):
            C.append(F.fk(c,F.ZPOW[5*j%29]));E.append(F.fk(e,F.ZPOW[8*j%29]))
        c=F.sigma(c);e=F.sigma(e)
    return C,E

def sums(indices):
    if len(indices)!=4 or any(not isinstance(i,int) or not 0<=i<116 for i in indices):
        raise ValueError('exactly four label indices in 0..115 are required')
    C,E=labels();c=e=F.F0
    for i in indices:c=F.fa(c,C[i]);e=F.fa(e,E[i])
    return c,e

def norm(x0,x1):return F.add(F.add(F.mul(x0,x0),F.mul(x0,x1)),F.mul(2,F.mul(x1,x1)))

def data(q,h):
    cq,eq=sums(q);ch,eh=sums(h);ie=F.ki(ETA)
    a,b,c,d=[F.fk(v,ie) for v in [eq,cq,ch,eh]]
    const=F.fs(F.fm(a,d),F.fm(b,c))
    bb=F.kb(F.BETA)
    columns=[F.fn(F.fa(a,d)),F.fn(F.fa(F.fk(a,F.BETA),F.fk(d,bb))),
             F.fa(b,c),F.fa(F.fk(b,bb),F.fk(c,F.BETA))]
    matrix=[[col[i] for col in columns]+[F.neg(const[i])] for i in range(1,8)]
    return a,b,c,d,const,columns,matrix

def test_point(q,h,point,mass=None):
    a,b,c,d,const,columns,matrix=data(q,h)
    x=tuple(point[:2]);y=tuple(point[2:]);xx=x+(0,)*6;yy=y+(0,)*6
    # L=(a-bar(x),b-y), R=(c-bar(y),d-x).
    L=[F.fs(a,F.kb(x)+(0,)*6),F.fs(b,yy)]
    R=[F.fs(c,F.kb(y)+(0,)*6),F.fs(d,xx)]
    nz=next((i for i in range(2) if L[i]!=F.F0),None)
    if nz is None:
        if any(r!=F.F0 for r in R):
            return {'valid_nonzero_scale':False,'reason':'zero left vector and nonzero right vector'}
        result={'x_M2':x,'y_M6':y,'epsilon':F.F1,'valid_nonzero_scale':True,
                'epsilon_in_K14':True,'scale_unique':False,
                'reason':'both vectors zero; every nonzero scale satisfies these two equations'}
        if mass is not None:result['weight_reconstruction']=F.decode_moments(x,y,mass)
        return result
    epsilon=F.fm(R[nz],F.fi(L[nz]))
    valid=epsilon!=F.F0 and all(F.fm(epsilon,l)==r for l,r in zip(L,R))
    result={'x_M2':x,'y_M6':y,'epsilon':epsilon,'valid_nonzero_scale':valid,
            'epsilon_in_K14':epsilon[2:]==(0,)*6,'scale_unique':True}
    if mass is not None and valid:result['weight_reconstruction']=F.decode_moments(x,y,mass)
    return result

def analyze(q,h,mass=None):
    a,b,c,d,const,cols,matrix=data(q,h)
    rref,piv,trans,bad=F.gaussian(matrix)
    result={'Q':q,'H':h,'rank':len(piv),'matrix':matrix,'rref':rref,
            'row_operation_certificate':trans,
            'normalized_endpoint_sums':[a,b,c,d],
            'constant':const,'linear_columns':cols,'field':'F_5[theta]/(4+4 theta+2 theta^2+3 theta^3+3 theta^4+2 theta^5+2 theta^6+theta^7)',
            'warning':'Necessary moment equations only; no actual curve is asserted.'}
    if bad is not None:
        result.update(status='linear_inconsistent',contradictory_row=bad);return result
    particular=[0]*4
    for j,row in zip(piv,rref):particular[j]=row[4]
    free=[j for j in range(4) if j not in piv];kernel=[]
    for j in free:
        v=[0]*4;v[j]=1
        for k,row in zip(piv,rref):v[k]=F.neg(row[j])
        kernel.append(v)
    def qeval(v):
        r=F.add(const[0],F.sub(norm(v[0],v[1]),norm(v[2],v[3])))
        for co,t in zip(cols,v):r=F.add(r,F.mul(co[0],t))
        return r
    def plus(v,w):return [F.add(x,y) for x,y in zip(v,w)]
    q0=qeval(particular);linear=[];square=[];cross=[]
    for v in kernel:
        qp=qeval(plus(particular,v));qm=qeval(plus(particular,[F.neg(x) for x in v]))
        linear.append(F.mul(3,F.sub(qp,qm)))
        square.append(F.mul(3,F.sub(F.add(qp,qm),F.mul(2,q0))))
    for i in range(len(kernel)):
        for j in range(i+1,len(kernel)):
            v=qeval(plus(plus(particular,kernel[i]),kernel[j]))
            v=F.sub(F.sub(F.add(v,q0),qeval(plus(particular,kernel[i]))),qeval(plus(particular,kernel[j])))
            cross.append([i,j,v])
    result.update(particular=particular,kernel=kernel,
                  quadratic={'constant':q0,'linear':linear,'square':square,'cross':cross})
    candidate_parameters=[]
    if not kernel:
        if q0:result['status']='quadratic_inconsistent';return result
        candidate_parameters=[[]]
    elif len(kernel)==1:
        aa,bb,cc=square[0],linear[0],q0
        if aa:
            disc=F.sub(F.mul(bb,bb),F.mul(4,F.mul(aa,cc)));root=F.sqrt(disc)
            result['discriminant']=disc
            if root is None:result['status']='quadratic_nonsquare_discriminant';return result
            den=F.inv(F.mul(2,aa));roots={F.mul(F.add(F.neg(bb),root),den),F.mul(F.sub(F.neg(bb),root),den)}
            candidate_parameters=[[r] for r in sorted(roots)]
        elif bb:candidate_parameters=[[F.mul(F.neg(cc),F.inv(bb))]]
        elif cc:result['status']='quadratic_inconsistent';return result
        else:result['status']='positive_dimensional_affine_quadric';return result
    else:result['status']='affine_quadric_retained';return result
    result['tested_isolated_points']=[]
    for pars in candidate_parameters:
        v=particular[:]
        for par,k in zip(pars,kernel):v=plus(v,[F.mul(par,x) for x in k])
        assert qeval(v)==0
        ans=test_point(q,h,v,mass);ans.update(parameters=pars,point=v)
        result['tested_isolated_points'].append(ans)
    result['status']='isolated_moment_points' if any(p['valid_nonzero_scale'] for p in result['tested_isolated_points']) else 'nonzero_scale_impossible'
    return result

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--q',nargs=4,type=int,required=True);ap.add_argument('--h',nargs=4,type=int,required=True)
    ap.add_argument('--mass',type=int);ap.add_argument('--output',type=Path)
    args=ap.parse_args();r=analyze(args.q,args.h,args.mass);text=json.dumps(r,indent=2)+'\n'
    if args.output:args.output.write_text(text)
    else:print(text,end='')
if __name__=='__main__':main()
