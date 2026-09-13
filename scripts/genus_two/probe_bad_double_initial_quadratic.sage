"""Characteristic-five quadratic Riccati channel at a compatible reference.

The coefficient extraction is exact at retained Laurent precision. Its
identification with the full higher-Witt obstruction is a separate audit
obligation; no linear divided carry is calculated here.
"""
import argparse, itertools, json, sys, time
from pathlib import Path

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--module',type=Path,required=True)
p.add_argument('--precision',type=int,default=500)
p.add_argument('--output',type=Path,required=True)
p.add_argument('--limit',type=int,default=45)
opts=p.parse_args(); data=json.loads(opts.module.read_text()); saved=sys.argv
sys.argv=['diagnose_bad_double_noninvariant_covers.sage','--covers','0',
    '--parameter-polynomial',data['parameter_polynomial'],'--precision',str(opts.precision)]
load('scripts/genus_two/diagnose_bad_double_noninvariant_covers.sage')
sys.argv=saved
assert data['plane']=='nodal' and data['field_modulus']==[int(c) for c in k.modulus()]
decode=lambda c:sum(k(v)*k.gen()**i for i,v in enumerate(c))
encode=lambda c:[int(v) for v in coordinates(c)]
assert t==decode(data['parameter'])
begun=time.monotonic(); ix=list(itertools.product(range(5),repeat=2)); pos={v:i for i,v in enumerate(ix)}
shifts=[(sum(fixed[0][i]*z**[-3,-1][i] for i in range(2)),zero),(zero,anti_root*z)]
if data.get('mix_second',0):
    added=(sum(fixed[1][i]*z**[-3,-1][i] for i in range(2)),zero)
    shifts[1]=add(shifts[1],scal(Fp(data['mix_second']),added))
rhs=[]
for shift in shifts:
    disc=add(fift(shift),neg(shift))
    r0,a0=reduce0(disc[0]);r1,a1=reduce_anti(disc[1])
    assert r0.valuation()>=1 and r1.valuation()>=2
    rhs.append((a0,a1))
sp=[[power(neg(s),i) for i in range(5)] for s in shifts]
fp=[[power(f,i) for i in range(5)] for f in rhs]
local={}
for ab in ix:
    local[ab]=[]
    for cd in itertools.product(*(range(v+1) for v in ab)):
        if ab==cd:continue
        c=(LS.one(),zero)
        for j in range(2):c=mul(c,scal(binomial(ab[j],cd[j]),sp[j][ab[j]-cd[j]]))
        local[ab].append((pos[cd],c))

def reduced(vec,primitives=False):
    vv=list(vec); au=[(zero,zero) for _ in ix]
    for ab in reversed(ix):
        at=pos[ab]; r0,a0=reduce0(vv[at][0]);r1,a1=reduce_anti(vv[at][1])
        au[at]=(a0,a1)
        can0=sum(laurent_coefficient(r0,j)*z**j for j in inv_orders)
        can1=sum(laurent_coefficient(r1,j)*z**j for j in anti_orders)
        tail=(r0-can0,r1-can1)
        assert tail[0].valuation()>=2 and tail[1].valuation()>=4
        assert min(r0.precision_absolute(),r1.precision_absolute())>4
        for to,c in local[ab]:vv[to]=add(vv[to],neg(mul(c,tail)))
        vv[at]=(can0,can1)
    answer=vector(k,[laurent_coefficient(vv[n][p],j) for n in range(25)
        for p,exps in enumerate([inv_orders,anti_orders]) for j in exps])
    return (answer,au) if primitives else answer

PX=PolynomialRing(Fp,'X');xx=PX.gen();polys=[xx**4]
for _ in range(4):polys.append(polys[-1](xx+1)-polys[-1])
tri=matrix(Fp,5,5,lambda i,j:polys[j][i])
conv=tri.tensor_product(tri).tensor_product(identity_matrix(Fp,6)).change_ring(k)
convi=conv.inverse(); columns=[[decode(c) for c in col] for col in data['regular_free_columns']]
M=matrix(k,150,150,0,implementation='generic')
for ab in ix:
    for cd in ix:
        ef=tuple(ab[h]+cd[h] for h in range(2))
        if max(ef)>=5:continue
        for i in range(6):
            for j in range(6):M[6*pos[ef]+i,6*pos[ab]+j]=columns[j][6*pos[cd]+i]
