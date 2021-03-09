#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int count_cpu_cores() {
    FILE *fp;
    char path[100];
    int n_cores;

    fp = popen("nproc", "r");
    if (fp == NULL) {
        return -1;
    }
    fscanf(fp, "%d", &n_cores);
    return n_cores;

}

int main(void) {
    float a[4], b[4], loadavg;
    FILE *fp;
    char msg[512];

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &a[0], &a[1], &a[2], &a[3]);
    fclose(fp);

    usleep(800000);

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &b[0], &b[1], &b[2], &b[3]);
    fclose(fp);
    
    loadavg = (b[0] + b[1] + b[2]        - a[0] - a[1] - a[2]       ) / 
              (b[0] + b[1] + b[2] + b[3] - a[0] - a[1] - a[2] - a[3]);

    DIR       *d;
    struct    dirent *dir;
    int       n_cpu = 0;
    //int const n_cpu_max = 64;
    int       f_cpu = 0, f_cpu_max = 0;
    char      dir_path[] = "/sys/devices/system/cpu/cpufreq/";
    char      cpu_path[256];
    d = opendir(dir_path);
    if(d) {
        while((dir = readdir(d)) != NULL) {
            if(dir->d_type == DT_DIR && !strncmp(dir->d_name, "policy", 6)) {
                FILE *f;

                sprintf(cpu_path, "%s%s/scaling_cur_freq", dir_path, dir->d_name);
                f = fopen(cpu_path, "r");
                if(f) {
                    int tmpf;
                    fscanf(f, "%d", &tmpf);
                    f_cpu = tmpf > f_cpu ? tmpf : f_cpu;
                    fclose(f);
                }
                
                sprintf(cpu_path, "%s%s/scaling_max_freq", dir_path, dir->d_name);
                f = fopen(cpu_path, "r");
                if(f) {
                    int tmpf;
                    fscanf(f, "%d", &tmpf);
                    f_cpu_max = tmpf > f_cpu ? tmpf : f_cpu_max;
                    fclose(f);
                }
                
                ++n_cpu;
            }
        }
        FILE *fp = fopen("/sys/devices/system/cpu/intel_pstate/max_perf_pct","r");
        if(n_cpu > 0 && fp) {
            int max_pct;
            fscanf(fp, "%d", &max_pct);
            fclose(fp);
            printf("%3.1f%% %3.1f/%3.1f\n", loadavg * 100.0 * n_cpu, (float)(f_cpu / 1000000.0f), (float)(f_cpu_max / 100000000.0f * max_pct));
            printf("%3.1f%% %3.1f/%3.1f\n", loadavg * 100.0 * n_cpu, (float)(f_cpu / 1000000.0f), (float)(f_cpu_max / 100000000.0f * max_pct));
        } else {
            printf("%3.1f%%\n", loadavg * 100.0f);
            printf("%3.1f%%\n", loadavg * 100.0f);
        }
        if(loadavg > 0.95) {
            return 33;
        } else if(loadavg > 0.5) {
            printf("#FFFC00\n");
        }
    }

    return 0;
}
