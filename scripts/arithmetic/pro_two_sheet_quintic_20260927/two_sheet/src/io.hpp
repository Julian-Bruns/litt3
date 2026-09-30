#pragma once
#include "algebra.hpp"
LP readLP(istream&in){int n;in>>n;if(!in)throw runtime_error("LP truncated input");LP z;for(int i=0;i<n;i++){LP::Exp e;int c;in>>e[0]>>e[1]>>e[2]>>e[3]>>c;if(!in)throw runtime_error("LP truncated term");z.put(e,F::raw(c));}return z;}
void saveLP(ostream&o,const LP&p){o<<p.a.size();for(auto[e,c]:p.a)o<<" "<<e[0]<<" "<<e[1]<<" "<<e[2]<<" "<<e[3]<<" "<<c.v;o<<"\n";}
array<CL,4> readsource(string path){ifstream in(path);string header;getline(in,header);if(header!="SOURCE_V1 h w k1 k2")throw runtime_error("bad source header");array<CL,4>G;for(int k=0;k<12;k++){int g,j,d;in>>g>>j>>d;for(int i=0;i<=d;i++)G[g].a[j].a.push_back(readLP(in));}return G;}
void stats(string label,const LP&p){array<int,4> lo={INT_MAX,INT_MAX,INT_MAX,INT_MAX},hi={INT_MIN,INT_MIN,INT_MIN,INT_MIN};for(auto[e,c]:p.a)for(int j=0;j<4;j++){lo[j]=min(lo[j],e[j]);hi[j]=max(hi[j],e[j]);}cerr<<label<<": "<<p.a.size()<<" terms, ranges ";for(int j=0;j<4;j++)cerr<<"["<<lo[j]<<","<<hi[j]<<"] ";cerr<<"\n";}
// Remove only invertible scalar and Laurent monomial factors. Does NOT take radicals.
LP monic_laurent(LP p){if(!p)return p;LP::Exp lo={INT_MAX,INT_MAX,INT_MAX,INT_MAX};for(auto[e,c]:p.a)for(int j=0;j<4;j++)lo[j]=min(lo[j],e[j]);for(int&z:lo)z=-z;p=p*LP::mon(lo);return p*LP(p.a.rbegin()->second.inverse());}
