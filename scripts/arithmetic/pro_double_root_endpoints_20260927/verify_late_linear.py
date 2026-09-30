"""Independently multiply the literal global T16..T23 leading-coefficient identity.
No geometric specializations, polynomial-row trace, or degree interpolation
is used. The actual residual's coefficient array is hash-checked.
"""
import ctypes as ct,gzip,json,time,sys,hashlib
from exact import ROOT,DATA
from ratio_eliminant_data import load
from fast_arithmetic import library

def run():
    if sys.flags.optimize:raise RuntimeError('Do not disable assertions')
    start=time.time();meta,raw=load()
    path=ROOT/'evidence/late_linear_global.json.gz'
    obj=json.loads(gzip.open(path,'rt').read());assert obj['source_sha256']==meta['raw_sha256']
    assert obj['x_indices']==[117,124] and obj['leading_power']>=0
    cert=obj['certificate'];assert cert
    seen=set()
    for r in cert:
        key=(r['x'],r['q_power']);assert key not in seen;seen.add(key)
        assert 117<=key[0]<=124 and 0<=key[1]<9
        assert r['u_coefficients'] and r['u_coefficients'][-1]
        assert all(type(v)==int and 0<=v<390625 for v in r['u_coefficients'])
    stride=max(len(r['u_coefficients']) for r in cert);rows=len(cert)
    flat=[v for r in cert for v in r['u_coefficients']+[0]*(stride-len(r['u_coefficients']))]
    src=json.loads((ROOT/'evidence/global_source.json').read_text());g=[0]*30
    for iq,iu,a in src['critical_monic']:g[3*iq+iu]=a
    lib=library('lacunary_check');IP=ct.POINTER(ct.c_int)
    lib.late_linear_check.argtypes=[IP,ct.c_int,IP,IP,IP,IP,ct.c_int,ct.c_int,ct.c_int,ct.c_int,ct.c_int,IP]
    stats=(ct.c_int*3)()
    status=lib.late_linear_check((ct.c_int*len(raw))(*raw),133,(ct.c_int*30)(*g),
        (ct.c_int*rows)(*(r['x'] for r in cert)),(ct.c_int*rows)(*(r['q_power'] for r in cert)),
        (ct.c_int*len(flat))(*flat),rows,stride,*DATA['d'],obj['leading_power'],stats)
    assert status==0,(status,list(stats))
    summary={'status':'passed','verification':'literal products in K[u][q], independent monic-q reduction',
        'certificate_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),
        'residual_sha256':meta['raw_sha256'],'certificate_rows':rows,'x_indices':sorted(set(r['x'] for r in cert)),
        'certificate_u_degree':stride-1,'target_leading_power':obj['leading_power'],'nonzero_remainder_entries':stats[2],
        'polynomial_products':stats[0],'geometric_specializations_used':0,'seconds':round(time.time()-start,3),
        'global_square_decision':'unresolved'}
    (ROOT/'logs/late_linear_check.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,sort_keys=True),flush=True)
    return summary
if __name__=='__main__':run()
