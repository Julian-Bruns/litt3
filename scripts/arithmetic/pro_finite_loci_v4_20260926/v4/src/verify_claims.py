#!/usr/bin/env python3
"""Check claim-index consistency and referenced files/JSON pointers, not proof validity."""
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parents[1]

def main():
    obj=json.loads((ROOT/'claims.json').read_text())
    claims=obj['claims'];ids=[c['id'] for c in claims]
    assert len(ids)==len(set(ids)), 'duplicate claim IDs'
    references=0
    for c in claims:
        assert c['status'] in {'accepted_input','computationally_checked','proved','conditional','open'}
        for dep in c.get('depends_on',[]):
            assert dep in ids,(c['id'],'unknown dependency',dep)
        for ref in c['evidence']:
            # REPORT references may contain a prose section/lemma locator.
            file_part=ref.split('#',1)[0].split(' ',1)[0]
            path=ROOT/file_part
            assert path.is_file(),(c['id'],'missing file',file_part)
            if '.json#/' in ref:
                data=json.loads(path.read_text())
                for key in ref.split('#/',1)[1].split('/'):
                    key=key.replace('~1','/').replace('~0','~')
                    data=data[int(key)] if isinstance(data,list) else data[key]
            references+=1
    assert obj['target_status']=='open'
    assert obj['new_degrees_excluded']==list(range(14,obj['unresolved_degree_range'][0])) and not obj['actual_witnesses']
    assert obj['unresolved_degree_range'][1]==87
    print(f'PASS: {len(claims)} claim IDs, dependencies, {references} evidence references and JSON pointers')
    print('SCOPE: index consistency only; not automated validation of mathematical proofs')

if __name__=='__main__':main()
