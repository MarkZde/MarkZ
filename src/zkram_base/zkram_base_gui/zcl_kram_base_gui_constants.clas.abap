CLASS zcl_kram_base_gui_constants DEFINITION
  PUBLIC
  ABSTRACT
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF batch_input_identifiers,
        ok_code TYPE string VALUE 'BDC_OKCODE',
        cursor  TYPE string VALUE 'BDC_CURSOR',
      END OF batch_input_identifiers.
protected section.
private section.
ENDCLASS.



CLASS ZCL_KRAM_BASE_GUI_CONSTANTS IMPLEMENTATION.
ENDCLASS.
