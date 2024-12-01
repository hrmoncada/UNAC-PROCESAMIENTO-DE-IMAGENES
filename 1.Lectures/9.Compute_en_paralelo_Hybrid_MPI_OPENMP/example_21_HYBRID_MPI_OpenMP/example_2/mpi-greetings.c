#include <mpi.h>
#include <stdio.h>
#include <string.h>

#define MSG_LEN 128
#define MSG_TAG 99

int main(int argc, char *argv[])
{
    int world_rank = 0, world_size = 0, name_len = 0, i = 0;
    char processor_name[MPI_MAX_PROCESSOR_NAME] = { 0x0 };
    char msg[MSG_LEN] = { 0x0 };
    MPI_Status status;

    /* MPI_Init(NULL, NULL); */
    MPI_Init(&argc, &argv); /* 程序初始化 */
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank); /* 得到当前进程号 */
    MPI_Comm_size(MPI_COMM_WORLD, &world_size); /* 得到总的进程数 */
    MPI_Get_processor_name(processor_name, &name_len); /* 得到机器名 */

    if (world_rank != 0) {
        sprintf(msg, "MPI: Greetings from %s, rank %d out of %d", processor_name, world_rank, world_size);
        MPI_Send(msg, strlen(msg) + 1, MPI_CHAR, 0, MSG_TAG, MPI_COMM_WORLD);
    } else {
        printf("MPI: Greetings from %s, rank %d out of %d\n", processor_name, world_rank, world_size);
        for(i = 1; i < world_size; i++) {
            MPI_Recv(msg, MSG_LEN, MPI_CHAR, i, MSG_TAG, MPI_COMM_WORLD, &status);
            printf("%s\n", msg);
        }
    }

    MPI_Finalize(); /* 结束 */

    return 0;
}