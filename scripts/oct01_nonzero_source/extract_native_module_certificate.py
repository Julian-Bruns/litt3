#!/usr/bin/env python3
"""Extract small exact targets and the last polynomial basis from native stream."""
import argparse,json
from pathlib import Path
import numpy as np
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);a=p.parse_args();d=a.directory;meta=json.loads((d/'metadata.json').read_text());cols=meta.get('module_columns',126);v=np.memmap(d/'native_module_operations.bin',dtype='<u4',mode='r');k=0
assert int(v[k])==0x4c495433;k+=1;n=int(v[k]);k+=1;selected=v[k:k+n].copy();k+=n;last_rows=None;annihilator=None;bad=None;counts={};divisors={}
def poly():
    global k
    n=int(v[k]);k+=1;result=v[k:k+n].copy();k+=n;return result
while k<len(v):
    op=int(v[k]);k+=1;counts[str(op)]=counts.get(str(op),0)+1
    if op in (1,5):
        k+=1;dpoly=tuple(map(int,poly()));divisors[dpoly]=divisors.get(dpoly,0)+1
    elif op in (2,4):k+=2
    elif op==3:k+=2;poly()
    elif op==10:
        rows=int(v[k]);k+=1;polys=[[poly() for j in range(cols)] for i in range(rows)];width=max(map(len,(f for row in polys for f in row)));last_rows=np.zeros((rows,cols,width),dtype=np.uint32)
        for i,row in enumerate(polys):
            for j,f in enumerate(row):last_rows[i,j,:len(f)]=f
    elif op==12:
        annihilator=poly();remainders=[[poly() for j in range(cols)] for i in range(21)];assert all(not len(f) for r in remainders for f in r)
    elif op==13:bad=poly();passed=int(v[k]);k+=1;assert passed==1
    else:raise ValueError((op,k))
assert last_rows is not None and annihilator is not None and bad is not None
np.savez_compressed(d/'small_certificate.npz',basis=last_rows,annihilator=annihilator,bad_factor=bad,selected_rows=selected)
(d/'row_divisors.json').write_text(json.dumps({'scope':'literal original-row and saturation divisors from retained operation stream','divisors':[{'coefficients':list(f),'uses':n} for f,n in divisors.items()]},separators=(',',':'))+'\n')
uncleared=meta.get('auxiliaries',0)==15
smallcritical='exact m6 leading NOT inverted' in meta.get('units','')
domain='H selectedcriticalleading'+('' if smallcritical else ' exactm6leading')+('' if uncleared else ' auxiliarydelta')
report={'status':'all21constanttargets_exactly_annihilated','basis_shape':list(last_rows.shape),'annihilator_degree':len(annihilator)-1,'additional_bad_degree':len(bad)-1,'stream_operations':counts,'stream_words':len(v),'selected_rows':selected.tolist(),'input_field':meta['field_modulus'],'meaning':'whole eta/lambda exclusion conditional on '+domain+'; endpoint type '+str(meta.get('root',d.name.split('_')[-1]))+'; auxiliary determinant zero '+('included' if uncleared else 'retained as unresolved boundary')}
(d/'small_certificate.json').write_text(json.dumps(report,separators=(',',':'))+'\n');print(json.dumps({k:report[k] for k in ['status','basis_shape','annihilator_degree','additional_bad_degree','stream_operations']}))
