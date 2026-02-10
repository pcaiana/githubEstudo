*&---------------------------------------------------------------------*
*& Report ZPR_NOVA_SINTAXE_ABAP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpr_nova_sintaxe_abap.

START-OF-SELECTION.
  BREAK-POINT.

*  PERFORM zf_criar_tipo_pelo_valor.
*  PERFORM zf_tabelas_internas.
*  PERFORM zf_leituras_de_tabelas.
*  PERFORM zf_conv.
*  PERFORM zf_switch.
*  PERFORM zf_string_template.
  PERFORM zf_reduce.

*&---------------------------------------------------------------------*
*& Form zf_criar_tipo_pelo_valor
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_criar_tipo_pelo_valor .

  DATA: text1 TYPE string.
  text1 = 'hello'.

  DATA(text2) = 'hello'.
  DATA(num1)  = 1.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_tabelas_internas
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_tabelas_internas .
  DATA: lt_sairport TYPE STANDARD TABLE OF sairport.
  DATA: ls_sairport1 TYPE sairport.

  FIELD-SYMBOLS: <ls_sairport> TYPE sairport.

  SELECT *
    INTO TABLE lt_sairport
    FROM sairport
    UP TO 2 ROWS.

** sintaxe nova

  SELECT *
    INTO TABLE @DATA(lt_sairport2)
    FROM sairport
    UP TO 2 ROWS.

  SELECT SINGLE *
    INTO @DATA(ls_sairport2)
    FROM sairport .

  LOOP AT lt_sairport INTO ls_sairport1.
  ENDLOOP.

  LOOP AT lt_sairport INTO DATA(ls_airport2).
  ENDLOOP.

  LOOP AT lt_sairport ASSIGNING <ls_sairport>.
  ENDLOOP.

  LOOP AT lt_sairport ASSIGNING FIELD-SYMBOL(<ls_sairport2>).
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_leituras_de_tabelas
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_leituras_de_tabelas .

  DATA: lt_sairport TYPE STANDARD TABLE OF sairport.
  DATA: ls_sairport1 TYPE sairport.

  FIELD-SYMBOLS: <ls_sairport> TYPE sairport.

  SELECT *
    INTO TABLE lt_sairport
    FROM sairport
    UP TO 2 ROWS.

  READ TABLE lt_sairport INTO ls_sairport1 INDEX 1.
  READ TABLE lt_sairport INTO DATA(ls_sairport2) INDEX 1.

  CLEAR ls_sairport1.

  READ TABLE lt_sairport ASSIGNING <ls_sairport> INDEX 1.
  READ TABLE lt_sairport ASSIGNING FIELD-SYMBOL(<ls_sairport2>) INDEX 1.

  CLEAR ls_sairport1.

  ls_sairport1 = lt_sairport[ 1 ].
  DATA(ls_sairport3) = lt_sairport[ id = 'ACA' ].

  IF line_exists( lt_sairport[ id = 'ACA' ] ).
    MESSAGE 'existe' TYPE 'S'.
  ELSE.
    MESSAGE 'não existe' TYPE 'S'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_conv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_conv .

  DATA: ld_num  TYPE int4,
        ld_num1 TYPE string,
        ld_num2 TYPE int4.

  DATA: ld_result TYPE int4.

  ld_num1 = '2'.
  ld_num2 = 3.
  ld_num = ld_num1.

  CALL FUNCTION 'ZF_SOMA'
    EXPORTING
      id_num1   = ld_num
      id_num2   = ld_num2
    IMPORTING
      ed_result = ld_result.

* forma nova

  CALL FUNCTION 'ZF_SOMA'
    EXPORTING
      id_num1   = CONV int4( ld_num1 )
      id_num2   = ld_num2
    IMPORTING
      ed_result = ld_result.

  DATA: ld_nome1(255) TYPE c.

  ld_nome1 = 'paulo cesar'.

  DATA(ld_nome2) = cl_abap_codepage=>convert_to(
      EXPORTING
        source = CONV #( ld_nome1 )
        ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_switch
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_switch .

  DATA: ld_moeda TYPE string,
        ld_texto TYPE string.

  ld_moeda = 'BRL'.

  CASE ld_moeda.
    WHEN 'BRL'.
      ld_texto = 'REAL'.
    WHEN 'EUR'.
      ld_texto = 'EURO'.
    WHEN 'USD'.
      ld_texto = 'DOLAR'.
  ENDCASE.

  CLEAR ld_texto.

  ld_texto = SWITCH string( ld_moeda
                 WHEN 'BRL' THEN 'REAL'
                 WHEN 'EUR' THEN 'EURO'
                 WHEN 'USD' THEN 'DOLAR'
                 ).

  CLEAR ld_texto.

  ld_texto =  SWITCH #( ld_moeda
               WHEN 'BRL' THEN 'REAL'
               WHEN 'EUR' THEN 'EURO'
               WHEN 'USD' THEN 'DOLAR'
               ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_string_template
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_string_template .

  DATA: ld_nome1 TYPE String,
        ld_nome2 TYPE string,
        ld_nome3 TYPE string.

  ld_nome1 = 'paulo'.
  ld_nome2 = 'caiana'.

  CONCATENATE ld_nome1 ld_nome2 INTO ld_nome3 SEPARATED BY space.

  CLEAR ld_nome3.

  ld_nome3 = |{ ld_nome2 }{ ld_nome1 }|.

  CLEAR ld_nome3.

  ld_nome3 = |{ ld_nome1 } - { ld_nome2 } |.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form zf_reduce
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM zf_reduce .

  DATA: lt_sairport TYPE STANDARD TABLE OF sairport,
        ls_sairport TYPE sairport,
        ld_count1   TYPE int4,
        ld_count2   TYPE int4.

  SELECT *
    INTO TABLE lt_sairport
    FROM sairport.

  CLEAR: ld_count1,
         ld_count2.

  LOOP AT lt_sairport INTO ls_sairport WHERE time_zone = 'UTC-5'.
    ld_count1 = ld_count1 + 1.
  ENDLOOP.

  ld_count2 = REDUCE i(
             INIT x = 0
             FOR ls IN lt_sairport
             WHERE ( time_zone = 'UTC-5' )
             NEXT x = x + 1
             ).


ENDFORM.
