// Exhaustive normalized four-label scan. Exact arithmetic only.
// g++ -std=c++17 -O3 -Wall -Wextra -pedantic src/endpoint_scan.cpp -o endpoint_scan
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>
using E = std::array<unsigned char,7>;
unsigned char add25[25][25],mul25[25][25],neg25[25];
constexpr int mod[7]={4,22,7,20,21,7,24};
E add(const E&a,const E&b){E r{}; for(int i=0;i<7;++i)r[i]=add25[a[i]][b[i]];return r;}
E scale(const E&a,int b){E r{};for(int i=0;i<7;++i)r[i]=mul25[a[i]][b];return r;}
E mul(const E&a,const E&b){
  unsigned char t[13]={};
  for(int i=0;i<7;++i) for(int j=0;j<7;++j)
    t[i+j]=add25[t[i+j]][mul25[a[i]][b[j]]];
  for(int i=12;i>=7;--i)for(int j=0;j<7;++j)
    t[i-7+j]=add25[t[i-7+j]][mul25[neg25[t[i]]][mod[j]]];
  E r{};for(int i=0;i<7;++i)r[i]=t[i];return r;
}
bool zero(const E&a){for(auto x:a)if(x)return false;return true;}
void show(const E&a){std::cout<<"[";for(int i=0;i<7;++i)std::cout<<(i?",":"")<<int(a[i]);std::cout<<"]";}
struct Entry{E p5,r5,p17,r17;};
Entry add(const Entry&a,const Entry&b){return {add(a.p5,b.p5),add(a.r5,b.r5),add(a.p17,b.p17),add(a.r17,b.r17)};}
int main(int argc,char**argv){
  std::string output=argc>1?argv[1]:"endpoint_survivors.tsv";
  for(int a=0;a<25;++a){
    neg25[a]=((5-a%5)%5)+5*((5-a/5)%5);
    for(int b=0;b<25;++b){
      add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
      mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+
        5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
    }
  }
  E one{};one[0]=1;E z{};z[1]=1;
  E powers[30];powers[0]=one;for(int j=1;j<=29;++j)powers[j]=mul(powers[j-1],z);
  assert(powers[29]==one);for(int j=1;j<29;++j)assert(powers[j]!=one);
  Entry labels[116];int tw[4]={1,2,4,3},th[4]={1,3,4,2};
  // Label code 29*i+j. A chosen label has been moved to code 0.
  for(int i=0;i<4;++i)for(int j=0;j<29;++j){
    labels[29*i+j]={scale(powers[5*j%29],tw[i]),scale(powers[5*j%29],th[i]),
                   scale(powers[17*j%29],tw[i]),scale(powers[17*j%29],th[i])};
  }
  uint64_t total=0, dzero=0,bothzero=0,pzero=0,rzero=0,nondegenerate=0;
  std::ofstream out(output);out<<"a\tb\tc\td\n";
  if(!out){std::cerr<<"Cannot open survivor output\n";return 1;}
  std::ofstream stream;
  if(argc>2){stream.open(argv[2],std::ios::binary);if(!stream){std::cerr<<"Cannot open remainder stream\n";return 1;}}
  for(int a=0;a<116;++a){
    Entry base=add(labels[0],labels[a]);
    for(int b=a;b<116;++b){
      Entry base2=add(base,labels[b]);
      for(int c=b;c<116;++c){
        Entry e=add(base2,labels[c]);++total;
        // Sparse short-relation input implies simultaneous vanishing for each character.
        assert(zero(e.p5)==zero(e.p17));assert(zero(e.r5)==zero(e.r17));
        bool pz=zero(e.p5),rz=zero(e.r5);
        E left=scale(mul(e.r5,e.p17),5);
        E right=scale(mul(e.p5,e.r17),17);
        if(stream.is_open()){
          E remainder=add(left,scale(right,4));
          stream.write(reinterpret_cast<const char*>(remainder.data()),7);
        }
        if(left!=right)continue;
        ++dzero;
        if(pz&&rz){++bothzero;continue;}
        if(pz){++pzero;continue;}
        if(rz){++rzero;continue;}
        ++nondegenerate;
        out<<0<<'\t'<<a<<'\t'<<b<<'\t'<<c<<'\n';
      }
    }
  }
  std::cout<<"total="<<total<<" determinant_zero="<<dzero
           <<" both_characters_zero="<<bothzero<<" only_p_zero="<<pzero
           <<" only_r_zero="<<rzero<<" nondegenerate="<<nondegenerate<<'\n';
  assert(total==266916 && dzero==62 && bothzero==58 && pzero==2 && rzero==2 && nondegenerate==0);
  return 0;
}
