#!/usr/bin/env python3
"""Read-only comparison of fresh full W4 replays and immutable producer files.

This does not generate the Hodge cocycle. The named run directories must
come from complete executions of compute_neutral5_w4.py. It checks their
outputs and records precisely that evidence boundary.
"""
import argparse
import hashlib
import json
from pathlib import Path


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("certificate_root", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    cert = args.certificate_root.resolve()
    files = {}
    for line in (cert / "SHA256SUMS").read_text().splitlines():
        digest, name = line.split(maxsplit=1)
        path = (cert / name).resolve()
        assert path.is_relative_to(cert)
        assert sha(path) == digest, name
        files[name] = digest
    labels = {
        "baseline": "local_replay_20260911",
        "changed_affine_frobenius": "local_replay_frobenius1_20260911",
        "kernel_displacement_t": "local_replay_kernel_20260911",
        "coefficient_conjugate": "local_replay_conjugate_20260911",
    }
    results, receipts = {}, {}
    for label, directory in labels.items():
        root = cert / "runs" / directory
        names = ["genus6_first_stage.json", "genus6_second_stage.json",
                 "genus6_local_comparison.json", "genus6_fourth_result.json",
                 "genus6_decomposition.json"]
        data = {name: json.loads((root / name).read_text()) for name in names}
        result = data["genus6_fourth_result.json"]
        assert result["status"] == (
            "PASS complete normal comparison, geometric structure checks, "
            "direct residue, and decomposition")
        assert result["first_lift_frobenius_rank"] == 15
        assert result["rho4_precision"] > 9
        expect = [0, 3, 2, 1] if label == "coefficient_conjugate" else [1, 0, 0, 3]
        assert result["c4"] == expect
        components = data["genus6_decomposition.json"]["components"]
        keys = ["divided_linear_carry", "quadratic_first_repairs", "weighted_jet",
                "cubic_Taylor_derivative", "preceding_oper_potential"]
        assert [sum(components[key]["scalar"][i] for key in keys) % 5
                for i in range(4)] == expect
        assert data["genus6_first_stage.json"]["first_lift_frobenius_rank"] == 15
        results[label] = result
        receipts[label] = dict(directory=str(root), scalar=expect,
                               certified_normal_precision=result["rho4_precision"],
                               output_hashes={name: sha(root / name) for name in names})
    assert results["baseline"]["rho4_vector"] == results["changed_affine_frobenius"]["rho4_vector"]
    assert results["baseline"]["rho4_vector"] != results["kernel_displacement_t"]["rho4_vector"]
    # Independent coefficient arithmetic was performed by the bounded auditor;
    # here only compare the fresh producer result to its separately saved scalar.
    workspace = Path(__file__).resolve().parents[3]
    local_audit = workspace / "Research/computations/returned_neutral5_w4_local_audit.json"
    output = dict(status="PASS four fresh complete replays and output comparison",
                  certificate_root=str(cert), original_manifest_files=len(files),
                  original_manifest_sha256=sha(cert / "SHA256SUMS"),
                  producer_sha256=files["compute_neutral5_w4.py"], runs=receipts,
                  independent_local_audit=str(local_audit),
                  independent_local_audit_sha256=sha(local_audit),
                  scope="Exact selected R=u(u-1) cover; global conclusion uses the separately audited parameter-independence theorem. No unmarked common-cover conclusion.")
    args.output.write_text(json.dumps(output, indent=2) + "\n")
    print(json.dumps(output, indent=2))


if __name__ == "__main__":
    main()
