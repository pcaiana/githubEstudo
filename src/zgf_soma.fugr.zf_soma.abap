FUNCTION zf_soma.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(ID_NUM1) TYPE  INT4
*"     REFERENCE(ID_NUM2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(ED_RESULT) TYPE  INT4
*"----------------------------------------------------------------------


  ed_result = id_num1 + id_num2.


ENDFUNCTION.
