program PingPong

use mpi

real*8 t1,t2,tot_time,time, buffer
integer ierr, myid, numprocs, source, destination, count
integer i, j, tag, stat(MPI_STATUS_SIZE)
integer num

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

source = 0
destination =1
buffer = 1000.000283
time = 0.0
num = 1000000

count = 1

do i=1,num,1
if (myid .eq. source) then
   t1 = MPI_WTIME()
   call MPI_SEND(buffer,count,MPI_DOUBLE,destination,tag,MPI_COMM_WORLD,ierr)
   call MPI_RECV(buffer,count,MPI_DOUBLE,destination,tag,MPI_COMM_WORLD,stat,ierr)
   t2 = MPI_WTIME()
   tot_time = time + t2-t1

else
   call MPI_RECV(buffer,count,MPI_DOUBLE,source,tag,MPI_COMM_WORLD,stat,ierr)
   call MPI_SEND(buffer,count,MPI_DOUBLE,source,tag,MPI_COMM_WORLD,ierr)
endif
time = tot_time
enddo

if (myid .eq. source) then
print*,'Time taken for single message',tot_time/(2.0*num)
endif

call MPI_FINALIZE(ierr)

end program PingPong
