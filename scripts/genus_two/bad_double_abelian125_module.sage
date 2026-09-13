"""Six free columns for the actual maximal elementary-abelian5 cover.

This computes the special-fiber Hodge module, not a Witt lift. Checkpoints
retain exact columns. The measured one-column mode is a cost diagnostic.
"""
import argparse,itertools,json,sys,time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--parameter-polynomial',default='2,0,1')
parser.add_argument('--precision',type=int,default=320)
parser.add_argument('--columns',type=int,default=6)
parser.add_argument('--seconds',type=int,default=600)
parser.add_argument('--output',type=Path,required=True)
opts=parser.parse_args();saved_argv=sys.argv
sys.argv=['diagnose_bad_double_noninvariant_covers.sage','--covers','0',
    '--precision',str(opts.precision),'--parameter-polynomial',opts.parameter_polynomial]
load('scripts/genus_two/diagnose_bad_double_noninvariant_covers.sage')
sys.argv=saved_argv
assert len(roots)==5
start=time.monotonic();alarm(opts.seconds)
shifts=[(sum(cl[i]*z**[-3,-1][i] for i in range(2)),zero) for cl in fixed]
shifts.append((zero,anti_root*z))
rhs=[]
for shift in shifts:
    discrepancy=add(fift(shift),neg(shift))
    rem0,aff0=reduce0(discrepancy[0]);rem1,aff1=reduce_anti(discrepancy[1])
    assert rem0.valuation()>=1 and rem1.valuation()>=2
    rhs.append((aff0,aff1))
indices=list(itertools.product(range(5),repeat=3));position={v:i for i,v in enumerate(indices)}
shift_powers=[[power(neg(s),i) for i in range(5)] for s in shifts]
rhs_powers=[[power(s,i) for i in range(5)] for s in rhs]
local={}
for abc in indices:
    entries=[]
    for ijk in itertools.product(*(range(v+1) for v in abc)):
        if ijk==abc:continue
        coefficient=(LS.one(),zero)
        for j in range(3):
            coefficient=mul(coefficient,scal(binomial(abc[j],ijk[j]),shift_powers[j][abc[j]-ijk[j]]))
        entries.append((position[ijk],coefficient))
    local[abc]=entries

def reduce_multi(vec):
    vec=list(vec)
    for abc in reversed(indices):
        nn=position[abc]
        canonical,tail=canon_tangent(vec[nn])
        for pos,entry in local[abc]:vec[pos]=add(vec[pos],neg(mul(entry,tail)))
        vec[nn]=canonical
    return vector(k,[laurent_coefficient(vec[n][p],exponent)
        for n in range(125) for p,exps in enumerate([inv_orders,anti_orders]) for exponent in exps])

XX=PolynomialRing(Fp,'X');xx=XX.gen();polys=[xx**4]
for _ in range(4):polys.append(polys[-1](xx+1)-polys[-1])
tri=matrix(Fp,5,5,lambda i,j:polys[j][i])
smallinv=tri.inverse().tensor_product(tri.inverse()).tensor_product(tri.inverse())
conversion_inverse=smallinv.tensor_product(identity_matrix(Fp,6)).change_ring(k)
terms=[]
for abc in indices:
    term=(LS.one(),zero)
    for j in range(3):term=mul(term,scal(binomial(4,abc[j]),rhs_powers[j][4-abc[j]]))
    terms.append(term)
encode=lambda c:[int(v) for v in c.polynomial().list()]
columns=[]
result=dict(status='partial',parameter_polynomial=opts.parameter_polynomial,
    parameter=encode(t),field_modulus=[int(c) for c in k.modulus()],precision=int(opts.precision),
    source_genus=int(251),scope='Actual special-fiber module, not higher-Witt compatibility',columns=[])
def save():
    result['seconds']=time.monotonic()-start
    opts.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
try:
    for p,exps in enumerate([inv_orders,anti_orders]):
        for exponent in exps:
            if len(columns)>=opts.columns:break
            monomial=(z**exponent,zero) if p==0 else (zero,z**exponent)
            leading=scal(A,fift(monomial))
            col=conversion_inverse*reduce_multi([mul(leading,term) for term in terms])
            columns.append(col);result['columns'].append([encode(c) for c in col]);save()
            print(json.dumps(dict(stage='free_column',number=len(columns),parity=p,
                exponent=int(exponent),seconds=time.monotonic()-start)),flush=True)
    if len(columns)==6:
        PR=PolynomialRing(k,['e1','e2','e3']);e1,e2,e3=PR.gens()
        RR=PR.quotient([e1**5,e2**5,e3**5],names=['d1','d2','d3']);ds=RR.gens()
        mr=matrix(RR,6,6,lambda i,j:sum(columns[j][6*position[abc]+i]*
            prod(ds[h]**abc[h] for h in range(3)) for abc in indices))
        const=matrix(k,6,6,lambda i,j:mr[i,j].lift().constant_coefficient(),implementation='generic')
        assert const.rank()==5
        pivcols=list(const.pivots());pivrows=list(const.matrix_from_columns(pivcols).transpose().pivots())
        ii=next(i for i in range(6) if i not in pivrows);jj=next(j for j in range(6) if j not in pivcols)
        block=mr.matrix_from_rows_and_columns(pivrows,pivcols)
        inv0=const.matrix_from_rows_and_columns(pivrows,pivcols).inverse().change_ring(RR)
        nil=identity_matrix(RR,5)-inv0*block
        inverse=sum((nil**j for j in range(13)),zero_matrix(RR,5))*inv0
        assert inverse*block==identity_matrix(RR,5)
        rel=mr[ii,jj]-(matrix(RR,1,5,[mr[ii,j] for j in pivcols])*inverse*
            matrix(RR,5,1,[mr[i,jj] for i in pivrows]))[0,0]
        result['relation']=[dict(exponent=[int(v) for v in abc],coefficient=encode(c))
            for abc,c in rel.lift().dict().items()]
        result['status']='complete'
except AlarmInterrupt:
    result['status']='time_limit_completed_columns_saved'
finally:cancel_alarm();save()
print(json.dumps({key:val for key,val in result.items() if key not in ['columns','relation','field_modulus','parameter']}),flush=True)
