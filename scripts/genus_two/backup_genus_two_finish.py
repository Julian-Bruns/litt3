"""Checkpointable exact final Cech contractions for backup atlas tensors."""
import hashlib
import json
from pathlib import Path
import time
from sage.all import Infinity, load, matrix, save, vector


def relation_path(state_path,index):
    return Path(str(state_path)+'.relation_'+str(index)+'.json')


def atomic_json(path,data):
    path=Path(path);path.parent.mkdir(parents=True,exist_ok=True)
    temporary=Path(str(path)+'.tmp')
    temporary.write_text(json.dumps(data,indent=1,default=int)+'\n');temporary.replace(path)


def finish(state_path,output,only_relation=None,inventory_only=False,aggregate_only=False):
    started=time.monotonic();state=load(str(state_path))
    assert state['format']==4
    digest=hashlib.sha256(Path(state_path).read_bytes()).hexdigest()
    partial_path=Path(str(state_path)+'.partial.sobj')
    partial=load(str(partial_path)) if partial_path.exists() else {'tensor':[],'relations_checked':0}
    if inventory_only:
        manifest={'state_sha256':digest,'state_path':str(Path(state_path).resolve()),
                  'tensor_blocks':len(partial['tensor']),
                  'contiguous_relations_checked':partial['relations_checked'],
                  'relation_count':len(state['relation_alphas']),
                  'twist_index':state['result']['twist_index'],
                  'field_degree':state['result']['field_degree']}
        atomic_json(str(state_path)+'.tasks.json',manifest)
        print(json.dumps(manifest,indent=1),flush=True)
        return manifest
    k,LS=state['k'],state['LS'];q=LS.gen();upper=int(state['HH_upper'])
    exps=state['HH_exps'];projection=state['HH_projection']
    def unpack(data):
        valuation,coefficients,precision=data
        f=LS(coefficients)*q**valuation
        return f if precision is None else f.add_bigoh(precision)
    unpack_vector=lambda values:vector(LS,[unpack(f) for f in values])
    reducers={pole:unpack(f) for pole,f in state['HH_reducers'].items()};stats=state['result']['reduction_checks']
    Ji=matrix(LS,[[unpack(f) for f in row] for row in state['Ji']]);hi=unpack(state['hi'])
    ps=[unpack_vector(v) for v in state['ps']];alphas=[unpack_vector(v) for v in state['alphas']]
    def checkpoint():
        tmp=Path(str(partial_path)+'.tmp.sobj');save(partial,str(tmp),compress=False);tmp.replace(partial_path)
    def coefficient(f,e):
        assert f.precision_absolute()==Infinity or e<f.precision_absolute()
        return f[e] if f and f.valuation()<=e<=f.degree() else k.zero()
    def project(vec):
        answer=[]
        for value in vec:
            f=LS(value)
            assert f.precision_absolute()>=upper and f.valuation()>=-80
            if f: stats['max_input_pole']=max(stats['max_input_pole'],-int(f.valuation()))
            if f.precision_absolute()!=Infinity:
                stats['minimum_precision_margin']=min(stats['minimum_precision_margin'],int(f.precision_absolute())-upper)
            if state.get('linear_projection',False):
                sample=vector(k,[coefficient(f,e) for e in state['HH_sample_exps']])
                answer.extend(state['HH_scalar_reduction']*sample)
            else:
                f=f.add_bigoh(upper)
                for pole in sorted(reducers,reverse=True):
                    if -pole>=upper or -pole<f.valuation():continue
                    coef=coefficient(f,-pole)
                    if coef:f-=coef*reducers[pole]/coefficient(reducers[pole],-pole)
                assert all(e>0 or e in exps for e in f.exponents())
                answer.extend(coefficient(f,e) for e in exps)
        return projection*vector(k,answer)
    def frob(f):
        if f.precision_absolute()==Infinity:return f**5
        return sum((coef**5*q**(5*e) for e,coef in zip(f.exponents(),f.coefficients())),LS.zero()).add_bigoh(5*int(f.precision_absolute()))
    def flatten(mat):return vector(LS,[mat[i,j] for j in range(2) for i in range(2)])

    def check_relation(index):
        alpha=unpack_vector(state['relation_alphas'][index])
        assert not project(vector(LS,[alpha[0],0,alpha[1],0]))
        col=(Ji*alpha.apply_map(frob))*hi
        for p in ps:assert not project(flatten(col.column()*p.row()))

    if only_relation is not None:
        index=int(only_relation);assert 0<=index<len(state['relation_alphas'])
        check_relation(index)
        record={'state_sha256':digest,'relation_index':index,
                'exact_I_and_all_four_tensor_coboundaries_zero':True,
                'reduction_checks':stats,'elapsed_seconds':time.monotonic()-started}
        atomic_json(relation_path(state_path,index),record)
        print(json.dumps(record,indent=1),flush=True)
        return record

    if aggregate_only:assert len(partial['tensor'])==4
    for i in range(len(partial['tensor']),4):
        block=[]
        for alpha in alphas:
            col=(Ji*alpha.apply_map(frob))*hi
            block.append(project(flatten(col.column()*ps[i].row())))
        partial['tensor'].append(block);checkpoint()
        print('tensor block saved',state['result']['twist_index'],i,time.monotonic()-started,flush=True)
    for index in range(partial['relations_checked'],len(state['relation_alphas'])):
        path=relation_path(state_path,index)
        if path.exists():
            record=json.loads(path.read_text())
            assert record['state_sha256']==digest and record['relation_index']==index
            assert record['exact_I_and_all_four_tensor_coboundaries_zero']
            checked=record['reduction_checks']
            stats['max_input_pole']=max(stats['max_input_pole'],checked['max_input_pole'])
            stats['minimum_precision_margin']=min(stats['minimum_precision_margin'],checked['minimum_precision_margin'])
        else:
            assert not aggregate_only, ('missing exact relation check',index)
            check_relation(index)
        partial['relations_checked']=index+1;checkpoint()
    tensor=partial['tensor'];Imat=state['Imat']
    universal=matrix(k,12,16,[tensor[i][j][h] for h in range(12) for i in range(4) for j in range(4)])
    enc=lambda value:[int(c) for c in value.polynomial().list()]
    result=state['result']
    result.update({'status':'full intrinsic tensor computed; no solver or common-cover claim',
        'tensor':[[[enc(c) for c in vec] for vec in block] for block in tensor],
        'universal_tensor_rank':int(universal.rank()),
        'constant_b_linear_rank':int((universal.left_kernel().basis_matrix()*Imat).rank()),
        'all_B_coboundary_generators_verified':True,'checkpoint_state':str(state_path),
        'finish_elapsed_seconds_this_run':time.monotonic()-started})
    result['elapsed_seconds']=result['build_elapsed_seconds']+result['finish_elapsed_seconds_this_run']
    target=Path(output);atomic_json(target,result)
    print(json.dumps({'output':str(target),'twist':result['twist_index'],'field_degree':result['field_degree'],
                     'universal_tensor_rank':result['universal_tensor_rank'],'elapsed_seconds':result['elapsed_seconds']},indent=2,default=int),flush=True)


if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--state',required=True);parser.add_argument('--output')
    task=parser.add_mutually_exclusive_group()
    task.add_argument('--relation',type=int)
    task.add_argument('--inventory',action='store_true')
    task.add_argument('--aggregate-only',action='store_true')
    args=parser.parse_args()
    if args.relation is None and not args.inventory and not args.output:parser.error('--output required for final tensor')
    finish(args.state,args.output,args.relation,args.inventory,args.aggregate_only)
