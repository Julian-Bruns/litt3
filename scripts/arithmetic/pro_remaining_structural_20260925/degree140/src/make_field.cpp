#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <vector>
#include <stdexcept>
using namespace std;
static int add25[25][25],mul25[25][25],neg25[25];
int plusraw(int a,int b){int s=0,p=1;for(int i=0;i<4;i++,p*=25){s+=p*add25[a%25][b%25];a/=25;b/=25;}return s;}
int timesraw(int a,int b){int av[4],bv[4],s[7]={};for(int i=0;i<4;i++){av[i]=a%25;bv[i]=b%25;a/=25;b/=25;}for(int i=0;i<4;i++)for(int j=0;j<4;j++)s[i+j]=add25[s[i+j]][mul25[av[i]][bv[j]]];int m[4]={5,2,6,7};for(int i=6;i>=4;i--){for(int j=0;j<4;j++)s[i-4+j]=add25[s[i-4+j]][neg25[mul25[s[i]][m[j]]]];}int r=0;for(int i=3;i>=0;i--)r=25*r+s[i];return r;}
int powerraw(int a,int n){int z=1;while(n){if(n&1)z=timesraw(z,a);a=timesraw(a,a);n>>=1;}return z;}
int main(int argc,char**argv){string out=argc>1?argv[1]:"data";for(int a=0;a<25;a++){neg25[a]=(5-a%5)%5+5*((5-a/5)%5);for(int b=0;b<25;b++){add25[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);mul25[a][b]=(a%5*(b%5)+3*(a/5)*(b/5))%5+5*((a%5*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);}}int primitive=25;for(;;primitive++){bool ok=powerraw(primitive,390624)==1;for(int q:{2,3,13,313})ok=ok&&powerraw(primitive,390624/q)!=1;if(ok)break;if(primitive==390625)throw runtime_error("field/primitive failure");}vector<int32_t>log(390625,-1),exp(781248);int z=1;for(int i=0;i<390624;i++){if(log[z]!=-1)throw runtime_error("short period");log[z]=i;exp[i]=exp[i+390624]=z;z=timesraw(z,primitive);}if(z!=1)throw runtime_error("bad cycle");vector<uint16_t>add(625*625);for(int a=0;a<625;a++)for(int b=0;b<625;b++)add[a*625+b]=add25[a%25][b%25]+25*add25[a/25][b/25];ofstream(out+"/field_log.bin",ios::binary).write((char*)log.data(),log.size()*4);ofstream(out+"/field_exp.bin",ios::binary).write((char*)exp.data(),exp.size()*4);ofstream(out+"/field_add.bin",ios::binary).write((char*)add.data(),add.size()*2);cout<<"F_(5^8), alpha encoding 25, beta encoding 5, primitive="<<primitive<<", period=390624; all nonzero elements enumerated exactly once.\n";
}
