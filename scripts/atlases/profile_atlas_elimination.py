#!/usr/bin/env python3
"""Read saved pencil pivots/provenance; measure work, not mathematical rank.

Run with sage -python (NumPy). This never changes a checkpoint. The native
checkpoint's own loader verifies its checksum on resumption; this profiler
checks layout, counts, normalizations, and exact polynomial translations.
"""
import argparse
import hashlib
import itertools
import json
import mmap
from pathlib import Path
import struct
import time
import numpy as np


def profile(folder, output, translations=True):
    start = time.monotonic()
    folder = Path(folder)
    metadata = json.loads((folder/'matrix.json').read_text())
    result = json.loads((folder/'result.json').read_text())
    checkpoint = folder/'state.cp'
    q = 31 - metadata['chart']
    if metadata['v_degree'] != 0:
        raise ValueError('Translation profiling currently expects linear-in-v A=0')
    B = metadata['b_degree']
    tags = lambda degree: [tuple(c) for d in range(degree+1)
                           for c in itertools.combinations_with_replacement(range(q), d)]
    columns = sorted((((i,), b) for i in range(32) for b in tags(B+1)),
                     key=lambda vb: (-len(vb[0])-len(vb[1]),-len(vb[0]),vb))
    boundary = len(columns)
    columns += sorted((((),b) for b in tags(B)),key=lambda vb:(-len(vb[1]),vb))
    # Four bits per exponent suffice for this diagnostic's B<=14 domain.
    if B > 14 or q > 12:
        raise ValueError('Packed profiler supports B<=14 and q<=12')
    key_array = np.array([sum(1 << (4*i) for i in b) + ((v[0]+1 if v else 0) << (4*q))
                          for v,b in columns], dtype=np.uint64)
    stats = dict(chart=metadata['chart'], input_sha256=metadata['matrix_sha256'],
                 scope='Exact saved-run operation counts; no new exclusion')
    with checkpoint.open('rb') as stream, mmap.mmap(stream.fileno(),0,access=mmap.ACCESS_READ) as cp:
        header = struct.unpack_from('<QIIIIQQQQdI',cp,0)
        magic,rows,cols,pure_start,processed,inputpos,dagpos,reductions,stored,seconds,rank = header
        assert magic==0x4d414341554c3031 and cols==len(columns) and pure_start==boundary
        assert processed==result['rows_processed'] and rank==result['rank_so_far']
        offsets=np.zeros(rank,dtype=np.uint64)
        lengths=np.zeros(rank,dtype=np.uint64)
        leads=np.zeros(rank,dtype=np.uint64)
        coefficient_offsets=np.zeros(rank,dtype=np.uint64)
        hashes={}; duplicate_pairs=[]; duplicate_nnz=0; strict_translation_nodes=set()
        entries_saved_by_dense=0; dense_better=0; density_sum=0.0
        position=struct.calcsize('<QIIIIQQQQdI')
        def normalized(node):
            offset=int(coefficient_offsets[node]); n=int(lengths[node])
            ci=np.frombuffer(cp,dtype='<u4',count=n,offset=offset)
            codes=key_array[ci]
            divisor=sum(int(np.min((codes >> np.uint64(4*i)) & np.uint64(15))) << (4*i)
                        for i in range(q))
            norm=codes-np.uint64(divisor)
            values=bytes(cp[offset+4*n:offset+5*n])
            return norm,values,divisor
        for node in range(rank):
            offsets[node],n=struct.unpack_from('<QI',cp,position);position+=12
            lengths[node]=n;coefficient_offsets[node]=position
            ci=np.frombuffer(cp,dtype='<u4',count=n,offset=position)
            leads[node]=ci[0]
            assert ci[-1]<cols and cp[position+4*n]==1
            width=cols-int(ci[0]);density_sum+=n/width
            if 5*n>width:
                dense_better+=1;entries_saved_by_dense+=5*n-width
            if translations:
                norm,values,divisor=normalized(node)
                digest=hashlib.blake2b(norm.tobytes()+values,digest_size=16).digest()
                previous_nodes=hashes.get(digest,[])
                if previous_nodes:
                    previous=previous_nodes[0]
                    oldnorm,oldvalues,olddivisor=normalized(previous)
                    assert np.array_equal(norm,oldnorm) and values==oldvalues, 'hash collision'
                    duplicate_pairs.append((node,previous,divisor,olddivisor))
                    duplicate_nnz+=n
                    for candidate in previous_nodes:
                        _,_,cd=normalized(candidate)
                        if all(((divisor>>(4*i))&15)>=((cd>>(4*i))&15) for i in range(q)):
                            strict_translation_nodes.add(node)
                            break
                hashes.setdefault(digest,[]).append(node)
            position+=5*n
        assert position+8==len(cp) and int(lengths.sum())==stored
        del ci
        usage=np.zeros(rank,dtype=np.uint64)
        field_factors=np.zeros(25,dtype=np.uint64)
        source_ids=[]; edge_count=0; duplicate_construction_calls=0; duplicate_construction_updates=0
        full_pivot_coefficient_reads=0
        with (folder/'provenance.bin').open('rb') as dagstream, mmap.mmap(dagstream.fileno(),0,access=mmap.ACCESS_READ) as dag:
            dtype=np.dtype([('parent','<u4'),('factor','u1')])
            for node,offset in enumerate(offsets):
                source,norm,number=struct.unpack_from('<IBI',dag,int(offset));source_ids.append(source)
                edges=np.frombuffer(dag,dtype=dtype,count=number,offset=int(offset)+9)
                assert number==0 or int(edges['parent'].max())<node
                usage+=np.bincount(edges['parent'],minlength=rank).astype(np.uint64)
                field_factors+=np.bincount(edges['factor'],minlength=25).astype(np.uint64)
                edge_count+=number
                if node in strict_translation_nodes:
                    duplicate_construction_calls+=number
                    duplicate_construction_updates+=int((lengths[edges['parent']]-1).sum())
            del edges
        # Zero rows have no provenance node: report exact totals only when
        # every processed row produced a pivot, as in the successful B4 run.
        complete_cost=rank==processed and source_ids==list(range(processed))
        if complete_cost:
            assert edge_count==reductions
        touches=int(np.dot(usage,lengths-1))
        stats.update(rows_processed=processed,rank=rank,zero_rows=processed-rank,
            reduction_calls_in_dag=edge_count,all_row_reduction_costs_recovered=complete_cost,
            coefficient_updates_in_dag=touches,
            mean_updated_coefficients_per_reduction=touches/max(edge_count,1),
            pivot_coefficients_stored=stored,normalization_multiplications=stored,
            full_work_buffer_clears_bytes=processed*cols,
            forward_column_probes=int((leads+1).sum()),
            new_pivot_column_probes=int((cols-leads).sum()),
            mean_pivot_tail_density=density_sum/rank,
            pivots_smaller_if_dense=dense_better,
            sparse_payload_bytes=5*stored,
            hybrid_payload_bytes_saved=entries_saved_by_dense,
            multiply_by_one_reduction_calls=int(field_factors[1]),
            monomial_translation_pivots=len(duplicate_pairs),
            monomial_translation_stored_coefficients=duplicate_nnz,
            monomial_translation_reduction_calls=sum(int(usage[node]) for node,*_ in duplicate_pairs),
            strict_earlier_monomial_multiple_pivots=len(strict_translation_nodes),
            strict_translation_construction_reduction_calls=duplicate_construction_calls,
            strict_translation_construction_coefficient_updates=duplicate_construction_updates,
            top_reused_pivots=[dict(node=int(i),uses=int(usage[i]),nnz=int(lengths[i]))
                              for i in np.argsort(usage)[-10:][::-1]],
            elapsed_seconds=time.monotonic()-start,
            caveats=['Translation groups are verified equal after removing a common b-monomial; this diagnoses reusable work, not deletable equations.',
                     'Dense payload estimates exclude vector/container overhead and do not predict wall time.',
                     'Raw operation counts do not substitute for a sampled CPU profile.'])
    Path(output).write_text(json.dumps(stats,indent=2)+'\n')
    print(json.dumps(stats,indent=2),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory');parser.add_argument('--output',required=True)
    parser.add_argument('--no-translations',action='store_true')
    args=parser.parse_args();profile(args.directory,args.output,not args.no_translations)
