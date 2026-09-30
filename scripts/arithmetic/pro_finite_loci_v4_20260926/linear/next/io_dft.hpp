#pragma once
#include <filesystem>
namespace fs=std::filesystem;
using Rows=std::vector<std::vector<F>>;

Rows dft(const Rows& in,F root){
 const int n=in.size(), cols=in[0].size(); Rows out(n,std::vector<F>(cols));
 if(n==1)return in;
 int a=2;while(n%a)a++;int b=n/a;
 if(b==1){
  F rk(1);for(int k=0;k<n;k++){F fac(1);for(int j=0;j<n;j++){if(fac==F(1)){for(int c=0;c<cols;c++)out[k][c]+=in[j][c];}else for(int c=0;c<cols;c++)out[k][c]+=in[j][c]*fac;fac*=rk;}rk*=root;}return out;
 }
 for(int r=0;r<a;r++){
  Rows sub(b);for(int j=0;j<b;j++)sub[j]=in[a*j+r];Rows val=dft(sub,root.pow(a));
  F fac(1),step=root.pow(r);for(int k=0;k<n;k++){if(fac==F(1)){for(int c=0;c<cols;c++)out[k][c]+=val[k%b][c];}else for(int c=0;c<cols;c++)out[k][c]+=val[k%b][c]*fac;fac*=step;}
 }
 return out;
}
void write32(std::ostream& f,int a){uint32_t n=a;char b[4];for(int i=0;i<4;i++)b[i]=char(n>>(8*i));f.write(b,4);}
int read32(std::istream& f){unsigned char b[4];f.read((char*)b,4);if(!f)throw std::runtime_error("truncated binary");return int(b[0])+(int(b[1])<<8)+(int(b[2])<<16)+(int(b[3])<<24);}
Rows read_rows(const fs::path& p,int nr,int nc){std::ifstream f(p,std::ios::binary);if(read32(f)!=nr||read32(f)!=nc)throw std::runtime_error("bad dimensions");Rows r(nr,std::vector<F>(nc));for(auto& row:r)for(auto& a:row)a=F::code(read32(f));if(f.peek()!=EOF)throw std::runtime_error("trailing bytes");return r;}
void write_rows(const fs::path& p,const Rows& rows){fs::path tmp=p.string()+".tmp";std::ofstream f(tmp,std::ios::binary);write32(f,rows.size());write32(f,rows[0].size());for(auto& row:rows)for(F a:row)write32(f,a.v);f.close();if(!f)throw std::runtime_error("write failed");fs::rename(tmp,p);}
