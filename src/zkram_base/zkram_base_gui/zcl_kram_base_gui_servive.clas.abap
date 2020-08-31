class ZCL_KRAM_BASE_GUI_SERVIVE definition
  public
  final
  create private .

public section.

  interfaces ZIF_KRAM_BASE_GUI_TRANSACTION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_KRAM_BASE_GUI_SERVIVE IMPLEMENTATION.


METHOD zif_kram_base_gui_transaction~call_transaction_01.

  CHECK iv_transaction_code IS NOT INITIAL.

  CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
    EXPORTING
      tcode                   = iv_transaction_code
      skip_screen             = iv_skip_first_screen_x
    TABLES
      spagpa_tab              = it_set_get_parameters
    EXCEPTIONS
      call_transaction_denied = 1
      tcode_invalid           = 2
      OTHERS                  = 8.
  CASE sy-subrc.
    WHEN 0.
      " ok
    WHEN 1.
      " no authorization for transaction code
      RAISE EXCEPTION NEW zcx_kram_base_gui( textid = VALUE #( msgid = zcl_kram_base_constants=>message_classes-base_gui
                                                               msgno = '001'
                                                               attr1 = iv_transaction_code ) ).
    WHEN 2.
      " transaction code is not valid
      RAISE EXCEPTION NEW zcx_kram_base_gui( textid = VALUE #( msgid = zcl_kram_base_constants=>message_classes-base_gui
                                                               msgno = '002'
                                                               attr1 = iv_transaction_code ) ).
    WHEN OTHERS.
      RAISE EXCEPTION NEW zcx_kram_base_gui( ).
  ENDCASE.

ENDMETHOD.


METHOD zif_kram_base_gui_transaction~call_transaction_02.

  CHECK iv_transaction_code IS NOT INITIAL.

  CHECK it_batch_input IS NOT INITIAL.

  CLEAR et_batch_input_messages.

  CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
    EXPORTING
      tcode                   = iv_transaction_code
      mode_val                = 'E' " display screens only in case of errors
    TABLES
      spagpa_tab              = it_set_get_parameters
      using_tab               = it_batch_input
      mess_tab                = et_batch_input_messages
    EXCEPTIONS
      call_transaction_denied = 1
      tcode_invalid           = 2
      OTHERS                  = 8.
  CASE sy-subrc.
    WHEN 0.
      " ok
    WHEN 1.
      " no authorization for transaction code
      RAISE EXCEPTION NEW zcx_kram_base_gui( textid = VALUE #( msgid = zcl_kram_base_constants=>message_classes-base_gui
                                                               msgno = '001'
                                                               attr1 = iv_transaction_code ) ).
    WHEN 2.
      " transaction code is not valid
      RAISE EXCEPTION NEW zcx_kram_base_gui( textid = VALUE #( msgid = zcl_kram_base_constants=>message_classes-base_gui
                                                               msgno = '002'
                                                               attr1 = iv_transaction_code ) ).
    WHEN OTHERS.
      RAISE EXCEPTION NEW zcx_kram_base_gui( ).
  ENDCASE.

ENDMETHOD.
ENDCLASS.
