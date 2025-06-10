program ring

use mpi

integer count, numprocs, buffer, ierr, myid, choice, i
integer right, left, summ, tag, stat(MPI_STATUS_SIZE)
integer request
!real*8

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

summ = 0
buffer = 10
choice = 1
do i = 1,numprocs,1

if (choice .eq. 1) then
if (myid .eq. 0) then
right = 1
left = numprocs - 1
elseif (myid .eq. numprocs-1) then
right = 0
left = myid-1
else
right = myid+1
left = myid-1
endif

call MPI_ISEND(buffer,count,MPI_INTEGER,right,tag,MPI_COMM_WORLD,request,ierr)
call MPI_IRECV(buffer,count,MPI_INTEGER,left,tag,MPI_COMM_WORLD,request,ierr)
call MPI_WAIT(request,stat,ierr)
summ = summ + buffer
!buffer = summ
endif
enddo

print*,'Processor number',myid,'Sum value',summ

call MPI_FINALIZE(ierr)

end program ring
