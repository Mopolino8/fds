! Lorenz ' 96 system

module Lorenz96

    ! system parameters:
    integer, parameter :: D = 36
    real(kind=8), parameter :: M = 10.d0
contains

subroutine f(X,dXdt)

        
    implicit none
	real(kind=8), intent(in), dimension(D) :: X
	real(kind=8), intent(out), dimension(D) :: dXdt
	integer :: i
	do i=3,D-1
		dXdt(i) = (-X(i-2) + X(i+1))*X(i-1) - X(i) + M	
	end do
	dXdt(1) = (-X(D-1) + X(2))*X(D) - X(1) + M
  	dXdt(2) = (-X(D) + X(3))*X(1) - X(2) + M
	dXdt(D) = (-X(D-2) + X(1))*X(D-1) - X(D) + M
end subroutine f

subroutine dfdX(X,dfdX_res)

	implicit none
	real(kind=8), intent(in), dimension(D) :: X
	real(kind=8), intent(out), dimension(D,D) :: dfdX_res 	
	integer :: i
	dfdX_res = 0.d0
	do i=3,D-1
			
		dfdX_res(i,i) = -1.d0
		dfdX_res(i,i-1) = -X(i-2) + X(i+1)
		dfdX_res(i,i+1) = X(i-1)
		dfdX_res(i,i-2) = -X(i-1)  					

	enddo		
	dfdX_res(1,D) = X(2) - X(D-1)
	dfdX_res(1,D-1) = -X(D)
	dfdX_res(1,1) = -1.d0
	dfdX_res(1,2) = X(D)
	
	    		
	dfdX_res(2,1) = X(3) - X(D)
	dfdX_res(2,D) = -X(1)
	dfdX_res(2,2) = -1.d0
	dfdX_res(2,3) = X(1)
	
	dfdX_res(D,D-1) = X(1) - X(D-2)
	dfdX_res(D,D-2) = -X(D-1)
	dfdX_res(D,D) = -1.d0
	dfdX_res(D,1) = X(D-1)

end subroutine dfdX   

end module Lorenz96
