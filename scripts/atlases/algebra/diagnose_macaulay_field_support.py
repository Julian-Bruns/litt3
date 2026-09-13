#!/usr/bin/env python3
"""Coefficient-field-aware singleton peeling for a bounded multiplier span.

Support diagnostic only. A reported target disconnection must still be
converted to and replayed as an exact dual before rejecting the span.
The expanded F5 matrix can hide these full-field singleton columns.
"""
import argparse
import collections
import json
import time
from pathlib import Path

parser=argparse.ArgumentParser()
parser.add_argument('source',type=Path)
parser.add_argument('--receipt',type=Path)
parser.add_argument('--row-mask',type=Path,
    help='Write the exact selected-row mask for the original expanded matrix')
parser.add_argument('--preserve-degree',type=int,default=0,
    help='Protect all monomials through this degree for consequence extraction')
args=parser.parse_args()
started=time.monotonic()
data=json.loads(args.source.read_text())
monomials=[tuple(m) for m in data['monomials']]
indices={m:i for i,m in enumerate(monomials)}
target=indices[tuple([0]*len(data['variables']))]
protected={i for i,m in enumerate(monomials) if sum(m)<=args.preserve_degree}
columns=[set() for _ in monomials]
rows=[]
for multiplier in data['multipliers']:
    for polynomial in data['equations']:
        row=[indices[tuple(a+b for a,b in zip(exponent,multiplier))]
             for exponent,coefficient in polynomial]
        assert len(set(row))==len(row)
        index=len(rows);rows.append(row)
        for j in row:columns[j].add(index)
initial=collections.Counter(map(len,columns))
queue=collections.deque(j for j,col in enumerate(columns) if j not in protected and len(col)==1)
removed=set();order=[]
while queue:
    pivot=queue.popleft()
    if len(columns[pivot])!=1:continue
    row=next(iter(columns[pivot]))
    assert row not in removed
    removed.add(row);order.append((row,pivot))
    for j in rows[row]:
        columns[j].remove(row)
        if j not in protected and len(columns[j])==1:queue.append(j)
active_columns=sum(bool(c) for c in columns)
neq=len(data['equations'])
groups=collections.defaultdict(list)
for m in range(len(data['multipliers'])):
    mask=tuple(i for i in range(neq) if m*neq+i not in removed)
    groups[mask].append(m)
group_work=[]
for mask,multipliers in groups.items():
    bases={tuple(e) for i in mask for e,c in data['equations'][i]}
    group_work.append(dict(equations=len(mask),base_monomials=len(bases),
                           multipliers=len(multipliers)))
report=dict(scope='Field-level support only, no accepted dual yet',
    preserve_degree=args.preserve_degree,
    rows=len(rows),columns=len(columns),nonzeros=sum(map(len,rows)),
    initial_column_degree_histogram=dict(sorted(initial.items())),
    peeled_rows=len(removed),remaining_rows=len(rows)-len(removed),
    remaining_columns=active_columns,remaining_nonzeros=sum(len(row) for i,row in enumerate(rows) if i not in removed),
    repeated_row_mask_groups=group_work,target_remaining_degree=len(columns[target]),
    target_disconnected=not columns[target],seconds=time.monotonic()-started)
if args.receipt:
    receipt=dict(report,source=str(args.source.resolve()),peeling_order=order,
                 remaining_row_indices=[i for i in range(len(rows)) if i not in removed],
                 remaining_monomial_indices=[i for i,c in enumerate(columns) if c])
    with args.receipt.open('x') as stream:json.dump(receipt,stream,separators=(',',':'))
if args.row_mask:
    degree=data['field_degree']
    mask=bytes(flag for i in range(len(rows))
               for flag in [int(i not in removed)]*degree)
    assert len(mask)==data['rows']
    with args.row_mask.open('xb') as stream:stream.write(mask)
print(json.dumps(report,indent=2),flush=True)
