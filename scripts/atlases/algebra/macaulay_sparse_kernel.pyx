# cython: language_level=3
"""Compiled sparse row loop; Sage field objects and exact provenance unchanged.

No coefficient-field scalar restriction, floating arithmetic, or changed
pivot rule. Every result still passes the existing independent verifier.
"""
import heapq,json,time

def eliminate(dict rows,dict low,list columns,list heap,set protected,
              object field,double seconds,double start,long long max_nonzeros,
              object report,long long pivot_limit=0,long long sample_window=0):
    cdef long long pivots=0,updates=0,nnz=0,count,j,i,r,q,rr,rowlen,bestlen,high_columns,high_nonzeros
    cdef dict row,original,pivot
    cdef set touched
    cdef object scale,factor,c,before,after,zero=field.zero()
    cdef list operations=[]
    cdef bint all_low
    cdef double lastreport=time.monotonic()
    cdef double budget_started=lastreport,chunk_started=lastreport
    cdef str status='complete'
    for row in rows.values():nnz+=len(row)
    while rows:
        if time.monotonic()-budget_started>seconds or nnz>max_nonzeros or (pivot_limit and pivots>=pivot_limit):
            status='bounded_partial';break
        while heap:
            count,j=heapq.heappop(heap)
            if count and count==len(columns[j]):break
        else:break
        i=-1;bestlen=9223372036854775807
        for rr in columns[j]:
            rowlen=len(rows[rr])
            if rowlen<bestlen or (rowlen==bestlen and rr<i):i=rr;bestlen=rowlen
        original=rows.pop(i);scale=original[j]**(-1);pivot={}
        for q,c in original.items():
            if q!=j:pivot[q]=c*scale
        pivots+=1;nnz-=len(original)
        for q in original:columns[q].remove(i)
        touched=set(original)
        for r in list(columns[j]):
            row=rows[r];factor=row.pop(j);columns[j].remove(r);nnz-=1
            operations.append((r,i,factor*scale))
            for q,c in pivot.items():
                before=row.get(q,zero);after=before-factor*c;updates+=1
                if after:
                    row[q]=after
                    if not before:columns[q].add(r);nnz+=1
                elif before:
                    del row[q];columns[q].remove(r);nnz-=1
                touched.add(q)
            if not row:del rows[r]
            else:
                all_low=True
                for q in row:
                    if q not in protected:all_low=False;break
                if all_low:
                    low[r]=rows.pop(r);nnz-=len(row)
                    for q in row:columns[q].remove(r)
        for q in touched:
            if q not in protected and columns[q]:heapq.heappush(heap,(len(columns[q]),q))
        if len(heap)>4*len(columns):
            heap=[]
            for q in range(len(columns)):
                if columns[q] and q not in protected:heap.append((len(columns[q]),q))
            heapq.heapify(heap)
        if time.monotonic()-lastreport>5 or (sample_window and pivots%sample_window==0):
            high_columns=0;high_nonzeros=0
            for q in range(len(columns)):
                if q not in protected and columns[q]:
                    high_columns+=1;high_nonzeros+=len(columns[q])
            report(dict(stage='sample_chunk_complete' if sample_window and pivots%sample_window==0 else 'cython_extract',
                chunk_seconds=time.monotonic()-chunk_started,
                pivots=pivots,updates=updates,
                nonzeros=nnz,high_rows=len(rows),high_columns=high_columns,
                high_nonzeros=high_nonzeros,low_rows=len(low),seconds=time.monotonic()-start))
            if sample_window and pivots%sample_window==0:chunk_started=time.monotonic()
            lastreport=time.monotonic()
    return status,pivots,updates,nnz,operations
