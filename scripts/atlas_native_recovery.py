"""Explicit, evidence-bound operational recovery; never retries search limits."""
import json
from pathlib import Path
import time
from atlas_native_tensor_input import sha

APPROVED_CLEANUP_FAILURES={
    'orbit_0002':dict(
        tensor='d5f8c22bde2dc3e0dbe97ff2b4880d79f0414b839904ea174d3b0eec7a431415',
        log='native_original_solving-1788824193391061000.log',
        log_sha256='ac0365990c7298e16f2eb7e78e6200a0afb3fa3abc7e1de0e131280df3ca69bc',
        batch_sha256='b35e8cb9d2c650bb8818d424dd6d8a1e0cb2e3b2af0494c905d4d8fec3d0cb29'),
    'orbit_0006':dict(
        tensor='2205623fed2ecace5c33c9702e5f8d1d76f6e543e27f10cd1207d1e587a47012',
        log='native_original_solving-1788820212366849000.log',
        log_sha256='7396e28c1c3f60a0876e432ecbdc32ab7ab0c7b6ff951f63594123089be91fbb',
        batch_sha256='3d7b84344f98c71a62e36615c8b5dbd85acee3093c5eea78115c76db5eb6ba52')}

APPROVED_PACKING_TARGETS={'orbit_0001','orbit_0003','orbit_0005','invariant_3','invariant_4','invariant_5'}
APPROVED_PACKING_REPORT_SHA256='6d0c49b87667a96c1a54519e4e3e3e18c545c371260fb2d375c6ce7ab2c2f18c'


def recover_verified_packing(state,report_path):
    """One approved metadata failure cohort; retain EVERY chart attempt."""
    report_path=Path(report_path);assert sha(report_path)==APPROVED_PACKING_REPORT_SHA256
    report=json.loads(report_path.read_text())
    assert report['status']=='verified' and report['controller_or_chart_state_changed'] is False
    assert {r['representative'] for r in report['representatives']}==APPROVED_PACKING_TARGETS
    pending=[]
    for r in report['representatives']:
        job=state['jobs'][r['representative']]
        if any(h.get('packing_report_sha256')==APPROVED_PACKING_REPORT_SHA256 for h in job.get('restart_history',[])):
            continue
        assert not job.get('deferred') and job['stage']=='needs_attention' and job['reason']=='exit_1'
        assert job['last_log']==r['failed_log'] and sha(job['last_log'])==r['failed_log_sha256']
        assert sha(job['tensor'])==r['tensor_sha256']
        assert r['all32_original_coordinate_roundtrips_verified'] and r['all_preexisting_binary_and_original_hashes_preserved']
        assert len(r['bindings'])==32
        assert all(sha(path)==digest for path,digest in r['preserved'].items())
        assert all(sha(path)==digest for path,digest in r['bindings'].items())
        pending.append((job,r))
    # All six complete checks precede ANY state mutation. We neither clear
    # batch terminal records nor adopt a packing result as an atlas proof.
    for job,r in pending:
        job.setdefault('restart_history',[]).append(dict(time=time.time(),
            reason='approved_exact_legacy_metadata_packing_repair',failed_log=r['failed_log'],
            failed_log_sha256=r['failed_log_sha256'],packing_report=str(report_path.resolve()),
            packing_report_sha256=APPROVED_PACKING_REPORT_SHA256,
            all_original_and_native_binary_hashes_preserved=True,
            preserved_all_terminal_search_attempts=True))
        job.update(stage='paused');job.pop('reason',None)
    return [j['id'] for j,_ in pending]


def recover_cleanup(job,directory,adopt):
    if job['stage']!='needs_attention':return False
    expected=APPROVED_CLEANUP_FAILURES[job['id']]
    directory=Path(directory);log=Path(job['last_log']);batch_path=directory/'batch.json'
    assert job.get('reason')=='exit_1'
    assert log.name==expected['log'] and sha(log)==expected['log_sha256']
    assert sha(Path(job['tensor']))==expected['tensor'] and sha(batch_path)==expected['batch_sha256']
    batch=json.loads(batch_path.read_text());assert batch['source_sha256']==expected['tensor']
    from atlas_native_batch import live_group_members
    for active in batch.get('active',{}).values():
        assert not live_group_members(active['pid']), 'An owned failed-job worker is still live'
    certificates=[]
    for chart in [31,30,29]:
        path=directory/f'chart-{chart:02d}'/'result.json';result=json.loads(path.read_text())
        replay=json.loads((path.parent/'replay.json').read_text())
        assert result['source_sha256']==expected['tensor'] and result['chart']==chart
        assert result['status']=='verified_polynomial_certificate'
        assert result['identity_sum_original_rows_times_multipliers_equals_one_verified']
        assert replay['source_sha256']==expected['tensor'] and replay['certificate_sha256']==sha(path)
        assert replay['verified_original_unit_identity'] and replay['search_or_groebner_solver_used'] is False
        certificates.append(path)
    # All validation precedes mutation. The failed batch and its terminal
    # chart records remain intact; only never-attempted charts can be queued.
    for path in certificates:assert adopt(job,path)
    job.setdefault('restart_history',[]).append(dict(time=time.time(),
        reason='approved_exact_native_cleanup_failure',log=str(log),
        log_sha256=expected['log_sha256'],batch_sha256=expected['batch_sha256'],
        original_chart_certificates={str(p):sha(p) for p in certificates},
        preserved_all_terminal_search_attempts=True))
    job.update(stage='paused');job.pop('reason',None)
    return True


def resume_unstarted_user_stop(job,directory,atomic):
    """Resume only explicit user stops before any search/input artifact.

    Retain the entire old batch byte-for-byte under its content hash. A
    mathematical timeout, memory stop, completed solver input or certificate
    is NEVER reset by this narrow preparation-only recovery.
    """
    directory=Path(directory);path=directory/'batch.json'
    if not path.exists():return []
    batch=json.loads(path.read_text())
    assert batch['source_sha256']==sha(Path(job['tensor']))
    selected=[]
    for chart,record in batch.get('charts',{}).items():
        if not (record.get('status')=='bounded_native_batch_interrupted' and record.get('reason')=='user_stop'):continue
        folder=directory/f'chart-{int(chart):02d}'
        if any(p.name!='events.jsonl' and p.suffix!='.log' for p in folder.iterdir()):continue
        events=folder/'events.jsonl'
        if events.exists() and any(json.loads(line)['stage'] not in
                ('original_input_started','original_rows_constructed')
                for line in events.read_text().splitlines() if line.strip()):continue
        selected.append(chart)
    if not selected:return []
    digest=sha(path);archive=directory/('batch-user-stop-'+digest+'.json')
    if archive.exists():assert sha(archive)==digest
    else:archive.write_bytes(path.read_bytes())
    for chart in selected:
        batch['charts'].pop(chart)
        attempt=job.get('native_original_attempts',{}).get(chart,{})
        if attempt.get('reason')=='user_stop':job['native_original_attempts'].pop(chart)
    batch.setdefault('preparation_only_resume_history',[]).append(dict(time=time.time(),
        charts=selected,original_batch_archive=str(archive),original_batch_sha256=digest))
    atomic(path,batch)
    return selected
