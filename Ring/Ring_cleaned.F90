program Ring

USE mpi

  IMPLICIT NONE

  INTEGER, PARAMETER :: to_right=201

  INTEGER :: ierror, my_rank, size

  INTEGER :: right, left

  INTEGER :: i, sum

  INTEGER :: snd_buf
  INTEGER :: rcv_buf

  INTEGER :: status(MPI_STATUS_SIZE)

  INTEGER :: request

  INTEGER(KIND=MPI_ADDRESS_KIND) :: iadummy


  CALL MPI_INIT(ierror)

  CALL MPI_COMM_RANK(MPI_COMM_WORLD, my_rank, ierror)
  CALL MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)

  right = mod(my_rank+1,      size)
  left  = mod(my_rank-1+size, size)

!     ... this SPMD-style neighbor computation with modulo has the same
!     meaning as:
!     right = my_rank + 1
!     IF (right .EQ. size) right = 0
!     left = my_rank - 1
!     IF (left .EQ. -1) left = size-1

  sum = 0
  snd_buf = 10

  DO i = 1, size

     CALL MPI_ISSEND(snd_buf, 1, MPI_INTEGER, right, to_right, MPI_COMM_WORLD, request, ierror)

     CALL MPI_RECV(rcv_buf, 1, MPI_INTEGER, left, to_right, MPI_COMM_WORLD, status, ierror)

     CALL MPI_WAIT(request, status, ierror)

!     CALL MPI_GET_ADDRESS(snd_buf, iadummy, ierror)
!    ... or with MPI-3.0 and later:
!    IF (.NOT.MPI_ASYNC_PROTECTS_NONBLOCKING) CALL
!    MPI_F_sync_reg(snd_buf)

     snd_buf = rcv_buf
     sum = sum + rcv_buf

  END DO

  WRITE(*,*) "PE", my_rank, ": Sum =", sum

  CALL MPI_FINALIZE(ierror)

END PROGRAM
