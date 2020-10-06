#include 'protheus.ch'
#DEFINE  ENTER CHR(13)+CHR(10) 

/*/{Protheus.doc} RbtBrowse
Class to create "FwTemporaryTable/FwBrowse" from FwBrowse with many features.
@type	class
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@param AdjustedColumns,logical, Property to indicate if array FieldsGrid are in determinated order.!false
@param AliasX3, caracter,Set an x3 alias to open.</br>Get TableObj:FwTemporaryTable:GetAlias() or x3 Seted</br>Example: <code>RbtBrowse:AliasX3 := "SB1"</code>,!false 
@param Columns, array,Array of Columns with processed FieldsGrid after AdjustAFields().!false
@param CreateIndexs, logical,Logical to get OR set to create or get index status.!false
@param FieldsGrid,array,Array of col definition or x3 field name</br>Exemplo:<br><code>Especified:<br>aAdd(FieldsGrid,{SELECOL',; // Name of col markup.<br>              "Sel",; //Title<br>              1,;//Size<br>              0,;//Decimal<br>              "",;//Picture<br>              "L",;//Type<br>			 .F.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br>			 	//			  then dont diplay in FwBrowse)<br><br>//Add Col from SX3<br>aAdd(FieldsGrid,{"B1_COD"})  <br></code>!true
@param Indexs,array,Array of string with single col to be index </br>Exemplo:<br><code>aAdd(aIndex,"B1_COD") </code>
@param Items, array, Array of array  with vlues in col sequence </br>Exemplo:<br><code>aAdd(aIndex,{.F.,"00001","DESC 01 ",0.50,.F.)</code>!true
@param MarkColumn, caracter, Name of col to be a markup col</br>Exemplo:<br><code> cMark := "SEL_COL"</code>!false
@param Query,caractere, An sql query  with values in col sequence</br>Exemplo:<br><code>oBrowse:Query            := "SELECT TOP 100 'F' AS SELECOL,B1_COD,B1_DESC,'EXEMPLO' AS DESCRICAO, 0.00 AS VALOR "+;<br>                                 " FROM "+RETSQLNAME("SB1")+" WHERE D_E_L_E_T_<>'*'"</code>!false
@param TableObj,object, get de FwTemporaryTable Object!false
@param Title, caracter,Title of FwBrowse!false 
@param UseTempTable,logical,Indicate to use temp table or just array!false
@example <code> Local aItems  := {} <br> Local aFields := {}<br>// Add a column especified<br>aAdd(aFields,{SELECOL',; // Name of col markup.<br>              "Sel",; //Title<br>              1,;//Size<br>              0,;//Decimal<br>              "",;//Picture<br>              "L",;//Type<br>			 .F.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br>			 	//			  then dont diplay in FwBrowse)<br><br>//Add Col from SX3<br>aAdd(aFields,{"B1_COD"})  <br>aAdd(aFields,{"B1_DESC"})<br><br><br>//Add a column  especified Desc<br>aAdd(aFields,{'DESCRICAO',; // Name of col markup.<br>            "Desc",; //Title<br>               9,;//Size<br>               0,;//Decimal<br>               "@!",;//Picture<br>               "C",;//Type<br>			   .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br>			//  				 // then dont diplay in FwBrowse)<br><br>//Add a column  especified VaLOR<br>// aAdd(aFields,{VALOR',; // Name of col vlor.<br>              "Valor",; //Title<br>               12,;//Size<br>               2,;//Decimal<br>               "@!",;//Picture<br>               "N",;//Type<br> 			  .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br>// 			 				 // then dont diplay in FwBrowse)<br><br>//Add items from array at finish, in order of columns and add a logical in finish (Deleted)<br> aAdd(aItems,{.T.,"CODIGO001","DESC COD 01","POR ITEM",15.20,.F.})<br> aAdd(aItems,{.T.,"CODIGO002","DESC COD 02","POR ITEM2",10.50,.F.})<br><br> oBrowse := RbtBrowse():New()<br> oBrowse:UseTempTable     := .T.<br> oBrowse:CreateIndexs    := .T.<br> oBrowse:MarkColumn       := "SELECOL"<br> oBrowse:FieldsGrid       := aFields<br> oBrowse:Items            := aItems<br><br>// //Add items from query dont need deleted default .F.<br> oBrowse:Query            := "SELECT TOP 100 'F' AS SELECOL,B1_COD,B1_DESC,'EXEMPLO' AS DESCRICAO, 0.00 AS VALOR "+;<br>                                 " FROM "+RETSQLNAME("SB1")+" WHERE D_E_L_E_T_<>'*'"<br> oBrowse:Title           := "Titulo Browse"<br> oBrowse:Create(oDlg)<br>// //Num  rows<br>oBtn1:bAction := {|| MsgAlert(cValToChar(oBrowse:GetRowsCount()),"Linhas!") } <br> //Sum of col<br>oBtn2:bAction := {|| MsgAlert(cValToChar(oBrowse:GetColumnTotal("VALOR")),"Total")} <br> oBrowse:Activate()<br> ACTIVATE MSDIALOG oDlg CENTERED<br> Return<br></code>
@see https://github.com/Rbt-Sistemas/Advpl
@link https://www.rbtsistemas.com.br/images/browsesample1.png
/*/	
class RbtBrowse FROM FWBrowse

	Data AdjustedColumns
	Data AliasX3 
	Data Columns        
	Data CreateIndexs
	Data FieldsGrid   
	Data Indexs    
	Data Items         
	Data MarkColumn    
	Data Query     
	Data TableObj      
	Data Title        
	Data UseTempTable  

	method New() constructor 
	method Create(oParent)
	method CreateBrw()
	method CreateTemp()
	method AdjustAFields()
	method Destroy()
	method GetColumnTotal(cColumn)
	method CreateMark()
	method GetRowsCount()
	method SetFreeze(nFreeze)
	method ClearRows()
	method AddArRows(aItems)

