interface ZIF_KRAM_BASE_STRING
  public .


  class-methods GET_NO_OF_UNIQUE_CHARACTERS
    importing
      !IV_STRING type STRING
    returning
      value(RV_RESULT) type ZKRAM_INT4 .
endinterface.
