"""Replay the endpoint verification from an empty extraction of an archive.

This utility uses only the Python standard library. It verifies every
manifest entry, runs the documented driver, and freezes all source,
evidence, and exact-input files. Generated caches and refreshed execution
logs are not mathematical inputs. No external coefficient data is used.
"""
import argparse, hashlib, json, pathlib, subprocess, sys, time, zipfile


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('archive', type=pathlib.Path)
    parser.add_argument('--destination', type=pathlib.Path, required=True)
    parser.add_argument('--audit', type=pathlib.Path, required=True)
    parser.add_argument('--jobs', type=int, choices=[1, 2, 3], default=3)
    args = parser.parse_args()
    archive, dest = args.archive.resolve(), args.destination.resolve()
    if dest.exists() and any(dest.iterdir()):
        parser.error('--destination must be absent or empty')
    dest.mkdir(parents=True, exist_ok=True)
    started = time.time()
    archive_hash = sha(archive)
    with zipfile.ZipFile(archive) as z:
        names = z.namelist()
        if len(set(names)) != len(names):
            raise ValueError('Duplicate archive member')
        for name in names:
            path = pathlib.PurePosixPath(name)
            if path.is_absolute() or '..' in path.parts:
                raise ValueError('Unsafe archive member: ' + name)
        if z.testzip() is not None:
            raise ValueError('ZIP checksum failed')
        z.extractall(dest)
    manifest = {}
    for line in (dest / 'SHA256SUMS').read_text().splitlines():
        digest, name = line.split('  ', 1)
        if name in manifest:
            raise ValueError('Duplicate manifest entry: ' + name)
        manifest[name] = digest
    actual = {n for n in names if not n.endswith('/') and n != 'SHA256SUMS'}
    if set(manifest) != actual:
        raise ValueError('Manifest membership does not match archive')
    for name, digest in manifest.items():
        if sha(dest / name) != digest:
            raise ValueError('Manifest mismatch: ' + name)
    proof = {name: digest for name, digest in manifest.items()
             if name == 'INPUT.md' or name.split('/')[0] in {'src', 'evidence', 'inputs'}}
    fingerprint = hashlib.sha256(''.join(f'{proof[n]}  {n}\n' for n in sorted(proof)).encode()).hexdigest()
    command = [sys.executable, 'src/verify_endpoint_continuation.py', '--jobs', str(args.jobs)]
    logfile = dest / 'logs/endpoint_clean_excerpt.log'
    with logfile.open('w') as output:
        result = subprocess.run(command, cwd=dest, stdout=output, stderr=subprocess.STDOUT)
    if result.returncode:
        raise RuntimeError('Clean replay failed; see ' + str(logfile))
    changed = [name for name, digest in proof.items() if sha(dest / name) != digest]
    if changed:
        raise ValueError('Proof/input files changed: ' + ', '.join(changed))
    ledger = json.loads((dest / 'logs/endpoint_continuation_checks.json').read_text())
    assert ledger['status'] == 'passed' and ledger['top_level_commands'] == 51
    audit = {
        'status': 'passed_from_fresh_extraction',
        'verification_input_archive': archive.name,
        'verification_input_archive_sha256': archive_hash,
        'manifest_entries_verified_before_replay': len(manifest),
        'all_source_evidence_and_exact_input_files_unchanged': True,
        'frozen_source_evidence_input_count': len(proof),
        'frozen_source_evidence_input_manifest_sha256': fingerprint,
        'command': command,
        'top_level_commands_passed': ledger['top_level_commands'],
        'versions': ledger['versions'],
        'execution_scope': ledger['scope'],
        'global_square_locus_decision': 'unresolved',
        'excerpt': 'logs/endpoint_clean_excerpt.log',
        'seconds': round(time.time() - started, 3),
        'packaging_note': 'The replay archive may precede final metadata packaging. The recorded scientific-source fingerprint is preserved; the final ZIP receives a new complete SHA-256 manifest.'
    }
    args.audit.parent.mkdir(parents=True, exist_ok=True)
    args.audit.write_text(json.dumps(audit, indent=2) + '\n')
    print(json.dumps(audit, indent=2), flush=True)


if __name__ == '__main__':
    main()