endclass


/*/{Protheus.doc} New constructor
Constructor of RbtBrowse
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@return object,RbtBrowse
/*/	
method New() class RbtBrowse
		_Super:New()
		AdjustedColumns  := .F.
		::Columns := {}
		::CreateIndexs := .T.
return

/*/{Protheus.doc} SetFreeze
Index of col to freeze, just 1 by limitation of framework
@param nCol,numeric, Col Index to be freeze
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
/*/	
method SetFreeze(nCol) class RbtBrowse

::oBrowse:nFreeze := nCol
::SetLineHeight(::nRowHeight)
::Refresh(.t.)

return


/*/{Protheus.doc} CreateTemp
Create a FwTemporaryTable by FieldsGrid property
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@obs  Need FieldsGrid property previous setted
/*/	
method  CreateTemp() class RbtBrowse
	Local cQuery := ""
    Local _nI,i,_nY
	::TableObj := FWTemporaryTable():New()
    
    IF !::AdjustedColumns 
    	::AdjustAFields()
    ENDIF
        
    aFields := {}

    FOR _nI := 1 TO Len(::FieldsGrid)
    	 aAdd(aFields, {::FieldsGrid[_nI][1],;
    	  			    ::FieldsGrid[_nI][6],;
    	  			    ::FieldsGrid[_nI][3],;
    	  			    ::FieldsGrid[_nI][4]})
    	  			   
    	 
    Next _nI

    ::TableObj:SetFields(aFields)
    
    IF ::CreateIndexs 
    
        IF ::Indexs <> NIL
            FOR _nI := 1 TO Len(::Indexs)
                
                            
                ::TableObj:AddIndex(StrZero(_nI,2), {::Indexs[_nI]} )
            Next _nI
        ELSE

            FOR _nI := 1 TO Len(::FieldsGrid)
                
                            
                ::TableObj:AddIndex(StrZero(_nI,2), {::FieldsGrid[_nI][1]} )
            Next _nI
            
        ENDIF
    ELSE
    
    ENDIF
   
   
    ::TableObj:Create()
    ::AliasX3 := ::TableObj:GetAlias()


    IF ::Query <> nil
    	
    	 cTableName := ::TableObj:GetRealName()
    	  
    	  if TCIsConnected()
    	  	nConnect := TCGetConn()
    	  	lCloseConnect := .F.
    	  else
    	  	nConnect := TCLink()
    	  	lCloseConnect := .T.
    	  endif
    	 
    	 cFieldsSql := "("
    	 For i := 1 to Len(aFields)
    	 		cFieldsSql += aFields[i][1]
    	 		if i < Len(aFields)
    	 			cFieldsSql += ","
    	 		endif
    	 Next i
    	 cFieldsSql += ")"
    	 cQuery :=   "INSERT INTO " + cTableName +  " " + cFieldsSql +ENTER+"	"+ ::Query 
    	 CONOUT(cQuery)
    	 MemoWrite( "\RbtBrwQuery.TXT", cQuery )
    	 if TCSqlExec(cQuery) < 0
    	 	ConOut("ErroSql:", TCSqlError())
    	 endif
    	 
    ENDIF
    
    IF ::Items <> NIL

	    For _nI := 1 To Len(::Items)
	    	RecLock((::AliasX3),.T.)
	    		For _nY := 1 To Len(::FieldsGrid)
	    			cFlName := ::FieldsGrid[_nY][1]
	    			cValA	:= ::Items[_nI][_nY]
                    cTpField := ::FieldsGrid[_nY][6]
                    IF cTpField == "D"
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  stod(cValA) ")
                    ELSE
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  cValA ")
                    ENDIF
				   
			    Next _nY
			 MsUnlock()
	    Next _nI
	ENDIF   
	
	
	
	
	    
