close all; clear all;
f_m = fopen("data_out.txt", "r");
f_v = fopen("output.txt", "r");

m=fscanf(f_m,"%x");
v=fscanf(f_v,"%x");

s = m ~= v;
error = sum(s)
i = find(s==1);

fclose(f_m);
fclose(f_v);