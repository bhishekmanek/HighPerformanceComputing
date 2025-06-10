program Hello

!implicit none

use mpi

integer ierr, myid, numprocs

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
!print*,"rank, MPI ierr, MPI_SUCCESS",myid,ierr,MPI_SUCCESS
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

print*, 'Hello world from processor',myid, "out of ",numprocs

call MPI_FINALIZE(ierr)

end program Hello
