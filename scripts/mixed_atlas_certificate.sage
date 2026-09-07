#!/usr/bin/env sage
"""Checkpointed exact pencil elimination on F25 rooted charts.

Multipliers have v-degree <= A and b-degree <= B. All v-bearing columns
are eliminated first; every resulting pure-b basis relation retains its exact
disk provenance. The selected expanded multiplier certificate is independently
checked against original N/s equations. No Groebner basis is computed.

Resume by repeating the same command and output directory. Checkpoints contain
only completed rows, have payload checksums and an atomic previous snapshot.
Live progress is state.cp.progress.json; --max-rows gives deterministic stops.
"""
import argparse, array, hashlib, itertools, json, os, struct, subprocess, time, uuid
from pathlib import Path

CPP = r'''
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <sys/resource.h>
#include <vector>
using namespace std;
struct Pivot {vector<uint32_t> col; vector<uint8_t> val;};
struct Edge {uint32_t parent; uint8_t factor;};
static uint8_t mul[25][25], subf[25][25], invf[25];
template<class T> void put(ofstream& f,T v){f.write((char*)&v,sizeof(v));}
template<class T> T get(ifstream& f){T v; f.read((char*)&v,sizeof(v)); if(!f) throw runtime_error("truncated input"); return v;}
int main(int argc,char**argv){
 if(argc!=6)return 9;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  int a0=a%5,a1=a/5,b0=b%5,b1=b/5;
  mul[a][b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);
  subf[a][b]=(a0-b0+5)%5+5*((a1-b1+5)%5);
 }
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mul[a][b]==1)invf[a]=b;
 auto start=chrono::steady_clock::now(); double limit=atof(argv[4]); uint64_t cap=stoull(argv[5]);
 auto elapsed=[&](){return chrono::duration<double>(chrono::steady_clock::now()-start).count();};
 auto rss=[&](){struct rusage r; getrusage(RUSAGE_SELF,&r);
#ifdef __APPLE__
 return uint64_t(r.ru_maxrss);
#else
 return uint64_t(r.ru_maxrss)*1024;
#endif
 };
 ifstream input(argv[1],ios::binary); ofstream dag(argv[2],ios::binary);
 uint32_t rows=get<uint32_t>(input),cols=get<uint32_t>(input);
 vector<int32_t> owner(cols,-1); vector<Pivot> pivots;
 vector<uint64_t> offsets; vector<uint8_t> work(cols,0);
 uint64_t reductions=0,stored=0; uint32_t processed=0; string status="bounded_ansatz_no_certificate";
 int found=-1;
 for(uint32_t row=0;row<rows;row++){
  if(elapsed()>limit){status="time_limit";break;}
  if(rss()>cap){status="memory_limit";break;}
  fill(work.begin(),work.end(),0);
  uint32_t count=get<uint32_t>(input); vector<uint32_t> ci(count); vector<uint8_t> cv(count);
  input.read((char*)ci.data(),4*count);input.read((char*)cv.data(),count);
  if(!input)throw runtime_error("bad row");
  for(uint32_t h=0;h<count;h++)work[ci[h]]=cv[h];
  vector<Edge> edges;
  bool interrupted=false;
  for(uint32_t col=0;col<cols;col++){
   uint8_t c=work[col];if(!c)continue;
   int32_t old=owner[col];
   if(old>=0){
    const Pivot &p=pivots[old];work[col]=0;
    for(size_t h=1;h<p.col.size();h++)work[p.col[h]]=subf[work[p.col[h]]][mul[c][p.val[h]]];
    edges.push_back({uint32_t(old),c});reductions++;
    if((reductions&255)==0 && (elapsed()>limit||rss()>cap)){
     status=elapsed()>limit?"time_limit":"memory_limit";interrupted=true;break;
    }
   }else{
    uint8_t norm=invf[c];Pivot p;
    for(uint32_t h=col;h<cols;h++)if(work[h]){p.col.push_back(h);p.val.push_back(mul[norm][work[h]]);}
    owner[col]=int32_t(pivots.size());stored+=p.col.size();pivots.push_back(move(p));
    offsets.push_back(uint64_t(dag.tellp()));put(dag,row);put(dag,norm);put(dag,uint32_t(edges.size()));
    for(auto e:edges){put(dag,e.parent);put(dag,e.factor);}
    if(col==cols-1){found=owner[col];status="unit_found";}
    break;
   }
  }
  processed=row+1;
  if(interrupted||found>=0)break;
 }
 dag.close();
 if(found>=0){
  ifstream trace(argv[2],ios::binary);vector<uint8_t> lambda(pivots.size(),0),weights(rows,0);lambda[found]=1;
  for(int64_t id=found;id>=0;id--){
   uint8_t c=lambda[id];if(!c)continue;
   trace.seekg(offsets[id]);uint32_t source=get<uint32_t>(trace);uint8_t norm=get<uint8_t>(trace);
   uint32_t n=get<uint32_t>(trace);uint8_t cn=mul[c][norm];
   weights[source]=subf[weights[source]][subf[0][cn]];
   for(uint32_t h=0;h<n;h++){
    uint32_t parent=get<uint32_t>(trace);uint8_t factor=get<uint8_t>(trace);
    lambda[parent]=subf[lambda[parent]][mul[cn][factor]];
   }
  }
  ofstream cert(argv[3],ios::binary);cert.write((char*)weights.data(),weights.size());
 }
 cout<<"{\"status\":\""<<status<<"\",\"rows_total\":"<<rows<<",\"columns\":"<<cols
     <<",\"rows_processed\":"<<processed<<",\"rank_so_far\":"<<pivots.size()
     <<",\"row_reductions\":"<<reductions<<",\"stored_nonzeros\":"<<stored
     <<",\"peak_rss_bytes\":"<<rss()<<",\"native_seconds\":"<<elapsed()<<"}"<<endl;
 return 0;
}
'''

