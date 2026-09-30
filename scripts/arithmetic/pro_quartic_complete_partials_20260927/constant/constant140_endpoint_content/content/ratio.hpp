#pragma once
#include "../src/source.hpp"
#include <sstream>
struct RF{Poly U,V; std::array<std::array<Poly,6>,2>Z;};
RF operator+(const RF&a,const RF&b){RF c;c.U=a.U+b.U;c.V=a.V+b.V;for(int h=0;h<2;h++)for(int q=0;q<6;q++)c.Z[h][q]=a.Z[h][q]+b.Z[h][q];return c;}
RF operator-(const RF&a,const RF&b){RF c;c.U=a.U-b.U;c.V=a.V-b.V;for(int h=0;h<2;h++)for(int q=0;q<6;q++)c.Z[h][q]=a.Z[h][q]-b.Z[h][q];return c;}
RF operator*(const Poly&a,const RF&b){RF c;c.U=a*b.U;c.V=a*b.V;for(int h=0;h<2;h++)for(int q=0;q<6;q++)c.Z[h][q]=a*b.Z[h][q];return c;}
RF divRF(const RF&a,const Poly&b){RF c;c.U=exactdiv(a.U,b);c.V=exactdiv(a.V,b);for(int h=0;h<2;h++)for(int q=0;q<6;q++)c.Z[h][q]=exactdiv(a.Z[h][q],b);return c;}
std::array<RF,4> readRF(const std::string&path){std::ifstream f(path);std::string s;f>>s;if(s!="RATIO_SOURCE_V1")throw std::runtime_error("Bad ratio file");std::array<RF,4>r;for(auto&a:r){a.U=readpoly(f);a.V=readpoly(f);for(int h=0;h<2;h++)for(int q=0;q<6;q++)a.Z[h][q]=readpoly(f);}return r;}
// v^10 G/w at an endpoint r with v=y/w and q=P(r)/v^3.
std::array<Poly,2> atEndpoint(const RF&a,F r){std::array<Poly,2>o;F pr=eval(P,r);o[0]=Poly::mon(10,eval(a.U,r))+Poly::mon(11,eval(a.V,r));for(int h=0;h<2;h++)for(int q=0;q<6;q++)o[h]=o[h]+Poly::mon(15-3*q,ff::mul(eval(a.Z[h][q],r),ff::pow(pr,q-1)));return o;}
void printCoeffs(std::ostream&f,const Poly&p){f<<"[";for(int j=0;j<=p.deg();j++){if(j)f<<",";f<<p.at(j);}f<<"]";}
