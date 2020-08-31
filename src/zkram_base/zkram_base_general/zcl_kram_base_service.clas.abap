class ZCL_KRAM_BASE_SERVICE definition
  public
  final
  create public .

public section.

  interfaces ZIF_KRAM_BASE_STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_KRAM_BASE_SERVICE IMPLEMENTATION.


METHOD zif_kram_base_string~get_no_of_unique_characters.

  CHECK iv_string IS NOT INITIAL.

  DATA lt_characters TYPE zkram_tt_char1.

  DATA(lv_offset) = 0.
  WHILE lv_offset < strlen( iv_string ).
    INSERT CONV #( substring( val = iv_string
                              off = lv_offset
                              len = 1 ) )
           INTO TABLE lt_characters.
    lv_offset = lv_offset + 1.
  ENDWHILE.

  SORT lt_characters ASCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_characters.

  rv_result = lines( lt_characters ).

ENDMETHOD.
ENDCLASS.
