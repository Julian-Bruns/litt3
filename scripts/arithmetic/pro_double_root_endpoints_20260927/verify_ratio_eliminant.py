"""Independent verification of the three explicit annihilator circuits.

The determinants are not expanded and their common zero scheme is NOT
asserted empty. Nonvanishing uses exact point determinants; the global
annihilator identity itself is the universal adjugate identity in REPORT.
"""
import ctypes as ct,struct,json,gzip,hashlib,time,sys
from exact import ROOT,DATA,add,mul,neg,power,peval
from ratio_eliminant_data import load
from ratio_eliminant import library,matrix_at,entry_location,point_coefficients,HEIGHT,WIDTH,DEST

def verify_point_identity(A,c):
    # Python-level multiplication against the ORIGINAL full differential rows.
    # Neither Gaussian elimination nor its operation history is used.
    sums=[[0]*10 for _ in range(71)]
    for j in range(71):
        for m in range(1,210):
            n=m-j;z=(3*j-m)%5
            if z==0 or not 0<=n<=140:continue
            for ell in range(4):
                cc=mul(c[4*(m-1)+ell],z)
                if not cc:continue
                for s in range(7):sums[j][ell+s]=add(sums[j][ell+s],mul(cc,A[n*7+s]))
    assert sums[0][0]==1
    assert all(v==0 for j,row in enumerate(sums) for t,v in enumerate(row) if j or t)

def verify_duals(meta,rec):
    duals=rec['separate_valuation_duals'];columns=rec['selected_columns']
    assert len(columns)==HEIGHT and len(set(columns))==HEIGHT
    assert all(0<=c<WIDTH for c in columns)
    for name,d in duals.items():
        r,c,p=d['row_potentials'],d['column_potentials'],d['matching']
        assert len(r)==len(c)==len(p)==HEIGHT and sorted(p)==list(range(HEIGHT))
        total=0
        for i in range(HEIGHT):
            for j,col in enumerate(columns):
                loc=entry_location(i,col)
                if loc is None or meta['weights_by_T_scale'][loc[0]][loc[1]]<0:
                    assert j!=p[i]
                    continue
                n,s,_=loc
                cost=-meta['weights_by_T_scale'][n][s] if name=='negative_weight' else meta['unit_valuations_by_T_scale'][n][s][name]
                assert r[i]+c[j]<=cost
                if j==p[i]:total+=cost
        assert total==sum(r)+sum(c)==d['value']
    w=-duals['negative_weight']['value']
    assert w==rec['unstripped_weight_bound']
    assert (9*w)//2==rec['unstripped_norm_degree_bound']

def run(fresh=False):
    start=time.time();meta,raw=load();records=json.load(gzip.open(DEST,'rt'));lib=library();fresh_raw={}
    assert records['normalized_residual_raw_sha256']==meta['raw_sha256']
    if fresh:
        from global_residual import sample
        for u in sorted(set(r['point']['u_code'] for r in records['records'])):
            sample(u)
            b=gzip.open(ROOT/'work/global_samples'/f'{u}.bin.gz','rb').read()
            fresh_raw[u]=struct.unpack('<%dI'%(len(b)//4),b)
    for rec in records['records']:
        u,q=rec['point']['u_code'],rec['point']['q_code'];A=point_coefficients(raw,u,q)
        assert hashlib.sha256(struct.pack('<%dI'%len(A),*A)).hexdigest()==rec['point_coefficients_sha256']
        if fresh:
            ar=fresh_raw[u]
            for n in range(141):
                for s in range(7):
                    value=peval(ar[(s*141+140-n)*9:(s*141+140-n+1)*9],q)
                    assert mul(value,power(q,2*s-48))==A[n*7+s]
        verify_point_identity(A,rec['point_cubic_scale_certificate'])
        mat=matrix_at(A,rec['selected_columns']);det=lib.independent_det((ct.c_int*len(mat))(*mat),HEIGHT)
        assert det==rec['point_minor_determinant'] and det!=0
        verify_duals(meta,rec)
        print('ANNIHILATOR',rec['id'],'independent determinant, whole-scale identity and global weight duals verified',flush=True)
    summary={'status':'passed','fresh_source':fresh,'source_algebras':sorted(fresh_raw),
       'all_scale_point_identities_checked_by_independent_python':3,
       'nonzero_determinants_checked_independently':3,'determinants_expanded_globally':False,
       'global_common_zero_scheme_decided':False,'bound_for_dimension_of_explicit_remaining_ratio_algebra':598243,
       'seconds':round(time.time()-start,3)}
    (ROOT/'logs/ratio_eliminant_direct_verification.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary),flush=True)
    return summary
if __name__=='__main__':run('--fresh' in sys.argv)
