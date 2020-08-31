class ZCL_KRAM_BASE_MATH_SERVICE definition
  public
  final
  create private .

public section.

  interfaces ZIF_KRAM_BASE_MATH_INTEGER .
protected section.
private section.
ENDCLASS.



CLASS ZCL_KRAM_BASE_MATH_SERVICE IMPLEMENTATION.


METHOD zif_kram_base_math_integer~is_even.

  IF iv_integer MOD 2 = 0.
    rv_result_x = zcl_kram_base_constants=>true.
  ENDIF.

ENDMETHOD.


METHOD zif_kram_base_math_integer~is_odd.

  IF iv_integer MOD 2 <> 0.
    rv_result_x = zcl_kram_base_constants=>true.
  ENDIF.

ENDMETHOD.
ENDCLASS.
