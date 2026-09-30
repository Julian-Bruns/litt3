#include <array>
#include <cstdint>
#include <iostream>
#include <cassert>
// Exhaustive necessary-condition test, NOT a search for curves.
// Every normalized multiset is (0,a,b,c,d), 0<=a<=b<=c<=d<116.
// Each integer array entry is in F5; reduce only after summing exact inputs.
#include "quadratic_table.h"
int main(){
 uint64_t total=0,zeros=0,nonzero=0,bothzero=0,onezero=0,poly1=0,poly3=0;
 std::array<unsigned,14> D2,D3,D4;
 for(int a=0;a<116;a++){
  for(int k=0;k<14;k++)D2[k]=T[0][k]+T[a][k]+Q[0][a][k];
  for(int b=a;b<116;b++){
   for(int k=0;k<14;k++)D3[k]=D2[k]+T[b][k]+Q[0][b][k]+Q[a][b][k];
   for(int c=b;c<116;c++){
    for(int k=0;k<14;k++)D4[k]=D3[k]+T[c][k]+Q[0][c][k]+Q[a][c][k]+Q[b][c][k];
    for(int d=c;d<116;d++){
     ++total;bool ok=true;
     for(int k=0;k<14;k++){
      unsigned vv=D4[k]+T[d][k]+Q[0][d][k]+Q[a][d][k]+Q[b][d][k]+Q[c][d][k];
      if(vv%5){ok=false;break;}
     }
     if(!ok)continue;
     ++zeros; bool za=true,zb=true;
     for(int k=0;k<14;k++){
      za&=(H15[0][k]+H15[a][k]+H15[b][k]+H15[c][k]+H15[d][k])%5==0;
      zb&=(H35[0][k]+H35[a][k]+H35[b][k]+H35[c][k]+H35[d][k])%5==0;
     }
     if(za&&zb) {bothzero++;std::cout<<"BOTHZERO 0 "<<a<<' '<<b<<' '<<c<<' '<<d<<'\n';}
     else if(za||zb){
      onezero++;
      unsigned h1[29]={},h3[29]={};
      const int labels[5]={0,a,b,c,d};
      constexpr unsigned w1[4]={1,2,4,3},w3[4]={1,3,4,2};
      for(auto j:labels){h1[j/4]+=w1[j%4];h3[j/4]+=w3[j%4];}
      bool p1=true,p3=true;
      for(int j=0;j<29;j++){p1&=(h1[j]%5==0);p3&=(h3[j]%5==0);}
      assert(za==p1 && zb==p3);
      poly1+=p1;poly3+=p3;
     }
     else {nonzero++;std::cout<<"NONZERO 0 "<<a<<' '<<b<<' '<<c<<' '<<d<<'\n';}
    }
   }
  }
 }
 assert(total==7940751 && zeros==461 && nonzero==0 && bothzero==1 && onezero==460);
 std::cout<<"PHASEWISE_ZERO_CHARACTERS "<<poly1<<' '<<poly3<<'\n';
 std::cout<<"SUMMARY "<<total<<' '<<zeros<<' '<<nonzero<<' '<<bothzero<<' '<<onezero<<'\n';
 std::cout<<"PASS: no nonpure endpoint can satisfy the mixed quadratic-scalar equations.\n";
}
