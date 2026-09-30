#include <array>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <cstdint>
int A[25][25],M[25][25],N[25];
int mul(int a,int b){
 std::array<int,4> aa{},bb{}; std::array<int,7> c{};
 for(int i=0;i<4;i++){aa[i]=a%25;bb[i]=b%25;a/=25;b/=25;}
 for(int i=0;i<4;i++)for(int j=0;j<4;j++)c[i+j]=A[c[i+j]][M[aa[i]][bb[j]]];
 int mod[4]={5,2,6,7};
 for(int i=6;i>=4;i--)for(int j=0;j<4;j++)c[i-4+j]=A[c[i-4+j]][N[M[c[i]][mod[j]]]];
 int r=0;for(int i=3;i>=0;i--)r=25*r+c[i];return r;
}
int main(int argc,char** argv){
 if(argc!=2)return 2;
 for(int a=0;a<25;a++){
  N[a]=(5-a%5)%5+5*((5-a/5)%5);
  for(int b=0;b<25;b++){
   A[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
   M[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
  }
 }
 int g=std::atoi(argv[1]),z=1;std::vector<int32_t> out(390624);
 for(auto &v:out){v=z;z=mul(z,g);}
 if(z!=1)return 3;
 std::cout.write(reinterpret_cast<const char*>(out.data()),out.size()*sizeof(int32_t));
 return 0;
}