K=M.right_kernel().basis_matrix(); lam=M.left_kernel().basis_matrix()
assert K.nrows()==lam.nrows()==9

# Pointwise multiplication uses w_i^5=w_i+f_i, not augmentation products.
redpowers=[]
for axis in range(2):
    tab=[{j:(LS.one(),zero)} for j in range(5)]
    for j in range(5,9):
        out=dict(tab[j-4])
        for h,c in tab[j-5].items():out[h]=add(out.get(h,(zero,zero)),mul(rhs[axis],c))
        tab.append(out)
    redpowers.append(tab)
product_rules={}
for ab in ix:
    for cd in ix:
        ef=tuple(ab[h]+cd[h] for h in range(2))
        product_rules[ab,cd]=[(pos[(i,j)],mul(ci,cj))
            for i,ci in redpowers[0][ef[0]].items() for j,cj in redpowers[1][ef[1]].items()]

def amul(x,y):
    out=[(zero,zero) for _ in ix]
    for i,ab in enumerate(ix):
        if not any(x[i]):continue
        for j,cd in enumerate(ix):
            if not any(y[j]):continue
            cc=mul(x[i],y[j])
            for at,f in product_rules[ab,cd]:out[at]=add(out[at],mul(cc,f))
    return out

def ascal(c,x):return [scal(c,v) for v in x]
def asum(*vs):return [tuple(sum(v[i][j] for v in vs) for j in range(2)) for i in range(25)]
normals=[]; repairs=[]
for number,row in enumerate(K):
    uvec=conv*vector(k,row); n5=[(zero,zero) for _ in ix]
    for ab in ix:
        for p,exps in enumerate([inv_orders,anti_orders]):
            for jj,exponent in enumerate(exps):
                c=uvec[6*pos[ab]+3*p+jj]
                if not c:continue
                base=fift((z**exponent,zero) if p==0 else (zero,z**exponent))
                for cd in itertools.product(*(range(v+1) for v in ab)):
                    term=scal(c,base)
                    for axis in range(2):term=mul(term,scal(binomial(ab[axis],cd[axis]),fp[axis][ab[axis]-cd[axis]]))
                    n5[pos[cd]]=add(n5[pos[cd]],term)
    rho=ascal(A,n5); coho,affine=reduced(rho,True)
    assert not coho
    normals.append(n5);repairs.append(ascal(-1,affine))
    print('ACTUAL_PRIMARY_PRIMITIVE',number,round(time.monotonic()-begun,2),flush=True)

# J=[[z^-1,0],[-D(z),z]], N=[[-B,A],[-C,B]], B=D(A)/2.
Ap=(t+1)**2*u*(u-1)*(u-2)*(u-3)
B=vf*Ap.derivative()(uf)/2
Dz=2*uf-uf**2*F.derivative()(uf)/(2*F(uf))
records=[]
for i,j in itertools.combinations_with_replacement(range(9),2):
    if len(records)>=opts.limit:break
    n,m=normals[i],normals[j];q,r=repairs[i],repairs[j]
    wi=asum(ascal(A,n),q);wj=asum(ascal(A,m),r)
    factor=1 if i==j else 2
    normal=asum(ascal(-factor*A*B,amul(n,m)),
                ascal(-B,asum(amul(n,r),amul(m,q))) if i==j else
                ascal(-2*B,asum(amul(n,r),amul(m,q))),
                ascal(factor*Dz/z,amul(wi,wj)))
    coho=convi*reduced(normal); projection=lam*coho
    records.append(dict(pair=[int(i),int(j)],normal=[encode(c) for c in coho],projection=[encode(c) for c in projection]))
    result=dict(status='complete' if len(records)==45 else 'partial',
        scope='Exact characteristic-five quadratic Riccati channel; geometric identification audited separately; linear carry not computed',
        precision=int(opts.precision),module=str(opts.module),field_modulus=data['field_modulus'],parameter=data['parameter'],
        kernel_frobenius_inputs=[[encode(c) for c in row] for row in K],dual_rows=[[encode(c) for c in row] for row in lam],
        coefficients=records,seconds=time.monotonic()-begun)
    opts.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
    print('QUADRATIC',i,j,'NONZERO',bool(projection),round(time.monotonic()-begun,2),flush=True)