Return


/*/{Protheus.doc} AddArRows
Add an array of items to temp table
@param aItems,array, Itens to add.
@type method
@author    Roberto Alves
@since     13/09/2020
@version   1.3.0
/*/	
method AddArRows(aItems) Class RbtBrowse

 IF aItems <> NIL

	    For _nI := 1 To Len(aItems)
	    	RecLock((::AliasX3),.T.)
	    		For _nY := 1 To Len(::FieldsGrid)
	    			cFlName := ::FieldsGrid[_nY][1]
	    			cValA	:= aItems[_nI][_nY]
                    cTpField := ::FieldsGrid[_nY][6]
                    IF cTpField == "D"
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  stod(cValA) ")
                    ELSE
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  cValA ")
                    ENDIF
				   
			    Next _nY
			 MsUnlock()
	    Next _nI
	ENDIF   

return


/*/{Protheus.doc} ClearRows
Truncate temp table.
@type method
@author    Roberto Alves
@since     13/09/2020
@version   1.3.0
/*/	
Method ClearRows() Class RbtBrowse

Local  cQuery :=   "TRUNCATE TABLE " + ::AliasX3 +  "

CONOUT(cQuery)
MemoWrite( "\RbtBrwQuery.TXT", cQuery )
if TCSqlExec(cQuery) < 0
ConOut("ErroSql:", TCSqlError())
endif


return


/*/{Protheus.doc} CreateMarkColumn
Create a mark column of MarkColumn property
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
/*/	
Method CreateMark() Class RbtBrowse

	IF ::MarkColumn <> NIL
		
        ::AddMarkColumns({||IIf(&(""+(::AliasX3)+"->"+(::MarkColumn)+""),'LBOK','LBNO')},;
            {|| IIF(&(""+(::AliasX3)+"->"+(::MarkColumn)+""),&(""+(::AliasX3)+"->"+(::MarkColumn)+" := .F. "),;
            &(""+(::AliasX3)+"->"+(::MarkColumn)+" := .T. ") ) },;
            {|| &("DBEVAL({|| IIF("+::AliasX3+"->"+::MarkColumn+","+;
            " "+::AliasX3+"->"+::MarkColumn+" := .F., "+::AliasX3+"->"+::MarkColumn+" := .T.)})"),::GoTop()})
    
	ENDIF

