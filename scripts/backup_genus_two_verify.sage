#!/usr/bin/env sage
"""Independently replay original-equation unit identities, without a solver."""
import argparse
import hashlib
import json
from pathlib import Path


def verify(path,tensor_directory=None):
    certificate=json.loads(Path(path).read_text())
    assert certificate['status']=='empty_chart_exact_original_equation_certificate'
    tensor_path=Path(certificate['tensor_path'])
    if tensor_directory is not None:tensor_path=Path(tensor_directory)/tensor_path.name
    tensor_raw=tensor_path.read_bytes()
    assert hashlib.sha256(tensor_raw).hexdigest()==certificate['tensor_sha256']
    tensor=json.loads(tensor_raw)
    Q=PolynomialRing(GF(5),'x')
    k=GF(5**tensor['field_degree'],name='c',modulus=Q(tensor['field_modulus']));c=k.gen()
    decode=lambda cs:k(Q(cs))
    chart=certificate['chart_first_nonzero_b'];nfree=3-chart
    names=['p'+str(i) for i in range(4)]+['b'+str(j) for j in range(chart+1,4)]+['z']
    assert names==certificate['variables']
    R=PolynomialRing(k,names=names,order='degrevlex')
    pp=list(R.gens()[:4]);bb=[R.zero()]*chart+[R.one()]+list(R.gens()[4:4+nfree]);z=R.gens()[-1]
    original=[sum(decode(tensor['I'][h][j])*bb[j] for j in range(4))+
              sum(decode(tensor['tensor'][i][j][h])*pp[i]*bb[j]**5 for i in range(4) for j in range(4))
              for h in range(12)]
    norm=sum(decode(tensor['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))
    original.append(z*norm-1)
    loc=dict(zip(names,R.gens()));loc['c']=c
    parse=lambda s:R(sage_eval(s,locals=loc))
    assert [parse(s) for s in certificate['original_equations']]==original
    lift=[parse(s) for s in certificate['unit_certificate_multipliers']]
    assert len(lift)==13 and sum(h*f for h,f in zip(lift,original))==1
    return {'twist':int(tensor['twist_index']),'chart':int(chart),'certificate':str(Path(path).resolve()),
            'certificate_sha256':hashlib.sha256(Path(path).read_bytes()).hexdigest(),
            'tensor_filename':tensor_path.name,'tensor_sha256':certificate['tensor_sha256'],
            'verified_exact_unit_identity':True}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('certificates',nargs='+')
    parser.add_argument('--tensor-directory',help='Optional relocated tensor directory; exact hashes remain mandatory.')
    parser.add_argument('--json-output',help='Optional small replay receipt; not a mathematical-construction audit.')
    args=parser.parse_args();results=[verify(path,args.tensor_directory) for path in args.certificates]
    print(json.dumps(results,indent=2),flush=True)
    groups={}
    for row in results:groups.setdefault(row['twist'],set()).add(row['chart'])
    for twist,charts in groups.items():
        if charts=={0,1,2,3}:print('WHOLE REPRESENTATIVE EMPTY, all four charts, twist',twist,flush=True)
    if args.json_output:
        output={'status':'independent_no_solver_original_equation_identity_replay',
                'construction_independently_audited':False,'certificates':results,
                'whole_empty_representatives':sorted(twist for twist,charts in groups.items() if charts=={0,1,2,3}),
                'scope':'Endpoint coefficient systems only; no common-cover or complete cored exclusion.'}
        target=Path(args.json_output);target.parent.mkdir(parents=True,exist_ok=True)
        temporary=Path(str(target)+'.tmp');temporary.write_text(json.dumps(output,indent=2)+'\n');temporary.replace(target)
