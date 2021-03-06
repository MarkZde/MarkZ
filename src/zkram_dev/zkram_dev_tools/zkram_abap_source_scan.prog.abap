*&---------------------------------------------------------------------*
*& Report ZKRAM_ABAP_SOURCE_SCAN
*&---------------------------------------------------------------------*
REPORT zkram_abap_source_scan.

INITIALIZATION.

CLASS lcl_kram_abap_source_scan DEFINITION CREATE PRIVATE FINAL.

  PUBLIC SECTION.

    CLASS-METHODS run.

ENDCLASS.

CLASS lcl_kram_abap_source_scan IMPLEMENTATION.

  METHOD run.

    TRY.
        zcl_kram_base_gui_servive=>zif_kram_base_gui_transaction~call_transaction_02(
          EXPORTING
            iv_transaction_code     = 'SA38'
            it_set_get_parameters   = VALUE #( ( parameter_id    = 'RID'
                                                 parameter_value = 'RS_ABAP_SOURCE_SCAN' ) )
            it_batch_input          = VALUE #( ( program  = 'SAPMS38M'
                                                 dynpro   = '0101'
                                                 dynbegin = zcl_kram_base_constants=>true
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-ok_code
                                                 fval     = 'STRT' ) ) ).
      CATCH zcx_kram_base_gui INTO DATA(lx_kram_base_gui).
        MESSAGE lx_kram_base_gui->get_text( ) TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

**********************************************************************

START-OF-SELECTION.

  lcl_kram_abap_source_scan=>run( ).
