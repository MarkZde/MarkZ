CLASS zcl_kram_base_constants DEFINITION
  PUBLIC
  ABSTRACT
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS true TYPE abap_bool VALUE abap_true ##NO_TEXT.
    CONSTANTS false TYPE abap_bool VALUE abap_false ##NO_TEXT.
    CONSTANTS:
      BEGIN OF message_classes,
        base     TYPE symsgid VALUE 'ZMCL_KRAM_BASE',
        base_gui TYPE symsgid VALUE 'ZMCL_KRAM_BASE_GUI',
      END OF message_classes.
protected section.
private section.
ENDCLASS.



CLASS ZCL_KRAM_BASE_CONSTANTS IMPLEMENTATION.
ENDCLASS.
