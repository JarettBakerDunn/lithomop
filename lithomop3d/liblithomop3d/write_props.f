c -*- Fortran -*-
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c                             Charles A. Williams
c                       Rensselaer Polytechnic Institute
c                        (C) 2004  All Rights Reserved
c
c  Copyright 2004 Rensselaer Polytechnic Institute.
c  All worldwide rights reserved.  A license to use, copy, modify and
c  distribute this software for non-commercial research purposes only
c  is hereby granted, provided that this copyright notice and
c  accompanying disclaimer is not modified or removed from the software.
c
c  DISCLAIMER:  The software is distributed "AS IS" without any express
c  or implied warranty, including but not limited to, any implied
c  warranties of merchantability or fitness for a particular purpose
c  or any warranty of non-infringement of any current or pending patent
c  rights.  The authors of the software make no representations about
c  the suitability of this software for any particular purpose.  The
c  entire risk as to the quality and performance of the software is with
c  the user.  Should the software prove defective, the user assumes the
c  cost of all necessary servicing, repair or correction.  In
c  particular, neither Rensselaer Polytechnic Institute, nor the authors
c  of the software are liable for any indirect, special, consequential,
c  or incidental damages related to the software, to the maximum extent
c  the law permits.
c
c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
c
c
      subroutine write_props(prop,infmat,infmatmod,numat,npropsz,idout,
     & idsk,kw,kp,ofile,pfile,ierr,errstrng)
c
c...  program to print properties for each material type.
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "materials.inc"
      include "nconsts.inc"
c
c...  subroutine arguments
c
      integer numat,npropsz,idout,idsk,kw,kp,ierr
      integer infmat(3,numat),infmatmod(5,nmatmodmax)
      double precision prop(npropsz)
      character ofile*(*),pfile*(*),errstrng*(*)
c
c...  external routines
c
      include "mat_prt_ext.inc"
c
c...  local variables
c
      integer imat,matmodel,indprop,nprop
c
cdebug      write(6,*) "Hello from write_props_f!"
c
      ierr=izero
c
c...  open output files and output number of materials
c
      if(idout.gt.izero) then
        open(kw,file=ofile,err=10,status="old",access="append")
        write(kw,1000,err=20) numat
      end if
      if(idsk.eq.izero) then
        open(kp,file=pfile,err=10,status="old",access="append")
        write(kp,"(i5)",err=20) numat
      end if
      if(idsk.eq.ione) then
        open(kp,file=pfile,err=10,status="old",access="append",
     &   form="unformatted")
        write(kp,err=20) numat
      end if
c
c...  loop over number of material types
c
      do imat=1,numat
        matmodel=infmat(1,imat)
        indprop=infmat(3,imat)
        nprop=infmatmod(3,matmodel)
        if(matmodel.eq.1) then
          call mat_prt_1(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.2) then
          call mat_prt_2(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.3) then
          call mat_prt_3(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.4) then
          call mat_prt_4(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.5) then
          call mat_prt_5(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.6) then
          call mat_prt_6(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.7) then
          call mat_prt_7(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.8) then
          call mat_prt_8(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.9) then
          call mat_prt_9(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.10) then
          call mat_prt_10(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.11) then
          call mat_prt_11(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.12) then
          call mat_prt_12(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.13) then
          call mat_prt_13(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.14) then
          call mat_prt_14(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.15) then
          call mat_prt_15(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.16) then
          call mat_prt_16(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.17) then
          call mat_prt_17(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.18) then
          call mat_prt_18(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.19) then
          call mat_prt_19(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        else if(matmodel.eq.20) then
          call mat_prt_20(prop(indprop),nprop,imat,idout,idsk,kw,kp,
     &     ierr,errstrng)
        end if
        if(ierr.ne.izero) return
      end do
c
c...  normal return
c
      if(idout.gt.izero) close(kw)
      close(kp)
      return
c
c...  error opening output file
c
 10   continue
        ierr=2
        errstrng="write_props"
        if(idout.gt.izero) close(kw)
        close(kp)
        return
c
c...  error writing to output file
c
 20   continue
        ierr=4
        errstrng="write_props"
        if(idout.gt.izero) close(kw)
        close(kp)
        return
c
 1000 format(1x,///,
     & " m a t e r i a l   s e t   d a t a                    ",//,5x,
     & " number of material sets . . . . . . . . . . (numat) =",i5)
c
      end
c
c version
c $Id: write_props.f,v 1.2 2004/07/13 16:26:48 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
