#!/usr/bin/env sage
"""Enumerate complete uniform tame monodromy classes of a given genus.

The signature lists the ordered inertia indices. This is a permutation
census; its use for geometric covers is justified by tame specialization.
"""
import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--signature", nargs="+", type=int, required=True)
    parser.add_argument("--genus", type=int, default=2)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    sig = args.signature
    if args.genus < 2 or len(sig) < 3 or min(sig) < 2:
        parser.error("use genus at least2 and at least three inertia indices >=2")
    defect = -2 + sum(QQ(e - 1) / e for e in sig)
    if defect <= 0:
        parser.error("the signature must have positive orbifold canonical degree")
    degree = QQ(2 * args.genus - 2) / defect
    if degree.denominator() != 1:
        parser.error("Hurwitz does not give an integral cover degree")
    n = int(degree)
    gap.eval('F:=FreeGroup(%d);;' % (len(sig) - 1))
    rels = ['F.%d^%d' % (i + 1, e) for i, e in enumerate(sig[:-1])]
    rels.append('(%s)^%d' %
                ('*'.join('F.%d' % (i + 1) for i in range(len(sig) - 1)), sig[-1]))
    gap.eval('G:=F/[%s];;' % ','.join(rels))
    gap.eval('subs:=LowIndexSubgroupsFpGroup(G,%d);;' % n)
    gap.eval("""
    uniform_census:=function(G,subs,n,sig)
    local H,rho,gs,P,out;
    out:=[];
    for H in subs do
      if Index(G,H)=n then
        rho:=ActionHomomorphism(G,RightCosets(G,H),OnRight);
        gs:=List(GeneratorsOfGroup(G),x->Image(rho,x));
        Add(gs,Product(gs)^-1);
        if ForAll([1..Length(gs)],i->
          ForAll(CycleLengths(gs[i],[1..n]),z->z=sig[i])) then
          P:=Image(rho);
          Add(out,[Size(P),Size(Centralizer(SymmetricGroup(n),P)),
                   List(gs,x->List([1..n],i->i^x))]);
        fi;
      fi;
    od;
    return out;
    end;;
    """)
    gap.eval('out:=uniform_census(G,subs,%d,%s);;' % (n, str(sig)))
    classes = [dict(monodromy_order=int(order), deck_order=int(deck),
                    generators=[[int(i) - 1 for i in g] for g in gs])
               for order, deck, gs in gap('out').sage()]
    record = dict(signature=sig, genus=args.genus, degree=n, classes=classes)
    args.output.write_text(json.dumps(record, indent=2, default=int) + '\n')
    print(f"genus={args.genus}, signature={sig}, degree={n}, classes={len(classes)}")


if __name__ == "__main__":
    main()
