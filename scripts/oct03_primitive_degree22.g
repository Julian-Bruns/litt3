# Exact bounded catalog check for the nonsplit index-one d=11 bridge.
# Reproduce with: gap -q scripts/oct03_primitive_degree22.g
LoadPackage("primgrp");;
Print("GAP version: ", GAPInfo.Version, "\n");
Print("PrimGrp version: ", PackageInfo("primgrp")[1].Version, "\n");
Print("Primitive degree: 22\n");
n22 := NrPrimitiveGroups(22);;
if n22 <> 4 then Error("Unexpected degree-22 catalog size"); fi;
Print("Catalog count: ", n22, "\n");
expected22 := [443520,887040,Factorial(22)/2,Factorial(22)];;
for i22 in [1..n22] do
    grp22 := PrimitiveGroup(22,i22);;
    if Size(grp22) <> expected22[i22] then
        Error("Unexpected degree-22 group order");
    fi;
    Print(i22," ",Size(grp22)," ",StructureDescription(grp22),
          " SimsNo=",SimsNo(grp22),"\n");
od;
Print("10! = ",Factorial(10),"\n");
if expected22[2] >= Factorial(10) then Error("Small-group test failed"); fi;
Print("PASS: only A22/S22 can contain a subgroup surjecting onto S10.\n");
QUIT;
