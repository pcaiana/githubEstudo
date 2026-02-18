*&---------------------------------------------------------------------*
*& Report ZPR_LISTA_SFLIGHT_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpr_lista_sflight_alv.
*
DATA: it_sflight TYPE STANDARD TABLE OF sflight,
      st_sflight TYPE sflight.

DATA: cl_table    TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  PERFORM get_data.

  IF it_sflight[] IS NOT INITIAL.
    PERFORM display_alv.
  ENDIF.


FORM get_data.

  SELECT *
    INTO TABLE it_sflight
    FROM sflight.

ENDFORM.

FORM display_alv.

  CALL METHOD cl_salv_table=>factory
*    EXPORTING
*      list_display = abap_true
    IMPORTING
      r_salv_table = cl_table
    CHANGING
      t_table      = it_sflight.

  PERFORM feed_functions.

  CALL METHOD cl_table->display.

ENDFORM.

FORM feed_functions.

  DATA: cl_functions TYPE REF TO cl_salv_functions.

  cl_functions = cl_table->get_functions( ).
  cl_functions->set_all( abap_true ).

ENDFORM.
