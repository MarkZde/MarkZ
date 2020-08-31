class ZCL_KRAM_COLLATZ_SEQUENCE definition
  public
  final
  create private .

public section.

  methods GET_SEQUENCE
    returning
      value(RT_COLLATZ_SEQUENCE) type ZKRAM_TT_INT8 .
  methods GET_SEQUENCE_LENGTH
    returning
      value(RV_SEQUENCE_LENGTH) type ZKRAM_INT8 .
  class-methods CREATE_INSTANCE
    importing
      !IV_STARTING_INTEGER type ZKRAM_INT8
    returning
      value(RO_INSTANCE) type ref to ZCL_KRAM_COLLATZ_SEQUENCE
    raising
      ZCX_KRAM_BASE_MATH .
protected section.
private section.

  data MT_COLLATZ_SEQUENCE type ZKRAM_TT_INT8 .

  methods CREATE_SEQUENCE
    importing
      !IV_STARTING_INTEGER type ZKRAM_INT8 .
  methods CONSTRUCTOR
    importing
      !IV_STARTING_INTEGER type ZKRAM_INT8 .
ENDCLASS.



CLASS ZCL_KRAM_COLLATZ_SEQUENCE IMPLEMENTATION.


METHOD constructor.

  create_sequence( iv_starting_integer ).

ENDMETHOD.


METHOD create_instance.

  IF NOT iv_starting_integer > 0.
    " the Collatz sequence starting value must be a positive integer
    RAISE EXCEPTION NEW zcx_kram_base_math( textid = VALUE #( msgid = zcl_kram_base_constants=>message_classes-base_math
                                                              msgno = '001'
                                                              attr1 = iv_starting_integer ) ).
  ENDIF.

  ro_instance = NEW #( iv_starting_integer ).

ENDMETHOD.


METHOD create_sequence.

  INSERT iv_starting_integer INTO TABLE mt_collatz_sequence.

  DATA(lv_current_integer) = iv_starting_integer.

  WHILE lv_current_integer <> 1.

    IF zcl_kram_base_math_service=>zif_kram_base_math_integer~is_even( lv_current_integer ) = zcl_kram_base_constants=>true.
      lv_current_integer = lv_current_integer / 2.
    ELSE. " is odd
      lv_current_integer = 3 * lv_current_integer + 1.
    ENDIF.

    INSERT lv_current_integer INTO TABLE mt_collatz_sequence.

  ENDWHILE.

ENDMETHOD.


METHOD get_sequence.

  rt_collatz_sequence = mt_collatz_sequence.

ENDMETHOD.


METHOD get_sequence_length.

  rv_sequence_length = lines( mt_collatz_sequence ).

ENDMETHOD.
ENDCLASS.
