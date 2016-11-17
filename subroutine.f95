subroutine routine()
    integer i
    external pyfunc
    i=1
    print*, "In ROUTINE"
    call pyfunc(i) ! This will be defined to raise a Python exception
    print*, "Called PYFUNC. Shouldn't be here!"
    return
end subroutine routine

subroutine routine2()
    integer i
    external pyfunc
    i=2
    print*, "In ROUTINE2"
    call pyfunc(i) ! This will be defined to raise a Python exception
    print*, "Called PYFUNC. Shouldn't be here!"
    return
end subroutine routine2