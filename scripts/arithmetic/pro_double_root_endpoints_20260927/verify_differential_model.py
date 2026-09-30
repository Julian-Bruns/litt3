"""Actual-family comparison with all 70 original square equations.
A whole degree-nine coefficient algebra is retained at each reference u.
The scale tau is a polynomial indeterminate, never a finite-field sample.
These are bounded implementation checks; the ideal equivalence is universal.
"""
import struct,json,time,sys,hashlib
from exact import ROOT
from extension import E,Poly,init
from fibres_u import load_sample,fibre_modulus
from residual import square_equations
from differential_square import equations,root_residual,differential_values
from test_differential_square import canonical_root

def run(nodes):
    start=time.time();records=[]
    for u0 in nodes:
        orig,mod,removed=fibre_modulus(u0)
        if orig!=mod:raise ValueError('No primary factor may be discarded in this checker')
        init(orig);raw=load_sample(u0)
        arr=struct.unpack('<%dI'%(7*141*9),raw)
        R=[Poly([E(arr[(s*141+x)*9:(s*141+x+1)*9]) for x in range(141)]) for s in range(7)]
        A=[Poly([R[s][140-m] for s in range(7)]) for m in range(141)]
        assert A[0].degree()==0
        L=A[0][0];B=canonical_root(A);EE=root_residual(A,B)
        DD=differential_values(A,B);GG=equations(A,B)
        assert not any(EE[:71]) and not any(GG[:70])
        old=square_equations(R,True)
        tails=[p/(L**63) for p in old[:54]]
        assert [p/(L**126) for p in old[54:]]==[p/L for p in EE[125:]]
        for m in range(71,125):
            expected=sum((3*tails[j-71]*B[m-j] for j in range(71,m+1)),Poly())
            assert EE[m]/L==expected,('original first54 comparison',u0,m)
        # The exact lower-triangular transfer, including the late coefficients.
        for m in range(71,141):
            rhs=sum((B[i]*EE[m-i]*((m-3*i)%5)
                for i in range(1,min(70,m-71)+1)),Poly())
            assert DD[m-1]-EE[m]*(m%5)==rhs,('all70 differential transfer',u0,m)
        # Every matrix coefficient is an original A_i times a prime-field scalar.
        assert max(p.degree() for p in A)==6
        rec={'u_code':u0,'whole_coefficient_algebra_length':9,'removed_factors':removed,
             'residual_raw_sha256':hashlib.sha256(raw).hexdigest(),
             'coefficient_scope':'all 987 original residual coefficients',
             'scale':'unrestricted polynomial tau; no specialization',
             'old_first54':'triangular unit comparison passed',
             'old_last16':'exact comparison passed',
             'new_first70':'identically zero after monic root elimination',
             'new_last70':'lower-triangular ideal transfer passed',
             'raw_matrix_coefficient_scale_degree':6,
             'eliminated_equation_scale_degrees':[p.degree() for p in GG[70:]]}
        records.append(rec)
        print('ACTUAL FULL-SCALE DIFFERENTIAL MODEL VERIFIED',u0,flush=True)
    result={'status':'passed','reference_algebras':records,'seconds':round(time.time()-start,3),
        'scope':'bounded independent implementation comparisons; not new ratio exclusions',
        'global_square_ideal':'unresolved'}
    dest=ROOT/'logs'/('differential_model_checks_'+('_'.join(map(str,nodes)))+'.json')
    dest.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)
    return result
if __name__=='__main__':run([int(x) for x in sys.argv[1:]] or [1,132])
