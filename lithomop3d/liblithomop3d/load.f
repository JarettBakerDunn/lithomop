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
      subroutine load(id,ibond,bond,d,deld,b,histry,deltp,numnp,
     & neq,nhist,nstep,lastep,ierr,errstrng)
c
c...program to transfer nodal boundary conditions into appropriate
c   vectors:
c
c        b(neq) = global right-hand side vector (applied forces)
c        d(ndof,numnp) = global displacements (fixed or zero
c                        displacements)
c        deld(ndof,numnp)= changes in displacement (constant velocity)
c        histry(nhist,lastep+1) = load history factor
c
      include "implicit.inc"
c
c...  parameter definitions
c
      include "ndimens.inc"
      include "nconsts.inc"
      include "rconsts.inc"
c
c...  subroutine arguments
c
      integer numnp,neq,nhist,nstep,lastep,ierr
      integer id(ndof,numnp),ibond(ndof,numnp)
      character errstrng*(*)
      double precision bond(ndof,numnp),b(neq),d(ndof,numnp)
      double precision deld(ndof,numnp),histry(nhist,lastep+1),deltp
c
c...  local variables
c
      integer i,j,imode,ihist,itype,k
c
cdebug      write(6,*) "Hello from load_f!"
c
      do i=1,ndof
        do j=1,numnp
          imode=ibond(i,j)
          ihist=imode/10
          itype=imode-10*ihist
cdebug          write(6,"(3i7)") imode,ihist,itype
          if((ihist.gt.nhist).or.(ihist.lt.izero)) then
            ierr=100
            errstrng="load"
            return
          end if
c
c...specified displacment, condition 1
c
          if(itype.eq.ione) then
            if(nstep.eq.izero) then
              d(i,j)=bond(i,j)
              if(ihist.ne.izero) d(i,j)=bond(i,j)*histry(ihist,1)
            else if(nstep.ge.ione) then
              if(ihist.ne.izero) deld(i,j)=bond(i,j)*
     &         (histry(ihist,nstep+1)-histry(ihist,nstep))
            end if
c
c...specified velocity, condition 2
c
          else if(itype.eq.itwo) then
            if(nstep.eq.izero) then
              d(i,j)=zero
            else
              deld(i,j)=deltp*bond(i,j)
              if(ihist.ne.izero) deld(i,j)=deld(i,j)*
     &         histry(ihist,nstep+1)
            end if
c
c...applied force, condition 3
c
          else if(itype.eq.ithree) then
            k=id(i,j)
            if(nstep.eq.izero) then
              b(k)=bond(i,j)
              if(ihist.ne.izero) b(k)=bond(i,j)*histry(ihist,1)
            else if(nstep.ge.ione) then
              if(ihist.ne.izero) b(k)=bond(i,j)*(histry(ihist,nstep+1)
     &                                 -histry(ihist,nstep))
            end if
          end if
        end do
      end do
      return
1000  format(//' fatal boundary condition error!'//
     & ' attempt to use undefined load history # ',i5,
     & ' for boundary condition of type ',i1,' at node ',i7)
      end
c
c version
c $Id: load.f,v 1.3 2004/08/12 01:51:31 willic3 Exp $
c
c Generated automatically by Fortran77Mill on Wed May 21 14:15:03 2003
c
c End of file 
