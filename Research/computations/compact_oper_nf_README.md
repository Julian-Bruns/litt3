# Direct compact normal forms — 2026-09-07

`scripts/compact_oper_nf.c` imports the compact negative-tail matrix directly
into the retained patched neogb internal sparse basis. It inserts each
distinct input monomial once, stores hash IDs in the polynomial rows, and
converts compact rewrite coefficients c to polynomial coefficients -c mod5.
Rows are sorted in decreasing DRL by reversing the ascending standard list.
The importer regenerates divisibility masks and supplies every leading term.
It calls `core_nf` with exact LA option2 and NO_TRACER. No Groebner basis
computation is performed. This is an adapter using upstream implementation
internals, not a standalone replacement for neogb.

Build from the repository root:

```sh
/opt/homebrew/opt/llvm/bin/clang -O3 -fopenmp \
  -I/var/tmp/sage-10.9-current/local/include \
  -I/opt/homebrew/opt/libomp/include \
  -DNEOGB_SOURCE='"/tmp/litt3-msolve-lowmem.bQGL6w/msolve-0.10.1/src/neogb/gb.c"' \
  scripts/compact_oper_nf.c \
  -L/var/tmp/sage-10.9-current/local/lib \
  -Wl,-rpath,/var/tmp/sage-10.9-current/local/lib \
  -L/opt/homebrew/opt/libomp/lib -lgmp -lm -o /tmp/litt3-compact-nf
sage scripts/check_compact_oper_nf.sage
/tmp/litt3-compact-nf Research/computations/normalized_oper_rewrite 13 \
  Research/computations/normalized_oper_a9_nf 64 8
```

The Sage fixture passed13 exact missing-product comparisons using an actual
15-variable Groebner basis with12 standard monomials, including the field
equation z²+4z+2 and batches of three. This tests input coefficient signs,
term order, nontrivial reductions, batch row order, and output decoding.
It is a small implementation regression test, not a certificate for the
large supplied basis. The full run additionally rejects every output term
not in its supplied standard list.

Each completed batch has two files:

- `normalized_oper_a9_nf.NNNNNN.keys.u64`: target monomial keys, native
  little-endian uint64,15 nibbles with variable0 in the low nibble.
- `normalized_oper_a9_nf.NNNNNN.u8`: one dense coefficient row per key,
 19290 bytes per row, columns in `normalized_oper_rewrite.standard.u64`
 order. Coefficients are ordinary normal-form coefficients modulo5.

NNNNNN is the zero-based start among missing products, in the supplied
standard list's order. The batch size is64; the final batch is shorter.
Data is flushed and fsynced to `.partial` files then renamed, with the keys
written before the row file. A completed row file is skipped on rerun with
the same inputs and batch size. Partial files require inspection before a
restart; the adapter deliberately does not overwrite them.

The source directly includes patched neogb `gb.c` and its included source
files. Keep that build tree. Its bitmap patches are separately recorded in
`msolve_lowmem/README.md`. At build time SHA256 values were:

```
gb.c     391e1aea8d5f7375fd38fffe4197b8270cf2cb035c0256ffe82a2491c9dcaa19
nf.c     1c5f3b6db22f826d31846ecad88e0dfe6b51de0b2d56e2cb820da2eae0e9c962
la_ff_8.c 4837687e027be0020ee19bdbdc6a1ff9f4566310f00331e4ce2af3c34f5ad9fd
symbol.c 5fe1daf07212443a19d69276c9fb6d4900c786e46256cd1269b23abca518c349
adapter  94dca4c9179c146fb61909a1bf9f04fdb0aecb2aa31d35d4557e001b3fb11302
binary   f222392008d0e7503709322e0ac365b396ba90aea190d18fa7d13cb22af9be0e
```

Early full-run observations:640/2403 rows completed in approximately ten
seconds, observed RSS about2.06GB. At896 rows observed RSS about2.20GB.
These are process samples, not measured maximum memory. Timings and all
batch completions are recorded in `normalized_oper_a9_nf.log`.

The full run completed with exit0 and all2403 rows in38 checkpoints.
Independent binary validation checked every target key against the missing
a9 products, all row dimensions, and every coefficient in0..4. The row
files contain46,353,870 coefficient bytes in total. The largest final
symbolic matrix reported413568 by432823 for the last35 targets; its actual
peak memory was not measured. The largest observed earlier RSS sample was
about4.67GB. None of these reductions alone certifies the supplied large
Groebner basis or the original equations.
