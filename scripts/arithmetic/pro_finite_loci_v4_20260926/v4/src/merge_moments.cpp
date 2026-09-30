// Merge every exact sorted endpoint-ratio chunk, including cross-chunk pairs.
// C++17 standard library. Binary records are eight little-endian uint32 words.
#include <array>
#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <queue>
#include <regex>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;
struct Rec {array<uint32_t,7> v;uint32_t label;};
static_assert(sizeof(Rec)==32,"unexpected record padding");
static uint64_t integer(const string&s,const string&k){smatch m;regex r("\\\""+k+"\\\"\\s*:\\s*([0-9]+)");if(!regex_search(s,m,r))throw runtime_error("missing integer "+k);return stoull(m[1]);}
struct Node {Rec r;size_t file;};
struct Greater{bool operator()(const Node&a,const Node&b)const{return a.r.v>b.r.v;}};
struct Stream {
 vector<ifstream> files;vector<uint64_t> sizes,reads;vector<Rec> previous;vector<bool> have;
 priority_queue<Node,vector<Node>,Greater> heap;
 uint64_t consumed=0;
 explicit Stream(const vector<string>& names):previous(names.size()),have(names.size(),false){
  for(auto&name:names){files.emplace_back(name,ios::binary);if(!files.back())throw runtime_error("open "+name);files.back().seekg(0,ios::end);auto n=files.back().tellg();if(n<0||n%32)throw runtime_error("invalid record size "+name);sizes.push_back(uint64_t(n)/32);reads.push_back(0);files.back().seekg(0);}
  for(size_t i=0;i<files.size();i++)next(i);
 }
 void next(size_t i){
  Rec r{};if(reads[i]==sizes[i])return;
  if(!files[i].read(reinterpret_cast<char*>(&r),32))throw runtime_error("truncated chunk");
  for(auto x:r.v)if(x>=390625)throw runtime_error("bad field coefficient");
  if(have[i]&&r.v<previous[i].v)throw runtime_error("unsorted chunk");
  previous[i]=r;have[i]=true;reads[i]++;heap.push({r,i});
 }
 pair<uint64_t,uint32_t> popgroup(){
  if(heap.empty())throw runtime_error("empty pop");
  auto v=heap.top().r.v;uint32_t id=heap.top().r.label;uint64_t n=0;
  while(!heap.empty()&&heap.top().r.v==v){auto q=heap.top();heap.pop();n++;consumed++;next(q.file);}return {n,id};
 }
 void drain(){while(!heap.empty())popgroup();}
};
int main(int argc,char**argv){try{
 string prefix,profile,out;int chunks=16;
 for(int i=1;i<argc;i++){string a=argv[i];if(a=="--prefix"&&i+1<argc)prefix=argv[++i];else if(a=="--profile"&&i+1<argc)profile=argv[++i];else if(a=="--output"&&i+1<argc)out=argv[++i];else if(a=="--chunks"&&i+1<argc)chunks=stoi(argv[++i]);else throw runtime_error("Usage: --prefix PREFIX --profile PROFILE --output JSON [--chunks 16]");}
 if(prefix.empty()||profile.empty()||out.empty())throw runtime_error("missing arguments");
 uint16_t endian=1;if(*reinterpret_cast<unsigned char*>(&endian)!=1)throw runtime_error("little-endian platform required");
 vector<string>left,right;uint64_t coverage=0,za=0,zb=0,zz=0;
 for(int i=0;i<chunks;i++){
  ostringstream nm;nm<<prefix<<'.'<<setw(2)<<setfill('0')<<i<<".json";ifstream f(nm.str());if(!f)throw runtime_error("missing chunk summary");string s((istreambuf_iterator<char>(f)),{});
  if(s.find("\"profile\": \""+profile+"\"")==string::npos)throw runtime_error("profile mismatch");
  if(integer(s,"range_start")!=coverage)throw runtime_error("gap or overlap in ranges");
  coverage+=integer(s,"quartets_checked");za+=integer(s,"zero_a_count");zb+=integer(s,"zero_b_count");zz+=integer(s,"zero_both_count");
  left.push_back(nm.str()+".left.keys");right.push_back(nm.str()+".right.keys");
 }
 if(coverage!=7940751)throw runtime_error("incomplete endpoint enumeration");
 Stream a(left),b(right);uint64_t hits=0;vector<pair<uint32_t,uint32_t>> first;
 while(!a.heap.empty()&&!b.heap.empty()){
  auto av=a.heap.top().r.v,bv=b.heap.top().r.v;
  if(av<bv){a.popgroup();continue;}if(bv<av){b.popgroup();continue;}
  auto ar=a.popgroup(),br=b.popgroup();hits+=ar.first*br.first;if(first.size()<20)first.emplace_back(ar.second,br.second);
 }
 a.drain();b.drain();uint64_t expected=coverage-za-zb-zz;
 if(a.consumed!=expected||b.consumed!=expected)throw runtime_error("record count disagrees with zero counts");
 bool empty=!hits&&!zz&&(!za||!zb);
 cout<<"PASS: complete contiguous coverage of "<<coverage<<" endpoint quartets\n";
 cout<<"PASS: both sorted streams validated; "<<a.consumed<<" records each\n";
 cout<<"RESULT "<<profile<<" all_pair_ratio_hits="<<hits<<" zero_a="<<za<<" zero_b="<<zb<<" zero_both="<<zz<<" moment_locus_empty="<<(empty?"true":"false")<<'\n';
 for(auto h:first)cout<<"HIT_CODES "<<h.first<<' '<<h.second<<'\n';
 ofstream f(out);if(!f)throw runtime_error("output error");
 f<<"{\n  \"profile\": \""<<profile<<"\",\n  \"scope\": \"complete necessary endpoint-moment locus for this normalized weighted pole profile\",\n  \"quartets_checked\": "<<coverage<<",\n  \"ordered_quartet_pairs_covered\": "<<coverage*coverage<<",\n  \"range_coverage_complete\": true,\n  \"left_records_checked\": "<<a.consumed<<",\n  \"right_records_checked\": "<<b.consumed<<",\n  \"all_pair_ratio_hits\": "<<hits<<",\n  \"zero_a_count\": "<<za<<",\n  \"zero_b_count\": "<<zb<<",\n  \"zero_both_count\": "<<zz<<",\n  \"moment_locus_empty\": "<<(empty?"true":"false")<<",\n  \"first_hit_codes\": [";
 for(size_t i=0;i<first.size();i++){if(i)f<<',';f<<'['<<first[i].first<<','<<first[i].second<<']';}f<<"]\n}\n";
}catch(const exception&e){cerr<<"ERROR: "<<e.what()<<'\n';return 1;}}
