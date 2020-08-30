*&---------------------------------------------------------------------*
*& Report ZKRAM_UI5_TRANSLATE_TEXTS
*&---------------------------------------------------------------------*
REPORT zkram_ui5_translate_texts.

INITIALIZATION.

CLASS lcl_kram_ui5_translate_texts DEFINITION CREATE PRIVATE FINAL.

  PUBLIC SECTION.

    CLASS-METHODS run.

ENDCLASS.

CLASS lcl_kram_ui5_translate_texts IMPLEMENTATION.

  METHOD run.

    TRY.
        zcl_kram_base_gui_servive=>zif_kram_base_gui_transactions~call_transaction_02(
          EXPORTING
            iv_transaction_code     = 'SE63'
            it_batch_input          = VALUE #( ( program  = 'SAPMTRAN'
                                                 dynpro   = '1000'
                                                 dynbegin = zcl_kram_base_constants=>true )
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '1000'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-ok_code
                                                 fval     = 'S' ) " short texts
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>true )
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-cursor
                                                 fval     = '02/04' ) " meta objects
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-ok_code
                                                 fval     = 'TRSL' )
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>true )
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-cursor
                                                 fval     = '14/15' ) " tables (meta)
                                               ( program  = 'SAPMSSY0'
                                                 dynpro   = '0120'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-ok_code
                                                 fval     = 'TRSL' )
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '2000'
                                                 dynbegin = zcl_kram_base_constants=>true )
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '2000'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = 'DYNP_2000-OBJNAME_PART1' " object name
                                                 fval     = 'WDY_CONF_USERT2' )
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '2000'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = 'DYNP_2000-SLANG' " source language
                                                 fval     = 'enUS' ) " English
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '2000'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = 'DYNP_2000-TLANG' " target language
                                                 fval     = 'deDE' ) " German
                                               ( program  = 'SAPMTRAN'
                                                 dynpro   = '2000'
                                                 dynbegin = zcl_kram_base_constants=>false
                                                 fnam     = zcl_kram_base_gui_constants=>batch_input_identifiers-ok_code
                                                 fval     = 'TORS' ) ) ).
      CATCH zcx_kram_base_gui INTO DATA(lx_kram_base_gui).
        MESSAGE lx_kram_base_gui->get_text( ) TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

**********************************************************************

START-OF-SELECTION.

  lcl_kram_ui5_translate_texts=>run( ).
