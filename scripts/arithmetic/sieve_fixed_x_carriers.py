#!/usr/bin/env python3
"""Checkpointed actual-Jacobian carrier sieve, with separately timed setup.

Uses the independently verified1533 Frobenius/F4 label representatives.
Cached low/high byte tables convert each carrier into at most one addflip.
A stratified sample benchmarks the SAME per-carrier calculation as --all.
No passing carrier is called excluded. Every completed matrix is retained.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,gzip,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.atlases.opers.fixed_x_monomial_jacobian import FixedXMonomialJacobian,FROBENIUS_COEFFICIENTS
from scripts.arithmetic.fixed_x_prym_cartier import prym_matrix,semilinear_norm,backup_factor_sieve


def save_json(path,value):
    path=Path(path)
    tmp=path.with_suffix(path.suffix+'.tmp')
    payload=(json.dumps(value,separators=(',',':'))+'\n').encode()
    tmp.write_bytes(gzip.compress(payload) if path.suffix=='.gz' else payload)
    tmp.replace(path)


def load_json(path):
    data=Path(path).read_bytes()
    return json.loads(gzip.decompress(data) if str(path).endswith('.gz') else data)


class CarrierSieve:
    def __init__(self,torsion,cache,report):
        self.started=time.monotonic();self.report=report;self.cache=Path(cache)
        self.cache.mkdir(exist_ok=True,parents=True)
        self.data=load_json(torsion);data=self.data
        assert data['field_degree']==342 and data['nonzero'] and data['doubling_zero']
        source_hash=hashlib.sha256(Path(torsion).read_bytes()).hexdigest()
        stamp=self.cache/'input_sha256.txt'
        if stamp.exists():assert stamp.read_text().strip()==source_hash
        else:stamp.write_text(source_hash+'\n')
        self.k=GF(5**342,'b',modulus=PolynomialRing(GF(5),'z')(data['modulus']),impl='pari_ffelt')
        self.J=FixedXMonomialJacobian(self.k,self.k(data['a']))
        self.w=self.decode(data['point']);self.basis=[self.w]
        for j in range(1,18):self.basis.append(self.J.frobenius(self.basis[-1]))
        self.tables={};self.table_seconds=0.;self.table_flips=0
        report('field_model_and_frobenius_basis_ready',seconds=time.monotonic()-self.started)

    def decode(self,data):
        return matrix(self.k,data['rows'],data['columns'],[self.k(c) for c in data['coefficients']])

    def table(self,part,mask):
        if not mask:return self.J.zero
        key=(part,mask)
        if key in self.tables:return self.tables[key]
        path=self.cache/('table%d_%03d.json.gz'%(part,mask))
        if path.exists():value=self.decode(load_json(path))
        elif mask.bit_count()==1:value=self.basis[part*8+mask.bit_length()-1]
        else:
            top=1<<(mask.bit_length()-1)
            left=self.table(part,mask^top);right=self.table(part,top)
            start=time.monotonic();value=self.J.km.addflip(left,right)
            self.table_seconds+=time.monotonic()-start;self.table_flips+=1
        if not path.exists():save_json(path,self.J.serialize(value))
        self.tables[key]=value
        if self.table_flips and self.table_flips%20==0:
            self.report('setup_table_progress',table_flips=self.table_flips,
                        table_seconds=self.table_seconds,cached_entries=len(self.tables))
        return value

    def prepare(self,seeds):
        for part in (0,1):
            masks=sorted({(s>>(8*part))&255 for s in seeds})
            for mask in masks:self.table(part,mask)

    def carrier(self,seed,out):
        out=Path(out);out.mkdir(exist_ok=True)
        if (out/'result.json').exists():return load_json(out/'result.json')
        started=time.monotonic();lo=seed&255;hi=seed>>8
        low=self.table(0,lo);high=self.table(1,hi)
        # Any needed setup occurred in prepare(), outside this interval.
        started=time.monotonic()
        w=self.J.km.addflip(low,high) if lo and hi else (low if lo else high)
        group_seconds=time.monotonic()-started
        save_json(out/'torsion_matrix.json.gz',self.J.serialize(w))
        arithmetic=time.monotonic()
        M,g,h=prym_matrix(self.J,w)
        N=semilinear_norm(M,342);poly=N.charpoly('T')
        assert all(c**5==c for c in poly)
        coefficients=[int(c.polynomial()[0]) for c in poly]
        cartier_seconds=time.monotonic()-arithmetic
        encode_poly=lambda f:[list(map(int,c.polynomial().list())) for c in f.list()]
        save_json(out/'cartier_witness.json.gz',dict(matrix=self.J.serialize(M),
            anti_basis=self.J.serialize(h),trivialization=[encode_poly(f) for f in g],
            linear_norm=self.J.serialize(N)))
        result=dict(seed=seed,coefficients=coefficients,cartier_rank=int(M.rank()),
            group_seconds=group_seconds,cartier_seconds=cartier_seconds,
            per_carrier_seconds=time.monotonic()-started,
            sieve=backup_factor_sieve(coefficients),
            scope='Actual geometric Prym factor sieve for this carrier only')
        save_json(out/'result.json',result)
        return result


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('torsion',type=Path);p.add_argument('labels',type=Path)
    p.add_argument('cache',type=Path);p.add_argument('out',type=Path)
    p.add_argument('--sample',type=int,default=15);p.add_argument('--all',action='store_true')
    p.add_argument('--seconds',type=int,default=1800);p.add_argument('--prepare-only',action='store_true')
    p.add_argument('--index-from',type=int,default=0);p.add_argument('--index-to',type=int)
    args=p.parse_args();args.out.mkdir(exist_ok=True);start=time.monotonic();events=[]
    def report(stage,**kw):
        event=dict(stage=stage,wall_seconds=time.monotonic()-start,**kw);events.append(event)
        print(json.dumps(event),flush=True);save_json(args.out/'progress.json',events)
    labels=load_json(args.labels);all_seeds=labels['seeds']
    assert len(all_seeds)==1533 and labels['independent_partition_replay']=='PASS'
    expected=[i for i,c in enumerate(FROBENIUS_COEFFICIENTS) if c%2]
    assert expected==labels['mod2_exponents']
    if args.all:indices=list(range(len(all_seeds)))
    else:indices=sorted({i*len(all_seeds)//args.sample for i in range(args.sample)})
    indices=indices[args.index_from:args.index_to]
    seeds=[all_seeds[i] for i in indices]
    save_json(args.out/'selection.json',dict(indices=indices,seeds=seeds,total=1533,
        labels_source=str(args.labels.resolve()),labels_sha256=hashlib.sha256(args.labels.read_bytes()).hexdigest(),
        torsion_source=str(args.torsion.resolve()),mode='all' if args.all else 'stratified_sample'))
    alarm(args.seconds)
    try:
        engine=CarrierSieve(args.torsion,args.cache,report)
        setup=time.monotonic();engine.prepare(seeds)
        setup_seconds=time.monotonic()-setup
        report('setup_tables_complete',setup_seconds=setup_seconds,table_flips=engine.table_flips,
               table_arithmetic_seconds=engine.table_seconds)
        if args.prepare_only:return
        results=[];solve_started=time.monotonic()
        for i,seed in zip(indices,seeds):
            result=engine.carrier(seed,args.out/('carrier_%04d'%i));results.append(result)
            report('carrier_completed',index=i,seed=seed,processed=len(results),
                per_carrier_seconds=result['per_carrier_seconds'],
                excluded=result['sieve']['geometric_backup_factor_excluded'],
                coefficients=result['coefficients'])
        times=[r['per_carrier_seconds'] for r in results]
        summary=dict(status='complete',selected=len(results),total_carrier_orbits=1533,
            excluded=sum(r['sieve']['geometric_backup_factor_excluded'] for r in results),
            passing_indices=[i for i,r in zip(indices,results) if not r['sieve']['geometric_backup_factor_excluded']],
            table_setup_seconds=setup_seconds,table_arithmetic_seconds=engine.table_seconds,
            per_carrier_mean_seconds=sum(times)/len(times),
            per_carrier_min_seconds=min(times),per_carrier_max_seconds=max(times),
            scaled_full_sequential_carrier_seconds=1533*sum(times)/len(times),
            scope='Measured setup excluded from scaling. Passing carriers and untested labels remain open.')
        save_json(args.out/'summary.json',summary);report('sample_or_batch_complete',summary=summary)
    except AlarmInterrupt:report('time_limit_completed_carriers_retained')
    finally:cancel_alarm()


if __name__=='__main__':main()
