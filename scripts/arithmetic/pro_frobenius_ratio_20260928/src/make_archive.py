"""Stream a self-contained ZIP containing exactly the SHA-256-manifest files.

Build products and caches are excluded because they are not in the manifest.
This packages evidence; it does not replace the algebraic verification.
"""
import argparse
import hashlib
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def build(output: Path) -> None:
    records = []
    manifest = ROOT / "SHA256SUMS"
    for line in manifest.read_text().splitlines():
        digest, name = line.split("  ", 1)
        path = ROOT / name
        if not path.is_file() or ROOT not in path.resolve().parents:
            raise ValueError(f"Invalid manifest path: {name}")
        records.append((name, digest))
    records.append(("SHA256SUMS", hashlib.sha256(manifest.read_bytes()).hexdigest()))
    output = output.resolve()
    if output.exists() and output.is_dir():
        raise ValueError("Output must be a file, not a directory")
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_suffix(output.suffix + ".tmp")
    try:
        with zipfile.ZipFile(temporary, "w", compression=zipfile.ZIP_DEFLATED,
                             compresslevel=9, allowZip64=True) as archive:
            for name, expected in sorted(records):
                path = ROOT / name
                digest = hashlib.sha256()
                info = zipfile.ZipInfo("frobenius_ratio/" + name, (1980, 1, 1, 0, 0, 0))
                info.compress_type = zipfile.ZIP_DEFLATED
                info.external_attr = (0o100755 if name == "verify.sh" else 0o100644) << 16
                with path.open("rb") as source, archive.open(info, "w") as dest:
                    while chunk := source.read(1024 * 1024):
                        digest.update(chunk)
                        dest.write(chunk)
                if digest.hexdigest() != expected:
                    raise ValueError(f"Manifest mismatch: {name}")
        temporary.replace(output)
    except Exception:
        temporary.unlink(missing_ok=True)
        raise
    print(f"Streamed {len(records)} files to {output}; {output.stat().st_size} bytes")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    build(parser.parse_args().output)
