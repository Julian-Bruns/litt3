"""Package and statically check the single rank25 fourth-lift request."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import zipfile


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument("cyclic_certificate",type=Path)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[3]
    names={
        "PROMPT.md":"Research/requests/rank25_fourth_lift_request.md",
        "inputs/rank25_fourth.json":"Research/computations/rank25_small_field_fourth_inputs.json",
        "inputs/rank25_fourth_p300.json":"Research/computations/rank25_small_field_fourth_inputs_p300.json",
        "inputs/prompt_checks.json":"Research/computations/rank25_fourth_prompt_checks.json",
        "scripts/deformations/rank25/prepare_rank25_fourth_prompt.py":"scripts/deformations/rank25/prepare_rank25_fourth_prompt.py",
        "scripts/deformations/rank25/check_rank25_prompt_inputs.py":"scripts/deformations/rank25/check_rank25_prompt_inputs.py",
        "scripts/deformations/cyclic/cyclic5_witt_obstruction.sage":"scripts/deformations/cyclic/cyclic5_witt_obstruction.sage",
    }
    files={name:(root/path).read_bytes() for name,path in names.items()}
    original=json.loads((args.cyclic_certificate/"MANIFEST.json").read_text())
    entries=original["files"]
    for name,entry in entries.items():
        source=(args.cyclic_certificate/name).read_bytes()
        assert hashlib.sha256(source).hexdigest()==entry["sha256"]
        files["reference/cyclic5/"+name]=source
    files["reference/cyclic5/MANIFEST.json"]=(args.cyclic_certificate/"MANIFEST.json").read_bytes()
    data=[json.loads(files[n]) for n in ["inputs/rank25_fourth.json","inputs/rank25_fourth_p300.json"]]
    a,b=data; volatile={"seconds","precision"}
    assert {k:v for k,v in a.items() if k not in volatile}=={k:v for k,v in b.items() if k not in volatile}
    assert a["source_sha256"]==hashlib.sha256(files["scripts/deformations/rank25/prepare_rank25_fourth_prompt.py"]).hexdigest()
    assert a["helper_sha256"]==hashlib.sha256(files["scripts/deformations/cyclic/cyclic5_witt_obstruction.sage"]).hexdigest()
    assert a["cyclic_input_sha256"]==hashlib.sha256(files["reference/cyclic5/inputs/cyclic5_small_field_fourth_inputs.json"]).hexdigest()
    assert a["kernel_basis_total_AS_degrees"]==[0,1,1,2,2,3,3,4,4]
    assert len(a["hodge_matrix"])==75 and all(len(row)==75 for row in a["hodge_matrix"])
    assert len(a["kernel_basis"])==len(a["obstruction_dual_rows"])==9
    prompt=files["PROMPT.md"].decode()
    for opening,closing in [(r"\[",r"\]"),(r"\(",r"\)")]:
        assert prompt.count(opening)==prompt.count(closing)
    assert prompt.count("```")%2==0
    assert re.findall(r"\\begin\{([^}]+)\}",prompt)==re.findall(r"\\end\{([^}]+)\}",prompt)
    assert "\ufffd" not in prompt and "sandbox:" not in prompt and "/Users/" not in prompt
    for unwanted in ["instructions to the user","when you submit","attach this file","copy below"]:
        assert unwanted not in prompt.lower()
    for key in ["primary_repair","kernel_basis","obstruction_dual_rows","regular_tails"]:
        assert key in prompt and key in a
    checks=json.loads(files["inputs/prompt_checks.json"])
    assert checks["cokernel_pullback_rank"]==1
    assert checks["embedded_cyclic_plane_origin"]==[[0,0,0,0]]*9
    assert checks["at_least_one_trace_visible_kernel_square"]
    manifest={"format_version":1,"scope":"One new rank25 W4-locus question. Rank25 primary data are verified; rank25 fourth-locus value is uncomputed. Included cyclic W4 theorem is an established reference.",
              "files":{name:{"sha256":hashlib.sha256(data).hexdigest(),"bytes":len(data)} for name,data in files.items()}}
    target=root/"Research/pro_inputs/rank25_fourth_lift_inputs.zip"
    with zipfile.ZipFile(target,"w",compression=zipfile.ZIP_DEFLATED) as z:
        for name,data in files.items():z.writestr(name,data)
        z.writestr("MANIFEST.json",json.dumps(manifest,indent=2)+"\n")
    with zipfile.ZipFile(target) as z:
        assert z.testzip() is None
        assert all(z.read(name)==data for name,data in files.items())
    receipt={"status":"PASS archive provenance, exact input agreement, prompt schema/delimiters, and model-only text",
             "path":str(target),"files":len(files)+1,"bytes":target.stat().st_size,
             "sha256":hashlib.sha256(target.read_bytes()).hexdigest(),
             "prompt_words":len(prompt.split()),"prompt_sha256":hashlib.sha256(files["PROMPT.md"]).hexdigest()}
    (root/"Research/computations/rank25_fourth_prompt_packet.json").write_text(json.dumps(receipt,indent=2)+"\n")
    print(json.dumps(receipt,indent=2))


if __name__=="__main__":main()
