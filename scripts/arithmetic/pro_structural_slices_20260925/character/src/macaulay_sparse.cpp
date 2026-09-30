// Exact degree-(1,d) Macaulay row-space checks over F25.
// Field code a+5b denotes a+b*beta, beta^2=beta+3.
// Input: nr nz nw, then the nr*nz*nw field codes, and d nf.
// Monomials are encoded as exponent vectors; no point sampling occurs.
#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>
using namespace std;
static uint8_t addt[25][25], subt[25][25], mult[25][25], invt[25];
void field(){
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  addt[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  subt[a][b]=(a%5-b%5+5)%5+5*((a/5-b/5+5)%5);
  mult[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 }
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mult[a][b]==1)invt[a]=b;
}
using Mono=vector<uint8_t>;
void gen(int n,int d,int i,Mono &m,vector<Mono>&v){
 if(i==n-1){m[i]=d;v.push_back(m);return;}
 for(int e=0;e<=d;e++){m[i]=e;gen(n,d-e,i+1,m,v);}
}
vector<Mono> monoms(int n,int d){
 vector<Mono>v;Mono m(n);gen(n,d,0,m,v);
 sort(v.begin(),v.end(),[](const Mono&a,const Mono&b){
  for(int i=int(a.size())-1;i>=0;i--)if(a[i]!=b[i])return a[i]<b[i];return false;
 });return v;
}
struct Entry{int col;uint8_t c;};
int main(int argc,char**argv){
 field();int nr,nz,nw,d,nf;
 cin>>nr>>nz>>nw;
 if(!cin||nw<1||nw>40){cerr<<"Invalid input dimensions\n";return 2;}
 vector<uint8_t>A(nr*nz*nw);
 for(auto &c:A){int x;cin>>x;if(x<0||x>=25)return 2;c=x;}
 cin>>d>>nf;
 if(!cin||d<1||nf>nw)return 2;
 auto mons=monoms(nw,d),prev=monoms(nw,d-1);
 auto lessm=[](const Mono&a,const Mono&b){for(int i=int(a.size())-1;i>=0;i--)if(a[i]!=b[i])return a[i]<b[i];return false;};
 const int nm=mons.size(),np=prev.size(),nc=nz*nm,nb=(nc+63)/64;
 vector<vector<int>> prod(np,vector<int>(nw));
 for(int h=0;h<np;h++)for(int w=0;w<nw;w++){
  Mono m=prev[h];m[w]++;
  prod[h][w]=lower_bound(mons.begin(),mons.end(),m,lessm)-mons.begin();
 }
 bool position_first=(argc>1&&string(argv[1])=="position");
 bool pure_mode=(argc>1&&string(argv[1])=="pure");
 vector<int> mono_order(nm);iota(mono_order.begin(),mono_order.end(),0);
 auto pure=[&](int m){for(int w=nf;w<nw;w++)if(mons[m][w])return false;return true;};
 int mixed_count=0;
 if(pure_mode){stable_sort(mono_order.begin(),mono_order.end(),[&](int a,int b){return pure(a)<pure(b);});for(int m:mono_order)if(!pure(m))mixed_count++;}
 vector<int> monomap(nm);for(int i=0;i<nm;i++)monomap[mono_order[i]]=i;
 auto col=[=](int z,int m){return position_first?z*nm+m:monomap[m]*nz+z;};
 vector<vector<Entry>> base(nc);
 vector<uint8_t> work(nc);
 vector<uint64_t> bits(nb);
 long long ops=0,total_entries=0;int rk=0;
 auto begin=chrono::steady_clock::now();
 auto reduce=[&](bool store){
  int block=0;
  while(true){
   while(block<nb&&!bits[block])block++;
   if(block==nb)return -1;
   int pivot=64*block+std::countr_zero(bits[block]);
   if(base[pivot].empty()){
    if(!store)return pivot;
    uint8_t c=invt[work[pivot]];auto &dest=base[pivot];
    for(int b=block;b<nb;b++){
     uint64_t mask=bits[b];
     while(mask){int k=64*b+std::countr_zero(mask);mask&=mask-1;dest.push_back({k,mult[c][work[k]]});work[k]=0;}
     bits[b]=0;
    }
    total_entries+=dest.size();rk++;return pivot;
   }
   uint8_t c=work[pivot];ops+=base[pivot].size();
   for(const auto &e:base[pivot]){
    auto old=work[e.col];auto val=subt[old][mult[c][e.c]];work[e.col]=val;
    if((old==0)!=(val==0))bits[e.col/64]^=uint64_t(1)<<(e.col%64);
   }
  }
 };
 cerr<<"degree "<<d<<" rows "<<nr*np<<" cols "<<nc<<" ordering "<<(position_first?"position":"term")<<"\n";
 for(int h=0;h<np;h++){
  for(int r=0;r<nr;r++){
   for(int z=0;z<nz;z++)for(int w=0;w<nw;w++){
    int c=A[(r*nz+z)*nw+w];if(!c)continue;int k=col(z,prod[h][w]);
    auto old=work[k];auto val=addt[old][c];work[k]=val;
    if((old==0)!=(val==0))bits[k/64]^=uint64_t(1)<<(k%64);
   }
   reduce(true);
  }
  if((h+1)%100==0){auto sec=chrono::duration<double>(chrono::steady_clock::now()-begin).count();cerr<<"multiplier "<<h+1<<"/"<<np<<" rank "<<rk<<" stored "<<total_entries<<" ops "<<ops<<" seconds "<<sec<<"\n";}
 }
 if(pure_mode && argc>2){
  ofstream out(argv[2]);int ct=0;for(int p=mixed_count*nz;p<nc;p++)if(!base[p].empty())ct++;
  out<<ct<<" "<<nz<<" "<<nf<<" "<<d<<"\n";
  for(int p=mixed_count*nz;p<nc;p++)if(!base[p].empty()){
   out<<base[p].size()<<"\n";
   for(auto e:base[p]){
    int z=e.col%nz,m=mono_order[e.col/nz];out<<z<<" "<<int(e.c)<<" "<<d;
    for(int w=0;w<nf;w++)for(int k=0;k<mons[m][w];k++)out<<" "<<w;out<<"\n";
   }
  }
 }
 int yes=0;vector<int> failed;
 for(int z=0;z<nz;z++)for(int w=0;w<nf;w++){
  fill(work.begin(),work.end(),0);fill(bits.begin(),bits.end(),0);
  Mono m(nw);m[w]=d;int j=lower_bound(mons.begin(),mons.end(),m,lessm)-mons.begin(),k=col(z,j);
  work[k]=1;bits[k/64]|=uint64_t(1)<<(k%64);
  if(reduce(false)==-1)yes++;else failed.push_back(z*nf+w);
 }
 auto sec=chrono::duration<double>(chrono::steady_clock::now()-begin).count();
 cout<<"{\"degree\":"<<d<<",\"rows\":"<<nr*np<<",\"columns\":"<<nc<<",\"rank\":"<<rk<<",\"targets_proved\":"<<yes<<",\"targets_total\":"<<nz*nf<<",\"stored_entries\":"<<total_entries<<",\"field_ops\":"<<ops<<",\"seconds\":"<<sec<<",\"failed\":[";
 for(int i=0;i<int(failed.size());i++)cout<<(i?",":"")<<failed[i];cout<<"]}\n";
 return 0;
}
