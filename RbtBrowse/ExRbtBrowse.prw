#include 'protheus.ch'



User Function ExRbtBrowse

Local aItens  := {}

Local aFields := {}

Static oDlg
Private oBrowse,oDlg,oPanel1,oPanelGrid,oBtn1,oBtn2

DEFINE MSDIALOG oDlg TITLE "Exemplo 1" FROM -004, 000  TO 500, 1000 COLORS 0, 16777215 PIXEL
 @ 171, 000 MSPANEL oPanel1 SIZE 250, 079 OF oDlg COLORS 0, 16777215 RAISED
 @ 059, 000 MSPANEL oPanelGrid SIZE 249, 019 OF oDlg COLORS 0, 16777215 RAISED

 @ 004, 453 BUTTON oBtn1 PROMPT "Total Linhas" SIZE 037, 012 OF oPanel1  PIXEL
 @ 004, 413 BUTTON oBtn2 PROMPT  "Total Soma" SIZE 037, 012 OF oPanel1  PIXEL


//ADICIONA COLUNAS
//PELO DICIONARIO
aAdd(aFields,{/*NOME*/"SELECOL",;
              /*TITULO*/"Sel",;
              /*TAMANHO*/1,;
              /*DECIMAIS*/0,;
              /*PICTURE*/"",;
              /*TIPO*/"L",;
              /*VISIVEL*/.F.}) //SE .F. CRIA SO NA TEMPTABLE

aAdd(aFields,{"B1_COD"})  
aAdd(aFields,{"B1_DESC"})

//CRIADA MANUALMENTE
aAdd(aFields,{/*NOME*/"DESCRICAO",;
              /*TITULO*/"Desc",;
              /*TAMANHO*/9,;
              /*DECIMAIS*/0,;
              /*PICTURE*/"@!",;
              /*TIPO*/"C",;
              /*VISIVEL*/.T.}) //SE .F. CRIA SO NA TEMPTABLE

aAdd(aFields,{/*NOME*/"VALOR",;
              /*TITULO*/"Valor",;
              /*TAMANHO*/12,;
              /*DECIMAIS*/2,;
              /*PICTURE*/"",;
              /*TIPO*/"N",;
              /*VISIVEL*/.T.}) //SE .F. CRIA SO NA TEMPTABLE

//ADICIONA ITENS POR ARRAY
aAdd(aItens,{.T.,"CODIGO001","DESC COD 01","POR ITEM",15.20,.F.})
aAdd(aItens,{.T.,"CODIGO002","DESC COD 02","POR ITEM2",10.50,.F.})

oBrowse := RbtBrowse():New()
oBrowse:UseTempTable     := .T.
oBrowse:CreateIndices    := .T.
oBrowse:MarkColumn       := "SELECOL"
oBrowse:FieldsGrid       := aFields
oBrowse:Itens            := aItens

//ADICIONA ITENS POR QUERY
oBrowse:Query            := "SELECT TOP 100 'F' AS SELECOL,B1_COD,B1_DESC,'EXEMPLO' AS DESCRICAO, 0.00 AS VALOR "+;
                                " FROM "+RETSQLNAME("SB1")+" WHERE D_E_L_E_T_<>'*'"
oBrowse:Titulo           := "Titulo Browse"

oBrowse:Create(oPanelGrid)
    

oPanel1:Align 	      := CONTROL_ALIGN_BOTTOM
oPanelGrid:Align 	  := CONTROL_ALIGN_ALLCLIENT


//CONTA TOTAL DE LINHA
oBtn1:bAction := {|| MsgAlert(cValToChar(oBrowse:GetRowsCount()),"Linhas!") } 

//SOMA TOTAL DE UMA COLUNA
oBtn2:bAction := {|| MsgAlert(cValToChar(oBrowse:GetColumnTotal("VALOR")),"Total")} 


oBrowse:Activate()

ACTIVATE MSDIALOG oDlg CENTERED


  
Return