Return




/*/{Protheus.doc} GetColumnTotal
Get sum of especified column
@type method
@param cColumn,caractere,Name of col to sum.!true
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@return numeric,Sum of cColumn
/*/
METHOD GetColumnTotal(cColumn)  Class RbtBrowse

	Local aAreaB := (::AliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::AliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += "+::AliasX3+"->"+cColumn+" })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot



/*/{Protheus.doc} GetRowsCount
Get number of rows
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@return numeric,NumRows
/*/
METHOD GetRowsCount()  Class RbtBrowse

	Local aAreaB := (::AliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::AliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += 1 })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot


/*/{Protheus.doc} AdjustAFields
Adjust Columns property from FieldsGried
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
/*/
method AdjustAFields() Class RbtBrowse

Local _nI

IF ::FieldsGrid == NIL 
	::FieldsGrid := {}
ENDIF

IF LEN(::FieldsGrid) == 0
	IF ::AliasX3 == NIL
		Alert("Campos ou Alias não preenchido!")
		RETURN
	ELSE
		aFieldSx3 := FWSX3Util():GetAllFields(::AliasX3, .F. )
		FOR _nI  := 1 TO Len(aFieldSx3)
			aAdd(::FieldsGrid,{aFieldSx3[_nI],;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TITULO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TAMANHO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_DECIMAL"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_PICTURE"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TIPO");				                
				                })
		Next _nI
	ENDIF
	
ELSE
	
    For _nI := 1 To Len(::FieldsGrid)
		IF LEN(::FieldsGrid[_nI]) == 1
			::FieldsGrid[_nI] := {::FieldsGrid[_nI][1],;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TITULO"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TAMANHO"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_DECIMAL"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_PICTURE"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TIPO");	
			 					   }
		ENDIF

	
	
	Next _nI
ENDIF

::AdjustedColumns := .T.

return	


/*/{Protheus.doc} CreateBrw
Create a RbtBrowse pre configured
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
/*/
method  CreateBrw() class RbtBrowse

Local nI := 1

IF !::AdjustedColumns 
    	::AdjustAFields()
ENDIF

IF ::UseTempTable

	::CreateTemp()

ENDIF
nCol := 1
For nI := 1 To Len(::FieldsGrid)
	lAddCol := .T.
	
	IF VALTYPE(::FieldsGrid[nI][LEN(::FieldsGrid[nI])]) == "L"
		IF ::FieldsGrid[nI][LEN(::FieldsGrid[nI])]
			lAddCol := .T.
		ELSE
			lAddCol := .F.
		ENDIF
	ELSE	
		lAddCol := .T.
	
	ENDIF
	IF lAddCol
		aAdd(::Columns,FWBrwColumn():New())
		::Columns[nCol]:SetData(&("{||"+::AliasX3+"->"+::FieldsGrid[nI][1]+"}"))
		::Columns[nCol]:SetTitle(::FieldsGrid[nI][2])
		::Columns[nCol]:SetSize(::FieldsGrid[nI][3])
		::Columns[nCol]:SetDecimal(::FieldsGrid[nI][4])
		::Columns[nCol]:SetPicture(::FieldsGrid[nI][5])
        nCol++
	ENDIF
Next nI

return


/*/{Protheus.doc} Create
Create browse before activate
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
@param oParent,object,Parent containner
/*/
method Create(oParent) class RbtBrowse
    
    ::CreateBrw()
    ::setDescription(::Title)
    ::setDataQuery(.F.)
    ::CreateMark()
    ::setColumns(::Columns)
    ::setDataTable(.T.)
    ::setAlias(::AliasX3)
    ::setUseFilter()
    ::setOwner(oParent)    
 
Return


/*/{Protheus.doc} Destroy
@type method
@author    Roberto Alves
@since     13/03/2020
@version   1.3.0
/*/
Method Destroy() class RbtBrowse
	IF ::UseTempTable
		::TableObj:Delete()
	ENDIF
Return



