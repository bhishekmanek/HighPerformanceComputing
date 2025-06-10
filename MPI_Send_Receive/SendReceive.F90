program Send_Receive

use mpi

integer ierr, myid, numprocs, source, destination, buffer, count
integer tag, stat(MPI_STATUS_SIZE)

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

source = 0
destination =1
buffer = 137
count = 1

if (myid .eq. source) then
   call MPI_SEND(buffer,count,MPI_INTEGER,destination,tag,MPI_COMM_WORLD,ierr)
   print*,'Sending data value',buffer,'from source processor',myid
endif 

if (myid .eq. destination) then
   call MPI_RECV(buffer,count,MPI_INTEGER,source,tag,MPI_COMM_WORLD,stat,ierr)
   print*,'Receiving data value',buffer,'at destination processor',myid
endif

call MPI_FINALIZE(ierr)

end program Send_Receive
