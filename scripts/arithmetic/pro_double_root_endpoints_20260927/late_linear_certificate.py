"""Construct a global leading-coefficient-localized identity for T16..T23.
The proof and independent literal verification, not a ratio sampling test,
are required before using the resulting certificate.
"""
import ctypes as ct,gzip,json,sys,time
from exact import ROOT
from ratio_eliminant_data import load
from fast_arithmetic import library

def run(verify=False):
    meta,raw=load();src=json.loads((ROOT/'evidence/global_source.json').read_text());g=[0]*30
    for iq,iu,a in src['critical_monic']:g[iq*3+iu]=a
    lib=library('lacunary_module');IP=ct.POINTER(ct.c_int)
    lib.late_linear_certificate.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,ct.c_int,IP]
    cap=8192;out=(ct.c_int*(72*cap))();stats=(ct.c_int*10)();start=time.time()
    st=lib.late_linear_certificate((ct.c_int*len(raw))(*raw),133,(ct.c_int*30)(*g),4,out,cap,stats)
    print('LATE-LINEAR STATUS',st,'stats',list(stats),'seconds',time.time()-start,flush=True)
    if st:return
    done,reds,exp,md,events,nz=list(stats)[:6];cert=[]
    for i in range(done):
        p=list(out[i*cap:i*cap+md+1])
        while p and not p[-1]:p.pop()
        if p:cert.append({'x':117+i//9,'q_power':i%9,'u_coefficients':p})
    rec={'status':'constructed_identity_requires_independent_check','identity':'sum C_i(u) q^j [x^i]Rstar(nu,x)=L^e modulo g','leading_power':exp,'source_sha256':meta['raw_sha256'],'x_indices':[117,124],'scale_arbitrary':True,'stats':{'rows_processed':done,'reductions':reds,'max_u_degree':md,'events':events,'nonzero_rows':len(cert),'stored_slots':nz},'certificate':cert}
    dest=ROOT/'evidence/late_linear_global.json.gz';data=json.dumps(rec,separators=(',',':')).encode()
    if verify:assert gzip.open(dest,'rb').read()==data
    else:dest.write_bytes(gzip.compress(data,mtime=0,compresslevel=9))
    return rec
if __name__=='__main__':run('--verify' in sys.argv)
