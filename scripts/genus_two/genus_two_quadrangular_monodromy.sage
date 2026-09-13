#!/usr/bin/env sage
"""Bounded diagnostic: torsion-free genus-two orbifold subgroups.

This is an abstract permutation census, NOT a characteristic-five covering
classification or a common-cover exclusion. Positive-characteristic use
requires a separate lifting/specialization argument.
"""
import argparse
import json
import time
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--profile", choices=("2233", "2223", "344"), required=True)
parser.add_argument("--output", type=Path)
args = parser.parse_args()
sig = [int(c) for c in args.profile]
n = 6 if args.profile == "2233" else 12
started = time.monotonic()
gap.eval('F:=FreeGroup(%d);;' % (len(sig)-1))
rels = ['F.%d^%d' % (i+1,e) for i,e in enumerate(sig[:-1])]
rels.append('(%s)^%d' % ('*'.join('F.%d' % (i+1) for i in range(len(sig)-1)),sig[-1]))
gap.eval('G:=F/[%s];;' % ','.join(rels))
gap.eval('subs:=LowIndexSubgroupsFpGroup(G,%d);;' % n)
gap.eval('''
qmon:=function(G,subs,n,sig)
local H,rho,gs,P,H0,irr,hchar,inertiachars,mult,fixed,contrib,out;
out:=[];
for H in subs do
  if Index(G,H)=%d then
    rho:=ActionHomomorphism(G,RightCosets(G,H),OnRight);;
    gs:=List(GeneratorsOfGroup(G),x->Image(rho,x));;
    Add(gs,Product(gs)^-1);;
    if ForAll([1..Length(gs)],i->
      ForAll(CycleLengths(gs[i],[1..%d]),z->z=sig[i])) then
      P:=Image(rho);; H0:=Stabilizer(P,1);;
      irr:=Irr(P);;
      hchar:=PermutationCharacter(P,H0);;
      inertiachars:=List(gs,x->PermutationCharacter(P,Subgroup(P,[x])));;
      mult:=List(irr,chi->2*ScalarProduct(chi,TrivialCharacter(P))
                 +(Length(gs)-2)*chi[1]-Sum(inertiachars,z->ScalarProduct(chi,z)));;
      fixed:=List(irr,chi->ScalarProduct(chi,hchar));;
      contrib:=List([1..Length(irr)],i->mult[i]*fixed[i]);;
      Assert(0,Sum(contrib)=4);;
      Add(out,[Size(P),TransitiveIdentification(P),Size(Centralizer(SymmetricGroup(%d),P)),
               List(gs,x->List([1..%d],i->i^x)),
               List([1..Length(irr)],i->[irr[i][1],mult[i],fixed[i]]),
               List(Filtered([1..Length(irr)],i->contrib[i]>0),
                    i->[i,contrib[i],DegreeOverPrimeField(Field(irr[i]))])]);;
    fi;
  fi;
od;
return out;
end;;
''' % (n,n,n,n))
gap.eval('out:=qmon(G,subs,%d,%s);;' % (n,str(sig)))
rows = gap('out').sage()
expected = {"2233":9,"2223":39,"344":10}.get(args.profile)
if expected is not None:
    assert len(rows) == expected, (len(rows), expected)
if args.profile == "344":
    from collections import Counter
    assert Counter((int(row[0]), int(row[2])) for row in rows) == {
        (12,12):1, (24,2):1, (36,6):1, (96,2):1,
        (576,2):3, (1320,1):1, (15552,1):2}
    for row in rows:
        if row[0] == 576:
            positive = row[5]
            # Each positive record is [one-based character index,
            # H1(C) contribution, degree of character-value field].
            assert len(positive) == 2
            assert all(rank == 2 and field_degree == 1
                       for _, rank, field_degree in positive)
            assert sorted(row[4][int(i)-1] for i, _, _ in positive) == [
                [4,2,1], [6,2,1]]
record = dict(profile=sig, degree=n, count=len(rows),
              wall_seconds=time.monotonic()-started, rows=rows,
              status="abstract_monodromy_only_not_a_geometric_exclusion")
text = json.dumps(record, indent=2, default=int)
if args.output:
    args.output.write_text(text + '\n')
print(text, flush=True)
