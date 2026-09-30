#!/usr/bin/env python3
"""Independent arithmetic checks, including ALL 726 final cancellation cases.

The full C++ replay is exhaustive. This independent L-first field engine
checks a deterministic supplementary selection and every case needing the
last geometric condition. It never substitutes samples for full coverage.
"""
import argparse, json, sys, hashlib, time
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent/'pro_degree6_actual_return_20260924/degree6/src'))
from reference_field import ReferenceField

ap=argparse.ArgumentParser()
ap.add_argument('--data',type=Path,required=True)
ap.add_argument('--certificate',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args()
D=json.loads(args.data.read_text())
F=ReferenceField(D['KM'],D['LM'])
A,S,M,C=F.add,F.sub,F.mul,F.scale
one=F.one()
def sq(a): return M(a,a)
def prod(*args):
    out=one
    for a in args: out=M(out,a)
    return out
def outer(name,i,e,m=1):return F.outer(D[name][i],D['ZP'][(m*e)%29])

def check(case,record):
    j,k,l,u,t,v,r=case;vm=(v+t)%29
    def diff(name,i,e,j,f,m=1):return S(outer(name,i,e,m),outer(name,j,f,m))
    def avg(name,i,e,j,f,m=1):return C(A(outer(name,i,e,m),outer(name,j,f,m)),3)
    a=S(F.embed(D['ROOTS'][0]),F.embed(D['ROOTS'][j]))
    b=S(F.embed(D['ROOTS'][k]),F.embed(D['ROOTS'][l]))
    f=diff('HS',0,0,j,u);c=diff('FS',0,0,j,u,4)
    d=diff('GS',0,0,j,u,5);e=diff('JS',0,0,j,u,8)
    h=diff('HS',k,v,l,vm);ii=diff('FS',k,v,l,vm,4)
    jj=diff('GS',k,v,l,vm,5);kk=diff('JS',k,v,l,vm,8)
    dp=avg('GS',0,0,j,u,5);ep=avg('JS',0,0,j,u,8)
    jp=avg('GS',k,v,l,vm,5);kp=avg('JS',k,v,l,vm,8)
    rr=F.outer([1,0,0,0],D['ZP'][r]);r2=sq(rr)
    r3=M(rr,r2);r7=F.power(rr,7);r8=M(rr,r7)
    delta=S(M(h,ii),M(b,jj));assert any(delta)
    T0=S(M(h,d),M(b,c));T1=S(M(a,b),M(h,f))
    U0=S(M(jj,d),M(ii,c));U1=S(M(ii,a),M(jj,f))
    bb=S(b,M(r7,h));pp=A(S(ii,M(r7,jj)),M(rr,bb))
    q0=A(M(delta,S(f,M(r7,a))),M(rr,S(M(pp,T0),M(bb,U0))))
    den=M(rr,S(M(pp,T1),M(bb,U1)));nu=C(q0,4)
    assert any(den)
    tp=A(M(T0,den),M(T1,nu));up=A(M(U0,den),M(U1,nu));assert any(tp)
    rv=S(S(prod(e,delta,den),M(h,tp)),prod(c,nu,delta))
    rm=S(S(M(kk,tp),prod(f,delta,den)),M(ii,up))
    stage,coordinate,value=record
    if stage==3: assert not any(a);w=rv
    elif stage==4: assert not any(b);w=rm
    else:
        assert any(a) and any(b)
        en=S(M(r8,jp),kp);ed=S(M(r8,ep),dp);assert any(en) and any(ed)
        li=A(S(sq(den),C(prod(rr,nu,den),4)),C(M(r2,sq(nu)),3))
        ln=A(prod(a,delta,li),C(prod(r2,rv,den),2))
        ri=A(S(C(sq(up),3),C(prod(rr,up,tp),4)),M(r2,sq(tp)))
        rn=A(M(b,ri),C(M(rm,tp),2))
        w=S(prod(b,sq(en),sq(sq(tp)),ln),prod(a,sq(ed),delta,sq(delta),sq(sq(den)),rn))
        if stage==8:
            assert not any(w)
            # Independently clear the opposite-sheet cancellation equation.
            hh=A(C(prod(a,delta,nu,den),3),
                 M(rr,A(C(prod(a,delta,sq(nu)),3),C(M(rv,den),2))))
            bn=A(prod(S(C(up,2),M(rr,tp)),sq(ed),a,delta,sq(delta),sq(sq(den))),
                 prod(sq(en),tp,sq(tp),hh))
            eb=A(A(prod(a,delta,den),M(rr,S(M(jj,tp),M(h,up)))),prod(r2,h,tp))
            ar=S(M(jp,ed),M(en,ep))
            w=S(C(prod(r3,a,delta,sq(delta),sq(sq(den)),tp,sq(tp),sq(ar)),4),M(bn,sq(eb)))
            assert any(w),case
            return 'all_final_cancellation_cases'
        assert stage==7
    assert any(w) and w[coordinate]==value,(case,record,w)
    assert next(i for i,a in enumerate(w) if a)==coordinate
    return 'independent_exact_record'

start=time.monotonic()
cert=args.certificate.read_bytes()
assert len(cert)==3*6356452
reps=[]
for u in range(29):
 for t in range(29):
  for v in range(29):
   a=(u,t,v);orbit=[a]
   for i in range(6):orbit.append(tuple(24*x%29 for x in orbit[-1]))
   if a==min(orbit):reps.append(a)
index=0;checked=0;last=0;counts={}
for j in range(4):
 for k in range(4):
  for l in range(4):
   for u,t,v in reps:
    if (j==0 and u==0) or (k==l and t==0):continue
    for r in range(29):
     record=tuple(cert[3*index:3*index+3]);stage=record[0]
     assert stage in (3,4,7,8) and record[1]<28 and 0<record[2]<25
     counts[stage]=counts.get(stage,0)+1
     if stage==8 or index%16381==0:
      check((j,k,l,u,t,v,r),record);checked+=1
      if stage==8:last+=1
      if checked%100==0: print('checked',checked,'final-stage',last,flush=True)
     index+=1
assert index==6356452 and last==726
result={'scope':'Independent supplementary exact arithmetic and ALL last-stage cases; exhaustive coverage comes from the complete C++ replay.',
        'records':index,'checked_independently':checked,'final_stage_checked':last,
        'stage_counts':counts,'certificate_sha256':hashlib.sha256(cert).hexdigest(),
        'seconds':time.monotonic()-start,'status':'PASS'}
args.output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
