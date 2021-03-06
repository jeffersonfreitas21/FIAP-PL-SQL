-- PROCEDURE QUE INSERE UM VE�CULO NA TABELA LOC_VEICULO
CREATE OR REPLACE PROCEDURE prc_insere_veiculo(
  P_NR_PALCA IN LOC_VEICULO.NR_PLACA%TYPE,
  P_CD_PROPRIETARIO IN LOC_VEICULO.CD_PROPRIETARIO%TYPE,
  P_NR_CHASSIS IN LOC_VEICULO.NR_CHASSIS%TYPE,
  P_STATUS IN LOC_VEICULO.STATUS%TYPE,
  P_TIPO_AUTOMOVEL IN LOC_VEICULO.TIPO_AUTOMOVEL%TYPE,
  P_KM_ATUAL IN LOC_VEICULO.KM_ATUAL%TYPE,
  P_COMBUSTIVEL IN LOC_VEICULO.COMBUSTIVEL%TYPE,
  P_MODELO IN LOC_VEICULO.MODELO%TYPE,
  P_COR IN LOC_VEICULO.COR%TYPE,
  P_CD_GRUPO IN LOC_VEICULO.CD_GRUPO%TYPE,
  P_MENSAGEM OUT VARCHAR
)IS
V_CD_GRUPO_EXCEPTION EXCEPTION;
V_CD_PROPRIETARIO_EXCEPTION EXCEPTION;
BEGIN
  IF(P_CD_GRUPO IS NULL)THEN
    RAISE V_CD_GRUPO_EXCEPTION;
  ELSIF( P_CD_PROPRIETARIO IS NULL) THEN
    RAISE V_CD_PROPRIETARIO_EXCEPTION;
  ELSE
    INSERT INTO LOC_VEICULO (NR_PLACA, CD_PROPRIETARIO, NR_CHASSIS, STATUS, 
    TIPO_AUTOMOVEL, KM_ATUAL, COMBUSTIVEL, MODELO, COR, CD_GRUPO) 
    VALUES(P_NR_PALCA, P_CD_PROPRIETARIO, P_NR_CHASSIS, P_STATUS, 
    P_TIPO_AUTOMOVEL,P_KM_ATUAL, P_COMBUSTIVEL, P_MODELO, P_COR, P_CD_GRUPO);
    P_MENSAGEM := 'VE�CULO CADASTRADO COM SUCESSO!';
    COMMIT;
  END IF;
EXCEPTION
  WHEN V_CD_PROPRIETARIO_EXCEPTION then
    P_MENSAGEM := 'Ocorreu um erro. O c�digo do propriet�rio n�o pode ser 0';
    raise_application_error(-20001,'O c�digo do propriet�rio n�o pode ser 0');
  WHEN V_CD_GRUPO_EXCEPTION then
    P_MENSAGEM := 'Ocorreu um erro. O c�digo do grupo n�o pode ser 0';
    raise_application_error(-20001,'O c�digo do grupo n�o pode ser 0');
  when others then
    raise_application_error(-20002,'Erro gen�rico ' || sqlerrm);
END;


DECLARE
v_mensagem varchar(60);
BEGIN
  PRC_INSERE_VEICULO('IOS2014', 8, '5CND2', 'A', 'CAR', 5000, 'ALCOOL', 'CAMARO', 'AMARELO',1, v_mensagem);
  SYS.DBMS_OUTPUT.PUT_LINE(v_mensagem);
END;