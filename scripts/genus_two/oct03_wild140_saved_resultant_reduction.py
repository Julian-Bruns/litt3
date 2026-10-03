#!/usr/bin/env -S sage -python
"""One 30-second direct reduction using the saved true subresultant data."""
import json
import signal
from pathlib import Path
from sage.all import GF, PolynomialRing

signal.alarm(30)
out=Path('../litt3-computation-data/oct03_wild140_normalized_subresultants')
data=json.loads((out/'raw_degree3_receipt.json').read_text())
R=PolynomialRing(GF(5),names=('Q','B','S','T','Z'))
gb=[R(p) for p in data['groebner_basis']]
raw=R(data['lower_raw_subresultants']['0'][0])
reduced=raw.reduce(gb)
signal.alarm(0)
receipt={'scope':'exact direct degree0 subresultant NF, saved Cartier GB',
         'raw_degree':int(raw.total_degree()),'raw_terms':len(raw.monomials()),
         'normal_form':str(reduced),
         'normal_form_degree':int(reduced.total_degree()),
         'normal_form_terms':len(reduced.monomials())}
(out/'degree0_reduction_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt))
