import subprocess,json
from pathlib import Path
roots=[9,14,2514,7367,20130,104315,139659,154113,281660,364472]
records=[]
for r in roots:
 cmd=['build/independent_gmp_verify',f'next/r{r}',f'verified_fibres/r{r}']
 with open(f'next/evidence/independent_gmp_r{r}.log','w') as f:subprocess.run(cmd,check=True,stdout=f,stderr=subprocess.STDOUT)
 records.append({'r':r,'command':cmd,'outcome':'PASS'});print(r,'independent GMP PASS',flush=True)
Path('next/evidence/independent_gmp_summary.json').write_text(json.dumps({'GMP':'6.3.0','all_full_bezout_and_quotient_identities_independently_verified':True,'records':records},indent=2)+'\n')
