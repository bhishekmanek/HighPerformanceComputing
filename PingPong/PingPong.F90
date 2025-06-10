program PingPong

use mpi

integer ierr, myid, numprocs, source, destination, buffer, count
integer tag, stat(MPI_STATUS_SIZE)

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

source = 0
destination =1
buffer = 1000923437
count = 1
length = numprocs

!do i=1,length,1
if (myid .eq. source) then
   call MPI_SEND(buffer,count,MPI_INTEGER,destination,tag,MPI_COMM_WORLD,ierr)
   print*,'Sending data value',buffer,'from source processor',myid
   call MPI_RECV(buffer,count,MPI_INTEGER,destination,tag,MPI_COMM_WORLD,stat,ierr)
!endif 
else
!if (myid .eq. destination) then
   call MPI_RECV(buffer,count,MPI_INTEGER,source,tag,MPI_COMM_WORLD,stat,ierr)
   print*,'Receiving data value',buffer,'at destination processor',myid
   call MPI_SEND(buffer,count,MPI_INTEGER,source,tag,MPI_COMM_WORLD,ierr)
endif
!enddo


call MPI_FINALIZE(ierr)

end program PingPong
