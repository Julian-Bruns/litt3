#!/usr/bin/env sage
"""Bounded native-field search with a unit identity in ALL original rows.

Completed input, solver output and exact certificates are checkpointed.
Singular's active critical pairs are NOT checkpointed: a bounded incomplete
search is explicitly marked, must not be automatically retried, and leaves
the separate resumable F4 state untouched. No basis candidate is an exclusion.
"""
import argparse,hashlib,json,os,signal,subprocess,time
from pathlib import Path
from atlas_original_chart import OriginalChart,sha


def atomic(path,value):
    tmp=Path(str(path)+'.tmp');tmp.write_text(json.dumps(value,indent=2,default=int)+'\n');tmp.replace(path)


def solve(tensor,chart,output,seconds,memory_gib,precondition=True,deck_grading=None,native_term_cache=False):
    started=time.monotonic();out=Path(output).resolve();out.mkdir(parents=True,exist_ok=True)
    requested=[]
    signal.signal(signal.SIGTERM,lambda *_:requested.append(True))
    signal.signal(signal.SIGINT,lambda *_:requested.append(True))
    result_path=out/'result.json'
    if result_path.exists():
        previous=json.loads(result_path.read_text())
        assert previous['source_sha256']==sha(tensor) and previous['chart']==chart
        assert previous.get('search_representation','original')==('cubic_descended' if deck_grading else 'original')
        if previous['status'] in ['verified_polynomial_certificate','bounded_native_slice_incomplete',
                                  'nonunit_basis_candidate','native_solver_error']:
            print(json.dumps(dict(resumed_completed_result=True,status=previous['status'])),flush=True)
            return previous
    def event(stage,**values):
        record=dict(stage=stage,seconds=time.monotonic()-started,pid=os.getpid(),**values)
        with (out/'events.jsonl').open('a') as stream:stream.write(json.dumps(record,default=int)+'\n')
        print(json.dumps(record,default=int),flush=True)
    event('original_input_started',chart=chart)
    model_path=out/'validated_input.json'
    if model_path.exists():
        validated=json.loads(model_path.read_text())
        assert validated['source_sha256']==sha(tensor) and validated['chart']==chart
        assert validated.get('search_representation','original')==('cubic_descended' if deck_grading else 'original')
    if deck_grading:
        from atlas_deck_chart import CubicDescendedChart
        model=CubicDescendedChart(tensor,chart,deck_grading)
        if model_path.exists():
            assert validated['field_model']==model.field_model
            assert validated['deck_grading_sha256']==sha(deck_grading)
    elif model_path.exists():
        model=OriginalChart(tensor,chart,field_model=validated['field_model'],native_input=True,retain_terms=native_term_cache)
    else:model=OriginalChart(tensor,chart,native_input=True,retain_terms=native_term_cache)
    event('original_rows_constructed',construction=model.timings)
    result=dict(status='not_started',chart=int(chart),source_sha256=model.source_sha256,
        tensor_path=str(model.path),field_model=getattr(model,'original_field_model',model.field_model),
        search_field_model=model.field_model,variables=model.names,
        search_representation='cubic_descended' if deck_grading else 'original',
        original_equation_count=97,original_equation_order=
        'n0..n63; s_h-delta_hj for h<=j; s_h^5-b_h for h>j; w*sum(v_i*s_i)-1',
        all_compact_R_equations_retained=True,original56_R_equivalence='Verified tensor coupled-R witness',
        engine='native_field_liftstd_original',solver_active_critical_pair_checkpoint=False,
        original_field_description=model.description,
        original_row_construction=model.timings,
        scope='One original rooted untwisted chart only; no whole-oper or common-cover conclusion')
    if deck_grading:
        result['exact_cubic_descent']=dict(grading_path=str(Path(deck_grading).resolve()),
            grading_sha256=sha(deck_grading),original_degree_F5=model.original_field_model['degree_F5'],
            search_degree_F5=model.degree,row_weights=model.row_weights,
            variable_weights=model.variable_weights,all97_rows_retained=True,
            formula='F_original=t^row_weight*F_search(t^(-variable_weight)*original_variables)',
            nonconstant_denominators_used=False)
    unit_checkpoint=out/'search-unit.json'
    def accept_unit(multipliers):
        model.verify_unit(multipliers)
        checkpoint=dict(source_sha256=model.source_sha256,chart=int(chart),
            field_model=model.field_model,search_representation=result['search_representation'],
            deck_grading_sha256=sha(deck_grading) if deck_grading else None,
            polynomial_multipliers=[str(h) for h in multipliers],
            exact_identity_in_all97_search_rows_verified=True)
        if unit_checkpoint.exists():assert json.loads(unit_checkpoint.read_text())==checkpoint
        else:atomic(unit_checkpoint,checkpoint)
        if deck_grading:
            event('original_coordinate_unit_lift_started',search_degree_F5=model.degree)
            before=time.monotonic();original_model,multipliers=model.lift_certificate(multipliers)
            assert original_model.field_model==result['field_model']
            result['exact_cubic_descent'].update(original_unit_lift_seconds=time.monotonic()-before,
                unit_identity_in_reconstructed_original97_rows_verified=True,
                fresh_original_JSON_replay_still_required_before_adoption=True,
                original_row_construction=original_model.timings)
            event('original_coordinate_unit_lift_verified',seconds_in_stage=time.monotonic()-before)
        result.update(status='verified_polynomial_certificate',
            polynomial_multipliers=[str(h) for h in multipliers],
            identity_sum_original_rows_times_multipliers_equals_one_verified=True,
            max_multiplier_degree=max((h.total_degree() for h in multipliers if h),default=0))
    if unit_checkpoint.exists():
        checkpoint=json.loads(unit_checkpoint.read_text())
        assert checkpoint['source_sha256']==model.source_sha256 and checkpoint['chart']==chart
        assert checkpoint['field_model']==model.field_model
        assert checkpoint['search_representation']==result['search_representation']
        assert checkpoint['deck_grading_sha256']==(sha(deck_grading) if deck_grading else None)
        assert checkpoint['exact_identity_in_all97_search_rows_verified']
        event('resuming_exact_search_unit_checkpoint',checkpoint_sha256=sha(unit_checkpoint))
        accept_unit([model.parse(h) for h in checkpoint['polynomial_multipliers']])
        result.update(resumed_exact_search_unit_checkpoint=True,elapsed_seconds=time.monotonic()-started)
        atomic(result_path,result);event('finished',status=result['status']);return result
    conditioner=None;immediate=None
    for index,f in enumerate(model.original):
        if f and f.total_degree()==0:
            immediate=[model.ring.zero() for _ in model.original]
            immediate[index]=model.ring(1/f);break
    if precondition and immediate is None:
        from atlas_affine_precondition import AffinePrecondition
        conditioner=AffinePrecondition(model,reuse_native_terms=native_term_cache)
        immediate=conditioner.immediate_unit()
        event('exact_affine_preconditioning',seconds_in_stage=conditioner.seconds,
              row_reductions=conditioner.statistics,remaining_rows=len(conditioner.rows))
        result['exact_affine_preconditioning']=dict(seconds=conditioner.seconds,
            row_reductions=conditioner.statistics,variable_denominators_used=False)
    if immediate is not None:
        accept_unit(immediate)
        result.update(groebner_search_needed=False,elapsed_seconds=time.monotonic()-started)
        atomic(result_path,result);event('finished',status=result['status']);return result
    original=conditioner.rows if conditioner is not None else model.original
    modulus=PolynomialRing(GF(5),'c')(model.field_model['modulus'])
    body=('ring r=(5,c),(%s),dp; minpoly=%s; short=0;\n'%(','.join(model.names),modulus)+
          'ideal I='+',\n'.join(str(f) for f in original)+';\n')
    body_sha=hashlib.sha256(body.encode()).hexdigest()
    native_input=out/'native-input.sing'
    if model_path.exists():
        assert validated['native_input_sha256']==body_sha and sha(native_input)==body_sha
    else:
        temporary=out/'native-input.sing.tmp';temporary.write_text(body);temporary.replace(native_input)
        # Independent parser roundtrip before admitting input to search.
        roundtrip=out/'roundtrip.txt'
        if roundtrip.exists():raise RuntimeError('Unvalidated parse artifact exists; inspect before retry')
        program=body+'int ii; for(ii=1;ii<=size(I);ii++){write(%s,string(I[ii]));} quit;\n'%json.dumps(str(roundtrip))
        parsed=subprocess.run(['Singular','-q'],input=program,text=True,capture_output=True,timeout=float(30))
        (out/'parse.log').write_text(parsed.stdout+parsed.stderr)
        assert parsed.returncode==0 and roundtrip.exists()
        parsed_rows=roundtrip.read_text().splitlines()
        assert len(parsed_rows)==len(original) and all(model.parse(f)==g for f,g in zip(parsed_rows,original))
        atomic(model_path,dict(source_sha256=model.source_sha256,chart=int(chart),
            field_model=model.field_model,native_input_sha256=body_sha,
            search_representation='cubic_descended' if deck_grading else 'original',
            deck_grading_sha256=sha(deck_grading) if deck_grading else None,
            search_row_count=len(original),search_rows_sage_singular_roundtrip_verified=True,
            every_coefficient_fifth_root_identity_verified=True))
    event('original_input_verified',degree_F5=model.degree,rows=len(original),original_rows=97,
          terms=sum(len(f.dict()) for f in original),native_input_bytes=len(body))
    basis_path=out/'basis.txt';weights_path=out/'multipliers.txt';complete=out/'solver-complete.txt'
    program=(body+'option(prot); matrix T; ideal G=liftstd(I,T);\n'+
        'int ii; for(ii=1;ii<=size(G);ii++){write(%s,string(G[ii]));}\n'%json.dumps(str(basis_path))+
        'if(size(G)==1 && deg(G[1])==0 && G[1]!=0){\n'+
        'for(ii=1;ii<=nrows(T);ii++){write(%s,string(T[ii,1]/G[1]));}\n'%json.dumps(str(weights_path))+
        '}\nwrite(%s,string(size(G))+","+string(nrows(T))+","+string(ncols(T))); quit;\n'%json.dumps(str(complete)))
    if not complete.exists():
        # Partial solver files cannot be reused as a complete checkpoint.
        if basis_path.exists() or weights_path.exists():
            raise RuntimeError('Partial solver artifact exists; preserve and diagnose before new search')
        (out/'solve.sing').write_text(program)
        remaining=seconds-(time.monotonic()-started)
        if remaining<=0:
            result.update(status='bounded_native_slice_incomplete',reason='input_exhausted_time_budget')
            result['elapsed_seconds']=time.monotonic()-started;atomic(result_path,result);return result
        peak=0;next_report=0;interruption=None
        with (out/'singular.log').open('w') as log:
            proc=subprocess.Popen(['Singular','-q',str(out/'solve.sing')],stdout=log,stderr=subprocess.STDOUT)
            event('native_liftstd_started',solver_pid=proc.pid,remaining_seconds=remaining)
            while proc.poll() is None:
                values=subprocess.run(['ps','-o','rss=,pcpu=','-p',str(proc.pid)],text=True,capture_output=True).stdout.split()
                rss=int(values[0])*1024 if values else 0;peak=max(peak,rss)
                now=time.monotonic()
                if now>=next_report:
                    event('native_liftstd_progress',solver_pid=proc.pid,rss_bytes=rss,
                          cpu_percent=float(values[1]) if values else 0)
                    next_report=now+10
                if requested or now-started>=seconds or rss>memory_gib*1024**3:
                    interruption='user_stop' if requested else ('memory_limit' if rss>memory_gib*1024**3 else 'time_limit')
                    proc.terminate()
                    try:proc.wait(timeout=float(2))
                    except subprocess.TimeoutExpired:proc.kill();proc.wait()
                    break
                time.sleep(float(.25))
        result['peak_solver_rss_bytes']=peak;result['solver_returncode']=proc.returncode
        if not complete.exists():
            result.update(status='bounded_native_slice_incomplete' if interruption else 'native_solver_error',
                          reason=interruption or 'native_solver_returned_without_completed_artifact')
            result['elapsed_seconds']=time.monotonic()-started;atomic(result_path,result)
            event('finished',status=result['status'],reason=result['reason']);return result
    sizes=[int(v) for v in complete.read_text().strip().split(',')]
    basis=[model.parse(f) for f in basis_path.read_text().splitlines()]
    assert len(sizes)==3 and sizes[0]==len(basis) and sizes[1]==len(original) and sizes[2]==len(basis)
    result['completed_solver_artifact_hashes']={p.name:sha(p) for p in [basis_path,complete]}
    if len(basis)==1 and basis[0] and basis[0].total_degree()==0:
        multipliers=[model.parse(f) for f in weights_path.read_text().splitlines()]
        if conditioner is not None:multipliers=conditioner.lift(multipliers)
        accept_unit(multipliers)
        result['completed_solver_artifact_hashes'][weights_path.name]=sha(weights_path)
    else:
        # A nonunit candidate is not a proof of existence or even a verified GB.
        result.update(status='nonunit_basis_candidate',candidate_basis=[str(f) for f in basis])
    result['elapsed_seconds']=time.monotonic()-started;atomic(result_path,result)
    event('finished',status=result['status']);return result


if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--tensor',required=True);ap.add_argument('--chart',type=int,required=True)
    ap.add_argument('--output',required=True);ap.add_argument('--seconds',type=float,default=120)
    ap.add_argument('--raw',action='store_true',help='Bounded regression only: omit reversible affine preprocessing')
    ap.add_argument('--deck-grading',type=Path,
        help='Experimental checked cubic coefficient descent; every unit is lifted to original coordinates')
    ap.add_argument('--native-term-cache',action='store_true',
        help='Reuse exactly constructed native coefficients for the first affine row reduction')
    ap.add_argument('--memory-gib',type=float,default=.75);args=ap.parse_args()
    assert args.seconds>0 and args.memory_gib>0
    solve(args.tensor,args.chart,args.output,args.seconds,args.memory_gib,not args.raw,args.deck_grading,args.native_term_cache)
