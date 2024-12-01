/*
https://gist.github.com/huzhifeng/d1cda3f0474261eda72b36ca83f24e21
*/
#include <mpi.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
    int world_rank, world_size;
    int name_len;
    char processor_name[MPI_MAX_PROCESSOR_NAME];

    /* MPI_Init(NULL, NULL); */
    MPI_Init(&argc, &argv); /* 程序初始化 */
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank); /* 得到当前进程号 */
    MPI_Comm_size(MPI_COMM_WORLD, &world_size); /* 得到总的进程数 */
    MPI_Get_processor_name(processor_name, &name_len); /* 得到机器名 */

    printf("MPI: Hello world from %s, rank %d out of %d\n", processor_name, world_rank, world_size);

    MPI_Finalize(); /* 结束 */

    return 0;
}
