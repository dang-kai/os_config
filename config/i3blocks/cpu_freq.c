#include<stdio.h>
#include<stdlib.h>

int main(void)
{
    float a[4], b[4], loadavg;
    FILE *fp;

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &a[0], &a[1], &a[2], &a[3]);
    fclose(fp);

    sleep(1);

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &b[0], &b[1], &b[2], &b[3]);
    fclose(fp);
    
    loadavg = (b[0]+b[1]+b[2]-a[0]-a[1]-a[2])/(b[0]+b[1]+b[2]+b[3]-a[0]-a[1]-a[2]-a[3]);
    printf("%4.2f\%\n", loadavg*100.0);

    return 0;
}