# Retain the original arithmetic implementation above as the regression source.
# The general engine uses the same scalar tables and sparse row operations.
CPP_GENERAL = CPP[:CPP.index('int main(')] + r'''
#include <filesystem>
#include <fcntl.h>
#include <unistd.h>
#include <sstream>
#include <atomic>
#include <condition_variable>
#include <functional>
#include <mutex>
#include <thread>
namespace fs=std::filesystem;
alignas(64) static uint8_t axpy[25][1024];
static void syncfile(const string&p){int fd=open(p.c_str(),O_RDONLY);if(fd>=0){fsync(fd);close(fd);}}
static uint64_t digest=1469598103934665603ULL;
static void hashbytes(const char*p,size_t n){for(size_t i=0;i<n;i++){digest^=uint8_t(p[i]);digest*=1099511628211ULL;}}
template<class T> void cpwrite(ofstream&f,T v){put(f,v);hashbytes((char*)&v,sizeof(v));}
template<class T> T cpread(ifstream&f){T v=get<T>(f);hashbytes((char*)&v,sizeof(v));return v;}
struct State {uint32_t processed=0;uint64_t inputpos=8,dagpos=0,reductions=0,stored=0;double seconds=0;vector<Pivot> pivots;vector<uint64_t> offsets;vector<int32_t> source_pivots;};
struct Work {uint64_t calls=0,updates=0,zero_rows=0,zero_calls=0,zero_updates=0,norm=0,probes=0,input_bytes=0,checkpoint_bytes=0,checkpoints=0,predecessor_rows=0,predecessor_zero_skips=0,translated_terms=0,proof_updates=0;double checkpoint_seconds=0;};
// Workers only see immutable pivots. The main thread commits in input order.
class PrefixPool {
 mutex lock;condition_variable ready,done;vector<thread> workers;
 function<void(size_t)> job;size_t next=0,total=0,active=0;bool stopping=false;
public:
 explicit PrefixPool(unsigned n){for(unsigned i=0;i<n;i++)workers.emplace_back([this](){
  unique_lock<mutex> guard(lock);
  for(;;){ready.wait(guard,[&](){return stopping||next<total;});if(stopping)return;
   size_t index=next++;active++;guard.unlock();job(index);guard.lock();
   active--;if(next==total&&!active)done.notify_one();
  }
 });}
 void run(size_t n,function<void(size_t)> fn,const function<void()>&tick){
  unique_lock<mutex> guard(lock);job=move(fn);next=0;total=n;ready.notify_all();
  while(next<total||active){if(done.wait_for(guard,chrono::milliseconds(250))==cv_status::timeout){guard.unlock();tick();guard.lock();}}
  job={};
 }
 ~PrefixPool(){{lock_guard<mutex> guard(lock);stopping=true;}ready.notify_all();for(auto &worker:workers)worker.join();}
};
struct PreparedRow {
 vector<uint8_t> values;vector<Edge> edges;uint64_t input_end=0,calls=0,updates=0,probes=0;
 uint32_t column=0,seed=0,variable=UINT32_MAX;uint8_t kind=0;bool inherited_zero=false,interrupted=false;
};
int main(int argc,char**argv){
 if(argc<6)return 9;
 for(int a=0;a<25;a++)for(int b=0;b<25;b++){
  int a0=a%5,a1=a/5,b0=b%5,b1=b/5;
  mul[a][b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5);
  subf[a][b]=(a0-b0+5)%5+5*((a1-b1+5)%5);
 }
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mul[a][b]==1)invf[a]=b;
 for(int c=0;c<25;c++)for(int p=0;p<25;p++)for(int w=0;w<25;w++){
  uint8_t value=subf[w][mul[c][p]];axpy[c][(p<<5)|w]=value;
  int c0=c%5,c1=c/5,p0=p%5,p1=p/5,w0=w%5,w1=w/5;
  int direct=(w0-c0*p0-3*c1*p1+100)%5+5*((w1-c0*p1-c1*p0-c1*p1+100)%5);
  if(value!=direct)throw runtime_error("fused F25 axpy exhaustive verification failed");
 }
 auto start=chrono::steady_clock::now();double limit=atof(argv[4]);uint64_t cap=stoull(argv[5]);
 string checkpoint=argc>6?argv[6]:"",dagpath=argv[2];
 uint32_t boundary=argc>7?stoul(argv[7]):UINT32_MAX;
 double interval=argc>8?atof(argv[8]):30;
 uint32_t maxrows=argc>9?stoul(argv[9]):UINT32_MAX;
 int64_t requested=argc>10?stoll(argv[10]):-1;
 string logpath=argc>11?argv[11]:"";
 string runid=argc>12?argv[12]:to_string(chrono::system_clock::now().time_since_epoch().count());
 string context=argc>13?argv[13]:"{\"schema\":1,\"backend\":\"native_pencil\",\"arithmetic_domain\":\"native_F25\",\"field_degree_F5\":2}";
 string predecessor_path=argc>14?argv[14]:"";bool recurrence=!predecessor_path.empty();
 unsigned threads=argc>15?stoul(argv[15]):1;
 if(threads<1||threads>256)throw runtime_error("native threads must be in 1..256");
 uint32_t batch_requested=argc>16?stoul(argv[16]):0;
 if(!batch_requested)batch_requested=threads==1?1:4*threads;
 auto elapsed=[&](){return chrono::duration<double>(chrono::steady_clock::now()-start).count();};
 auto rss=[&](){struct rusage r;getrusage(RUSAGE_SELF,&r);
#ifdef __APPLE__
 return uint64_t(r.ru_maxrss);
#else
 return uint64_t(r.ru_maxrss)*1024;
#endif
 };
 ifstream input(argv[1],ios::binary);uint32_t rows=get<uint32_t>(input),cols=get<uint32_t>(input);
 vector<int32_t> predecessor,column_translate,multiplier_translate;vector<uint32_t> predecessor_variable;
 uint32_t multiplier_count=0,equation_count=0,variable_count=0;
 if(recurrence){
  ifstream m(predecessor_path,ios::binary);
  if(get<uint64_t>(m)!=0x5052454445433031ULL||get<uint32_t>(m)!=rows||get<uint32_t>(m)!=cols)throw runtime_error("predecessor metadata mismatch");
  multiplier_count=get<uint32_t>(m);equation_count=get<uint32_t>(m);variable_count=get<uint32_t>(m);
  if(uint64_t(multiplier_count)*equation_count!=rows)throw runtime_error("bad multiplier count");
  predecessor.resize(rows);predecessor_variable.resize(rows);
  for(uint32_t r=0;r<rows;r++){predecessor[r]=get<int32_t>(m);predecessor_variable[r]=get<uint32_t>(m);if(predecessor[r]>=int64_t(r))throw runtime_error("predecessor is not earlier");}
  column_translate.resize(uint64_t(variable_count)*cols);for(auto &v:column_translate)v=get<int32_t>(m);
  multiplier_translate.resize(uint64_t(variable_count)*multiplier_count);for(auto &v:multiplier_translate)v=get<int32_t>(m);
  if(m.peek()!=EOF)throw runtime_error("extra predecessor metadata");
 }
 if(boundary==UINT32_MAX)boundary=cols-1;
 vector<uint8_t> degrees(cols,0);ifstream degfile(string(argv[1])+".degrees",ios::binary);
 if(degfile)degfile.read((char*)degrees.data(),cols);
 State state;
 if(recurrence)state.source_pivots.assign(rows,-2);
 auto readcp=[&](const string&path){
  State s;ifstream f(path,ios::binary);digest=1469598103934665603ULL;
  if(cpread<uint64_t>(f)!=(recurrence?0x4d414341554c3032ULL:0x4d414341554c3031ULL)||cpread<uint32_t>(f)!=rows||cpread<uint32_t>(f)!=cols||cpread<uint32_t>(f)!=boundary)throw runtime_error("checkpoint header mismatch");
  s.processed=cpread<uint32_t>(f);s.inputpos=cpread<uint64_t>(f);s.dagpos=cpread<uint64_t>(f);s.reductions=cpread<uint64_t>(f);s.stored=cpread<uint64_t>(f);s.seconds=cpread<double>(f);
  uint32_t rank=cpread<uint32_t>(f);if(rank>cols||s.processed>rows)throw runtime_error("invalid checkpoint counts");
  for(uint32_t id=0;id<rank;id++){
   s.offsets.push_back(cpread<uint64_t>(f));uint32_t n=cpread<uint32_t>(f);if(n>cols||n==0)throw runtime_error("invalid checkpoint row");
   Pivot p;p.col.resize(n);p.val.resize(n);
   for(auto &v:p.col)v=cpread<uint32_t>(f);for(auto &v:p.val)v=cpread<uint8_t>(f);
   if(p.val[0]!=1||!is_sorted(p.col.begin(),p.col.end())||p.col.back()>=cols)throw runtime_error("invalid echelon pivot");
   s.pivots.push_back(move(p));
  }
  if(recurrence){s.source_pivots.resize(rows);for(uint32_t r=0;r<rows;r++){int32_t id=cpread<int32_t>(f);s.source_pivots[r]=id;if(r<s.processed?(id< -1||id>=int64_t(rank)):id!= -2)throw runtime_error("invalid source-row checkpoint map");}}
  uint64_t computed=digest;if(get<uint64_t>(f)!=computed||f.peek()!=EOF)throw runtime_error("checkpoint checksum mismatch");
  if(fs::file_size(dagpath)<s.dagpos)throw runtime_error("provenance truncated");return s;
 };
 bool resumed=false;
 if(!checkpoint.empty()&&fs::exists(checkpoint)){
  try{state=readcp(checkpoint);}catch(const exception&e){cerr<<"Primary checkpoint rejected: "<<e.what()<<"; trying previous\n";state=readcp(checkpoint+".prev");}
  fs::resize_file(dagpath,state.dagpos);resumed=true;
 }
 vector<int32_t> owner(cols,-1);for(size_t id=0;id<state.pivots.size();id++){uint32_t col=state.pivots[id].col[0];if(owner[col]>=0)throw runtime_error("duplicate pivot");owner[col]=id;}
 input.seekg(state.inputpos);ofstream dag(dagpath,ios::binary|(resumed?ios::app:ios::trunc));
 double inherited=state.seconds,lastsave=elapsed(),lastprogress=-10;uint32_t initialprocessed=state.processed;
 Work workcounts,previouscounts,zerocounts;workcounts.input_bytes=8;
 uint64_t parallel_rows=0,parallel_reductions=0;uint32_t active_batch_rows=0;
 vector<uint64_t> reuse(cols,0);uint64_t interval_index=0;uint32_t interval_start_row=state.processed;double interval_start_time=0;
 ofstream operations;if(!logpath.empty())operations.open(logpath,ios::app);
 auto counts_json=[&](const Work&a,const Work&b){ostringstream s;s
  <<"{\"row_subtractions\":"<<a.calls-b.calls<<",\"coefficient_updates\":"<<a.updates-b.updates
  <<",\"zero_rows\":"<<a.zero_rows-b.zero_rows<<",\"zero_row_subtractions\":"<<a.zero_calls-b.zero_calls
  <<",\"zero_row_coefficient_updates\":"<<a.zero_updates-b.zero_updates<<",\"normalization_products\":"<<a.norm-b.norm
  <<",\"column_probes\":"<<a.probes-b.probes<<",\"input_bytes\":"<<a.input_bytes-b.input_bytes
  <<",\"checkpoint_bytes\":"<<a.checkpoint_bytes-b.checkpoint_bytes<<",\"checkpoints\":"<<a.checkpoints-b.checkpoints
  <<",\"checkpoint_seconds\":"<<a.checkpoint_seconds-b.checkpoint_seconds
  <<",\"predecessor_rows\":"<<a.predecessor_rows-b.predecessor_rows<<",\"predecessor_zero_skips\":"<<a.predecessor_zero_skips-b.predecessor_zero_skips
  <<",\"translated_terms\":"<<a.translated_terms-b.translated_terms<<",\"provenance_coefficient_updates\":"<<a.proof_updates-b.proof_updates<<"}";return s.str();};
 string status="bounded_ansatz_no_certificate";int64_t found=owner[cols-1];
 auto relation_ids=[&](){vector<uint32_t> ids;for(uint32_t id=0;id<state.pivots.size();id++)if(state.pivots[id].col[0]>=boundary)ids.push_back(id);return ids;};
 auto progress=[&](const string&phase){
  auto ids=relation_ids();int mindeg=-1,maxdeg=-1;
  for(auto id:ids){int degree=0;for(auto col:state.pivots[id].col)degree=max(degree,int(degrees[col]));if(mindeg<0||degree<mindeg)mindeg=degree;maxdeg=max(maxdeg,degree);}
  string record="{\"status\":\""+phase+"\",\"rows_total\":"+to_string(rows)+",\"columns\":"+to_string(cols)+",\"rows_processed\":"+to_string(state.processed)+",\"rank_so_far\":"+to_string(state.pivots.size())+",\"pure_b_relations\":"+to_string(ids.size())+",\"pure_b_min_degree\":"+to_string(mindeg)+",\"pure_b_max_degree\":"+to_string(maxdeg)+",\"row_reductions\":"+to_string(state.reductions)+",\"stored_nonzeros\":"+to_string(state.stored)+",\"peak_rss_bytes\":"+to_string(rss())+",\"native_seconds\":"+to_string(elapsed())+",\"cumulative_seconds\":"+to_string(inherited+elapsed())+",\"resumed\":"+(resumed?"true":"false")+",\"native_threads\":"+to_string(threads)+",\"batch_rows\":"+to_string(active_batch_rows)+",\"parallel_rows\":"+to_string(parallel_rows)+",\"parallel_row_reductions\":"+to_string(parallel_reductions)+",\"counter_scope\":\"since_invocation_start\",\"work_since_invocation_start\":"+counts_json(workcounts,zerocounts)+"}";
  if(!checkpoint.empty()){ofstream f(checkpoint+".progress.tmp");f<<record<<endl;f.close();fs::rename(checkpoint+".progress.tmp",checkpoint+".progress.json");}
  if(operations.is_open()){
   vector<uint64_t> histogram(64,0);uint64_t reused=0,maximum=0;
   for(auto n:reuse)if(n){reused++;maximum=max(maximum,n);uint32_t bucket=0;for(uint64_t value=n;value>1;value>>=1)bucket++;histogram[bucket]++;}
   auto epoch=chrono::duration_cast<chrono::milliseconds>(chrono::system_clock::now().time_since_epoch()).count();double now=elapsed();
   operations<<"{\"schema\":1,\"event\":\""<<(interval_index?"interval":"run_start")<<"\",\"run_id\":\""<<runid<<"\",\"interval_index\":"<<interval_index
    <<",\"timestamp_epoch_ms\":"<<epoch<<",\"phase\":\""<<phase<<"\",\"context\":"<<context
    <<",\"resumed\":"<<(resumed?"true":"false")<<",\"run_processed_start\":"<<initialprocessed
    <<",\"processed_start\":"<<interval_start_row<<",\"processed_end\":"<<state.processed
    <<",\"interval_seconds\":"<<now-interval_start_time<<",\"counter_scope\":\"interval_actual_work\",\"counts\":"<<counts_json(workcounts,previouscounts)
    <<",\"rank\":"<<state.pivots.size()<<",\"pure_b_relations\":"<<ids.size()<<",\"pure_b_min_degree\":"<<mindeg<<",\"pure_b_max_degree\":"<<maxdeg
    <<",\"peak_rss_bytes\":"<<rss()<<",\"distinct_pivots_reused\":"<<reused<<",\"pivot_reuse_max\":"<<maximum
    <<",\"pivot_reuse_log2_histogram\":[";
   for(size_t h=0;h<histogram.size();h++){if(h)operations<<",";operations<<histogram[h];}operations<<"]}"<<endl;
   fill(reuse.begin(),reuse.end(),0);previouscounts=workcounts;interval_start_time=now;interval_start_row=state.processed;interval_index++;
  }
  lastprogress=elapsed();return record;
 };
 auto savecp=[&](){
  if(checkpoint.empty())return;
  double checkpoint_start=elapsed();
  progress("checkpointing");dag.flush();syncfile(dagpath);state.dagpos=uint64_t(dag.tellp());state.seconds=inherited+elapsed();
  ofstream f(checkpoint+".tmp",ios::binary);digest=1469598103934665603ULL;
  cpwrite(f,uint64_t(recurrence?0x4d414341554c3032ULL:0x4d414341554c3031ULL));cpwrite(f,rows);cpwrite(f,cols);cpwrite(f,boundary);cpwrite(f,state.processed);cpwrite(f,state.inputpos);cpwrite(f,state.dagpos);cpwrite(f,state.reductions);cpwrite(f,state.stored);cpwrite(f,state.seconds);cpwrite(f,uint32_t(state.pivots.size()));
  for(size_t id=0;id<state.pivots.size();id++){
   const Pivot&p=state.pivots[id];cpwrite(f,state.offsets[id]);cpwrite(f,uint32_t(p.col.size()));for(auto v:p.col)cpwrite(f,v);for(auto v:p.val)cpwrite(f,v);
  }
  if(recurrence)for(auto id:state.source_pivots)cpwrite(f,id);
  put(f,digest);f.close();syncfile(checkpoint+".tmp");
  if(fs::exists(checkpoint))fs::rename(checkpoint,checkpoint+".prev");fs::rename(checkpoint+".tmp",checkpoint);
  workcounts.checkpoint_bytes+=fs::file_size(checkpoint);workcounts.checkpoints++;workcounts.checkpoint_seconds+=elapsed()-checkpoint_start;lastsave=elapsed();
 };
 PrefixPool pool(threads);
 progress("running");
 bool stop=false;
 while(state.processed<rows&&found<0&&!stop){
  if(state.processed-initialprocessed>=maxrows){status="row_limit";break;}
  if(elapsed()>limit||rss()>cap){status=elapsed()>limit?"time_limit":"memory_limit";break;}
  uint32_t begin=state.processed;
  // Reserve for worst-case dense rows and edge-vector capacity; never use a
  // large fraction of the process cap for speculative work.
  uint64_t available=cap-rss(),per_row=uint64_t(cols)*(1+2*sizeof(Edge))+sizeof(PreparedRow);
  uint64_t budget=min<uint64_t>(256ULL<<20,min(cap/16,available/2));
  if(per_row>available){status="memory_limit";break;}
  uint32_t batch_size=min<uint64_t>(batch_requested,max<uint64_t>(1,budget/max<uint64_t>(1,per_row)));
  batch_size=min(batch_size,rows-begin);batch_size=min(batch_size,maxrows-(begin-initialprocessed));
  // A translated seed must exist before the immutable parallel snapshot.
  if(recurrence)for(uint32_t offset=0;offset<batch_size;offset++)if(predecessor[begin+offset]>=int64_t(begin)){batch_size=offset;break;}
  if(!batch_size)throw runtime_error("empty predecessor batch");
  active_batch_rows=batch_size;
  vector<PreparedRow> batch(batch_size);
  for(uint32_t offset=0;offset<batch_size;offset++){
  uint32_t row=begin+offset;PreparedRow &prepared=batch[offset];prepared.values.assign(cols,0);auto &work=prepared.values;
  uint32_t count=get<uint32_t>(input);workcounts.input_bytes+=4;
  auto &seed_kind=prepared.kind;auto &seed=prepared.seed;auto &seed_variable=prepared.variable;auto &inherited_zero=prepared.inherited_zero;seed=row;
  if(recurrence&&predecessor[row]>=0){
   input.seekg(5*uint64_t(count),ios::cur);int32_t previous=state.source_pivots[predecessor[row]];
   if(previous== -2)throw runtime_error("predecessor not processed");
   if(previous<0){inherited_zero=true;workcounts.predecessor_zero_skips++;}
   else{
    seed_kind=1;seed=previous;seed_variable=predecessor_variable[row];if(seed_variable>=variable_count)throw runtime_error("invalid predecessor variable");
    const Pivot&p=state.pivots[seed];workcounts.predecessor_rows++;workcounts.translated_terms+=p.col.size();
    for(size_t h=0;h<p.col.size();h++){int32_t target=column_translate[uint64_t(seed_variable)*cols+p.col[h]];if(target<0||uint32_t(target)>=cols||work[target])throw runtime_error("invalid monomial translation");work[target]=p.val[h];}
   }
  }else{
   vector<uint32_t> ci(count);vector<uint8_t> cv(count);input.read((char*)ci.data(),4*count);input.read((char*)cv.data(),count);if(!input)throw runtime_error("bad row");
   workcounts.input_bytes+=5*uint64_t(count);for(uint32_t h=0;h<count;h++)work[ci[h]]=cv[h];
   if(recurrence&&row>=equation_count)throw runtime_error("only original equations can seed recurrence");
  }
  if(!input||input.tellg()<0)throw runtime_error("bad input position");
  prepared.input_end=uint64_t(input.tellg());
  }
  atomic<bool> cancelled(false);
  auto tick=[&](){if(elapsed()>limit||rss()>cap)cancelled.store(true,memory_order_relaxed);if(elapsed()-lastprogress>2)progress("running");};
  pool.run(batch.size(),[&](size_t index){
   PreparedRow &prepared=batch[index];auto &work=prepared.values;
   if(prepared.inherited_zero){prepared.column=cols;return;}
   uint32_t col=0;
   for(;col<cols;col++){
    if((prepared.calls&255)==0&&cancelled.load(memory_order_relaxed)){prepared.interrupted=true;break;}
    uint8_t c=work[col];if(!c)continue;int32_t old=owner[col];
    // Do not reduce later old pivots past a gap: serial insertion would stop
    // here, and doing so would change both the echelon row and its proof DAG.
    if(old<0)break;
    const Pivot&p=state.pivots[old];work[col]=0;prepared.calls++;prepared.updates+=p.col.size()-1;
    const uint8_t *operation=axpy[c];
    for(size_t h=1;h<p.col.size();h++)work[p.col[h]]=operation[(uint32_t(p.val[h])<<5)|work[p.col[h]]];
    prepared.edges.push_back({uint32_t(old),c});
   }
   prepared.column=col;prepared.probes=col<cols?col:cols;
  },tick);
  // All workers are quiescent here. Include actual speculative arithmetic in
  // telemetry, but only committed rows contribute to checkpoint reductions.
  for(const auto &prepared:batch){workcounts.calls+=prepared.calls;workcounts.updates+=prepared.updates;workcounts.probes+=prepared.probes;
   if(threads>1){parallel_rows++;parallel_reductions+=prepared.calls;}
   if(operations.is_open())for(auto e:prepared.edges)reuse[e.parent]++;
  }
  for(uint32_t offset=0;offset<batch_size&&found<0;offset++){
  uint32_t row=begin+offset;PreparedRow &prepared=batch[offset];
  if(prepared.interrupted||elapsed()>limit||rss()>cap){status=elapsed()>limit?"time_limit":"memory_limit";stop=true;break;}
  auto &work=prepared.values;auto &edges=prepared.edges;
  uint8_t seed_kind=prepared.kind;uint32_t seed=prepared.seed,seed_variable=prepared.variable;
  bool inherited_zero=prepared.inherited_zero,new_pivot=false,interrupted=false;
  uint64_t reductions_before=state.reductions,updates_before=workcounts.updates;
  state.reductions+=prepared.calls;
  uint32_t probes_logged=prepared.column;
  uint32_t col=prepared.column;if(!inherited_zero)for(;col<cols;col++){
   uint8_t c=work[col];if(!c)continue;int32_t old=owner[col];
   if(old>=0){
    const Pivot&p=state.pivots[old];work[col]=0;
    workcounts.calls++;workcounts.updates+=p.col.size()-1;if(operations.is_open())reuse[old]++;
    const uint8_t *operation=axpy[c];
    for(size_t h=1;h<p.col.size();h++)work[p.col[h]]=operation[(uint32_t(p.val[h])<<5)|work[p.col[h]]];
    edges.push_back({uint32_t(old),c});state.reductions++;
    if((state.reductions&255)==0){
     if(elapsed()-lastprogress>2){workcounts.probes+=uint64_t(col)+1-probes_logged;probes_logged=col+1;progress("running");}
     if(elapsed()>limit||rss()>cap){status=elapsed()>limit?"time_limit":"memory_limit";interrupted=true;break;}
    }
   }else{
    uint8_t norm=invf[c];Pivot p;for(uint32_t h=col;h<cols;h++)if(work[h]){p.col.push_back(h);p.val.push_back(mul[norm][work[h]]);}
    workcounts.norm+=p.col.size();new_pivot=true;
    owner[col]=state.pivots.size();state.stored+=p.col.size();state.pivots.push_back(move(p));
    state.offsets.push_back(uint64_t(dag.tellp()));put(dag,row);put(dag,norm);
    if(recurrence){put(dag,seed_kind);put(dag,seed);put(dag,seed_variable);}
    put(dag,uint32_t(edges.size()));for(auto e:edges){put(dag,e.parent);put(dag,e.factor);}
    if(recurrence)state.source_pivots[row]=state.pivots.size()-1;
    if(col==cols-1){found=owner[col];status="unit_found";}break;
   }
  }
  workcounts.probes+=inherited_zero?0:(col<cols?uint64_t(col)+1:cols)-probes_logged;
  if(interrupted){state.reductions=reductions_before;stop=true;break;}
  if(!new_pivot){workcounts.zero_rows++;workcounts.zero_calls+=state.reductions-reductions_before;workcounts.zero_updates+=prepared.updates+workcounts.updates-updates_before;if(recurrence)state.source_pivots[row]=-1;}
  state.processed=row+1;state.inputpos=prepared.input_end;
  if(elapsed()-lastprogress>2||(operations.is_open()&&state.processed-interval_start_row>=256))progress("running");if(elapsed()-lastsave>interval)savecp();
  }
 }
 if(found>=0)status="unit_found";
 savecp();dag.close();
 auto ids=relation_ids();
 if(!checkpoint.empty()){
  ofstream rel(checkpoint+".pure_b.bin",ios::binary);put(rel,uint32_t(ids.size()));
  for(auto id:ids){const Pivot&p=state.pivots[id];put(rel,id);put(rel,uint32_t(p.col.size()));for(auto c:p.col)put(rel,c);for(auto c:p.val)put(rel,c);}
 }
 int64_t selected=found>=0?found:(requested>=0?requested:(ids.empty()?int64_t(-1):int64_t(ids[0])));
 if(selected>=0){
  progress("certificate_reconstruction");
  if(size_t(selected)>=state.pivots.size())throw runtime_error("certificate node missing");
  ifstream trace(dagpath,ios::binary);vector<uint8_t>weights(rows,0);
  if(recurrence){
   uint64_t entries=uint64_t(state.pivots.size())*multiplier_count;
   if(entries>cap||rss()>cap-entries)throw runtime_error("polynomial provenance exceeds memory cap; checkpoint retained");
   vector<uint8_t> lambda(entries,0);lambda[uint64_t(selected)*multiplier_count]=1;
   for(int64_t id=selected;id>=0;id--){
    uint8_t *coefficient=lambda.data()+uint64_t(id)*multiplier_count;bool any=false;for(uint32_t m=0;m<multiplier_count;m++)if(coefficient[m]){any=true;break;}if(!any)continue;
    trace.seekg(state.offsets[id]);uint32_t source=get<uint32_t>(trace);uint8_t norm=get<uint8_t>(trace),kind=get<uint8_t>(trace);uint32_t seed=get<uint32_t>(trace),variable=get<uint32_t>(trace),n=get<uint32_t>(trace);
    vector<pair<uint32_t,uint8_t>> active;for(uint32_t m=0;m<multiplier_count;m++)if(coefficient[m])active.emplace_back(m,mul[coefficient[m]][norm]);
    if(kind==0){if(seed>=equation_count||seed!=source)throw runtime_error("invalid original provenance source");for(auto term:active){auto &v=weights[uint64_t(term.first)*equation_count+seed];v=subf[v][subf[0][term.second]];}}
    else if(kind==1){if(seed>=uint64_t(id)||variable>=variable_count)throw runtime_error("invalid translated provenance source");for(auto term:active){int32_t target=multiplier_translate[uint64_t(variable)*multiplier_count+term.first];if(target<0||uint32_t(target)>=multiplier_count)throw runtime_error("polynomial provenance exceeds degree bound");auto &v=lambda[uint64_t(seed)*multiplier_count+target];v=subf[v][subf[0][term.second]];}}
    else throw runtime_error("unknown provenance kind");
    workcounts.proof_updates+=active.size();
    for(uint32_t h=0;h<n;h++){uint32_t parent=get<uint32_t>(trace);uint8_t factor=get<uint8_t>(trace);if(parent>=uint64_t(id))throw runtime_error("nonacyclic provenance edge");uint8_t *dst=lambda.data()+uint64_t(parent)*multiplier_count;const uint8_t *operation=axpy[factor];for(auto term:active)dst[term.first]=operation[(uint32_t(term.second)<<5)|dst[term.first]];workcounts.proof_updates+=active.size();}
    if(elapsed()-lastprogress>2)progress("certificate_reconstruction");
   }
  }else{
   vector<uint8_t>lambda(state.pivots.size(),0);lambda[selected]=1;
   for(int64_t id=selected;id>=0;id--){uint8_t c=lambda[id];if(!c)continue;
    trace.seekg(state.offsets[id]);uint32_t source=get<uint32_t>(trace);uint8_t norm=get<uint8_t>(trace);uint32_t n=get<uint32_t>(trace);uint8_t cn=mul[c][norm];weights[source]=subf[weights[source]][subf[0][cn]];
    for(uint32_t h=0;h<n;h++){uint32_t parent=get<uint32_t>(trace);uint8_t factor=get<uint8_t>(trace);lambda[parent]=subf[lambda[parent]][mul[cn][factor]];}workcounts.proof_updates+=uint64_t(n)+1;
   }
  }
  ofstream cert(argv[3],ios::binary);cert.write((char*)weights.data(),weights.size());
  ofstream relation(string(argv[3])+".relation",ios::binary);const Pivot&p=state.pivots[selected];put(relation,uint32_t(selected));put(relation,uint32_t(p.col.size()));for(auto c:p.col)put(relation,c);for(auto c:p.val)put(relation,c);
 }
 cout<<progress(status)<<endl;return 0;
}
'''

