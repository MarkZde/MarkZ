*&---------------------------------------------------------------------*
*& Report ZKRAM_DEMO_SALV_LINES_COUNT
*&---------------------------------------------------------------------*
REPORT zkram_demo_salv_lines_count.
**********************************************************************
* This report is for demonstration purposes, i.e. its content can simply be copied as is and the report should "just run".
* This means in particular that there are no outside dependencies that one needs to be aware of.
* Furthermore, for the sake of simplicity, certain "bad" programming habits are applied,
* e.g. the usage of global variables, not making use of code modularization techniques, etc.
**********************************************************************

INITIALIZATION.

  DATA go_salv_table TYPE REF TO cl_salv_table.

  DATA gt_spfli TYPE STANDARD TABLE OF spfli WITH EMPTY KEY.

  CONSTANTS lv_string_number_of_lines TYPE string VALUE 'Number of lines:' ##NO_TEXT.

CLASS lcl_event_handler DEFINITION FINAL.

  PUBLIC SECTION.

    METHODS on_filter_table FOR EVENT after_salv_function OF cl_salv_events_table IMPORTING e_salv_function.

ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.

  METHOD on_filter_table.

    DATA lv_lines_count TYPE i.

    TYPES: BEGIN OF lsty_salv_select_option,
             sign   TYPE salv_de_selopt_sign,
             option TYPE salv_de_selopt_option,
             low    TYPE salv_de_selopt_low,
             high   TYPE salv_de_selopt_high,
           END OF lsty_salv_select_option.

    DATA lt_salv_select_options TYPE STANDARD TABLE OF lsty_salv_select_option WITH EMPTY KEY.

    IF (     e_salv_function <> if_salv_c_slis_fcode=>filter
         AND e_salv_function <> if_salv_c_slis_fcode=>filter_delete ).
      RETURN.
    ENDIF.

    DATA(lt_column_filters) = go_salv_table->get_filters( )->get( ).
    IF lt_column_filters IS INITIAL. " no filters applied
      lv_lines_count = lines( gt_spfli ).
    ELSE.
      DATA(lt_spfli_filtered) = gt_spfli.
      LOOP AT lt_column_filters INTO DATA(ls_column_filter).
        lt_salv_select_options = VALUE #( FOR line IN ls_column_filter-r_filter->get( ) ( sign   = line->get_sign( )
                                                                                          option = line->get_option( )
                                                                                          low    = line->get_low( )
                                                                                          high   = line->get_high( ) ) ).
        LOOP AT gt_spfli INTO DATA(ls_spfli).
          ASSIGN COMPONENT ls_column_filter-columnname OF STRUCTURE ls_spfli TO FIELD-SYMBOL(<lv_cell_value>).
          IF <lv_cell_value> NOT IN lt_salv_select_options.
            DELETE lt_spfli_filtered WHERE table_line = ls_spfli.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
      lv_lines_count = lines( lt_spfli_filtered ).
    ENDIF.

    DATA(lo_grid_header) = NEW cl_salv_form_layout_grid( ).
    lo_grid_header->create_flow( EXPORTING row = 1 column = 1 )->create_text( text = lv_string_number_of_lines ).
    lo_grid_header->create_flow( EXPORTING row = 1 column = 2 )->create_text( text = lv_lines_count ).
    go_salv_table->set_top_of_list( lo_grid_header ).

    go_salv_table->refresh( ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  SELECT FROM spfli FIELDS * INTO TABLE @gt_spfli.

  cl_salv_table=>factory( IMPORTING r_salv_table = go_salv_table
                          CHANGING  t_table      = gt_spfli ).

  DATA(go_toolbar) = go_salv_table->get_functions( ).
  go_toolbar->set_all( if_salv_c_bool_sap=>true ). " display toolbar

  DATA(go_grid_header) = NEW cl_salv_form_layout_grid( ).
  go_grid_header->create_flow( EXPORTING row = 1 column = 1 )->create_text( text = lv_string_number_of_lines ).
  go_grid_header->create_flow( EXPORTING row = 1 column = 2 )->create_text( text = lines( gt_spfli ) ).
  go_salv_table->set_top_of_list( go_grid_header ).

  DATA(go_event_handler) = NEW lcl_event_handler( ).
  DATA(go_salv_events_table) = go_salv_table->get_event( ).
  SET HANDLER go_event_handler->on_filter_table FOR go_salv_events_table.

  go_salv_table->display( ).
