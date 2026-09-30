// Complete radius-three Lee-ball collision test for lambda*xi^(17j)-xi^(4j).
// A nonzero kernel word of Lee weight<=6 is a difference of two ball words.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include <unordered_map>
#include "sextic_paired_data.hpp"
using Word=std::array<uint8_t,29>;
using Vec=std::array<int,7>;
int lee(int c){return c<=2?c:5-c;}
int main(){
 for(int scalar=1;scalar<25;++scalar){
  std::array<Vec,29> columns;
  for(int j=0;j<29;++j)for(int i=0;i<7;++i)columns[j][i]=add25[mul25[scalar][phase[17*j%29][i]]][neg25[phase[4*j%29][i]]];
  std::unordered_map<uint64_t,Word> seen;seen.reserve(40000);uint64_t total=0,collisions=0,bad=0;
  auto inspect=[&](const Word&w){
   ++total;Vec v{};for(int j=0;j<29;++j)if(w[j])for(int i=0;i<7;++i)v[i]=add25[v[i]][mul25[w[j]][columns[j][i]]];
   uint64_t key=0,power=1;for(int c:v){key+=power*c;power*=25;}
   auto it=seen.find(key);if(it==seen.end()){seen.emplace(key,w);return;}
   ++collisions;bool different=false;
   for(int j=scalar==1?1:0;j<29;++j)if(w[j]!=it->second[j])different=true;
   if(different){++bad;if(bad<=8){std::cout<<"BAD scalar "<<scalar<<" word";for(int j=0;j<29;++j){int d=(int(w[j])+5-int(it->second[j]))%5;if(d)std::cout<<' '<<j<<':'<<d;}std::cout<<'\n';}}
  };
  Word w{};inspect(w);
  for(int i=0;i<29;++i)for(int a=1;a<5;++a){w[i]=a;inspect(w);w[i]=0;}
  for(int i=0;i<29;++i)for(int j=i+1;j<29;++j)for(int a=1;a<5;++a)for(int b=1;b<5;++b)if(lee(a)+lee(b)<=3){w[i]=a;w[j]=b;inspect(w);w[i]=w[j]=0;}
  for(int i=0;i<29;++i)for(int j=i+1;j<29;++j)for(int k=j+1;k<29;++k)for(int a:{1,4})for(int b:{1,4})for(int c:{1,4}){w[i]=a;w[j]=b;w[k]=c;inspect(w);w[i]=w[j]=w[k]=0;}
  assert(total==34221);std::cout<<"SCALAR "<<scalar<<" BALL "<<total<<" DISTINCT "<<seen.size()<<" COLLISIONS "<<collisions<<" BAD "<<bad<<std::endl;
 }
}
