// Independent relative-F25 reconstruction of the length-seven phase-sum lemma.
#include <array>
#include <vector>
#include <algorithm>
#include <cstdint>
#include <iostream>
#include <cassert>
#include "sextic_paired_data.hpp"
using Vec=std::array<uint8_t,7>;
using Wide=unsigned __int128;
struct Row{uint64_t sum;Wide counts;};
std::vector<Row> rows;
std::array<int,29> counts{};
void visit(int remaining,int first,Vec v){
 if(!remaining){
  uint64_t key=0;for(int i=6;i>=0;--i)key=25*key+v[i];
  Wide code=0;for(int i=28;i>=0;--i)code=5*code+counts[i]%5;
  rows.push_back({key,code});return;
 }
 for(int j=first;j<29;++j){
  Vec next;for(int k=0;k<7;++k)next[k]=add25[v[k]][phase[j][k]];
  ++counts[j];visit(remaining-1,j,next);--counts[j];
 }
}
int main(){
 rows.reserve(6724520);visit(7,0,Vec{});assert(rows.size()==6724520);
 std::sort(rows.begin(),rows.end(),[](const Row&a,const Row&b){return a.sum!=b.sum?a.sum<b.sum:a.counts<b.counts;});
 uint64_t groups=0,collisions=0,maximum=0;
 for(size_t i=0;i<rows.size();){
  size_t j=i+1;while(j<rows.size()&&rows[j].sum==rows[i].sum)++j;
  ++groups;collisions+=(j>i+1);maximum=std::max(maximum,uint64_t(j-i));
  assert(rows[i].counts==rows[j-1].counts);i=j;
 }
 assert(groups==6712340&&collisions==435&&maximum==29);
 std::cout<<"PASS length7 multisets "<<rows.size()<<" sums "<<groups
  <<" collision_classes "<<collisions<<" max_class "<<maximum
  <<" non_frobenius_classes 0\n";
}
