#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(void)
{
    float a[4], b[4], loadavg;
    FILE *fp;
    char msg[512];

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &a[0], &a[1], &a[2], &a[3]);
    fclose(fp);

    sleep(1);

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &b[0], &b[1], &b[2], &b[3]);
    fclose(fp);
    
    loadavg = (b[0] + b[1] + b[2] - a[0] - a[1] - a[2]) / (b[0] + b[1] + b[2] + b[3] - a[0] - a[1] - a[2] - a[3]);

    int       n_cpu = 0;
    //int const n_cpu_max = 64;
    int       f_cpu = 0, f_cpu_max = 0;
    char      dir_path[] = "/sys/devices/system/cpu/";
    char      cpu_path[256];
    FILE*     f = NULL;

    while (1) {
        int tmpf = 0;

        sprintf(cpu_path, "%scpu%d/cpufreq/scaling_cur_freq", dir_path, n_cpu);
        f = fopen(cpu_path, "r");
        if (f == NULL) {
            break;
        }
        fscanf(f, "%d", &tmpf);
        f_cpu = tmpf > f_cpu ? tmpf : f_cpu;
        fclose(f);

        sprintf(cpu_path, "%scpu%d/cpufreq/scaling_max_freq", dir_path, n_cpu);
        f = fopen(cpu_path, "r");
        if (f == NULL) {
            break;
        }
        fscanf(f, "%d", &tmpf);
        f_cpu_max = tmpf > f_cpu_max ? tmpf : f_cpu_max;
        fclose(f);

        n_cpu++;
    }

    if (n_cpu > 0) {
        printf("%3.1f%% %3.1f/%3.1f\n", loadavg * 100.0 * n_cpu, (float)(f_cpu / 1.0e6), (float)(f_cpu_max / 1.0e6));
        printf("%3.1f%% %3.1f/%3.1f\n", loadavg * 100.0 * n_cpu, (float)(f_cpu / 1.0e6), (float)(f_cpu_max / 1.0e6));
    } else {
        printf("%3.1f%%\n", loadavg * 100.0);
        printf("%3.1f%%\n", loadavg * 100.0);
    }
    if (loadavg > 0.95) {
        return 33;
    } else if(loadavg > 0.5) {
        printf("#FFFC00\n");
    }

    return 0;
}
