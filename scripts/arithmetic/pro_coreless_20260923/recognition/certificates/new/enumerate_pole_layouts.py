#!/usr/bin/env python3
"""Exact combinatorial counts for the new d=3, n=6 reduction.

A subset of Z/29 specifies poles {rho^e}, rho a primitive 29th root.
Translation corresponds to rescaling the source coordinate. Inversion
corresponds to swapping the endpoints. These counts are NOT exclusions.
"""
import itertools
import json
import math
import pathlib


def rotation_key(subset):
    return min(tuple(sorted((x-t) % 29 for x in subset)) for t in range(29))


def dihedral_key(subset):
    return min(rotation_key(subset), rotation_key(tuple(-x % 29 for x in subset)))


def main():
    raw = list(itertools.combinations(range(29), 3))
    cyclic = sorted({rotation_key(s) for s in raw})
    dihedral = sorted({dihedral_key(s) for s in raw})
    assert len(raw) == 3654 and len(cyclic) == 126 and len(dihedral) == 70
    counts = []
    for n in range(6, 33):
        r = n-3
        fixed_rotation = 28 if r == 29 else 0
        total = math.comb(29, r)
        reflection_fixed = math.comb(14, (r-1)//2 if r % 2 else r//2)
        rot = (total+fixed_rotation)//29
        dih = (total+fixed_rotation+29*reflection_fixed)//58
        assert 29*rot == total+fixed_rotation
        assert 58*dih == total+fixed_rotation+29*reflection_fixed
        counts.append({'n': n, 'poles': r, 'rotation_classes': rot, 'dihedral_classes': dih})
    data = {
        'scope': 'Pole-layout enumeration only; no degree-six or all-degree exclusion is claimed.',
        'raw_degree6_layouts': len(raw),
        'degree6_rotation_classes': len(cyclic),
        'degree6_dihedral_classes': len(dihedral),
        'rotation_representatives': cyclic,
        'dihedral_representatives': dihedral,
        'all_d3_degree_layout_counts': counts,
    }
    destination = pathlib.Path(__file__).resolve().parents[1]/'data'/'d3_pole_layouts.json'
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(data, indent=2)+'\n')
    print('degree6_raw_pole_layouts=3654')
    print('degree6_rotation_classes=126')
    print('degree6_dihedral_classes=70')
    print('scope=pole_layout_counts_only_not_an_exclusion')


if __name__ == '__main__':
    main()
