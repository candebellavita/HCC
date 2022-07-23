PROGRAM PRUEBA
USE iso_fortran_env, ONLY : WP => REAL64
USE sco_global
USE sco_arrays
IMPLICIT NONE
    INTEGER, PARAMETER :: mesh_size1 = 299
    REAL(WP) :: disk_size, corona_size, Tcorona, Tdisk, tau, QPO_frequency, DHext, eta_frac
    REAL(WP) :: Tsss(mesh_size+4), Ssss(mesh_size+4), Treal(mesh_size+4), Sreal(mesh_size+4)
    REAL(WP) :: Timag(mesh_size+4), Simag(mesh_size+4)
    REAL(WP), ALLOCATABLE :: bandwidth(:,:), fracrms(:), plag_scaled(:), SSS_band(:),Re_band(:), Im_band(:)
    INTEGER :: Nsss, Nreal, Nimag, io, rows, dim_int



    disk_size = 10.
    corona_size = 7.
    Tcorona = 6.
    Tdisk = 0.7
    tau = 4.
    QPO_frequency = 400.
    DHext = 0.05
    eta_frac = 0.4

    ! OPEN(UNIT=10, FILE='FG_data.txt')
    ! rows=0
    ! DO
    !   READ(10,*,iostat=io)
    !   IF (io.lt.0) EXIT
    !   rows = rows + 1
    ! END DO
    !
    ! ALLOCATE(bandwidth(rows-3,rows-3),fracrms(rows-3), plag_scaled(rows-3), SSS_band(rows-3),Re_band(rows-3), Im_band(rows-3))
    ! close(10)
    ! OPEN(UNIT=10, FILE='FG_data.txt')
!    READ(10,*)
! Falta el disk_size, sobra exptime, nh, norm
!    write(10, *) QPO_frequency, EXPTIME, DHext, Tcorona, corona_size, eta_frac, tau, Tdisk, NH, NORM
!    READ(10,*)
    ! DO I= 4, rows
    !   READ(10, *) bandwidth(i-3,1), bandwidth(i-3,2)
    ! ENDDO
    ! CLOSE(10)
    ! rows=rows-3
    ! dim_int =mesh_size-4

!    CALL sco_MODEL_LOGSSS(disk_size, corona_size, Tcorona, Tdisk, tau, QPO_frequency, DHext, eta_frac, Nsss, Ssss,Tsss, &
!      Nreal, Sreal, Treal, Nimag,Simag, Timag)

    CALL sco_MODEL(disk_size, corona_size, Tcorona, Tdisk, tau, QPO_frequency, DHext, eta_frac, Nsss, Ssss,Tsss, &
      Nreal, Sreal, Treal, Nimag,Simag, Timag)
    OPEN(UNIT=10, FILE='FG_data.txt')
    rows=0
    DO
      READ(10,*,iostat=io)
      IF (io.lt.0) EXIT
      rows = rows + 1
    END DO

    ALLOCATE(bandwidth(rows-3,rows-3),fracrms(rows-3), plag_scaled(rows-3), SSS_band(rows-3),Re_band(rows-3), Im_band(rows-3))
    close(10)
    OPEN(UNIT=10, FILE='FG_data.txt')
    DO I=1,3
      READ(10,*)
    ENDDO
    DO I= 4, rows
      READ(10, *) bandwidth(i-3,1), bandwidth(i-3,2)
    ENDDO
    CLOSE(10)
    rows=rows-3
    dim_int =mesh_size-4

    CALL sco_band_integrated_amplitude(rows,bandwidth,dim_int, Nsss, Tsss, Ssss, Nreal, Treal, Sreal, Nimag, Timag, Simag, &
        fracrms, plag_scaled, SSS_band,Re_band, Im_band)
    OPEN(UNIT=11, FILE= 'outputLIN.dat')
    WRITE(11,*) '#  ', 'fractional rms ', ' phase lag ', ' SSS band ', ' Real band ', ' Imag band'
    DO I=1, ROWS
      WRITE(11,*) fracrms(I), plag_scaled(I), SSS_band(I), Re_band(I), Im_band(I)
    ENDDO
    CLOSE(11)
END PROGRAM
