# Bounded complete primitive catalog orders needed for the c=0 d=12..19 bridges.
# Reproduce with: gap -q scripts/oct03_primitive_even_degrees_24_38.g
LoadPackage("primgrp");;
Print("GAP version: ",GAPInfo.Version,"\n");
Print("PrimGrp version: ",PackageInfo("primgrp")[1].Version,"\n");
for degreeBridge in [24,26..38] do
    countBridge := NrPrimitiveGroups(degreeBridge);;
    Print("Degree ",degreeBridge," count ",countBridge,"\n");
    qualifyingBridge := [];;
    for indexBridge in [1..countBridge] do
        groupBridge := PrimitiveGroup(degreeBridge,indexBridge);;
        orderBridge := Size(groupBridge);;
        Print("  ",indexBridge," ",orderBridge," ",
              StructureDescription(groupBridge)," SimsNo=",SimsNo(groupBridge),"\n");
        if orderBridge mod Factorial(10) = 0 then
            Add(qualifyingBridge,indexBridge);
            if not orderBridge in [Factorial(degreeBridge)/2,Factorial(degreeBridge)] then
                Error("A non-A/S primitive order is divisible by 10!");
            fi;
        fi;
    od;
    if Length(qualifyingBridge) <> 2 then
        Error("Expected exactly two orders divisible by 10!");
    fi;
    Print("PASS degree ",degreeBridge,": only A/S orders divisible by 10!\n");
od;
QUIT;
