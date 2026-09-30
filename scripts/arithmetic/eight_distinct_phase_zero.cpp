// Exact zero-sum check for eight DISTINCT mu29 phases. Multiply by a
// phase to normalize one exponent to zero; every zero sum is retained.
#include <array>
#include <cassert>
#include <cstdint>
#include <iostream>
#include "sextic_paired_data.hpp"
using Vec=std::array<uint8_t,7>;
uint64_t tested=0,zero=0;
void visit(int remaining,int first,const Vec&v){
 if(!remaining){++tested;bool yes=true;for(auto x:v)yes= yes && !x;zero+=yes;return;}
 for(int j=first;j<=29-remaining;++j){Vec w;for(int k=0;k<7;++k)w[k]=add25[v[k]][phase[j][k]];visit(remaining-1,j+1,w);}
}
int main(){Vec v;for(int k=0;k<7;++k)v[k]=phase[0][k];visit(7,1,v);
 assert(tested==1184040);std::cout<<"COMPLETE normalized_eight_subsets "<<tested<<" zero_sums "<<zero<<'\n';}
