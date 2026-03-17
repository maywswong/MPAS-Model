! Copyright (c) 2016,  Los Alamos National Security, LLC (LANS)
! and the University Corporation for Atmospheric Research (UCAR).
!
! Unless noted otherwise source code is licensed under the BSD license.
! Additional copyright and license information can be found in the LICENSE file
! distributed with this code, or at http://mpas-dev.github.com/license.html
!
module mpas_atm_mask

 use mpas_derived_types
 use mpas_pool_routines
 use mpas_kind_types
 use mpas_dmpar
 use mpas_constants   
 use mpas_log, only : mpas_log_write

 contains

!==================================================================================================
 subroutine atm_retrieve_masked_region(configs, structs )
!==================================================================================================
      ! 2025/7/8
      ! Test code to apply user-specified mask region from inputs stream 
      !
      implicit none

      type (mpas_pool_type), intent(in) :: configs
      type (mpas_pool_type), intent(inout) :: structs

      type (mpas_pool_type), pointer :: mask_input 
      type (mpas_pool_type), pointer :: mesh
      
      integer :: i
      integer, pointer :: nCellsSolve, nEdgesSolve, nVerticesSolve
      
      integer, dimension(:), pointer :: nudgeMaskCell, nudgeMaskEdge, nudgeMaskVertex 
      integer, dimension(:), pointer :: testMaskCell 


      call mpas_pool_get_subpool(structs, 'mask_input', mask_input)
      call mpas_pool_get_subpool(structs, 'mesh', mesh)

      call mpas_pool_get_dimension(mesh, 'nCellsSolve', nCellsSolve)
      call mpas_pool_get_dimension(mesh, 'nEdgesSolve', nEdgesSolve)
      call mpas_pool_get_dimension(mesh, 'nVerticesSolve', nVerticesSolve)
      
      call mpas_pool_get_array(mask_input, 'nudgeMaskCell',   nudgeMaskCell)
      call mpas_pool_get_array(mask_input, 'nudgeMaskEdge',   nudgeMaskEdge)
      call mpas_pool_get_array(mask_input, 'nudgeMaskVertex',   nudgeMaskVertex)
      call mpas_pool_get_array(mask_input, 'testMaskCell',   testMaskCell)

      do i = 1, nCellsSolve
          testMaskCell(i) = nudgeMaskCell(i)
      end do
 
      
 end subroutine atm_retrieve_masked_region 
 !==================================================================================================

end module mpas_atm_mask
