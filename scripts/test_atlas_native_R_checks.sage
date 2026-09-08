#!/usr/bin/env sage
"""Original56-row native checker, exact scalar fixtures and negative controls."""
import json,tempfile,time,subprocess
from pathlib import Path
from atlas_native_R_checks import NativeRChecks

set_random_seed(20260908);reports=[]
for degree in [2,240,410,1320]:
    start=time.monotonic();P=PolynomialRing(GF(5),'x')
    if degree==2:modulus=P([2,4,1])
    elif degree==240:
        p=Path('/Users/julian/Documents/litt3-computation-data/orbit11-structure/complete_native_orbit_0004/report.json')
        modulus=P(json.loads(p.read_text())['field_modulus'])
    else:
        rep='orbit_0006' if degree==410 else 'orbit_0007'
        p=Path('/Users/julian/Documents/litt3-computation-data/atlas-all18')/rep/'tensor/complete_native/binding-00.json'
        modulus=P(json.loads(p.read_text())['native_modulus'])
    k=GF(5**degree,'c',modulus=modulus,check_irreducible=False)
    M=lambda r,c:matrix(k,r,c,implementation='generic')
    H,B,I,N,C,raw=M(56,64),M(56,32),M(32,56),M(64,32),M(32,32),M(56,32)
    for i in range(32):B[i,i]=I[i,i]=C[i,i]=raw[i,i]=1
    # Full-degree coefficients, with sparse matrices so that an independent
    # scalar audit costs seconds, not a new full tensor calculation.
    for i in range(24):
        H[32+i,i]=k.random_element();N[i,i]=k.random_element()
        raw[32+i,i]=H[32+i,i]*N[i,i]
    assert I*raw==C and H*N+B*C==raw
    with tempfile.TemporaryDirectory(prefix='atlas-R-check-fixture-') as td:
        path=Path(td)/'block.bin';checker=NativeRChecks(H,B,I,td)
        checker.pack_test_block(path,(N,C,raw));result=checker.run(path);assert result['valid']
        corrupted=copy(raw);corrupted[55,0]+=1
        checker.pack_test_block(path,(N,C,corrupted));assert checker.run(path)['valid'] is False
        corrupted=copy(raw);corrupted[0,0]+=1
        checker.pack_test_block(path,(N,C,corrupted))
        try:checker.run(path)
        except subprocess.CalledProcessError:pass
        else:raise AssertionError('Projection corruption accepted')
    reports.append(dict(degree_F5=int(degree),exact_scalar_original_R_agreement=True,
                        negative_controls_rejected=True,result=result,seconds=time.monotonic()-start))
print(json.dumps(dict(all_passed=True,reports=reports),default=int),flush=True)
