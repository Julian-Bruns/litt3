"""Audits the global input array and records proved circuit-degree bounds.
The metadata is a compact exact description, not an elimination certificate.
"""
import gzip,json,struct,hashlib,sys
from exact import ROOT
from differential_square import LINEAR_INDICES,QUADRATIC_INDICES

def run(verify=False):
    path=ROOT/'evidence/global_residual.bin.gz';raw=gzip.open(path,'rb').read()
    a=struct.unpack('<%dI'%(133*7*141*9),raw)
    count=0;umax=-1;wmax=-1;sm=-1
    for idx,c in enumerate(a):
        assert 0<=c<390625
        if not c:continue
        t,q=divmod(idx,9);t,x=divmod(t,141);u,s=divmod(t,7)
        count+=1;umax=max(umax,u);wmax=max(wmax,2*u+q);sm=max(sm,s)
    assert count==977302 and umax==129 and sm==6 and wmax<=264
    record={'status':'exact_model_with_global_decision_open',
      'coefficient_ring':'K[u,q]/g_monic, localized only at the recorded original open and previously certified exclusions',
      'global_residual_file':path.relative_to(ROOT).as_posix(),
      'global_residual_raw_sha256':hashlib.sha256(raw).hexdigest(),
      'global_residual_shape':[133,7,141,9],
      'global_residual_axis_order':['u','tau','x','q'],
      'actual_nonzero_K_coefficients':count,'actual_max_u_degree':umax,
      'actual_max_parameter_weight_q1_u2':wmax,'actual_max_tau_degree':sm,
      'original_unit':'L=(3*epsilon^8)^3*q^84*d^33*u^9*F^3',
      'raw_linear_entry':'(3*j-m)*A[m-j], reduced modulo5; 0 outside0..140',
      'raw_root_variables':70,'raw_linear_indices':list(LINEAR_INDICES),
      'raw_quadratic_indices':list(QUADRATIC_INDICES),
      'compressed_root_auxiliaries':14,
      'compressed_formula':'P=(A^3*sum(c_j*T^(5*j),j=0..14)) mod T^71; c0=1; B=P/L^3',
      'compressed_linear_indices':[m for m in LINEAR_INDICES if m>=71],
      'compressed_quadratic_indices':list(QUADRATIC_INDICES),
      'proved_fraction_free_compressed_coefficient_bounds':{
         'P_linear_in_c':{'degree_in_A':3,'tau_degree':18,'weight_q1_u2':792,'normal_u_degree':396},
         'linear_equations':{'degree_in_A':4,'tau_degree':24,'weight_q1_u2':1056,'normal_u_degree':528},
         'quadratic_equations':{'degree_in_A':6,'tau_degree':36,'weight_q1_u2':1584,'normal_u_degree':792}},
      'scope_of_degree_bounds':'uneliminated circuit coefficients; auxiliary elimination can increase degrees',
      'universal_proofs_need_computational_certificates':False,
      'reference_fibre_identity':'evidence/differential_fibre_1.json.gz',
      'new_ratio_exclusions':0,'global_square_ideal_decision':'unresolved'}
    dest=ROOT/'evidence/differential_model.json'
    if verify:assert json.loads(dest.read_text())==record
    else:dest.write_text(json.dumps(record,indent=2)+'\n')
    print('GLOBAL DIFFERENTIAL INPUT AND DEGREE AUDIT PASSED',count,umax,wmax,sm,flush=True)
    return record
if __name__=='__main__':run('--verify' in sys.argv)
