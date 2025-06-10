program game_of_life

integer :: A(4,4)
real*8 r(16)
integer :: values(1:8), total_num, i, j, nsize 
integer seed(8),s(16)

nsize=4
total_num = nsize**2

call date_and_time(values=values)
call random_seed(size=total_num)
total_num = 16
seed(:) = values(8)
call random_seed(put=seed)
call random_number(r)

do i=1,total_num,1
if (r(i) .le. 0.3) then
s(i) = 0
else
s(i) = 1
endif
enddo

A = RESHAPE(s, (/nsize, nsize/))

print*,'The matrix is'
do i=1,nsize,1
print*,(A(i,j),j=1,nsize,1)
enddo

end program game_of_life
