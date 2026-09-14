// Exact Frobenius class-product mass for (2^42,3^28,7^12).
// C++17 with header-only Boost.Multiprecision. No character tables.
#include <boost/multiprecision/cpp_int.hpp>
#include <algorithm>
#include <array>
#include <chrono>
#include <iostream>
#include <map>
#include <stdexcept>
#include <vector>
using namespace std;
using boost::multiprecision::cpp_int;
array<cpp_int,85> fact;
uint64_t npart=0, nonzero=0;
cpp_int total=0;
vector<int> lam;
cpp_int hook_product(const vector<int>& l){
 if(l.empty())return 1;
 array<int,85> cols{};
 for(int a:l)for(int j=0;j<a;j++)cols[j]++;
 cpp_int h=1;
 for(int i=0;i<(int)l.size();i++)for(int j=0;j<l[i];j++)h*=l[i]-j+cols[j]-i-1;
 return h;
}
cpp_int character(const vector<int>& l,int e){
 const int L=l.size(); if(!L)return 1;
 array<int,7> cnt{},seen{},vacseen{};
 array<array<int,85>,7> runners{};
 int parity=0;
 for(int i=0;i<L;i++){
  int beta=l[i]+L-1-i,r=beta%e;
  runners[r][cnt[r]++]=beta/e;
  for(int s=r+1;s<e;s++)parity^=(seen[s]&1);
  seen[r]++;
  int vr=(L-1-i)%e;
  for(int s=vr+1;s<e;s++)parity^=(vacseen[s]&1);
  vacseen[vr]++;
 }
 for(int r=0;r<e;r++)if(cnt[r]!=vacseen[r])return 0;
 cpp_int denom=1;
 for(int r=0;r<e;r++){
  vector<int> mu;
  for(int j=0;j<cnt[r];j++){
   int v=runners[r][j]-(cnt[r]-1-j);
   if(v<0)throw runtime_error("bad quotient");
   if(v)mu.push_back(v);
  }
  denom*=hook_product(mu);
 }
 int n=0;for(int a:l)n+=a;
 if(fact[n/e]%denom!=0)throw runtime_error("nonintegral character");
 cpp_int value=fact[n/e]/denom;
 return parity?-value:value;
}
void visit(int n,int bound){
 if(n==0){
  npart++;
  auto c7=character(lam,7);if(c7==0)return;
  auto c3=character(lam,3);if(c3==0)return;
  auto c2=character(lam,2);if(c2==0)return;
  nonzero++;
  total+=hook_product(lam)*c7*c3*c2;
  return;
 }
 for(int a=min(n,bound);a>=1;a--){lam.push_back(a);visit(n-a,a);lam.pop_back();}
}
cpp_int power(int a,int e){cpp_int x=1;for(int i=0;i<e;i++)x*=a;return x;}

// Direct Murnaghan--Nakayama recursion, independent of the quotient formula.
array<map<vector<int>,cpp_int>,8> mn_cache;
cpp_int mn_character(const vector<int>& l, int e){
 if(l.empty())return 1;
 auto it=mn_cache[e].find(l);if(it!=mn_cache[e].end())return it->second;
 const int L=l.size();vector<int> beta;
 for(int i=0;i<L;i++)beta.push_back(l[i]+L-1-i);
 cpp_int answer=0;
 for(int b:beta){
  if(b<e || find(beta.begin(),beta.end(),b-e)!=beta.end())continue;
  int height=0;vector<int> nb=beta;
  for(int x:beta)if(b-e<x && x<b)height++;
  *find(nb.begin(),nb.end(),b)=b-e;
  sort(nb.begin(),nb.end(),greater<int>());
  vector<int> mu;
  for(int i=0;i<L;i++){int v=nb[i]-(L-1-i);if(v)mu.push_back(v);}
  cpp_int term=mn_character(mu,e);answer+=(height%2 ? -term : term);
 }
 mn_cache[e][l]=answer;return answer;
}
uint64_t tests=0;
void test_visit(int n,int bound,int e,vector<int>& l){
 if(n==0){
  if(character(l,e)!=mn_character(l,e))throw runtime_error("MN cross-check failed");
  tests++;return;
 }
 for(int a=min(n,bound);a>=1;a--){l.push_back(a);test_visit(n-a,a,e,l);l.pop_back();}
}
int main(){
 fact[0]=1;for(int i=1;i<=84;i++)fact[i]=fact[i-1]*i;
 auto start=chrono::steady_clock::now();
 for(int n=1;n<=21;n++)for(int e:{2,3,7})if(n%e==0){vector<int> l;test_visit(n,n,e,l);}
 cout<<"MN_cross_checks = "<<tests<<"\n";
 visit(84,84);
 cpp_int den=power(2,42)*fact[42]*power(3,28)*fact[28]*power(7,12)*fact[12];
 cpp_int a=total,b=den;while(b!=0){cpp_int r=a%b;a=b;b=r;}
 cout<<"partitions_of_84 = "<<npart<<"\nnonzero_character_products = "<<nonzero<<"\n";
 cout<<"character_numerator = "<<total<<"\ncharacter_denominator = "<<den<<"\n";
 cout<<"character_mass = "<<total/a<<"/"<<den/a<<"\n";
 cout<<"seconds = "<<chrono::duration<double>(chrono::steady_clock::now()-start).count()<<endl;
}
