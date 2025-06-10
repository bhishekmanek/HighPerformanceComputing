program pi

use mpi

integer ierr, myid, numprocs, home, count, seed1(8), values(1:8)
integer  home_summ, two, total_summ
real*8 r(2), rad, val_pi, summ, total
integer tag, request, stat(MPI_STATUS_SIZE)

call MPI_INIT(ierr)
call MPI_COMM_RANK(MPI_COMM_WORLD,myid,ierr)
call MPI_COMM_SIZE(MPI_COMM_WORLD,numprocs,ierr)

count = 1
total = 1000000
two = 2

do i=1,1000000,1

call date_and_time(values=values)
call random_seed(size=two)
seed1(:) = values(8)
call random_seed(put=seed1)
call random_number(r)

rad = sqrt((r(1)-0.5d0)**2 + (r(2)-0.5d0)**2)
if (rad .le. 0.5d0) then
summ = summ + 1
endif

enddo

val_pi = 4.0*(summ/total)

print*,'Value of pi',val_pi,'in processor no.',myid

call MPI_FINALIZE(ierr)

end program pi