def run(chart, output, seconds=120, memory_gib=2, v_degree=1, b_degree=1,
        checkpoint_seconds=30, max_rows=4294967295, extract_node=-1, interval_log=True,
        predecessor_reuse=False, tensor_path=None, atlas_input=None, representative=None,
        threads=1, batch_rows=0):
    if threads < 1 or batch_rows < 0:
        raise ValueError('threads must be positive and batch-rows nonnegative')
    assert not predecessor_reuse or v_degree==0, 'Predecessor reuse currently requires A=0 and a total b-degree bound'
    began=time.monotonic(); out=Path(output).resolve();out.mkdir(parents=True,exist_ok=True)
    root=Path(__file__).resolve().parents[1]
    source=Path(tensor_path).resolve() if tensor_path else root/'Research/computations/canonical_atlas_system.json'
    if tensor_path and not atlas_input:
        raise ValueError('--tensor requires --atlas-input pointing to its verified rooted export')
    folder=Path(atlas_input or '/Users/julian/Documents/litt3-computation-data/atlas-rooted-first')/('chart-%02d'%chart)
    tensor=json.loads(source.read_text()); meta=json.loads((folder/'metadata.json').read_text())
    assert hashlib.sha256(source.read_bytes()).hexdigest()==meta['source_sha256']
    k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
    description=tensor.get('field_description') or dict(kind='finite_field',characteristic=5,degree=2,generator='a',modulus=[2,4,1])
    if description.get('kind')!='finite_field' or description.get('characteristic')!=5 or description.get('degree')!=2:
        raise ValueError('Native backend supports F25 only; larger/tower fields require a different arithmetic backend')
    modulus=PolynomialRing(k,'fieldvariable')(description['modulus'])
    fieldgen=a if modulus(a)==0 else modulus.roots(multiplicities=False)[0]
    assert modulus(fieldgen)==0 and fieldgen**5!=fieldgen
    field_locals={description['generator']:fieldgen}
    if 'base_F25_generator' in description:
        field_locals['a']=sum((k(c)*fieldgen**i for i,c in enumerate(description['base_F25_generator'])),k.zero())
    representative=representative or ('orbit_0000' if tensor_path is None else (tensor.get('oper_metadata') or {}).get('rep_id','unspecified'))
    names=['v%d'%i for i in range(32)]+['b%d'%i for i in range(chart+1,32)]
    P=PolynomialRing(k,names=names,order='degrevlex');vv=P.gens()[:32]
    bb=[P.zero()]*chart+[P.one()]+list(P.gens()[32:])
    loc=dict(zip(names,P.gens()));loc.update(field_locals)
    cache={}
    def coeff(c):
        key=c if isinstance(c,str) else json.dumps(c,separators=(',',':'))
        if key not in cache:
            cache[key]=k(sage_eval(c,locals=field_locals)) if isinstance(c,str) else (sum((k(v)*fieldgen**i for i,v in enumerate(c)),k.zero()) if isinstance(c,list) else k(c))
        return cache[key]
    def tensors(key,n):
        return [sum((coeff(tensor[key][i][r][h])**5*vv[i]*bb[h]
                    for i in range(32) for h in range(chart,32)),P.zero()) for r in range(n)]
    ns=tensors('N_tensor',64);ss=tensors('R_tensor',32)
    original=ns+ss[:chart]+[ss[chart]-1]
    rec=json.loads((folder/'initial_rref.json').read_text())
    rows=[P(sage_eval(s,locals=loc)) for s in rec['rows']]
    C=matrix(k,[[coeff(c) for c in row] for row in rec['row_combinations']])
    assert all(sum((c*f for c,f in zip(row,original)),P.zero())==g for row,g in zip(C.rows(),rows))
    assert C.ncols()==len(original) and C.nrows()==len(rows) and C.rank()==len(rows)
    if len(rows)!=len(original):
        original_monomials=sorted(set(ex for f in original for ex in f.dict()))
        original_matrix=matrix(k,[[f.dict().get(ex,0) for ex in original_monomials] for f in original])
        assert original_matrix.rank()==len(rows), 'Cached reduced equations must span all original equations'
    def tags(ex):
        return tuple(i for i in range(32) for _ in range(ex[i])),tuple(i-32 for i in range(32,len(names)) for _ in range(ex[i]))
    def enc(c):
        poly=c.polynomial();return int(poly[0])+5*int(poly[1])
    elements=[k(i)+a*j for j in range(5) for i in range(5)]
    for xcode,xx in enumerate(elements):
        for ycode,yy in enumerate(elements):
            x0,x1=xcode%5,xcode//5;y0,y1=ycode%5,ycode//5
            assert enc(xx*yy)==(x0*y0+3*x1*y1)%5+5*((x0*y1+x1*y0+x1*y1)%5)
            assert enc(xx-yy)==(x0-y0)%5+5*((x1-y1)%5)
    q=31-chart
    def monomial_tags(variables,degree):
        return [tuple(c) for d in range(degree+1)
                for c in itertools.combinations_with_replacement(range(variables),d)]
    vtags=monomial_tags(32,v_degree+1);btags=monomial_tags(q,b_degree+1)
    # All v-bearing columns precede every pure-b column. The constant part
    # of each original row is scalar, so pure-b output degree is at most B.
    columns=sorted(((v,b) for v in vtags for b in btags if v),
                   key=lambda vb:(-len(vb[0])-len(vb[1]),-len(vb[0]),vb))
    pure_start=len(columns)
    columns+=sorted((((),b) for b in monomial_tags(q,b_degree)),key=lambda vb:(-len(vb[1]),vb))
    index={tag:i for i,tag in enumerate(columns)}
    assert columns[-1]==((),())
    multipliers=sorted(((v,b) for v in monomial_tags(32,v_degree) for b in monomial_tags(q,b_degree)),
                       key=lambda vb:(len(vb[0])+len(vb[1]),len(vb[0]),vb))
    raw=[]
    for f in rows:
        raw.append([(tags(ex),enc(c)) for ex,c in f.dict().items()])
    matrixfile=out/'matrix.bin'
    predecessor_file=out/'predecessor.bin'
    predecessor_data=None
    if predecessor_reuse:
        multiplier_index={tag:i for i,tag in enumerate(multipliers)}
        predecessor_data=bytearray(struct.pack('<QIIIII',0x5052454445433031,
            len(rows)*len(multipliers),len(columns),len(multipliers),len(rows),q))
        for mi,(mv,mb) in enumerate(multipliers):
            assert not mv
            if mb:
                variable=mb[0];parent=multiplier_index[((),mb[1:])]
                assert parent<mi
            else: variable=4294967295;parent=-1
            for equation in range(len(rows)):
                source_row=parent*len(rows)+equation if parent>=0 else -1
                predecessor_data.extend(struct.pack('<iI',source_row,variable))
        for variable in range(q):
            for mv,mb in columns:
                target=index.get((mv,tuple(sorted(mb+(variable,)))),-1)
                predecessor_data.extend(struct.pack('<i',target))
        for variable in range(q):
            for mv,mb in multipliers:
                target=multiplier_index.get((mv,tuple(sorted(mb+(variable,)))),-1)
                predecessor_data.extend(struct.pack('<i',target))
    identity=dict(schema=2,source_sha256=meta['source_sha256'],chart=int(chart),
        v_degree=int(v_degree),b_degree=int(b_degree),columns=len(columns),rows=len(rows)*len(multipliers),
        pure_b_start=pure_start,engine_sha256=hashlib.sha256(CPP_GENERAL.encode()).hexdigest(),
        predecessor_reuse=bool(predecessor_reuse),checkpoint_format=2 if predecessor_reuse else 1,
        predecessor_metadata_sha256=hashlib.sha256(predecessor_data).hexdigest() if predecessor_reuse else None)
    manifest=out/'matrix.json'
    if manifest.exists():
        old=json.loads(manifest.read_text())
        assert all(old.get(key)==val for key,val in identity.items() if key!='engine_sha256'), 'Incompatible input checkpoint; use a new directory'
        compatible_engines = {identity['engine_sha256'],
            'e809c9cff1d70b37683ddff94ad5ebd9ffbcef4cdb38c7aeb55152d299b42e16'}
        assert old.get('engine_sha256') in compatible_engines, 'Unvalidated engine checkpoint; use a new directory'
        assert hashlib.sha256(matrixfile.read_bytes()).hexdigest()==old['matrix_sha256']
        if predecessor_reuse: assert predecessor_file.read_bytes()==predecessor_data
    else:
        assert not matrixfile.exists(), 'Unidentified old matrix; use a new output directory'
        with matrixfile.open('wb') as stream:
            stream.write(struct.pack('<II',len(rows)*len(multipliers),len(columns)))
            for mv,mb in multipliers:
                for row in raw:
                    indices=array.array('I');values=bytearray()
                    for (rv,rb),c in row:
                        indices.append(index[(tuple(sorted(rv+mv)),tuple(sorted(rb+mb)))]);values.append(c)
                    stream.write(struct.pack('<I',len(indices)));stream.write(indices.tobytes());stream.write(values)
        Path(str(matrixfile)+'.degrees').write_bytes(bytes(len(b) for v,b in columns))
        if predecessor_reuse: predecessor_file.write_bytes(predecessor_data)
        identity['matrix_sha256']=hashlib.sha256(matrixfile.read_bytes()).hexdigest()
        manifest.write_text(json.dumps(identity,indent=2,default=int)+'\n')
    cpp=out/'eliminate.cpp';cpp.write_text(CPP_GENERAL);binary=out/'eliminate'
    subprocess.run(['c++','-O3','-std=c++17','-pthread',str(cpp),'-o',str(binary)],check=True,capture_output=True)
    # This example has no b-only module certificate, but admits mixed ones:
    # f1 + v1*f2 - (1+b*v1)*f3 = 1. Verify the native reconstruction too.
    testP=PolynomialRing(k,names=['v1','v2','b']);v1,v2,tb=testP.gens()
    testrows=[v2-tb*v1,tb*v2,v2-1]
    testmultipliers=[testP.one(),tb,v1,v2,v1*tb,v2*tb]
    expanded=[m*f for m in testmultipliers for f in testrows]
    testmons=sorted(set(ex for f in expanded for ex in f.dict()),
                    key=lambda ex:(-sum(ex),ex))
    assert tuple(testmons[-1])==(0,0,0)
    testindex={ex:i for i,ex in enumerate(testmons)}
    with (out/'mixed-selftest.bin').open('wb') as stream:
        stream.write(struct.pack('<II',len(expanded),len(testmons)))
        for f in expanded:
            terms=list(f.dict().items());stream.write(struct.pack('<I',len(terms)))
            stream.write(array.array('I',[testindex[ex] for ex,c in terms]).tobytes())
            stream.write(bytes(enc(c) for ex,c in terms))
    selftest=subprocess.run([str(binary),str(out/'mixed-selftest.bin'),str(out/'mixed-selftest.dag'),
        str(out/'mixed-selftest.weights'),'2','33554432'],text=True,capture_output=True,check=True,timeout=5)
    assert json.loads(selftest.stdout)['status']=='unit_found'
    testweights=(out/'mixed-selftest.weights').read_bytes()
    assert sum(((k(c%5)+a*(c//5))*f for c,f in zip(testweights,expanded)),testP.zero())==1
    preparation=time.monotonic()-began
    print('chart',chart,'prepared',len(rows)*len(multipliers),'x',len(columns),'in',preparation,flush=True)
    remaining=max(0.1,float(seconds)-preparation)
    checkpoint=out/'state.cp'
    run_id=uuid.uuid4().hex
    logpath=str(out/'operations.jsonl') if interval_log else ''
    context=dict(schema=1,backend='native_pencil',arithmetic_domain='native_F25',field_degree_F5=2,
        representative=representative,chart=int(chart),source=str(source),source_sha256=meta['source_sha256'],
        input_hash=json.loads(manifest.read_text())['matrix_sha256'],multiplier_bidegree_bound=[int(v_degree),int(b_degree)],
        method='predecessor_reuse' if predecessor_reuse else 'raw_macaulay',
        native_threads=int(threads), requested_batch_rows=int(batch_rows),
        running_engine_sha256=identity['engine_sha256'])
    (out/'run_context.json').write_text(json.dumps(dict(context,run_id=run_id),indent=2,default=int)+'\n')
    native=subprocess.run([str(binary),str(matrixfile),str(out/'provenance.bin'),str(out/'weights.bin'),
        str(remaining),str(int(memory_gib*1024**3)),str(checkpoint),str(pure_start),
        str(checkpoint_seconds),str(max_rows),str(extract_node),logpath,run_id,json.dumps(context,default=int),
        str(predecessor_file) if predecessor_reuse else '',str(threads),str(batch_rows)],text=True,capture_output=True,
        timeout=remaining+180,check=True)
    status=json.loads(native.stdout)
    status.update(chart=int(chart),source_sha256=meta['source_sha256'],preparation_seconds=preparation,
        multiplier_bidegree_bound=[int(v_degree),int(b_degree)],mixed_only_counterexample_identity_verified=True,
        exhaustive_F25_arithmetic_checked=True,exhaustive15625_axpy_checks_passed=True,checkpoint=str(checkpoint),
        run_id=run_id,operations_log=logpath or None,
        requested_native_threads=int(threads),running_engine_sha256=identity['engine_sha256'],
        predecessor_reuse=bool(predecessor_reuse),checkpoint_format=2 if predecessor_reuse else 1,
        representative=representative,source=str(source),input_field_description=description,
        native_field_generator_image=str(fieldgen),
        scope='Selected F25 representative and rooted chart only; bounded ansatz, no whole-oper conclusion')
    def read_relation(stream):
        node,count=struct.unpack('<II',stream.read(8));ci=struct.unpack('<'+'I'*count,stream.read(4*count));cv=stream.read(count)
        relation=P.zero()
        for col,code in zip(ci,cv):
            mv,mb=columns[col]
            relation+=(k(code%5)+a*(code//5))*prod(vv[i] for i in mv)*prod(P.gen(32+i) for i in mb)
        return node,relation
    relations=[]
    with Path(str(checkpoint)+'.pure_b.bin').open('rb') as stream:
        number=struct.unpack('<I',stream.read(4))[0]
        for _ in range(number):
            node,relation=read_relation(stream)
            assert all(sum(ex[:32])==0 for ex in relation.dict())
            relations.append(dict(provenance_node=node,polynomial=str(relation),degree=int(relation.total_degree())))
        assert stream.read()==b''
    relation_record=dict(source_sha256=meta['source_sha256'],multiplier_bidegree_bound=[int(v_degree),int(b_degree)],
        relations=relations,provenance=str(out/'provenance.bin'),checkpoint=str(checkpoint),
        provenance_format='polynomial_sources_v2' if predecessor_reuse else 'scalar_sources_v1',
        note='Every basis relation retains its exact elimination DAG node. The selected expanded certificate is independently verified below.')
    (out/'pure_b_relations.json').write_text(json.dumps(relation_record,indent=2,default=int)+'\n')
    if (out/'weights.bin').exists() and (status['pure_b_relations']>0 or extract_node>=0):
        with (out/'weights.bin.relation').open('rb') as stream:
            selected_node,selected_relation=read_relation(stream)
        weights=(out/'weights.bin').read_bytes();assert len(weights)==len(rows)*len(multipliers)
        reduced_weights=[P.zero() for _ in rows]
        for h,code in enumerate(weights):
            if not code:continue
            mv,mb=multipliers[h//len(rows)]
            mon=prod(vv[i] for i in mv)*prod(P.gen(32+i) for i in mb)
            reduced_weights[h%len(rows)]+=(k(code%5)+a*(code//5))*mon
        assert sum((c*f for c,f in zip(reduced_weights,rows)),P.zero())==selected_relation
        ow=vector(P,reduced_weights)*C.change_ring(P)
        assert sum((c*f for c,f in zip(ow,original)),P.zero())==selected_relation
        assert all(sum(ex[:32])<=v_degree and sum(ex[32:])<=b_degree for f in ow for ex in f.dict())
        status.update(original_equation_order=meta['original_low_equation_order'],selected_relation=str(selected_relation),
            selected_provenance_node=selected_node,polynomial_multipliers=[str(f) for f in ow],
            identity_sum_original_rows_times_multipliers_equals_selected_relation_verified=True)
        if selected_relation==1:
            status.update(status='verified_polynomial_certificate',identity_sum_original_rows_times_multipliers_equals_one_verified=True)
    status['elapsed_seconds']=time.monotonic()-began
    (out/'result.json').write_text(json.dumps(status,indent=2,default=int)+'\n')
    print(json.dumps({key:val for key,val in status.items() if key!='polynomial_multipliers'},indent=2,default=int),flush=True)
    return status

if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--chart',type=int,required=True);ap.add_argument('--output',required=True)
    ap.add_argument('--seconds',type=float,default=120);ap.add_argument('--memory-gib',type=float,default=2)
    ap.add_argument('--v-degree',type=int,default=1);ap.add_argument('--b-degree',type=int,default=1)
    ap.add_argument('--checkpoint-seconds',type=float,default=30)
    ap.add_argument('--max-rows',type=int,default=4294967295,help='Completed rows this invocation, for restart tests')
    ap.add_argument('--extract-node',type=int,default=-1,help='Expand a saved provenance node; combine with --max-rows 0')
    ap.add_argument('--no-interval-log',action='store_true',help='Disable append-only interval telemetry')
    ap.add_argument('--predecessor-reuse',action='store_true',help='For A=0, translate the earlier reduced predecessor instead of reloading each raw multiple')
    ap.add_argument('--tensor',type=Path,help='Exact F25 tensor JSON (larger fields are explicitly rejected)')
    ap.add_argument('--atlas-input',type=Path,help='Rooted export directory containing chart-XX/metadata.json and initial_rref.json')
    ap.add_argument('--representative',help='Representative ID recorded in results and telemetry')
    ap.add_argument('--threads',type=int,default=1,help='Native prefix-reduction workers')
    ap.add_argument('--batch-rows',type=int,default=0,help='Rows prefetched per batch;0 uses native thread-dependent default')
    args=ap.parse_args();run(args.chart,args.output,args.seconds,args.memory_gib,args.v_degree,args.b_degree,
        args.checkpoint_seconds,args.max_rows,args.extract_node,not args.no_interval_log,args.predecessor_reuse,
        args.tensor,args.atlas_input,args.representative,args.threads,args.batch_rows)
