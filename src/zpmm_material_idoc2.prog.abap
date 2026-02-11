*&---------------------------------------------------------------------*
*& Report ZPMM_MATERIAL_IDOC2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPMM_MATERIAL_IDOC2.
*&---------------------------------------------------------------------*

DATA: wa_mara TYPE e1maram,
      wa_makt TYPE e1maktm,
      wa_marc TYPE e1marcm.

DATA: wa_idoc_data TYPE edidd,
      it_idoc_data TYPE edidd_tt.

wa_mara-matnr = '117'.
wa_mara-mtart = 'ERSA'.
wa_mara-meins = 'ST'.
wa_mara-ersda = sy-datum.
wa_mara-aenam = 'MVPCAIANA'.

wa_idoc_data-segnam = 'E1MARAM'.
wa_idoc_data-sdata  = wa_mara.
APPEND wa_idoc_data TO it_idoc_data.
CLEAR wa_idoc_data.

wa_makt-maktx = 'ACOMPLAMENTO ST PEÇ PEÇ'.
wa_makt-spras = 'P'.

wa_idoc_data-segnam = 'E1MAKTM'.
wa_idoc_data-sdata  = wa_makt.
APPEND wa_idoc_data TO it_idoc_data.
CLEAR wa_idoc_data.

wa_marc-werks = '1410'.

wa_idoc_data-segnam = 'E1MARCM'.
wa_idoc_data-sdata  = wa_marc.
APPEND wa_idoc_data TO it_idoc_data.
CLEAR wa_idoc_data.

DATA: master_idoc_control        TYPE edidc,
      communication_idoc_control TYPE STANDARD TABLE OF edidc.

master_idoc_control-mestyp = 'MATMAS'.
Master_idoc_control-doctyp = 'MATMAS05'.


CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
  EXPORTING
    master_idoc_control        = master_idoc_control
*   OBJ_TYPE                   = ''
*   CHNUM                      = ''
  TABLES
    communication_idoc_control = communication_idoc_control
    master_idoc_data           = it_idoc_data
* EXCEPTIONS
*   ERROR_IN_IDOC_CONTROL      = 1
*   ERROR_WRITING_IDOC_STATUS  = 2
*   ERROR_IN_IDOC_DATA         = 3
*   SENDING_LOGICAL_SYSTEM_UNKNOWN       = 4
*   OTHERS                     = 5
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
