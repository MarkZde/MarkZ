interface ZIF_KRAM_BASE_MATH_INTEGERS
  public .


  class-methods IS_EVEN
    importing
      !IV_INTEGER type ZKRAM_INT8
    returning
      value(RV_RESULT_X) type ABAP_BOOL .
  class-methods IS_ODD
    importing
      !IV_INTEGER type ZKRAM_INT8
    returning
      value(RV_RESULT_X) type ABAP_BOOL .
endinterface.
