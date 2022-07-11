
rm -f ./perf.data
perf record -F 99 ./sched 1000 100
perf report -n --stdio
perf script | ./stackcollapse-perf.pl > out.perf-folded && ./flamegraph.pl out.perf-folded > perf.svg
